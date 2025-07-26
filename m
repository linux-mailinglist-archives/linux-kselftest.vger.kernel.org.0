Return-Path: <linux-kselftest+bounces-38015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E082FB127C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 02:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CBE56363A
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 00:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F42620D3;
	Fri, 25 Jul 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxLFXo6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0228682;
	Fri, 25 Jul 2025 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753487997; cv=none; b=B32sX71grFVrGK5meHLda10mJY6jqgmgeS8DPAlt3X/XlLYLPHcPZcfBHoBCGT+Y5Lj+vB8mzrr3drs4Spqh1d6SxpK62BgxaNJEqS/sXhmIMmwZCaGsRge0nPTrhL3UpRlSgJESTL7HMH3qcBuOjzvmQemXitMZLnSjVuu2fj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753487997; c=relaxed/simple;
	bh=8KfkU61ou7VxdyMPz3kzRRqpWw3+EuaGmFnDA1Wo6Sk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=orhdtzBERX4KTqFxiUF8zgfxOLhuiOZ+Wg+LHl01i1CFMJ5Roba+HJbgb1HdJKp5cy24fAmRL0C/aOATb4qJNqK0VER8jRGLBpPvFBMVcNkpK1EM8zpdtv+91nUjCtHCF9eUrBpFpryWxAaL5sUIq4wnf3V+tu1a3zUbroB/c90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxLFXo6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09345C4CEF4;
	Fri, 25 Jul 2025 23:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753487996;
	bh=8KfkU61ou7VxdyMPz3kzRRqpWw3+EuaGmFnDA1Wo6Sk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FxLFXo6PjEPnH3dsgmOPYnMJSBWD3YWGxYYNfYcaTYVuskKfNvPflHJCp6WkOuAy/
	 TYWKIy3nHNlKfP+1yvKj8w6v4yVQ4nUE69lRcpclCCtwa7ZdvqYVf+wD7NsuIXA/8h
	 eYHjIG9Go1aKLxJigvmIwZylepILsv1pHjf2Ok+62tRocoOcQ/h7LksrHiyC7oU7Ug
	 Bkjd9VS6HbnbxjjPu4ZX1p32m8FMWQJxQDmjmcwtZEUroreXYvyp8+kpxTCghD/rf8
	 8JasZXxNqUZdHrRhElgxZmlsb3gTTsy3/0tJ5sQma6dY0vI1DGjmBUoX801ChPlING
	 p00aNrboEYHpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE7383BF4E;
	Sat, 26 Jul 2025 00:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: Wait for bkg socat to start
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175348801351.3451765.3781597644210857755.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 00:00:13 +0000
References: <20250724235140.2645885-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250724235140.2645885-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.or, pabeni@redhat.com, shuah@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 16:51:40 -0700 you wrote:
> Currently, UDP exchange is prone to failure when cmd attempt to send data
> while socat in bkg is not ready. Since, the behavior is probabilistic, this
> can result in flakiness for XDP tests. While testing
> test_xdp_native_tx_mb() on netdevsim, a failure rate of around 1% in 500
> 500 iterations was observed.
> 
> Use wait_port_listen() to ensure that the bkg socat is started and ready to
> receive before cmd start sending. With proposed changes, a re-run of the
> same test passed 100% of time.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: Wait for bkg socat to start
    https://git.kernel.org/netdev/net-next/c/d1f3dbad6f0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



