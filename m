Return-Path: <linux-kselftest+bounces-11873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0CD9077B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009591C24A02
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615AE12F5A5;
	Thu, 13 Jun 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWvGEL72"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FA12F5B8;
	Thu, 13 Jun 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294508; cv=none; b=eAzEvHYdeTMtJref3kyWY4h5ec2zET6pfegajit/+0n2rL0sqxN2bWfrKMRf1dWGJsMDWdE1OXyCwnO5J6AGfdx6Zh3cp8Ldr8KXrpReUm6StWY8Abde6FSEdKo7ElgmSjTo+SJLHYVYzQ6IJR0caCqOgp/dVueSeOvROC/Y8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294508; c=relaxed/simple;
	bh=LKy2D6arl+GpL0o3xCQY76R9veCG4oWlZUUz2h91SqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5+NmHeK1RrokD8hOdsPWSPwJM6QuXkhvXeYOPikCwuTSgHit1889ywXr0r2SXjQJY+lCgqAiVzXhUmu9M+Hr3TBqBGDN1fTDrUrRyikSG2fuJIhsBDXfRWylG+LsnpH4L9ZRI0KA6t9xvQyDofU1LqPONkgCg12NnL+Oc4ibA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWvGEL72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1B1C2BBFC;
	Thu, 13 Jun 2024 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718294507;
	bh=LKy2D6arl+GpL0o3xCQY76R9veCG4oWlZUUz2h91SqE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BWvGEL72ILqyPUF+a50b+MgblLneW9UZ4U+mwtAbphD3OOWIfcm8diwW/DyAGQRkT
	 HsOf6n1lx2Wu0+5s+1mYY1lvtMPqImxjd7Tug6v/R2J3dYlrZZ+8uRmhVes/imJVUk
	 i2LMzNDim98YcN8Vs8K4tb4cVb1E8N+sLWAjhH8aVM95ZI8rY9Tofc4A7fP08WmpNY
	 q0s5RYjGBiSVbdRq8CLCYwVcIGSS54T144xFSLCQsxPRoxsUixbJcf3TxqMKy2099g
	 JtNqYySXF+cBKKQRrgcUvDbESpqp3+MPjHATiyWTQg+DaeWpE6FhJcWxrJx+dsUJuN
	 O6vxSMW6Lgraw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 54042CE04D4; Thu, 13 Jun 2024 09:01:47 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:01:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, davidgow@google.com,
	akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <046f42c5-34b5-41a2-9680-5ef86ef25c01@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
 <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
 <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
 <ZmsS9DZWl8TccvKz@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsS9DZWl8TccvKz@kbusch-mbp.dhcp.thefacebook.com>

On Thu, Jun 13, 2024 at 09:40:36AM -0600, Keith Busch wrote:
> On Thu, Jun 13, 2024 at 08:15:06AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 13, 2024 at 08:47:26AM -0600, Keith Busch wrote:
> > > > 
> > > > Just make a helper function like this:
> > > > 
> > > > 	static void my_synchronize_srcu(void)
> > > > 	{
> > > > 		synchronize_srcu(&my_srcu_struct);
> > > > 	}
> > > > 
> > > > Or am I missing something subtle here?
> > > 
> > > That would work if we had a global srcu, but the intended usage
> > > dynamically allocates one per device the driver is attached to, so a
> > > void callback doesn't know which one to sync.
> > 
> > Ah, good point!  I suppose that a further suggestion to just JIT the
> > needed function would not be well-received?  ;-)
> > 
> > I cannot resist suggesting placing a pointer to the srcu_struct in
> > the task structure.  /me runs...
> > 
> > Perhaps somewhat more constructively, my usual question:  Is it really
> > necessary to have per-driver SRCU here?  What would break if there was
> > a global srcu_struct that applied to all drivers?
> 
> There's not a strict need for srcu_struct to be per device that I know
> of. It was just done this way to keep usage localized to the parts that
> need to be protected. The fear being that one device's long running
> reader could prevent another device from quickly tearing down.

That is a legitimate concern.

Is there a way to avoid this issue by making this be a statement parameter
to a macro?

							Thanx, Paul

