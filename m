Return-Path: <linux-kselftest+bounces-9667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371798BF3AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 02:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E640928259E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F17FD;
	Wed,  8 May 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM9mUW+u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F9622;
	Wed,  8 May 2024 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128232; cv=none; b=kBNRd/OScJ/L8r9wZZluE6Hyaok7Z1rir5Ww7YA5sD59YNYMVJmvaxk/pKzHzAjnnbtWla6rBvrKt+ZgFKo85MMqO7T2StyZHcl5Zg+feEt/UuVA1iwSK84QZEchSMu/W/BDN310srzpcMqiAwRfBuOAMlGGQrPBzlgqn52yrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128232; c=relaxed/simple;
	bh=q6V7n72TWE+LkN6Z1iKMOe3Tu61qwITDsaurNXpNThY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ly+qbBqnIcyYitWriKMHJsAF2FGkVqlac1LTeQC+HCzOAs42oTb0Ddst5dKl0sZVD7+oy7zOcKHIEi9ciXXI8CZFg28LZR30Lp158zTQY24JIa3ipV6TfwJJDLxIbfwDMUeW/EHf56Hs70KS4C/GoSYB9ZZaHJDszCaHsJCYxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM9mUW+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AC5EC4DDE8;
	Wed,  8 May 2024 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715128232;
	bh=q6V7n72TWE+LkN6Z1iKMOe3Tu61qwITDsaurNXpNThY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rM9mUW+uCyW/C+l7YZqn2HJubeCXW8XJmWc36duoSk4aNSt4fb+TgZo+IFraMBQyV
	 5CLIy5/rXtuwfysu/bH/gx6VUJDSQQgUCvsdLVT7OJG/PEh2Yx7ON75232pD0dvkCL
	 4F/SCRISml0gDFmwiYxcIuyoWK8EBPxxu/9S0syUbg/lXhfdDWoEewDm/yabYjZT9B
	 Ly9Lc7rnecRfMOrk8HaHDiXU8wL3qjin2WsqBeZ9vcclI9gosbYKA0uEBWgMIskUOE
	 mKUnBumVr+Fb/o2f1PIKLaS0LZMrVOl1kmIWeZvgH25pEI4RDf6ooUBA1w9dqZt6cV
	 ewnrn40mzMLRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D90AC43614;
	Wed,  8 May 2024 00:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/net: fix uninitialized variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512823237.17947.6042274954836297174.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 00:30:32 +0000
References: <20240506190204.28497-1-jhubbard@nvidia.com>
In-Reply-To: <20240506190204.28497-1-jhubbard@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: shuah@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, afaerber@suse.de,
 manivannan.sadhasivam@linaro.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org, pshelar@ovn.org, willemdebruijn.kernel@gmail.com,
 alexander@mihalicyn.com, zhujun2@cmss.chinamobile.com, petrm@nvidia.com,
 idosch@nvidia.com, liuhangbin@gmail.com, razor@blackwall.org,
 bpoirier@nvidia.com, bigeasy@linutronix.de, 0x7f454c46@gmail.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
 dev@openvswitch.org, kernel@valentinobst.de, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 May 2024 12:02:04 -0700 you wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns about three variables that are not initialized in all
> cases:
> 
> [...]

Here is the summary with links:
  - [v2] selftests/net: fix uninitialized variables
    https://git.kernel.org/netdev/net-next/c/eb709b5f6536

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



