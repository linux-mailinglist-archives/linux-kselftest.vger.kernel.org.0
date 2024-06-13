Return-Path: <linux-kselftest+bounces-11853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DBC9072F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EACCA2847C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78988139CFE;
	Thu, 13 Jun 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQR+v4m7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0B17FD;
	Thu, 13 Jun 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283382; cv=none; b=XCPTmy9x0beN/8cvyPx4FAA2ov/mmD2NX6oWoNIMcWEfVku2H3X2dZ0WWzB82CV849kNToM8KXiWzrDPNJ5pFRkfzJXidw8nFGhO7GMBcn/8wIKV9gfcE+LRiqFvkBhz5+JPYZWJK95sdthlVtMT4yBoFMDnO7T/N7SeKlMR7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283382; c=relaxed/simple;
	bh=bsPL3KQAP7mYRKsmkdNID7B/zfeUGn2fmiXDfN/6S7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtTNywKuKwlGSFsTmPNz8vhR2J2oN7VB07ESEavDu5hErF2FECDjBIgZOFLg8k5Pn5bELIKQoeY2bAytfaVxqI2T46zK2bhw+Z11CWJcz3WlpTTKO4rtBCbT/6n0zNj6u1QxjldDRmCW3Sc1cwheoj/9f+vEGSzmcXz2R75Mk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQR+v4m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A45C2BBFC;
	Thu, 13 Jun 2024 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718283382;
	bh=bsPL3KQAP7mYRKsmkdNID7B/zfeUGn2fmiXDfN/6S7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQR+v4m7I9qXfqIZYmNf1l+zzpKYSFwfe105O2wE+UmX6I3Vljl8g6q1yaIjTa09Q
	 lHyY4re5v2wpkOQG6WWRVtMp/+g/7Frk4vwd5nFbgnzdnJZt39ILbiBwOyrN8XDIda
	 FPA4G8/3RTGOB8msLFSwiz5nAtnyKQqsQ8Blr/jrY+BIbtZKBNw/THboHlUc0yTWbs
	 sPvIgDFqmrKpDNkdbByQVHobIdVlz75IJ0FNpA8N8dOkTxenlEC3WjAayWMN2aTcFN
	 8Hm0w925eJ9g/SMIwsctjlSeFt0d1145cW4mey1+qqyqNgBGxYudQ1SzTMOAelx90c
	 rOqSpg33Llnjg==
Date: Thu, 13 Jun 2024 06:56:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, paulmck@kernel.org,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmrscxG51gFRDVlM@kbusch-mbp>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>

On Thu, Jun 13, 2024 at 10:26:11AM +0530, Nilay Shroff wrote:
> On 6/12/24 21:21, Keith Busch wrote:
> > +static inline void list_cut(struct list_head *list,
> > +		struct list_head *head, struct list_head *entry)
> > +{
> > +	list->next = entry;
> > +	list->prev = head->prev;
> > +	head->prev = entry->prev;
> > +	entry->prev->next = head;
> > +	entry->prev = list;
> > +	list->prev->next = list;
> > +}
> I am wondering whether we really need the _rcu version of list_cut here?
> I think that @head could point to an _rcu protected list and that's true 
> for this patch. So there might be concurrent readers accessing @head using
> _rcu list-traversal primitives, such as list_for_each_entry_rcu().
> 
> An _rcu version of list_cut():
> 
> static inline void list_cut_rcu(struct list_head *list,
> 		struct list_head *head, struct list_head *entry)
> {
> 	list->next = entry;
> 	list->prev = head->prev;
> 	head->prev = entry->prev;
> 	rcu_assign_pointer(list_next_rcu(entry->prev), head);
> 	entry->prev = list;
> 	list->prev->next = list;
> }

I was initially thinking similiar, but this is really just doing a
"list_del", and the rcu version calls the same generic __list_del()
helper. To make this more clear, we could change

	head->prev = entry->prev;
	entry->prev->next = head;

To just this:

	__list_del(entry->prev, head);

And that also gets the "WRITE_ONCE" usage right.

But that's not the problem for the rcu case. It's the last line that's
the problem:

 	list->prev->next = list;

We can't change forward pointers for any element being detached from
@head because a reader iterating the list may see that new pointer value
and end up in the wrong list, breaking iteration. A synchronize rcu
needs to happen before forward pointers can be mucked with, so it still
needs to be done in two steps. Oh bother...

