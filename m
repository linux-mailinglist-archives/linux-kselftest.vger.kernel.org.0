Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86EA363FE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Apr 2021 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhDSKub (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Apr 2021 06:50:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17359 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhDSKua (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Apr 2021 06:50:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FP3Rs3wJ0zBrRp;
        Mon, 19 Apr 2021 18:47:37 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 19 Apr 2021 18:49:50 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        <yuzenghui@huawei.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH] KVM: selftests: Tweak time measurement flag in kvm_page_table_test
Date:   Mon, 19 Apr 2021 18:49:47 +0800
Message-ID: <20210419104947.38544-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Also use CLOCK_MONOTONIC flag to get time in kvm_page_table_test.c,
since that's what all the kvm/selftests do currently. And this will
be consistent with function timespec_elapsed() in test_util.c.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 tools/testing/selftests/kvm/kvm_page_table_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index 1c4753fff19e..d7847fba47a8 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -212,7 +212,7 @@ static void *vcpu_worker(void *data)
 		if (READ_ONCE(host_quit))
 			return NULL;
 
-		clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+		clock_gettime(CLOCK_MONOTONIC, &start);
 		ret = _vcpu_run(vm, vcpu_id);
 		ts_diff = timespec_elapsed(start);
 
@@ -390,7 +390,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	/* Test the stage of KVM creating mappings */
 	*current_stage = KVM_CREATE_MAPPINGS;
 
-	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	vcpus_complete_new_stage(*current_stage);
 	ts_diff = timespec_elapsed(start);
 
@@ -403,7 +403,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	*current_stage = KVM_UPDATE_MAPPINGS;
 
-	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	vcpus_complete_new_stage(*current_stage);
 	ts_diff = timespec_elapsed(start);
 
@@ -415,7 +415,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	*current_stage = KVM_ADJUST_MAPPINGS;
 
-	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	vcpus_complete_new_stage(*current_stage);
 	ts_diff = timespec_elapsed(start);
 
-- 
2.23.0

