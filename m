Return-Path: <linux-kselftest+bounces-46294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCCEC7C10D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 02:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF3AD3640A4
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC5927E040;
	Sat, 22 Nov 2025 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1XsDrp1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946BD27B34E;
	Sat, 22 Nov 2025 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763773242; cv=none; b=TXIckQSJTNEm2Bj3Q94IBz3FI0QyCGi32U/0n+sakImDrEHXfda6BmRJzXIFGFhJuHptfKd54UUK0vIckpkjdr4i87Q77k6W9zHBlNRi7kO40zNlEhxexm3peieDzoij32nifcB4tTilGGt6CTCgAmkXXbDuytGReFfDAXbWkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763773242; c=relaxed/simple;
	bh=V7MAocUPNKgFRLMbwe9m2LJhXc6lrDXfWaTWzN9srVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SB5FAxpnJBcmXQTZR5b24MUIDUU97142a7bMrP1YYC76nNm/ti72mFxvlARSzeAp+6HeaV6g0s/tl9t8MIZ+MvQ2yu8ENodC1Qqly5k6XJADqjaRxgOkKNAcbPdcw8qShS2+S9eK85mkTcnSSrbMbtI79mGGQUDf1qIMlduqaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1XsDrp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE9C4CEF1;
	Sat, 22 Nov 2025 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763773242;
	bh=V7MAocUPNKgFRLMbwe9m2LJhXc6lrDXfWaTWzN9srVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u1XsDrp1PR2HCiRyI59UHkHAgFZmRM6z651ctHa+S0XztLCrGPcONQKa3AMce20jL
	 4kHiGf7KmrI2dYAz+QtvwdcR4qJqgH8+IeRbwa3uhmt7rVnkEV7mGV7j5GkCorkRQO
	 X96Hv8nOq4YAoGMUYHT+TXREH8hsRSKPlrxPZVGuXDdLDOvSPbtjEiqLjRD5NjfaPK
	 Yi613d3+9vqhgm/gEIvCP/eFF0mi6pb/KOTu0Lchgr4YaqR1JR52pdAh9odhZmq2BD
	 TjuhW2DUn9egYi1z+1iL9tpKleTotPY89NHUKnvz4TYcV2QY/MrFqkEBSopwqX4KHh
	 F1LRJfftfapew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0B13A78B32;
	Sat, 22 Nov 2025 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests: test_tag: prog_tag is calculated using
 SHA256.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176377320677.2640508.1395304302978193609.git-patchwork-notify@kernel.org>
Date: Sat, 22 Nov 2025 01:00:06 +0000
References: <20251121061458.3145167-1-higuoxing@gmail.com>
In-Reply-To: <20251121061458.3145167-1-higuoxing@gmail.com>
To: Xing Guo <higuoxing@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org,
 kpsingh@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Nov 2025 14:14:58 +0800 you wrote:
> commit 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use SHA256")
> changed digest of prog_tag to SHA256 but forgot to update tests
> correspondingly.  This patch helps fix it.
> 
> Fixes: 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use SHA256")
> Signed-off-by: Xing Guo <higuoxing@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests: test_tag: prog_tag is calculated using SHA256.
    https://git.kernel.org/bpf/bpf-next/c/b7f7d76d6e35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



