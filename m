Return-Path: <linux-kselftest+bounces-42642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A0BADF96
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 17:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487303A33A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA13081C2;
	Tue, 30 Sep 2025 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdu5JwgL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B512032D;
	Tue, 30 Sep 2025 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247415; cv=none; b=dsYjcVatawVcAF5YLQVIz6PEu49xeln2R5iRA3a2EWf3YgSWFuqJKh2RUAmbSiNALP27G316YdPOR+mRzrAUpPdIwUIC4YpA4lBQI2y0ar563enKCEf3Q4g8pM493mkK7dBPeCcvom67KAKHCRRpdNMnAPWbvzDvXV7QdOrsHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247415; c=relaxed/simple;
	bh=ODDGAeANZJXMXsw5dIQyCYdhwt8Qovd/AateS2IGK/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cXAjEzZt5CvUq4luOVOnXJo3xIpQNvgFY5GjlETo2xJOg4SjhRj8ijLiilscNQeIXvXONqlNUSO4G/9gyre4x2VAUV3sVQqVKCbbyK8OrUSOkCA8Qb+F9tJ0BfVnlvSibR2cUpsnsVUjs5GImJTSV7++1KsDIdobWExToJF1yDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdu5JwgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EDAC4CEF0;
	Tue, 30 Sep 2025 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759247413;
	bh=ODDGAeANZJXMXsw5dIQyCYdhwt8Qovd/AateS2IGK/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hdu5JwgLl7ax9srC1bfQhbI6JjgAcJyKYjhaKrijDC4Qpzzwcdzd7w+03D87RRKgP
	 ohx4ZNhxCoZhpAsVYdvUyVJbj9A8dlqdTX85Y9pWd0gATfVz5PBdxQfK1sbpWAq2Go
	 F6hXX9Uk3FiJ8w0+YWFaf/K7zVCa/9BH2HeRIou2UamE40VJJcmqdQn69YH/u3z3o2
	 vRuRC8td8MVq5Xq7Y6YHASknrpfHAU8QM2hHpVW6VQ4tcc2iHFgoSZEf/fTaJLivfJ
	 2pS1YAf7hLj9OVKN+Yh32UXnHg8SXpxV49LjCzcKqo6G7+u8KP6a8/7lOTKUoSXFPJ
	 NxX1/zKVOxtXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD9C39D0C1A;
	Tue, 30 Sep 2025 15:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: add tcp_port_share to .gitignore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175924740628.2029424.4176185982748581739.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 15:50:06 +0000
References: <20250929163140.122383-1-krishnagopi487@gmail.com>
In-Reply-To: <20250929163140.122383-1-krishnagopi487@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 22:01:38 +0530 you wrote:
> Add the tcp_port_share test binary to .gitignore to avoid
> accidentally staging the build artifact.
> 
> Fixes: 8a8241cdaa34 ("selftests/net: Test tcp port reuse after unbinding
> a socket")
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: add tcp_port_share to .gitignore
    https://git.kernel.org/netdev/net-next/c/03faea846671

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



