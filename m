Return-Path: <linux-kselftest+bounces-19771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55A999F4A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 20:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77001C23153
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A6E210183;
	Tue, 15 Oct 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EatNm/cB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112731B3950;
	Tue, 15 Oct 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015230; cv=none; b=Oc1tcRBI7feudVYKSpbB11qbxoG/+HYhH3HLIPJVqWM6aMhM6ElXjboyIfIJInbo/QjieRIynSZddBzOjbW0jBkSEhkpk+/7HEgQGcEB2caQViLf03GbijzIXC53p9psEkAiodB/p3wLRIBtwqa5Mk/m94PoXLY+ErzxGm/Gxow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015230; c=relaxed/simple;
	bh=lpbB4zBvabiC+qAlL68upeccQ4XTAZm+z7OB3LiXtIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p5rV3dCnSuZoRFtsFEuBaRrmDwrWXkN07aQT5nu8+pogbWsqMunhCePCqed5psjMsHHLx8a060wczlOoRA3DCXT8m4qasK2bjFm/0+zpKn9nLGqNjsR62/8Wq/sa2kMpdCBZwrGeT31rBZnNDsQZysODNGegMO1vRaajF6BImuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EatNm/cB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4ABC4CED0;
	Tue, 15 Oct 2024 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015229;
	bh=lpbB4zBvabiC+qAlL68upeccQ4XTAZm+z7OB3LiXtIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EatNm/cB8Ug5PL8M8DCox35cExWgIaqGH2Sa9LYNCQy9IjRzt0eTV1+xfUAsUzlsa
	 /3V2DhyXsqcwcvv3/Se6D8iGctkkzcqx/GCPBEbdvFM/3pPa8gdM6E8ejEtW76A/de
	 DX3LCH0CaasGt4Z3EgATy7jICY59ZXAfLiMI/91vG3WCpEoC+EuTDrN7DW6F+oEa9G
	 qBX1KFtwwi/jPskGD0EXydzKC1cop4//x+AgTfC/wtdX3dw6JXlYqKU50iX3ey5Zco
	 afkMS0jmJ184G3vOo3DNhea+4O3OX1YYDfMou3TgjlXCkKYw+WGy9n+0l9wDHpTLbi
	 8x+UIBPyWytFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0813809A8A;
	Tue, 15 Oct 2024 18:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] mptcp: prevent MPC handshake on port-based
 signal endpoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901523474.1243233.15564285937564337583.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 18:00:34 +0000
References: <20241014-net-mptcp-mpc-port-endp-v2-0-7faea8e6b6ae@kernel.org>
In-Reply-To: <20241014-net-mptcp-mpc-port-endp-v2-0-7faea8e6b6ae@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, cong.wang@bytedance.com,
 stable@vger.kernel.org, syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 16:05:59 +0200 you wrote:
> MPTCP connection requests toward a listening socket created by the
> in-kernel PM for a port based signal endpoint will never be accepted,
> they need to be explicitly rejected.
> 
> - Patch 1: Explicitly reject such requests. A fix for >= v5.12.
> 
> - Patch 2: Cover this case in the MPTCP selftests to avoid regressions.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] mptcp: prevent MPC handshake on port-based signal endpoints
    https://git.kernel.org/netdev/net/c/3d041393ea8c
  - [net,v2,2/2] selftests: mptcp: join: test for prohibited MPC to port-based endp
    https://git.kernel.org/netdev/net/c/5afca7e996c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



