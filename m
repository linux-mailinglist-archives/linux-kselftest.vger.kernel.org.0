Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02322B8288
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 18:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgKRRCn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 12:02:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36662 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgKRRCn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 12:02:43 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EA3C41F45211
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v7 7/7] docs: Document Syscall User Dispatch
Organization: Collabora
References: <20201118032840.3429268-1-krisman@collabora.com>
        <20201118032840.3429268-8-krisman@collabora.com>
        <875z63yrrq.fsf@mid.deneb.enyo.de>
Date:   Wed, 18 Nov 2020 12:02:36 -0500
In-Reply-To: <875z63yrrq.fsf@mid.deneb.enyo.de> (Florian Weimer's message of
        "Wed, 18 Nov 2020 09:48:41 +0100")
Message-ID: <877dqivbrn.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:

> * Gabriel Krisman Bertazi:
>
>> +Interface
>> +---------
>> +
>> +A process can setup this mechanism on supported kernels
>> +CONFIG_SYSCALL_USER_DISPATCH) by executing the following prctl:
>> +
>> +  prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <offset>, <length>, [selector])
>> +
>> +<op> is either PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF, to enable and
>> +disable the mechanism globally for that thread.  When
>> +PR_SYS_DISPATCH_OFF is used, the other fields must be zero.
>> +
>> +<offset> and <offset+length> delimit a closed memory region interval
>> +from which syscalls are always executed directly, regardless of the
>> +userspace selector.  This provides a fast path for the C library, which
>> +includes the most common syscall dispatchers in the native code
>> +applications, and also provides a way for the signal handler to return
>> +without triggering a nested SIGSYS on (rt_)sigreturn.  Users of this
>> +interface should make sure that at least the signal trampoline code is
>> +included in this region. In addition, for syscalls that implement the
>> +trampoline code on the vDSO, that trampoline is never intercepted.
>> +
>> +[selector] is a pointer to a char-sized region in the process memory
>> +region, that provides a quick way to enable disable syscall redirection
>> +thread-wide, without the need to invoke the kernel directly.  selector
>> +can be set to PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.  Any other
>> +value should terminate the program with a SIGSYS.
>
> Is this a process property or a task/thread property?  The last
> paragraph says “thread-wide”, but the first paragraph says “process”.

It is per-thread, as it doesn't survive across clone/fork syscalls.  I
will fix the first paragraph of this text.

-- 
Gabriel Krisman Bertazi
