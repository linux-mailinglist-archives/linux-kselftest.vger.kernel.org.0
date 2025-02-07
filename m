Return-Path: <linux-kselftest+bounces-26055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00017A2D04A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 23:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB223A67C2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 22:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A829E1B3953;
	Fri,  7 Feb 2025 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NeB1uvDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958242069
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738966022; cv=none; b=F28pTX6pBC/uhs3uJCIHGsqzZi/eWLSE1iWwap1FOK1V+MXlHLlmtfFQp0HcexLB52u30qp0z5wsYGbrGd58fKsqLPfZi7jR+oABAPgx5k1X+115jIcVGv09leB6tTH+hVC/yvNd/+hSDWV0NR68yeG38chd+Nt6/nu1/t1GQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738966022; c=relaxed/simple;
	bh=zVjyVpEwahYgt3SEF0BgSMZY7oAQhqvSjkG1s2m/zvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVWFc4VnRLrquycjCwWpnFSXO9rDmhn+8MFA2Yvj0i8sAbPEqqgt2hwfGrB9pBejNjh2MrnAX58ql2fABXrJrjLmzM5NPvfn+tA97qzq+tM8V44pcMxfc7SNDzryebd8h3fiLla3nUnGP5wsdQYGptAyz1DIqZJyE9tNlIpgkLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NeB1uvDI; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Feb 2025 17:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738966018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kCM+5H3mX9pSirMl0feWfw9v8RFmV75dHq/4txr4p0c=;
	b=NeB1uvDIy3b0lXnzR/i3FaYO4aB6DZ1oyp/Fsgc9ANUai+2Lke4i6JaoxSUQPQbyqaM+FS
	4zbr2m/pCMwhjDqTCj79PQN8h+3HbWILbhzA6eExjRfCktX4P7z+NRmlKsdW1pse9IktBk
	I5YFLcSMm+n0MH5H1RmT064JhCcMeDY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/21] bcachefs: eytzinger code
Message-ID: <obey3ik72ztzv27ghxr3xg63v76rlzibfzdp2yad3mmm7hyirh@n7xjjk3pyt7h>
References: <20250128163859.1883260-1-agruenba@redhat.com>
 <yoxmbxirfwr6tpl4lp3jnnb26ef3omhjna5b7p4d6522xvmnco@3eajr5hkfmhp>
 <CAHc6FU5DDKga1ma72Dnvsj23DLJ3GyMd-CM0qx83EKhvo5p2ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU5DDKga1ma72Dnvsj23DLJ3GyMd-CM0qx83EKhvo5p2ow@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 07, 2025 at 10:50:05PM +0100, Andreas Gruenbacher wrote:
> On Fri, Feb 7, 2025 at 7:56 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > On Tue, Jan 28, 2025 at 05:38:37PM +0100, Andreas Gruenbacher wrote:
> > > Kent, to continue our discussion from last November, I've gone through
> > > more parts of the eytzinger code and as a result, here are some patches
> > > for you to consider.
> > >
> > > What I've not looked at are the eytzinger_to_inorder and
> > > inorder_to_eytzinger functions, as well as the implementation of sort.
> > > Those functions could use a bit more documentation, but the code iself
> > > looks reasonable.
> > >
> > >
> > > Shuah, I've also had a quick look at converting the tests into kernel
> > > selftests, but that hasn't gone very far because of the lack of support
> > > for basic functions like __fls(), __ffs(), ffz(), and
> > > rounddown_pow_of_two() in selftests.  Are there any plans for making
> > > those kinds of primitives generally available to selftests?
> >
> > Ping on this patchset - can you throw up a git repo that's ready to be
> > applied directly, and have you run the test that failed yourself to
> > confirm the fix?
> 
> Did you miss this message?
> 
>   https://lore.kernel.org/linux-bcachefs/20250130103400.1899121-1-agruenba@redhat.com/

No, I saw it.

I'm looking for a branch that is ready to be applied as is - fixups in
the correct place, no debug patches.

That way there's no confusion over exactly what is going in, and we
elimanate a lot of the back and forth.

> 
> The test results at:
> 
>   https://evilpiepirate.org/~testdashboard/ci?user=kmo&branch=eytzinger
> 
> are still for the initial version, but I've applied the fix right away:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/agruen/linux.git/log/?h=bcachefs

I shall point my CI at that...

> On top of that, I've got a small patch that adds eytzinger0_find self
> tests. That patch still needs testing before I can post it, though.
> 
> Oh, and let me warn you about "bcachefs: Run the eytzinger tests on
> modprobe" again: this really is FOR DEBUGGING ONLY, so please do not
> merge.

Why is that in the branch? You ran the eytzinger tests, and that's for
code that's self contained that I'm not concerned about running it
myself (and if I did, then we'd be following up on getting it working
with kunit now...)

If you want to leave it in the branch as an informational thing ("yes
these tests were run and here's how"), it should be at the top, not the
bottom, so that when I take it out I still have a subset that's an exact
match (to the sha1) of something you've been working with and testing.

