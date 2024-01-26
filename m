Return-Path: <linux-kselftest+bounces-3609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F2483D197
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 01:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA80B20D69
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 00:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8835B387;
	Fri, 26 Jan 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orHgsV9e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CD362;
	Fri, 26 Jan 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706229627; cv=none; b=jn4PkC5mM96FPStVIN5LVHX7+s9+XD1hswrV1sz2Tn2nFbs+oOiRBQHDcM9aIamAdmbOn9QGe+0N1zlWeDZ2nhTGWkbwrJZLmMLQBp+PE+5Xqbu6JSPL9nQddx23TbfJdDWz2wO+loikP7O4ySTOSSRm0Sa/gDZkQSRG35tkt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706229627; c=relaxed/simple;
	bh=optjiLqvTjGGObgLXQKYUtubHmak1FHv8h+dtKZk5Ck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Us9KYYXzGC3dVHu0lyR8n4BnTLdO03tQpMpoGjdE+wBz+zWT8/DL93SNXiaLl+FNflXeO5n6SXfUsgq23HZ1dp03sD4CLWOPswC0/3Es6r75rccx9UHzET/tCF7cSS3B4DRrT3P3R+XfmrCu0SkuUthm5gMJoxV/EeY9wXYMww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orHgsV9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9FE9C433F1;
	Fri, 26 Jan 2024 00:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706229626;
	bh=optjiLqvTjGGObgLXQKYUtubHmak1FHv8h+dtKZk5Ck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=orHgsV9e7ypNKJ8gkZoniK6FFyjqEEixEGHTn8cdvHwrezbO2dmeFacd3qyqNs3GP
	 w+zurEBpC7Tn0ELQFb192WLVF49qr2QAFRoOX8a0moUsqQ9Gs/m6up5inIPxXMYN80
	 /c+s/ADua8xnPWxVF6RW3pcqXZ3+6bDpGMFI7k5Y8IyWQe2cqSoBeg4x7VwfE/f3Yg
	 x4GtqcMzge4iWLikpdFH2g633e1hBUZhPVdCXE8ZCiNb2h/X2VyKDVT+og51q9eUPw
	 d38LFrN7b/Fqrf/BPiG01/B2ZtloCb5gfmpBU9sSNgDDMeva3gYPrvVwRXtUOGqMDc
	 6toUZNuxLjW7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E091D8C962;
	Fri, 26 Jan 2024 00:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] selftests: tc-testing: misc changes for tdc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170622962664.15293.8396048599580127697.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 00:40:26 +0000
References: <20240124181933.75724-1-pctammela@mojatatu.com>
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, kuba@kernel.org, vladimir.oltean@nxp.com,
 dcaratti@redhat.com, edumazet@google.com, pabeni@redhat.com,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 15:19:28 -0300 you wrote:
> Patches 1 and 3 are fixes for tdc that were discovered when running it
> using defconfig + tc-testing config and against the latest iproute2.
> 
> Patch 2 improves the taprio tests.
> 
> Patch 4 enables all tdc tests.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] selftests: tc-testing: add missing netfilter config
    https://git.kernel.org/netdev/net-next/c/14a12e6c0b7f
  - [net-next,v2,2/5] selftests: tc-testing: check if 'jq' is available in taprio tests
    https://git.kernel.org/netdev/net-next/c/4f4d38412140
  - [net-next,v2,3/5] selftests: tc-testing: adjust fq test to latest iproute2
    https://git.kernel.org/netdev/net-next/c/3007d8712c9b
  - [net-next,v2,4/5] selftests: tc-testing: enable all tdc tests
    https://git.kernel.org/netdev/net-next/c/d17d0e333707
  - [net-next,v2,5/5] selftests: tc-testing: return fail if a test fails in setup/teardown
    https://git.kernel.org/netdev/net-next/c/8981a85e1ba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



