Return-Path: <linux-kselftest+bounces-19157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98BF993213
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 17:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D332B21CC0
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5C41D9678;
	Mon,  7 Oct 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu1IgiY/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D81D959A;
	Mon,  7 Oct 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316419; cv=none; b=XHStACKxWq+hmO6bt2Va55nL4lVKTC8SWxwNmyDnHy+Ki8BY2PO6ew5tVcMKNjQZzszi1Urvfi+OH4DGCMr8bfKzySfTme3CiDCvKybxFnTqZPNxOpcNM0cfsyC85NVoYFrDgvnBTW6XpvNpB0E7ReGWffMD/e3Yhw+i5kbqrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316419; c=relaxed/simple;
	bh=pv+FyOgJCBxol40Zme3vCVxJbHJxEYdzmwt+YmqSRTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdpgHJfAJH5paK3mkjZkIY3/WtRAtkFpG2Qyk2hycwuFL8MYp/haAt64SJfwuL/boRvwU92cSdWKTt/7g1VUXq5+NFvKmNgg2Jsq0Dji5w7guEohkd1/bw57wKne9N6daShVLws74N9Wk4vbbWpRXEF3k56m+pM0bZRebsPFkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu1IgiY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C5BC4CEC6;
	Mon,  7 Oct 2024 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316418;
	bh=pv+FyOgJCBxol40Zme3vCVxJbHJxEYdzmwt+YmqSRTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qu1IgiY/3wgptstFINr+lgfocbnrIs958IalvSl+y5N4B9wPPh55gmawmhKX5dsp6
	 YWLqu8VT8zmfGDaNYXNGMRXNlyVsi0RnvNOrfIaPf9UQLzHbyDupz+iEDId/gDoRMr
	 USyG2D6fODlJ6LF2SFRUG8qoogNtjss8aeEWqVF1kKNiaXUTsrsNkCOpX0yQ9kSXLJ
	 cajYqEFeaZkPvAD+gHIMuXJX+C6Af16vtX/yU/u87/9K7GJPEx7zCxF2UpLJxtI/Ve
	 Ofk+M9E0ymXwJAQKpG69iEPnydWBOnWaoEqK9ruzkI4Kdy/hwMuyJqHl4ndQCLJkz7
	 V6/wYN9QH4Rug==
Date: Mon, 7 Oct 2024 08:53:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
Subject: Re: [PATCH net-next v8 01/24] netlink: add NLA_POLICY_MAX_LEN macro
Message-ID: <20241007085337.2ffff440@kernel.org>
In-Reply-To: <e09ea6b5-fe0c-4f90-8943-83aa410ccc1f@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
	<20241002-b4-ovpn-v8-1-37ceffcffbde@openvpn.net>
	<m2msjkf2jn.fsf@gmail.com>
	<20241004063855.1a693dd1@kernel.org>
	<e09ea6b5-fe0c-4f90-8943-83aa410ccc1f@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 12:04:22 +0200 Antonio Quartulli wrote:
> > Or we could check if len(self.checks) <= 1 early and throw our hands up
> > if there is more, for now?  
> 
> We already perform the same check in the 'else' branch below.
> It'd be about moving it at the beginning of the function and bail out if 
> true, right?
> 
> Should I modify this patch and move the check above?

I just sent the refactor patch, that seemed easier than explaining ;)

