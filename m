Return-Path: <linux-kselftest+bounces-39426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 879C3B2EB3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970051CC2FEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 02:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2B261B91;
	Thu, 21 Aug 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5PuTFYk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5628252910;
	Thu, 21 Aug 2025 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743407; cv=none; b=s7TpbEQstXqhhDpSLShMPG560dnz4SrhLdg/1roFFbpBrhW7b1dLmF+v9sV91MIzPriBhsCzHRH0wcyPOzBlKxMMZxrBV0O+IAib9Z+8403ei8tML4ScTnJIevOSL1SNgJ/50Q9+DnLEaEByq80JMpgv/aRLktsUo0OWr3vD6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743407; c=relaxed/simple;
	bh=IX8S02uoqknO2ug4UL8qWthJagbJzYPLpQV+Px/2XoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t7yTsstWe8rl2YMMi20ue8nnwwxRYpSPDttxkSjaHfZlk27xWLZsB9LCnxACRkbXPA1XbeWmV5KSbn1YJIsCSeuQXbHVOj6KbuO6ahchOikfE/EHQ2B2Wz+vuzQhkRU6rfjip7HdTsOljCtZr0fT5DibheRixFvEKAjQX9Obbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5PuTFYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2E7C113CF;
	Thu, 21 Aug 2025 02:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755743407;
	bh=IX8S02uoqknO2ug4UL8qWthJagbJzYPLpQV+Px/2XoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A5PuTFYk03Xg7XX0NIZ26gUoUe05BPBZ8bIi1q05iw5u+MgNervuphr+9GBukLukD
	 tfRYo+GzOkyuXuyk5iVdqOgYFWz4RdwoO9/Af/XKQhkOy3tV6Mxq+gkQ/dcPMYaihd
	 V24KDWYF7Ma40miIsc9ikXz60DSWhNVT7ByRpe4CRjIcqH7vkki1PtHs9zzSY3zVAk
	 0lm25uxcY4Iq7y3pdsXsH8YABihJOtluD143ASgZW640cEf+D+M9VAHOafTp6+m7ZG
	 cz7nFmdt5eejUWLdc6XEirXaLzL5hOwpL9xiPT7Wi070R4Sgmb3/qol1N6U6vtmDZr
	 Xzfb3ZmdVGjPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC2383BF4E;
	Thu, 21 Aug 2025 02:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/net/socket.c: removed warnings from unused
 returns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574341664.480425.10177992226629504965.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:30:16 +0000
References: <20250819025227.239885-1-alex.t.tran@gmail.com>
In-Reply-To: <20250819025227.239885-1-alex.t.tran@gmail.com>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 19:52:27 -0700 you wrote:
> socket.c: In function ‘run_tests’:
> socket.c:59:25: warning: ignoring return value of ‘strerror_r’ \
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
> 59 | strerror_r(-s->expect, err_string1, ERR_STRING_SZ);
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> socket.c:60:25: warning: ignoring return value of ‘strerror_r’ \
> declared with attribute ‘warn_unused_result’ [-Wunused-result]
> 60 | strerror_r(errno, err_string2, ERR_STRING_SZ);
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [v2] selftests/net/socket.c: removed warnings from unused returns
    https://git.kernel.org/netdev/net-next/c/6b4b1d577e1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



