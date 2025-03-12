Return-Path: <linux-kselftest+bounces-28839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1AA5E557
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F70D3BB784
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78B1EF092;
	Wed, 12 Mar 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SN3ahCpb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934E1EF08A;
	Wed, 12 Mar 2025 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811397; cv=none; b=JPDfegq8DY8LEnEL+RU1XHIdW6nSITjIuhG7afq+TrRARYTJc+Dd9g8e0IZphgpBBMN2BcJCqXiPtmCgo3agSDEMTLDf6WKcOIHCYxdmRzyJ0wwkdJkQMhVmYIWv6yrxPuyUwD0BA29B2kyJLZ/o6IdOCzWg71VPP6zuzIoVePA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811397; c=relaxed/simple;
	bh=Lui/Wi9+usBiOXuSFc09k5rv1L/XWBX66Q0Dat36Q2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fOPQ/YqmsR/0vlrjiBum9KGDnzYfBK1iZjyHjeRBHmkPC2YSdJbwbXnWdMJ8leP/HRmbSkC9tbG29af8xxpPjHbVo7LJ6SWZQ5Dz9313iKNrKGwkFiQ9PyiTyk0jeQ7z5z9gtjw2bbP/HR78iQpdg1GcuOkzxrxnqa9TQwhiYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SN3ahCpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EACFC4CEE3;
	Wed, 12 Mar 2025 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811396;
	bh=Lui/Wi9+usBiOXuSFc09k5rv1L/XWBX66Q0Dat36Q2c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SN3ahCpbq8R4pGfSe0YTZbcUQ+DpEDqvZOFhUbbjiFZFJMviDGOHyZxTKoiFS5bBx
	 5Sp6m9H0cXm6VCCx+SKT0LfJThO/n2246+G3FRza4C2l54+k6XmctCVBb6Zzjhuy3u
	 IjQLp7in7rvGpONGgqH0nBG2SQSYDERjY5QdFxK91K/Qzgj8sPcoURjxBw8FfJtcd4
	 FmaMiBd5cqvoo7G2ioDWbcNRCQtkZpInthy7FQSOOYAR9v4ZtQZ7WcfHMXVGh27qql
	 6wvtI7pgbbcl8gM8V/JbYaCQROUKc3b1+RBSy7IAiChyuGls9EBN5pkR/2wfFrIfqQ
	 2YxrWPJxwl3+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB006380DBDF;
	Wed, 12 Mar 2025 20:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: net: bump GRO timeout for gro/setup_veth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174181143054.921984.17666665132739086259.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 20:30:30 +0000
References: <20250310110821.385621-1-kuba@kernel.org>
In-Reply-To: <20250310110821.385621-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 krakauer@google.com, willemb@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Mar 2025 12:08:21 +0100 you wrote:
> Commit 51bef03e1a71 ("selftests/net: deflake GRO tests") recently
> switched to NAPI suspension, and lowered the timeout from 1ms to 100us.
> This started causing flakes in netdev-run CI. Let's bump it to 200us.
> In a quick test of a debug kernel I see failures with 100us, with 200us
> in 5 runs I see 2 completely clean runs and 3 with a single retry
> (GRO test will retry up to 5 times).
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: net: bump GRO timeout for gro/setup_veth
    https://git.kernel.org/netdev/net-next/c/188107b2c403

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



