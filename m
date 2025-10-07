Return-Path: <linux-kselftest+bounces-42818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7031DBC0FE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 12:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E18F3AEE12
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C102D780C;
	Tue,  7 Oct 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6TlVR9H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6B2AD2F;
	Tue,  7 Oct 2025 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832417; cv=none; b=sUvWPCcd1nIUZ1MZm74hE7QZTJP8VIpad4eTB/2RA74jqTbdF2mxOoOjeWjdvompTwvLlLoi19uD9WSP5fbc+719rZ9h/DmZ+gLmpZDIF+tDAAvRTZo9fhclXFoGUbqnm7lPpvHzZdkwvYsdARtFxLayil8fzhkNTflSPLAHcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832417; c=relaxed/simple;
	bh=4LnOx3YhyrpcIzEMQ2atXfC3zY1nvJVhB2xuxA4lMjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iOXGRr3f77EZrmOdJhd+Nnd97rBs55vobylikBl4/r9ISFuvxRteHFOsIExjnp5fBA4mYmwsq23fm4ABP7zm2CGT/hSfnkF5Ne3LWwWQpLdGTjgK+4jY+ygN87pG9XVng9cxqU5hxwZPtg4upBQLYsGnbMAZ7A9Vxj/WL4oGSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6TlVR9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FF7C4CEF1;
	Tue,  7 Oct 2025 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759832417;
	bh=4LnOx3YhyrpcIzEMQ2atXfC3zY1nvJVhB2xuxA4lMjQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I6TlVR9HXV1qYVwp4mfGR0c9Mu3fz02pQKkI5dHZopRT7LWYJ4l645YxOspfTxd+L
	 pnKrMsIpntyYAlcTFKL1eixnwNuB5vmo5KEuRwoKBgm9oZtWX5E+kRBdcwui9YHr2l
	 nZfl5PrOxFhZP9BYw1pQw6iQZycc0szvNyF7lazHO8v0hipqC1opkKQdIF6TA8gbSL
	 lcKbKAOknTBHt1h+dPwPySZCOSkGvGhiuHIAqQNGQnnQmMsP2t9QR/iPPKpCkCxZc8
	 0zRq5++0r23T8fwsrFxndwRKgPDeELad1wsnwGnDCoObCQqwltVDHhosoWA0TGJTeQ
	 onu/Q7DZ+HW3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE13239EFA5B;
	Tue,  7 Oct 2025 10:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net repost] selftests: drv-net: make linters happy with
 our
 imports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175983240552.1839985.6510617664801519913.git-patchwork-notify@kernel.org>
Date: Tue, 07 Oct 2025 10:20:05 +0000
References: <20251003164748.860042-1-kuba@kernel.org>
In-Reply-To: <20251003164748.860042-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com,
 shuah@kernel.org, daniel.zahka@gmail.com, willemb@google.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Oct 2025 09:47:48 -0700 you wrote:
> Linters are still not very happy with our __init__ files,
> which was pointed out in recent review (see Link).
> 
> We have previously started importing things one by one to
> make linters happy with the test files (which import from __init__).
> But __init__ file itself still makes linters unhappy.
> 
> [...]

Here is the summary with links:
  - [net,repost] selftests: drv-net: make linters happy with our imports
    https://git.kernel.org/netdev/net/c/b615879dbfea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



