Return-Path: <linux-kselftest+bounces-23228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA7E9ED9F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 23:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD471282CEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 22:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000D81FFC40;
	Wed, 11 Dec 2024 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbl6916+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCC11FD78F;
	Wed, 11 Dec 2024 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956354; cv=none; b=BBrZC006YN7visKct9qxnG1kUiHldWZVu1BNotTv2aaLgrY9nL0497SpovmT8eUumlVcT/vLi+s8aiRbVnVgKio1FaNv429xeeoCQxOgi1R19gcBganKJW/a3KQce32+ThEbZ28eSal5Jy7UQy5/EOJxu0C7xdvGtXi/cDtD8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956354; c=relaxed/simple;
	bh=D8PIEfAkk3ZURZLdoJfZkuoLoCE4AVt+//7WJV4stTI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gvPce0YYNs0qpq9CW9BXDZHduZ/bjWm/qHzcbYzcGYLCUU+USEwyhBSvNseePjOT00CSq8gAWh++/TmFYfgqaxTZVC1K70w3rRRjGKNvQDtDqH4oWDraAYzBcWC0IpWyIh9KjgK7WVrl4D3inLOcEUS7Vsw6srGGkpaI7oMQvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbl6916+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A286AC4CED2;
	Wed, 11 Dec 2024 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956354;
	bh=D8PIEfAkk3ZURZLdoJfZkuoLoCE4AVt+//7WJV4stTI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbl6916+Zv/ZGhbfFNrBYPN6Ig1vrxarxb4LSjDhlwExb8L+Lq+2UD0ffQnWh8h4s
	 DpGOCoiuYKnJZKMTuVzYVhGZ3YuLTXuy1iyp0HuZ01hLDTy4JIu7cluWfhK6Nm/r4h
	 rGFsQTAiWVDX9RC3/nPrTtyfyIbi85DluHt/9Q0deDuv3wm+UjAHEdeeNZFxymeUGG
	 7I/sBszMtqijm61PqNLaE2a4jJqyuHE5OFBdZsgvv7ZCa5jyJetZoeRwV5xhNIFnoL
	 XWY2ngLDLWEvW4Q3p17ceBYsNra+U88Y+eFZlgRB2brmwJDufsCHPMl/NuKf3I2K7H
	 8DAYif77nC/nA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD92380A965;
	Wed, 11 Dec 2024 22:32:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] selftest/mm: Fix typo in virtual_address_range
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395637050.1729195.966660069889668701.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:50 +0000
References: <20240913022635.751505-1-zhangchunyan@iscas.ac.cn>
In-Reply-To: <20240913022635.751505-1-zhangchunyan@iscas.ac.cn>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 shuah@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 alex@ghiti.fr, charlie@rivosinc.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhang.lyra@gmail.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri, 13 Sep 2024 10:26:34 +0800 you wrote:
> The function name should be *hint* address, so correct it.
> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>  tools/testing/selftests/mm/virtual_address_range.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [1/2] selftest/mm: Fix typo in virtual_address_range
    https://git.kernel.org/riscv/c/e847f8cd96ae
  - [2/2] selftests/mm: skip virtual_address_range tests on riscv
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



