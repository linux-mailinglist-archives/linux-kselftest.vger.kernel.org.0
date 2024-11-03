Return-Path: <linux-kselftest+bounces-21353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780B99BA999
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 00:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04921C20E72
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Nov 2024 23:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D463F18D64D;
	Sun,  3 Nov 2024 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuTVqQSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041118D626;
	Sun,  3 Nov 2024 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730677222; cv=none; b=YaK+cihKuCsYEmj61qHmYK7OIITMS6PqXjYVonO+X0OZt9ul8hQt2sHA0nn2m1ALOU1eT/SZQQszH6xwDXjJ7x8a+ciGcblgf4gYWoKHI07dHuJTBS6fbTwWFAOf4I95BJFgO+sQejr/OeV78hl6iqnkl+fgA1ZcrRPf+HjqXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730677222; c=relaxed/simple;
	bh=7lpDI3SH3dGBQQZtr79GnpzYlYdzwt1oFzSLvpFuUNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QuzSazoFzX3b77nHozvFxKVA4/zecIhozviftaFv3vec8M64UA6CamssYyXfZRxXga+XMirgbPYL80XZltCWmH5UyqpFlk+8rkOky8ZSsY0M36pYfrQrKFqEMivZuDDAjd7sxXAKgCLHQQMUM2sXhUwqBGvzKPuHJVwQBpjS8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuTVqQSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374A0C4CED5;
	Sun,  3 Nov 2024 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730677222;
	bh=7lpDI3SH3dGBQQZtr79GnpzYlYdzwt1oFzSLvpFuUNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EuTVqQSBLvmXkONtc3FcCAKjs6HuIeu18s9TPS0yzgSg0+VxptJE5QwOZ+22XxkjU
	 SJCLyWciroO4QdjhezEAr/WZdlnzZ9WsWhNEU3y9zZMt19l7+qvZhnYBuO1/vkmF8Y
	 daOdo+gtwj88XhqJphUkcLWDIDG6KINNgd7tAv1mIq1eV7xYwIqABXJnpOnf35GZjh
	 FN1O4+cYCnk5jql4ytxir/QCJuJcEh2y4MERK1MKBmCbimu+MOLFYP6M+D7D65j9Xy
	 l5zQwIW0fXzBg9vt6T7srIAi0v/f2gEXqOVRxj790pcOP2B9LZ5fVLNOuokWOpUQXG
	 W9xsHCQG7AlKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF338363C3;
	Sun,  3 Nov 2024 23:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/tc-testing: add tests for
 qdisc_tree_reduce_backlog
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173067723051.3278663.1340500265334898665.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 23:40:30 +0000
References: <20241101143148.1218890-1-pctammela@mojatatu.com>
In-Reply-To: <20241101143148.1218890-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Nov 2024 11:31:48 -0300 you wrote:
> Add 3 tests to check for the expected behaviour of
> qdisc_tree_reduce_backlog in special scenarios.
> 
> - The first test checks if the qdisc class is notified of deletion for
> major handle 'ffff:'.
> - The second test checks the same as the first test but with 'ffff:' as the root
> qdisc.
> - The third test checks if everything works if ingress is active.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/tc-testing: add tests for qdisc_tree_reduce_backlog
    https://git.kernel.org/netdev/net-next/c/9ff75a23dff3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



