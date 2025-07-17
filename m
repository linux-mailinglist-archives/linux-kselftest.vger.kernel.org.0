Return-Path: <linux-kselftest+bounces-37465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E45EB0825C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6F017B2619
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B001DE3A5;
	Thu, 17 Jul 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjhE2soT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9C1DC9B5;
	Thu, 17 Jul 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715789; cv=none; b=n57hZDJ53QgY2fjbDhwnkUt9rOpxq8s/praM8c2JNOabu80AJNIyTyHbOAdrlPFKYPq6FVpG1OK5ulynL1kAc397Xa2ZglbIbxudyAfQjg7UQMl/bORd+0D0dsdRWYMFMuEA7uwbELxULJIJY+yUyl4TLeMO9GNJKvf0OUg/fmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715789; c=relaxed/simple;
	bh=4ZNCZwXvNH9vuMgkk/NS1R5HXJ7/MpNDC0QStIdElmA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vy638lK21nY6fWEAgC02WiN8xdnrO/Ug05k6P3JMTdlMqmREfkYoKpf/fCr3kcPxoEbS/uriBmTNZR+sWLLn8Czg7ZXFaKffnN5kO03DD40o5fR+4erciyRcDMZuKvovgHKbjiNuijsIfkKEda7kCjrOzF+1LJ3d2pbpk5Mqq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjhE2soT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE572C4CEE7;
	Thu, 17 Jul 2025 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752715789;
	bh=4ZNCZwXvNH9vuMgkk/NS1R5HXJ7/MpNDC0QStIdElmA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YjhE2soT7mhlqrz+/hkv3UjIrd5XJxlzIWKRy4zyAirX+U4A0rLCOdVJwIcMAKtkF
	 EhftIpSOliE6OCY8gTiRvb2rYVSFqA+VyPfVRzBwB7Ae9Ii2EdpNA47RpiuSpQiSym
	 PVgiVPuUPCqNbS3LUCrQEP4AFeqqYfkB1N06MBSOQCcLjm/q7jEGCYNJssogem0mRK
	 rQ799N8bkepZb/UQ6iPmhDA1sD9VyJfvMMBha52u1ql5LGmVsyKmSiAhpUn89fw1iG
	 /PDFnM3DngrNaJY6ET5b5fAAzinjgQLualv6oSvVbESwkarCId05yWhVkQk6cWYVVc
	 CcPguFCGX43ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 593D0383BA38;
	Thu, 17 Jul 2025 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] bpf, arm64: relax constraint in BPF JIT compiler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175271580926.1388574.2871718742808894447.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 01:30:09 +0000
References: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
In-Reply-To: <20250709-arm64_relax_jit_comp-v1-0-3850fe189092@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, puranjay@kernel.org,
 xukuohai@huaweicloud.com, catalin.marinas@arm.com, will@kernel.org,
 mykolal@fb.com, shuah@kernel.org, ebpf@linuxfoundation.org,
 thomas.petazzoni@bootlin.com, bastien.curutchet@bootlin.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 09 Jul 2025 10:36:54 +0200 you wrote:
> Hello,
> this series follows up on the one introducing 9+ args for tracing
> programs [1]. It has been observed with this series that there are cases
> for which we can not identify accurately the location of the target
> function arguments to prepare correctly the corresponding BPF
> trampoline. This is the case for example if:
> - the function consumes a struct variable _by value_
> - it is passed on the stack (no more register available for it)
> - it has some __packed__ or __aligned(X)__ attribute
> 
> [...]

Here is the summary with links:
  - [1/2] bpf, arm64: remove structs on stack constraint
    https://git.kernel.org/bpf/bpf-next/c/dc704d0cfa43
  - [2/2] selftests/bpf: enable tracing_struct tests for arm64
    https://git.kernel.org/bpf/bpf-next/c/4a760d2d7aa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



