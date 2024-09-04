Return-Path: <linux-kselftest+bounces-17120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCA396BBEF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 14:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688552841FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F171D88AF;
	Wed,  4 Sep 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4zXEJxP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC11D86F3;
	Wed,  4 Sep 2024 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452432; cv=none; b=ZdgFVBlnKkHAslsGT2RsCC2MXcGJthj+5Z6LCrY70TkuuqsYp9dog3dW8pUwE3DXWupK5f2wYq81nh1cKO730/DnG+p4nehjtKAN7+riovX1vludqvyhbaLndZwl0btMWP6DpGlwGYg7WWvxyochiBv6nt0EhPZDrl5ncRhBYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452432; c=relaxed/simple;
	bh=nszU7t/vHkcN9m5RILpXLHcsnDXP+Nh+QsK721f1qtc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SjoBWb/B0aooJmCzTMWxK6XG5aayGwPt7UXwkkC6WUgM2oRP9EQErROmq6ox2u3HDeJutKCmnhNyTyGOrUWxPMFKmGLdndkf1kob42LkwSTmoiWThwYQ14p+keWkkxexJBFVfaT9mzOZAD3bVkGJ76IwtfoZv1L8MUgHzZuvSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4zXEJxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E8BC4CEC6;
	Wed,  4 Sep 2024 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725452431;
	bh=nszU7t/vHkcN9m5RILpXLHcsnDXP+Nh+QsK721f1qtc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c4zXEJxPcwoVYjUjSdq6PpX0ZnVaKXC+XgnhBfKOw0TFA23KvSkvhjfBA8AluVdf9
	 d1GOu8MnptjenpaIbAiMYaXjtBYnQxYdxlWjYCDNIdormDABtNx7yfE8vVZoY3dXBG
	 u7C7blI2GpKzTjgGNWICjpj+9wqCitCwLpFwMEtVP9lUkpeGwjkS/MyYfkGIL/voet
	 IGWwYG3OiVwSmkyF8U72rMyjNr2H0Ihg9hUtjQLbuyX+5vMcIDO75AM7TOKs6i78Ok
	 MpZzflIjE4uk33NjpBmWCxW4l3YNkmh8Qb+6Ij2fYIV7F3JgW/LJwAJBBhp4Qjl/hB
	 0A347R+BAIa5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342A23806651;
	Wed,  4 Sep 2024 12:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: add selftest for UDP SO_PEEK_OFF
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172545243174.991376.3044755914056065573.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 12:20:31 +0000
References: <20240902160610.66332-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240902160610.66332-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, jmaloy@redhat.com, sdf@fomichev.me,
 willemdebruijn.kernel@gmail.com, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernelxing@tencent.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  3 Sep 2024 00:06:10 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add the SO_PEEK_OFF selftest for UDP. In this patch, I mainly do
> three things:
> 1. rename tcp_so_peek_off.c
> 2. adjust for UDP protocol
> 3. add selftests into it
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: add selftest for UDP SO_PEEK_OFF support
    https://git.kernel.org/netdev/net-next/c/5c26516f0903

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



