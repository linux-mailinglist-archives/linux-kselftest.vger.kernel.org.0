Return-Path: <linux-kselftest+bounces-41042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FADB4A8CE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 11:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D2F361CA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 09:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979A3090E5;
	Tue,  9 Sep 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVcn1K7t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F958307AEA;
	Tue,  9 Sep 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411404; cv=none; b=jzVZ/ftASLhgitufLXuFtWMERwuMaUhzx133LOSR5z3Wlop9+8egM96XaPWLm5ittAgjBpK4K6kNh0rVXYodtheohUKnnnz+SdZBymbMS9W3QPnVwtb7c4u9h4B+Cn4QnoiTfNdpVOEQghFZTZda81XRetRsF/UEbTQtH2SyHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411404; c=relaxed/simple;
	bh=/EtGdIHS39Iac8fH0acLYR2zMPwIstesB2+6J8P3RI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qd2TCz/y2lgE0ph4gStRy7AvZGSWEg0ts26pJ7F/ReFNT9KthhwfFZF7qqYTBfyU4A7M5XzMGGckGgJoC3PQnkPXRsPI/uSkxj18oRy2OorpwCf5YadUWYE/HxfphlshKp5v9vD/DUuUQlQ/nCZieZPKNNWh1y333xr0FE+CoI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVcn1K7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F79EC4CEF4;
	Tue,  9 Sep 2025 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411402;
	bh=/EtGdIHS39Iac8fH0acLYR2zMPwIstesB2+6J8P3RI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sVcn1K7tUbl8/87lFHnqgElZU1UZyjTLemrjxGr1Q+8zOI9TmAvnwHwK8XkI4Ue9H
	 7epBMbqeAfv8lOFGQla8QzrDvJO9Yc26DznwDa6fnPfOu3XZA/c49TgF0btfNf7u/R
	 k7t4mvpLLaOlIokQujGBECWIddU5YjUq7N5m9w8b9tkl3Xm3P6kwENZehxyQKlvwon
	 4pfFmw8UMdhhdyFvLNm5VXRHNiDSWuqxTM35kbPIUxFLqQokxq3jVK/Gi9lUT1rNTK
	 gFxsgBtyMv2WqULmpmzSFpplJBxc3ZHHW782yjyWAnIWHZv+xLN2Yenh2Fl94kIYqo
	 9JnBnnrKNB0Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ADF383BF69;
	Tue,  9 Sep 2025 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] selftests: net: add test for ipv6
 fragmentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175741140600.605175.15205546890528795882.git-patchwork-notify@kernel.org>
Date: Tue, 09 Sep 2025 09:50:06 +0000
References: <20250903154925.13481-1-bacs@librecast.net>
In-Reply-To: <20250903154925.13481-1-bacs@librecast.net>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 gregkh@linuxfoundation.org, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  3 Sep 2025 15:46:01 +0000 you wrote:
> Add selftest for the IPv6 fragmentation regression which affected
> several stable kernels.
> 
> Commit a18dfa9925b9 ("ipv6: save dontfrag in cork") was backported to
> stable without some prerequisite commits.  This caused a regression when
> sending IPv6 UDP packets by preventing fragmentation and instead
> returning -1 (EMSGSIZE).
> 
> [...]

Here is the summary with links:
  - [net-next,v6] selftests: net: add test for ipv6 fragmentation
    https://git.kernel.org/netdev/net-next/c/aeb8d48ea92e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



