Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E847D3A277A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 10:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFJI42 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 04:56:28 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5321 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJI42 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 04:56:28 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0yMj0Mnnz1BJgm;
        Thu, 10 Jun 2021 16:49:37 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 16:54:21 +0800
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 16:54:20 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ben Gardon <bgardon@google.com>,
        Andrew Jones <drjones@redhat.com>
CC:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yuzenghui@huawei.com>,
        <wanghaibin.wang@huawei.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH] KVM: selftests: Fix compiling errors when initializing the static structure
Date:   Thu, 10 Jun 2021 16:54:18 +0800
Message-ID: <20210610085418.35544-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Errors like below were produced from test_util.c when compiling the KVM
selftests on my local platform.

lib/test_util.c: In function 'vm_mem_backing_src_alias':
lib/test_util.c:177:12: error: initializer element is not constant
    .flag = anon_flags,
            ^~~~~~~~~~
lib/test_util.c:177:12: note: (near initialization for 'aliases[0].flag')

The reason is that we are using non-const expressions to initialize the
static structure, which will probably trigger a compiling error/warning
on stricter GCC versions. Fix it by converting the two const variables
"anon_flags" and "anon_huge_flags" into more stable macros.

Fixes: b3784bc28ccc0 ("KVM: selftests: refactor vm_mem_backing_src_type flags")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 tools/testing/selftests/kvm/lib/test_util.c | 38 ++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 6ad6c8276b2e..af1031fed97f 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -166,75 +166,75 @@ size_t get_def_hugetlb_pagesz(void)
 	return 0;
 }
 
+#define ANON_FLAGS	(MAP_PRIVATE | MAP_ANONYMOUS)
+#define ANON_HUGE_FLAGS	(ANON_FLAGS | MAP_HUGETLB)
+
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 {
-	static const int anon_flags = MAP_PRIVATE | MAP_ANONYMOUS;
-	static const int anon_huge_flags = anon_flags | MAP_HUGETLB;
-
 	static const struct vm_mem_backing_src_alias aliases[] = {
 		[VM_MEM_SRC_ANONYMOUS] = {
 			.name = "anonymous",
-			.flag = anon_flags,
+			.flag = ANON_FLAGS,
 		},
 		[VM_MEM_SRC_ANONYMOUS_THP] = {
 			.name = "anonymous_thp",
-			.flag = anon_flags,
+			.flag = ANON_FLAGS,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB] = {
 			.name = "anonymous_hugetlb",
-			.flag = anon_huge_flags,
+			.flag = ANON_HUGE_FLAGS,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB] = {
 			.name = "anonymous_hugetlb_16kb",
-			.flag = anon_huge_flags | MAP_HUGE_16KB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_16KB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB] = {
 			.name = "anonymous_hugetlb_64kb",
-			.flag = anon_huge_flags | MAP_HUGE_64KB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_64KB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB] = {
 			.name = "anonymous_hugetlb_512kb",
-			.flag = anon_huge_flags | MAP_HUGE_512KB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_512KB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB] = {
 			.name = "anonymous_hugetlb_1mb",
-			.flag = anon_huge_flags | MAP_HUGE_1MB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_1MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB] = {
 			.name = "anonymous_hugetlb_2mb",
-			.flag = anon_huge_flags | MAP_HUGE_2MB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_2MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB] = {
 			.name = "anonymous_hugetlb_8mb",
-			.flag = anon_huge_flags | MAP_HUGE_8MB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_8MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB] = {
 			.name = "anonymous_hugetlb_16mb",
-			.flag = anon_huge_flags | MAP_HUGE_16MB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_16MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB] = {
 			.name = "anonymous_hugetlb_32mb",
-			.flag = anon_huge_flags | MAP_HUGE_32MB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_32MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB] = {
 			.name = "anonymous_hugetlb_256mb",
-			.flag = anon_huge_flags | MAP_HUGE_256MB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_256MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB] = {
 			.name = "anonymous_hugetlb_512mb",
-			.flag = anon_huge_flags | MAP_HUGE_512MB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_512MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB] = {
 			.name = "anonymous_hugetlb_1gb",
-			.flag = anon_huge_flags | MAP_HUGE_1GB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_1GB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB] = {
 			.name = "anonymous_hugetlb_2gb",
-			.flag = anon_huge_flags | MAP_HUGE_2GB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_2GB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB] = {
 			.name = "anonymous_hugetlb_16gb",
-			.flag = anon_huge_flags | MAP_HUGE_16GB,
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_16GB,
 		},
 		[VM_MEM_SRC_SHMEM] = {
 			.name = "shmem",
-- 
2.23.0

