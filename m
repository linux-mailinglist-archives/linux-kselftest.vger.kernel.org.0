Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4018DE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEIQUJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 12:20:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35077 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIQUJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 12:20:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id g5so1394344plt.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2019 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Da8NJHS+7ZThf+OYImudsb+xwESZVW3cTD3jbRasagk=;
        b=gzFJZzgJPaZOucWo/vGMIWF9T1za1Iyi65SlihCeJbqtt/msKUw1nz7EPEN2hzNegz
         b/dS6s4L0QhwAP4U2cgOxcvgj/l8oPYk8pKWywFPwniO7kF1aprd6AwIged5Z+PsVxWU
         TqCDO3ZWBmCpYUwIJrzJ6dDaehTVjOVSGK1NKdQoUCr4q37afPcQth5OaU2/6A0ifAK5
         FnlPX194aoxQCHrCS9nietKN0QRKYWrnfjhrrns2sdUrgd5PoqYM4JnVELcUYsrxDqZv
         DNXgFaJclAHn4NjG4u8+xlMouUe40x6WTco8xHeJf60QyHdlgvgvmft/7D/eHzB3tZtV
         ifkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Da8NJHS+7ZThf+OYImudsb+xwESZVW3cTD3jbRasagk=;
        b=T5TbzuXVq558Qg9Ddq28Dtdwq7ar75ogfOkcYb8x5MFjKlXz5iG0joUdOrvyLT3voj
         be4FvnY8Jz+qQg/f/Cg+4pZSgL3bPihnsAYq+EO/4/LW89q0FsSix8VP1mo4R2HkBAOZ
         GuYw9bzTJ9qz3VEqHa9mpLkQ794/PfBn2NMcnxnJbXhZILce39mudZ+hvpQ+3VXg3Yt0
         XJofi7gd7Rwce4C2brLUkasXWfS9ClPmS5rgXPxhkasVCfKIkPHnzxD1mMxGWSLoR9no
         5G+xhVfS5qPp3lUvM+A6+JnoI7MHDONWvYK/baCoEa+F2jKHU2zvSGChxJ96m8SYRmby
         zL3w==
X-Gm-Message-State: APjAAAUIeZ5AfEDS7qtWMjVsgeXiwxInhdOwukXuLUkQisNrYNSOJLAt
        9VaQsD2tWYsQ1L3fE2y9h8d7Jg==
X-Google-Smtp-Source: APXvYqyek3vYot8PDiUs/2GXtlTftVn0SxW+VEnhHWpmGG8ZBMqgEH+H6vf2yS0OxGzrlBxec9MXdQ==
X-Received: by 2002:a17:902:9a81:: with SMTP id w1mr5118343plp.71.1557418808267;
        Thu, 09 May 2019 09:20:08 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:8848:cc98:4f02:bf2c? ([2601:646:c200:1ef2:8848:cc98:4f02:bf2c])
        by smtp.gmail.com with ESMTPSA id s78sm7785323pfs.187.2019.05.09.09.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:20:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190509081431.GO2589@hirez.programming.kicks-ass.net>
Date:   Thu, 9 May 2019 09:20:06 -0700
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>, linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <81170F0B-A2BB-4CD6-A1B5-5E7E0DDBC282@amacapital.net>
References: <20190508074901.982470324@infradead.org> <20190508080612.721269814@infradead.org> <20190508115416.nblx7c2kocidpytm@treble> <20190508120416.GL2589@hirez.programming.kicks-ass.net> <20190508124248.u5ukpbhnh4wpiccq@treble> <20190508153907.GM2589@hirez.programming.kicks-ass.net> <20190508184848.qerg3flv3ej3xsev@treble> <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org> <20190509081431.GO2589@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On May 9, 2019, at 1:14 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Thu, May 09, 2019 at 10:20:30AM +0900, Masami Hiramatsu wrote:
>> Hi Josh,
>>=20
>> On Wed, 8 May 2019 13:48:48 -0500
>> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>=20
>>>> On Wed, May 08, 2019 at 05:39:07PM +0200, Peter Zijlstra wrote:
>>>>> On Wed, May 08, 2019 at 07:42:48AM -0500, Josh Poimboeuf wrote:
>>>>> On Wed, May 08, 2019 at 02:04:16PM +0200, Peter Zijlstra wrote:
>>>>=20
>>>>>> Do the x86_64 variants also want some ORC annotation?
>>>>>=20
>>>>> Maybe so.  Though it looks like regs->ip isn't saved.  The saved
>>>>> registers might need to be tweaked.  I'll need to look into it.
>>>>=20
>>>> What all these sites do (and maybe we should look at unifying them
>>>> somehow) is turn a CALL frame (aka RET-IP) into an exception frame (aka=

>>>> pt_regs).
>>>>=20
>>>> So regs->ip will be the return address (which is fixed up to be the CAL=
L
>>>> address in the handler).
>>>=20
>>> But from what I can tell, trampoline_handler() hard-codes regs->ip to
>>> point to kretprobe_trampoline(), and the original return address is
>>> placed in regs->sp.
>>>=20
>>> Masami, is there a reason why regs->ip doesn't have the original return
>>> address and regs->sp doesn't have the original SP?  I think that would
>>> help the unwinder understand things.
>>=20
>> Yes, for regs->ip, there is a histrical reason. Since previously, we had
>> an int3 at trampoline, so the user (kretprobe) handler expects that
>> regs->ip is trampoline address and ri->ret_addr is original return addres=
s.
>> It is better to check the other archs, but I think it is possible to
>> change the regs->ip to original return address, since no one cares such
>> "fixed address". :)
>>=20
>> For the regs->sp, there are 2 reasons.
>>=20
>> For x86-64, it's just for over-optimizing (reduce stack usage).
>> I think we can make a gap for putting return address, something like
>>=20
>>    "kretprobe_trampoline:\n"
>> #ifdef CONFIG_X86_64
>>    "    pushq %rsp\n"    /* Make a gap for return address */
>>    "    pushq 0(%rsp)\n"    /* Copy original stack pointer */
>>    "    pushfq\n"
>>    SAVE_REGS_STRING
>>    "    movq %rsp, %rdi\n"
>>    "    call trampoline_handler\n"
>>    /* Push the true return address to the bottom */
>>    "    movq %rax, 20*8(%rsp)\n"
>>    RESTORE_REGS_STRING
>>    "    popfq\n"
>>    "    addq $8, %rsp\n"    /* Skip original stack pointer */
>>=20
>> For i386 (x86-32), there is no other way to keep &regs->sp as
>> the original stack pointer. It has to be changed with this series,
>> maybe as same as x86-64.
>=20
> Right; I already fixed that in my patch changing i386's pt_regs.
>=20
> But what I'd love to do is something like the belwo patch, and make all
> the trampolines (very much including ftrace) use that. Such that we then
> only have 1 copy of this magic (well, 2 because x86_64 also needs an
> implementation of this of course).
>=20
> Changing ftrace over to this would be a little more work but it can
> easily chain things a little to get its original context back:
>=20
> ENTRY(ftrace_regs_caller)
> GLOBAL(ftrace_regs_func)
>    push ftrace_stub
>    push ftrace_regs_handler
>    jmp call_to_exception_trampoline
> END(ftrace_regs_caller)
>=20
> typedef void (*ftrace_func_t)(unsigned long, unsigned long, struct ftrace_=
op *, struct pt_regs *);
>=20
> struct ftrace_regs_stack {
>    ftrace_func_t func;
>    unsigned long parent_ip;
> };
>=20
> void ftrace_regs_handler(struct pr_regs *regs)
> {
>    struct ftrace_regs_stack *st =3D (void *)regs->sp;
>    ftrace_func_t func =3D st->func;
>=20
>    regs->sp +=3D sizeof(long); /* pop func */
>=20
>    func(regs->ip, st->parent_ip, function_trace_op, regs);
> }
>=20
> Hmm? I didn't look into the function_graph thing, but I imagine it can
> be added without too much pain.
>=20
> ---
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1576,3 +1576,100 @@ ENTRY(rewind_stack_do_exit)
>    call    do_exit
> 1:    jmp 1b
> END(rewind_stack_do_exit)
> +
> +/*
> + * Transforms a CALL frame into an exception frame; IOW it pretends the C=
ALL we
> + * just did was in fact scribbled with an INT3.
> + *
> + * Use this trampoline like:
> + *
> + *   PUSH $func
> + *   JMP call_to_exception_trampoline
> + *
> + * $func will see regs->ip point at the CALL instruction and must therefo=
re
> + * modify regs->ip in order to make progress (just like a normal INT3 scr=
ibbled
> + * CALL).
> + *
> + * NOTE: we do not restore any of the segment registers.
> + */
> +ENTRY(call_to_exception_trampoline)
> +    /*
> +     * On entry the stack looks like:
> +     *
> +     *   2*4(%esp) <previous context>
> +     *   1*4(%esp) RET-IP
> +     *   0*4(%esp) func
> +     *
> +     * transform this into:
> +     *
> +     *  19*4(%esp) <previous context>
> +     *  18*4(%esp) gap / RET-IP
> +     *  17*4(%esp) gap / func
> +     *  16*4(%esp) ss
> +     *  15*4(%esp) sp / <previous context>
> +     *  14*4(%esp) flags
> +     *  13*4(%esp) cs
> +     *  12*4(%esp) ip / RET-IP
> +     *  11*4(%esp) orig_eax
> +     *  10*4(%esp) gs
> +     *   9*4(%esp) fs
> +     *   8*4(%esp) es
> +     *   7*4(%esp) ds
> +     *   6*4(%esp) eax
> +     *   5*4(%esp) ebp
> +     *   4*4(%esp) edi
> +     *   3*4(%esp) esi
> +     *   2*4(%esp) edx
> +     *   1*4(%esp) ecx
> +     *   0*4(%esp) ebx
> +     */
> +    pushl    %ss
> +    pushl    %esp        # points at ss
> +    addl    $3*4, (%esp)    #   point it at <previous context>
> +    pushfl
> +    pushl    %cs
> +    pushl    5*4(%esp)    # RET-IP
> +    subl    5, (%esp)    #   point at CALL instruction
> +    pushl    $-1
> +    pushl    %gs
> +    pushl    %fs
> +    pushl    %es
> +    pushl    %ds
> +    pushl    %eax
> +    pushl    %ebp
> +    pushl    %edi
> +    pushl    %esi
> +    pushl    %edx
> +    pushl    %ecx
> +    pushl    %ebx
> +
> +    ENCODE_FRAME_POINTER
> +
> +    movl    %esp, %eax    # 1st argument: pt_regs
> +
> +    movl    17*4(%esp), %ebx    # func
> +    CALL_NOSPEC %ebx
> +
> +    movl    PT_OLDESP(%esp), %eax
> +
> +    movl    PT_EIP(%esp), %ecx
> +    movl    %ecx, -1*4(%eax)
> +
> +    movl    PT_EFLAGS(%esp), %ecx
> +    movl    %ecx, -2*4(%eax)
> +
> +    movl    PT_EAX(%esp), %ecx
> +    movl    %ecx, -3*4(%eax)
> +
> +    popl    %ebx
> +    popl    %ecx
> +    popl    %edx
> +    popl    %esi
> +    popl    %edi
> +    popl    %ebp
> +
> +    lea    -3*4(%eax), %esp
> +    popl    %eax
> +    popfl
> +    ret
> +END(call_to_exception_trampoline)
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -731,29 +731,8 @@ asm(
>    ".global kretprobe_trampoline\n"
>    ".type kretprobe_trampoline, @function\n"
>    "kretprobe_trampoline:\n"
> -    /* We don't bother saving the ss register */
> -#ifdef CONFIG_X86_64
> -    "    pushq %rsp\n"
> -    "    pushfq\n"
> -    SAVE_REGS_STRING
> -    "    movq %rsp, %rdi\n"
> -    "    call trampoline_handler\n"
> -    /* Replace saved sp with true return address. */
> -    "    movq %rax, 19*8(%rsp)\n"
> -    RESTORE_REGS_STRING
> -    "    popfq\n"
> -#else
> -    "    pushl %esp\n"
> -    "    pushfl\n"
> -    SAVE_REGS_STRING
> -    "    movl %esp, %eax\n"
> -    "    call trampoline_handler\n"
> -    /* Replace saved sp with true return address. */
> -    "    movl %eax, 15*4(%esp)\n"
> -    RESTORE_REGS_STRING
> -    "    popfl\n"
> -#endif
> -    "    ret\n"
> +    "push trampoline_handler\n"
> +    "jmp call_to_exception_trampoline\n"
>    ".size kretprobe_trampoline, .-kretprobe_trampoline\n"
> );


Potentially minor nit: you=E2=80=99re doing popfl, but you=E2=80=99re not do=
ing TRACE_IRQ_whatever.  This makes me think that you should either add the t=
racing (ugh!) or you should maybe just skip the popfl.=
