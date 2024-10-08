Return-Path: <linux-kselftest+bounces-19255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C8B995618
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 20:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 273B5B23C75
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADF5212642;
	Tue,  8 Oct 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtonTQnd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB21E0086;
	Tue,  8 Oct 2024 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410425; cv=none; b=efcybQsk4tn6igQfyrPtEin03QnPwzLOGc/tpU2gPUpZoJ/9dJQFzC+XAhOAPYBEgHJTVe2Gx2b+rLzQw9xaA8MUqFpj9TqycAiQuqHFz5RjVommFPQY24aq93idRpGZQG5skiyyp/TC8KIvgIsi+Y7eZYibNqnJwHeVlTry/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410425; c=relaxed/simple;
	bh=ULmn/lqBD/hhas+W8CDIuZ9oamytTQJtGH1MZauHw5k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N7j6nTpJ2n9MViAnkzyPPpwVFVMqdWOF7KqfMQnQ9JnKz13+JLtpHPd1aMAGfQTjLplf0M/EAX1Vjy0bzY8oSg2IMf64Rzk7bWRzvRdnniQ97Ey5ZDRAfP/nA/pIRreHi7+rZCBV1O4Q9z3zw31KGOUhmvE2OO6auZKuwaaU8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtonTQnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488C4C4CEC7;
	Tue,  8 Oct 2024 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728410425;
	bh=ULmn/lqBD/hhas+W8CDIuZ9oamytTQJtGH1MZauHw5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NtonTQndNGyf2iAhzwjwDBOQpRBpF6b6sQLxpRqtQgHkjXe23sMCy0uam8epCk7Rv
	 mlIJmUs/gtg4IVYzfiiE5GwX9NNwMw4KcZkC8p3Jn6tLfeWbdAxfP9R4gdLHBcNh42
	 6pWZ1MaIwB4RF6c/irBN0SafyiGkB23lOrlQN92Qv3yhiPO8/voK5aM3LKJmKXahze
	 uM+Mi74j7SpHDcWGHqP4tIF6aWtwyNUDI/HEyupYs1Nd3nAFm0C4kPyZsf/31EYvmM
	 I1h9LN9Tc8Hlpp56C3B6so7AAk55nPFAVACfsXXiKt2vRXTeKs8gVQ7onN8IDHQFgS
	 +d/92i0RFUR2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0783810938;
	Tue,  8 Oct 2024 18:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: add missing header include for htons
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172841042952.630678.15879008082090181173.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 18:00:29 +0000
References: <20241008-network_helpers_fix-v1-1-2c2ae03df7ef@bootlin.com>
In-Reply-To: <20241008-network_helpers_fix-v1-1-2c2ae03df7ef@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 08 Oct 2024 16:50:57 +0200 you wrote:
> Including the network_helpers.h header in tests can lead to the following
> build error:
> 
> ./network_helpers.h: In function ‘csum_tcpudp_magic’:
> ./network_helpers.h:116:14: error: implicit declaration of function \
>   ‘htons’ [-Werror=implicit-function-declaration]
>   116 |         s += htons(proto + len);
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: add missing header include for htons
    https://git.kernel.org/bpf/bpf-next/c/bc9b3fb827fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



