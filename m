Return-Path: <linux-kselftest+bounces-44367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A8BC1DF8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 02:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FF5188E455
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 01:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F04246BA8;
	Thu, 30 Oct 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjvOMK3B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA642459EA;
	Thu, 30 Oct 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786039; cv=none; b=rPT1B931J6dvMaV4jK3fsEAvrVAFwUvuBC0SbdaBYczGrxY8H3CabxKoF5+1DfSwS2ff9Zox+y3zdeOlwEjpOOSzs1v64K7xmOkyrmx7C5XpsXFHzto8pJJM78e7+MV9NX5aK6ymBL6QlqfksZ1pXcEMgYxq0JgYmvovsAkx9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786039; c=relaxed/simple;
	bh=sDHL2SfL9e48SuVb3CsnFf6tl1w0ApA8EeIFwZChLms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dCMJVmy++sb1exfd2P4IiPenDrRAqTg/Rh7+Cq4XQiAICpaLReFe932r6W0tnLrEsMaU+RnSgxEJmjQkDt6nGdgRRMoZKOwFOkw1DPGommBOljl5yG1XxlV66IrY4VVQnvhLk45J8JVEoeqWUFIYex6a4GHzvfp8HyBZZZH+3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjvOMK3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3E2C4CEFF;
	Thu, 30 Oct 2025 01:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761786039;
	bh=sDHL2SfL9e48SuVb3CsnFf6tl1w0ApA8EeIFwZChLms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SjvOMK3Bb8waaIba9bXVIPojOmkYM7oxWxaFQsHYMAdckUNP2SWTCsTNa5BxbRR8/
	 K4Nnvhp/lVn+GFdPw+OFdFbNYwiUuv8x/d7RTuyfOGvJcDftMW0m3TKKQ/pmR2m7lT
	 AYz6MdWCKyEs+kJsKuTVnXcyZXNzVCwSg78oBTjq2YNHGeX+nK3Mfh3Qkrighm2i+R
	 qYyM4LakGkPc3i4ILOHCcVCgDPDUtcYJ6T7qJkM7GUxMcxJ0bpIayzMkSlACr5u94/
	 3fAK2OBo1eETqv0zJW86tPkkGveszBHqu/GiJ/JeuIxZNhzGXytsC+7PAygtipOf4w
	 O4qJo/2L3HmKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BDE3A55EC7;
	Thu, 30 Oct 2025 01:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] selftests: net: use BASH for bareudp testing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178601574.3269431.2615356628282051961.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 01:00:15 +0000
References: <20251027095710.2036108-1-po-hsu.lin@canonical.com>
In-Reply-To: <20251027095710.2036108-1-po-hsu.lin@canonical.com>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 edoardo.canepa@canonical.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Oct 2025 17:57:09 +0800 you wrote:
> The bareudp.sh script uses /bin/sh and it will load another lib.sh
> BASH script at the very beginning.
> 
> But on some operating systems like Ubuntu, /bin/sh is actually pointed to
> DASH, thus it will try to run BASH commands with DASH and consequently
> leads to syntax issues.
> 
> [...]

Here is the summary with links:
  - [1/1] selftests: net: use BASH for bareudp testing
    https://git.kernel.org/netdev/net/c/9311e9540a8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



