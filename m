Return-Path: <linux-kselftest+bounces-15063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838E994CEAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F848282E68
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9A0190490;
	Fri,  9 Aug 2024 10:32:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8646176237;
	Fri,  9 Aug 2024 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199520; cv=none; b=Uom10n41gfuvf85TVXsQJUyonyQLblK6GX2uJ3VOEaDDW300EKpSORdRpbyci4uaXfiPNvD3B6oJvWYrfLqfr14YmHLbK1hYKQzJrdZ4hqstWui0wKrPSiNxypfugKlVZTXuidPoJkzCF4efdnZcOvmHiWOGWijMsGEXrXoBF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199520; c=relaxed/simple;
	bh=FCbXMjwRhSxGWG+KGEb6VZ0zlgypTmf8rZa+aiS38L0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=je0rEBD1kIQ5XrN53aAlE4lNRT/kWVE1Q++/Q3pk9/iIdhCOe9BpeLG+HE1h0ohptcTiSAxjIhJE6/LY/cXWg9f82EXlTskswGTPLwX0anAbegm+I8FV6HpFe3d9LiRLVzEsg1hDwbt/bDiog1o/ER2CSfNVGLlA92e9TO2sNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0DD913D5;
	Fri,  9 Aug 2024 03:32:23 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 157CC3F766;
	Fri,  9 Aug 2024 03:31:42 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org,
	david@redhat.com,
	willy@infradead.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	osalvador@suse.de,
	baolin.wang@linux.alibaba.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	ioworker0@gmail.com,
	gshan@redhat.com,
	mark.rutland@arm.com,
	kirill.shutemov@linux.intel.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	broonie@kernel.org,
	mgorman@techsingularity.net,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 0/2] Improve migration by backing off earlier
Date: Fri,  9 Aug 2024 16:01:27 +0530
Message-Id: <20240809103129.365029-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was recently observed at [1] that during the folio unmapping stage
of migration, when the PTEs are cleared, a racing thread faulting on that
folio may increase the refcount of the folio, sleep on the folio lock
(the migration path has the lock), and migration ultimately fails
when asserting the actual refcount against the expected.

Migration is a best effort service; the unmapping and the moving phase
are wrapped around loops for retrying. The refcount of the folio is
currently being asserted during the move stage; if it fails, we retry.
But, if a racing thread changes the refcount, and ends up sleeping on the
folio lock (which is mostly the case), there is no way the refcount would
be decremented; as a result, this renders the retrying useless. In the
first patch, we make the refcount check also during the unmap stage; if
it fails, we restore the original state of the PTE, drop the folio lock,
let the system make progress, and retry unmapping again. This improves the
probability of migration winning the race.

Given that migration is a best-effort service, it is wrong to fail the
test for just a single failure; hence, fail the test after 100 consecutive
failures (where 100 is still a subjective choice).

[1] https://lore.kernel.org/all/20240801081657.1386743-1-dev.jain@arm.com/

Dev Jain (2):
  mm: Retry migration earlier upon refcount mismatch
  selftests/mm: Do not fail test for a single migration failure

 mm/migrate.c                           |  9 +++++++++
 tools/testing/selftests/mm/migration.c | 17 +++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.30.2


