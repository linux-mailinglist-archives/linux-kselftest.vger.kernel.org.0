Return-Path: <linux-kselftest+bounces-44562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0BDC27471
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 01:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 384B74E10EB
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 00:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687A81EF36C;
	Sat,  1 Nov 2025 00:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRFVAS/C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5251EB9F2;
	Sat,  1 Nov 2025 00:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761957635; cv=none; b=L8GLBNymgKV+9QIMftlA5IrHyLyIyGFijsJioXZSLVzgtxa1ky+AbF92Hq47PRFuttp6VS8AXZ+TktHnYltBWkc99dPSDq/F/W7S3cYmQHiaTiF9v+eF8LNQJ5uenTxsOHvaQHBbAcOXY1IpQgX5Xui5A6UM0lPOl1xIpRgIxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761957635; c=relaxed/simple;
	bh=UOUr9arVMvjmsh2BLepUaAJ6qUS2BLHIb+Txdz08UO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KgMCMSfUoqd6V+jxX/YpvnmLAm46Ix8W/aLFugIpkebJgpMVo3Ei9Lyzx/dbeuXlnFBB3F+Fp9R2NEUjwb0hi+43l6GbPxjqx3LM4dyim78YtmVdQD6bW8TGhIB7dlrmDouipfXsgVi02EGZ3diQADja2vQUmDYe/fwx/M/q6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRFVAS/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C21C4CEE7;
	Sat,  1 Nov 2025 00:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761957634;
	bh=UOUr9arVMvjmsh2BLepUaAJ6qUS2BLHIb+Txdz08UO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HRFVAS/CuxfrK5spxA6LrDiKr7j7r4yWdbiFA+2gMn+JOmOC9zPQEJWAF+EBiAwP5
	 9lSMjLgAWpD6SL6zThi1y67fxGBU+Eq+ZlcVsSvNnCfGvfj6fvMKoq5W+/RrIjWRXX
	 qsE9z/P5ZB2FcQ+KC2avWIWinbBlwPPyH3QNGDYA/eTnx0lZAXFmTv+L1Cy9LyAHaU
	 DgrfqdQqs1pYoI9v52E/a24bY3t2KeOArNtQsEe/Md+ubTLsxX6DqO9SK7o03ox5z7
	 ZCcIIX1goT7isvW9cbaNTVXiebcgxd5r/uYFzO5V4tHNWl+41AxNz0Z32depdyFoha
	 aPJtlBTw91R8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABDA3809A00;
	Sat,  1 Nov 2025 00:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/net: use destination options instead of
 hop-by-hop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195761074.680160.2034732686013542470.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 00:40:10 +0000
References: <20251030060436.1556664-1-anubhavsinggh@google.com>
In-Reply-To: <20251030060436.1556664-1-anubhavsinggh@google.com>
To: Anubhav Singh <anubhavsinggh@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, willemb@google.com, lixiaoyan@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Oct 2025 06:04:36 +0000 you wrote:
> The GRO self-test, gro.c, currently constructs IPv6 packets containing a
> Hop-by-Hop Options header (IPPROTO_HOPOPTS) to ensure the GRO path
> correctly handles IPv6 extension headers.
> 
> However, network elements may be configured to drop packets with the
> Hop-by-Hop Options header (HBH). This causes the self-test to fail
> in environments where such network elements are present.
> 
> [...]

Here is the summary with links:
  - [net] selftests/net: use destination options instead of hop-by-hop
    https://git.kernel.org/netdev/net/c/f8e8486702ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



