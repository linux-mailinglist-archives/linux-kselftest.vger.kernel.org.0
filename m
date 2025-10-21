Return-Path: <linux-kselftest+bounces-43670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3AEBF7C6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 18:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C529C425462
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067483446C7;
	Tue, 21 Oct 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gsG/gyUz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FCE235360;
	Tue, 21 Oct 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065208; cv=none; b=j+R7zWUBF3IDZJ+RRHD8W1XuyuiDsem6xjAojxKFLxmRFd4M379s1b3szuW0/Cn5tKFE1ElBeNZHSUacznBZ78kfw1Wx0TPuM58F9e+1ioYHIDtWMfteltrTALOv+fOLhMyx7YGgFIWlOWLSogPmOgSIJlTbIzsIYmFZFPAwiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065208; c=relaxed/simple;
	bh=arHrvou9uQqGbHOB/p6IMtkA2TNGKttCri6QEWXzjxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTB8RfSNOqbqhxjhre52mK5R4qwigxTmyC7syXXOb2LQSFOo9HHbDXM0hBl5tAXeLZgrJUL1xVxJL7MUUIeZwYM5ue1hIP+DXaGZmlNy7aeSDA2PyqR4bUqRL2VykcS1C1WN2i5nGFzx2GwoMWaU6j+O+wmKkpKJQMFDtqcuFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gsG/gyUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3D6C4CEF1;
	Tue, 21 Oct 2025 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761065208;
	bh=arHrvou9uQqGbHOB/p6IMtkA2TNGKttCri6QEWXzjxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsG/gyUzuDKYqVOuHlctFQ/BUjwTW8253Q/OoKIbt8mKs/yJaITjMj3rQBa+JAdBX
	 LVtTd8QQm91N5li/9P0LkppGSfZPs5ib5VMM+6C4hFggchYFS9xviUSlWZgEt6KWtm
	 mkaP3Qaoi7DjgfO5kNC5Z8otPquVU9IvBZcuvBbg=
Date: Tue, 21 Oct 2025 18:46:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	safety-architecture@lists.elisa.tech, acarmina@redhat.com,
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Subject: Re: [RFC PATCH v2 0/3] Add testable code specifications
Message-ID: <2025102124-punctuate-kilogram-da50@gregkh>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
 <2025102111-facility-dismay-322e@gregkh>
 <CA+wEVJZEho_9kvaGYstc=5f6iHGi69x=_0zT+jrC2EqSFUQMWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+wEVJZEho_9kvaGYstc=5f6iHGi69x=_0zT+jrC2EqSFUQMWQ@mail.gmail.com>

On Tue, Oct 21, 2025 at 11:42:24AM +0200, Gabriele Paoloni wrote:
> Hi Greg
> 
> On Tue, Oct 21, 2025 at 9:35 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 10, 2025 at 06:59:57PM +0200, Gabriele Paoloni wrote:
> > > [1] was an initial proposal defining testable code specifications for
> > > some functions in /drivers/char/mem.c.
> > > However a Guideline to write such specifications was missing and test
> > > cases tracing to such specifications were missing.
> > > This patchset represents a next step and is organised as follows:
> > > - patch 1/3 contains the Guideline for writing code specifications
> > > - patch 2/3 contains examples of code specfications defined for some
> > >   functions of drivers/char/mem.c
> > > - patch 3/3 contains examples of selftests that map to some code
> > >   specifications of patch 2/3
> > >
> > > [1] https://lore.kernel.org/all/20250821170419.70668-1-gpaoloni@redhat.com/
> >
> > "RFC" implies there is a request.  I don't see that here, am I missing
> > that?  Or is this "good to go" and want us to seriously consider
> > accepting this?
> 
> I assumed that an RFC (as in request for comments) that comes with proposed
> changes to upstream files would be interpreted as a request for feedbacks
> associated with the proposed changes (what is wrong or what is missing);
> next time I will communicate the request explicitly.
> 
> WRT this specific patchset, the intent is to introduce formalism in specifying
> code behavior (so that the same formalism can also be used to write and
> review test cases), so my high level asks would be:
> 
> 1) In the first part of patch 1/3 we explain why we are doing this and the high
> level goals. Do you agree with these? Are these clear?

No, and no.

I think this type of thing is, sadly, folly.  You are entering into a
path that never ends with no clear goal that you are conveying here to
us.

I might be totally wrong, but I fail to see what you want to have happen
in the end.

Every in-kernel api documented in a "formal" way like this?  Or a
subset?  If a subset, which ones specifically?  How many?  And who is
going to do that?  And who is going to maintain it?  And most
importantly, why is it needed at all?

For some reason Linux has succeeded in pretty much every place an
operating system is needed for cpus that it can run on (zephyr for those
others that it can not.)  So why are we suddenly now, after many
decades, requiring basic user/kernel stuff to be formally documented
like this?

In the past, when we have had "validating bodies" ask for stuff like
this, the solution is to provide it in a big thick book, outside of the
kernel, by the company that wishes to sell such a product to that
organization to justify the cost of doing that labor.  In every instance
that I know of, that book sits on a shelf and gathers dust, while Linux
is just updated over the years in those sites to new versions and the
book goes quickly out of date as no one really cares about it, except
it having been a check-box for a purchase order requirement.

That's business craziness, no need to get us involved in all of that.
Heck, look at the stuff around FIPS certification for more insanity.
That's a check-box that is required by organizations and then totally
ignored and never actually run at all by the user.  I feel this is much
the same.

So step back, and tell us exactly what files and functions and apis are
needed to be documented in this stilted and formal way, who exactly is
going to be doing all of that work, and why we should even consider
reviewing and accepting and most importantly, maintaining such a thing
for the next 40+ years.

> 2) In the rest of the patchset we introduce the formalism, we propose some
> specs (in patch 2) and associated selftests (in patch 3). Please let us know
> if there is something wrong, missing or to be improved.

I made many comments on patch 3, the most important one being that the
tests created do not seem to follow any of the standards we have for
Linux kernel tests for no documented reason.

The irony of submitting tests for formal specifications that do not
follow documented policies is rich :)

thanks,

greg k-h

