Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1531770C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 09:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCCIHX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 03:07:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727594AbgCCIHX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 03:07:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 50C3727143BE5F251882;
        Tue,  3 Mar 2020 16:07:19 +0800 (CST)
Received: from localhost (10.173.228.206) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 16:07:13 +0800
From:   Jay Zhou <jianjay.zhou@huawei.com>
To:     <kvm@vger.kernel.org>
CC:     <pbonzini@redhat.com>, <peterx@redhat.com>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxinxin.wang@huawei.com>, <weidong.huang@huawei.com>,
        <liu.jinsong@huawei.com>, <jianjay.zhou@huawei.com>
Subject: [PATCH] kvm: selftests: Support dirty log initial-all-set test
Date:   Tue, 3 Mar 2020 16:07:10 +0800
Message-ID: <20200303080710.1672-1-jianjay.zhou@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.228.206]
X-CFilter-Loop: Reflected
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since the new capability KVM_DIRTY_LOG_INITIALLY_SET of
KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 has been introduced, tweak the
clear_dirty_log_test to test it.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 tools/testing/selftests/kvm/clear_dirty_log_test.c |  4 ++++
 tools/testing/selftests/kvm/dirty_log_test.c       | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/clear_dirty_log_test.c b/tools/testing/selftests/kvm/clear_dirty_log_test.c
index 7493369..11672ec 100644
--- a/tools/testing/selftests/kvm/clear_dirty_log_test.c
+++ b/tools/testing/selftests/kvm/clear_dirty_log_test.c
@@ -1,2 +1,6 @@
 #define USE_CLEAR_DIRTY_LOG
+#define KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE (1 << 0)
+#define KVM_DIRTY_LOG_INITIALLY_SET         (1 << 1)
+#define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
+		KVM_DIRTY_LOG_INITIALLY_SET)
 #include "dirty_log_test.c"
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 5614222..7e21addc4 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -264,6 +264,10 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
 #define DIRTY_MEM_BITS 30 /* 1G */
 #define PAGE_SHIFT_4K  12
 
+#ifdef USE_CLEAR_DIRTY_LOG
+static u64 dirty_log_manual_caps;
+#endif
+
 static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 		     unsigned long interval, uint64_t phys_offset)
 {
@@ -320,7 +324,7 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
 	struct kvm_enable_cap cap = {};
 
 	cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
-	cap.args[0] = 1;
+	cap.args[0] = dirty_log_manual_caps;
 	vm_enable_cap(vm, &cap);
 #endif
 
@@ -438,8 +442,18 @@ int main(int argc, char *argv[])
 #endif
 
 #ifdef USE_CLEAR_DIRTY_LOG
-	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2)) {
-		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping tests\n");
+	dirty_log_manual_caps =
+		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
+	if (!dirty_log_manual_caps) {
+		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, "
+				"skipping tests\n");
+		exit(KSFT_SKIP);
+	}
+	if (dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_CAPS &&
+		dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE) {
+		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not valid caps "
+				"%"PRIu64", skipping tests\n",
+				dirty_log_manual_caps);
 		exit(KSFT_SKIP);
 	}
 #endif
-- 
1.8.3.1


