Return-Path: <linux-kselftest+bounces-19494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8F3999A4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 04:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165BB1C25E3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596D61EBA12;
	Fri, 11 Oct 2024 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jlp1Pp8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318931EABC8;
	Fri, 11 Oct 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613224; cv=none; b=VsN3TC01OGtlVLn2jjk9LMcNIcFPFcgP8wZpHYM+JI+eZnGIyXZtfnH6P8ecsSwblNC4XoCHhNm/4A9dc20+G/LWFQPBMrwl86rrab0oeNRxLUmp4t9u3+69f4bOcHoZKkVjGq7Q2GOB07mXdeNAblFs+XyOkWw3sXbbkJXR1WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613224; c=relaxed/simple;
	bh=BQLFEExhevMT+qIVLA3ERcYd4yRjbC+4AQJ8puarpwA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fd8D4VbXzA0FO2Ht7cGmmEvohEfmZEK8zjnJB96ErPkKQHCdjmCwjMUxmRL5pVNxTcRZYv3gINY7Pp7Qa9QeUBVVUTyLvmwyHGvO0Pmq10uMonyF4G3O52I5jYif8ZoGBFAmAcXtthOGXRyjkTuF0lmXOOSJzR9oZuAilQAc1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jlp1Pp8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA42DC4CED3;
	Fri, 11 Oct 2024 02:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728613223;
	bh=BQLFEExhevMT+qIVLA3ERcYd4yRjbC+4AQJ8puarpwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jlp1Pp8RKOTaIAfPERpyeBVPiRb/HbA+Mf69dbVvP9DjhbM9rzjU0/tedikh4JNbv
	 5SNpBbxvz+gAYRl3wchXroyDQdw+WlEe3vOqqMhzi6jvCIErtqDdEDbQYMq0EppNHx
	 PiStxmpwNrMCbcRBUZ1L9dPs/3K7qvPNdT8i370VMUerPVkVJLuFzbMTSz4unyv4ay
	 R5og+vT4oCK/Ty6d96FAgH+Sq5GPdbWbuIer/xmd7ThpdHLvMzFa/omdSHlKFp7QBr
	 ve17+d61p7j1mdx/Btj4MU7lg+dNM/tKzEgxzSL1bh9dDBvU3/2HOjkduIow3wgIeB
	 bsH2mKLXECVMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB23803263;
	Fri, 11 Oct 2024 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix cross-compiling urandom_read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172861322827.2249999.11507085376179509228.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 02:20:28 +0000
References: <20241009040720.635260-1-tony.ambardar@gmail.com>
In-Reply-To: <20241009040720.635260-1-tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  8 Oct 2024 21:07:20 -0700 you wrote:
> Linking of urandom_read and liburandom_read.so prefers LLVM's 'ld.lld' but
> falls back to using 'ld' if unsupported. However, this fallback discards
> any existing makefile macro for LD and can break cross-compilation.
> 
> Fix by changing the fallback to use the target linker $(LD), passed via
> '-fuse-ld=' using an absolute path rather than a linker "flavour".
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests/bpf: Fix cross-compiling urandom_read
    https://git.kernel.org/bpf/bpf/c/fd526e121c4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



