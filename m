Return-Path: <linux-kselftest+bounces-25775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A6BA281B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49491883A97
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFEE214214;
	Wed,  5 Feb 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIXhF2bO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341425A65D;
	Wed,  5 Feb 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722014; cv=none; b=CgkeQWGEOgEaZPEm+xFT7pM8Iszixfhuik0eMrByVIc9/as/iE20ia/GKn31JwLtRkse8ijpyLqJCIZXDVOXrMpU8v7JHwypc14kM36l1OfsrXYNR6Xd+aY+sYi0ymnMD5Ht5unXDzdS4VXjZRN9gp2dvZUyyxa8UUFmKbRAi1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722014; c=relaxed/simple;
	bh=zhOY3YomWCvmtaCgrNkjWnKNT5JYyt5HT88X3JfjTGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N4J3wK2ua3ZvdddlnxZgN4NM16M+z+iRgTiCjTyK2+aX53QvyoycNpsRHq+AzeY9XuawsQK9UXUCAAJ8vS1gcU35DXud8w9VOA4mIE2gSPcWsj+x+jXkIYVRoTYWriO/G9BHhLZ/eOOoMuQ5RGB7A/5Md9/npnIRjJBdcOJ0vT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIXhF2bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3DBC4CEE5;
	Wed,  5 Feb 2025 02:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738722013;
	bh=zhOY3YomWCvmtaCgrNkjWnKNT5JYyt5HT88X3JfjTGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sIXhF2bO5sBgw3d3Bfs0bcQzAbh9rsSsMplZDebJjekVHXXaRMj2NqeM+eDk/BgfU
	 OC3c5isc3u/dwZLvZkdO8JNaAgWAwtNQO32hXpl185kIucHeMASiqeuntc0yuHnZTr
	 ZXXgqWMLdMppWGfbkfCwV7JJd/D7nVGAS5m64ysbNK7K+P+budDLJcqxEn7zVvea0i
	 Uiy1XtVX4ptRARxkXZ1YKgZCGEKXIeEXR3nRTcq9X9gEGHh+7MYWmDtnT0tWjcZWSV
	 35V6gVxqZhAN0mVm926RJb+t5PbT0s1mH05EldhtDRtDlGMnRVNTAG11oqZIBLHqU7
	 BNPRp16Ljcspw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34310380AA7E;
	Wed,  5 Feb 2025 02:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netconsole: selftest: Add test for fragmented
 messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173872204075.246239.3683457761866734624.git-patchwork-notify@kernel.org>
Date: Wed, 05 Feb 2025 02:20:40 +0000
References: <20250203-netcons_frag_msgs-v1-1-5bc6bedf2ac0@debian.org>
In-Reply-To: <20250203-netcons_frag_msgs-v1-1-5bc6bedf2ac0@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@meta.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 03 Feb 2025 11:04:15 -0800 you wrote:
> Add a new selftest to verify netconsole's handling of messages that
> exceed the packet size limit and require fragmentation. The test sends
> messages with varying sizes and userdata, validating that:
> 
> 1. Large messages are correctly fragmented and reassembled
> 2. Userdata fields are properly preserved across fragments
> 3. Messages work correctly with and without kernel release version
>    appending
> 
> [...]

Here is the summary with links:
  - [net-next] netconsole: selftest: Add test for fragmented messages
    https://git.kernel.org/netdev/net-next/c/d5fdfe480c79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



