Return-Path: <linux-kselftest+bounces-42983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C69BD0960
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 20:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086C23BF0E5
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Oct 2025 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDAD2EE5FC;
	Sun, 12 Oct 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/L4X9Z+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D918B0F;
	Sun, 12 Oct 2025 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292621; cv=none; b=DxafPef5ZQrhpqUEF9Y6ko1e7qCsuDEDr9HqPacAFNEKsjRHgW/m7LzrRFRJxFID50jydmexrJ2j6bIJ94KHsk4G6l1S1+6qgAqKucfu5Bmh8qZEyP4imRVI0TlA9V7A6AxscJZBoPu4AxkhGb5alpdSQX5fgWjsSLPzz73HXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292621; c=relaxed/simple;
	bh=Ysge4p0Fzzg+AZAPRXYrt5LM2kUgpM6h22sbhXB1iaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OXqmEEhdmPzsxwzgO1S3IsXWF0eIcQqZVeTangzP5jDpoQA5OSB0uNDRe2/FGssW3/rgcdHE3NdT24Dw2bvmOFOAJFM2jDNpammiAz+W2soIXwAX8bIsMsAeDeG6Jfa6Pd24C6EBFc7fMo/gZcFdpoHq32N/OhTMl0LP3Ax2uMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/L4X9Z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A971CC4CEE7;
	Sun, 12 Oct 2025 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760292620;
	bh=Ysge4p0Fzzg+AZAPRXYrt5LM2kUgpM6h22sbhXB1iaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q/L4X9Z+MKSvmEvsh2DayUsQHu786z9nokVaXjcYZ/jo851hF/Fwaj9jek86LfXx3
	 FSksZeG1OKXfmhopy8lpPIRiCS/fNitSCnhTsG+W1fLpk/ymHnvy8ZeFp/y2OoX3h/
	 4fGgn8I9JXATb0NwowWwuGXxbbFQx8FGoxXecJmJEOh3P+ZSABiUG0sttTxGlsDr3e
	 m7rDNlpJ1AO18BMxIxPpMe1z7eqI+XFg/F2C0mtfARdlHluhQUpmxH2mIkeoJhcxq5
	 GloYiZhU2/MRgVI+l5d8SyjRw9Cm2TCeststd7rGotJDm8VOOScPpl/1ymtt+FhrQ4
	 fGZJa/INH5Sug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF43809A1D;
	Sun, 12 Oct 2025 18:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] selftests: drv-net: update remaining Python init
 files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176029260701.1713934.10688397681954330342.git-patchwork-notify@kernel.org>
Date: Sun, 12 Oct 2025 18:10:07 +0000
References: <20251009205629.379829-1-sdf@fomichev.me>
In-Reply-To: <20251009205629.379829-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
 horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  9 Oct 2025 13:56:29 -0700 you wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Convert remaining __init__ files similar to what we did in
> commit b615879dbfea ("selftests: drv-net: make linters happy with our imports")
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> [...]

Here is the summary with links:
  - [net,v3] selftests: drv-net: update remaining Python init files
    https://git.kernel.org/netdev/net/c/68a052239fc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



