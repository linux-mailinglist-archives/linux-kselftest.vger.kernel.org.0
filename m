Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12739F7D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhFHN3n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 09:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233025AbhFHN3m (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 09:29:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBA3E61009;
        Tue,  8 Jun 2021 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623158855;
        bh=D+lp5Yp4s5pc/+bwbwvj8F8yRt2z7XluZm2R3r9rwME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I4xnn7D6nO1wKo/fcg4fYE7aKLZskLjgMWj8e6jI0ieF+m3eIIHqCO5Ya2Nk0cGFj
         JNGktwLoKyEit5X+ZPkfGlWItX7AMCktx4v45UkoNeMv63QETKcX/U3LLdKS9yOPbo
         YzUVGGE/Ublh+2NN8Oh7QZJCXFTGsP/neYQXLBj0=
Date:   Tue, 8 Jun 2021 15:27:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrey Semashev <andrey.semashev@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        acme@kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        corbet@lwn.net, Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>, fweimer@redhat.com,
        joel@joelfernandes.org, kernel@collabora.com,
        krisman@collabora.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, malteskarupke@fastmail.fm,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        pgriffais@valvesoftware.com, Peter Oskolkov <posk@posk.io>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, z.figura12@gmail.com
Subject: Re: [PATCH v4 00/15] Add futex2 syscalls
Message-ID: <YL9wROdz4y/pETA1@kroah.com>
References: <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com>
 <YL9Q2tKLZP6GKbHW@kroah.com>
 <8fa8b7fd-58ae-9467-138d-4ff4f32f68f7@gmail.com>
 <YL9kApyE6FbG/hru@kroah.com>
 <3fca0afa-d9db-a176-aad1-ff7db21ba4a2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fca0afa-d9db-a176-aad1-ff7db21ba4a2@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 08, 2021 at 04:18:42PM +0300, Andrey Semashev wrote:
> On 6/8/21 3:35 PM, Greg KH wrote:
> > On Tue, Jun 08, 2021 at 03:06:48PM +0300, Andrey Semashev wrote:
> > > On 6/8/21 2:13 PM, Greg KH wrote:
> > 
> > > > So what's keeping the futex2 code from doing all that futex1 does so
> > > > that the futex1 code can be deleted internally?
> > > 
> > > I think, André will answer this, but my guess is, as stated above, this is a
> > > lot of work and time while the intermediate version is already useful.
> > 
> > useful to who?  I still do not understand what users will be needing
> > this.  All I can tell is a single userspace program wants to use it, and
> > that is a fork from the real project it was based on and that the
> > maintainers have no plan to merge it back.
> > 
> > So who does need/want this?
> 
> I mentioned C++ std::atomic and Boost.Atomic before. Those need variable
> sized futexes.

And has anyone converted them to use this new api to see if it works
well or not?

As was pointed out to me numerous times when I tried to propose
readfile(), you need a real user that can show and prove it is needed
before we can take new syscalls, especially complex beasts like this
one.

thanks,

greg k-h
