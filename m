Return-Path: <linux-kselftest+bounces-38259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80464B1ABB5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 02:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9137A30D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 00:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7668E12F5A5;
	Tue,  5 Aug 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbVbrsVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBBD72639;
	Tue,  5 Aug 2025 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353802; cv=none; b=pOJcHWJaLd79NmhtPqB8KfhZm1IT4SG3swzQU9aw69K0KeVzn+61CU2ViBHHj/LcoN9TAXWsB1G2U2fBRVHXMILkPcbzE+HwFmO3h5KeFDmoG1cTnOgC8W6jfLqQie+EJA6YwruP0g0fs1kEUXyG9ERekfVXiixswLcmm2uu8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353802; c=relaxed/simple;
	bh=vFHDoxI8szDyghYzgM3qlYFrLc19H8Yxdegx66jeKbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LaeJcbY+x5UgwV9brA3uANEWGTVmmlRmH3rhaT45uzMsTxL4tKbnFhuRQTeBDaFBwI+vbK8yrzeCelWAHNiYbIEtr62hHMFD3Bu4DgegHXXumBMmqqV/Kt+OGvbABt9QYZo8nByBelw8EMKG7uOQ2NERNuYS1BUKBKpyeWVVKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbVbrsVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8931C4CEE7;
	Tue,  5 Aug 2025 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353801;
	bh=vFHDoxI8szDyghYzgM3qlYFrLc19H8Yxdegx66jeKbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gbVbrsVtLUGriZ5Q/jV7/HvxJTPdn/MZ4UowlN/qqkOvxUvt9XX6j0sxvJPENx1Lt
	 naV67K07VyvB9IH4mD+NHXCgfaxHZMWZxjFOSkCrdS5TPCOT45YSo8ziZCvleM639m
	 Ydt7iKJLDPuUof2JqWrHVCSPfcAmjFyDWCX0X4iqQVy2maZBz3eRNWYGlQwvIg1F0K
	 1NhHzhJrvFrq7dfaEuvjXgik9293sYl/xfkMzDp5ododOhfSLkMwM0WX7MS5hOJpRM
	 TiUBT6MPoatzFkJiBCao/gry4rJHhIunPOzhl8j2mulvCsrtkrodnx0jz9jYZm62w0
	 vndLf+GJIL/fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2A383BF62;
	Tue,  5 Aug 2025 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: packetdrill: xfail all problems on
 slow
 machines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175435381578.1400451.12382106859002652663.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 00:30:15 +0000
References: <20250801181638.2483531-1-kuba@kernel.org>
In-Reply-To: <20250801181638.2483531-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, matttbe@kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Aug 2025 11:16:38 -0700 you wrote:
> We keep seeing flakes on packetdrill on debug kernels, while
> non-debug kernels are stable, not a single flake in 200 runs.
> Time to give up, debug kernels appear to suffer from 10msec
> latency spikes and any timing-sensitive test is bound to flake.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: packetdrill: xfail all problems on slow machines
    https://git.kernel.org/netdev/net/c/5ef7fdf52c0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



