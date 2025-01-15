Return-Path: <linux-kselftest+bounces-24579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8CA1267E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 15:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043AC3A53A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449937080A;
	Wed, 15 Jan 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoGhkQ/l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C778F57;
	Wed, 15 Jan 2025 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952610; cv=none; b=cy0Pyj3od8Ys4Xcr3QvPkfK2aMW4+k+Nz7aBlrnbms5ZMW84wa6ljV61D5N9rm++eeEaPs8d1wYwHHwjujvhi/bQkGnjliO7hz9M1+wrLI9Kk1jvD3v+/5En5Xtuy0XvQZTyXBlw9tX27mxy7kwUnUZVy03p6GSCW7BrtEsM350=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952610; c=relaxed/simple;
	bh=MgSgOR07Uk2XNhXGIzgpjx/GRSxlKQMVhkBnA85nM8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bYTLoxZ5cFK6pXf++RY2CviEpyD/mkcpWDxC7LtWokO8aoU3sBfquAPGyNCngfUQGVA+RyYfkTc9qk7owGmSIWLEtzHoINApLq6QmRDV7j0+5RI8vtMdichq8D2TY6g4+UFMC8CP3gGsGarNIY/jOAyFBoFVcy2KcsNqwW8pgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoGhkQ/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D174C4CED1;
	Wed, 15 Jan 2025 14:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736952608;
	bh=MgSgOR07Uk2XNhXGIzgpjx/GRSxlKQMVhkBnA85nM8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WoGhkQ/lOuJEdcvIpg8J4xY26/jImKIIAFk1G1c1ywEYTD4k2Sjs0gz/LgAFrZqFX
	 aJGIRDpzSkUK08aIa0QEDwFJN7nCHyWxDuQtMZUvhUvSnRZsB69FcVqHXSN0mscXNx
	 ac2pfBv3GDgmmOrD3P6I8yj0psYSlvZkDwyoifkdEZqF78uZcX3tdZFZU5jV0zdiun
	 XBH5R/EZ2sQOw92aEhuPuJsggifIlUtmagaecVUoTR1nzRshqQfeUUNxQZKt9FhS2a
	 PXIy+PlaRRSezFI2C0curLwSbC/6v3T8UesJT6s4XmOQTyFpIo/6GQRaq9SC7I156j
	 NwNIs1E6CqGfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEA31380AA5F;
	Wed, 15 Jan 2025 14:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix test_xdp_adjust_tail_grow2 selftest on
 powerpc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173695263151.740417.13884014136612446857.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 14:50:31 +0000
References: <20250110103109.3670793-1-skb99@linux.ibm.com>
In-Reply-To: <20250110103109.3670793-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com,
 andrii@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 10 Jan 2025 16:01:09 +0530 you wrote:
> On powerpc cache line size is 128 bytes, so skb_shared_info must be
> aligned accordingly.
> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c      | 2 ++
>  tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c | 2 ++
>  2 files changed, 4 insertions(+)

Here is the summary with links:
  - selftests/bpf: Fix test_xdp_adjust_tail_grow2 selftest on powerpc
    https://git.kernel.org/bpf/bpf-next/c/9fe17b7466f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



