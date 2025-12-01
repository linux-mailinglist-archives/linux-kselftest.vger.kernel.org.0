Return-Path: <linux-kselftest+bounces-46842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50983C98E9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 20:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0673E3A23A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 19:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6A52405E7;
	Mon,  1 Dec 2025 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byx3kEvV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A43228CB0;
	Mon,  1 Dec 2025 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618643; cv=none; b=g7YrnWzw4fhlMgGE3RjkDJenEmpVJRrPsZrGKpI2b5DmwnwxzBv0abJ/dmhwH1bZgafsN8Y7iy1pdqTvZ5xsXuEnns7CnSNWsf4/WdqVgNP9o3NUPD7SjUY3lrFVc3isAESILc7jKoUWd07U5DASaqJQBDEfozmyAnHtogeRT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618643; c=relaxed/simple;
	bh=ni8ZCMUFSd6ywa7ImxfaUIx6WZ0B74HT8Yi2k5LznIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nod66bcMwRM/6sNgo0U6TQUosBSvUqs2lGDjxHkv/NOIouxTGQrYs5CDVAFgqS/YwfOoyTptQdTzXoApx21rq1foXDTI83duCIhStotJeLYjuVLhRAj77Ys5jXZWxSCRKIzIUPifv7uvrfhn5KKhYPXyM3xKUSjJPTogxKeqqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byx3kEvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3637C4CEF1;
	Mon,  1 Dec 2025 19:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764618643;
	bh=ni8ZCMUFSd6ywa7ImxfaUIx6WZ0B74HT8Yi2k5LznIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Byx3kEvVHRYcEzskpmyCrQV00yv6Qayp/T/AwTjfsU18a7Oz6uYE3rIpwGNJM1H22
	 eLbqLSPC/867KodihHaP7y4BaXtY63JjD9SLgGvorkDJcchS1SY1Ij5xGbhWlZhrNi
	 EIhDk1Eyl3IZ0TNVPEeX9VS0FVtJVk0G3+HqwjmnY2kz5Opfjp4FQ6vmM+n95Q64N8
	 lvO0sveKFTj8OzIBLVfWDPF6WKnF6/aWix5CGnQiwSD6lp2mwQs63VBl7KLXk1Ai1H
	 cg5sDcdPtAg12bYpaUN+w3CGDXmZmYHtyNILIwxrF/18hWlu3hu8BU82nWjBH9ZB0v
	 FZgEDAXx7j8IA==
Date: Mon, 1 Dec 2025 11:50:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: gro: run the test
 against HW GRO and LRO
Message-ID: <20251201115041.5aa4c986@kernel.org>
In-Reply-To: <willemdebruijn.kernel.3877052beef72@gmail.com>
References: <20251128005242.2604732-1-kuba@kernel.org>
	<20251128005242.2604732-2-kuba@kernel.org>
	<willemdebruijn.kernel.468ae2cb7a74@gmail.com>
	<20251129173851.56cf3b18@kernel.org>
	<willemdebruijn.kernel.3877052beef72@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Nov 2025 09:56:24 -0500 Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Fri, 28 Nov 2025 15:42:40 -0500 Willem de Bruijn wrote:  
> > > So GRO off disables HW_GRO, but not LRO? That difference is behavior
> > > is confusing. Could we still see this as a regression and make the
> > > ethtool HW_GRO feature equally independent from SW_GRO?  
> > 
> > I couldn't convince myself that it's justified. Of course it would have
> > made testing a lot easier. But apart from that - what's your reading of
> > the status quo? Working backwards from were we ended up (and I
> > haven't dug into the git history) I'm guessing that LRO disable is used
> > to prevent changing geometry of the packets. GRO would presumably be
> > disabled when user knows that it will be ineffective, to save the cost.
> > Or when some portion of the stack (XDP?) can't deal with super frames.
> > 
> > If those are the reasons, practically, I don't see why user would want
> > HW GRO without SW. Ever since we allowed SW GRO to re-GRO HW GRO'ed
> > frames it's always better to leave SW enabled. HW leaves a lot of
> > aggregation opportunities on the table.
> > 
> > I concluded that changing the current behavior would not help any real
> > life scenario, just testing. LMK if you see one or the inconsistency
> > is a big enough reason.  
> 
> I think that's fair.
> 
> But from reading the code I don't see how disabling NETIF_F_GRO also
> disables NETIF_F_GRO_HW. And indeed I just tested on one (admittedly
> not latest upstream) IDPF driver and it does not.

Looks like you're right. Broadcom drivers where GRO_HW originates do it
locally, so does qede. I guess somewhere along the way drives started
treating GRO_HW as a separate feature rather than a GRO offload. 

I don't think it changes the reasoning in any major way? 

