Return-Path: <linux-kselftest+bounces-5883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5887145A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 04:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85BB1C213F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 03:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AAC38DE2;
	Tue,  5 Mar 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETB847Qa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232E1C01;
	Tue,  5 Mar 2024 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709610026; cv=none; b=nq+1FdstRBIMYkRkgvnoEGca1FfvI3BgnOOjsXs9+hzCEKezNLCWYpzLEdeTuKmDK2sZvRjdv+gOKJHZvZufWb0EiPz+1yemAUVWXAH8GxQNw01PvqNe4WWIqf2yUsVmrJgKo5r57iHP/NLlbX9XoTXfp4y60MJ7SM+dROC/FN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709610026; c=relaxed/simple;
	bh=YO8QxpFJ+gMX1HZDCAHPq7q2GCIHmf23VqVGjI52XVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sjnr1NP5+fgw9ytlDQ3NDPx99gHig0OtIvMUBBHQuS+ZtQS67xtUm9+LQ+6N4WohLNw53+fi7B5a8OYuDfkQnQoLlsBjalbQS+rS/XE0zCaxsRa3yMjGAGgerRDUfoPwTuwCQfzG/tegNgcMlnx2uhpOcgadkYpoMBxvUssZXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETB847Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ADA1C433F1;
	Tue,  5 Mar 2024 03:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709610026;
	bh=YO8QxpFJ+gMX1HZDCAHPq7q2GCIHmf23VqVGjI52XVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ETB847Qa9Mibxjue5i90N02fDIwQyY/FKqZFqF9YEgUrfabZe71eln/pens4Op0DC
	 pwaq9vp+CALSGc52552UY5Lsp8HATaRN5KuTUDcK8epC+gJQiAvfjwxrqK7A2y2CG1
	 h4gmz7fXqFLmYIyLd8OfpOVZ0bEmLNpGtWBCFkcd5bFgfjpbMLbEP3lPyrC49tFsmd
	 0XFwZc5kRzTUchX/+ZdS45rQPar/GoZ8feSfjLEMLIXRVO3H/RfMPUyK5NRAa3tFVu
	 9rubtZeJx+99+QLDPKLcatBmyOFoa+hXNTHqdPMhFI3pp4Ln74ujjLl7Tp11p1RYX1
	 foV8RAghV6gMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F55FD9A4B5;
	Tue,  5 Mar 2024 03:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/tc-testing: require an up to date iproute2
 for blockcast tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170961002605.3516.18175318406387875689.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 03:40:26 +0000
References: <20240229143825.1373550-1-pctammela@mojatatu.com>
In-Reply-To: <20240229143825.1373550-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org,
 victor@mojatatu.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkft@linaro.org, naresh.kamboju@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Feb 2024 11:38:25 -0300 you wrote:
> Add the dependsOn test check for all the mirred blockcast tests.
> It will prevent the issue reported by LKFT which happens when an older
> iproute2 is used to run the current tdc.
> 
> Tests are skipped if the dependsOn check fails.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/tc-testing: require an up to date iproute2 for blockcast tests
    https://git.kernel.org/netdev/net-next/c/dcfaf1f758ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



