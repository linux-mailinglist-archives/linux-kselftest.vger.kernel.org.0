Return-Path: <linux-kselftest+bounces-5972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76622872D94
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 04:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D698B2236D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 03:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886414263;
	Wed,  6 Mar 2024 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqHlyNKO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAC2DDA8;
	Wed,  6 Mar 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696429; cv=none; b=TNmGF7F7z1m0TDyReeVSo/IzafvmuB31chSjXWkiQ2UEdX1C6godLr6am1vjBHMWb2AWZlfAUDUCzUf11K3vVKaB6XdMvpmRzAj5bxdFrNm4g1cT4iPjcZGnWwjHkcMtNe3x+zfSDACv3Li/SvRihkiIpmENFN1i1jouU45AY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696429; c=relaxed/simple;
	bh=tLUcs7AGu1cKfGjGrERuLZL6+BqOUOATWWsSl1GrJqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YrJQYckOYKQXtmM8j10iJBgOv8T+PiBVLaxgU93EUNIEnXqQeDkz0bUe2FpgiGXHLHxsf+O8GQTuyUT9pasNvfIKwywzD7vBrH00sYFKPlYsWv1L69TigW94UDINCyECCeEzgr6sjoLQariX3uV9zvkCExykGmhmBf0qMHGAYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqHlyNKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B416C43390;
	Wed,  6 Mar 2024 03:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709696428;
	bh=tLUcs7AGu1cKfGjGrERuLZL6+BqOUOATWWsSl1GrJqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gqHlyNKOqgW0dSiOOdkl2I+A7x9SG70qeWm053FSiqvsdu6TJ23aWYcE/5s9nPNLU
	 YcPWBELMNpXYVEZfjTBKVUJetzCT433lRG9liN+bQwwktxCOCcSNHbguuwMMYROUcQ
	 mi07kqXci/SNnGD9R0QGVaN6iGXip8UyWuDfrVIfQqIdD0G1trDSI1qOWjmuRDELpu
	 stpv0gE/MBFGiV5IX/MuZlNJ+KAI5r+cvyOXtZhR/gXnzFBFYy+zPl0PMvj6Bnrpte
	 tpFon6mGPqcy9wzoqa5HuMn5rhQDY1RwW1Eh7GKeLj9PV7B81s9ZtBs/IpBq+Cmlso
	 L6rGumKovAj5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B51FD9A4B6;
	Wed,  6 Mar 2024 03:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: avoid using SKIP(exit()) in harness
 fixure setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170969642850.9099.14198532225350311208.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 03:40:28 +0000
References: <20240304233621.646054-1-kuba@kernel.org>
In-Reply-To: <20240304233621.646054-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, broonie@kernel.org, ivan.orlov0322@gmail.com,
 perex@perex.cz, tiwai@suse.com, shuah@kernel.org, jglisse@redhat.com,
 akpm@linux-foundation.org, keescook@chromium.org,
 linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Mar 2024 15:36:20 -0800 you wrote:
> selftest harness uses various exit codes to signal test
> results. Avoid calling exit() directly, otherwise tests
> may get broken by harness refactoring (like the commit
> under Fixes). SKIP() will instruct the harness that the
> test shouldn't run, it used to not be the case, but that
> has been fixed. So just return, no need to exit.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: avoid using SKIP(exit()) in harness fixure setup
    https://git.kernel.org/netdev/net-next/c/e3350ba4a5b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



