Return-Path: <linux-kselftest+bounces-40714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3834B42DA4
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 01:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1D25404B7
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 23:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2F0304962;
	Wed,  3 Sep 2025 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZWY/vy9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFA2FF16C;
	Wed,  3 Sep 2025 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943405; cv=none; b=rop+VVvI/hN5ls9fSNPzKNgvB58wY6IpadOvYrtg2x0kDXTMx6wuUhuMUwaavlc/VmB0NwFRmQsiG8q7WAnV0TMrgD/WO8eKg2CGmb+RsFoQW5ouniHul2+5ovSi8crM73FQ14FOVQhU3TmvU+QZTG366WTjyIBtgukYy5deK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943405; c=relaxed/simple;
	bh=Lys8SA5l227NsOMdSHvAK/Wz4oFY7/1ccIH4c5rvCKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jE6IqUQZrUkcSlsGdz+QuZ2wB5oBXntroyCDgdoqy3Ub+orljNxVctqlu2L549PIR9Np3sze9D29WRvo1PZJuoMinpZIS+8caC07v6cmzut7dU7NlXNc34HH6HF9vn/TVOpywW+Dj3d89oN4YHOSzRpTh8i8sB49e8ZoYzHTYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZWY/vy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E18C4CEF5;
	Wed,  3 Sep 2025 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756943404;
	bh=Lys8SA5l227NsOMdSHvAK/Wz4oFY7/1ccIH4c5rvCKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XZWY/vy9x0vPcfQSsgT94r/ZTQrquZUZ78b1Nbt2SHm/ZvLMxV7FGL435kipfwk7H
	 gEyWklXrV1YMESzw+UOKsGYWHeg6AkRKD7GIhotxAmbN60QidJ4d1LhfEzemvGL9LA
	 GAjjNmZBJ3zXvZNZEI7l5VrpLZpUdPMeNa9Rkz2SgoFS02PuU7x+4NzDMHjlSIi3/0
	 ls17gfTs1DCCU0xJDAf0URCEIkgXZVuRnWb4Qrs4U86RbDlU5UePf3o2O0OOxVeBFP
	 ov/X/peBded0HN2bvu8vGWrAS2uvnJcG/0m4GDpEQGI5Odo/fiQ9i3Qn3g1+dKzQlY
	 gDPTtDzYAG7vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100A383C259;
	Wed,  3 Sep 2025 23:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Upon failures, exit with code 1 in
 test_xsk.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694340901.1240011.10466250497289986211.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 23:50:09 +0000
References: <20250828-selftests-bpf-test_xsk_ret-v1-1-e6656c01f397@suse.com>
In-Reply-To: <20250828-selftests-bpf-test_xsk_ret-v1-1-e6656c01f397@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4=?=@codeaurora.org
Cc: bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 28 Aug 2025 15:48:30 -0300 you wrote:
> Currently, even if some subtests fails, the end result will still yield
> "ok 1 selftests: bpf: test_xsk.sh". Fix it by exiting with 1 if there are
> any failures.
> 
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Upon failures, exit with code 1 in test_xsk.sh
    https://git.kernel.org/bpf/bpf-next/c/2a912258c90e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



