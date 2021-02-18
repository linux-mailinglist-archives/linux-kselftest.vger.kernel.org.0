Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECC131ECD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Feb 2021 18:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhBRRE0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Feb 2021 12:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhBRPtj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Feb 2021 10:49:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E16C061756;
        Thu, 18 Feb 2021 07:48:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EE6261F45D20
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
Subject: Re: [RFC PATCH 01/13] futex2: Implement wait and wake functions
In-Reply-To: <74e321d5-2cf5-f3a6-6a7a-49e1ed2fda07@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Thu, 18 Feb 2021 10:29:46 -0300")
Organization: Collabora
References: <20210215152404.250281-1-andrealmeid@collabora.com>
        <20210215152404.250281-2-andrealmeid@collabora.com>
        <87k0r9w19l.fsf@collabora.com>
        <74e321d5-2cf5-f3a6-6a7a-49e1ed2fda07@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Thu, 18 Feb 2021 10:48:50 -0500
Message-ID: <87y2fltlzx.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

>>> +		if (unlikely(ret)) {
>>> +			spin_unlock(&bucket->lock);
>>> +
>>> +			bucket_dec_waiters(bucket);
>>> +			__set_current_state(TASK_RUNNING);
>>> +			*awakened = futex_dequeue_multiple(futexv, i);
>>> +
>>> +			if (__get_user(uval, uaddr))
>>> +				return -EFAULT;
>>> +
>>> +			if (*awakened >= 0)
>>> +				return 1;
>> If you are awakened, you don't need to waste time with trying to get
>> the
>> next key.
>> 
>
> Yes, and this is what this return is supposed to do. What I'm missing?

you don't need to do that __get_user if some other key was already awoke.

[...]
if (*awakened >= 0)
	return 1;

if (__get_user(uval, uaddr))
	return -EFAULT;
[...]

-- 
Gabriel Krisman Bertazi
