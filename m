Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA8266960
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgIKUIz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgIKUIy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 16:08:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93E7C061573;
        Fri, 11 Sep 2020 13:08:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 53A7E29BA66
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     peterz@infradead.org
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Organization: Collabora
References: <20200904203147.2908430-1-krisman@collabora.com>
        <20200904203147.2908430-2-krisman@collabora.com>
        <20200911093221.GD1362448@hirez.programming.kicks-ass.net>
Date:   Fri, 11 Sep 2020 16:08:45 -0400
In-Reply-To: <20200911093221.GD1362448@hirez.programming.kicks-ass.net>
        (peterz@infradead.org's message of "Fri, 11 Sep 2020 11:32:21 +0200")
Message-ID: <878sdgnkj6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

peterz@infradead.org writes:

> On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
>> +static inline void __set_tsk_syscall_intercept(struct task_struct *tsk,
>> +					   unsigned int type)
>> +{
>> +	tsk->syscall_intercept |= type;
>> +
>> +	if (tsk->syscall_intercept)
>> +		set_tsk_thread_flag(tsk, TIF_SYSCALL_INTERCEPT);
>> +}
>
> Did the above want to be:
>
> 	unsigned int old = tsk->syscall_intercept;
> 	tsk->syscall_intercept |= type;
> 	if (!old)
> 		set_tsk_thread_flag(tsk, TIF_SYSCALL_INTERCEPT)
>

Hi Peter,

Thanks for the review!

I'm not sure this change gains us anything.  For now,
__set_tsk_syscall_intercept cannot be called with !type, so both
versions behave the same, but my version is safe with that scenario.
This won't be called frequent enough for the extra calls to
set_tsk_thread_flag matter.  Am I missing something?

Thanks,

-- 
Gabriel Krisman Bertazi
