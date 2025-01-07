Return-Path: <linux-kselftest+bounces-23991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8044FA04313
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199A41881822
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60AB1E9B06;
	Tue,  7 Jan 2025 14:48:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF854433AD;
	Tue,  7 Jan 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261292; cv=none; b=ZYp6YM8ZQoVbpTCTEGIViS2saWu7eDdE7VDBi6MVps4QH22NyBZqMDJOWtBGI49EVXehBCxlFp8wFUHfgBC3jUAPNckmPzSBwvKOYA333zpCWlKEykFIhjJyfk4yDC8clsjO7plhIXBcxHnhr2gY5cb3yH+LllY9OBjyVJlaNYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261292; c=relaxed/simple;
	bh=xSOx6i53FWdlp27JIwKc3r3t3SNpSzR+p180bKvX7SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J1XIjmTSfytMHJ/xqkBG38Nx6OZxBsA/gtHQoDkW0rlK5O+MUhNKfwl1O5DJPJCEjnrXCjaSfY3zJ+yOdiUyTjssSpjFF0JnkRSb5j5xkJ+IVw0AWdBXoSG/iDFxxfNEsggpql8bp7tKXYf8VkmO0KSTBAy8YUvNKhzH/IRzwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBC301424;
	Tue,  7 Jan 2025 06:48:35 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20D563F59E;
	Tue,  7 Jan 2025 06:48:04 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	=?UTF-8?q?Miko=C5=82aj=20Lenczewski?= <miko.lenczewski@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 0/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Date: Tue,  7 Jan 2025 14:47:51 +0000
Message-ID: <20250107144755.1871363-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This series contains a fix for a warning emitted when a uffd-registered region,
which doesn't have UFFD_FEATURE_EVENT_REMAP, is mremap()ed. patch 1 describes
the problem and fixes it, and patch 2 adds a selftest to verify the fix.

Thanks to Mikołaj Lenczewski who originally created the patch, which I have
subsequently extended.

Applies on top of mm-unstable (f349e79bfbf3)

Thanks,
Ryan

Ryan Roberts (2):
  mm: Clear uffd-wp PTE/PMD state on mremap()
  selftests/mm: Introduce uffd-wp-mremap regression test

 include/linux/userfaultfd_k.h               |  12 +
 mm/huge_memory.c                            |  12 +
 mm/hugetlb.c                                |  14 +-
 mm/mremap.c                                 |  32 +-
 tools/testing/selftests/mm/.gitignore       |   1 +
 tools/testing/selftests/mm/Makefile         |   2 +
 tools/testing/selftests/mm/run_vmtests.sh   |   1 +
 tools/testing/selftests/mm/uffd-wp-mremap.c | 380 ++++++++++++++++++++
 8 files changed, 452 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/mm/uffd-wp-mremap.c

--
2.43.0


