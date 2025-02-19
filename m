Return-Path: <linux-kselftest+bounces-26925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70C6A3AF71
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 03:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9335F3B2686
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15718D63E;
	Wed, 19 Feb 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUClFexB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3F18C011;
	Wed, 19 Feb 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931612; cv=none; b=XRWs84gY0DGbEFA+10CMqtDrOM6/2ov5KAMkGXaDiWtDY2YD2zhweifo7lqlUQUpeMvZdZVlDRbrtn2fhP5Ngdfg54S2enW5nlpdw/wfSpI6rPB1jfQ7zvu+gvPDJ1pReWw/+Y0FoG56s0uf0smmq9R05agyV1bp9GG29xMAHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931612; c=relaxed/simple;
	bh=XBQHYQrJoRPL+Fp0/YA4AGa2fMscsSePleT2f8Sonkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mvkbQaTCg0JozbK5fWRRIpPDJWXyIuyIs9HhsiKwfcb4/gwLDG8XXyl+t9kg2o2slEqjFbCY/E3XnOB5neeCRJrmGxPTLfquiDs1K78d+B7aC3cMcUKyyLBF2u6qoZENtYeFCGViAgqVEDyTPmlbVBlBZoxuvwi7ji0vR6UD3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUClFexB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E0DC4CEE2;
	Wed, 19 Feb 2025 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931612;
	bh=XBQHYQrJoRPL+Fp0/YA4AGa2fMscsSePleT2f8Sonkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PUClFexBVHNx5rCHEgXdzFIWb0MWfZzVlqDoh3h5hnSF+0pQWXFiKZP7Ywj/1PYWb
	 F/D7MRYjyRenEdLxBTPA4hyuMiqSGRjOVit3s/7COUYudPYOEskaajQLWAgBcSgqCt
	 Ohy3EW47BpsC2F2Gw+BGMF5kHyMVO2rLCCA/pmlG1hfS+cXjwrt8yWN3fLYpEwyFzy
	 bl3XUbwjW36vcfWpwQHJbh0NNg9wsWrSw4QFKVSziDEcirqu7e8iIg6qxdfim8LoFp
	 GuHW3TQfJSFDUJ0uAjd6TtsPJDUKPmZM7dmLkPB6gcKrbzEcN4aGv96u5FdABTN3uz
	 LHfsHF90olrEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0CD380AAE9;
	Wed, 19 Feb 2025 02:20:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: net : Fix few spelling mistakes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993164236.106119.786009468500083710.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:20:42 +0000
References: <20250217141520.81033-1-chandru.dav@gmail.com>
In-Reply-To: <20250217141520.81033-1-chandru.dav@gmail.com>
To: Chandra Mohan Sundar <chandru.dav@gmail.com>
Cc: skhan@linuxfoundation.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 19:45:16 +0530 you wrote:
> Fix few spelling mistakes in net selftests
> 
> Signed-off-by: Chandra Mohan Sundar <chandru.dav@gmail.com>
> ---
>  tools/testing/selftests/net/fcnal-test.sh   | 4 ++--
>  tools/testing/selftests/net/fdb_flush.sh    | 2 +-
>  tools/testing/selftests/net/fib_nexthops.sh | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - selftests: net : Fix few spelling mistakes
    https://git.kernel.org/netdev/net-next/c/f29e41454b94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



