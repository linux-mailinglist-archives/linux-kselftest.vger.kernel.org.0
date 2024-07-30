Return-Path: <linux-kselftest+bounces-14492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F09C9421D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 22:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35331F250F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900E218CBFC;
	Tue, 30 Jul 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmGT+v0F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0AE1AA3C3;
	Tue, 30 Jul 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372633; cv=none; b=N0HUf9A+dYx+C1b9AX9Vnyl8+r/sgWB20+cxWBpJxDwibOM1wpwPbkNhidozBfzIZ75XUg8P8uuNZ0qHGvvgkJj4+jcGJUm756q8B0LZDyApRNRGaOrvZt73PlAAeuyH4T22sWKc/66pHHKrH7yw7tV8XZXUQvJno8hP77AL34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372633; c=relaxed/simple;
	bh=mgbDbs3m2vKrcowpVkRdf2QvyifjX7DGu7yPNSLLAVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lAEYnnUF9gHZe/KEkwmwC3h+wfomiEXlsHwjnqdKWyTW/UJ1rPCH2Fhoa/Ogg00v6nYHsom+GTN8Hk3EyzdKBfY6kr/sNW+0WdHSC6g9rizeJ1Q8Mk0iC81g4cOF1l859VMdC8HDDDPLt4bbY1K4xQUTjbtySYb1CIcBMlNfcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmGT+v0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD7CAC4AF0B;
	Tue, 30 Jul 2024 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722372632;
	bh=mgbDbs3m2vKrcowpVkRdf2QvyifjX7DGu7yPNSLLAVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FmGT+v0FnlO9H2NNnWNgxAHW0irv5gSsOUCQ/XrtWHwdOQ+wvlE+5zzQnb/Zm9dg3
	 wlwaPkG6oHh3a0nvm3DkzvMUvDFdtcX9rRIA5j9isIzDxSPtIFTnU637Gk44iOhgxf
	 hguPAruwKwyAPczAxrINK6ScULc7QStK2JwFXUoAi+Ss5f5s+dmgTLXzJNeXxJNsqQ
	 8N74GcxLILRkVbvDZXAd0XPT53rnCfA5m8/nP5Kw0NkHSX33g0PGIbMnaPSAt1RH34
	 sQFl5ZrZbaao/EMJ5zHzIcABmZQJfFCdi942+Ceq9VlB+2uJYQYK3Wjg5HoxFjjLk/
	 uCBo9tf25eQgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9509C43140;
	Tue, 30 Jul 2024 20:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/8] selftests/bpf: Use portable POSIX basename()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172237263281.10299.11042421152153113745.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jul 2024 20:50:32 +0000
References: <0fd3c9f3c605e6cba33504213c9df287817ade04.1722244708.git.tony.ambardar@gmail.com>
In-Reply-To: <0fd3c9f3c605e6cba33504213c9df287817ade04.1722244708.git.tony.ambardar@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, davem@davemloft.net,
 yan@cloudflare.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 29 Jul 2024 02:24:17 -0700 you wrote:
> Use the POSIX version of basename() to allow compilation against non-gnu
> libc (e.g. musl). Include <libgen.h> ahead of <string.h> to enable using
> functions from the latter while preferring POSIX over GNU basename().
> 
> In veristat.c, rely on strdupa() to avoid basename() altering the passed
> "const char" argument. This is not needed in xskxceiver.c since the arg
> is mutable and the program exits immediately after usage.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/8] selftests/bpf: Use portable POSIX basename()
    https://git.kernel.org/bpf/bpf-next/c/c0247800ee7d
  - [bpf-next,v2,2/8] selftests/bpf: Fix arg parsing in veristat, test_progs
    https://git.kernel.org/bpf/bpf-next/c/03bfcda1fbc3
  - [bpf-next,v2,3/8] selftests/bpf: Fix error compiling test_lru_map.c
    https://git.kernel.org/bpf/bpf-next/c/cacf2a5a78cd
  - [bpf-next,v2,4/8] selftests/bpf: Fix C++ compile error from missing _Bool type
    https://git.kernel.org/bpf/bpf-next/c/aa95073fd290
  - [bpf-next,v2,5/8] selftests/bpf: Fix redefinition errors compiling lwt_reroute.c
    https://git.kernel.org/bpf/bpf-next/c/16b795cc5952
  - [bpf-next,v2,6/8] selftests/bpf: Fix compile if backtrace support missing in libc
    https://git.kernel.org/bpf/bpf-next/c/c9a83e76b5a9
  - [bpf-next,v2,7/8] selftests/bpf: Fix using stdout, stderr as struct field names
    https://git.kernel.org/bpf/bpf-next/c/06eeca1217a8
  - [bpf-next,v2,8/8] selftests/bpf: Fix error compiling tc_redirect.c with musl libc
    https://git.kernel.org/bpf/bpf-next/c/21c5f4f55da7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



