Return-Path: <linux-kselftest+bounces-27123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631AEA3EA04
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 02:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29379420D6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845FE142E6F;
	Fri, 21 Feb 2025 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2X6BYSE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793F13C3C2;
	Fri, 21 Feb 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101404; cv=none; b=lmrZzYXercWT/Sgwf1iICYPxqYz0WbUj7uJ1k8NSIpN02qYZDIrNF2C/MAthiJ+3MYcroJQDI9tWjs/aUuhZ/vbYqpam9fMCJagA0QCnhHh4zasfM2eHQ4LH/ZApAZTD80yJMEtBP7P7kGrburCKx2wWwrUH3OgwDFgDH1qupPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101404; c=relaxed/simple;
	bh=sRaeZ9pubQLiIrdk5z/qnCwjDJA+i6IHXzNYQs2ByZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NDMYwYtvmQn5fGEQ0kPxeZGHfWvIKTOyjr03pXRJcgEu3NJ1JQI4fRyGiJ3rrrd8oeQDWCfwD8auNKNFte/NJ8fSWCDks1FzeHfbiFhMxLwQDEsmHY8dsHQeeg+Fb4NbHUs3b+1iYh7OKB8HUPeW+2ZSM4yfnJQm5XHxB1hoRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2X6BYSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B412BC4CED1;
	Fri, 21 Feb 2025 01:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740101403;
	bh=sRaeZ9pubQLiIrdk5z/qnCwjDJA+i6IHXzNYQs2ByZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2X6BYSEQw0VRwGSRBKvbv30Opf1rnJVsduh/d1FjrUmfIBTNiG6uD4svTEuEgkUG
	 VutZVc4n8QOjFEKEcIwKtbY418d8FklOVjXQ6RXaH0NdCWIyFceZs3oOchu/MlUrlv
	 XdMzyfTT1Yn2GjG6ky9LE18dKDO+n5CvWrjYOxPl6N4UngLXiuOjtfEX4q4wNX0VdD
	 SMcJD2y+DEQktlP61GrrXlgD6ZGh4FqZhhcQVY+sySsS/Ed2GLY/ZFs7+jN7zofKNC
	 0zriNnWqWqpv3ykarL1ZLSnDtJ1ZLaYwlquCUmeVyeCMW8raHBfriudXfbPiytQ4ma
	 R7eIKzBYf2dyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE49380CEE2;
	Fri, 21 Feb 2025 01:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/7] Some pktgen fixes/improvments (part I)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174010143451.1536213.11901300800314080047.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 01:30:34 +0000
References: <20250219084527.20488-1-ps.report@gmx.net>
In-Reply-To: <20250219084527.20488-1-ps.report@gmx.net>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 artem.chernyshev@red-soft.ru, frederic@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 09:45:20 +0100 you wrote:
> While taking a look at '[PATCH net] pktgen: Avoid out-of-range in
> get_imix_entries' ([1]) and '[PATCH net v2] pktgen: Avoid out-of-bounds
> access in get_imix_entries' ([2], [3]) and doing some tests and code review
> I detected that the /proc/net/pktgen/... parsing logic does not honour the
> user given buffer bounds (resulting in out-of-bounds access).
> 
> This can be observed e.g. by the following simple test (sometimes the
> old/'longer' previous value is re-read from the buffer):
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/7] net: pktgen: replace ENOTSUPP with EOPNOTSUPP
    https://git.kernel.org/netdev/net-next/c/802fb6db9fdc
  - [net-next,v6,2/7] net: pktgen: enable 'param=value' parsing
    https://git.kernel.org/netdev/net-next/c/80604d19b5fc
  - [net-next,v6,3/7] net: pktgen: fix hex32_arg parsing for short reads
    https://git.kernel.org/netdev/net-next/c/b38504346a24
  - [net-next,v6,4/7] net: pktgen: fix 'rate 0' error handling (return -EINVAL)
    https://git.kernel.org/netdev/net-next/c/3ba38c25a8c0
  - [net-next,v6,5/7] net: pktgen: fix 'ratep 0' error handling (return -EINVAL)
    https://git.kernel.org/netdev/net-next/c/1c3bc2c325f8
  - [net-next,v6,6/7] net: pktgen: fix ctrl interface command parsing
    https://git.kernel.org/netdev/net-next/c/1e5e511373fe
  - [net-next,v6,7/7] net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
    https://git.kernel.org/netdev/net-next/c/425e64440ad0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



