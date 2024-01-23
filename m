Return-Path: <linux-kselftest+bounces-3424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25CC8393E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 16:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA712284227
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0560DF1;
	Tue, 23 Jan 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGlIKORa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A51612CE;
	Tue, 23 Jan 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025460; cv=none; b=tjAIcmoJkyuQZlm6WXMs8Oqv15JVt7W1qz/O2CFdc84VS2xu51iu8XWp6a/Q0dQYbvoBlt33uH6yBvYfu5Ms1869wbJCy4vgJ7q5+/SwHumvTWdJ7Di0JLrgdhwSj9mdwHndHa28GzjX2awNKVM23nlDXfA4+YxnYfSrZi72NG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025460; c=relaxed/simple;
	bh=AE57RfS6LrxW69MjMNy5Ejs67em/s2Lg0dgNEmUrhgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhqINi8u30FUBJO8YiP7rL2u++foLUZ98YF6XwV5vGVE+Oj+TTGDYXRX6jPfSl/QE0RGKQi0dT3C02UXDgNpOezusJYZpykaU382ZlxgyV8x94el/dZZx3FcivhV7Oq+UrWIU5yFt1nl5OpvApSR3kJKJqRlE1VPF2khGZaNcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGlIKORa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCCFC433F1;
	Tue, 23 Jan 2024 15:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025459;
	bh=AE57RfS6LrxW69MjMNy5Ejs67em/s2Lg0dgNEmUrhgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AGlIKORaKUl5XoBLCcYABsaLsQQB8iqijTHoxXwU/kzPvrGrxkEsUn20zKmflRV19
	 EpBSXUBGN6CSCI6PQO3nxctvGdn4DWwq44WsYSIR0TR5xV02oJ7tEHsbvRbgaHeiSz
	 s/Bp77pTWGatO+nIkpNvDWX0wLy5DL8/Rwrj6aQa+gZ0oXnxGZsAWSJG1ns+ZzGfl5
	 8V0ygddQi3NypVDMmhT0+QL2wTIkOj4hUcIZNjH+NtQ+XQQ/nYhPDOcbdLER5+MIlr
	 Y5NjP9/Yvy0ZIqU7sE1eQN9OhkESD5NzT/8Vu28vC4e4Mwu/7AbiAIbuEEkEFbZEgh
	 i03vQgjo3V3kg==
Date: Tue, 23 Jan 2024 07:57:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, razor@blackwall.org,
 idosch@nvidia.com, horms@kernel.org, kuniyu@amazon.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: fill in some missing configs for net
Message-ID: <20240123075738.13bf9b55@kernel.org>
In-Reply-To: <878r4gtaif.fsf@cloudflare.com>
References: <20240122203528.672004-1-kuba@kernel.org>
	<878r4gtaif.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 14:55:59 +0100 Jakub Sitnicki wrote:
> > Fixes: ae5439658cce ("selftests/net: Cover the IP_LOCAL_PORT_RANGE socket option")  
> 
> MPTCP coverage is a recent (Dec '23) addition. I must have missed it.
> 
> Fortunately we don't need to backport that far. Should be:
> 
> Fixes: 122db5e3634b ("selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE")

Thanks! I'll swap when applying, if you don't mind :)

