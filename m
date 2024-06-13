Return-Path: <linux-kselftest+bounces-11862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A56F907549
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9C01F22515
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B8B145A02;
	Thu, 13 Jun 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHXYhS3F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DA1DFFC;
	Thu, 13 Jun 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289407; cv=none; b=sOycGs2p6UUVOLqiRqBYJ6UjQ+83cbSCB8+RF0gek9jyesfca4j9lAy9kAJJQHygeOu76YNWZX8nPY0nvsN2VZIaEmGXValkY0JFUa/L9h5XOhN7X5+i/P0ps772biquShBSV4s+sytO9jE/51Nnlc5OsR1JpGoJtD9SVNHWqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289407; c=relaxed/simple;
	bh=rQcVPloL/Qc1hVR24fDLFbTfgfjeOTVGfBNjrvJqCKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKXB4l/aIqwMnnQ8YQ3vlGT6Mukiv+6nquQA+vEo2afdtMBzvauHXhlB9LYWQBgDs5IHjSJgPANGUyEixNrJX9WdigQy/M6l6CsBridYJjeAAkkR3Jk79MmLcg3mLa2pFX40kms3zQzBnxlxMUOflgmEW+Rg1DrHRwsVVfwX9kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHXYhS3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FE7C32786;
	Thu, 13 Jun 2024 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289407;
	bh=rQcVPloL/Qc1hVR24fDLFbTfgfjeOTVGfBNjrvJqCKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHXYhS3FyCg5LtOYUzUGQo269no97821yMFOzr5aoyMK5ag4u+Bo1AEMSPa5nmZmQ
	 /z9H8kgfXctKvahUS760ZjpZ+IwyGTma5OACP9bxYqIi9DbejHs4vIU8UHtZRe1QoI
	 tpu+04e+hBOuPqDX2xnqkKgw34Pr/+16i3R2d9FLly8qJrJkT/Ky7L/cI48MVLNc4h
	 lTx/6GIN+5/7GZmI37lEUxT/4DRtBtLXz8zbsGgabSZxEWU7610Ge69hGto9raY6uS
	 a9ajo23fKqksXsoifnMLYh8TAu0Peoc6pj7e5/JG6cEWJ8ODsVOl2NcRiLzwMyx43q
	 hz1MLElRsZvHw==
Date: Thu, 13 Jun 2024 08:36:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, paulmck@kernel.org,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>

On Thu, Jun 13, 2024 at 07:11:52PM +0530, Nilay Shroff wrote:
> On 6/13/24 18:26, Keith Busch wrote:
> > But that's not the problem for the rcu case. It's the last line that's
> > the problem:
> > 
> >  	list->prev->next = list;
> > 
> > We can't change forward pointers for any element being detached from
> > @head because a reader iterating the list may see that new pointer value
> > and end up in the wrong list, breaking iteration. A synchronize rcu
> > needs to happen before forward pointers can be mucked with, so it still
> > needs to be done in two steps. Oh bother...
> 
> Agree and probably we may break it down using this API:
> static inline void list_cut_rcu(struct list_head *list,
>  		struct list_head *head, struct list_head *entry, 
> 		void (*sync)(void))
> {
>  	list->next = entry;
>  	list->prev = head->prev;
> 	__list_del(entry->prev, head);
> 	sync();
>  	entry->prev = list;
>  	list->prev->next = list;
> }

Yes, that's the pattern, but I think we need an _srcu() variant: the
"sync" callback needs to know the srcu_struct.

