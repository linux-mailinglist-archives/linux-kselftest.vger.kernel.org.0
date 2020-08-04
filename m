Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455BD23BC14
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 16:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgHDO1F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Aug 2020 10:27:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33090 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgHDO1B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Aug 2020 10:27:01 -0400
Received: from localhost (unknown [IPv6:2610:98:8005::7c0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 90031298801;
        Tue,  4 Aug 2020 15:26:59 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, willy@infradead.org, luto@kernel.org,
        gofmanp@gmail.com, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v4 0/2] Syscall User Redirection
Organization: Collabora
References: <20200716193141.4068476-1-krisman@collabora.com>
        <20200802120115.GC1289@bug>
Date:   Tue, 04 Aug 2020 10:26:56 -0400
In-Reply-To: <20200802120115.GC1289@bug> (Pavel Machek's message of "Sun, 2
        Aug 2020 14:01:15 +0200")
Message-ID: <87h7tiebbj.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> This is v4 of Syscall User Redirection.  The implementation itself is
>> not modified from v3, it only applies the latest round of reviews to the
>> selftests.
>> 
>> __NR_syscalls is not really exported in header files other than
>> asm-generic for every architecture, so it felt safer to optionally
>> expose it with a fallback to a high value.
>> 
>> Also, I didn't expose tests for PR_GET as that is not currently
>> implemented.  If possible, I'd have it supported by a future patchset,
>> since it is not immediately necessary to support this feature.
>> 
>> Finally, one question: Which tree would this go through?
>
> Should it come with Documentation?

Hi,

Thanks for the review.

I will prepare it for the next iteration.

> How does it interact with ptrace, seccomp and similar?

That is a very good question.

Regarding seccomp, this must take precedence, since the use case is
emulation (it can be invoked with a different ABI) such that seccomp
filtering by syscall number doesn't make sense in the first place.  In
addition, either the syscall is dispatched back to userspace, in which
case there is no resource for seccomp to protect, or the syscall will be
executed, and seccomp will execute next.

Regarding ptrace, I experimented with before and after, and while the
same ABI argument applies, I felt it was easier to debug if I let ptrace
happen for syscalls that are dispatched back to userspace.  In addition,
doing it after ptrace makes the code in syscall_exit_work slightly
simpler, since it doesn't require special handling for this feature.

For PTRACE_SYSEMU in particular, either placing this before or after is
a bit odd.  I don't think there is a right answer for this one, but I
don't see anyone wanting to use these features at the same time.  I
think as long as it is documented behavior, it should be fine either
way.

-- 
Gabriel Krisman Bertazi
