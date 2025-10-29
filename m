Return-Path: <linux-kselftest+bounces-44354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6CC1D08D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36EF04E1216
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907B3596FA;
	Wed, 29 Oct 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdpYQXSk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A555345754;
	Wed, 29 Oct 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766834; cv=none; b=QjdFXdFDuk0gdlxkzsQ8LKHAgjqNRB7zHiCpiDfBHlHD7cDydGl+tQfP4ZDX8noNescDS8egAqefRWrRX7m2ffn8OlNx94Awu2Ku3wzDVxP3MMxyiUNBgVIO1nM1C0vhzJgUqAoTltFRgNqOmSTIZHlX9gPnhpiWSvwW/OlJ2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766834; c=relaxed/simple;
	bh=FPNNebRY/3BNB37M1f3dFBO6d/6gfDm+j/J2gEeRKSY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a8R6foMSL8bogokmDUszsKi62sYwAibuT2XnVRLH0zLD659L3h8aA16VP8A43PAgCoj5+Wh70FN35oapUB8sNIMMPTyrls/RcT3oCVgx0+ABxxAwKzTBi096+nZ6exc2Goa5knjCohoSJF2cTFsYnX+DUglw4JumJRRIfcianSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdpYQXSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B91DC4CEF7;
	Wed, 29 Oct 2025 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761766833;
	bh=FPNNebRY/3BNB37M1f3dFBO6d/6gfDm+j/J2gEeRKSY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bdpYQXSku1I5U5dOpYSUf+MtX0juFsvN0DaXvnrfTHgoUl9qWBpj1X0vsaaH6Jzbp
	 JuRPlrlmLa74u1UcyoA7V8Sqfo7iHyP709ctNgntgXdT6uDODagH5NCfMsUT8idsp1
	 KEGNUZ/kO4xtAM5qm9jEwEV3U9w3EbBZtG0y2Ep7F1yVXr/Dg6Lr2X+g0hyZuOZ4i7
	 pY16AHHuPThfBUUHQnQZtvK4Atp0lFMxo0boccJ1L/4eQ/PfQ0pecyh+mplv0ukH39
	 +iT2BkXICq9ExqR7FyLUySkcBRJQiMWQ45qOt7n+3Bwtc/3xW96Y0Yh3HboahAOtxP
	 jaFj6v8aJZqTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBE283A549BD;
	Wed, 29 Oct 2025 19:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/4] selftests/bpf: convert test_tc_tunnel.sh
 to test_progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176176681076.3187348.7903797974082135104.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 19:40:10 +0000
References: <20251027-tc_tunnel-v3-0-505c12019f9d@bootlin.com>
In-Reply-To: <20251027-tc_tunnel-v3-0-505c12019f9d@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 bastien.curutchet@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 27 Oct 2025 15:51:52 +0100 you wrote:
> Hello,
> this is the v3 of test_tc_tunnel conversion into test_progs framework.
> This new revision:
> - fixes a few issues spotted by the bot reviewer
> - removes any test ensuring connection failure (and so depending on a
>   timout) to keep the execution time reasonable
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] selftests/bpf: add tc helpers
    https://git.kernel.org/bpf/bpf-next/c/1d5137c8d1ac
  - [bpf-next,v3,2/4] selftests/bpf: make test_tc_tunnel.bpf.c compatible with big endian platforms
    https://git.kernel.org/bpf/bpf-next/c/86433db93256
  - [bpf-next,v3,3/4] selftests/bpf: integrate test_tc_tunnel.sh tests into test_progs
    https://git.kernel.org/bpf/bpf-next/c/8517b1abe5ea
  - [bpf-next,v3,4/4] selftests/bpf: remove test_tc_tunnel.sh
    https://git.kernel.org/bpf/bpf-next/c/5d3591607da2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



