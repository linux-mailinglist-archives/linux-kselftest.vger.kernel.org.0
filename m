Return-Path: <linux-kselftest+bounces-3423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7708393A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800A11C25959
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A396341C;
	Tue, 23 Jan 2024 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4bkMcKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9FE63419;
	Tue, 23 Jan 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024572; cv=none; b=ltxtLQc4hDCDg2HfiBr9ocmdD//vtJk3PxD8Ikyq0TIqbozSMdfvHTfZlRD7WkpbsSOfMxesJta35IOLIj+vTEoRKLMGtlI0zWZ+o+eev1wBywD+r5+6BqxqhCmj/RXgrVnRa9Rz9GCnzkOZ9jFd2CJ509MiNZyghQlseMVxd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024572; c=relaxed/simple;
	bh=/abJMsE9oo+O9XXWWJ+u2LALF0NQYiZJ/ErCT8PTrIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnpJqMfHHUO/7gzFNRLe3lGyxIqezjR+F6r/Fhn0Y1CgoGI4d/wPYa+s8iMOSVBSAdi61wBWOd3o11TOIpKfZ1dWK9JU9J8/k1XtftBeJxqIFr2YdU2sqftKqyzcdN9khGxRBTQ3FEfLBGPqxeWYN91X3/DB82y/9nGKCh9ntgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4bkMcKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AECDC433F1;
	Tue, 23 Jan 2024 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706024571;
	bh=/abJMsE9oo+O9XXWWJ+u2LALF0NQYiZJ/ErCT8PTrIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H4bkMcKrlw4nQYwNuv5GjNCeoMUZpKnGFvdtFnv6EP3/SFUokyhr+jKdo/TKmlyEK
	 1wuysLpe0SPFXuqxRmMKwZNX7OAQatIrLREduVrcgwSEDqUFzySZ96QlYbNjg8afiA
	 e5gUIxmYnttUq4k3T5zb+uW+TBkzutiH9WcqmldXQJCfVXSsDS6zZeNzJL2SDU6Yc0
	 F0EQG2bA3Z5BEEmLxiMA3KkHHbSWlZP28PGjgHW1jiclVzrF1UOOQhGapC+kbpwlMg
	 /9sFBQ8wcazaTPwA640U4O0PC9L3q+Ok/l2B+afJVTJaTbO3sdV3ZPgFBiQQb7Vhcr
	 oqG6MC9iziw9A==
Date: Tue, 23 Jan 2024 07:42:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, shuah@kernel.org,
 horms@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: netdevsim: fix the udp_tunnel_nic test
Message-ID: <20240123074250.60b2b232@kernel.org>
In-Reply-To: <20240123073925.416d3746@kernel.org>
References: <20240123060529.1033912-1-kuba@kernel.org>
	<c029e9d7891fcaf1f635e2a76eae9a5df898f3f6.camel@redhat.com>
	<20240123073925.416d3746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 07:39:25 -0800 Jakub Kicinski wrote:
> On Tue, 23 Jan 2024 09:27:17 +0100 Paolo Abeni wrote:
> > > @@ -270,6 +270,7 @@ for port in 0 1; do
> > >  	echo 1 > $NSIM_DEV_SYS/new_port
> > >      fi
> > >      NSIM_NETDEV=`get_netdev_name old_netdevs`
> > > +    ifconfig $NSIM_NETDEV up    
> > 
> > WoW! I initially thought the above was a typo, before noticing it's
> > actually consistent with the whole script :)
> > 
> > Do you think we should look at dropping ifconfig usage from self-tests?
> > I guess that in the long run most systems should not have such command
> > available in the default install.  
> 
> Good point, there's only one use outside of this script.
> I'll queue up a conversion for -next!

Hm, Hi Florian! Is the use of ifconfig in kci_test_promote_secondaries,
commit bb2bd090854cc6 on purpose or can I switch that to ip addr, too?

