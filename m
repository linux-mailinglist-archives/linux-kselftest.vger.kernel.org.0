Return-Path: <linux-kselftest+bounces-38746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5CBB21B94
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D61E625DB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 03:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE602D876B;
	Tue, 12 Aug 2025 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLNQTXfr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827D2D3A90;
	Tue, 12 Aug 2025 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968812; cv=none; b=lmHvqZGgNsg2w8RgcAaoXLKipPqbqUX/NdFM4uCex/nUPKGLIgkN7o7lx7K6o4hmll0Ornfmq3sQRhxUAh5cdML1VZTKXGp7C1JD4bARc8fOqZgz7q2x+5sxNip+Vb4rGURzBwAE7zNYgC1SozSDJZISC3DeVnS6v8XXtApd4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968812; c=relaxed/simple;
	bh=ft2kh9u7vPa7ThZ7vPFh6taFl4YVQaFNsS+dwruoRpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GtIMLgRn1L+nW63ggIxHqRKLcBt2gngwo5e81nqQ0vsX6y3ZxaeyB4IUlDY/Y32e1O8jzQbEmjjK+HuwM5B+HwzxCvoRLMm1n2g27t90Tx4TKtemZ5r1iywEpWRlgMPHfsXUKmgshP40aAh1rYy+KlEQnrbFxUJ112lJ7f32V9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLNQTXfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407F1C4CEED;
	Tue, 12 Aug 2025 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754968812;
	bh=ft2kh9u7vPa7ThZ7vPFh6taFl4YVQaFNsS+dwruoRpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lLNQTXfrmZrjB/j5geLgreaYiMvQV7cX4HXfzyOSbo15MQSpJybPZzL9ooioUf+PT
	 11orgBY9nAFTr+tiH622CuuZPwBRzIrQdjDquqFZWlpRwibTmvRyQjyuvdaFHtpdEl
	 b1rEcx/lt3FT401hguDMVKoCpiM4CQ3Rh8+bQgrl74n0Ih8NCtCBZcEfnyNVH44pVm
	 2RyoehkiEWHwvgWuNYXWkyVtenK2k0FAGp4bim9E6XxZ1YRGcFTNf+jtJee8xWc3cr
	 REOg7sooAS+jjlcgYlAvSq6oHIZxYI6Gbd8hdNDyS7rQE6pYpD8TtRVJURY0zjzWON
	 D5OTRHD082oWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD76383BF51;
	Tue, 12 Aug 2025 03:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/net: Replace non-standard __WORDSIZE with
 sizeof(long) * 8
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175496882424.1990527.5318713796643859654.git-patchwork-notify@kernel.org>
Date: Tue, 12 Aug 2025 03:20:24 +0000
References: <20250807080932.1678178-1-wakel@google.com>
In-Reply-To: <20250807080932.1678178-1-wakel@google.com>
To: Wake Liu <wakel@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, nathan@kernel.org, horms@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Aug 2025 16:09:32 +0800 you wrote:
> The `__WORDSIZE` macro, defined in the non-standard `<bits/wordsize.h>`
> header, is a GNU extension and not universally available with all
> toolchains, such as Clang when used with musl libc.
> 
> This can lead to build failures in environments where this header is
> missing.
> 
> [...]

Here is the summary with links:
  - selftests/net: Replace non-standard __WORDSIZE with sizeof(long) * 8
    https://git.kernel.org/netdev/net-next/c/c36748e8733e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



