Return-Path: <linux-kselftest+bounces-31941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E612FAA1CC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773EB1B670EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 21:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1375F253344;
	Tue, 29 Apr 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FO786ePk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDB13AC1;
	Tue, 29 Apr 2025 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745961590; cv=none; b=qzubrQqMwRRNgjHOpD/+gISb5h5UIao6nfOUY0URyF4ny1dxfQ2e2Gigsps7GC6W6YzSzAsL38WEL5EYneYgbYRSm0xlRSxvNRmXLgKPmAO7VE/NkIWPSsPWFdIsp/u1dh/MdfxefweQoKGLOGkOcrt54GW1GYQKWUNJ8sEKvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745961590; c=relaxed/simple;
	bh=HzYtP5KUYS9gSWTsmkbwZQNkpSo91hivuUnjt4CIwlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s7tzI+jkiRPGYiVYNM4sdNZde6tFWCREVbi8kVyDTZgGTysfqYqowtVxYU4+wkx0EQ9lRAGpLoEoygDPGxtkn6VUarGzqy2XIesueY8FHKygncoUIQhVMx6XVXInq6VfVvOm9HYMnB+6kQ1Cdj6BwWPLPLy7NI5i87rewNnOjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FO786ePk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E4CC4CEE3;
	Tue, 29 Apr 2025 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745961589;
	bh=HzYtP5KUYS9gSWTsmkbwZQNkpSo91hivuUnjt4CIwlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FO786ePkoFUQPhXR4UyCYwEuxkAqnvj9InM1z7kYlYqYouqdaKLdjIhkPkVKe+Onp
	 pYFtf6r4MpEOKhfPAvHqw4wNKXZQcmvtwX7ZRxtdOdyWzQHJIc95OObexboRWAsUVx
	 6DSlVvjldq3qUV7S3ws4ZsZvQKYWk+mKY+ZHDcrEgc3vF8VIlzAisSprtgcYk5XdEx
	 tK3WoLoLEF/QmmRD2FM3dyCAcj7p8geLwDbrpVUvN1eqW4hxwa/JAsCih0CZxG0D89
	 mxzPark+LWsYxORnW1OQSGp1zSBOoC1Iubt9KEHYao6rDMQ050/F16AFAn3d8tQpef
	 jxdjoSRYeNjaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FA23822D4E;
	Tue, 29 Apr 2025 21:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compilation errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174596162825.1800330.14207050460197358125.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 21:20:28 +0000
References: <20250428033445.58113-1-yangfeng59949@163.com>
In-Reply-To: <20250428033445.58113-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, toke@redhat.com, amery.hung@bytedance.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Mon, 28 Apr 2025 11:34:45 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> If the CONFIG_NET_SCH_BPF configuration is not enabled,
> the BPF test compilation will report the following error:
> In file included from progs/bpf_qdisc_fq.c:39:
> progs/bpf_qdisc_common.h:17:51: error: declaration of 'struct bpf_sk_buff_ptr' will not be visible outside of this function [-Werror,-Wvisibility]
>    17 | void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
>       |                                                   ^
> progs/bpf_qdisc_fq.c:309:14: error: declaration of 'struct bpf_sk_buff_ptr' will not be visible outside of this function [-Werror,-Wvisibility]
>   309 |              struct bpf_sk_buff_ptr *to_free)
>       |                     ^
> progs/bpf_qdisc_fq.c:309:14: error: declaration of 'struct bpf_sk_buff_ptr' will not be visible outside of this function [-Werror,-Wvisibility]
> progs/bpf_qdisc_fq.c:308:5: error: conflicting types for '____bpf_fq_enqueue'
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix compilation errors
    https://git.kernel.org/bpf/bpf-next/c/1ce65102d2d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



