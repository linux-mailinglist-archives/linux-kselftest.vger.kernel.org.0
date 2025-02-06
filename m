Return-Path: <linux-kselftest+bounces-25874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DFEA29E1F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 02:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5CA3A776A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEC92B9B9;
	Thu,  6 Feb 2025 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qp47s5Sr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82DBE40;
	Thu,  6 Feb 2025 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738803607; cv=none; b=jaEQPCW11IQyIOYpsKqDjDe0BdAZQRvR8jArG2EOkUct2QK/YlZcJ+utHvwUEIWLupbWsEDpn27/q8+skd4L/omhPUCRHFCc5Uov3yp01G8NYteDTlz91XHzvpyTJqeOskK/7rp+Smdu6ji0t3i3CUF7zBtPeCacW2iRsETbWMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738803607; c=relaxed/simple;
	bh=K/+CpxPj7U+irpyynnCsaKf/QClUHUkBtv5jQ3252JE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nyse53WnsM5GOYCzgK1dYe54eoGahMH3Bk/J23Q+qE5OC0AfHNjG+hyRQFSGq2SqRZl+wHUA3m7Pu890A2yIKQFbWNeVoZRUXTpsDpCHtVinoFrRaCgV8kWsPug5jlG4ZZo4Dp/9o0Q6K9fjG2+auQH8jV+mIzGx5buOEKfT+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qp47s5Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E983DC4CED1;
	Thu,  6 Feb 2025 01:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738803607;
	bh=K/+CpxPj7U+irpyynnCsaKf/QClUHUkBtv5jQ3252JE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qp47s5SrhmIbMxd6Jc0Ge7ofFFexUDqJaw/jbTqRKafp7aLNWdAZXQAwTewkwD/YT
	 NeGVQgjow17NGDnS+YxKZwPoWyUDwgj4J+nmoPFj+6TBCIVHiruWFMHWxb2+l1HQYJ
	 S1l5awLQrw6JxVsgHLSLJ/2DS9U6mPrPJZvZy6bwy8C0+ODH94v8avnITTZzIGL4uq
	 69VlzoubdMmz2j6RdOd+ylXNdU1zgGrnjhIGUizLL7iWZjR8pDGt1wFilDXZNOZSIv
	 Up1PmUYx/DSYfojECzHee6koraPgU0Ubn/Ind3M8yAo5Gcy5Yo4P5Y2IrFXkMfHaFD
	 gPF5z5joydjgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE344380AAD0;
	Thu,  6 Feb 2025 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: bpf: Support dynamic linking LLVM if static not
 available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173880363452.959069.1872974221131683094.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 01:00:34 +0000
References: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
In-Reply-To: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: shuah@kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 nathan@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 30 Jan 2025 15:33:45 -0700 you wrote:
> Since 67ab80a01886 ("selftests/bpf: Prefer static linking for LLVM
> libraries"), only statically linking test_progs is supported. However,
> some distros only provide a dynamically linkable LLVM.
> 
> This commit adds a fallback for dynamically linking LLVM if static
> linking is not available. If both options are available, static linking
> is chosen.
> 
> [...]

Here is the summary with links:
  - selftests: bpf: Support dynamic linking LLVM if static not available
    https://git.kernel.org/bpf/bpf-next/c/2a9d30fac818

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



