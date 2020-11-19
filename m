Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE42B99DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 18:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKSRnL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 12:43:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51660 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgKSRnK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 12:43:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4F6B71F45ABF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, Rich Felker <dalias@libc.org>
Cc:     tglx@linutronix.de, keescook@chromium.org,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org, gofmanp@gmail.com,
        kernel@collabora.com
Subject: Re: [PATCH v7 3/7] kernel: Implement selective syscall userspace
 redirection
Organization: Collabora
References: <20201118032840.3429268-1-krisman@collabora.com>
        <20201118032840.3429268-4-krisman@collabora.com>
Date:   Thu, 19 Nov 2020 12:43:05 -0500
In-Reply-To: <20201118032840.3429268-4-krisman@collabora.com> (Gabriel Krisman
        Bertazi's message of "Tue, 17 Nov 2020 22:28:36 -0500")
Message-ID: <87a6vdmedy.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> Introduce a mechanism to quickly disable/enable syscall handling for a
> specific process and redirect to userspace via SIGSYS.  This is useful
> for processes with parts that require syscall redirection and parts that
> don't, but who need to perform this boundary crossing really fast,
> without paying the cost of a system call to reconfigure syscall handling
> on each boundary transition.  This is particularly important for Windows
> games running over Wine.

I raised a discussion about this on libc-alpha, as requested by Florian.
At the moment, there was some back and forth on why the use-case is not
done by seccomp, but a more interesting point about user_notif was
raised by Rich Felker (cc'ed).

SIGSYS, as a signal handler, is limited in what can be done inside it.
Rich suggested the user_notif design is a better solution.  I understand
that from a Wine perspective, SIGSYS suffices for their work, but would
it make sense to extend SUD interface to support a user_notif-like
interface?  Would this be acceptable as future work to be added when/if
needed, or should we design it from the start?

The existing interface could be extended with a flags field as part of
the opcode passed in argument 2, which is currently reserved, and then
return a FD, just like seccomp(2) does.  So it is not like the current
patches couldn't be extended in the future if needed, unless I'm
mistaken.

-- 
Gabriel Krisman Bertazi
