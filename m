Return-Path: <linux-kselftest+bounces-24273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B3A09E5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 23:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A802616ADB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C4921D003;
	Fri, 10 Jan 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCXsscUr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7D21C9E4;
	Fri, 10 Jan 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549409; cv=none; b=WPdmesxcMEX9CHlydfXuwsLoMYhobJPQtL8NLIxapikfp9nvYZntZWoN9JWAnrZMbGl9QPjrWh6BWHw2zLiQftSIwUXycKpaaohtrIDa6MqzNpFX35edANNm9YMTWN3ynPzde3gUvO0/BnW96Nf3h0YNMVV34DPv73r/PR/j2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549409; c=relaxed/simple;
	bh=Huf/pE6TMUQr+vLB92KqCr5ieXQ31aInwc0R1YC5Auo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B23bXb0K6ZXZqTKd7Rc2zlbxiZjmn3gcvC23VZKUkODsRg33Sblq/Bih4pqD3aGhTBudnBdlJIQTD9lGUuhY/9r8uW6D2JcqlKp4rGQGpxPTg4p8vr4OnttLmwSizx/yuzxbSMB0uWav/7ZFzp/LHPG+mbEGOlM0vAjXICOT7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCXsscUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126A6C4CEDD;
	Fri, 10 Jan 2025 22:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736549409;
	bh=Huf/pE6TMUQr+vLB92KqCr5ieXQ31aInwc0R1YC5Auo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QCXsscUrHfdYTpT53PBuAS6DYwHjZJ7y0RlCy3gS3Drl7nh5mlmL50VJiQkqsoBCA
	 dd5ZWOGSpcuFvjlL8BvvmuHhjv+a1YGmHqaXEkFoIRTNvGHQkKd9bh0JxI2FkntXK1
	 UuYKG1HraFjbP31P8fpGlyGwfIErmR5pDXbfP0irp00iEjDHjU7hxCPoCk4z2gSFh5
	 3xtiQIl1BKLXHKbdFdXFicjE0Bq+D5rttdSNC4kHoZVkynQxcQZt0aJ+pCtwg1Rxso
	 vLgxmvnhYX13FjtX+Xy+zBe/WhV0x+Zf8vhzoX9r/nd5Uc8hHbjlbCsmGUgxuxyv47
	 cwvZNLSJHwQ+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2D380AA57;
	Fri, 10 Jan 2025 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: veristat: Document verifier log dumping
 capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173654943090.2227300.18196413103615549239.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 22:50:30 +0000
References: <d57bbcca81e06ae8dcdadaedb99a48dced67e422.1736466129.git.dxu@dxuuu.xyz>
In-Reply-To: <d57bbcca81e06ae8dcdadaedb99a48dced67e422.1736466129.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: eddyz87@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 shuah@kernel.org, ast@kernel.org, mykolal@fb.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  9 Jan 2025 16:42:29 -0700 you wrote:
> `-l2 -v` is a useful combination of flags to dump the entire
> verification log. This is helpful when making changes to the verifier,
> as you can see what it thinks program one instruction at a time.
> 
> This was more or less a hidden feature before. Document it so others can
> discover it.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: veristat: Document verifier log dumping capability
    https://git.kernel.org/bpf/bpf-next/c/95ad526edebc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



