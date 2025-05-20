Return-Path: <linux-kselftest+bounces-33363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C03ABCDC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 05:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991561B64618
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3AD2580F6;
	Tue, 20 May 2025 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGZpmJlr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70A257AF9;
	Tue, 20 May 2025 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711212; cv=none; b=qfydSefkFLU5/zHsZJ135HWgfpcwO2Hlo9WbfVQVB4NouE7hZwZYLNieNIyRo69nDKhI2vyCS7MskHJEak9TstZfCMJs1tQ7iP2UUcKbz7NIgQlIlcNcrHJq0Nzr0Dzddqchj1MqbtTchi1NGaR0wCwRq1dQL4hAIk087ek711U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711212; c=relaxed/simple;
	bh=4NJFK9l8EDUJ9nC3w848koeWn+lxPfhikyvdEaeMeus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iHEA1kkDvo4NfWeHBQBr+XzMk85zi0NzyWucGTpJtUpeGEl0Vb3daln2itG5ahKb5x+Uarnk5H6hdn202skGzEtKqO2qGln46MQkXQuDK2NQUq9k1P77ptCqHMf/cziHdW4RtS7KcrQCaW2Eo2hWjtZYc8OPnen+2xp86nZHN2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGZpmJlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B63CC4CEF1;
	Tue, 20 May 2025 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747711212;
	bh=4NJFK9l8EDUJ9nC3w848koeWn+lxPfhikyvdEaeMeus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WGZpmJlrR4a+zRQpTZM32/DKg0KjS4d3UQfLcrfOxHXW7a1nwL8f0wNS652OmLoyU
	 KYQo2ZCB+wet5GtHz91rvm1ycQbJG2q8sPeybvGTHL0j6now95UGnhc+4tHd7LgDjW
	 ctWOKl4tXegQq9ktEIjV4JEk5QdoZJfTnzPfWuXVixDVpNO4T/ArL97KPL947/3WqK
	 N9SvH4nHcyxv7N9lT+P8JtuZd7LTQGiCDSXL06SYSxdKeWvpc9OtHgrtAfSGLQ7Wqk
	 y8g9bF3/50UiOBtj8UYiyv6y3VTKvbCrCmzG8HawlHJjDJS48bvbnbhVYtEkKhC3ob
	 roSGOrdEZZrkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D35380AA70;
	Tue, 20 May 2025 03:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: drv-net: Fix "envirnoments" to "environments"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174771124799.1146050.18144156324943651513.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 03:20:47 +0000
References: <20250516225156.1122058-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250516225156.1122058-1-sumanth.gavini@yahoo.com>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, willemb@google.com,
 petrm@nvidia.com, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 15:51:48 -0700 you wrote:
> Fix misspelling reported by codespell
> 
> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
> ---
>  tools/testing/selftests/drivers/net/lib/py/env.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - selftests: drv-net: Fix "envirnoments" to "environments"
    https://git.kernel.org/netdev/net-next/c/c6a957d06791

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



