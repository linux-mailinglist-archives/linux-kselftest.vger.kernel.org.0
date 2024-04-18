Return-Path: <linux-kselftest+bounces-8292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F808A9101
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 04:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4C21C20BFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 02:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92B945BEA;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL200nNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C83BB3D;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406228; cv=none; b=UTOhH4zQtq1gWcE8cDZChCjKiJeyuC72P89WtZzp9igMMC/6laQjAmEE05p9DKbZ26ISazqEVQmLMIFsTtkVaqTwcK8qUEggudBl24XfUAaPpoufo6h521F7XVreTE7gKtmNurmBdHKh+vdsBMWC1u5n1Y4dh5rGWxZFKwdl9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406228; c=relaxed/simple;
	bh=RAGC14c8Q1nFc1rexV5dELq1NYAVyKJAmwHd8XkO/3Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ChRUcx51NgdyDBkLLlHxRKUSppu9UuLKFs77ffS33RrljSB61wrVmzObWvhJljVV0uSvsRlquJPONMO+iLsATBC91Wq/fYqGHldC9k8OH21P+ZvSE5V7VHQfpzsOVrVstLjjpiAw4mc+T2+2F8Jz0qtq8MLKxvbempbeLB+Jods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL200nNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56918C32783;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713406228;
	bh=RAGC14c8Q1nFc1rexV5dELq1NYAVyKJAmwHd8XkO/3Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZL200nNPgfts9CYklTGCBByTb5/Q7SAoubfAXD1em6rPGk72YL4L/UyifMj04HZm7
	 llICGwX0Bu3X/sDKbXBNhzYsdr6v5W1YpSiC8ayFll071gHWZ38mrcRPGK9JTYvqPJ
	 J/OfBCS0eZGZ5KEwSDP6nJkhNHpFlv+O7bi+W025u7/DjbmpmDOfBMGP8/aXBtcc6x
	 JyZvhotDIQ0W8kHVtUkHGxovTY6AQf0u1Zm40eQoTnpLbiHaUc+veo2KXSalzf3Ggx
	 tW7nIg3bqaDfCJJDD9EL/009CEOMXk43UC3DSZa3O7cODQxLb5Gai/5rPX1DccafmJ
	 1td38/cbpLO2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4169AC4361C;
	Thu, 18 Apr 2024 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: kselftest_harness: fix Clang warning about
 zero-length format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340622826.10413.6848935617606326222.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 02:10:28 +0000
References: <20240416151048.1682352-1-kuba@kernel.org>
In-Reply-To: <20240416151048.1682352-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, seanjc@google.com, shuah@kernel.org,
 keescook@chromium.org, usama.anjum@collabora.com,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 08:10:48 -0700 you wrote:
> Apparently it's more legal to pass the format as NULL, than
> it is to use an empty string. Clang complains about empty
> formats:
> 
> ./../kselftest_harness.h:1207:30: warning: format string is empty
> [-Wformat-zero-length]
>  1207 |            diagnostic ? "%s" : "", diagnostic);
>       |                                 ^~
> 1 warning generated.
> 
> [...]

Here is the summary with links:
  - [net] selftests: kselftest_harness: fix Clang warning about zero-length format
    https://git.kernel.org/netdev/net/c/caed8eba2215

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



