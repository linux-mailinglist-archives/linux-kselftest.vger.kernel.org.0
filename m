Return-Path: <linux-kselftest+bounces-47353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 898E7CB1DDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 05:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4816E30E2B52
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 04:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7171C30E0D8;
	Wed, 10 Dec 2025 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSLSiwyv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAED27280C;
	Wed, 10 Dec 2025 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765339544; cv=none; b=eYTERtarWFbuKd7Oy06VaVWpWm7W3YxgU0CdLRnTVDLLQiSYCHEbjpMEZelx2sBNYQE+bOooOssS8DB2Feq7XpxzKg9NzHdXeO6aZ9x4RqWvx4zgL/FDD3lCe8qQ6nwIFLqP8pO5Wof6QaNF2KDZ3H/jyk0qHy0RRJ2z+NmtsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765339544; c=relaxed/simple;
	bh=/pgtDdbLyzsiBNrvqE8WGvAHGF6R2MHfkVKuKRhOpDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2CjiLLNPj/wJSwfx4hJAQsUpIqm10NBjzQYZTSxodAX12sPa83QucOLG+zM4nX5BtkwjH69aoEIb3zRX/lJ6TWmhAbokYWJjK5BV4uc4A6cYEw9UU25Q4/8zxuVc3970QP4iG6oreeltmURgvYTocymeQp+7n1nwyVeBqHSPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSLSiwyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6086C4CEF1;
	Wed, 10 Dec 2025 04:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765339543;
	bh=/pgtDdbLyzsiBNrvqE8WGvAHGF6R2MHfkVKuKRhOpDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eSLSiwyvvuk2jVCHEVC5WEOrgjc26SOeByQu0BTaa5gTYpoDNrwoOKjsAKXt1u6xP
	 19gPkArZ4u8HzbtaHd7vGEyZH9NlJ+U9w4eKqFpmiVb8saoD+ACIiRQJh9jNJ/4i9/
	 EKuw9iECrtFHmxqFpGn2/7p8/pPX3HSRRs0f7/IefUjD0DfwjoJVCwCn2amfqXXZtl
	 dxLFEamLg/VOyAUlFVq2VNuMwA6opUgYlVjtSUW3P/PuWdnKGd7nYNIAMRTbQvNFz4
	 Tve9+KsRJb0B+fDnZK0+yrtQ0qUOmgVt/W2OY8ven4sEmcMGgVyy8cEx9rmQ+erVAN
	 zq1/PIOVKmH0A==
Date: Wed, 10 Dec 2025 13:05:38 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Petr Mladek <pmladek@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
 kernel-team@meta.com, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <20251210130538.38374707@kernel.org>
In-Reply-To: <snoxl67npkzfi63l4ndh3d6qvx2lyxthtrwhfnharhf5llrv4j@zhyzxm3tegia>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
	<20251201163622.4e50bf53@kernel.org>
	<4oybtunobxtemenpg2lg7jv4cyl3xoaxrjlqivbhs6zo72hxpu@fqp6estf5mpc>
	<20251202102442.568f91a7@kernel.org>
	<aTFmew5trILX3RpO@pathway.suse.cz>
	<aTFnzmc0ZtBvGg4y@pathway.suse.cz>
	<7jdruzcpkeyhuudwi6uzg2vsc5mhgpq7qz4ym7vqqmgs7j3524@cvtnzneddg2d>
	<20251209163745.3d0fcdfe@kernel.org>
	<snoxl67npkzfi63l4ndh3d6qvx2lyxthtrwhfnharhf5llrv4j@zhyzxm3tegia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Dec 2025 09:46:51 -0800 Breno Leitao wrote:
> > I think I was alluding that another option (not saying that it's the
> > best but IIUC your requirements it'd be the best fit)):
> > 
> > 5) Add a keepalive configfs knob, if set to a non-zero value netconsole
> > will send an empty (?) message at given interval
> > 
> >   Pros:
> >    - truly does not require a user binary to run periodically, netcons
> >      would set a timer in the kernel
> >   Cons:
> >    - does not provide the arbitrary "console bypass" message
> >      functionality  
> 
> This is a good idea if we change it slightly. What about a "ping"
> configfs item that send sit when I touch it?
> 
> Something as:
> 
> 	# echo 1 > /sys/kernel/configs/<target>/ping
>
> And it would ping the host with a predefined "ping" message, and nothing
> else.
> 
> That would work, for my current problem, honestly.
> 
> One drawback compared to a more flexible "send_msg" is that I don't have
> complete flexibility on the message format. Thus, if I want to pass
> extra information such as a Nonce, timestamp, host state, interface
> name, health state, it will not be possible, which is fine for now,
> given I am NOT planning to use it at this stage.

If you still want to tickle it from user space periodically, I guess
send_msg is more flexible. I think the main advantage of keepalive
would be to remove the need for periodic userspace work.

