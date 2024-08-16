Return-Path: <linux-kselftest+bounces-15474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7B0953F36
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 04:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AFD1C22C95
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7982BD04;
	Fri, 16 Aug 2024 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHxDXuuT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22551DFCB;
	Fri, 16 Aug 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773664; cv=none; b=BcY0kph5K37MAyjlEXTMRh18EjFW4dRw28SQ/fKIk0riwiTy0Ru9Jx4llWsWsq4m3rQowHBa7Jw9mo3Kry782RvVz7C9yK/YEEvkia+bE0iBVNrsNZh43RNAAyaZZwTbjZeZid+nZ55Lbr1Ec9ildZgdfIdYWOsJjnXJQN7nQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773664; c=relaxed/simple;
	bh=91mWyF4f/hsXKFWQTEcv0Mn3BuRfSkS/LJXcnArwOUg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfn6QyWZqXT+1RWZgeYY1LOWKoUqyq70nDi6VuLGLC8Hu2+xhZH88OoKfZ1C76Lr30IWss/KgwAjgFd0gxONiXy/+ILDj5ILJrwBrS8P+G9/MHr8BdBa9E3jTi8nclLVWDwBA6RPsrDhnaqCvm5V4YgndK/MI5rXHfW9ULNQNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHxDXuuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77692C4AF0D;
	Fri, 16 Aug 2024 02:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723773663;
	bh=91mWyF4f/hsXKFWQTEcv0Mn3BuRfSkS/LJXcnArwOUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GHxDXuuTpCGD+nQlWV+/Tk9y2r7NmV7AeYCMJWMmpQqmVIyeJtVul87to2T43OICS
	 x5vFXjMK1z914YvoZNJF5YPTsuy/PjuhZ0n93MzPSwZ58rHUQdAw009W0GIcqU0bwX
	 4bYTk2I+8rbHlY7EXDDAkbe3uGX/pIYkLCtbU4LUMo2dSqm1Az9r91Xr5aiPn3RYyS
	 QSRMdxL92Wih2iQ5PsqRXSGU+MIg3CjQvkz6A5/D/Z4C2Ik4qFISBEWtWM6SyvKTwC
	 yN+d+ofLycSLM+JXJd+s/r1YYL2W1Fnl3j25iwx7Hh6f6iHcw6ck6Gr33wY/Pl/qY1
	 yCAYJhBqADtQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB21F382327A;
	Fri, 16 Aug 2024 02:01:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net/pmtu.sh: Fix typo in error message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377366276.3089823.7557901907562929855.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:01:02 +0000
References: <20240814173121.33590-1-abhashkumarjha123@gmail.com>
In-Reply-To: <20240814173121.33590-1-abhashkumarjha123@gmail.com>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kuba@kernel.org, shuah@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Aug 2024 23:01:21 +0530 you wrote:
> The word 'expected' was spelled as 'exepcted'.
> Fixed the typo in this patch.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> ---
>  tools/testing/selftests/net/pmtu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - selftests/net/pmtu.sh: Fix typo in error message
    https://git.kernel.org/netdev/net-next/c/e7d731326ef0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



