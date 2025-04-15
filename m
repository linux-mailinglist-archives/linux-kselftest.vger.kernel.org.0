Return-Path: <linux-kselftest+bounces-30890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C420FA8A676
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 20:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CA2168882
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253C23026C;
	Tue, 15 Apr 2025 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMpN/2ek"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE722B5A5;
	Tue, 15 Apr 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740596; cv=none; b=VwN3psm0NMEqJT6fqHhTKl2DQeceNEs1o8oR36W0johoAxafGgyad/fJQJN4mgV/fsfz0eIcMShQ2PRtrO4VkljMAMVFGF20+xbD6q9LnrTZ7A2H8kIR1qleyGN8B+kntOo+VtXRzPemyReBu3CaCHhI4tSmG1ZTfRMbB5kfSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740596; c=relaxed/simple;
	bh=xQI2GKkQoI1TZdmJHVrd8rELK0VEmYKP62keOuNrboA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jHJ4ylMR9Bx+Vm5tg0YbL6xdSe2JXNX5ZBlBF4dk9Zk0g0xWC7HORyYmcwiOGlEIj+UUOue9SPhXEeq+mm5qervTaFDvGKnv6HNMnjF+CVMaeuoMzXos0+7aa9oUzqx5IeBXBl8gsfqx/u1g8ZU6ro0YaLAqBh7cfvBcjM3VbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMpN/2ek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5475DC4CEEC;
	Tue, 15 Apr 2025 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744740595;
	bh=xQI2GKkQoI1TZdmJHVrd8rELK0VEmYKP62keOuNrboA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tMpN/2ekG1hx0UQ/ca4rxxiLY1vvV5V8BVb3qna4ar4C3NAmjtoDzQYY53rlKZzJT
	 PQQVFUhN/HJMlZsIQiKy5YhcnNPwSME0K1wPo9s8rjaHN7auIVDzJmOtlq4L0XG/oI
	 kONJMibGRiTI6eV+2T7uFJyMIrjltiW8EpK975nMRB2sEIcwmrsBiGe98fzbH8rrJf
	 Xto5cW0tm/5vShx/DoYu/Xp6hVYJOYiSM0uqDa5Dc1i1JfWGdWSD6yAb8WKPuFBwW+
	 4jAf2667QBhRSax/Y16gfFUuy8/RxezF/AtDJKE2qkhEpwCgd+SlxJWqNeeLoe6NN0
	 gf9BP+4nJN8MA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7108B3822D55;
	Tue, 15 Apr 2025 18:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] selftest/bpf/benchs: Remove duplicate sys/types.h
 header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174474063327.2730246.12931886216738044879.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 18:10:33 +0000
References: <20250415061459.11644-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20250415061459.11644-1-jiapeng.chong@linux.alibaba.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, abaci@linux.alibaba.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue, 15 Apr 2025 14:14:59 +0800 you wrote:
> ./tools/testing/selftests/bpf/benchs/bench_sockmap.c: sys/types.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=20436
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/testing/selftests/bpf/benchs/bench_sockmap.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [-next] selftest/bpf/benchs: Remove duplicate sys/types.h header
    https://git.kernel.org/bpf/bpf-next/c/7d0b43b68d1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



