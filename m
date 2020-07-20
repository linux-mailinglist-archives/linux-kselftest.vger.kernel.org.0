Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBE2225BF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jul 2020 11:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGTJon (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jul 2020 05:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgGTJon (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jul 2020 05:44:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA1F208E4;
        Mon, 20 Jul 2020 09:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595238283;
        bh=TRyr/qp3584qIQrYcl/qGBgEKMgFIlh/mOVW7CCDN+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wf/zu+kAnmX1JayuDyY2CAJGv0WvYDIuazTvTk8ZZVlDW8bunpDFa3DrUYJbxpIow
         +uO76SL7RT88ODVsqB2d7Aj7Mk/2l6ntmxhEeCtBG2x7tDzwn2iTj/qWU4ReS+ss8V
         UBWSKrqTZi5TdFTyhB9r0mqloqEk7fMeUOtopLTk=
Date:   Mon, 20 Jul 2020 10:44:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Matthew Wilcox <willy@infradead.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace
 redirection
Message-ID: <20200720094437.GA11405@willie-the-truck>
References: <20200716193141.4068476-1-krisman@collabora.com>
 <20200716193141.4068476-2-krisman@collabora.com>
 <CALCETrWdCN5KsRUkrb8VoYGRBhy71P-MAHGWhuJ5y4Z3vByyvg@mail.gmail.com>
 <874kq2o7zy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kq2o7zy.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 20, 2020 at 11:23:13AM +0200, Thomas Gleixner wrote:
> Andy Lutomirski <luto@kernel.org> writes:
> > On Thu, Jul 16, 2020 at 12:31 PM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> > The amount of syscall entry wiring that arches need to do is IMO
> > already a bit out of hand.  Should we instead rename TIF_SECCOMP to
> > TIF_SYSCALL_INTERCEPTION and have one generic callback that handles
> > seccomp and this new thing?
> 
> The right way to go is to consolidate all the stupidly different
> entry/exit work handling implementations and have exactly one in generic
> code, i.e. what I posted a few days ago.
> 
> Then we can make new features only available in the generic version by
> hiding the new functionality in the core code and not exposing the
> functions to architecture implementations.
> 
> Making it easy for architectures to keep their own variant forever just
> proliferates the mess we have right now.

Couldn't agree more. We recently added PTRACE_SYSEMU to arm64 and I deeply
regret doing that now that yet another way to rewrite the syscall number
has come along. I only just untangled some of the mess in our entry code
for that, so I can't say I'm looking forward to opening it right back up
to support this new feature. Much better to do it in the core code instead.

Will
