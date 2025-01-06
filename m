Return-Path: <linux-kselftest+bounces-23965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2854A031C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 22:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573BF7A1627
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50391DFE30;
	Mon,  6 Jan 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fq4DTnKX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFDC1DF99C
	for <linux-kselftest@vger.kernel.org>; Mon,  6 Jan 2025 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736197435; cv=none; b=l7su5ItXmgDdKx3uAlhgKlknAbV0BRmLSUASpHwFDsDEmxSFmfwqqQ5yLKmyQWyr7l6HfMsCUqYphelIIcxvyUVTBJMv/dc9Eq8Y9wnuoTNU1Mc+OuccJhRh09xzQY2naJ5dEJeSBJESMBQaMwVWWGeRlgwrJJfpVGccr5wxzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736197435; c=relaxed/simple;
	bh=A0EwU2KWDIQTM0ZylrNtw28mmoAfhrr8ZveR8K5KjbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE+a1ckoE3n8FQOnf+D3kkKhJM0QIoDufNWeIrf0nCI0ZcuPnzA0COJOKIpR4Nyofvd77daxaoykObIrUZ6GO+APxMCN+NLbPDJeN838rNMQvNNEiaPZRXh0sJighsXQI0Xaf2TjzRxjZh0MSbpAmA4Aj5i/C5dpq8uwCTFlOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fq4DTnKX; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 Jan 2025 13:03:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736197416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2XnxA8bBrbeEfZhjJa7nYBpTgQjLSeAqkIA9Z+SmJUI=;
	b=fq4DTnKXE18xy2+YLZLT1tL53b3p56K2VG9eCm6dnhl22ODMaVmiL9CM8DdDXaN2KGy6Gx
	136B0G+QS8CW0qincZlNX7t4UZH601umFUZLFCBWzbQbjYB+UtFK3YO1cxy72D1Gle05Iz
	VIBQyyA9Xh0SDZLCazXk+KM0i+bfBCo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <wvwahrb5yxd4dzfy6an7dpefiswtbc5uutckltbtx5p7hv4pxg@4n6tds6cmjx3>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
 <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>
 <20241028-gesoffen-drehmoment-5314faba9731@brauner>
 <c96df57a-fa1b-4301-9556-94a6b8c93a31@lucifer.local>
 <b8f4664c-b8f0-46ca-b9a3-8d73e398b5ca@lucifer.local>
 <55764300-1b53-4d14-99cc-e735d3704713@lucifer.local>
 <fbcea328-9545-4f3e-9f99-2e2057ce32df@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcea328-9545-4f3e-9f99-2e2057ce32df@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 02, 2024 at 10:52:13AM +0000, Lorenzo Stoakes wrote:
> On Fri, Nov 08, 2024 at 02:28:14PM +0000, Lorenzo Stoakes wrote:
> > On Wed, Oct 30, 2024 at 04:37:37PM +0000, Lorenzo Stoakes wrote:
> > > On Mon, Oct 28, 2024 at 04:06:07PM +0000, Lorenzo Stoakes wrote:
> > > > I guess I'll try to adapt that and respin a v7 when I get a chance.
> > >
> > > Hm looking at this draft patch, it seems like a total rework of pidfd's
> > > across the board right (now all pidfd's will need to be converted to
> > > pid_fd)? Correct me if I'm wrong.
> > >
> > > If only for the signal case, it seems like overkill to define a whole
> > > pid_fd and to use this CLASS() wrapper just for this one instance.
> > >
> > > If the intent is to convert _all_ pidfd's to use this type, it feels really
> > > out of scope for this series and I think we'd probably instead want to go
> > > off and do that as a separate series and put this on hold until that is
> > > done.
> > >
> > > If instead you mean that we ought to do something like this just for the
> > > signal case, it feels like it'd be quite a bit of extra abstraction just
> > > used in this one case but nowhere else, I think if you did an abstraction
> > > like this it would _have_ to be across the board right?
> > >
> > > I agree that the issue is with this one signal case that pins only the fd
> > > (rather than this pid) where this 'pinning' doesn't _necessary_ mess around
> > > with reference counts.
> > >
> > > So we definitely must address this, but the issue you had with the first
> > > approach was that I think (correct me if I'm wrong) I was passing a pointer
> > > to a struct fd which is not permitted right?
> > >
> > > Could we pass the struct fd by value to avoid this? I think we'd have to
> > > unfortunately special-case this and probably duplicate some code which is a
> > > pity as I liked the idea of abstracting everything to one place, but we can
> > > obviously do that.
> > >
> > > So I guess to TL;DR it, the options are:
> > >
> > > 1. Implement pid_fd everywhere, in which case I will leave off on
> > >    this series and I guess, if I have time I could look at trying to
> > >    implement that or perhaps you'd prefer to?
> > >
> > > 2. We are good for the sake of this series to special-case a pidfd_to_pid()
> > >    implementation (used only by the pidfd_send_signal() syscall)
> > >
> > > 3. Something else, or I am misunderstanding your point :)
> > >
> > > Let me know how you want me to proceed on this as we're at v6 already and I
> > > want to be _really_ sure I'm doing what you want here.
> > >
> > > Thanks!
> >
> > Hi Christian,
> >
> > Just a gentle nudge on this - as I need some guidance in order to know how
> > to move the series forwards.
> >
> > Obviously no rush if your workload is high at the moment as this is pretty
> > low priority, but just in case you missed it :)
> >
> > Thanks, Lorenzo
> 
> Hi Christian,
> 
> Just a ping on this now we're past the merge window and it's been over a
> month.
> 
> It'd be good to at least get a polite ack to indicate you're aware even if
> you don't have the time to respond right now.
> 
> If you'd prefer this series not to go ahead just let me know, but
> unfortunately I really require your input to know how to move forward
> otherwise I risk doing work that you might then reject.
> 

Hey Lorenzo & Christian, what's the latest here? I see Christian has
code suggestions at [1] which just needs to be addressed. Any thing
else? I am hoping we can get this merged in the coming open window.

[1] https://lore.kernel.org/linux-mm/20241202-wahrnehmen-mitten-e330cbd1eaf0@brauner/

