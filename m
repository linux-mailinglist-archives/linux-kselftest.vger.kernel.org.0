Return-Path: <linux-kselftest+bounces-3494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF283B468
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 23:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8E61F2321B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6574135403;
	Wed, 24 Jan 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/Tbaq2N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1511353E4;
	Wed, 24 Jan 2024 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133631; cv=none; b=OGZ6G2IgIwSv3/0Q4FNBWvhSnT9Y/IecKTQ8MIStje87j0zbwasI56ISPzPIrjupBJPajCF5gClpl9ZHOwRwAIP7Teotg/Kt7RORTYsYMaW0kEMxo1EneozMzQKRce0LB4z/GTSFb/L9ujAoFru0J15JfuHvzfSgK8FRa0EwuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133631; c=relaxed/simple;
	bh=NhoGpV5NMmCtdxNo8oE/71IMyGs3/jRJ221PV34QAQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=btdv3boIyiAUEjfySxG81KOxUpEsozczGdbrnMZOYoYNRlKubuK8FHN5hvk9xNCS0n14qGjrYucjYBVj48TyQxXfwM4zcmQSnTF8fjaunPW6nAoA9de/4VP7762PfZQznw/JMK0RLBMUB/GLpGGuHXKd3yPToErInXBN9aNMCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/Tbaq2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B79AC433A6;
	Wed, 24 Jan 2024 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706133630;
	bh=NhoGpV5NMmCtdxNo8oE/71IMyGs3/jRJ221PV34QAQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t/Tbaq2Nh8H9O1z786MlGD8WFfsuoNubK+4qgFVWZ3yT/d4APNGtsZ4LlZsmE4o7T
	 JVUc7osITtUbBHquNvVuzHQ3cjPJKYgHa0T16EncghJFEJDOcu3H0U5NAIihkOgbIo
	 eDjtCeVFQL7+qDwCJYuV/aNVgwaPM9YuUG02uPpbPP+1q5/x5Ug6sb7YT3742ku1Za
	 PsLfYVloFPk+/QVWyFHoE2+k3MMlE59TeZudZDMNBEeH8K3YTxUG/d9STt26hV8omR
	 NmHax2N9qzSeZ7fD1vZtXluarjTtfo0HCCDyZlqK2159+JjoyHbLZGpEPHyN7CVxN/
	 3n22eq+pKOUsQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42FB7D8C966;
	Wed, 24 Jan 2024 22:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] selftests: net: fix rps_default_mask with >32 CPUs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170613363027.18410.10710260593019790950.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jan 2024 22:00:30 +0000
References: <20240122195815.638997-1-kuba@kernel.org>
In-Reply-To: <20240122195815.638997-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jan 2024 11:58:15 -0800 you wrote:
> If there is more than 32 cpus the bitmask will start to contain
> commas, leading to:
> 
> ./rps_default_mask.sh: line 36: [: 00000000,00000000: integer expression expected
> 
> Remove the commas, bash doesn't interpret leading zeroes as oct
> so that should be good enough. Switch to bash, Simon reports that
> not all shells support this type of substitution.
> 
> [...]

Here is the summary with links:
  - [net,v3] selftests: net: fix rps_default_mask with >32 CPUs
    https://git.kernel.org/netdev/net/c/0719b5338a0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



