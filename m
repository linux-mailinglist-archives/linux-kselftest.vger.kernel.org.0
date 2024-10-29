Return-Path: <linux-kselftest+bounces-20996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E179B5221
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4743E1C22D35
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8273207205;
	Tue, 29 Oct 2024 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmJFLbDa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D48F205AD5;
	Tue, 29 Oct 2024 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227841; cv=none; b=TwynePKmkFi2xPssioLSwGHxAJKJot83q9r59DZjqFOebsNTepKUyL3RgKD6T/oi0uymEqJcgrk2GIIso26kksGkL6ooeCj1LQqdz8mBUAG4hfO/rv6rg/a/1izanRNHLENvl1XnBRtx0pzHZxQeHrOPwncJC0GSgnlGJS1uYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227841; c=relaxed/simple;
	bh=nPAzmFngWdB8viKSN3p9lLg8K8B3YR3nM0OwfHzDWsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JBUT6p5Hh7lCVNjqKtL0QkJANRQlCZ11DFEknkxSIhUhm4buaKV6ZX8yDxv50hOnwr3UxQl5jnU3o/FxJquqknyzx4Gijg3iQnk2LiqGbmmNI7vFD9bqdoXa2aQMcFqgtPioAVU0u54AiaIWaanmagTEbgPU9p5NZtE6tTpcCS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmJFLbDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297CDC4CECD;
	Tue, 29 Oct 2024 18:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730227841;
	bh=nPAzmFngWdB8viKSN3p9lLg8K8B3YR3nM0OwfHzDWsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EmJFLbDasj+Amn/a9CYEG3j7oY5gakRRASNeuOwDa9cB9t6UqyY+lrf6WCzVwMArA
	 vs456lvHz/gZlJVjVa3UZBF2jNeVo5A1eOYAka9PrIlRxz7lSr4bxz/HgwhSGbCcx5
	 Ae9puUURIfAg+Y0DwJLCbenBgsKI/nge/DVwPtk7Kabu4qSuYBseGnQ+Pk2bF5PiRj
	 b5gVSrtFbiQANv37TOeYpP4YEp80oox86vpTnCLoFrJk85aeOEgVZmSljowsfr9pBp
	 V0qd0VoHk73nsMo7uDJxwnuBkc3O2t5ch4f915KDBViKN9VDPJRpfiqBCgSOzyWfqG
	 wnb256fVUL0lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDD380AC08;
	Tue, 29 Oct 2024 18:50:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests: tc-testing: Fix typo error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022784849.787364.4801576337230877452.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:50:48 +0000
References: <20241022-multiple_spell_error-v2-1-7e5036506fe5@gmail.com>
In-Reply-To: <20241022-multiple_spell_error-v2-1-7e5036506fe5@gmail.com>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 anupnewsmail@gmail.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 18:30:52 +0000 you wrote:
> Correct the typo errors in json files
> 
> - "diffferent" is corrected to "different".
> - "muliple" and "miltiple" is corrected to "multiple".
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] selftests: tc-testing: Fix typo error
    https://git.kernel.org/netdev/net-next/c/9a1036389fa2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



