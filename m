Return-Path: <linux-kselftest+bounces-13502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30BE92D985
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE7028278E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 19:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FEE84A52;
	Wed, 10 Jul 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKkAEPdp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F115E88;
	Wed, 10 Jul 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641033; cv=none; b=pSapvLAfW8Kr8hJFbFPubmlOHpkibmkEuKh1rNO3psfSBTAxxQ7Cnla2bEMjAVK/ll4izm4D27air0JTehZFXiQizH3+BEvD63/HRmKUkL5/lhDPhf9oanvHHc53OKGKUqdVzhW4AYxwLh1oNXWIWZzl+4XYFYyMsMosqY3Cxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641033; c=relaxed/simple;
	bh=83oAH1y4b/G3MQcnay1WF4xTj/sdXPszU3IJ70N82Uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AT/GZkbhvL5zGac9Qkdb+I5A4mVuC//Algsp38JTsXIuHnQqLZ13CYBkMfmM6OFD5SoSmPggs3qQMIpr3+BKmZ4qznmMMS6HQ46yuDnDLuHJ6LlC7UTWo1H/buPu1qOXpIh/zwijEs+Hiwgo5YAgE+jkYqbuE+WgZ1z/CBOeSck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKkAEPdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25880C32782;
	Wed, 10 Jul 2024 19:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720641033;
	bh=83oAH1y4b/G3MQcnay1WF4xTj/sdXPszU3IJ70N82Uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BKkAEPdpNiqAl1MybTOT50PLj92fMddab1JhJito9AoSxlJBMnfwAnfA+o+h+KNFe
	 XsKh6iShkp9Ks0+D555j7m0TzLRagVmN1M67tnS/5tsSKIdKC9wSNlQ4c4904xp17y
	 ImCuUHD9lqi+frocw0ho/YfT9Cbuz5ZbYrx8zKyAJeuGNug0dOoTSGIDEwqs7o6qon
	 Wa07ROAlzafEEh8dYCNiWcDAKkCTp19HAjDWS7HQi8WTEROqI3ceZoMvuaiuPAwrDH
	 oImSS0a6XSjfTyau9faqldYDItp2s9zX9pfyY95fz/LFFgt523AHMobRsHoedfGaFh
	 V0MuZkz+DJaVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F8D4DAE95B;
	Wed, 10 Jul 2024 19:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] BPF selftests misc fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172064103306.11923.14968245917639696549.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 19:50:33 +0000
References: <cover.1720615848.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1720615848.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed, 10 Jul 2024 21:10:15 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v2:
>  - only check the first "link" (link_nl) in test_mixed_links().
>  - Drop patch 2 in v1.
> 
> Resend patch 1 out of "skip ENOTSUPP BPF selftests" set as Eduard
> suggested. Together with another fix for xdp_adjust_tail.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: Null checks for links in bpf_tcp_ca
    https://git.kernel.org/bpf/bpf-next/c/eef0532e900c
  - [bpf-next,v2,2/2] selftests/bpf: Close obj in error path in xdp_adjust_tail
    https://git.kernel.org/bpf/bpf-next/c/52b49ec1b2c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



