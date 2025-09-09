Return-Path: <linux-kselftest+bounces-41017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D0CB4A1D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23093BAF4C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826212550CA;
	Tue,  9 Sep 2025 06:15:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379CA315D36;
	Tue,  9 Sep 2025 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398553; cv=none; b=qjzaFCrb2bmktXCx57Rn1TKzC7OP3fYTrWh0Ua2yIowB3eDvpJLd10ENQdN/ai3i61BDt/jjkEQv1b/h1295vcPr+Sbhnn8zyMrjD7rj/fzeabDNHr4zMjj5yfk+qfnW9o6W+pzXlzlAO5YZs9vlxmNWl7mh96jjywYJd+PABmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398553; c=relaxed/simple;
	bh=tedYefJS40zmTkKGAil9JPYxwfMwuyXXhCM4eVzhIUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=APl5v5XAv87qcgA1N8P6i4RZYRpHA5adULj03oBTH83iR1+0xPGtAi/h4xhyMCZhss29SyeXrSnS4CJivE+jKLCRFnRjlEIYdHG9DbCYTp4hRbtGzdcWTWhSr3tUxtJrlPxrTPx5AhLWvzK9qvYMV8q/brIGp9n8qJk16C2oLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2590B15A1;
	Mon,  8 Sep 2025 23:15:42 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52E1C3F66E;
	Mon,  8 Sep 2025 23:15:46 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 0/2] selftests/mm: uffd-stress fixes
Date: Tue,  9 Sep 2025 11:45:28 +0530
Message-Id: <20250909061531.57272-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset ensures that the number of hugepages is correctly set in the
system so that the uffd-stress test does not fail due to the racy nature of
the test. Patch 1 changes the hugepage constraint in the run_vmtests.sh
script, whereas patch 2 changes the constraint in the test itself.

---
Based on 6.17-rc5.

Dev Jain (2):
  selftests/mm/uffd-stress: make test operate on less hugetlb memory
  selftests/mm/uffd-stress: stricten constraint on free hugepages needed
    before the test

 tools/testing/selftests/mm/run_vmtests.sh | 10 +++++++---
 tools/testing/selftests/mm/uffd-stress.c  | 17 +++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.30.2


