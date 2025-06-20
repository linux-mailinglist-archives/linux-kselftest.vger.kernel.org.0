Return-Path: <linux-kselftest+bounces-35460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36684AE2259
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 20:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98ACB3A3360
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 18:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD692EAD08;
	Fri, 20 Jun 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czQmKt1A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3C2EAB93;
	Fri, 20 Jun 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750444782; cv=none; b=mYLfnBcThCeu4B2tufVcaM4vZAp+x5s1vyoBugADkBXG2X9bwzOHphny7j6FbjK3+BAclsRHIeEzvXepc0v4gjge6Tf9e4F/G4262f3V8mkuvICC8Ap4yfitB+BIxaatehjUF6xAi9F5UYt4VIBWn2nUgvThPy7ru395z7+XLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750444782; c=relaxed/simple;
	bh=qFplRIR30byJ3eK29/l57zIY4PeTzFMDH2y+qY42Hjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RCsmPrQzMobm5TUEdFS20UYw+J9f92x9As3kGOB+IBjI/wuBTSZFN/OtSl+HmpNY4lTCT4cVnDy/2VwkY4ImynZze1f5NvVW/PHizZcfel05gZ4imOF57Og8jKdRv6sLdgjMZbPvn+QpZ5EQIOvFc8+F1t6y/9HW/w3OVVh/nxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czQmKt1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0534C4CEE3;
	Fri, 20 Jun 2025 18:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750444781;
	bh=qFplRIR30byJ3eK29/l57zIY4PeTzFMDH2y+qY42Hjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=czQmKt1AnfvaXLqTvZ2KHnzn0cUAxtgxEDTkl8IDvWT0vqMnCOX3krGRrHGUnCGbt
	 HxgAX/ZeDaR+u4l58FYbQh3E5mVnA3cHc1mQqs6As7ey7IGDOV/ygl2GX6PbS27RBX
	 +FVagyYCjeuzxaSLLIHpEDsLNDXfglerrMyFLoSz77xcKXVr8RrAoV9ypHEEAEqRXj
	 5wnxd9+sijPDWZ2GOQN+AH5NC3Yl8LC47ajlKYl411kRg7eKKbXDo21ijO5tus3GAm
	 F8dfocxVnVfFWwH1i5RtJ6kQmxtOdjFI57UY+pKN/zZZMuYj16ffvcQ4Cvur4ZYEtx
	 N4DkVISMGED5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFCB39FEB78;
	Fri, 20 Jun 2025 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/2] bpftool: Use appropriate permissions for
 map
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175044480950.1670618.6860751226215846032.git-patchwork-notify@kernel.org>
Date: Fri, 20 Jun 2025 18:40:09 +0000
References: <20250620151812.13952-1-slava.imameev@crowdstrike.com>
In-Reply-To: <20250620151812.13952-1-slava.imameev@crowdstrike.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 shuah@kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 justin.deschamp@crowdstrike.com, mark.fontana@crowdstrike.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 21 Jun 2025 01:18:11 +1000 you wrote:
> Modify several functions in tools/bpf/bpftool/common.c to allow
> specification of requested access for file descriptors, such as
> read-only access.
> 
> Update bpftool to request only read access for maps when write
> access is not required. This fixes errors when reading from maps
> that are protected from modification via security_bpf_map.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpftool: Use appropriate permissions for map access
    https://git.kernel.org/bpf/bpf-next/c/d32179e8c258
  - [bpf-next,v4,2/2] selftests/bpf: Add test for bpftool access to read-only protected maps
    https://git.kernel.org/bpf/bpf-next/c/f8b19aeca165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



