Return-Path: <linux-kselftest+bounces-35661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FCBAE5913
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 03:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE4017F482
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 01:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423D1F4628;
	Tue, 24 Jun 2025 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFx0/sYP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DBC1EE03D;
	Tue, 24 Jun 2025 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750727986; cv=none; b=mn/LptTCtTUmi8rV9a/vo1rP3RMmekyVMW0G438FjcYkaGPfLeJC4kFwuS2FzgWQqTSOUoKwueFbKyPwvYRIG5makDhX2ftryA9kX+Mp+Or82JWlq2vfhV8hROCZF6z1tlu1wiReMyuanpxBQ2YusrZ3HhbvQkHkD+uvPuSxPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750727986; c=relaxed/simple;
	bh=2sea/8TDb29cJCbSdhJsFF2RTDYENHm4QTSQy7k4Iic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j/VN0KWEW3gg6i1X1lvBOF9dbVDf/Kcy/tKUG3d4VKuVHooT9KGVopfxdCH+Po9KOfrbgxfsfVV+70O30DGbwlmfYaAmGeVBfuqx0wzvCV2wpsSrodGMV4tsZEU9Sdv4lKGf1IpN1CryUGIsQq/wCcRk74jHhZzfAYo06LLMAeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFx0/sYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF27C4CEEF;
	Tue, 24 Jun 2025 01:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750727986;
	bh=2sea/8TDb29cJCbSdhJsFF2RTDYENHm4QTSQy7k4Iic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SFx0/sYPuXcRzbjTvea0LQrxM+GgZqSfGBrr62cTP+PNYxjmuiEaR/TeRTrb6cK1B
	 RrVX/1jhpDeeg3zvsMqdImCH47JUgFcgmiQCRqz8Gobd4rH52kRklmQr+O3x6lmYvT
	 UaI1j6IeUP5Tuz9+dieFTg9ODK7yw3MzXVD4OBLT66E3RzwB6XfGNkdTh+UafUCk1I
	 vFObtOL5WxsWfnS0Ms+d2+lHuxxt1M6fxh5+np8V5p1xoclbqtvvPa95LY0rrD0xEH
	 SswdAPCJSl1v5HyNOHC0aStyE1jKKwnlV2CVP4P8ap1UpVlBX+NXfK7ZKvWo2J9Mo0
	 PhKYDQEG6Z4vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3408839FEB7D;
	Tue, 24 Jun 2025 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] page_pool: import Jesper's page_pool
 benchmark
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072801301.3355543.12713890018845780288.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 01:20:13 +0000
References: <20250619181519.3102426-1-almasrymina@google.com>
In-Reply-To: <20250619181519.3102426-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, hawk@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, ilias.apalodimas@linaro.org, toke@toke.dk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 18:15:18 +0000 you wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> We frequently consult with Jesper's out-of-tree page_pool benchmark to
> evaluate page_pool changes.
> 
> Import the benchmark into the upstream linux kernel tree so that (a)
> we're all running the same version, (b) pave the way for shared
> improvements, and (c) maybe one day integrate it with nipa, if possible.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] page_pool: import Jesper's page_pool benchmark
    https://git.kernel.org/netdev/net-next/c/cccfe0982208

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



