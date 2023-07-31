Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116877689F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 04:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGaCYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 22:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGaCYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 22:24:09 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62676E4E;
        Sun, 30 Jul 2023 19:24:06 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8BxXetFG8dk0+EMAA--.25521S3;
        Mon, 31 Jul 2023 10:24:05 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c5FG8dkiKtBAA--.41295S2;
        Mon, 31 Jul 2023 10:24:05 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: use unified time type for comparison
Date:   Mon, 31 Jul 2023 10:24:05 +0800
Message-Id: <20230731022405.854884-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx_c5FG8dkiKtBAA--.41295S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww4kXr4rZFyDGFykuw15trc_yoW8uFW5pr
        Z7A3s0kr4rtr93tr1xJr1q9FyrKws8GrW8GF1kGr40yr45JFs3tFs7GFy7Xr4rurWfX39I
        vay0kr4UCa10yacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With test case kvm_page_table_test, start time is acquired with
time type CLOCK_MONOTONIC_RAW, however end time in function timespec_elapsed
is acquired with time type CLOCK_MONOTONIC. This will cause
inaccurate elapsed time calculation on some platform such as LoongArch.

This patch modified test case kvm_page_table_test, and uses unified
time type CLOCK_MONOTONIC for start time.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tools/testing/selftests/kvm/kvm_page_table_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
index b3b00be1ef82..69f26d80c821 100644
--- a/tools/testing/selftests/kvm/kvm_page_table_test.c
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -200,7 +200,7 @@ static void *vcpu_worker(void *data)
 		if (READ_ONCE(host_quit))
 			return NULL;
 
-		clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+		clock_gettime(CLOCK_MONOTONIC, &start);
 		ret = _vcpu_run(vcpu);
 		ts_diff = timespec_elapsed(start);
 
@@ -367,7 +367,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	/* Test the stage of KVM creating mappings */
 	*current_stage = KVM_CREATE_MAPPINGS;
 
-	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	vcpus_complete_new_stage(*current_stage);
 	ts_diff = timespec_elapsed(start);
 
@@ -380,7 +380,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	*current_stage = KVM_UPDATE_MAPPINGS;
 
-	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	vcpus_complete_new_stage(*current_stage);
 	ts_diff = timespec_elapsed(start);
 
@@ -392,7 +392,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	*current_stage = KVM_ADJUST_MAPPINGS;
 
-	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+	clock_gettime(CLOCK_MONOTONIC, &start);
 	vcpus_complete_new_stage(*current_stage);
 	ts_diff = timespec_elapsed(start);
 
-- 
2.27.0

