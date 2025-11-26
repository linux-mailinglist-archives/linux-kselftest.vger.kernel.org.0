Return-Path: <linux-kselftest+bounces-46502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1FC8A1BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 14:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E36E4E12E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0E326941;
	Wed, 26 Nov 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xH23ha1j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6D239E9D;
	Wed, 26 Nov 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764165315; cv=none; b=St/SJ97jm8FATSY3+fWeb9GNzFpsGi5+KqgtZC7dFbsqAMRJPSinkk1OKRoo94hA/7jgL8OOMgWEr64EQ/SS5lgh8AEuu3PTca8PO+OfDxfZfl0EcY0t5RM7lZ3OHuvefyzvt5wb+8Ouy6ItSQ6vFdaBWJZYmKvUuwh0yrlodfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764165315; c=relaxed/simple;
	bh=I+TScRoNbd7FG0IWAZIoQseK2RrdKsM+sqKB4TIxaG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eukuu/dwJygutEWvtlfOIqV4tQ5BYJ2nJO0Nb2Pj+tXVtfdEYDg0JxiuVl8aDwYe/dcc4gdreQkCyctANLQvwLs7v44CggUzVLSeNlDs/cmxIaA6qwv03ryFKOl4D8eCH/eOGCl1jIswjwvw1o1W22jiS1KulizJXONqPpDpcbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xH23ha1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09007C4CEF8;
	Wed, 26 Nov 2025 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764165314;
	bh=I+TScRoNbd7FG0IWAZIoQseK2RrdKsM+sqKB4TIxaG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xH23ha1jcoyROXLVBmErwbr+/N2i2YI6GVuUy3wBhbAdyhXBCHLcM44Vu6hXi7erD
	 vPi3ytkvLOx4YZXX3G65ghF9qx9e/Zt/CVoI5m1V2hSFGdHcP3ooibTzWvTpnNTp+t
	 7iHZZpHoKQ6XoGJP5QA6NT1+BbnRGJBG+RycrZac=
Date: Wed, 26 Nov 2025 14:55:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org,
	safety-architecture@lists.elisa.tech, acarmina@redhat.com,
	kstewart@linuxfoundation.org, chuck@wolber.net
Subject: Re: [RFC PATCH v2 0/3] Add testable code specifications
Message-ID: <2025112631-repeated-crafty-207d@gregkh>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
 <2025102111-facility-dismay-322e@gregkh>
 <CA+wEVJZEho_9kvaGYstc=5f6iHGi69x=_0zT+jrC2EqSFUQMWQ@mail.gmail.com>
 <2025102124-punctuate-kilogram-da50@gregkh>
 <CA+wEVJajSGzb85YTiv98yAY3bcJFS0Qp_xjLc++wnU8t=wDAOg@mail.gmail.com>
 <2025102211-wolverine-cradling-b4ec@gregkh>
 <CAB=6tBSaGfKq4RgV=nbw28Yq59jHMrVOkm_dx2bqD1AjU37oaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=6tBSaGfKq4RgV=nbw28Yq59jHMrVOkm_dx2bqD1AjU37oaw@mail.gmail.com>

On Fri, Nov 07, 2025 at 04:29:13PM +0000, Chuck Wolber wrote:
> On Wed, Oct 22, 2025 at 5:13 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Oct 22, 2025 at 04:06:10PM +0200, Gabriele Paoloni wrote:
> > > > Every in-kernel api documented in a "formal" way like this?  Or a subset?
> > > > If a subset, which ones specifically?  How many?  And who is going to do
> > > > that?  And who is going to maintain it?  And most importantly, why is it
> > > > needed at all?
> 
> I appreciate the questions. I sense there may be some confusion over who this
> is intended to benefit.
> 
> The design of the Linux kernel is emergent. This is a fundamental property of
> the way it is developed, and the source of its greatest strength. But it has
> some shortcomings that place a burden on kernel maintainers, all kernel
> testing, and even people who wish to contribute.

What specific burden?  A lack of documentation?  Something else?  How
are we surviving without this "standardized" interface so far?  Are you
a maintainer that runs into this issue in the past?

> We intend this as a tool to address those areas.

What tool exactly?  And who is asking for this?

> > > > For some reason Linux has succeeded in pretty much every place an
> > > > operating system is needed for cpus that it can run on (zephyr for those
> > > > others that it can not.)  So why are we suddenly now, after many decades,
> > > > requiring basic user/kernel stuff to be formally documented like this?
> 
> You are correct, the kernel has succeeded over many decades, and will continue
> succeeding for many decades to come.
> 
> With the exception of some very narrow situations, the emergent design (or
> "nuanced complexity" if you prefer that term) of the Linux kernel is not
> communicated in a broadly consistent way. This affects the way the kernel is
> tested, and also the way it is developed. Even veteran kernel maintainers are
> tripping over nuance and complexity.

We all trip over nuance and complexity, but I do not belive that adding
more formal comments is going to solve that (hint, the proof is on
you...)

> > > Let me try to answer starting from the "why".
> >
> > Let's ignore the "why" for now, and get to the "how" and "what" which you
> > skipped from my questions above.
> >
> > _Exactly_ how many in-kernel functions are you claiming is needed to be
> > documented in this type of way before Linux would become "acceptable" to
> > these regulatory agencies, and which ones _specifically_ are they?
> 
> Exactly zero. This is not for regulators.

Great!  Then we don't have to do anything and you all can stop it with
the "we need this to pass certification reviews" nonsense.  :)

> > Without knowing that, we could argue about the format all day long, and
> > yet have nothing to show for it.
> 
> As this is not intended for regulators, it is not clear to me that catering to
> their desires would be a good use of anyone's time.

Agreed!

> > And then, I have to ask, exactly "who" is going to do that work.
> 
> The intent is to allow for a separate maintainer path. There is more to it than
> that, but I do not want to bury the lede here.

But that's the real issue.  We've seen loads of proposals in the past
that have gone no where as no one actually does the real work.

Heck, look at SPDX, that "simple" work isn't yet done because no one
actually funded it, they just "demanded" that we implement SPDX tags for
all files, and when the work got hard, everyone ran away.

What makes you believe that documenting something that is orders of
magnitude more complex than something as "simple" as SPDX is going to
actually happen to our codebase?

> > So, try to answer that, with lots and lots of specifics, and then, if we
> > agree that it is a sane thing to attempt (i.e. you are going to do all the
> > work and it actually would be possible to complete), then we can argue about
> > the format of the text :)
> 
> I respect what you are saying here, and perhaps the point of confusion came
> from the safety related source? As is often the case in science and
> engineering, we are borrowing (and _heavily_ modifying) a technique that is
> found in a different domain.
> 
> The intent is to target technical debt and maintainer burnout by filling in a
> semantic gap that occurs when a human idea is turned into code. Ironically,
> this is why the safety regulations were written in the first place, but little
> consideration was given to development methodology during that process.

So I don't see the real goal here.  You all for some reason want to
"formalize" a documentation process of all kernel apis internally, for
the sole reason of making developer's and maintainer's lives easier?

Again, who is actually going to do that work?  And if you are, great,
just start sending out patches today using the format that we already
have for kerneldoc and the like.  No need for formal language
requirements here as obviously no tool is going to be parsing this, nor
as you said, any regulator is going to be reading this.

So let's just stick with the style that we have already, no need to
change anything, just start sending documentation patches!

thanks,

greg k-h

