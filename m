Return-Path: <linux-kselftest+bounces-3734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7980E841967
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 03:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303891F29616
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6528E17;
	Tue, 30 Jan 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8eY5A1f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F785364C6;
	Tue, 30 Jan 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582424; cv=none; b=lLX07U6CFxqyYVfdh2Nt5rWQxF4LEMVQ/jDg8EqKc7M1aJvHZMn5dDoBnyOT1Er9m2jkARuYOPftxF4KqvWyBnrCSsxhEmjRUmLWQRBAHZUIQKmhQ5hLR0EbonELku5nbdhAA0HqOyblVm/vkXbCqaYv3m5377ueWCZ14WIJFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582424; c=relaxed/simple;
	bh=/+JJ+5Dh8JPDLWVZZFqERw8ATKk3+XmkeQhdjQ1wYW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V56nQWZQE2JgbjejCX5q0zl/9IN+TBHsF1bBmSvg8OuafCxn8P1KTYThXLCeCT9eSmER/RDtJLTKSphelKYrLIQxj3IYx9ZxlcWMf7FpZOw48IQhui5/+GH8VKQsRsSjSyX/cUbGPlo2t6zhIOvTL5WXpLYH1yPxeQGVePCBJLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8eY5A1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5187C433F1;
	Tue, 30 Jan 2024 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706582423;
	bh=/+JJ+5Dh8JPDLWVZZFqERw8ATKk3+XmkeQhdjQ1wYW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I8eY5A1f54PN37rmXdRJhto6xA2Jbn8/5k35WaQ72nv9DmrHwmkRWxTJ6qD8MKnYJ
	 Kn5r4xbI4V2l4qgpgSNbTbqmmoZQzVcCYIWkJA6ujefibnFWDKvUQ8mzroOm492QPE
	 /2F3LGuTyPsHY8aXuWufH9llKYcZLF00PRRH6P2jBTO/BF2IY5gcPGwEsjJiyVVyuW
	 j0MciY4VJtpLpjrcqazRsWDrzezYM8h52ntEPIfD59CZ2Z+XK3aSLRBuIoaoRKoQ4L
	 nw1zcyXrIaXck/nbAVLSZ3o0iULYQMBuytVWtP0QyUHzXw8frlZbhP+1jZYdLfZ3JO
	 rcxpGaD6cKcfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDB38C43153;
	Tue, 30 Jan 2024 02:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: add missing config for nftables-backed
 iptables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170658242377.31723.2754949438054475014.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 02:40:23 +0000
References: <20240126201308.2903602-1-kuba@kernel.org>
In-Reply-To: <20240126201308.2903602-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jan 2024 12:13:08 -0800 you wrote:
> Modern OSes use iptables implementation with nf_tables as a backend,
> e.g.:
> 
> $ iptables -V
> iptables v1.8.8 (nf_tables)
> 
> Pablo points out that we need CONFIG_NFT_COMPAT to make that work,
> otherwise we see a lot of:
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: add missing config for nftables-backed iptables
    https://git.kernel.org/netdev/net/c/59c93583491a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



