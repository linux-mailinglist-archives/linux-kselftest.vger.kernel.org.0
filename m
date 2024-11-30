Return-Path: <linux-kselftest+bounces-22644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70B9DF268
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E312162EA2
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2024 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5AD1A76AE;
	Sat, 30 Nov 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyUWpmr2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD543AA1;
	Sat, 30 Nov 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989386; cv=none; b=WxGFQM9OJx3IBX9sEnAg33D3DUGrvY10wK82SL1k+ncmbiNeo+lQ2ffbmBTH4WqcKLr8Kgr3jCwHcaqnUouVHznpqTAnC1/5VV7Nkz5wFKfr1Vjsu8YUBiPfZF2/Yvk4rjuP+tZ/8mCrw1eGtHaUi+N+OXRz6s3j3Dr/Try4RhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989386; c=relaxed/simple;
	bh=Ab4feArBZDLh5bvzEF2wp8FNfSQEeaamV/6tHPpOlTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxdvILuJJJP1ofhfGzK0AQUqJvVN9xnAif2gqvswav2l4x2ikHAKL2/+AkJswPkLhYjPTdKOTUkZcyckY3HWP0b+dowYWmYnOjbqcQEngxqBvKgv8cTY3DXUTeZkg+Ai03HU0tZhhkibxsysZKNQJpw+EVezAytPsbv4WfaIVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyUWpmr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749F2C4CECC;
	Sat, 30 Nov 2024 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732989385;
	bh=Ab4feArBZDLh5bvzEF2wp8FNfSQEeaamV/6tHPpOlTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nyUWpmr2hn1aShisZ6dJhVRGYJozospmM0H9kujGzKxmjWv6ChyeEpRFqczlsFDVV
	 8ujzv5U2IqSpMo6Vv75Rwja7R7MbqY1zq/bgvrgLYKZq5AKzafKFn2obWlCV70W/7U
	 umCV6jxI0PafxtClfdcZCsM6HV+ainkOI9juAu7WdalidpMYnAhLw1BM2Y+Hb5fYvF
	 VveTnnEsEJZzdXk5cjPtYQuMx/G/UCccwZW0uxe/KUf6hIxpTp6KwcOqmsg4LFoah/
	 KomQD/VDp/jiMxM/IPJ2veJIdfDxWHoYi3cZhMkxxwIG9HSPw5KdZSRhNyKuy2vtlP
	 ltqEpioC/ZYJw==
Date: Sat, 30 Nov 2024 09:56:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jordan Rife <jrife@google.com>
Cc: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, wireguard@lists.zx2c4.com
Subject: Re: [PATCH v2 net-next] wireguard: allowedips: Add
 WGALLOWEDIP_F_REMOVE_ME flag
Message-ID: <20241130095624.1c34a12c@kernel.org>
In-Reply-To: <20241127232133.3928793-1-jrife@google.com>
References: <CADKFtnTThMBDKCXufNaeci5uCeddOgLvXmqszyJoT6N=6xtWug@mail.gmail.com>
	<20241127232133.3928793-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 23:21:33 +0000 Jordan Rife wrote:
> The second command fails with "Invalid argument" (EINVAL) on the
> unpatched kernel. This simplifies things, as there's no need for
> clients to explicitly probe to see if this attribute is supported. I
> will do the following:
> 
> 1. Revert WG_GENL_VERSION back to 1.
> 2. Add a check for new flags similar to the one you mentioned for
>    WGPEER_A_FLAGS.
> 
>         if (attrs[WGPEER_A_FLAGS])
>                 flags = nla_get_u32(attrs[WGPEER_A_FLAGS]);
>         ret = -EOPNOTSUPP;
>         if (flags & ~__WGPEER_F_ALL)
>                 goto out;
> 
> This should be sufficient. We might want to consider how best to bubble
> this error up to users. In the case of wg, "Invalid argument" may not be
> very helpful in determining where you went wrong. We could always detect
> when EINVAL is returned in response to an operation that sets
> WGALLOWEDIP_A_FLAGS and print something more helpful like "Operation not
> supported on this kernel". However, these are details that can be worked
> out.

Better still use NLA_POLICY_MASK() so that nla_parse_nested() can
perform the validation and attach a machine readable info about
the failure.

