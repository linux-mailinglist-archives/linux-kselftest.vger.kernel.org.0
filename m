Return-Path: <linux-kselftest+bounces-33918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B019AC63BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 10:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 777A37A3BAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 08:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA982472A8;
	Wed, 28 May 2025 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6q2CReX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27880244677;
	Wed, 28 May 2025 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419795; cv=none; b=ACwsvonDmY+bNK+DtR6CgR2CKCWnnqIIx5p35VJn5LgBoIbc1IqDAS5xpqt1glbJk8mQmHqVtuYNUfRh0E9rf1yH0dSotgpt0LrVj2hD2nat0PDS9NL2gTfwhUEzXzI0adNtXrlIghdBu4ybvd7Czo6HdpnEG13Qwt//9+heoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419795; c=relaxed/simple;
	bh=xPH2TOLrYbaBzEBjshCytD643Fi1W6h06i3izOxmaMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nShdT9RTGfhI/VstRnEneMdkxvATwZPgZkCj/rkWSlJrpzQLntv6SPzz94wLM5E/REw57EXSFnUnTlaLaBO3qhbN/gGQYid8e7aEvVeIW8w+eB3iwFRDnydahbeByB/wMfOEIQJZUpyHVZBk7qFVCKOkDpMnBXg+2AKNoJ7k4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6q2CReX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3618C4CEE7;
	Wed, 28 May 2025 08:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748419794;
	bh=xPH2TOLrYbaBzEBjshCytD643Fi1W6h06i3izOxmaMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R6q2CReXqi351arYamfusEQw3O0kwi4YGd1bt879B4qr4yvgBUk1CyvnArTIv0smc
	 NXvJhy3rHieKVOi+tUe5QmmlnCN5RO898055mEoH1EWKJPjjovI8/QDjF4zqm1vQfJ
	 cqU29tVewnnoJzKgnTuhDpH728qLojOt2AyC7BIE+/+X42qYlaKQwrYaMK403no7Ua
	 TZ0bKUkqqecki/5lUad1aiEGgWoQMqYzfRayyTmnEV25atRmA02iqR9BtlD0qJsJ0r
	 qB6J9uLElOL2/leSpfly+lbqDvyBix1dzCA1VbPuw7ltatxCIhV+w4Y2yOC6kxRB3e
	 Iccf1+EJveFYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6739F1DE4;
	Wed, 28 May 2025 08:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/bpf: Fix bpf selftest build warning
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174841982875.2299972.9858779087019173111.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 08:10:28 +0000
References: <20250527054138.1086006-1-skb99@linux.ibm.com>
In-Reply-To: <20250527054138.1086006-1-skb99@linux.ibm.com>
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, hbathini@linux.ibm.com, maddy@linux.ibm.com,
 venkat88@linux.ibm.com, sfr@canb.auug.org.au, alexei.starovoitov@gmail.com,
 daniel@iogearbox.net, mykolal@fb.com, yoong.siang.song@intel.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 May 2025 11:11:38 +0530 you wrote:
> On linux-next, build for bpf selftest displays a warning:
> 
> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h'
> differs from latest version at 'include/uapi/linux/if_xdp.h'.
> 
> Commit 8066e388be48 ("net: add UAPI to the header guard in various network headers")
> changed the header guard from _LINUX_IF_XDP_H to _UAPI_LINUX_IF_XDP_H
> in include/uapi/linux/if_xdp.h.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/bpf: Fix bpf selftest build warning
    https://git.kernel.org/netdev/net-next/c/acea6b132d81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



