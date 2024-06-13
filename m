Return-Path: <linux-kselftest+bounces-11872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F6F90775A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669121F24C35
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7807E145B03;
	Thu, 13 Jun 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1Tc42C7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACB14198E;
	Thu, 13 Jun 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293239; cv=none; b=f3TL4fXryraOuL6KTWmTKULOIYWevkiESLGzk3QbHJO1RBV+wzbxUgCxvEZdRyBHjm2p/vuMrZbvgeuiFIcIUxHzgckqbLgDgh+3F5bcuIgju83wxuFYgNz9UbJWLDP2SLrp+4x+Athg5GVEF/6jN3HgItAGdwXmqKk6Jh+Ei6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293239; c=relaxed/simple;
	bh=PaVcqWpzvUVb5bqFarvjMoq1WONE9j8JGCxJ79pc1j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkkK48Wzu1jSR2tU2d4gTYkgKD6ecU7WvN20sGjVX0sBsPSyIrsOPixF5xd+XTOKw3nCBpDUotVDVppHYKwfbpd8yAsSQ4KGgr4taxHyNWgktF6GbkJQDqjJDyFQ1J8KjNT5gi+Y5HS6RoCGb9FmMR2oMDUFw6+KQPiPb92lymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1Tc42C7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2ACC2BBFC;
	Thu, 13 Jun 2024 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718293239;
	bh=PaVcqWpzvUVb5bqFarvjMoq1WONE9j8JGCxJ79pc1j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1Tc42C70PM77KeC0itgIgTLjOly/BlSkyGjkgHZHFYCKI/XleSPPMsbsc53JkgBc
	 gFVFVfIXHn6b0wnq7+Z6WNswwTGWLg05CFq5RxqmRNFA6jlk6WVJvOZMsIFrDokS2B
	 Qg1+G9RgdyV/Tvm0OpiQbPYVypQOlb0yis5h29aAh0fjEv4xuczCppnM/MSbXZPZ8K
	 BLlMNn94XsGg6Qn03ZwvuRyZpuhUY60N1THTSv/nS+EeYAS3TN9MTpiXneeQ+iV0/X
	 Dltc5nPohmh4VXUTkf+qFuKQl/D5cDzHd12SyfufnnHx56duXSF1g9q/y8GRAPKvAE
	 wKjzpbeL/F0lQ==
Date: Thu, 13 Jun 2024 09:40:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, davidgow@google.com,
	akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmsS9DZWl8TccvKz@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
 <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
 <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>

On Thu, Jun 13, 2024 at 08:15:06AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 13, 2024 at 08:47:26AM -0600, Keith Busch wrote:
> > > 
> > > Just make a helper function like this:
> > > 
> > > 	static void my_synchronize_srcu(void)
> > > 	{
> > > 		synchronize_srcu(&my_srcu_struct);
> > > 	}
> > > 
> > > Or am I missing something subtle here?
> > 
> > That would work if we had a global srcu, but the intended usage
> > dynamically allocates one per device the driver is attached to, so a
> > void callback doesn't know which one to sync.
> 
> Ah, good point!  I suppose that a further suggestion to just JIT the
> needed function would not be well-received?  ;-)
> 
> I cannot resist suggesting placing a pointer to the srcu_struct in
> the task structure.  /me runs...
> 
> Perhaps somewhat more constructively, my usual question:  Is it really
> necessary to have per-driver SRCU here?  What would break if there was
> a global srcu_struct that applied to all drivers?

There's not a strict need for srcu_struct to be per device that I know
of. It was just done this way to keep usage localized to the parts that
need to be protected. The fear being that one device's long running
reader could prevent another device from quickly tearing down.

