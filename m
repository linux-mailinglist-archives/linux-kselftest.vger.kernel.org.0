Return-Path: <linux-kselftest+bounces-17169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B468196C7B1
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67011C24FBA
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB11E764A;
	Wed,  4 Sep 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCl5pwfZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132B1E7646;
	Wed,  4 Sep 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478834; cv=none; b=Gdzgdpwg+63BX6D4IcP+nHW1w+k58qAQ9fnFXKPjGKiF0NhsKFaa0rSkqJFK+dRdFYCMNAwgo7l4JBq3CnjXPoWtJiscpb3Uwfcn3JRJhwlmH3p2PC2dXh2/6ilCjFpWzwAzhGvWrzu99/yHOz2bLWFNR47sXBANPvODtn8FCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478834; c=relaxed/simple;
	bh=Nrso63BtrkpzhxYm9yCTdaXOqHsZiYMXDLJdMPnueg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sPzdWKlLIuSWFM7xHmD52H+XGkxPrbdqu89ZD7i6Y7leuXGXK+51exj6wFTf7wX4fWbg9XHcEhcKRrAwgdyS+gj+s5kK1HDu5yLw/Z2Z6E3c/s1YKR3rrDg5QPZZrNmneCvSHWOzWnqBIxk5aPVgqU2yBhc61xn6vzniItq9IGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCl5pwfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC5AC4CEC2;
	Wed,  4 Sep 2024 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725478833;
	bh=Nrso63BtrkpzhxYm9yCTdaXOqHsZiYMXDLJdMPnueg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LCl5pwfZO9BsUU6tgjQYDgZWoJSmqjipHFeAQvBoK3t711sTZzGj0obc68XDz9eKi
	 tFTe43IVJPw71M3ukIQb3y6UGuyzq+Io19IZM7Tqqj5RuqFtFlDHMTpGRdRCqfFWL9
	 1u0QuCcInb8iiCW85SYM6+qgCjeds9a7kljX5BdQOblsCLpYGZl1eJ1OVfdiaPn9io
	 oSTBMBO2kFgOblglHFvazKFO1jmMT4nYtjofBqwkUcQ8bm84t1QxI9FU6iwV6zUH0G
	 VkWxmofINgk66Lnzna/60CdNxpfVnnBqArLSHC/lz3rC17am2dNIqXSYxVlRNox5fv
	 ivjGLIoXtf2aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 716293822D30;
	Wed,  4 Sep 2024 19:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf,v2,0/2] bpf: fix incorrect name check pass logic in
 btf_name_valid_section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172547883425.1145823.3809122034965007407.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 19:40:34 +0000
References: <20240831054525.364353-1-aha310510@gmail.com>
In-Reply-To: <20240831054525.364353-1-aha310510@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 31 Aug 2024 14:45:25 +0900 you wrote:
> This patch was written to fix an issue where btf_name_valid_section() would
> not properly check names with certain conditions and would throw an OOB vuln.
> And selftest was added to verify this patch.
> 
> Jeongjun Park (2):
>   bpf: add check for invalid name in btf_name_valid_section()
>   selftest/bpf : Add a selftest test case to check for incorrect names
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: add check for invalid name in btf_name_valid_section()
    https://git.kernel.org/bpf/bpf/c/bb6705c3f93b
  - [bpf,v2,2/2] selftest/bpf : Add a selftest test case to check for incorrect names
    https://git.kernel.org/bpf/bpf/c/743070894724

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



