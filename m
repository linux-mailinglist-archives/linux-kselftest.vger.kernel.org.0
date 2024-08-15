Return-Path: <linux-kselftest+bounces-15402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9A6952D5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 13:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9951C237C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475B17BEAA;
	Thu, 15 Aug 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPN5/oXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893317BEA4;
	Thu, 15 Aug 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720840; cv=none; b=HXlvUx+WZ2Kr571L+i+B8C2/oag4M4ofz0ev7vP/aOYOIJ9t2IzEySxEvFyonOxSIfKJYePDacGRuLb2mapo1XWGh69Pcn6prG+BhkVQDniQT8uWPCl91ysLQExg0xdgz/VT/pcOdMaV28QnsQdmV2iUQzBD+FyQaN+C7sRA9Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720840; c=relaxed/simple;
	bh=AC4GHTrqbsJ8gnMraO6v0o43Z9jjJJSmDC0HieCBRYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uj5KMgqd26pHw447Vqkc4mFLnT0nq+O0Jw9wZzCQO+Q0HwogLnxhk+qTSNpWKngAs+WOHvHFVXzkBJ0tGZf73aHQmd4lrucHIzx28ds7TykW0VP/vqeWCpYsfcPsFxmoctgXc3IVNmwD1GkMOYdojCFxxuZxdOTY7cSAwqma0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPN5/oXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4AEC4AF11;
	Thu, 15 Aug 2024 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723720839;
	bh=AC4GHTrqbsJ8gnMraO6v0o43Z9jjJJSmDC0HieCBRYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NPN5/oXtpbfcEvgEdPI0fMn/AnzGzQV2hVcvVJ9t8tptKk/dQTt+b4swmM7KIXzi0
	 HEKkz3+aA0xw8WHHJbX59WA5i33JvzqOPyzcdm7qTVOv0tnbtMTZELaxxHQNQ0sXrB
	 RU3bHQV1WlxPaDpXUXsUzmb3i6STmOffgVHfiVy4tPEGXYQz0FZMhLQH0boEQ4+ki7
	 Ic+Zioj9kMYsh06Bb7s1h8PAQ9mUpooI1F/6NYBA2Y58XESBv4L5JjztZurqOYVRz8
	 EFfKFwJ3rUP+Dm/RujnLKGpn1shNZnCJtJdOzylCz/daE+V78juqRLWdpripqdWPW8
	 7dZifTgW+GldQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3403A382327A;
	Thu, 15 Aug 2024 11:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: lib: kill PIDs before del netns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172372083879.2824509.4319410901155671996.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 11:20:38 +0000
References: <20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org>
In-Reply-To: <20240813-upstream-net-20240813-selftests-net-lib-kill-v1-1-27b689b248b8@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, liuhangbin@gmail.com,
 petrm@nvidia.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, martineau@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Aug 2024 15:39:34 +0200 you wrote:
> When deleting netns, it is possible to still have some tasks running,
> e.g. background tasks like tcpdump running in the background, not
> stopped because the test has been interrupted.
> 
> Before deleting the netns, it is then safer to kill all attached PIDs,
> if any. That should reduce some noises after the end of some tests, and
> help with the debugging of some issues. That's why this modification is
> seen as a "fix".
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: lib: kill PIDs before del netns
    https://git.kernel.org/netdev/net/c/7965a7f32a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



