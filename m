Return-Path: <linux-kselftest+bounces-42972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D57BCE171
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 19:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1E824EB9A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331AE1FF7C8;
	Fri, 10 Oct 2025 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIsSwea0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A521C6FE1;
	Fri, 10 Oct 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117422; cv=none; b=tSLWMzHnBlTkqYm4hdZIqZIE5MLQtktWEKUFYC4S3trk+3SDMg8nYFEfTgBtj37wUCetWETMBiG0I805vmgVNmGekfZlrLQJ2iDQFkDC4JrHdIFmVEdAiauQpPmxuPAP4DEy9NMFoJJaoG8mhzsyF+m6tkN3j0wrUabzuWQKa8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117422; c=relaxed/simple;
	bh=Qex65Vn/WzSn9sfGiKV7hYjCE6O+4yZoqzhj49DtQlE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hv48gEuZ42wI8Z57ATrPNq/KjlAomYReU746sz6LA/BAuH0yoOLQZc31N0s7sb8uz6qVW0YjGPdbJMKEjQFgC6wb148igd9QDTHWCrQQt38wxdmXLtM9sLotilpR/RBRmflQkWzDRKBecd3ekBD18o8m9PYGu9i8z9Yq246/+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIsSwea0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79378C4CEF1;
	Fri, 10 Oct 2025 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760117421;
	bh=Qex65Vn/WzSn9sfGiKV7hYjCE6O+4yZoqzhj49DtQlE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TIsSwea0MtiLgVbBH5KsEGfV7M7bhT8cboxerXU2IGTvlk08LfT7bekMmQg/wxVad
	 I+O4o6XQ1ui/7d4xGdm6D+Pm1URN9L9Di7sc8G2O/V21CoBHpI1BIO310rq9p03Xkm
	 jOL8aL9gN1Qx2zUPMmkUagpd8H6b9mf5yBFLCPIUbxbbfjruXGX0WGFyDvcmTJvY+T
	 ul9gsd/YwB3kQ2RHEfVVIiEvyOD82yPPzUxEcj835hosKztJeq1LzzcC2ep0fXiNXJ
	 jWav1HmAhtPt6UUpkMgRsLd15uZ1AHUuLpC6a0uZLOYVaf13TXvfW3dRTVfxsfvoCc
	 Bw/5JNKr8HvZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3412B3809A00;
	Fri, 10 Oct 2025 17:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: Avoid RCU context warning when unpinning
 htab
 with internal structs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176011740900.1056101.16417753312822261122.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 17:30:09 +0000
References: <20251008102628.808045-1-kafai.wan@linux.dev>
In-Reply-To: <20251008102628.808045-1-kafai.wan@linux.dev>
To: KaFai Wan <kafai.wan@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 toke@redhat.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Oct 2025 18:26:25 +0800 you wrote:
> This small patchset is about avoid RCU context warning when unpinning
> htab with internal structs (timer, workqueue, or task_work).
> 
> v3:
>   - fix nit (Yonghong Song)
>   - add Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Avoid RCU context warning when unpinning htab with internal structs
    https://git.kernel.org/bpf/bpf/c/4f375ade6aa9
  - [bpf,v3,2/2] selftests/bpf: Add test for unpinning htab with internal timer struct
    https://git.kernel.org/bpf/bpf/c/accb9a7e87f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



