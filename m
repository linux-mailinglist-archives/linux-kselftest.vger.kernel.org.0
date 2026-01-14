Return-Path: <linux-kselftest+bounces-48905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF9D1C3EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 04:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7F85300E028
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178722E62C8;
	Wed, 14 Jan 2026 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn9XFMlG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8610184;
	Wed, 14 Jan 2026 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361016; cv=none; b=eWUukvwsN6LVlFxsnoEWBDG8A1998o8QFi2DTdCn/aiFtGwW2op7s3ldCsrRZRNjGeuhNnCONQj/vKuECDswXt0yn6MaL4lAq7MO0oVgSlAOEYcqs2K+1eMKvn0o3cHijmVOdNnNzaR+WYNWyBERFeoPsnTSAOHVLSVWUhXbhsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361016; c=relaxed/simple;
	bh=bhaghKMLYIwR99ftVcdNg+TqXXijiVurTe2oOxVRWKY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fGFs+PKgOK0ZO5r7Uva4xdzExvilYUVSasAhY55X8qYPccc6HyCx5RcfIva5f4+yC/PHw2uEgwYPZ2OA+i6Z5NU+Hp3zCAdmCQzao1ukv1bFiBhHd/WsV2GiADeCelQ4rEOWgV8tUApH5BCVtrZvmRYPDGWT+b+z5+agzGNDoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn9XFMlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8D9C116C6;
	Wed, 14 Jan 2026 03:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768361015;
	bh=bhaghKMLYIwR99ftVcdNg+TqXXijiVurTe2oOxVRWKY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gn9XFMlGwl7UgVMacFa4NReOBAF3pEH8QRroK+H3ysG1kwxbXJr/0eKRAL/dFlY1l
	 oLdlZ+cl69pM+6uUT8s5jwxdxHG8P8qMPqxMytT9DDzDt9G7E59SRiuzTueZkueZFq
	 /7ktzoFl1eIh2CRyjufGp25vYyeq52eQrUAZ+X6XTtQ3VtSPfp7NFk/KI2lwLEygDb
	 IQguykdX9w9aKPirPKzgdemdgSXpB2I2lpWL31AF0bWNta4b2JMAx1iq24sETF4Ghg
	 yNBKLYxViJ6vNvL3xScm//Zm0pPmvz205xZj9Bt3N8zT856zr2W16wVwDDGL9+nxtE
	 4P8/Q82ngxz2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DFA123808200;
	Wed, 14 Jan 2026 03:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] selftests: Couple of fixes in Toeplitz RPS
 cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176836080865.2569860.17335295751025998084.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:20:08 +0000
References: <20260112173715.384843-1-gal@nvidia.com>
In-Reply-To: <20260112173715.384843-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 shuah@kernel.org, willemb@google.com, petrm@nvidia.com, lixiaoyan@google.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 19:37:13 +0200 you wrote:
> Fix a couple of bugs in the RPS cases of the Toeplitz selftest.
> 
> Changelog -
> v1->v2: https://lore.kernel.org/all/20260111171658.179286-1-gal@nvidia.com/
> * Use a single mask variable in the second patch (Willem).
> 
> Gal Pressman (2):
>   selftests: drv-net: fix RPS mask handling in toeplitz test
>   selftests: drv-net: fix RPS mask handling for high CPU numbers
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] selftests: drv-net: fix RPS mask handling in toeplitz test
    https://git.kernel.org/netdev/net/c/9d48c62f6b4e
  - [net,v2,2/2] selftests: drv-net: fix RPS mask handling for high CPU numbers
    https://git.kernel.org/netdev/net/c/cf055f8c0004

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



