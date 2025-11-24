Return-Path: <linux-kselftest+bounces-46370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE388C7FBA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 10:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58B2A3490A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6999E2FB98A;
	Mon, 24 Nov 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="SjUFZww7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B562F7ABA;
	Mon, 24 Nov 2025 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977831; cv=none; b=RgnDBxGE2b7Vnb1UEQDFOHadsXoFDD7F2YCYOkM9XZJolf86HN4UhcALor+gSbI9Jcr0ml/Tapzk/dodXTDhAZEceHapRat8MJPU6sNErLcwl/VqNYWLKrAmYQdnHS4FYsQD5q7EwWwtVmvsmcP6cdmKL9xXKu/AkRUT/ffFckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977831; c=relaxed/simple;
	bh=wdpq5aPFnF5Pv6Nk2aZ+bFwLVb4OvJTvVzFcLZwG7YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHjlzRylJb+hm05qGbJDeKGsJWAV0Oaw+1g14RVP1q8yXMBdV4WzDanmPn3Nj0LUWGapbizKzLME9DgW+828e677S4ifSRP8ePH2JJ3XP+PWDmpgKFJJr4BwT+ej07TRByb9uXTk3wrvaZi2Cd9Uj8GGM/bskDjh4th5wPrIf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SjUFZww7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6i0e0la1BJFqSUumCVXTF+dlaAAu2PveT+PtcuqdeYM=; b=SjUFZww7E0HLZ5T4XcQch/dnMJ
	BEAeMwEDbO5Lnq9Q0fDBXKAKEhSu885QO6mnYfOy3gHJoAAd6tN6oMA/tmMP+VFGaaznDZ5rQyOFU
	nyqZ9YGBFoyHmb7sDq8V/+LMGJZgaznhRCImj5bJdMp5QBhJDOCmq84Mjdgtb9jNihFsgBdpb4dJe
	5jfpzja8ohtAIVVQDUcMatDZf5yQZCdlPEkiU+FZJGDOk/LwZMOVCnL4sK6/Lo14yE4vHpcpT09yq
	gp5oZPpmOUENPsqT+BL5N5m2CHf0UdhYCCdAHODfTEcHWlpjThRX76rXFO7C8ZrC0CqSHTR60NbNu
	Rd9w7/Cg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vNTDC-002Uu5-Gd; Mon, 24 Nov 2025 09:50:22 +0000
Date: Mon, 24 Nov 2025 01:50:18 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 4/5] netconsole: resume previously
 deactivated target
Message-ID: <7vxiawjx5kdkt4jy7tca53sd7xxuhflrsnbghoynfw3wkd7t7q@s53w23z7umgg>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
 <20251121-netcons-retrigger-v6-4-9c03f5a2bd6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-netcons-retrigger-v6-4-9c03f5a2bd6f@gmail.com>
X-Debian-User: leitao

On Fri, Nov 21, 2025 at 12:49:03PM +0000, Andre Carvalho wrote:
> Attempt to resume a previously deactivated target when the associated
> interface comes back (NETDEV_UP event is received) by calling
> __netpoll_setup on the device.
> 
> Depending on how the target was setup (by mac or interface name), the
> corresponding field is compared with the device being brought up.
> 
> Targets that are candidates for resuming are removed from the target list
> and added to a temp list, as __netpoll_setup is IRQ unsafe.
> __netpoll_setup assumes RTNL is held (which is guaranteed to be the
> case when handling the event). In case of success, hold a reference to
> the device which will be removed upon target (or netconsole) removal by
> netpoll_cleanup.
> 
> Target transitions to STATE_DISABLED in case of failures resuming it to
> avoid retrying the same target indefinitely.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

