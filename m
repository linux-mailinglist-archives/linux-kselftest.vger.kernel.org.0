Return-Path: <linux-kselftest+bounces-21843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5DA9C4D68
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 04:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B58C1F2387B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 03:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF879208223;
	Tue, 12 Nov 2024 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh1oay6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8B208220;
	Tue, 12 Nov 2024 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382825; cv=none; b=njLJvXZ1p0+2aSwyagn3mSBTolfvJMkLcX17PmyFhrTcpzCWYh8SF+3kDs1CdRzj5N0DBrl4TnPGZ7mRgfYBY1bIoBilNy/6DwTT1Aor015FpOWIg1O92Xm5nnTYpFMxlVaGx5UZn78zWXeKRFSFwZloQSUr/Bqs4kByjmbtKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382825; c=relaxed/simple;
	bh=JtmczOi8pvJiKpG31qVAYrUOVOu5b2F3sEl1LBsri/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDK0CAuUjYQkjq5xNyphrdSFP7Yp2CwcA5muvBqMQVY1N9ybGOC3Uo0BVhnonvdvCyEyPSOenRDiT3ufcNQVc4V7M/vS2jDsuAPBdhLSlzRk0dA7ftpgEldtMocRdQX1x2C1Il99Lou4CoOyvv/nPfEUOUl+9INFqrHnLQ/fgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh1oay6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7A1C4CECD;
	Tue, 12 Nov 2024 03:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731382825;
	bh=JtmczOi8pvJiKpG31qVAYrUOVOu5b2F3sEl1LBsri/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nh1oay6ayEQ7wglDqD/umqe6cVG+DN5YXId19rPSlI0R95ZbEMUhEQ/m1LVKTQYTg
	 2SJGZqAkZ1yTSCkl8guy902I9fZk7OuE42gzZAa8D4W0vcR6t0MmZMtEBKJvJeAjTg
	 6u9PR7eC/EUpF/ZiTSahJodtGI5NgJ1st3FJdrHIXe6GqGp4igoO1sFkrsR69MrKcI
	 hb2MwQ2QhMTYHX/TW1Dv2vbBKKq7Stcl8PpHYcxrLQIDyU3EJpwIubaG7axGgRuJCj
	 uTZm4Pa8tG79F4Wch4sHvmAmOnEswHLylndaFngWeI7jR1CFqw1Ff8L8jgptyK4pV+
	 4a7yT6Nzv//tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0903809A80;
	Tue, 12 Nov 2024 03:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netconsole: selftests: Check if netdevsim is
 available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138283550.71105.1842004842601301984.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 03:40:35 +0000
References: <20241108-netcon_selftest_deps-v1-1-1789cbf3adcd@debian.org>
In-Reply-To: <20241108-netcon_selftest_deps-v1-1-1789cbf3adcd@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 08 Nov 2024 06:59:25 -0800 you wrote:
> The netconsole selftest relies on the availability of the netdevsim module.
> To ensure the test can run correctly, we need to check if the netdevsim
> module is either loaded or built-in before proceeding.
> 
> Update the netconsole selftest to check for the existence of
> the /sys/bus/netdevsim/new_device file before running the test. If the
> file is not found, the test is skipped with an explanation that the
> CONFIG_NETDEVSIM kernel config option may not be enabled.
> 
> [...]

Here is the summary with links:
  - [net-next] net: netconsole: selftests: Check if netdevsim is available
    https://git.kernel.org/netdev/net-next/c/43271bb5bf67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



