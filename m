Return-Path: <linux-kselftest+bounces-4185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5984B17D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 10:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5676FB21E5E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732D12CDBE;
	Tue,  6 Feb 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fxhcc8GA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23012D148;
	Tue,  6 Feb 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212428; cv=none; b=NdJE+HfxDh+qYKcHlPG/nTFhIhNazi9f1XTXFqGID9jtqjQM6czH0Kt3Ae1rYm1eqnXKSIOin8P0JgagPqYAd5aheGVINyK/d1DBGYHb6eqLPqfwM9OYukTlKE54z/Ny68HY4z3/yTPHQNV/Wo3q0TJ4mO3MdLchg9pel0e3/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212428; c=relaxed/simple;
	bh=b5Q0bEGFlliOgO8ZPlU1DX/9fSkj/V0AMapQ6831k+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=He2/eQ8USVIvU+N87COZsh5rVwv6WIcmNQHw/dt62883HVE7UZJUsUp4um2SFZo92lm+b5i6SPHQu9SrVfshKGorjSW8bnnEzjOZSBqIfbmDh1iaNO6V7sMEFEvqfqsR/gak8uCPgTQok8pos/wevLP1VkNElhZMwZpto/We2D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fxhcc8GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 865D1C43394;
	Tue,  6 Feb 2024 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707212427;
	bh=b5Q0bEGFlliOgO8ZPlU1DX/9fSkj/V0AMapQ6831k+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fxhcc8GAAwMtDqDlpvW/wvOCt0kgP0Kl6DS7ncS9vJnXJ/8NIW/WZyvkLrcy0c25c
	 EJSOXEk0Oas+0x/YvDINKldHlMO58doR6okuTCqzPCifsfx8pl4rytWP6PWkW8y5tr
	 Dt3xIQrNLvWNxPovrHjxCYKwOKOuOOkbj6pEPNIMYHZzVU72W/Ea0R416olnvGLhjO
	 OHgDzstf/ZccPRpqhnuczte8W3bZSx5RLCcNldQnd/uSZP791pSGJjO5RMdlQsT+f7
	 dchzQhln0QiXPO1rzVhZw0coL1pa4GSTA0vB2OuRv3CLGEZCvXzERLKkTSPwDVPvUM
	 u9LZuSWCaTDzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C8E7D8C97E;
	Tue,  6 Feb 2024 09:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: Amend per-netns counter checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170721242744.16343.3381362430812280443.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 09:40:27 +0000
References: <20240202-unsigned-md5-netns-counters-v1-1-8b90c37c0566@arista.com>
In-Reply-To: <20240202-unsigned-md5-netns-counters-v1-1-8b90c37c0566@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com, horms@kernel.org,
 mnassiri@ciena.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  2 Feb 2024 02:24:59 +0000 you wrote:
> Selftests here check not only that connect()/accept() for
> TCP-AO/TCP-MD5/non-signed-TCP combinations do/don't establish
> connections, but also counters: those are per-AO-key, per-socket and
> per-netns.
> 
> The counters are checked on the server's side, as the server listener
> has TCP-AO/TCP-MD5/no keys for different peers. All tests run in
> the same namespaces with the same veth pair, created in test_init().
> 
> [...]

Here is the summary with links:
  - selftests/net: Amend per-netns counter checks
    https://git.kernel.org/netdev/net/c/b083d24fcf57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



