Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27293B953F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jul 2021 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhGARMA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jul 2021 13:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhGARMA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jul 2021 13:12:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F8BC061762;
        Thu,  1 Jul 2021 10:09:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 32F041F445DA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        gofmanp@gmail.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 3/7] kernel: Implement selective syscall userspace
 redirection
Organization: Collabora
References: <20201127193238.821364-1-krisman@collabora.com>
        <20201127193238.821364-4-krisman@collabora.com>
        <8735szowmu.fsf@disp2133>
Date:   Thu, 01 Jul 2021 13:09:21 -0400
In-Reply-To: <8735szowmu.fsf@disp2133> (Eric W. Biederman's message of "Wed,
        30 Jun 2021 16:44:41 -0500")
Message-ID: <87mtr6gdvi.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Why does do_syscal_user_dispatch call do_exit(SIGSEGV) and
> do_exit(SIGSYS) instead of force_sig(SIGSEGV) and force_sig(SIGSYS)?
>
> Looking at the code these cases are not expected to happen, so I would
> be surprised if userspace depends on any particular behaviour on the
> failure path so I think we can change this.

Hi Eric,

There is not really a good reason, and the use case that originated the
feature doesn't rely on it.

Unless I'm missing yet another problem and others correct me, I think
it makes sense to change it as you described.

> Is using do_exit in this way something you copied from seccomp?

I'm not sure, its been a while, but I think it might be just that.  The
first prototype of SUD was implemented as a seccomp mode.

> The reason I am asking is that by using do_exit you deprive userspace
> of the change to catch the signal handler and try and fix things.
>
> Also by using do_exit only a single thread of a multi-thread application
> is terminated which seems wrong.
>
> I am asking because I am going through the callers of do_exit so I can
> refactor things and clean things up and this use just looks wrong.

Thanks,

-- 
Gabriel Krisman Bertazi
