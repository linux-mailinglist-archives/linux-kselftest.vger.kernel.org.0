Return-Path: <linux-kselftest+bounces-34740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1647FAD5A03
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C59189ACF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65A21A071C;
	Wed, 11 Jun 2025 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxjl5+hS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26731925AB;
	Wed, 11 Jun 2025 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654602; cv=none; b=HG7YJpHyh/HBU/oZA0VWS1f9inNMSjkf90Ht/Yo57uUnQi13uLl4LmJZ0M2O5hiNopDOR9r4GYivLp8Po3Z5b1+BR2z8IWXVvjDX5ZBoqLDyTLRIRXU2/XVoyIPLNav6x9YwynZzwy4/70hx5woxtuKUhdjzBII3phBGQ50QTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654602; c=relaxed/simple;
	bh=guKx/eVi2Puq98lD0YDWfUIP3bFaTVE4m7+rdn1ALhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r2MLn4Ey+RffrvldeHQ0w8FvJfbbPs1kidNA2E/HxF9J/tzemZ+jgBUD5AIkJYkq454qMTUvFVf6e2YxIYwo13dPVaxObpFkMFR8xxcXC3UTxVpaWqSUNnk3ndDUqsPZHrXZulYRSG5lV6SjaiGmzgi5HolV6TM+G7P7IGHmAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxjl5+hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169E1C4CEE3;
	Wed, 11 Jun 2025 15:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749654602;
	bh=guKx/eVi2Puq98lD0YDWfUIP3bFaTVE4m7+rdn1ALhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uxjl5+hSuA3qGWEACdYUufGb7KdAXvbKM4SVrAiQ7qGPTR/UXWJz2doaRJQMG0sTI
	 IRlqYL+rY5rllS3WPdMUf8mRcVRO1OJPGX+X6NchKjdSTWK26M7KZRMmyIxQjTuE6b
	 uUoge4ZhwmQ7PWg2lWvhKpun36dSiVrXViaNN12HvCvvucoY5k3tvnAslP1RTVtiTz
	 9koeb9YtkYKY9vwRr82AoEd8FbIL6rZ9fpzuBR/OKhc64marCPno/838iehN/GdMwI
	 Q6kFBjm5Z/EEH36RE/Pg3tH3QbGA9rQXR/yccJ2spxqdq2omSIdjKhxwY5qOx+KxEt
	 CCF4V/eHJgLKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CC739EFFC5;
	Wed, 11 Jun 2025 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf,ktls: Fix data corruption caused by
 using
 bpf_msg_pop_data() in ktls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174965463225.3362912.890575326348538837.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 15:10:32 +0000
References: <20250609020910.397930-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250609020910.397930-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 isolodrai@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (net)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  9 Jun 2025 10:08:51 +0800 you wrote:
> Cong reported an issue where running 'test_sockmap' in the current
> bpf-next tree results in an error [1].
> 
> The specific test case that triggered the error is a combined test
> involving ktls and bpf_msg_pop_data().
> 
> Root Cause:
> When sending plaintext data, we initially calculated the corresponding
> ciphertext length. However, if we later reduced the plaintext data length
> via socket policy, we failed to recalculate the ciphertext length.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf,ktls: Fix data corruption when using bpf_msg_pop_data() in ktls
    https://git.kernel.org/bpf/bpf-next/c/178f6a5c8cb3
  - [bpf-next,v2,2/2] selftests/bpf: Add test to cover ktls with bpf_msg_pop_data
    https://git.kernel.org/bpf/bpf-next/c/f1c025773f25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



