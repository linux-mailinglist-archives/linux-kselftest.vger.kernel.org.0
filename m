Return-Path: <linux-kselftest+bounces-10752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3459D8D10D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 02:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2466282CDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F464C97;
	Tue, 28 May 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOaaa+Zo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EC4A2D;
	Tue, 28 May 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716855631; cv=none; b=B3EbDFjVMlRajnPoIK7+FacuUCcB7aLDx+mw+QA3vzFPhgnT6whrmrd8ZlO8Y6y2AzrNTnNqCS4t3vzQaWOHlH6fqLoiADDc4ZZFongPWZxlMzj43699/MpKY5CWMkrGQwCDPsZnpNc2Q6bV8krxBcMy7endsvoO4SPioYH39AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716855631; c=relaxed/simple;
	bh=s+FbjgCDkvvaLJ+IBxXZ5gOOAsc2UqtoW2RDlXZAvvg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NTBHhtHSH8On/6itvq5lmi6HWpvedIXhqdqWaKpgDWpUEJCU3ZEKN3wGyqoUEv7obf1mCrnUpIAqG+O2pWE8tn1xXMfmsWCbPvgibbfOmcSJNZKn18G83a/K85tXpV05rZvlU9VWOE4QvOiC0DpSXckHuuuXvr+aKri/KiWvswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOaaa+Zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA846C4AF07;
	Tue, 28 May 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716855630;
	bh=s+FbjgCDkvvaLJ+IBxXZ5gOOAsc2UqtoW2RDlXZAvvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eOaaa+ZoBkdIT6J2hcyBDZL/FXiEcXcdXFTKoEoMjHwJoi0AEJhHSEt/9snwqcPTI
	 JfO2Yu+f9Asp91GF11qPvf+YiJv7Yka815yE7k26U93xi85mCVsLwGAbXpGT55Fdd4
	 6HW1ExmfcEnEyYROyfwI9syFzDQcykTLG1IG7RRHtp0Yx7k53j4bfs2N7jO3XhUTxk
	 QPoeDzj5VH+hjQwbWnV/kIrI65gz471TryUTz7189NKYtjClARpNBc6oO+5GmG8eZm
	 EwHW25mKAWL6lcP+WfUMYtTYq/EDpD1G+tTBoTzfyUJsvqup4XOrdICYi1WLDWZ0/W
	 cRLJWYd/j4iAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B82CFCF21F7;
	Tue, 28 May 2024 00:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] selftests: mptcp: mark unstable subtests as flaky
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171685563074.6024.16813862230766560677.git-patchwork-notify@kernel.org>
Date: Tue, 28 May 2024 00:20:30 +0000
References: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
In-Reply-To: <20240524-upstream-net-20240524-selftests-mptcp-flaky-v1-0-a352362f3f8e@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 May 2024 18:30:55 +0200 you wrote:
> Some subtests can be unstable, failing once every X runs. Fixing them
> can take time: there could be an issue in the kernel or in the subtest,
> and it is then important to do a proper analysis, not to hide real bugs.
> 
> To avoid creating noises on the different CIs where tests are more
> unstable than on our side, some subtests have been marked as flaky. As a
> result, errors with these subtests (if any) are ignored.
> 
> [...]

Here is the summary with links:
  - [net,1/4] selftests: mptcp: lib: support flaky subtests
    https://git.kernel.org/netdev/net/c/5597613fb3cf
  - [net,2/4] selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
    https://git.kernel.org/netdev/net/c/cc73a6577ae6
  - [net,3/4] selftests: mptcp: join: mark 'fastclose' tests as flaky
    https://git.kernel.org/netdev/net/c/8c06ac2178a9
  - [net,4/4] selftests: mptcp: join: mark 'fail' tests as flaky
    https://git.kernel.org/netdev/net/c/38af56e6668b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



