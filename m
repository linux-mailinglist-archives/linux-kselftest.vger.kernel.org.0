Return-Path: <linux-kselftest+bounces-2407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB8481D077
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B4A1F22EA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 23:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F85033CFA;
	Fri, 22 Dec 2023 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLaQR1cT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED033CF3;
	Fri, 22 Dec 2023 23:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 897C7C433C9;
	Fri, 22 Dec 2023 23:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703287824;
	bh=eaKEvVSQFOin/RXhdONJzZWiXqaT5GAiyvY3GOOgkFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YLaQR1cT2vLlax9tvbu7bpagCCT8hTeuHwE9oN391/vvjx+GdtqehN87+NSeVHOve
	 jmXwCnZtIsxqraxRAN7K4DyAuhATI17lw3l1SuS8X3/UpSy93+2k0gX1K8Je41EL7E
	 yaalckUn8/jSwYWGaj0LIVMhOtcSYRwO864L7uzSbfgjHmHucEz3SDZRXbXvDZMhvQ
	 i3SyrMUdoKmeEvR2WUveagHM+5EWmBHjaG+/AymwXpNe/aX9s9G8m7LaDrXtLAeQqW
	 4L0JPE2Y22U9/RKvPd5GEbyLqVtbWwdBjgumXAYxCLpO54b7gqjTqe1CNYEfAjIJgs
	 X/K+505NVdmSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F159DD4EE5;
	Fri, 22 Dec 2023 23:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftest/tcp-ao: Rectify out-of-tree build
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170328782445.9123.3749808837264846896.git-patchwork-notify@kernel.org>
Date: Fri, 22 Dec 2023 23:30:24 +0000
References: <20231219-b4-tcp-ao-selftests-out-of-tree-v1-1-0fff92d26eac@arista.com>
In-Reply-To: <20231219-b4-tcp-ao-selftests-out-of-tree-v1-1-0fff92d26eac@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 02:03:05 +0000 you wrote:
> Trivial fix for out-of-tree build that I wasn't testing previously:
> 
> 1. Create a directory for library object files, fixes:
> > gcc lib/kconfig.c -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing -I ../../../../../usr/include/ -iquote /tmp/kselftest/kselftest/net/tcp_ao/lib -I ../../../../include/  -o /tmp/kselftest/kselftest/net/tcp_ao/lib/kconfig.o -c
> > Assembler messages:
> > Fatal error: can't create /tmp/kselftest/kselftest/net/tcp_ao/lib/kconfig.o: No such file or directory
> > make[1]: *** [Makefile:46: /tmp/kselftest/kselftest/net/tcp_ao/lib/kconfig.o] Error 1
> 
> [...]

Here is the summary with links:
  - [net-next] selftest/tcp-ao: Rectify out-of-tree build
    https://git.kernel.org/netdev/net-next/c/826eb9bcc184

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



