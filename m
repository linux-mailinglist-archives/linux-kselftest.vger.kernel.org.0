Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04E225FF5B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 18:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgIGQaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 12:30:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39161 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbgIGOZY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 10:25:24 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFI51-0001oo-Gp; Mon, 07 Sep 2020 14:25:11 +0000
Date:   Mon, 7 Sep 2020 16:25:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, luto@kernel.org,
        tglx@linutronix.de, keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 6/9] kernel: entry: Support Syscall User Dispatch for
 common syscall entry
Message-ID: <20200907142510.klojh2urwyui23ox@wittgenstein>
References: <20200907101522.zo6qzgp4qfzkz7cs@wittgenstein>
 <0639209E-B6C6-4F86-84F4-04B91E1CC8AA@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0639209E-B6C6-4F86-84F4-04B91E1CC8AA@amacapital.net>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 07, 2020 at 07:15:52AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Sep 7, 2020, at 3:15 AM, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > 
> > ﻿On Fri, Sep 04, 2020 at 04:31:44PM -0400, Gabriel Krisman Bertazi wrote:
> >> Syscall User Dispatch (SUD) must take precedence over seccomp, since the
> >> use case is emulation (it can be invoked with a different ABI) such that
> >> seccomp filtering by syscall number doesn't make sense in the first
> >> place.  In addition, either the syscall is dispatched back to userspace,
> >> in which case there is no resource for seccomp to protect, or the
> > 
> > Tbh, I'm torn here. I'm not a super clever attacker but it feels to me
> > that this is still at least a clever way to circumvent a seccomp
> > sandbox.
> > If I'd be confined by a seccomp profile that would cause me to be
> > SIGKILLed when I try do open() I could prctl() myself to do user
> > dispatch to prevent that from happening, no?
> > 
> 
> Not really, I think. The idea is that you didn’t actually do open().
> You did a SYSCALL instruction which meant something else, and the
> syscall dispatch correctly prevented the kernel from misinterpreting
> it as open().

Right, for the case where you're e.g. emulating windows syscalls that's
true. I was thinking when you're running natively on Linux: couldn't I
first load a seccomp profile "kill me if someone does an open()", then
I exec() the target binary and that binary is setup to do
prctl(USER_DISPATCH) first thing. I guess, it's ok because as far as I
had time to read it this is a nothing or all mechanism, i.e. _all_
system calls are re-routed in contrast to e.g. seccomp where I could do
this per-syscall. So for user-dispatch it wouldn't make sense to use it
on Linux per se. Still makes me a little uneasy. :)

Christian
