Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC53C1F6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhGIGlt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jul 2021 02:41:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:14050 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhGIGls (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jul 2021 02:41:48 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GLk1y1pWyzbbh4;
        Fri,  9 Jul 2021 14:35:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 14:39:01 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 9 Jul 2021
 14:39:01 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <pbonzini@redhat.com>, <shuah@kernel.org>, <bgardon@google.com>,
        <wangyanan55@huawei.com>, <axelrasmussen@google.com>,
        <drjones@redhat.com>, <chenlifu@huawei.com>, <seanjc@google.com>,
        <vkuznets@redhat.com>, <dwmw@amazon.co.uk>,
        <joao.m.martins@oracle.com>, <yangyingliang@huawei.com>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 2/2] selftests: Fix fscanf warning
Date:   Fri, 9 Jul 2021 14:37:41 +0800
Message-ID: <20210709063741.355325-2-chenlifu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210709063741.355325-1-chenlifu@huawei.com>
References: <20210709063741.355325-1-chenlifu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Compile selftests occurs the following warnings:
make -C tools/testing/selftests
...

lib/test_util.c: In function ‘get_trans_hugepagesz’:
lib/test_util.c:138:2: warning: ignoring return value of ‘fscanf’, declared with attribute warn_unused_result [-Wunused-result]
  138 |  fscanf(f, "%ld", &size);
      |  ^~~~~~~~~~~~~~~~~~~~~~~
x86_64/mmio_warning_test.c: In function ‘get_warnings_count’:
x86_64/mmio_warning_test.c:85:2: warning: ignoring return value of ‘fscanf’, declared with attribute warn_unused_result [-Wunused-result]
   85 |  fscanf(f, "%d", &warnings);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
x86_64/xen_shinfo_test.c: In function ‘get_run_delay’:
x86_64/xen_shinfo_test.c:109:9: warning: ignoring return value of ‘fscanf’, declared with attribute warn_unused_result [-Wunused-result]
  109 |         fscanf(fp, "%ld %ld ", &val[0], &val[1]);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
steal_time.c: In function ‘get_run_delay’:
steal_time.c:228:2: warning: ignoring return value of ‘fscanf’, declared with attribute warn_unused_result [-Wunused-result]
  228 |  fscanf(fp, "%ld %ld ", &val[0], &val[1]);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Check the return value of ‘fscanf’ to fix it.

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 tools/testing/selftests/kvm/lib/test_util.c            | 3 ++-
 tools/testing/selftests/kvm/steal_time.c               | 3 ++-
 tools/testing/selftests/kvm/x86_64/mmio_warning_test.c | 3 ++-
 tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c   | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index af1031fed97f..02ed0d5c3aa5 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -135,7 +135,8 @@ size_t get_trans_hugepagesz(void)
 	f = fopen("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size", "r");
 	TEST_ASSERT(f != NULL, "Error in opening transparent_hugepage/hpage_pmd_size");
 
-	fscanf(f, "%ld", &size);
+	if (fscanf(f, "%ld", &size) != 1)
+		size = 0;
 	fclose(f);
 
 	return size;
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index b0031f2d38fd..18f231c45a12 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -225,7 +225,8 @@ static long get_run_delay(void)
 
 	sprintf(path, "/proc/%ld/schedstat", syscall(SYS_gettid));
 	fp = fopen(path, "r");
-	fscanf(fp, "%ld %ld ", &val[0], &val[1]);
+	if (fscanf(fp, "%ld %ld ", &val[0], &val[1]) != 2)
+		val[1] = 0;
 	fclose(fp);
 
 	return val[1];
diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index e6480fd5c4bd..e770037e5cc9 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -82,7 +82,8 @@ int get_warnings_count(void)
 	FILE *f;
 
 	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
-	fscanf(f, "%d", &warnings);
+	if (fscanf(f, "%d", &warnings) != 1)
+		warnings = 0;
 	fclose(f);
 
 	return warnings;
diff --git a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
index 117bf49a3d79..6efda86083f1 100644
--- a/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xen_shinfo_test.c
@@ -106,7 +106,8 @@ static long get_run_delay(void)
 
         sprintf(path, "/proc/%ld/schedstat", syscall(SYS_gettid));
         fp = fopen(path, "r");
-        fscanf(fp, "%ld %ld ", &val[0], &val[1]);
+	if (fscanf(fp, "%ld %ld ", &val[0], &val[1]) != 2)
+		val[1] = 0;
         fclose(fp);
 
         return val[1];
-- 
2.32.0

