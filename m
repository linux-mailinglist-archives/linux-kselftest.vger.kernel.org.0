Return-Path: <linux-kselftest+bounces-46796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD589C96B5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 11:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C10A5343740
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 10:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F534303CB7;
	Mon,  1 Dec 2025 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="walNuAjj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF48303A2D;
	Mon,  1 Dec 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586002; cv=none; b=FZi6w9UV3se5fmMEQ7VDVuwQBRhATNRKKpRJFGvtFFI1x+CLg/wUjKOE8Nweb5oNgftVxc4JvwQux3fd29imo+R3Pdx7h6X40pg7YVXDeyRk2cSpuzGozfBOy2Wv1BwGEaYGoMh9AXRljFwncvSsSOK6+RGgF7aKmBwM9+nSVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586002; c=relaxed/simple;
	bh=SPtVYLN6pr0/GK26TSby27WfxPjzX7yoGAZOETTxBuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0zEr12b1KH2lUam2LG5C/Ne1jHGdNhUGlHKd8rdfy4+Ko1nodInvXl/JKIa6jrhNyCLrGcm69FQ7sxfKLcGea4YH98aadlXXrfPGqgLwLBkvl7kBBg4iALChC4/4E5tNmhdCNkutEwDLFSeW0klOXoNrS2k2SSP1Pu22f5935k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=walNuAjj; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=prSP2R4LrGQbPcGBJUcBFxh7pV4LinvyasSth50C79w=; b=walNuAjjcZPZpAajNR0M5w8zmO
	IGRiHofwwxVdJHSp9QWhCYNnvdCjYgWRAZJQIQ9c7kk5CZfstSdqSDQboPvmsncxwxLEwTF4IakMP
	GGkO8fWTv3BDfdI7rHz0CeV0yvcS1wH5huBSwWs6/6MCzMSdarzyX/a39jUquEiEYa5YurC2hSnik
	mWZlMCNelBuXq5fYpAqCr+dwWUSkyU8jnf6yXE+Qg98dlnv8qet1Wj4EzwAQayujUvMEAVLpvuIl1
	1tjfjkrePH4ZLF0Vvk0Y7sDqqY0t66B9L5syY4muNvTxyKw6UF8EJ5glmfR5KVS7EAQBdvIXyKAJ1
	h0oL2wCg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vQ1QN-000aAP-DP; Mon, 01 Dec 2025 10:46:31 +0000
Date: Mon, 1 Dec 2025 02:46:25 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/5] netconsole: support automatic target
 recovery
Message-ID: <q4l6chqvikl4zgypqysdd5ri2vt6p4qdq2f4l66nxfbm7q5wo2@qwvwkilyzzoh>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
 <20251128161133.3397b20c@kernel.org>
 <htqwtsgxsffbjbccd62kzcdaa2uxezdtywudcrfghydym7axad@4j46eyxzvhte>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <htqwtsgxsffbjbccd62kzcdaa2uxezdtywudcrfghydym7axad@4j46eyxzvhte>
X-Debian-User: leitao

On Sat, Nov 29, 2025 at 12:29:22AM +0000, Andre Carvalho wrote:
> On Fri, Nov 28, 2025 at 04:11:33PM -0800, Jakub Kicinski wrote:
> > On Fri, 28 Nov 2025 22:07:59 +0000 Andre Carvalho wrote:
> > > This patchset introduces target resume capability to netconsole allowing
> > > it to recover targets when underlying low-level interface comes back
> > > online.
> > 
> > config hiding a build failure somewhere:
> > 
> > drivers/net/netconsole.c: In function ‘send_msg_store’:
> > drivers/net/netconsole.c:1304:16: error: ‘struct netconsole_target’ has no member named ‘enabled’
> >  1304 |         if (!nt->enabled)
> >       |                ^~
> > -- 
> > pw-bot: cr
> 
> Hi Jakub,
> 
> Looks like it comes from Breno's patch [1] which was also part of the same testing branch.
> Not sure how to proceed here, I suppose we would need to pick one of the series to apply
> first and then respind the other one.

I would like to have this patchset intergrated first, and I will rebase
mine on top of yours.

--breno

