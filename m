Return-Path: <linux-kselftest+bounces-19079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC8E9912F0
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 01:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C7BAB22FAD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 23:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680FD158543;
	Fri,  4 Oct 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTNTEvXz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7D1514F8;
	Fri,  4 Oct 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084038; cv=none; b=ZNB8SMoskqkFoL5diwGFRR0LZBSbAV/oO0qbGLVX5fJ/6PBO4iUBnpAz87GBg50tTwj22goT9t2jcGRSFA8iT2susQDf2mC5GKwUf9l/IMBOPQh5HSoqxCrfaLpsIraHT82B+DrfX+VesSJ4x94RarbmWXE5mCV+8P2TqJypoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084038; c=relaxed/simple;
	bh=YE6/LtsHcve4zJZuiAbHCkfw8TXv/uO2ioTzaMSOKH0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pit1CzQJFBclvpycIfSGeI04X0vp3hSYwHgPEROk+R8ACXikw5HE0jeIqfXkA+cIdXd4TZFwpq/vO4DJFrAoHSaU1I2uXMhdyESdplP9HabwwXLaj3q7Ya0hkgvuDvUHHo1W4QJk9hKPIkVbcZvapW1238XtQ6fT8o4dyS33l6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTNTEvXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163BAC4CED0;
	Fri,  4 Oct 2024 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084038;
	bh=YE6/LtsHcve4zJZuiAbHCkfw8TXv/uO2ioTzaMSOKH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mTNTEvXzch/8/X343lHdwDcGqyoSRC1UiPWHD5VeHuIGCK5Fxv9vv97hmg/fxmhSw
	 dsCR3YCwt4vAt0rhF644qe8nYvAKr6rBUoSa0TeYVIs7Haq9T7iHVyt+EWhZXt1IIE
	 aIdummhJhegPE//qQzEl8M1or0ETj4ha4xFmA+4+6E/Srbr0dofESdW/zxjY5GXG9s
	 EkJwQQpz52po8zSPrFgBpIIOqgDbxhNyqqU0KD5cxF8VpCUETrdd/47OUPkfkDthu/
	 waRvn7jCWMeaYsHtVwsip1L7ltuYe4tbWsjW+oyju9VdwkVHkbIrzLZg5XDtdHleif
	 JHRQfPK/fqLMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6739F76FF;
	Fri,  4 Oct 2024 23:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] selftests: net: ioam: add tunsrc support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808404149.2772330.14314026538003665489.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:20:41 +0000
References: <20241002162731.19847-1-justin.iurman@uliege.be>
In-Reply-To: <20241002162731.19847-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Oct 2024 18:27:29 +0200 you wrote:
> v2:
>  - v1 missed the merge window, so while we're at it...
>  - split changes into two patches instead of one for readability (#1
>    removes the ioam selftests, #2 adds the updated ioam selftests)
> 
> TL;DR This patch comes from a discussion we had with Jakub and Paolo on
> aligning the ioam selftests with its new "tunsrc" feature.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests: net: remove ioam tests
    https://git.kernel.org/netdev/net-next/c/897408d5e224
  - [net-next,v2,2/2] selftests: net: add new ioam tests
    https://git.kernel.org/netdev/net-next/c/2d2b5028b4ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



