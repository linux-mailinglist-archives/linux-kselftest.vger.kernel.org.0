Return-Path: <linux-kselftest+bounces-18957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B020A98EBE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 10:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D331F2340A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B513D518;
	Thu,  3 Oct 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsIioRRX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618E482ED;
	Thu,  3 Oct 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727945432; cv=none; b=t1sys0qNyn2jqL21N6N+4JkLoYEnflqw+WBDDl3xmOj1JBYuE8dkTKXNO59a71ExByTAjOaIixhueNAW8PL8M8KdeFjIPIPeWbATeTHna/SYZJ7d1nmmV0b7FE7CDlH1d4JF2GohBLC5hZmXd40dlZu4sx3Qd6aEuHgidhpxV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727945432; c=relaxed/simple;
	bh=Ih500JwZhz2TUgECSVMxflfvLsBLqOqDWhdcGZZ4jyg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CK/OC01f8DIu8r4OegZFOadF2ccH5ORtmPJbBFsSDUs2aTDsm7H0/xzLSNyWWLu4WsQV2LyN433QpZ3zCFF9XfjQhMJkYisMErdbt2WVkwdubbUrrVdLRL2Jp/KQaAI6oPLW5rlDAFhb3vJUCJ5KsXhZieyPaJG1Akkkdvr7MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsIioRRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2ABC4CEC7;
	Thu,  3 Oct 2024 08:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727945431;
	bh=Ih500JwZhz2TUgECSVMxflfvLsBLqOqDWhdcGZZ4jyg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tsIioRRXlaFfmqUitlJz/Jmo0cNRjFUNEhiBS9GTUiU/1OW3XD07xkaTxKyJnQGU3
	 69i1+QYNwgLE9/FJwTJbLYwIqvtlqoan9xxiGf4FtUabWqSdDfYAu4g8p5hOekbjXq
	 nHz6MqVbGtM1XQZJzthj6uAD4DS9mADySwvulz3yugeUtoyfGI7i3sFzeiTSY+xTYd
	 phYC6TUD9wdPDvjrfHboI9Sf66gL/p9O+JE+/Lp4cnZmS1C+vFpJwmauVRggOVOjoE
	 vhwUlWPQvC7SuU5KCJcCt6mdSkVXxT6yWIxaTVocYW7WlDm4hKyRByt59ed3klup2N
	 r/QBvjaUv+Low==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAA380DBCA;
	Thu,  3 Oct 2024 08:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: Add missing va_end.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172794543422.1786703.6973164582004338505.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 08:50:34 +0000
References: <20240927040050.7851-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20240927040050.7851-1-zhangjiao2@cmss.chinamobile.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Sep 2024 12:00:50 +0800 you wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> There is no va_end after va_copy, just add it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/net/tcp_ao/lib/aolib.h | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - selftests/net: Add missing va_end.
    https://git.kernel.org/netdev/net-next/c/7c2f1c2690a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



