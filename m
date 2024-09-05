Return-Path: <linux-kselftest+bounces-17322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7996E3BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADC5281D69
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668241A2566;
	Thu,  5 Sep 2024 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqegCMrb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70919EEA0;
	Thu,  5 Sep 2024 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567034; cv=none; b=VydAFQrF208U4XN+N+6K5OJ905Bq0ZF5cPbDFNIQvVRgOKEnXA3ZjisZxYq+NwwrEDscgyX9wscB7F2P1SkuZLZpFymBu9Rr1+qHxNgOArGcIpWyRO9+gU5g+7fLOfskcSLzmRm8lTM0OSUGifAWcrh0wo2qPT5JNX2q5cx2iSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567034; c=relaxed/simple;
	bh=F8McJ2Dh7rdF2JqMNEo2h3wzSea22lzOfgbFTJCTRF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cCyaTOS1rMgHfxvREmuH6e3t3d7VKxffOHw69f4v+iWOXYgd3+/tUJ64sBvu65FHYJki1UH5Z7fXMBaRPZTi6VRPM2VB3/X/D1Dn3kHzsUv7NEWUJ7UJedfpc67UgHH58pQhcK+Mo6GSdx5/G1F1zExsadhMPdtPJscQcoZyJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqegCMrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90E7C4CEC3;
	Thu,  5 Sep 2024 20:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567033;
	bh=F8McJ2Dh7rdF2JqMNEo2h3wzSea22lzOfgbFTJCTRF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IqegCMrb0TLt1ukjzsgoqck1syin6Z6Dc3JqVDGk16E1z+sndyun2wwUyR/L2SW30
	 cCrTWF6mQgafBVkj3hsLQmzr5MusZLRLZUFmvYxRhCU0QF8wAJeR4qCo7w+tnewWSI
	 VfG6CymdoMoysPatB65Swfdl7OEP+I0CQRJNnZAs3T9CnWFNXpg794XfaNJko0Zdaq
	 MVZJcPXCqVsxijjBpzWQCZFz8DgmcgDJK4vUKiNqL6Pacg/X30LrFboitbMcy1vJM+
	 IHLtFLSxwbr+RA4mAUd4gdAYBopC4zaYUCuhKMPLK5ZjlqJ8H8fGtbDWK8TitXTy8g
	 Z2eAs0YNJQHLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1AA3806651;
	Thu,  5 Sep 2024 20:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 1/3] selftests/bpf: fix some typos in selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172556703454.1814248.16375163338702525261.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 20:10:34 +0000
References: <20240905110354.3274546-1-yikai.lin@vivo.com>
In-Reply-To: <20240905110354.3274546-1-yikai.lin@vivo.com>
To: Lin Yikai <yikai.lin@vivo.com>
Cc: bpf@vger.kernel.org, opensource.kernel@vivo.com, qmo@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, rameezrehman408@hotmail.com,
 thinker.li@gmail.com, alan.maguire@oracle.com, yuran.pereira@hotmail.com,
 linux@jordanrome.com, zhouchuyi@bytedance.com, davemarchevsky@fb.com,
 menglong8.dong@gmail.com, tony.ambardar@gmail.com, razor@blackwall.org,
 geliang@kernel.org, quic_abchauha@quicinc.com, houtao1@huawei.com,
 iii@linux.ibm.com, jose.marchesi@oracle.com, shung-hsi.yu@suse.com,
 void@manifault.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Sep 2024 19:03:05 +0800 you wrote:
> Hi, fix some spelling errors in selftest, the details are as follows:
> 
> -in the codes:
> 	test_bpf_sk_stoarge_map_iter_fd(void)
> 		->test_bpf_sk_storage_map_iter_fd(void)
> 	load BTF from btf_data.o->load BTF from btf_data.bpf.o
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/3] selftests/bpf: fix some typos in selftests
    https://git.kernel.org/bpf/bpf-next/c/5db0ba6766f8
  - [bpf-next,v1,2/3] bpftool: fix some typos in bpftool
    https://git.kernel.org/bpf/bpf-next/c/a86857d2546c
  - [bpf-next,v1,3/3] libbpf: fix some typos in libbpf
    https://git.kernel.org/bpf/bpf-next/c/bd4d67f8ae55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



