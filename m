Return-Path: <linux-kselftest+bounces-11284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14288FDCC0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 04:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6280D1F238EB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 02:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3C18654;
	Thu,  6 Jun 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNQ6fN0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119910A11;
	Thu,  6 Jun 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641032; cv=none; b=gp4JhZpYBbBEQMUhFcWMgmrNannnZef+FioAUTCM4Y2tA+atBrsrw1K8Gmkk1LU5Xj6zl5OHtoUsUWcG6isuigEsYJmLykdB+gpiDvNNAAX2zbO8t/HvVe06bnEyFxc6kaqVI8jwZSfnTSxongZ7laJn8QfwpmMAdvmKyA5q1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641032; c=relaxed/simple;
	bh=tbFbVUmAjxj4cpFV/yhRaRlsb15O2Q2McTWB1aiUZAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TIKkTKvSoIfnylbd9D6H0Ak04NeSEm5lKCpTI1bzCqEsrYldaC83GDcBDez5ZnWlZ/96CrDfoQg4C1kiy3LG4VBY2Ue70scTToXw354TCguOz0g6afAhY8ORszCsXi4a7zqcuMT1HdK6zlunBie2/ktUJhaGXlBRSFQc85fcIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNQ6fN0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35DCDC4AF0E;
	Thu,  6 Jun 2024 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717641032;
	bh=tbFbVUmAjxj4cpFV/yhRaRlsb15O2Q2McTWB1aiUZAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YNQ6fN0uPh0hyAbDbb0Ve5hDpKbZktwmznJqOaKBohmtXTehcCVhz49ROrf6ws1DH
	 e8S2dsKsTeLI2lGXjvLVbaiFTlkzwmO2jHY9qpfyCnq8ci1Py3ATVLSaTB+ogN7rnL
	 ZTnC/ay2jBz5psd49UuSs7WLkUw6k9c32p3GgpbwLFyQKjrlOToYcCG/cLkZy14I1S
	 9kfvLeGSodZHM1x71eE04Aw5NLb2/yCp1zoqUFJih9/TW8G3+ocPCm8OJzYh5gtrN4
	 at64xMhag3zSmGnIjHzI6ArjcmINNglX/ZRhNr1R226Cw6U3hDTDZWT2r/E0GGahZ2
	 qRq7J2vmPxD1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F64EC4332C;
	Thu,  6 Jun 2024 02:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: hsr: Extend the hsr_ping.sh test to use
 fixed MAC addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171764103211.23267.2425387874478992852.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 02:30:32 +0000
References: <20240603093322.3150030-1-lukma@denx.de>
In-Reply-To: <20240603093322.3150030-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, olteanv@gmail.com, davem@davemloft.net,
 o.rempel@pengutronix.de, Tristram.Ha@microchip.com, bigeasy@linutronix.de,
 r-gunasekaran@ti.com, horms@kernel.org, n.zhandarovich@fintech.ru,
 m-karicheri2@ti.com, Arvid.Brodin@xdin.com, dan.carpenter@linaro.org,
 ricardo@marliere.net, casper.casan@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, liuhangbin@gmail.com,
 tanggeliang@kylinos.cn, shuah@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Jun 2024 11:33:21 +0200 you wrote:
> Fixed MAC addresses help with debugging as last four bytes identify the
> network namespace.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  tools/testing/selftests/net/hsr/hsr_ping.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)

Here is the summary with links:
  - [net-next] selftests: hsr: Extend the hsr_ping.sh test to use fixed MAC addresses
    https://git.kernel.org/netdev/net-next/c/ed20142ed68c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



