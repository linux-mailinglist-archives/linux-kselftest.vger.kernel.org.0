Return-Path: <linux-kselftest+bounces-30-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB1A7E8DB6
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 01:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6247280D5B
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 00:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CB915B6;
	Sun, 12 Nov 2023 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIrkMdFY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EE1380;
	Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42B3DC433C7;
	Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699750546;
	bh=g6sSrrVwZDGVPiE2PDTxknYsHB0fe/FH8seuAIgjE4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jIrkMdFYXfoc6646t+fgdmy4sIr1F1ywDUgFixpiXVK2S8hG40s3w/ls/pmJisSN8
	 TDIGXkLEgC3a/4p90siHf+cDU78je3Td25ZoX2ykDajR5fyvmfG6nqTybR75s0F48X
	 dhCva+EM+Bb/7XjWSY23pHKwDlaXUgBmmr7RUB+ArjnyC0qTvqnvuv3vHCsNL2LctV
	 0tXOdFgW8S0nqhX62C+KuwoToju/qNBjgv4ixifAFJngU54rqK79Ui6Hb4tkBa1nhX
	 eW82M2tmZ+GzdWlCgBnP0vPjBB3jXsurXY6nG0HHjB/zS3YwI2Qi/5HDUR9t2KdWG2
	 HzjUf7qn1KASQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A27BE00084;
	Sun, 12 Nov 2023 00:55:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH 0/2] add loongarch and riscv support for kprobe args
 test
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <169975054616.11360.3939944763451576227.git-patchwork-notify@kernel.org>
Date: Sun, 12 Nov 2023 00:55:46 +0000
References: <20231018020858.1304218-1-liaoyu15@huawei.com>
In-Reply-To: <20231018020858.1304218-1-liaoyu15@huawei.com>
To: Yu Liao <liaoyu15@huawei.com>
Cc: linux-riscv@lists.infradead.org, skhan@linuxfoundation.org,
 liwei391@huawei.com, rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, mhiramat@kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Shuah Khan <skhan@linuxfoundation.org>:

On Wed, 18 Oct 2023 10:08:56 +0800 you wrote:
> Yu Liao (2):
>   selftests/ftrace: add loongarch support for kprobe args char tests
>   selftests/ftrace: Add riscv support for kprobe arg tests
> 
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc      | 6 ++++++
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc    | 3 +++
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc    | 4 ++++
>  3 files changed, 13 insertions(+)

Here is the summary with links:
  - [RESEND,1/2] selftests/ftrace: add loongarch support for kprobe args char tests
    https://git.kernel.org/riscv/c/2eadb3299256
  - [RESEND,2/2] selftests/ftrace: Add riscv support for kprobe arg tests
    https://git.kernel.org/riscv/c/11df28854bee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



