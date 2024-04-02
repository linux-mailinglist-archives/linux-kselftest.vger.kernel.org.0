Return-Path: <linux-kselftest+bounces-6970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58F8894AA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 06:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138701C2255D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 04:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248CB17C6A;
	Tue,  2 Apr 2024 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+6UZRsF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5542175A9;
	Tue,  2 Apr 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033429; cv=none; b=cLGrEkpHuECwOF4l2Z5TwpYFE3uX4ec7wIYHFyHDK/Vsl0UrbuOFBiebK01a91bGMbRXDMyIVFcDP+QLUcCwRBCaTTL8Ou7nqVUOSWYNHtYyowW3diEwUmJA2+UFG4Dw39mn0SDsV0Jorom8/bqCCsue4jIkeZ6wPte8NRWmLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033429; c=relaxed/simple;
	bh=nHHWCjMhRh6CPqMNONkTsy8+0GPYXavAgdEu3JRVI/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FhScFzdgTKhIaE0gcsToFqYJLoklsQcRRpQFy3OW3Sg73ZM6xVuOA1OVCSQ4FD2uHfF/+mafP1ujt5OgbkfE9rYvVsRN6CM5fH4VKp7L1VlL+eVUXCjMLCa7jKebXb8xwmnUhXWFFm+wZIrU4lURX3zF/irRAnhsF53XitxYIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+6UZRsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 633F5C433C7;
	Tue,  2 Apr 2024 04:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033428;
	bh=nHHWCjMhRh6CPqMNONkTsy8+0GPYXavAgdEu3JRVI/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E+6UZRsFmbiPaSUetiBItB0Zn5fYCxeGL7ZqJHo66GLbawfTMJMqlhqcY/o51dW7X
	 RMWFrVDRPndjWyYoZytx6AY0ehmXFc+x0Msybhcp5tPWkTrHAwK65C4p05XX3IXLg1
	 kBTlqaF7+Uzlt1/IrHMjRg4dhN9FZBO6wo8E7rqdypGIiB6Cxc78DVls0GNbWGd83s
	 z3SJPbujicHzJt+qOA7+CSc+hm3BH9vinZsx2aKh+l1O21llSeO6/Kl0wIt5+BWH2D
	 syPlTpFXk3AaKzkFrxoCX6+7+9Lb7IY996OZF9QP7AW7eL12FkHSS6n0deWfjvuE8+
	 nloYTcjBexrjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53179D9A158;
	Tue,  2 Apr 2024 04:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: fix fallback MIB counter and wrong var in
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203342833.12415.12309302923089138092.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 04:50:28 +0000
References: <20240329-upstream-net-20240329-fallback-mib-v1-0-324a8981da48@kernel.org>
In-Reply-To: <20240329-upstream-net-20240329-fallback-mib-v1-0-324a8981da48@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dcaratti@redhat.com, stable@vger.kernel.org, cpaasch@apple.com,
 tanggeliang@kylinos.cn

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 13:08:51 +0100 you wrote:
> Here are two fixes related to MPTCP.
> 
> The first patch fixes when the MPTcpExtMPCapableFallbackACK MIB counter
> is modified: it should only be incremented when a connection was using
> MPTCP options, but then a fallback to TCP has been done. This patch also
> checks the counter is not incremented by mistake during the connect
> selftests. This counter was wrongly incremented since its introduction
> in v5.7.
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: don't account accept() of non-MPC client as fallback to TCP
    https://git.kernel.org/netdev/net/c/7a1b3490f47e
  - [net,2/2] selftests: mptcp: join: fix dev in check_endpoint
    https://git.kernel.org/netdev/net/c/40061817d95b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



