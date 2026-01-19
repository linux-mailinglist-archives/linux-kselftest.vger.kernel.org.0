Return-Path: <linux-kselftest+bounces-49387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779FD3B570
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FCC53023511
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB2368279;
	Mon, 19 Jan 2026 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGhseh83"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BCC3644DA;
	Mon, 19 Jan 2026 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846818; cv=none; b=C+OcIUKuO+MM+nLpNBLQM0dbCDRC++G5hDlg/EBorMZd/a8hZP3Pd+aotovcq8dv6/DBpG5BCehLh7h3o9r4jT80KMhfn8fNDLFvcVlFiM0Rq3+8EkMtxfhKZM4hjHeuFV9YQRqJ0ZEN4dr/YzKuFcKhdodgyG7cUhWWEy0lA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846818; c=relaxed/simple;
	bh=KL9gjHn4r0yJVDgVRuRcfSxW2l2bnCFvqscBEwQO6j8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i7jG3P04tPWBO79SNWqaXA/3HdsCdWeYDKF9IP2szqhG2YG1e0o8hjvoj9K69j+HnFxp/pV+/zszfOt+wB6qX6B46S3PjBSiAQ09+pf8zabGMXhz5TrDwLFWYWgmC+8AGwRmO6z9O+Qqjpu8j2MGV4vmvcGPutUnoP31ovVcV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGhseh83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926F9C116C6;
	Mon, 19 Jan 2026 18:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846817;
	bh=KL9gjHn4r0yJVDgVRuRcfSxW2l2bnCFvqscBEwQO6j8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hGhseh83fSagWmBl5Uc56dl6nMvkz3tSghS1cM4YCKIn4MjglBfMSN4ImiZarBzU4
	 ugFH/CfZ7GnKZ5S7SLnurGWEVHPgHqqulv1UQtSMUngmlkNnmB220Gt+qVYDszhbfN
	 dUP4wsSmAkiOy0o9MW7HfWRgm34p62oro+pTCv/6cVjrFTLiveG1dwbmRKlJL6M8D5
	 DR94mARI6t6AgscUvu4tJpoUOapnTQdGsB0qiwc3RFw4j24ksMB8diOzBMxfCaq6Qv
	 GbCUAnhys1dleRDYeJXwCWwy/+U/hqQTa0P5a03+3mSzNvUpREiPlNFgXby9e25Gup
	 0d3+zfZdfI8lw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B8EBA3806905;
	Mon, 19 Jan 2026 18:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: net: csum: Fix printk format in
 recv_get_packet_csum_status()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176884681553.87873.17149819008459175901.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 18:20:15 +0000
References: 
 <8b69b40826553c1dd500d9d25e45883744f3f348.1768556791.git.chleroy@kernel.org>
In-Reply-To: 
 <8b69b40826553c1dd500d9d25e45883744f3f348.1768556791.git.chleroy@kernel.org>
To: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jan 2026 10:48:55 +0100 you wrote:
> Following warning is encountered when building selftests on powerpc/32.
> 
>   CC       csum
> csum.c: In function 'recv_get_packet_csum_status':
> csum.c:710:50: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>   710 |                         error(1, 0, "cmsg: len=%lu expected=%lu",
>       |                                                ~~^
>       |                                                  |
>       |                                                  long unsigned int
>       |                                                %u
>   711 |                               cm->cmsg_len, CMSG_LEN(sizeof(struct tpacket_auxdata)));
>       |                               ~~~~~~~~~~~~
>       |                                 |
>       |                                 size_t {aka unsigned int}
> csum.c:710:63: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
>   710 |                         error(1, 0, "cmsg: len=%lu expected=%lu",
>       |                                                             ~~^
>       |                                                               |
>       |                                                               long unsigned int
>       |                                                             %u
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: net: csum: Fix printk format in recv_get_packet_csum_status()
    https://git.kernel.org/netdev/net-next/c/d321d505edb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



