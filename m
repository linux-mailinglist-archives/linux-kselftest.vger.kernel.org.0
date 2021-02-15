Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1497A31C2C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 21:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhBOUEj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 15:04:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34326 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhBOUEe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 15:04:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id AB0F01F45078
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, pgriffais@valvesoftware.com,
        z.figura12@gmail.com, joel@joelfernandes.org,
        malteskarupke@fastmail.fm, linux-api@vger.kernel.org,
        fweimer@redhat.com, libc-alpha@sourceware.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, acme@kernel.org,
        corbet@lwn.net
Subject: Re: [RFC PATCH 03/13] futex2: Implement vectorized wait
Organization: Collabora
References: <20210215152404.250281-1-andrealmeid@collabora.com>
        <20210215152404.250281-4-andrealmeid@collabora.com>
Date:   Mon, 15 Feb 2021 15:03:48 -0500
In-Reply-To: <20210215152404.250281-4-andrealmeid@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Mon, 15 Feb 2021 12:23:54 -0300")
Message-ID: <87ft1xw123.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

> Add support to wait on multiple futexes. This is the interface
> implemented by this syscall:
>
> futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
> 	    unsigned int flags, struct timespec *timo)
>
> struct futex_waitv {
> 	void *uaddr;
> 	unsigned int val;
> 	unsigned int flags;
> };
>
> Given an array of struct futex_waitv, wait on each uaddr. The thread
> wakes if a futex_wake() is performed at any uaddr. The syscall returns
> immediately if any waiter has *uaddr != val. *timo is an optional
> timeout value for the operation. The flags argument of the syscall
> should be used solely for specifying the timeout as realtime, if needed.
> Flags for shared futexes, sizes, etc. should be used on the individual
> flags of each waiter.

Given the previous proposal from Zebediah, one use case Wine has to
support is the ability to wait on all (instead of any) of a list of
futexes .  I suppose that could be done by a new FLAG_WAITALL passed on
the third argument of the syscall.

-- 
Gabriel Krisman Bertazi
