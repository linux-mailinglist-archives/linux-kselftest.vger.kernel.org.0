Return-Path: <linux-kselftest+bounces-17556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7621972601
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6331F247AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA161CD29;
	Tue, 10 Sep 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY3NFeG9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB102901;
	Tue, 10 Sep 2024 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926432; cv=none; b=X2IgJ8pGjDOC7CpOTOMKH+Esz6m2X8cRzHiBaigG4e6imXbXjYHojl+EkkeRNVjLiObwZPdYa88R/pkNcfKhaj3OO/yuPjv9tomQRqVACseLRs6aCmrR0QpQ4ObxpTvPO4CsTWmYiDXKgTxGGlGWf2/JtjhzxafgcrEVkhvuG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926432; c=relaxed/simple;
	bh=OeDMui6wde4DNiHQx1ZGzsr33zGQdn4RQKLNeHaEXEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FZnw/6FlWMSBoslQC5wV7140wdvSDPyIpaHIRIr4NWI6Fv40ECZqssvE/vb3/0/mXUA6mmlQVTmft0QTIeu3Yr80ooiWupcOeYDQ2dYg0F/qqOBiYYsEUw1G6qHU6forsJNN1bLQLSIvKYqIFy1+dlCGj0eBVOnBdNOXQ9dqm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY3NFeG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0379FC4CEC5;
	Tue, 10 Sep 2024 00:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725926432;
	bh=OeDMui6wde4DNiHQx1ZGzsr33zGQdn4RQKLNeHaEXEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IY3NFeG9xz405mv2aEhEYQyPPxakeM/7gsNFHQ99CTgAAH7N+RY0jdiPiyy03fRmw
	 svwdzDTZ7B5rZ3tePPP+Yb6B4RAiG2yWox2YHEej94q0HtXq8ZMgZKFDk0oWyIBmvD
	 Itso/H3+AaxTEsoQMUnxsUIBAvg2xfJpmDe2ShJRuOE1jUMAS/1iGEJQrb2OsDc5oo
	 DnRzpMpV0hc9czzyepSBkXvTlSkxqHC2Ec9RlyF8bUixUM4nSHB0bZVIarPQqWpfD9
	 ygPwd9BuGDnxy44UMzdDbUKiT2ZO00rxn28G41hd80u4ssl6JkTXzwYC4gY13JNayw
	 qjsBwuUxJBZ8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344183806654;
	Tue, 10 Sep 2024 00:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] selftests: mptcp: add time per subtests in
 TAP output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592643303.3961170.9520344470558627600.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:00:33 +0000
References: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
In-Reply-To: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 06 Sep 2024 20:46:06 +0200 you wrote:
> Patches here add 'time=<N>ms' in the diagnostic data of the TAP output,
> e.g.
> 
>   ok 1 - pm_netlink: defaults addr list # time=9ms
> 
> This addition is useful to quickly identify which subtests are taking a
> longer time than the others, or more than expected.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] selftests: mptcp: lib: add time per subtests in TAP output
    https://git.kernel.org/netdev/net-next/c/f58817c852e9
  - [net-next,v2,2/5] selftests: mptcp: connect: remote time in TAP output
    https://git.kernel.org/netdev/net-next/c/1a38cee4bbd0
  - [net-next,v2,3/5] selftests: mptcp: reset the last TS before the first test
    https://git.kernel.org/netdev/net-next/c/d4e192728efc
  - [net-next,v2,4/5] selftests: mptcp: diag: remove trailing whitespace
    https://git.kernel.org/netdev/net-next/c/a5b6be42aac0
  - [net-next,v2,5/5] selftests: mptcp: connect: remove duplicated spaces in TAP output
    https://git.kernel.org/netdev/net-next/c/a92d1db0c989

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



