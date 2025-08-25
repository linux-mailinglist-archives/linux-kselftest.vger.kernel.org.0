Return-Path: <linux-kselftest+bounces-39874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11910B349D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDAD1A82877
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1721C309DAA;
	Mon, 25 Aug 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez0SkEZ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B273093BA;
	Mon, 25 Aug 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145399; cv=none; b=lcovsFykwz8XF3ISZcBX/tcLISw7xOanFcGe16vl7V5xshPrRyrDBpNL74fGeVGXk3zjcbQHJDDT1PTpZN59nnXrSovqiIhEdsCuo2PrfHaui1JKIKPrisPgE3ZN9Asiphc/kWK9iWjsjmXcRg0aT8B6zvbYmtSfI4K2QdlVoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145399; c=relaxed/simple;
	bh=rtmv2IViFJYok/QCRYgx6QbIgL10htu3uGc5S67uWdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BM6CUycd/+s/2Y4wInK7gb7Aax3MEDV2ls6qwn80WDZfs4suheXZ9vybVmolYe61j7oKpkl/wDpNndQMIF6Zn/3c8msumE4OmSKiNafBray+J12Y6liEUmUVxhgEDcGj3CzCKSKQ7GlsJCaOR9bbbQ5UenlkYuKBVdgP/USKn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez0SkEZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40638C4CEED;
	Mon, 25 Aug 2025 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145398;
	bh=rtmv2IViFJYok/QCRYgx6QbIgL10htu3uGc5S67uWdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ez0SkEZ96KuWfl+bHDJ6CLh3IoeOyd5/BSsUnhSq4HNy8/r1gWArNP7wSsse6E0EH
	 BaurtadyFNZSZMAuiT1rnAuuDvw+F3S7DD9d9cTiHmm0pJybM7XEKEct8VWwXHHbRD
	 pZJA0eqPFKXIWnl5Gm3joYxjVguinK4zC3JyXeRpjiequNMNiVAGFLu1H7bLFceeHP
	 UZxx/ifj6rlTuYw1fzzNrwxKiPbTkJqIqACXGNyFqkzVjmkrFI2kPXM7lnLI8bagtD
	 cpTban+my/fTgO5841eE3NIlnkqVz/+VimfYjSF5PYp/495eGcrWXQ2iQgpbrexY2m
	 6UUzKpiT0IM1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D62383BF70;
	Mon, 25 Aug 2025 18:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: xdp: make sure we're
 actually
 testing native XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175614540627.3511457.5738695884587202392.git-patchwork-notify@kernel.org>
Date: Mon, 25 Aug 2025 18:10:06 +0000
References: <20250822195645.1673390-1-kuba@kernel.org>
In-Reply-To: <20250822195645.1673390-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Aug 2025 12:56:45 -0700 you wrote:
> Kernel tries to be helpful and attach the XDP program in generic
> mode if the driver has no BPF ndo at all. Since the xdp.py tests
> all have "native" in their names this can be quite confusing.
> Force native / "drv" attachment. Note that netdevsim re-uses
> the generic handler as its "native" handler, so we'll maintain
> the test coverage of the generic mode that way. No need to test
> both explicitly, I reckon.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: xdp: make sure we're actually testing native XDP
    https://git.kernel.org/netdev/net-next/c/992e9f53a0db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



