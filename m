Return-Path: <linux-kselftest+bounces-46410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98649C832F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 04:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AB4E2857
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AB71DD0EF;
	Tue, 25 Nov 2025 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5J1Ioue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA23FFD;
	Tue, 25 Nov 2025 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764040257; cv=none; b=giqkZN1t7JLnRu6Wje8+4KZ7hC/IVk9Zh+mTOE3JDWz1pCKbuGkvWx4oaPaWB8I2VD/f4R2ce7U6l61X0FpEgnick3P5R9db3XMLB5JkrY7xvDqSKU3v/C01l2RJHvvrbc4LQdy6QTw1M++KttGE0CBXH+JoD9E1gSTzeyiPyBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764040257; c=relaxed/simple;
	bh=c3dQl9qBpkyZCPX218+UL6dMyDicas++BTXTRzI8EEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k4FOno0I5m+MkEajpNFAeQY8mozppJcLyaB8PKHWreNFAuHAw0vFOHKZ5k54lbxkwjbMBP9UCGFp3RlWbBsbn+ByaW+dOyCQtiKtG0elQ3Kx/rtyU6RSq5us+uGErEvBPORV4W11q/51iS/56kObr/MDMm43RSCzCGLkRONNXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5J1Ioue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A34C4CEF1;
	Tue, 25 Nov 2025 03:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764040257;
	bh=c3dQl9qBpkyZCPX218+UL6dMyDicas++BTXTRzI8EEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z5J1IouegTcba91Wsv0m+5DIBk3TUuAoRz0jfOEv6xACP1ko5rZ3gDJbVSX5QeRPD
	 EwAB5R82mNPNLVmkBcvS5duiKt0taK7oehvIazEnuzUA3ae7YzFQ2X6ueODId7sTmp
	 mcDgA+j5DFhUB9m9Nl2NiHcgqyAoUYdsQML/V8rLSL/TZdoGheju0Shx/RYifpEdCa
	 svfzYWdHR6QKUSVx3UEro5E8+Qy8kWeRaZcrIhCMr+ElOsxhQdX4BDQVxX7wQtelj+
	 Cyjd1HejyyeTYcjDoDXFuQqYaHJGbDYVrIvBIijrCuhdiOVBfdi9vl+57A4xGuyJmJ
	 Uz3lN9mwig0bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B473A8A3CA;
	Tue, 25 Nov 2025 03:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] selftests: hw-net: toeplitz: read config
 from
 the NIC directly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404021999.167368.18155495583479444469.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 03:10:19 +0000
References: <20251121040259.3647749-1-kuba@kernel.org>
In-Reply-To: <20251121040259.3647749-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 willemb@google.com, petrm@nvidia.com, dw@davidwei.uk, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Nov 2025 20:02:54 -0800 you wrote:
> First patch here tries to auto-disable building the iouring sample.
> Our CI will still run the iouring test(s), of course, but it looks
> like the liburing updates aren't very quick in distroes and having
> to hack around it when developing unrelated tests is a bit annoying.
> 
> Remaining 4 patches iron out running the Toeplitz hash test against
> real NICs. I tested mlx5, bnxt and fbnic, they all pass now.
> I switched to using YNL directly in the C code, can't see a reason
> to get the info in Python and pass it to C via argv. The old code
> likely did this because it predates YNL.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] selftests: hw-net: auto-disable building the iouring C code
    https://git.kernel.org/netdev/net-next/c/f81171fecd0c
  - [net-next,2/5] selftests: hw-net: toeplitz: make sure NICs have pure Toeplitz configured
    https://git.kernel.org/netdev/net-next/c/27c512af190e
  - [net-next,3/5] selftests: hw-net: toeplitz: read the RSS key directly from C
    https://git.kernel.org/netdev/net-next/c/aa91dbf3eda2
  - [net-next,4/5] selftests: hw-net: toeplitz: read indirection table from the device
    https://git.kernel.org/netdev/net-next/c/c0105ffc5056
  - [net-next,5/5] selftests: hw-net: toeplitz: give the test up to 4 seconds
    https://git.kernel.org/netdev/net-next/c/5aadc155849e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



