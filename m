Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0CE39F6D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 14:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhFHMhK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 08:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232299AbhFHMhK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 08:37:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76D8661287;
        Tue,  8 Jun 2021 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623155717;
        bh=lwdEMXKgFqTlkSr7IAuLTjahUJnEjsEmeso5SigE+EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1dpSB8VCDGZO6vMLNJ7gFQSL3ip0u5W0q98wZMDQF7NdV/tlYB3d5ELQ8S0r/HN1U
         i84kLXEuntDYUcqGkMiWltpY2DQhLCXqYgMdXra4tlQ76fiB5NP9kI7XVhwhxn8Fhh
         ESkoXYjWgz8r3PMAXonf4EWA5OLc3xH2hh4QAWRU=
Date:   Tue, 8 Jun 2021 14:35:14 +0200
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
Message-ID: <YL9kApyE6FbG/hru@kroah.com>
References: <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com>
 <YL9Q2tKLZP6GKbHW@kroah.com>
 <8fa8b7fd-58ae-9467-138d-4ff4f32f68f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fa8b7fd-58ae-9467-138d-4ff4f32f68f7@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 08, 2021 at 03:06:48PM +0300, Andrey Semashev wrote:
> On 6/8/21 2:13 PM, Greg KH wrote:
> > On Tue, Jun 08, 2021 at 02:03:50PM +0300, Andrey Semashev wrote:
> > > On 6/8/21 4:25 AM, Nicholas Piggin wrote:
> > > > 
> > > > Are shared pthread mutexes using existing pthread APIs that are today
> > > > implemented okay with futex1 system call a good reason to constrain
> > > > futex2 I wonder? Or do we have an opportunity to make a bigger change
> > > > to the API so it suffers less from non deterministic latency (for
> > > > example)?
> > > 
> > > If futex2 is not able to cover futex1 use cases then it cannot be viewed as
> > > a replacement. In the long term this means futex1 cannot be deprecated and
> > > has to be maintained. My impression was that futex1 was basically
> > > unmaintainable(*) and futex2 was an evolution of futex1 so that users of
> > > futex1 could migrate relatively easily and futex1 eventually removed. Maybe
> > > my impression was wrong, but I would like to see futex2 as a replacement and
> > > extension of futex1, so the latter can be deprecated at some point.
> > 
> > You can never delete a kernel system call, so even if you "deprecate"
> > it, it still needs to be supported for forever.
> 
> If I'm not mistaken, some syscalls were dropped from kernel in the past,
> after it was established they are no longer used. So it is not impossible,
> though might be more difficult specifically with futex.
> 
> > Best of all would be if internally your "futex2" code would replace the
> > "futex1" code so that there is no two different code bases.  That would
> > be the only sane way forward, having 2 code bases to work with is just
> > insane.
> 
> Yes, implementing futex1 in terms of futex2 internally is a possible way
> forward. Though I'm not sure it is reasonable to require that to be done in
> the initial futex2 submission. This requires all of the futex1 functionality
> to implemented in futex2 from the start, which I think is too much to ask.
> Even with some futex1 features missing, futex2 would be already very much
> useful to users, and it is easier to implement the missing bits
> incrementally over time.

Then do it the other way around, as Peter points out.

> > So what's keeping the futex2 code from doing all that futex1 does so
> > that the futex1 code can be deleted internally?
> 
> I think, André will answer this, but my guess is, as stated above, this is a
> lot of work and time while the intermediate version is already useful.

useful to who?  I still do not understand what users will be needing
this.  All I can tell is a single userspace program wants to use it, and
that is a fork from the real project it was based on and that the
maintainers have no plan to merge it back.

So who does need/want this?

thanks,

greg k-h
