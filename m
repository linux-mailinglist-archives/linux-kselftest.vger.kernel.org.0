Return-Path: <linux-kselftest+bounces-29377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353E2A67B3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 18:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2D23AACD7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F2E211711;
	Tue, 18 Mar 2025 17:43:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659882116F4
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319839; cv=none; b=pv3D1IS3GXcOFHfPZOlRSynQcN/51pyBqBs35XfCvXCLjJ7BvQRCTo1lJaya8Bi8Xk4rotNAWy9IRbYwFT/XsU8nvUG+fHmOd7vFIFXD9qMGkyY2UhsA6afPvp+HXANNUSnDXqcoJxAsyR6tVof1kgdQCajpY8OFw1XuVTcKQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319839; c=relaxed/simple;
	bh=hI7eBDsFPsXfkNGQTfloPMrld/cFCnV5RLewB6g3Jnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DF7Z6+IiB82apnEZOareWoz/bm8r4DaKZ3QNzRJVFqGvLOOTKGOovBcapXKNmxwct5x6XUNVISNorP+nnJ3FHzx4AgvKGhewgXFl8lJHhrA4JOaG73shDqSPFK88B+FOc/qJw0gfUX8u/ZU+Xdx39WZZhh0Jx+ImOzXpr6mPdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 234C413D5;
	Tue, 18 Mar 2025 10:44:04 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC4053F673;
	Tue, 18 Mar 2025 10:43:54 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v1 1/3] selftests/mm: Fix half_ufd_size_MB calculation
Date: Tue, 18 Mar 2025 17:43:39 +0000
Message-ID: <20250318174343.243631-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

$half_ufd_size_MB is supposed to be half of the available hugetlb memory
expressed in MB. But previously it was calculated in pages since
$freepgs is the number of free pages.

When huge pages are 2M it doesn't make a whole lot of difference; the
number of pages that get used is just halved. But on arm64 with 16K or
64K base pages, the PMD size (and default hugetlb size) is 32M and 512M
respectively. So in this case we end up passing a number of MB that is
smaller than a single hugetlb page and the test raises an error.

Fixes: 2e47a445d7b3 ("selftests/mm: run_vmtests.sh: fix hugetlb mem size calculation")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index da7e26668103..14fa9d40d574 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -304,7 +304,7 @@ uffd_stress_bin=./uffd-stress
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
 # Hugetlb tests require source and destination huge pages. Pass in half
 # the size of the free pages we have, which is used for *each*.
-half_ufd_size_MB=$((freepgs / 2))
+half_ufd_size_MB=$(((freepgs * hpgsize_KB / 2) / 1024))
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
--
2.43.0


