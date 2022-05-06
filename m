Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4268F51D624
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 May 2022 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391139AbiEFLFz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 May 2022 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391133AbiEFLFx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 May 2022 07:05:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74440674D2;
        Fri,  6 May 2022 04:02:10 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxMNorAHViuhoMAA--.48869S4;
        Fri, 06 May 2022 19:02:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] MIPS: Use NOKPROBE_SYMBOL() instead of __kprobes annotation
Date:   Fri,  6 May 2022 19:02:03 +0800
Message-Id: <1651834923-31573-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1651834923-31573-1-git-send-email-yangtiezhu@loongson.cn>
References: <1651834923-31573-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9BxMNorAHViuhoMAA--.48869S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1DXFWfZw4fuFyxXFyrWFg_yoWxuF1rpF
        98Aw1rKr4rXa4kWF97AwsYvr1Syr4rZ3y7CrW7G34Fqa45tr15tF1IgrWjyFy5GrZYv3W3
        AF4YyryUZFWxA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4kMxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRy89JUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If define CONFIG_KPROBES, __kprobes annotation forces the whole function
into the ".kprobes.text" section, NOKPROBE_SYMBOL() only stores the given
function address in the "_kprobe_blacklist" section which is introduced
to maintain kprobes blacklist.

Modify the related code to use NOKPROBE_SYMBOL() to protect functions from
kprobes instead of __kprobes annotation under arch/mips.

No obvious functional change in this patch, some more work needs to be done
to fix the kernel panic when execute the following testcase on mips:

  # cd tools/testing/selftests/ftrace
  # ./ftracetest test.d/kprobe/multiple_kprobes.tc

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/kernel/kprobes.c | 36 ++++++++++++++++++++++++------------
 arch/mips/mm/fault.c       |  6 ++++--
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 6c7f3b1..316b27d 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -44,10 +44,11 @@ static const union mips_instruction breakpoint2_insn = {
 DEFINE_PER_CPU(struct kprobe *, current_kprobe);
 DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
-static int __kprobes insn_has_delayslot(union mips_instruction insn)
+static int insn_has_delayslot(union mips_instruction insn)
 {
 	return __insn_has_delay_slot(insn);
 }
+NOKPROBE_SYMBOL(insn_has_delayslot);
 
 /*
  * insn_has_ll_or_sc function checks whether instruction is ll or sc
@@ -56,7 +57,7 @@ static int __kprobes insn_has_delayslot(union mips_instruction insn)
  * instructions; cannot do much about breakpoint in the middle of
  * ll/sc pair; it is upto user to avoid those places
  */
-static int __kprobes insn_has_ll_or_sc(union mips_instruction insn)
+static int insn_has_ll_or_sc(union mips_instruction insn)
 {
 	int ret = 0;
 
@@ -72,8 +73,9 @@ static int __kprobes insn_has_ll_or_sc(union mips_instruction insn)
 	}
 	return ret;
 }
+NOKPROBE_SYMBOL(insn_has_ll_or_sc);
 
-int __kprobes arch_prepare_kprobe(struct kprobe *p)
+int arch_prepare_kprobe(struct kprobe *p)
 {
 	union mips_instruction insn;
 	union mips_instruction prev_insn;
@@ -132,26 +134,30 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 out:
 	return ret;
 }
+NOKPROBE_SYMBOL(arch_prepare_kprobe);
 
-void __kprobes arch_arm_kprobe(struct kprobe *p)
+void arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = breakpoint_insn;
 	flush_insn_slot(p);
 }
+NOKPROBE_SYMBOL(arch_arm_kprobe);
 
-void __kprobes arch_disarm_kprobe(struct kprobe *p)
+void arch_disarm_kprobe(struct kprobe *p)
 {
 	*p->addr = p->opcode;
 	flush_insn_slot(p);
 }
+NOKPROBE_SYMBOL(arch_disarm_kprobe);
 
-void __kprobes arch_remove_kprobe(struct kprobe *p)
+void arch_remove_kprobe(struct kprobe *p)
 {
 	if (p->ainsn.insn) {
 		free_insn_slot(p->ainsn.insn, 0);
 		p->ainsn.insn = NULL;
 	}
 }
+NOKPROBE_SYMBOL(arch_remove_kprobe);
 
 static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
@@ -257,7 +263,7 @@ static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs,
  * breakpoint trap. In case of branch instructions, the target
  * epc to be restored.
  */
-static void __kprobes resume_execution(struct kprobe *p,
+static void resume_execution(struct kprobe *p,
 				       struct pt_regs *regs,
 				       struct kprobe_ctlblk *kcb)
 {
@@ -268,8 +274,9 @@ static void __kprobes resume_execution(struct kprobe *p,
 		regs->cp0_epc = orig_epc + 4;
 	}
 }
+NOKPROBE_SYMBOL(resume_execution);
 
-static int __kprobes kprobe_handler(struct pt_regs *regs)
+static int kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
 	int ret = 0;
@@ -367,6 +374,7 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 	return ret;
 
 }
+NOKPROBE_SYMBOL(kprobe_handler);
 
 static inline int post_kprobe_handler(struct pt_regs *regs)
 {
@@ -415,7 +423,7 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 /*
  * Wrapper routine for handling exceptions.
  */
-int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
+int kprobe_exceptions_notify(struct notifier_block *self,
 				       unsigned long val, void *data)
 {
 
@@ -446,6 +454,7 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 	}
 	return ret;
 }
+NOKPROBE_SYMBOL(kprobe_exceptions_notify);
 
 /*
  * Function return probe trampoline:
@@ -469,7 +478,7 @@ static void __used kretprobe_trampoline_holder(void)
 
 void __kretprobe_trampoline(void);
 
-void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
+void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				      struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *) regs->regs[31];
@@ -478,11 +487,12 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 	/* Replace the return addr with trampoline addr */
 	regs->regs[31] = (unsigned long)__kretprobe_trampoline;
 }
+NOKPROBE_SYMBOL(arch_prepare_kretprobe);
 
 /*
  * Called when the probe at kretprobe trampoline is hit
  */
-static int __kprobes trampoline_probe_handler(struct kprobe *p,
+static int trampoline_probe_handler(struct kprobe *p,
 						struct pt_regs *regs)
 {
 	instruction_pointer(regs) = __kretprobe_trampoline_handler(regs, NULL);
@@ -493,14 +503,16 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
 	 */
 	return 1;
 }
+NOKPROBE_SYMBOL(trampoline_probe_handler);
 
-int __kprobes arch_trampoline_kprobe(struct kprobe *p)
+int arch_trampoline_kprobe(struct kprobe *p)
 {
 	if (p->addr == (kprobe_opcode_t *)__kretprobe_trampoline)
 		return 1;
 
 	return 0;
 }
+NOKPROBE_SYMBOL(arch_trampoline_kprobe);
 
 static struct kprobe trampoline_p = {
 	.addr = (kprobe_opcode_t *)__kretprobe_trampoline,
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 44f9810..b08bc55 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -35,7 +35,7 @@ int show_unhandled_signals = 1;
  * and the problem, and then passes it off to one of the appropriate
  * routines.
  */
-static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
+static void __do_page_fault(struct pt_regs *regs, unsigned long write,
 	unsigned long address)
 {
 	struct vm_area_struct * vma = NULL;
@@ -322,8 +322,9 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	}
 #endif
 }
+NOKPROBE_SYMBOL(__do_page_fault);
 
-asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
+asmlinkage void do_page_fault(struct pt_regs *regs,
 	unsigned long write, unsigned long address)
 {
 	enum ctx_state prev_state;
@@ -332,3 +333,4 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	__do_page_fault(regs, write, address);
 	exception_exit(prev_state);
 }
+NOKPROBE_SYMBOL(do_page_fault);
-- 
2.1.0

