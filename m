Return-Path: <linux-kselftest+bounces-41176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F7B51D69
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 18:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EF7581215
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029003375D3;
	Wed, 10 Sep 2025 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Mf9Ji+uK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C626B771;
	Wed, 10 Sep 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521028; cv=none; b=kbDGYlVFpQO6P8WfUFqpJutjOl0yeRq83Ppee0qiD9sr87pgxo/sm6vdG7qnm/NAQxC2zkqMP/ToxpZJQze1SOls1BCW9PW/hz+l4AL6V2Ua/Cb1yqSZiBnxydyBToRon/nw2kjOPXOt5H+yDEdJ31Yfk6L9DII1R6Wcg/WW1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521028; c=relaxed/simple;
	bh=uma7q0oq5MZZRgT0Fs/7mPla/kfmdZF3hVfzxFPSH9I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b5fJiqxoTRtM3sC9zAW1o8/H8VDZOKFu5qomTgY17NMMmv0fntg+wkrmaIKv9+WQUQUU7bsRN48XmuAwlCW7GwPZADK7a2VUAXjHxe2B3p+2M3Zg9yTyL4HJTPU28BqSMLRYt4rt0VHnBavwnxmoE3mxy4ZdZFp+2ZctnoyIjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Mf9Ji+uK; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AD2wWH032060;
	Wed, 10 Sep 2025 16:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pps0720; bh=deRTkyES2dLsCA1RpfhzllRYA0poesvFhy/5lcXgJUI=; b=Mf9J
	i+uKOdk2RrkZoW1x9ziX2I13/gxX+blB0dPG2G8/morCpl+JIfBv8j8rOloT+a9K
	22roZheiEUDbrYuxbpuLIiuZ/Spvpse2K7Qo5w2/ikDyljLpE7iEsnj4lC142sUY
	2sWVKI+t/qX/XnTFmG7vQK9PdwW+c7I+/VdY9kZK4wvqfoa6J5Yg5DgAJ1ygLvn+
	rnftoZwvsObzVjdnJSd5tkwHWvV02K8bj5E60xHqjLUurryf0HMxS5ETBOWJ0kzJ
	L5bFCvkYw5ZtxUs7bBAUzkagCJ3aGrUcMPLFWQvJNX6JxlIQdELReT8RB+qjjPIg
	fxd4Lpc3A1EVcDP7CQ==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4939d1hygn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 16:16:01 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 0557D130DC;
	Wed, 10 Sep 2025 16:15:58 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 5B49580CCD6;
	Wed, 10 Sep 2025 16:15:56 +0000 (UTC)
Date: Wed, 10 Sep 2025 11:15:54 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        linmiaohe@huawei.com, shuah@kernel.org, tony.luck@intel.com
Cc: Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz,
        jane.chu@oracle.com, jiaqiyan@google.com, joel.granados@kernel.org,
        kyle.meyer@hpe.com, laoar.shao@gmail.com, lorenzo.stoakes@oracle.com,
        mclapinski@google.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        osalvador@suse.de, rafael.j.wysocki@intel.com, rppt@kernel.org,
        russ.anderson@hpe.com, shawn.fan@intel.com, surenb@google.com,
        vbabka@suse.cz, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/memory-failure: Disable soft offline for HugeTLB pages by
 default
Message-ID: <aMGkAI3zKlVsO0S2@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: kqIpDWE2DAQUz9T13ajLU0ZtpoqC-0MS
X-Authority-Analysis: v=2.4 cv=BYfY0qt2 c=1 sm=1 tr=0 ts=68c1a441 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=MvuuwTCpAAAA:8 a=2-6KEjCLdOzKJHZFeg0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDExNSBTYWx0ZWRfXyMed/oh4zI0A
 zRZHpa9vgSdSo26PmP7rwF3/kqBMgtDUfgdff2eIvZ4fP2AKZKQcKu0IyMMzHN6I1K/8rPc+7sF
 KGFRvGgBFkWUQmuioxZhsVH6NYnzeTnb1d7pUtwLXtEDJ32Xr+puBkrL1DdGLMrlgCVOIrZwa0I
 Uo9zzUKhsBJD6/cuVlJMLaME0TWtRvHlwN6G3G16EB9xfMwf8GpfDDn3UammV7d8qMc5VkdVcb7
 G7GWYw9ulMrJf1FfFQJHQDGBFIMPy25n7RhR9keciIKhmASdzlf/FW+WFHse44tyM4AWtBIeN9l
 IUYILDNnt2CaAokpMCa3dV6zIk9ncF0Ijc/1u/I7SBf7WfnV98tEPmzY+ntov9FLtR/kX7mQd4X
 4jksBjJ0
X-Proofpoint-ORIG-GUID: kqIpDWE2DAQUz9T13ajLU0ZtpoqC-0MS
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1011 phishscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509100115

Soft offlining a HugeTLB page reduces the available HugeTLB page pool.
Since HugeTLB pages are preallocated, reducing the available HugeTLB
page pool can cause allocation failures.

/proc/sys/vm/enable_soft_offline provides a sysctl interface to
disable/enable soft offline:

0 - Soft offline is disabled.
1 - Soft offline is enabled.

The current sysctl interface does not distinguish between HugeTLB pages
and other page types.

Disable soft offline for HugeTLB pages by default (1) and extend the
sysctl interface to preserve existing behavior (2):

0 - Soft offline is disabled.
1 - Soft offline is enabled (excluding HugeTLB pages).
2 - Soft offline is enabled (including HugeTLB pages).

Update documentation for the sysctl interface, reference the sysctl
interface in the sysfs ABI documentation, and update HugeTLB soft
offline selftests.

Reported-by: Shawn Fan <shawn.fan@intel.com>
Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---

Tony's original patch disabled soft offline for HugeTLB pages when
a correctable memory error reported via GHES (with "error threshold
exceeded" set) happened to be on a HugeTLB page:

https://lore.kernel.org/all/20250904155720.22149-1-tony.luck@intel.com

This patch disables soft offline for HugeTLB pages by default
(not just from GHES).

---
 .../ABI/testing/sysfs-memory-page-offline     |  6 ++++
 Documentation/admin-guide/sysctl/vm.rst       | 18 ++++++++---
 mm/memory-failure.c                           | 21 ++++++++++--
 .../selftests/mm/hugetlb-soft-offline.c       | 32 +++++++++++++------
 4 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-memory-page-offline b/Documentation/ABI/testing/sysfs-memory-page-offline
index 00f4e35f916f..befb89ae39ec 100644
--- a/Documentation/ABI/testing/sysfs-memory-page-offline
+++ b/Documentation/ABI/testing/sysfs-memory-page-offline
@@ -20,6 +20,12 @@ Description:
 		number, or a error when the offlining failed.  Reading
 		the file is not allowed.
 
+		Soft-offline can be disabled/enabled via sysctl:
+		/proc/sys/vm/enable_soft_offline
+
+		For details, see:
+		Documentation/admin-guide/sysctl/vm.rst
+
 What:		/sys/devices/system/memory/hard_offline_page
 Date:		Sep 2009
 KernelVersion:	2.6.33
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 4d71211fdad8..ae56372bd604 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -309,19 +309,29 @@ physical memory) vs performance / capacity implications in transparent and
 HugeTLB cases.
 
 For all architectures, enable_soft_offline controls whether to soft offline
-memory pages.  When set to 1, kernel attempts to soft offline the pages
-whenever it thinks needed.  When set to 0, kernel returns EOPNOTSUPP to
-the request to soft offline the pages.  Its default value is 1.
+memory pages:
+
+- 0: Soft offline is disabled.
+- 1: Soft offline is enabled (excluding HugeTLB pages).
+- 2: Soft offline is enabled (including HugeTLB pages).
+
+The default is 1.
+
+If soft offline is disabled for the requested page type, EOPNOTSUPP is returned.
 
 It is worth mentioning that after setting enable_soft_offline to 0, the
 following requests to soft offline pages will not be performed:
 
+- Request to soft offline from sysfs (soft_offline_page).
+
 - Request to soft offline pages from RAS Correctable Errors Collector.
 
-- On ARM, the request to soft offline pages from GHES driver.
+- On ARM and X86, the request to soft offline pages from GHES driver.
 
 - On PARISC, the request to soft offline pages from Page Deallocation Table.
 
+Note: Soft offlining a HugeTLB page reduces the HugeTLB page pool.
+
 extfrag_threshold
 =================
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc30ca4804bf..cb59a99b48c5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -64,11 +64,18 @@
 #include "internal.h"
 #include "ras/ras_event.h"
 
+enum soft_offline {
+	SOFT_OFFLINE_DISABLED = 0,
+	SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
+	SOFT_OFFLINE_ENABLED
+};
+
 static int sysctl_memory_failure_early_kill __read_mostly;
 
 static int sysctl_memory_failure_recovery __read_mostly = 1;
 
-static int sysctl_enable_soft_offline __read_mostly = 1;
+static int sysctl_enable_soft_offline __read_mostly =
+	SOFT_OFFLINE_ENABLED_SKIP_HUGETLB;
 
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
@@ -150,7 +157,7 @@ static const struct ctl_table memory_failure_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= SYSCTL_TWO,
 	}
 };
 
@@ -2799,12 +2806,20 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -EIO;
 	}
 
-	if (!sysctl_enable_soft_offline) {
+	if (sysctl_enable_soft_offline == SOFT_OFFLINE_DISABLED) {
 		pr_info_once("disabled by /proc/sys/vm/enable_soft_offline\n");
 		put_ref_page(pfn, flags);
 		return -EOPNOTSUPP;
 	}
 
+	if (sysctl_enable_soft_offline == SOFT_OFFLINE_ENABLED_SKIP_HUGETLB) {
+		if (folio_test_hugetlb(pfn_folio(pfn))) {
+			pr_info_once("disabled for HugeTLB pages by /proc/sys/vm/enable_soft_offline\n");
+			put_ref_page(pfn, flags);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	mutex_lock(&mf_mutex);
 
 	if (PageHWPoison(page)) {
diff --git a/tools/testing/selftests/mm/hugetlb-soft-offline.c b/tools/testing/selftests/mm/hugetlb-soft-offline.c
index f086f0e04756..7e2873cd0a6d 100644
--- a/tools/testing/selftests/mm/hugetlb-soft-offline.c
+++ b/tools/testing/selftests/mm/hugetlb-soft-offline.c
@@ -1,10 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Test soft offline behavior for HugeTLB pages:
- * - if enable_soft_offline = 0, hugepages should stay intact and soft
- *   offlining failed with EOPNOTSUPP.
- * - if enable_soft_offline = 1, a hugepage should be dissolved and
- *   nr_hugepages/free_hugepages should be reduced by 1.
+ *
+ * - if enable_soft_offline = 0 (SOFT_OFFLINE_DISABLED), HugeTLB pages
+ *   should stay intact and soft offlining failed with EOPNOTSUPP.
+ *
+ * - if enable_soft_offline = 1 (SOFT_OFFLINE_ENABLED_SKIP_HUGETLB), HugeTLB pages
+ *   should stay intact and soft offlining failed with EOPNOTSUPP.
+ *
+ * - if enable_soft_offline = 2 (SOFT_OFFLINE_ENABLED), a HugeTLB page should be
+ *   dissolved and nr_hugepages/free_hugepages should be reduced by 1.
  *
  * Before running, make sure more than 2 hugepages of default_hugepagesz
  * are allocated. For example, if /proc/meminfo/Hugepagesize is 2048kB:
@@ -32,6 +37,12 @@
 
 #define EPREFIX " !!! "
 
+enum soft_offline {
+	SOFT_OFFLINE_DISABLED = 0,
+	SOFT_OFFLINE_ENABLED_SKIP_HUGETLB,
+	SOFT_OFFLINE_ENABLED
+};
+
 static int do_soft_offline(int fd, size_t len, int expect_errno)
 {
 	char *filemap = NULL;
@@ -83,7 +94,7 @@ static int set_enable_soft_offline(int value)
 	char cmd[256] = {0};
 	FILE *cmdfile = NULL;
 
-	if (value != 0 && value != 1)
+	if (value < SOFT_OFFLINE_DISABLED || value > SOFT_OFFLINE_ENABLED)
 		return -EINVAL;
 
 	sprintf(cmd, "echo %d > /proc/sys/vm/enable_soft_offline", value);
@@ -155,7 +166,7 @@ static int create_hugetlbfs_file(struct statfs *file_stat)
 static void test_soft_offline_common(int enable_soft_offline)
 {
 	int fd;
-	int expect_errno = enable_soft_offline ? 0 : EOPNOTSUPP;
+	int expect_errno = (enable_soft_offline == SOFT_OFFLINE_ENABLED) ? 0 : EOPNOTSUPP;
 	struct statfs file_stat;
 	unsigned long hugepagesize_kb = 0;
 	unsigned long nr_hugepages_before = 0;
@@ -198,7 +209,7 @@ static void test_soft_offline_common(int enable_soft_offline)
 	// No need for the hugetlbfs file from now on.
 	close(fd);
 
-	if (enable_soft_offline) {
+	if (enable_soft_offline == SOFT_OFFLINE_ENABLED) {
 		if (nr_hugepages_before != nr_hugepages_after + 1) {
 			ksft_test_result_fail("MADV_SOFT_OFFLINE should reduced 1 hugepage\n");
 			return;
@@ -219,10 +230,11 @@ static void test_soft_offline_common(int enable_soft_offline)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(2);
+	ksft_set_plan(3);
 
-	test_soft_offline_common(1);
-	test_soft_offline_common(0);
+	test_soft_offline_common(SOFT_OFFLINE_ENABLED);
+	test_soft_offline_common(SOFT_OFFLINE_ENABLED_SKIP_HUGETLB);
+	test_soft_offline_common(SOFT_OFFLINE_DISABLED);
 
 	ksft_finished();
 }
-- 
2.51.0


