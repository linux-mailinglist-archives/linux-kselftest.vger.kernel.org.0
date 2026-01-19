Return-Path: <linux-kselftest+bounces-49366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE8D3ABFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 517EC3015DC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FFA38A9B0;
	Mon, 19 Jan 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpF5eZ0X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614AB38A728;
	Mon, 19 Jan 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832582; cv=none; b=Or5yPl0vOtCss6TkdsTfTdx+5ybnP34Q2PQeHycGKMblkE4264FSUq9+WiYc733SEnxGGDktc7JTCfD/2OC4gW2vVGKM/lGrUOzBHsuf8H5tP804s98WoPyTsAfZS84cq8iHTRDiUIOFOvJ54i09ytUiBOuVIEENNO/tCaynYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832582; c=relaxed/simple;
	bh=3rseO2VdOcdRR2kY2+qI+fLi8ZuR3zafi9NP2SKUHYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E2rGEjG5iLtObexKaSNJuodsNohv5fsBE54DSn8OT2pTXJPwGF09kVpVgnwEkGVfnRrHrZfTvvGzimHROU4KPnsGHx0k7IIfkUgowAIt+HI/L5Cmo44lcsxqHwB4mX6Erd8skrGOJ4iVaJevtvEpJcedm5eTAis+w2zb0C0H93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpF5eZ0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE223C19424;
	Mon, 19 Jan 2026 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832582;
	bh=3rseO2VdOcdRR2kY2+qI+fLi8ZuR3zafi9NP2SKUHYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OpF5eZ0XqUx1N1nQZtIDYb3qTLD+bifKq2xeEtoSjuq8avJ5cMn6xDb036Nzoegyq
	 6178kR67yRzcRaL5jIIAIFUVHGlCUP1SAt50r6QXqoVRC7Ldhd2pIbvOejFpqnxZCU
	 kKg1oSX2t6vI6G1A+roD7fuVmMsE9MDsa9adnaVI6uWhv6Ud2nB3Ktip9x0b7cocRt
	 dFLvZJjSzNSXNjg3jkqd7CtSS1hPng/QfEEYr3FmSTk3bddEsAerb/R0yBw5UQ5CFc
	 qsiFHir7WCVOZYGwkW9QjRK7zJzkXiDwNalqs+65bsx9Z1qoFC+f7HW+ok5yy70T1o
	 TlUVZ9SEGnd3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A923A55FAF;
	Mon, 19 Jan 2026 14:19:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] selftests: net: improve error handling in
 passive TFO test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883237152.1426077.2316516849712377834.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:19:31 +0000
References: <cover.1768312014.git.yk@y-koj.net>
In-Reply-To: <cover.1768312014.git.yk@y-koj.net>
To: Yohei Kojima <yk@y-koj.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, Markus.Elfring@web.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 23:11:53 +0900 you wrote:
> This series improves error handling in the passive TFO test by (1)
> fixing a broken behavior when the child processes failed (or timed out),
> and (2) adding more error handlng code in the test program.
> 
> The first patch fixes the behavior that the test didn't report failure
> even if the server or the client process exited with non-zero status.
> The second patch adds error handling code in the test program to improve
> reliability of the test.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests: net: fix passive TFO test to fail if child processes failed
    https://git.kernel.org/netdev/net-next/c/52b485973043
  - [net-next,v2,2/2] selftests: net: improve error handling in passive TFO test
    https://git.kernel.org/netdev/net-next/c/342e31254f02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



