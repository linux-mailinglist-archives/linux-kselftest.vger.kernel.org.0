Return-Path: <linux-kselftest+bounces-21505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7109BDA52
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 01:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4451428507C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37B152E12;
	Wed,  6 Nov 2024 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXvEEeO9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3198D14A4FF;
	Wed,  6 Nov 2024 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853021; cv=none; b=lotPyFDJnumb/sm2gOEJelYGwdW4KA+ow4ufdIAep+H6E9fmH3I/cIziXBnz6kRrzlwNoUdQw52lbU+KF3J6XO2jQKRJA0lSd3v9aD/7Y1VSfRw+BqYgyaRPY8ugzjw4dBtDb4xzE0SO9hl0jm5cMZBpKKwEj4RVV6HYAKQ53i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853021; c=relaxed/simple;
	bh=c9V3aD4p8PP7Lw62hg1olACyeMbtZ7mnNz7niMzylDA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o9J6Fjy4/lknqHp7BaBho4KyN5KPj9IPHqakxhHSi1ccUMgA9zsTZ1R+Zn/la/PXCxha8zGIrODDJ27JZ1HTc/NHMCEYU/vXKgoFEvNDAfmodT4e0aHBDutCy/N2OnO3fCbS4+lNBXvNd+Ls2y7xA4tiV6zh9MaHRptF7YAsF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXvEEeO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977D9C4CECF;
	Wed,  6 Nov 2024 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730853020;
	bh=c9V3aD4p8PP7Lw62hg1olACyeMbtZ7mnNz7niMzylDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GXvEEeO98FQQpmcFH6ySrf7wZ6CenyFfbgLd6blVYesJ3sCCuRkwxRBeUybvCugYN
	 y2km8YI3f/+mDrTGWJIoSqYJ+nlfryc8Hptc/coWcBM/p+QNLFy8YE8LZSFlYQVNSb
	 Cc7LMsU9sFyMEoXvFo4w1c4VHZo9JeFE5S88kj/VVLJtqdaSxdsemgmuLN6TwImvsC
	 e/fmS0PQOr4O4Xj0jDvSeeau6BpMjyN2/Y0TuvnEEJGPkAA3Z0dpJcIyAlzvSgNbcO
	 a1OozBIaNLI5+RX2J/TZdHnLJUgs3/rLNLWKiFukGzyvoOhD6tv5oQPd1qhJsr/uRB
	 4jhRz+ZtGLi0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF793809A80;
	Wed,  6 Nov 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next/net v3] selftests/bpf: Drop netns helpers in mptcp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085302951.742987.15552199829339581477.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 00:30:29 +0000
References: <c02fda3177b34f9e74a044833fda9761627f4d07.1730338692.git.tanggeliang@kylinos.cn>
In-Reply-To: <c02fda3177b34f9e74a044833fda9761627f4d07.1730338692.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 tanggeliang@kylinos.cn, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, matttbe@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (net)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 31 Oct 2024 09:40:46 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> New netns selftest helpers netns_new() and netns_free() has been added
> in network_helpers.c, let's use them in mptcp selftests too instead of
> using MPTCP's own helpers create_netns() and cleanup_netns().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next/net,v3] selftests/bpf: Drop netns helpers in mptcp
    https://git.kernel.org/bpf/bpf-next/c/ac1bd50164b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



