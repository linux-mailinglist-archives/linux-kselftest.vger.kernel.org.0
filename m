Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85F2223113
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jul 2020 04:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgGQCPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 22:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgGQCPl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 22:15:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B4C061755;
        Thu, 16 Jul 2020 19:15:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EA02B2A292F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Matthew Wilcox <willy@infradead.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace redirection
Organization: Collabora
References: <20200716193141.4068476-1-krisman@collabora.com>
        <20200716193141.4068476-2-krisman@collabora.com>
        <CALCETrWdCN5KsRUkrb8VoYGRBhy71P-MAHGWhuJ5y4Z3vByyvg@mail.gmail.com>
Date:   Thu, 16 Jul 2020 22:15:35 -0400
In-Reply-To: <CALCETrWdCN5KsRUkrb8VoYGRBhy71P-MAHGWhuJ5y4Z3vByyvg@mail.gmail.com>
        (Andy Lutomirski's message of "Thu, 16 Jul 2020 17:20:02 -0700")
Message-ID: <87wo32j394.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Thu, Jul 16, 2020 at 12:31 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>
> This is quite nice.  I have a few comments, though:
>
> You mentioned rt_sigreturn().  Should this automatically exempt the
> kernel-provided signal restorer on architectures (e.g. x86_32) that
> provide one?

That seems reasonable.  Not sure how easy it is to do it, though.

> The amount of syscall entry wiring that arches need to do is IMO
> already a bit out of hand.  Should we instead rename TIF_SECCOMP to
> TIF_SYSCALL_INTERCEPTION and have one generic callback that handles
> seccomp and this new thing?

Considering the previous suggestion from Kees to hide it inside the
tracehook and Thomas rework of this path, I'm not sure what is the best
solution here, but some rework of these flags is due.  Thomas suggested
expanding these flags to 64 bits and having some arch specific and
arch-agnostic flags.  With the storage expansion and arch-agnostic flags,
would this still be desirable?

>> +int do_syscall_user_dispatch(struct pt_regs *regs)
>> +{
>> +       struct syscall_user_dispatch *sd = &current->syscall_dispatch;
>> +       unsigned long ip = instruction_pointer(regs);
>> +       char state;
>> +
>> +       if (likely(ip >= sd->dispatcher_start && ip <= sd->dispatcher_end))
>> +               return 0;
>> +
>> +       if (likely(sd->selector)) {
>> +               if (unlikely(__get_user(state, sd->selector)))
>> +                       do_exit(SIGSEGV);
>> +
>> +               if (likely(state == 0))
>> +                       return 0;
>> +
>> +               if (state != 1)
>> +                       do_exit(SIGSEGV);
>
> This seems a bit extreme and hard to debug if it ever happens.

Makes sense, but I don't see a better way to return the error here.
Maybe a SIGSYS with a different si_errno?  Alternatively, we could
revert to the previous behavior of allowing syscalls on state != 0, that
existed in v1.  What do you think?

-- 
Gabriel Krisman Bertazi
