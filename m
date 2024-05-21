Return-Path: <linux-kselftest+bounces-10476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC6A8CAD65
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE1BCB22B62
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972865E20;
	Tue, 21 May 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHnVj5XW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4117654747;
	Tue, 21 May 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291030; cv=none; b=PMNkXVD84VGotPGsAmBzrbTPD9piFntn3y0dPpAAFdVZqcl285F5sVyfvqar9tKhZBuCF/4axzrQUmAGB90J9aUzuzlTg0+vlkr1kDxguSCr48jwfmzkbsIVyJJQlz56QwuAyjw0yqFK1Z5BvVm27p8zWdknnRIpPc2O2MnR8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291030; c=relaxed/simple;
	bh=vcYx96Xu/pDjwNcj7957zdV+Qyh5Khjmt5BYWJzQaUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=odde1aqlAvMpi7CTR4zoFXm+NcQowpoIBvfZj8z23kvQi5vVK7YGb4QIDLlzZIm10j9njtmpm2yf8wvBE7mU0NPhpQ+HdERCbMMXAYSLNUMpoNN7tiahtGclO3o7wY0sEoPvJeH+czR7V/iyLYQ2zeVzx16AS4Lq1sYrefZ2W7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHnVj5XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3411C4AF08;
	Tue, 21 May 2024 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716291029;
	bh=vcYx96Xu/pDjwNcj7957zdV+Qyh5Khjmt5BYWJzQaUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AHnVj5XW8fNGVlDLloGTaJhxa1deXQiS32pejHpGQkM+SjdyyKAA9L+oyiuNgyvpo
	 AQwwc/KKIrKwH1YO84rZVHfmvnUiAweWqff6Rk4I5Ic8mguiVOPV4Ki3Ym/L0nlatx
	 Gb4RTIf1izMVvqt8kroU0Ko2NsxwSuCZbW6FT9g/oypQdQ8QpyYX0JMozGtBcLljgt
	 O7Yp6NXDpfphHf9hP8AGwkSb6ZgoAaLiMK+aZLGLkKMT9MS3R4IumS4NaNbaWOjYYC
	 yC+irC9y9mkvdm1fBXB+ZvMF6A1qdYVNldMXu1tkfQ+o5xnaeLKzBe3ORPaf7spNSV
	 anyN/0PK84qXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0098C54BD4;
	Tue, 21 May 2024 11:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net] selftests/net: use tc rule to filter the na packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171629102964.29018.6796524124183677017.git-patchwork-notify@kernel.org>
Date: Tue, 21 May 2024 11:30:29 +0000
References: <20240517010327.2631319-1-liuhangbin@gmail.com>
In-Reply-To: <20240517010327.2631319-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 bpoirier@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 vladimir.oltean@nxp.com, jhpark1013@gmail.com,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 May 2024 09:03:27 +0800 you wrote:
> Test arp_ndisc_untracked_subnets use tcpdump to filter the unsolicited
> and untracked na messages. It set -e before calling tcpdump. But if
> tcpdump filters 0 packet, it will return none zero, and cause the script
> to exit.
> 
> Instead of using slow tcpdump to capture packets, let's using tc rule
> to filter out the na message.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net] selftests/net: use tc rule to filter the na packet
    https://git.kernel.org/netdev/net/c/ea63ac142925

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



