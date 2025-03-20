Return-Path: <linux-kselftest+bounces-29509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B0A6AC3B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 18:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33873BC8FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D8225A59;
	Thu, 20 Mar 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqFub+mX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B9225A39;
	Thu, 20 Mar 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492396; cv=none; b=AUPmmljYIg8JQueCEeXaLr37s6MOoZhZJ3sIZmbQFegfb21MKxqPBBk0LVoWgjXuIFJfljquhk0vLccyoEVcF8C5WC13meGbqFQPBGu7ktKFOA7JCQFxBwm/W0noRMIRaBjxWvg6xCiHyTeQD/G8SbMeAp6bvRZ4HBZ3XEFFTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492396; c=relaxed/simple;
	bh=veXI/2pf0cPonxNdPJd/35KBv/hQlggJFWgaaXSaPMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oaeL62Cbz39uzny+1XpGCbWsNke48V6ij465N4EMbKFokgsRbJHGKbr2mgmCmWNymhA25ISw65pU6pKbqq2q9KrFo6Qfo3oTv+SquXID+Opvu6iRFOXPk4Ozk8LW8aQZ7EfKGXBpVBQ4saInvS2R9O6MZBfr3+fwre/ptU1IsjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqFub+mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3B3C4CEE7;
	Thu, 20 Mar 2025 17:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492396;
	bh=veXI/2pf0cPonxNdPJd/35KBv/hQlggJFWgaaXSaPMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JqFub+mXxqKvIm8oM2lVVvWckNUG+pgGD7N/dx5RhN7VdwqjaawV3NRK6GSeFslHy
	 hPyWCM7RNpEwzA8XV8r2Q1ocfebjTvmgOZKIYgRwHx4vn6YfbKGyubY+NDMNv65iLB
	 KvgGlioDCWdpuXPXcpwmzn75oB3Ppxt1MP9epO1mQTRxyij2eGf1b5FdC9l/fKSOvP
	 jcGEkwmpsluJwuhFxVluRP0REKMPwkQeA/F+wiKch5sCwf656USV1b/4EAHKUIwa2K
	 AQgwmbZfTaif6a894uPZ/QmFYg0yIERdompf6B30JrRHMp1FkRvJmyhd6ZKOQU/tgc
	 Pcjnv6NpbH8gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3412D3806654;
	Thu, 20 Mar 2025 17:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Sanitize pointer prior fclose()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174249243205.1852962.16150935978028407496.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 17:40:32 +0000
References: <20250318081648.122523-1-bjorn@kernel.org>
In-Reply-To: <20250318081648.122523-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, bpf@vger.kernel.org,
 bjorn@rivosinc.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 18 Mar 2025 09:16:47 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> There are scenarios where env.{sub,}test_state->stdout_saved, can be
> NULL, e.g. sometimes when the watchdog timeout kicks in, or if the
> open_memstream syscall is not available.
> 
> Avoid crashing test_progs by adding an explicit NULL check prior the
> fclose() call.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Sanitize pointer prior fclose()
    https://git.kernel.org/bpf/bpf-next/c/e16e64f9e076

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



