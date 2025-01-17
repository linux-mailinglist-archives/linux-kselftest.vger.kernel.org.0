Return-Path: <linux-kselftest+bounces-24690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECF5A147A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 02:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EAE16ADA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2354F218;
	Fri, 17 Jan 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgy29vYc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3427456;
	Fri, 17 Jan 2025 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078012; cv=none; b=kXcpcSs32BURsFWjhPMKPE016K6dFVcmvnD2vMnzTbQKXK0cCXUEv9PgSimmQaHmuYHRfn4DAVDS1ljBsBmeTzY2qrUkn2dIvau5Es1yJtjFChqDNe8KOkKJ7DWzYBl5xmmJ4JHg38afP2HYI4PWNOaW1SE1Kn21pOJNc/ko4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078012; c=relaxed/simple;
	bh=lga/gYG5eFhaDTuVk8ux0ZHrXkZBBoMK7Gi2Q8if53A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jUZU2ECTb4ECIz6WmNvJvpxE8zyRsvAzXOzbU8vVMnjYk19AaVF9Psl6zxxQ6VYtfjDOZaMubRu0zQEhlsePyx26oOzVaoiWkNYdQHsztG+J9JHcrIF0ji35+2hclzTNsnbAB8PVUG9PMb0QwK9vEfPFQmS/CgxX2J/orvkkUog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgy29vYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C15FC4CEE3;
	Fri, 17 Jan 2025 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737078011;
	bh=lga/gYG5eFhaDTuVk8ux0ZHrXkZBBoMK7Gi2Q8if53A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kgy29vYc4B6nXJOJWjKa9qc8swPP/MVfE1WjNSVISJxbtBZEUJ+4JeFWq0Llv6h99
	 LtQccPe+/PBldZnlwD0fvoJDYjlX8vh6QsCX1dpJajJe7lmm4Cc/N7H0EVOBqOTz5n
	 ggo6GFTwYoYW4BMnslpvG+gK1Mb/XzlUJkAaMZBxWs51IVgeHlNdSnpDtgb1mDY5zr
	 rkU7OjWRyKiBc6dLDwIIk8dR/QyZctwbpTHwaIqs2wzj68QHDzn76Hl714PzxgEDMe
	 I7+mIKTQyvJ5cUx0Pqp2xI+PdVBzqYmSoloj9wLrRQc2M1LQAisn+TvI416E432DKZ
	 uYtK7qyZl/T+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACBD380AA63;
	Fri, 17 Jan 2025 01:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: packetdrill: make tcp buf limited
 timing tests benign
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173707803449.1652211.2546746213800246175.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jan 2025 01:40:34 +0000
References: <20250115232129.845884-1-kuba@kernel.org>
In-Reply-To: <20250115232129.845884-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, matttbe@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 15:21:29 -0800 you wrote:
> The following tests are failing on debug kernels:
> 
>   tcp_tcp_info_tcp-info-rwnd-limited.pkt
>   tcp_tcp_info_tcp-info-sndbuf-limited.pkt
> 
> with reports like:
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: packetdrill: make tcp buf limited timing tests benign
    https://git.kernel.org/netdev/net-next/c/3030e3d57ba8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



