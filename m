Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5AF51E3DD
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 May 2022 05:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376470AbiEGDu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 May 2022 23:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiEGDu6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 May 2022 23:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D53E6A033;
        Fri,  6 May 2022 20:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 803B761705;
        Sat,  7 May 2022 03:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3861EC385A6;
        Sat,  7 May 2022 03:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651895231;
        bh=7ZSIHr1r552uUkAd0tcdw1ME8CPPtXDKguXH03aJWtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Em+bItqYN7eVL0Y8Wg4QvnnmWhFahcXMp6Oc7LHHbBAJKbYIN9CTayhPiMbKeRKFi
         s25DQezVN4P+ikyvpVNj1w6zeRXMktRYHHAjV33BlCzfGvp62qbmvJabwcegiwGaEF
         WESUAXJwEdJ8Fx9GibAGNG+w1BB/XdtuR/qIzuoQXQ4SQfh5eIB/ZXL4G315WuUDUX
         HqRo5ZaPNvfl0bn5wWp24FzU6xLxg46jcE7hIKh+M40unYnSJf41NZwJTLutkM1StR
         k0fAnwb1xGBNvtYemeFgrieSSTeVbnh2TQsys52pasQmdL/Bd9RF3BB/whEAvGEA0y
         QG+A/V7MZWj0Q==
Date:   Sat, 7 May 2022 12:47:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MIPS: Use NOKPROBE_SYMBOL() instead of __kprobes
 annotation
Message-Id: <20220507124707.8a32912789ed27bb69fe9946@kernel.org>
In-Reply-To: <1651834923-31573-3-git-send-email-yangtiezhu@loongson.cn>
References: <1651834923-31573-1-git-send-email-yangtiezhu@loongson.cn>
        <1651834923-31573-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri,  6 May 2022 19:02:03 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> If define CONFIG_KPROBES, __kprobes annotation forces the whole function
> into the ".kprobes.text" section, NOKPROBE_SYMBOL() only stores the given
> function address in the "_kprobe_blacklist" section which is introduced
> to maintain kprobes blacklist.
> 
> Modify the related code to use NOKPROBE_SYMBOL() to protect functions from
> kprobes instead of __kprobes annotation under arch/mips.

OK, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> No obvious functional change in this patch, some more work needs to be done
> to fix the kernel panic when execute the following testcase on mips:
> 
>   # cd tools/testing/selftests/ftrace
>   # ./ftracetest test.d/kprobe/multiple_kprobes.tc

Hm, I recommend you to manually bisecting the candidates.

1) list up the problematic symbols ( Use --console option to ftracetest so that
you can get the list of symbols via console before panic)
2) split the symbols into two groups
3) manually tests the groups, e.g. 
  $ cat group.list | while read sym; do echo p:$sym >> kprobe_events; done; \
    echo 1 > events/kprobes/enable 
4) if you find one group causes the panic, split it into two groups and repeat 3.

Then, you can find the symbols to be annotated.

Thank you,

> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/kernel/kprobes.c | 36 ++++++++++++++++++++++++------------
>  arch/mips/mm/fault.c       |  6 ++++--
>  2 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
> index 6c7f3b1..316b27d 100644
> --- a/arch/mips/kernel/kprobes.c
> +++ b/arch/mips/kernel/kprobes.c
> @@ -44,10 +44,11 @@ static const union mips_instruction breakpoint2_insn = {
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe);
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  
> -static int __kprobes insn_has_delayslot(union mips_instruction insn)
> +static int insn_has_delayslot(union mips_instruction insn)
>  {
>  	return __insn_has_delay_slot(insn);
>  }
> +NOKPROBE_SYMBOL(insn_has_delayslot);
>  
>  /*
>   * insn_has_ll_or_sc function checks whether instruction is ll or sc
> @@ -56,7 +57,7 @@ static int __kprobes insn_has_delayslot(union mips_instruction insn)
>   * instructions; cannot do much about breakpoint in the middle of
>   * ll/sc pair; it is upto user to avoid those places
>   */
> -static int __kprobes insn_has_ll_or_sc(union mips_instruction insn)
> +static int insn_has_ll_or_sc(union mips_instruction insn)
>  {
>  	int ret = 0;
>  
> @@ -72,8 +73,9 @@ static int __kprobes insn_has_ll_or_sc(union mips_instruction insn)
>  	}
>  	return ret;
>  }
> +NOKPROBE_SYMBOL(insn_has_ll_or_sc);
>  
> -int __kprobes arch_prepare_kprobe(struct kprobe *p)
> +int arch_prepare_kprobe(struct kprobe *p)
>  {
>  	union mips_instruction insn;
>  	union mips_instruction prev_insn;
> @@ -132,26 +134,30 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  out:
>  	return ret;
>  }
> +NOKPROBE_SYMBOL(arch_prepare_kprobe);
>  
> -void __kprobes arch_arm_kprobe(struct kprobe *p)
> +void arch_arm_kprobe(struct kprobe *p)
>  {
>  	*p->addr = breakpoint_insn;
>  	flush_insn_slot(p);
>  }
> +NOKPROBE_SYMBOL(arch_arm_kprobe);
>  
> -void __kprobes arch_disarm_kprobe(struct kprobe *p)
> +void arch_disarm_kprobe(struct kprobe *p)
>  {
>  	*p->addr = p->opcode;
>  	flush_insn_slot(p);
>  }
> +NOKPROBE_SYMBOL(arch_disarm_kprobe);
>  
> -void __kprobes arch_remove_kprobe(struct kprobe *p)
> +void arch_remove_kprobe(struct kprobe *p)
>  {
>  	if (p->ainsn.insn) {
>  		free_insn_slot(p->ainsn.insn, 0);
>  		p->ainsn.insn = NULL;
>  	}
>  }
> +NOKPROBE_SYMBOL(arch_remove_kprobe);
>  
>  static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
>  {
> @@ -257,7 +263,7 @@ static void prepare_singlestep(struct kprobe *p, struct pt_regs *regs,
>   * breakpoint trap. In case of branch instructions, the target
>   * epc to be restored.
>   */
> -static void __kprobes resume_execution(struct kprobe *p,
> +static void resume_execution(struct kprobe *p,
>  				       struct pt_regs *regs,
>  				       struct kprobe_ctlblk *kcb)
>  {
> @@ -268,8 +274,9 @@ static void __kprobes resume_execution(struct kprobe *p,
>  		regs->cp0_epc = orig_epc + 4;
>  	}
>  }
> +NOKPROBE_SYMBOL(resume_execution);
>  
> -static int __kprobes kprobe_handler(struct pt_regs *regs)
> +static int kprobe_handler(struct pt_regs *regs)
>  {
>  	struct kprobe *p;
>  	int ret = 0;
> @@ -367,6 +374,7 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
>  	return ret;
>  
>  }
> +NOKPROBE_SYMBOL(kprobe_handler);
>  
>  static inline int post_kprobe_handler(struct pt_regs *regs)
>  {
> @@ -415,7 +423,7 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  /*
>   * Wrapper routine for handling exceptions.
>   */
> -int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
> +int kprobe_exceptions_notify(struct notifier_block *self,
>  				       unsigned long val, void *data)
>  {
>  
> @@ -446,6 +454,7 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>  	}
>  	return ret;
>  }
> +NOKPROBE_SYMBOL(kprobe_exceptions_notify);
>  
>  /*
>   * Function return probe trampoline:
> @@ -469,7 +478,7 @@ static void __used kretprobe_trampoline_holder(void)
>  
>  void __kretprobe_trampoline(void);
>  
> -void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> +void arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				      struct pt_regs *regs)
>  {
>  	ri->ret_addr = (kprobe_opcode_t *) regs->regs[31];
> @@ -478,11 +487,12 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  	/* Replace the return addr with trampoline addr */
>  	regs->regs[31] = (unsigned long)__kretprobe_trampoline;
>  }
> +NOKPROBE_SYMBOL(arch_prepare_kretprobe);
>  
>  /*
>   * Called when the probe at kretprobe trampoline is hit
>   */
> -static int __kprobes trampoline_probe_handler(struct kprobe *p,
> +static int trampoline_probe_handler(struct kprobe *p,
>  						struct pt_regs *regs)
>  {
>  	instruction_pointer(regs) = __kretprobe_trampoline_handler(regs, NULL);
> @@ -493,14 +503,16 @@ static int __kprobes trampoline_probe_handler(struct kprobe *p,
>  	 */
>  	return 1;
>  }
> +NOKPROBE_SYMBOL(trampoline_probe_handler);
>  
> -int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> +int arch_trampoline_kprobe(struct kprobe *p)
>  {
>  	if (p->addr == (kprobe_opcode_t *)__kretprobe_trampoline)
>  		return 1;
>  
>  	return 0;
>  }
> +NOKPROBE_SYMBOL(arch_trampoline_kprobe);
>  
>  static struct kprobe trampoline_p = {
>  	.addr = (kprobe_opcode_t *)__kretprobe_trampoline,
> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index 44f9810..b08bc55 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
> @@ -35,7 +35,7 @@ int show_unhandled_signals = 1;
>   * and the problem, and then passes it off to one of the appropriate
>   * routines.
>   */
> -static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
> +static void __do_page_fault(struct pt_regs *regs, unsigned long write,
>  	unsigned long address)
>  {
>  	struct vm_area_struct * vma = NULL;
> @@ -322,8 +322,9 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
>  	}
>  #endif
>  }
> +NOKPROBE_SYMBOL(__do_page_fault);
>  
> -asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
> +asmlinkage void do_page_fault(struct pt_regs *regs,
>  	unsigned long write, unsigned long address)
>  {
>  	enum ctx_state prev_state;
> @@ -332,3 +333,4 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
>  	__do_page_fault(regs, write, address);
>  	exception_exit(prev_state);
>  }
> +NOKPROBE_SYMBOL(do_page_fault);
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
