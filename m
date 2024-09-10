Return-Path: <linux-kselftest+bounces-17557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F46972605
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 02:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85824283382
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 00:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956245013;
	Tue, 10 Sep 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoeS3/yh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A73CF7E;
	Tue, 10 Sep 2024 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926433; cv=none; b=cYG8iwfSmbS8VYEusPG+J9h5LNmPncTnhQ8juCcRmtktJA2w30RNjepE6FJzcI1UCcylkGVZ9cr6AHXuWar7wWLwdxL4cKVW2rtmwSl+bIXB1nmHW4bXWvGF/p9rcqFnayw4dLcHrBk5TtWItBWlwRx0TtFBTfqsGUf9ewwXvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926433; c=relaxed/simple;
	bh=gshxbRjlsuxCQBmbSgS5/MFLrNIDc9GlgrGSqqVJbPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mMVCaAkFoRCL0JKRCy39DNk3VCYfiKgxhwrgtbWeyHitU3R7DJLqAPLVKrHpOaixLu6IbJJ/GeU1ifVvyzIPs+UIEM4VilgKAPfinHlF0jKZfLH6vYEUS3XyKG+tViOF+Oa8TiH9UoAfsFXhHc6rnm92Ttw37rliGJiBBgth3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoeS3/yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0D0C4CEC6;
	Tue, 10 Sep 2024 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725926433;
	bh=gshxbRjlsuxCQBmbSgS5/MFLrNIDc9GlgrGSqqVJbPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qoeS3/yhJsFUM6pJD1jRA9Wj3azkZxWBgQ1/47BMDJ+iHIi3CFFqgyf1R9BR7YNsy
	 52d50w7RBi6Nm7kiOSOiXM5phaZYEHftfXdvCPNXRpKPfwligEYSHmr835UNegH8lx
	 3b47FSg9wJW98OZhLDcnxtbkNYCIMy50LiU+PxfaA5QxmrlEhaMgIRapxUpNDhehdC
	 yIQtR+fVWr+vj1l1e/BKTZYONb020G1ApImYOmNmyNpONTnvxcO6HJAZ6m4UXIOwkm
	 g0Q/h15KDss5hYIXMEJKfCWpn0d+G4A7a1kZy4HuhQR2vGlcWTMtV0u/8S1+yInNRM
	 WTJ4R7nmNHtmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF13806654;
	Tue, 10 Sep 2024 00:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: return failure when timestamps can't
 be reported
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592643426.3961170.381877473938074234.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:00:34 +0000
References: <20240905160035.62407-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240905160035.62407-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Sep 2024 00:00:35 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When I was trying to modify the tx timestamping feature, I found that
> running "./txtimestamp -4 -C -L 127.0.0.1" didn't reflect the error:
> I succeeded to generate timestamp stored in the skb but later failed
> to report it to the userspace (which means failed to put css into cmsg).
> It can happen when someone writes buggy codes in __sock_recv_timestamp(),
> for example.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: return failure when timestamps can't be reported
    https://git.kernel.org/netdev/net-next/c/a7e387375f22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



