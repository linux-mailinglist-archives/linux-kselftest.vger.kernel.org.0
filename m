Return-Path: <linux-kselftest+bounces-24278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4CA0A023
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 02:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F52716ABA7
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 01:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6044A1758B;
	Sat, 11 Jan 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk/mzqtO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91A5C96;
	Sat, 11 Jan 2025 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736559689; cv=none; b=VOi8F+akontjdmYJl4LefRDTgzF+D6q6u5J3bSdV/r0gG93R1UowRYm9tkn/caH3MGEkt1w/ZDy4ZN/PlL6sM2DJJQ/aojuc97HhycUfMOwHGaUOpAKJ8V9X7V14me4iyzNFH6odEoZ6KlHqFRPXIe6dq5c7HURC+2TTZTsA0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736559689; c=relaxed/simple;
	bh=SaAkLuVh5qeM5RczhYtiRyngltVs9Mjfy/xMJTVOWIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pTlsq1ws6nOscmdgw5Dhjj1zjhuJUIbQE999FmQ4y3Lf4A2CbPH0HCOXy/GrNhUaZqITf3r4lgiIFj+ySXqsz4Q6rZwqd+ANRtu4Nd4j89HSCSwIfRdTV6K+U1AICspsuq2KVFqdX5bPl6rwC0XCCphkjwaw7x2QcsbPe5a5lFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk/mzqtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAB1C4CED6;
	Sat, 11 Jan 2025 01:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736559685;
	bh=SaAkLuVh5qeM5RczhYtiRyngltVs9Mjfy/xMJTVOWIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xk/mzqtOkZWZ1bUHvh65lktetTPQyhONBxEJYI82Ed1EgCypli7pVEpV3JJGUm8mw
	 A8XIbZ/KqWanSuFYi5Ywu380X4oTGrN0NmWnT0TQRI4DXC/MRQGz7OQDtIjQdqnLbP
	 3ZCb7+okz/UmGqKsWY4EAWumje6bupcbRCFjOmxmLpk1R8bvv0vUAI6JnLZZ3XTjOr
	 jq6vPtk2rcfT6kJSUrZQks0iZWWg8E/Dtn7WCAGWGBHr8ePem5PqlIj8po1XEh7xm/
	 3mRIQhJzsNVWTcyzKurazP9smQ38f3FXwBsPPeJTj+DGh6nFFZ7R2PHYiKDJLOqSps
	 NMqN4m/44D3HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF93380AA57;
	Sat, 11 Jan 2025 01:41:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] selftests: bpf: Migrate
 test_xdp_redirect.sh to test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173655970751.2262030.14087955659103507101.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 01:41:47 +0000
References: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
In-Reply-To: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
To: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 10 Jan 2025 10:21:08 +0100 you wrote:
> Hi all,
> 
> This patch series continues the work to migrate the *.sh tests into
> prog_tests.
> 
> test_xdp_redirect.sh tests the XDP redirections done through
> bpf_redirect().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] selftests/bpf: test_xdp_redirect: Rename BPF sections
    https://git.kernel.org/bpf/bpf-next/c/2c6c5c7c1ad1
  - [bpf-next,v2,2/3] selftests/bpf: Migrate test_xdp_redirect.sh to xdp_do_redirect.c
    (no matching commit)
  - [bpf-next,v2,3/3] selftests/bpf: Migrate test_xdp_redirect.c to test_xdp_do_redirect.c
    https://git.kernel.org/bpf/bpf-next/c/3e99fa9fab19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



