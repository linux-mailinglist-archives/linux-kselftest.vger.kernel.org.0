Return-Path: <linux-kselftest+bounces-13635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839692F362
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 03:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E205B2146D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 01:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F23F79DE;
	Fri, 12 Jul 2024 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1JrSo8Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316405256;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747232; cv=none; b=fmI752sNCSnbaANPlp/ehmPbOvLUKqAtpWaRlhFQoqf92/+/+8EM2+NJnvsUr1yQd9ojoVheccS68BlDXygJ0L6DVh+5N4iYy2dAHWxDlK9nCR68250UpqVVDdQ6YqXdA1qSJiwWIFJbIhKgoHiUeXkkp+nmHT6QhAwPexFh+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747232; c=relaxed/simple;
	bh=uyG4cbU0RRQKaHPnKjY5D8gE/b0J0xyd8hv4929HBOs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZjXQrj5cIW++utNu5vWvzvCZ/AOHf/Oa6vggHgcAQ1UevXdZyuKELR1i7oYBxRXv5qP/4Ah0FaUF3SX2emDnP3RkQWFjp2SLfltkrsXEGYhEYemyrll/HSKKvugqaTcbXlN6/nD67fKIRXaFPDDjdnOTkgnYUDeNSwQhKRB+32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1JrSo8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4344C32782;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720747231;
	bh=uyG4cbU0RRQKaHPnKjY5D8gE/b0J0xyd8hv4929HBOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C1JrSo8QSL4yfS0r2yG34nDSR9y08AgeO+DA5iy+7s2mqsQrN5Gi5olcbAVZGcOcI
	 XlozEkclriXVEkOYsKL5D1PAbaPEczcVBHFfA84El2d7ubR28T6qAT1+EQn1Jf6uNY
	 3vGrZTD2ToCz7ntL7fPDdX7HxEx12JkMFj6YJjylg1eyKodKF+OiGG5FmSjAy5T5+f
	 0veaZDpU6W+qU+BtRL4U/GqKNi9oBvoG202DmSiaD3e0iKP66PVEt4Tsox0xcNXEIO
	 iSjACq23YClniM9vVFc02atutLuR5WwtnMdi/81YL/vLVBPFoI3OPXqrpYLFlxk1mK
	 +QYKsTOOMuVFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92EB5C4332D;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: openvswitch: retry instead of sleep
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074723159.25041.6854557803133417988.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 01:20:31 +0000
References: <20240710090500.1655212-1-amorenoz@redhat.com>
In-Reply-To: <20240710090500.1655212-1-amorenoz@redhat.com>
To: =?utf-8?q?Adri=C3=A1n_Moreno_=3Camorenoz=40redhat=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, pshelar@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 11:04:59 +0200 you wrote:
> There are a couple of places where the test script "sleep"s to wait for
> some external condition to be met.
> 
> This is error prone, specially in slow systems (identified in CI by
> "KSFT_MACHINE_SLOW=yes").
> 
> To fix this, add a "ovs_wait" function that tries to execute a command
> a few times until it succeeds. The timeout used is set to 5s for
> "normal" systems and doubled if a slow CI machine is detected.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: openvswitch: retry instead of sleep
    https://git.kernel.org/netdev/net-next/c/5e724cb688a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



