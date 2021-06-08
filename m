Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7039F4B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 13:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFHLPi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 07:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFHLPi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 07:15:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE7EB6128A;
        Tue,  8 Jun 2021 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623150813;
        bh=A6VpHR3oddi2suLec2a8UbPlr39nefG0fVnTuz2uXk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljZwGPKFpGidXrQDPvcVbFHoOwEk2DUTv7muK0IHXxDKQYGLKwd7RPQJs9wr+mjc2
         NWc5SRe+en635+znruA9DOqveNp01teR7cqN/b5kfsVOVylrO+53HQiFqvTYlycCxg
         xi8YK42QXjUzf2KWpwEx97q0gVod1ATu1XT0nC8c=
Date:   Tue, 8 Jun 2021 13:13:30 +0200
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
Message-ID: <YL9Q2tKLZP6GKbHW@kroah.com>
References: <20210603195924.361327-1-andrealmeid@collabora.com>
 <1622799088.hsuspipe84.astroid@bobo.none>
 <fb85fb20-5421-b095-e68b-955afa105467@collabora.com>
 <1622853816.mokf23xgnt.astroid@bobo.none>
 <6d8e3bb4-0cef-b991-9a16-1f03d10f131d@gmail.com>
 <1622980258.cfsuodze38.astroid@bobo.none>
 <c6d86db8-4f63-6c57-9a67-6268da266afe@gmail.com>
 <1623114630.pc8fq7r5y9.astroid@bobo.none>
 <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3488d1b-a4ff-8791-d960-a5f7ae2ea8b3@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 08, 2021 at 02:03:50PM +0300, Andrey Semashev wrote:
> On 6/8/21 4:25 AM, Nicholas Piggin wrote:
> > 
> > Are shared pthread mutexes using existing pthread APIs that are today
> > implemented okay with futex1 system call a good reason to constrain
> > futex2 I wonder? Or do we have an opportunity to make a bigger change
> > to the API so it suffers less from non deterministic latency (for
> > example)?
> 
> If futex2 is not able to cover futex1 use cases then it cannot be viewed as
> a replacement. In the long term this means futex1 cannot be deprecated and
> has to be maintained. My impression was that futex1 was basically
> unmaintainable(*) and futex2 was an evolution of futex1 so that users of
> futex1 could migrate relatively easily and futex1 eventually removed. Maybe
> my impression was wrong, but I would like to see futex2 as a replacement and
> extension of futex1, so the latter can be deprecated at some point.

You can never delete a kernel system call, so even if you "deprecate"
it, it still needs to be supported for forever.

Best of all would be if internally your "futex2" code would replace the
"futex1" code so that there is no two different code bases.  That would
be the only sane way forward, having 2 code bases to work with is just
insane.

> (*) I use "unmaintainable" in a broad sense here. It exists and works in
> newer kernel versions and may receive code changes that are necessary to
> keep it working, but maintainers refuse any extensions or modifications of
> the code, mostly because of its complexity.

Adding additional complexity for no good reason is not a good idea,
especially if you are asking others to maintain and support that
complexity.  Would you want to have to do that work?

So what's keeping the futex2 code from doing all that futex1 does so
that the futex1 code can be deleted internally?

thanks,

greg k-h
