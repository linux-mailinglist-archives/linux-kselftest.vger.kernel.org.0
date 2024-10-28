Return-Path: <linux-kselftest+bounces-20865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D07E9B3E2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B93282F86
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6E21F7572;
	Mon, 28 Oct 2024 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzO9N6g9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318691F4FA9;
	Mon, 28 Oct 2024 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156426; cv=none; b=g92tE+fXXat+Cp3hfcW4XlJIDC6HA7jXbZH9kO0BwGsAHtNtQQ9WWEOo+iqf6yC3mbs/RjSomBX7wQGXrod4vLUfECm3uchs+qAzjngbdct5V59m2jvVsYo8BlIfPvNQs27b7oDpyb76p2uIL18CsCAYP/PwK+sKOrWLWh53lIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156426; c=relaxed/simple;
	bh=cg9CZXqHngvKMWowCf81kXPpkp+T2UCnj7qICB56XI0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kSUoSk2xo2Jp6TGTdZynshfdCxzhlLznslYfInuASdGJZz6DQyYrQXf/RWAxWVfU+rBAElDfpHjJpq7KWIapu/hCy9gFv6Uonai2PWNrFQjLS/Y4Duu0Tlo1EzQV8RA10kNYdMMdMTWuPk9x5gKxkbVx7/CzCHz26wZxMj++KqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzO9N6g9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C096EC4CEC3;
	Mon, 28 Oct 2024 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730156425;
	bh=cg9CZXqHngvKMWowCf81kXPpkp+T2UCnj7qICB56XI0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AzO9N6g9xskN/S0YcPwYiu08rM+y7jxPahRx3MAioobtQU+jZMuJdb5F+xdZmeBcp
	 k1Fu+zXFQqGQlmcB2fOTG464Qt4PyLGPqpCqKH/9mW5hYYLauYPYsjmzTv7v7vQocv
	 I7Lo6sDsEXGnSzKgSYjuIKwh531clJmSrt7jgNI9T2dyHf3MNwaVjFRiguKF/m1o9b
	 gGBGarLYZ0tU2aHIr0ZfOI9+WBGRMu//++R7THijbg4F/RinlClLuqPWsPOkWXcZbP
	 VOOlu3fMmOwel23FWCPR4LHXxKefe3YnX+dErH+cQy3vNHVSPo2Hbdp/qDm6odxumH
	 D138uoxCN6Sng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100A380AC1C;
	Mon, 28 Oct 2024 23:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: sched: fix some lock issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173015643324.206744.11515451937132958633.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 23:00:33 +0000
References: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
In-Reply-To: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, gregory.detal@gmail.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Oct 2024 12:25:25 +0200 you wrote:
> Two small fixes related to the MPTCP packets scheduler:
> 
> - Patch 1: add missing rcu_read_(un)lock(). A fix for >= 6.6.
> 
> - Patch 2: remove unneeded lock when listing packets schedulers. A fix
>   for >= 6.10.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: init: protect sched with rcu_read_lock
    https://git.kernel.org/netdev/net/c/3deb12c788c3
  - [net,2/3] mptcp: remove unneeded lock when listing scheds
    (no matching commit)
  - [net,3/3] selftests: mptcp: list sysctl data
    https://git.kernel.org/netdev/net/c/5513dc1d8fec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



