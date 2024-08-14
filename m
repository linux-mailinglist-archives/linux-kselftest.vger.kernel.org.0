Return-Path: <linux-kselftest+bounces-15322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F022951D91
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 16:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413C91C215C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7A1B4C51;
	Wed, 14 Aug 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YV6V8QQR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D11B32CB;
	Wed, 14 Aug 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646612; cv=none; b=ichuSw3QQr8Y4cdYwwuzToZpoorGUYXZjF27IIda5vEUtwlYrrtXCZdauZt/IV13kWraZOhDy3UvZUhnHFMmzUU5+5XAOIhcOEYj4pAXC/1DFzKFDXLYJusO+0rMWGSpxxrXlD9eiwg0eH1Ggxhd3ZhWYb8+zvRmxMarIswA9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646612; c=relaxed/simple;
	bh=KQWG4ViSLsOS8V/X+ZV3XOOEhv8fDvLygcMOo7xLRQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGhkHtFwsxPPPLy9ueIYWWvgx2LWJIE38+/vLK8qPNdQYGe0EtF19zcGK/46/EA/sJpgNUuzaeb8biOc8ms1euNDviPYkvo7LCCNTYuHig3ZrLanRSBaGYEHJ2OCk92HtZohO+l2hCA3BA0pTySbavobM90WXpf6BROTVHvST64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YV6V8QQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDDCC116B1;
	Wed, 14 Aug 2024 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723646612;
	bh=KQWG4ViSLsOS8V/X+ZV3XOOEhv8fDvLygcMOo7xLRQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YV6V8QQRBCJBZrjU6npmHPflNVrafJeNC6m33uwwia+ttM8c7tuCKVbg/lKfi1Lxa
	 g4gVrmQDxXePmIsHAlPT7cyKFgXsaQiL4cvvUsnetp1AFLEBiLqIXU5aSf+UF6Xk45
	 bD0QN7I6RDJZL0lNPtCs+1wy4cVWWbT/mxegdxxEp6ioKgpL7lwqfqoEZpmb/Ro+O5
	 WMBZ4tuRoyfr8s7vhEDpF00pMDFCXWyBDQlwa6Q6kTE/6Affayb0vOJa2P9ikEiaWu
	 tNBhJSS/gkll/S+4gqX+d6Z3+63519ay88kApdBYHnHm1LFotQ5B4ZUaxTL8xYrr4g
	 q9gQ09Iu+Xc9w==
Date: Wed, 14 Aug 2024 07:43:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH net v2] selftest: af_unix: Fix kselftest compilation
 warnings
Message-ID: <20240814074331.4ab7e225@kernel.org>
In-Reply-To: <20240814081054.1156422-1-jain.abhinav177@gmail.com>
References: <20240813182106.1f44d161@kernel.org>
	<20240814081054.1156422-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 13:40:54 +0530 Abhinav Jain wrote:
> Also, @Jakub, please kindly check this and revert (another patch on which you
> have helped a lot already, need one small input and I can send the next version):
> https://lore.kernel.org/all/20240810175509.404094-1-jain.abhinav177@gmail.com/

I read the questions and I don't have an immediate answer.
Please do your best, and we'll review the next version on the list.
Unfortunately there isn't enough hours in the day to help everyone 
I'd like to help.

