Return-Path: <linux-kselftest+bounces-11316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A778FF692
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 23:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D621C23EC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CFC61FE3;
	Thu,  6 Jun 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="savm8AT/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67350282FE;
	Thu,  6 Jun 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708832; cv=none; b=QXQ9kJXp5lXJBqmIUaLGWpqD4FSfLZ2/sPtPYJ9N1IUX8vBECDlf5yOROPgJvfCh0I2rCzz5dOo6UbdQpYT44Kna0gGibCemVV0XYhJgiODgAq7lQ95SuKjdZpu7HEGTbpBNzdGcrBHtwbiXoCT05BfYtl3bgF5+rWDWlxzF/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708832; c=relaxed/simple;
	bh=8ScXl687XL6dccx4nHinj1xXnjkrSjFzvuqIzY4ArcU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LyD+JCbzmk7zsZ78ZQeOBbCO2jKCd/pWw2hQZKmCUp+c/0rj8nSzrXUsTofTV3+lasW3hr7cQazFW4RI3Idd8zCtAIMsxGeS7CJGXevL9nwrfVpUbfdRr9r2gARAmXnudtoXgsiavolBjOrbydiW1CI+sTSAf520BN++Ej+bSUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=savm8AT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C79FDC32786;
	Thu,  6 Jun 2024 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717708831;
	bh=8ScXl687XL6dccx4nHinj1xXnjkrSjFzvuqIzY4ArcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=savm8AT/ASQ852yrPpzjJXGBRdvdSbQFF2TzFlq2+ydJPBHEBz3mowBqXnDu7xaZF
	 AR3GtOz2AcTZjAnpIlHVvnbuaMbJzsJlvuguISjp/WZGeLPiNcSX2vekplsPWpslEY
	 WHH+zMeklFP8nddLx0XNiGTyFCNlqGQm3Ka3rtDTKT0jxQgPjrc/CVWAShiG4SlKCm
	 O3sXm13twirUe39d/vTy20X0mUCz04qYkfyb3cAXL3gnaQEal3mvoPDysd0umGtUxk
	 fB2aOm943mN3RkMBXCarVuVFvhuqKqGt8uktqLlEnuyIPlVGXpS0m+QfC0RZdl7aLf
	 apxOuDpjFfP2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AED6DD2039E;
	Thu,  6 Jun 2024 21:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/5] use network helpers, part 6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171770883171.30834.12991741087625316863.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 21:20:31 +0000
References: <cover.1717054461.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1717054461.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 30 May 2024 15:41:07 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> For moving dctcp test dedicated code out of do_test() into test_dctcp().
> This patchset adds a new helper start_test() in bpf_tcp_ca.c to refactor
> do_test().
> 
> Address Martin's comments for the previous series.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/5] selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/9abdfd8a2123
  - [bpf-next,2/5] selftests/bpf: Add start_test helper in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/fee97d0c9a14
  - [bpf-next,3/5] selftests/bpf: Use start_test in test_dctcp_fallback in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/224eeb5598c3
  - [bpf-next,4/5] selftests/bpf: Use start_test in test_dctcp in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/cd984b2ed624
  - [bpf-next,5/5] selftests/bpf: Drop useless arguments of do_test in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/f85af9d955ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



