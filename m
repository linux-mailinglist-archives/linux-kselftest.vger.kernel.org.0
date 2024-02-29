Return-Path: <linux-kselftest+bounces-5673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F312386D67A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 23:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303B01C212FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 22:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240976D539;
	Thu, 29 Feb 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnLss1W+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA66D528;
	Thu, 29 Feb 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244035; cv=none; b=ZLM/WinsGVOxdHw/lumS5LvNhvwvTaQZV1p8BFz/Aw2vivCpR/xnomOgUZA9IaJMx/DspZwJkjIaOClir+iRtbhJdEnKaiJo706M0fEn/0crggX6heo3J7YmgR1MtPofRWo+SHXs3XLfV3SKYDK1gN1Msal1cREBY4G+IasBaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244035; c=relaxed/simple;
	bh=DKB2o2S+feMPyuNFbB3ii6e3+RACDzpX5U78cW6QHLg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oKz4unf03JftsvKwqoofLKDuD34trVi5SowwxDHcpPOZfI5tbLoWEIGdzMVmdPvmmTgCzFjdzpZ0q0TxhJe2hE+ifLPgq7N/yObYDpPCmpSEbn1SitOjycwoouM+GapTWC3b7FLiqFOOP46d9EHLcxMm+MBiK05pGyfu6SjcznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnLss1W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E039C43399;
	Thu, 29 Feb 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709244034;
	bh=DKB2o2S+feMPyuNFbB3ii6e3+RACDzpX5U78cW6QHLg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bnLss1W+2l/1sqZokR2ESJQoKdRvn/Bsqg1lCQJuJJ7OjMjITbQtqMUE33okDC5Um
	 DhlusOnGWg+gyKrv+ptLGC7uBUpaWggzJrY5a1RC+vujCYwb9l+4/33MuyRXE5o22Z
	 klYcqmYTroM2wlRmGqE8YmbFd8XCFB6JhZCCAMPS3NYP46TTm8vyqJpGbIKuhdIKlB
	 tFQb+7QzYz0Eea/ACrmXGkRi5Csr5/BTmt0k2dTVWZK3eBkIqjXZ6fVgbXRoxUhOML
	 NsjrQ1J8OYj+hWnQ3AO3m9Xyqt765an9OSZ3j+f4jFuqBvf2G6YZzokyY2lxYa6yW7
	 ZiDguuIfHIVaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EBE5C595D1;
	Thu, 29 Feb 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] bpf: Replace bpf_lpm_trie_key 0-length array with flexible
 array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170924403425.8275.6534761971040087521.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 22:00:34 +0000
References: <20240222155612.it.533-kees@kernel.org>
In-Reply-To: <20240222155612.it.533-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: daniel@iogearbox.net, mark.rutland@arm.com, gustavoars@kernel.org,
 ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 baihaowen@meizu.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yonghong.song@linux.dev, corbet@lwn.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, joannelkoong@gmail.com,
 laoar.shao@gmail.com, kuifeng@meta.com, aspsk@isovalent.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 22 Feb 2024 07:56:15 -0800 you wrote:
> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> flexible array. Found with GCC 13:
> 
> ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
>   207 |                                        *(__be16 *)&key->data[i]);
>       |                                                   ^~~~~~~~~~~~~
> ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
>   102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
>       |                                                      ^
> ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
>    97 | #define be16_to_cpu __be16_to_cpu
>       |                     ^~~~~~~~~~~~~
> ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
>   206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
> ^
>       |                            ^~~~~~~~~~~
> In file included from ../include/linux/bpf.h:7:
> ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
>    82 |         __u8    data[0];        /* Arbitrary size */
>       |                 ^~~~
> 
> [...]

Here is the summary with links:
  - [v6] bpf: Replace bpf_lpm_trie_key 0-length array with flexible array
    https://git.kernel.org/bpf/bpf-next/c/896880ff3086

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



