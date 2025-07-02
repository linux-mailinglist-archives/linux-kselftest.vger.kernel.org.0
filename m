Return-Path: <linux-kselftest+bounces-36232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C9AF076A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 02:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1FC7A6A63
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7740FB640;
	Wed,  2 Jul 2025 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+oULs7p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3D1A26B;
	Wed,  2 Jul 2025 00:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751417389; cv=none; b=eDyCO12wRstxtnJ4xUQVFVzYhxyfEWCU61zyB7JywJjN6H4DUbhYP7QJtOeO9nU/sd6HhxsY/AEZ14MlUNoatJceQLItsOoT12M+M6FPUsr0QRlfZYSyt/d7NE74Rzjo3LV0Odwh4GXakjdmxi4vIJbjjJuPPANCChtiFj7ULhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751417389; c=relaxed/simple;
	bh=GP0PuCKZEQ/V9VgJSdJa34Zo7nvxZUDs6kHnohiQCfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HFAbgVUD5/xvqFqKRFTt70hQVwyQ4bz+cbv9OKXMSQ9JSUNqKALIFWWFIoZyQHwz7DsUXIo+DkkfmM2Mukbt8h1xzblW3bcJUWSpPlnaEK1y4KH2EYQW9Itm2gIOwCjhr1dgvJ/5vqZaSgbIqeXCpt+cTgkcbKyh6FhfLkHDxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+oULs7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90F8C4CEEB;
	Wed,  2 Jul 2025 00:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751417388;
	bh=GP0PuCKZEQ/V9VgJSdJa34Zo7nvxZUDs6kHnohiQCfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X+oULs7pRX1CgyRmh9nursF0tDUuQN4IqwegmGWZ4NnOy9HpqtTlNIuDL9P/ZPFVt
	 Hb2EXuoBUZYwyFStG/t6hj2XPwBrOEI+pZTFWV9KdtHo5WB+0zSgI4Elu1YRU32val
	 pyDyd9eJTA1KRaaXmMNIEam6Gv4nelcrbPLd9UP4Hp30w67wEzgbOpaZFezMyHF+W8
	 tGw0vF77mqUlWOwOdDA0hSm7/jM2R4oJuNOAMtxHbZYJR05HpZnS7Eg3vNQjqjaMe+
	 MremE2S6SWFZEXxLIvKev3q4iuRcR1ov1PN0p0DhVWh0C9cgQKTzxWxKGLVXCf6b2j
	 5fOXA1SChX8KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4A383BA06;
	Wed,  2 Jul 2025 00:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/2] selftests: pp-bench: remove unneeded
 linux/version.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175141741351.160580.4880481171336535052.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 00:50:13 +0000
References: <20250627200501.1712389-1-almasrymina@google.com>
In-Reply-To: <20250627200501.1712389-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 toke@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, lkp@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 20:04:51 +0000 you wrote:
> linux/version.h was used by the out-of-tree version, but not needed in
> the upstream one anymore.
> 
> While I'm at it, sort the includes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506271434.Gk0epC9H-lkp@intel.com/
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/2] selftests: pp-bench: remove unneeded linux/version.h
    https://git.kernel.org/netdev/net-next/c/8d3e0982f7c2
  - [net-next,v1,2/2] selftests: pp-bench: remove page_pool_put_page wrapper
    https://git.kernel.org/netdev/net-next/c/be75d319d1b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



