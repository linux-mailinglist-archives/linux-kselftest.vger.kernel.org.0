Return-Path: <linux-kselftest+bounces-24170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B8A08531
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 03:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEB63A83D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 02:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A37119F421;
	Fri, 10 Jan 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6h4JHaM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6D18027;
	Fri, 10 Jan 2025 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736475018; cv=none; b=irX4WFFMIwXkAAhQh5b8+faQYHQ5ns2YKmeOjyvi7guTP7ceBbdjPs1ZqmBuPSqyK+kOycegrNZPlRnjkGFS+7ZLI05wMANZoCNcYg6Cs4x1TvbG+Csgo4Ao/T+8EvULQlteI10TKuV54eQcQjH+vbzxEF9RX3fFTuV8q4bti5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736475018; c=relaxed/simple;
	bh=dGq6QBk0YpBeEpehS4DGo9EFTFFt+UJp+GJ6VVtWhF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lCabht1KEcKeoHw6GI8AvLbuEsBwlKQcl1JS4RcvTwVm8TrmPXVFWtuUDCae0sRNbIxaczq0PHSn2VFfba4x7UPKVOP6GB0mIFRszRLuKR4HXvM5oTuLGa7y7iKB3KNpMycPTxAduKBLRvwhIPqWTJ7R9w5tiEmqJpzGdAdqzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6h4JHaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68358C4CED2;
	Fri, 10 Jan 2025 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736475016;
	bh=dGq6QBk0YpBeEpehS4DGo9EFTFFt+UJp+GJ6VVtWhF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h6h4JHaMBilwzaY4jRhhRTZkzFvaos0FFhiA8csQGrkjX11w5Fid2N0HUxFWkdx+Y
	 IOVi+gEOehoYzOKvCdr7fksDN5v0fZmHcRpJ+YiFlOElG276DKp/UCj7LHXoS7Q1Ej
	 q4quuEnR3Nw+iPw+Oh7QVsOM8HZDAI23FCOSa7Duy7k6+6LaNZbWrOl712n20oxcs9
	 35zgCa3U9LAeKMiz4+2+A/eA/x809FZOhI2cpICCPs5cBSnmjPphb5MAWHYNZcwAHG
	 sTw213TnLasa4dmEyVP5Jhkf/iJ9two8GJQzdB0yNc+y4+AY9fxTq2qee9b8RHtza8
	 pBEXKivvxw7Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71078380A97F;
	Fri, 10 Jan 2025 02:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] netconsole: selftest for userdata overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173647503798.1577336.1474540791245653756.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 02:10:37 +0000
References: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
In-Reply-To: <20250108-netcons_overflow_test-v3-0-3d85eb091bec@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Jan 2025 03:50:24 -0800 you wrote:
> Implement comprehensive testing for netconsole userdata entry handling,
> demonstrating correct behavior when creating maximum entries and
> preventing unauthorized overflow.
> 
> Refactor existing test infrastructure to support modular, reusable
> helper functions that validate strict entry limit enforcement.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] netconsole: Warn if MAX_USERDATA_ITEMS limit is exceeded
    https://git.kernel.org/netdev/net-next/c/e51c7478d23b
  - [net-next,v3,2/4] netconsole: selftest: Split the helpers from the selftest
    https://git.kernel.org/netdev/net-next/c/61f51cc6defe
  - [net-next,v3,3/4] netconsole: selftest: Delete all userdata keys
    https://git.kernel.org/netdev/net-next/c/7dcb65351b30
  - [net-next,v3,4/4] netconsole: selftest: verify userdata entry limit
    https://git.kernel.org/netdev/net-next/c/daea6d23cd2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



