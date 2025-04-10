Return-Path: <linux-kselftest+bounces-30457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C265A836F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 05:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E6D19E749D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 03:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8C1E9B30;
	Thu, 10 Apr 2025 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8YEe/8x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE21B4F0F;
	Thu, 10 Apr 2025 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253996; cv=none; b=OvXYby/cO6BPUMDvdori9zCVGqSMIth9n/FscU/5Wa0MyLhj1mw5JWFVqO8W25M01UlYxsmXrQ6dT1bBok/kNM0CN2rXNiiv03bs4JUf2BqsB4eHCvnS4l9bkqz+uiOXWuwgD5pjp+AVhwKyXBxGT+DHVev+P0njTbH4mmRq4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253996; c=relaxed/simple;
	bh=sVkjhND4OnGT29i081T50Q7YVLWEUAsudY0GWSSmi+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pm+D0Akqjie2EMfRp+zTkZ8eH8lyXsUEMtm1zh62URLgV1nQovsHRrmAuv14pFcBr5LK58XGnYAxiGwG104y0LlbdLlMozr4OLOq5IRvzQHTkbyuMaYy5sGoH+0EZocEqR4ZGPfAd0WGmnmsq1AKGG3sBeqdWg2gBh4ITivcD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8YEe/8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AE2C4CEE2;
	Thu, 10 Apr 2025 02:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744253995;
	bh=sVkjhND4OnGT29i081T50Q7YVLWEUAsudY0GWSSmi+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V8YEe/8xDPris59JyQkg7dI3BnzNlfBcsI6h9RUEzVqqSf6UhyiCPz4T//cwotsrF
	 qoGRMWB6fqatecB4GZ87Wr/zZDwlYO/4tdcVPNJKCuMolnDOlsvUB7MhYFgnrUnWWm
	 WmjWIOVheG2ZEq3ID2JzF/soNpny+GrBaJMdeWiaiWQLmBMhmNHDPQdd/l2u3dv5HV
	 N/fmlm8QPYC0sjrdBQOOosDAcZPi0CikEvJexoRJHygWijwi76I1FuCWVAwdOK7kxD
	 jgEPVnUn/6NTnecuOVBG353ZEOj4mLJ6e5BwI+Fos4LI6UzzbPgXEXyRN14a+nWmx1
	 2jKY8KXnLnP5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 87D5E380CEF9;
	Thu, 10 Apr 2025 03:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: fix ktls panic with sockmap and add
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174425403350.3129009.3714564709160612234.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 03:00:33 +0000
References: <20250219052015.274405-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250219052015.274405-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 viro@zeniv.linux.org.uk, mrpre@163.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 19 Feb 2025 13:20:13 +0800 you wrote:
> We can reproduce the issue using the existing test program:
> './test_sockmap --ktls'
> Or use the selftest I provided, which will cause a panic:
> 
> ------------[ cut here ]------------
> kernel BUG at lib/iov_iter.c:629!
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: fix ktls panic with sockmap
    https://git.kernel.org/bpf/bpf-next/c/54a3ecaeeeae
  - [bpf-next,v2,2/2] selftests/bpf: add ktls selftest
    https://git.kernel.org/bpf/bpf-next/c/05ebde1bcb50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



