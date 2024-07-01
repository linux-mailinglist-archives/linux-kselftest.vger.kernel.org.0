Return-Path: <linux-kselftest+bounces-13012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05FF91E3E7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9E31C20FA2
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793B16C87E;
	Mon,  1 Jul 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbMte/2K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2878216C850;
	Mon,  1 Jul 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847232; cv=none; b=JLH5Ai6vyFEm1DGl5Bv/MzypzS8ccxfiikk/n2oqEgUxECAmpDMlo7gKopXD60Z7ZWCRRqDRsWsxLwIdjX/mF12PhNOJMGRM7WjiNIer0XEFwCk789CUN2UJpF/fIIqNnNtol6VsHK7BlCbI95FWo2/Gdl+N1P1R66xiJk/cois=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847232; c=relaxed/simple;
	bh=eBZTgio92XvIiaJrlosp4SpcyfO8TN1ko1sMkGrctV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j7LcAsEemA07Ai3AvgAoxM5mT344ktOwCp4REA6mepEvqiwdiVSltmY03mthnBDFXl8wUvKmw82DCRHUUzk5iAReQsEXvPrvX+osg5AitucPXpdp0PLL7VxCqXZjD7x8X7CyCq6sKDySeimy0LQmgmRwnHiBnuZVkgC0c35iJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbMte/2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A06F3C32786;
	Mon,  1 Jul 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719847230;
	bh=eBZTgio92XvIiaJrlosp4SpcyfO8TN1ko1sMkGrctV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CbMte/2KIZuE6OBCyEbal2xPSDK7ZLPu2X03gX2Qwa/kah5z9T/mAuadTwndtPc2R
	 UUIfLvbjAU/dqS/hBqTRUlvc6Peu12xqAjjZMT0UH+m2mdZDnrIqHcL8coY/bPE29J
	 kKb74rvUih0HbE/LRcHsnRuF3xrJEVbwYfA6z55pXh7OhYbzZ4S4TSdE9w6jWvmDPq
	 xQuh9YTVqrv6swJtQNCUphYBCQj4yoLCf3z/IEOS72V5KpLmt8yeLRgsxi4YQgoAvG
	 z0IlwcfvXLdrVjE6mEU1/dkIPrxIB9DFpwwRFFvD1cBTBIshrsG/b+dqXBSu8v4BPB
	 lH1kFt2nGvmeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88680C4333A;
	Mon,  1 Jul 2024 15:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf:Delete extra blank Lines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171984723055.1282.11176590552984938670.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 15:20:30 +0000
References: <20240627031905.7133-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20240627031905.7133-1-zhujun2@cmss.chinamobile.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: shuah@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, ast@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 26 Jun 2024 20:19:05 -0700 you wrote:
> Delete extra blank lines inside of test_selftest()
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - selftests/bpf:Delete extra blank Lines
    https://git.kernel.org/bpf/bpf-next/c/03922e97bc30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



