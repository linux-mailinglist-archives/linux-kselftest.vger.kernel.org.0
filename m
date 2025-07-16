Return-Path: <linux-kselftest+bounces-37448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B3AB0803D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 00:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34141C27F36
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 22:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3D2EE604;
	Wed, 16 Jul 2025 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFDjqxXx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAEA2EE5FE;
	Wed, 16 Jul 2025 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703791; cv=none; b=OSNAOIVcIUh1JWEbevMF7bjhYIJggxg2R/xjVpCmBZ9Bz3hPGxW4lDbrz4xDJfJ0m6r7+v9ybhwTBTHPHSIsU8egVN1NmLWNEntTbYBkU85MAAy7wPRjtQg6A9SCYSxfr3VeurqHjw+RF6IMITE1QxtLwCtfTFUEdD1QxCjqFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703791; c=relaxed/simple;
	bh=mNFVHEBnhuird5zyEhCc/wBwLPL9kDMSU2Mpwt4O8zQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dt/smOCvCD0pqG4N7ew90nuGYpFujG3p5hNm6oxPcttyJTguUf5vAvTSS13JyMx+Z+TAa3g4Z85TvTbpc61WHCQADQIUBcwlgxdM9bMNsbl0L6TLgSWpEezkWHpYb04vUe/nVmJVa6W8oThrSar2COrdvyM73+fkbMLnqS5kqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFDjqxXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39669C4CEE7;
	Wed, 16 Jul 2025 22:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752703791;
	bh=mNFVHEBnhuird5zyEhCc/wBwLPL9kDMSU2Mpwt4O8zQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LFDjqxXxxyL8E6s+/CABfGzDqLNG2T/c14BO45mBISplDEdnSQC3/1vgcOU+SujVb
	 x8Ftmcp46TAVPwZ+masX9gbi8ommh7fQ6aQhiyUwVIldcFNcq/B7z67Gq4hx+mESBt
	 yjQcp8pB1GZIgb2DC2GA3ay4vMa30QXiF3Hyb5kdb09mdHkehpN+Q4PDvLf7fKrYwE
	 RJ80ZrAnghLjxvV4c/Jce/IHuP9Yn3ySzjOD5dfq5xkmFHpeY0NmvPfJ1vhFAKddKk
	 VY8aHTup+2zkJuCy4a6mB7NU/SSNx7w5uHrBzy6g/9j4l44/BD0gQOm0DlKYZN89Ht
	 jYUNpmb95yU4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEBC383BA38;
	Wed, 16 Jul 2025 22:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: rtnetlink: fix addrlft test flakiness on
 power-saving systems
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175270381125.1341865.1254102075141304386.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 22:10:11 +0000
References: <20250715043459.110523-1-liuhangbin@gmail.com>
In-Reply-To: <20250715043459.110523-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 04:34:59 +0000 you wrote:
> Jakub reported that the rtnetlink test for the preferred lifetime of an
> address has become quite flaky. The issue started appearing around the 6.16
> merge window in May, and the test fails with:
> 
>     FAIL: preferred_lft addresses remaining
> 
> The flakiness might be related to power-saving behavior, as address
> expiration is handled by a "power-efficient" workqueue.
> 
> [...]

Here is the summary with links:
  - [net] selftests: rtnetlink: fix addrlft test flakiness on power-saving systems
    https://git.kernel.org/netdev/net-next/c/3047957cc7c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



