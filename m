Return-Path: <linux-kselftest+bounces-4469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2184FD06
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C3E1F22875
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 19:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5084A37;
	Fri,  9 Feb 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DySIMKje"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2B84A36;
	Fri,  9 Feb 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507630; cv=none; b=CNVED13qYSfhn46/2EvPHn4ouDhADxQInPauj8BOgg2PSnsIEsclQpedRO3oRR6oUSkSp6Z8XoasL8rW0IAC0Q+1Nvu+S9XS4MOm0KMJKozYlddqNug2DVWQPtJRJgoBeMiRZS0F1XPkphot97hUwkQ+SazEYau4iOtvOye0I6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507630; c=relaxed/simple;
	bh=YFBErYR8n1RTcVHqtX1w3DmIoFdAkulnJD5claaxj2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YnDvnAibs7RukhExte4/rWDtFvAIMkBJ1Uge1kxEj4JqfytcBZ+hAGN9Z96weuBJpBQ4Z1nD3Vx8Snfy7g902H0TTeqVsudetSe8ZdECVd3oA8To8SRQz8UD5N/5FukcKSczIV+pWt/11a87VEN10l/o7lJ6CZXFmvq/9Bs5zBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DySIMKje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F305BC43394;
	Fri,  9 Feb 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707507630;
	bh=YFBErYR8n1RTcVHqtX1w3DmIoFdAkulnJD5claaxj2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DySIMKjeeLyzgu5l3v1LLLCTUpqa/v3AhF+bY8+osHhNmyYfmsOdA+fIaRW+LO0I7
	 Tda/VJNIGA/A1gYm3Nq82wG1t6M6U/U3aPwgXLwKqUL6AC5q4b+oOF1FQwKdUgdTxA
	 PQ2OsTyBvj51mp0FLz7RvxNY1Ike+XhqIchNHVydzlh2tV8W/SfSCjGb03m8xsXCTk
	 LbzgY3DV5/TXs5nzq1nSKFvJIJxwPWZT8yZa4WDRDn9UK0ZYzy5ur46nndxgI02QMa
	 JQv8YYKQCyfLtwuSJ50WvwNIw14rmzxxsnzxHBPPRfskL7Ej+E57k0V5ojcve2ahpe
	 GDabfye8wJiDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D85C7D8C98B;
	Fri,  9 Feb 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: net: Fix bridge backup port test flakiness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170750762988.32352.8965829570129199791.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 19:40:29 +0000
References: <20240208123110.1063930-1-idosch@nvidia.com>
In-Reply-To: <20240208123110.1063930-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, shuah@kernel.org, petrm@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 8 Feb 2024 14:31:10 +0200 you wrote:
> The test toggles the carrier of a bridge port in order to test the
> bridge backup port feature.
> 
> Due to the linkwatch delayed work the carrier change is not always
> reflected fast enough to the bridge driver and packets are not forwarded
> as the test expects, resulting in failures [1].
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: net: Fix bridge backup port test flakiness
    https://git.kernel.org/netdev/net/c/38ee0cb2a2e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



