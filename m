Return-Path: <linux-kselftest+bounces-34853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A14AD8054
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 03:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D0C17D6DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 01:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919701F12F4;
	Fri, 13 Jun 2025 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhRZDpE3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3961EF094;
	Fri, 13 Jun 2025 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778216; cv=none; b=D/9Yim9xlmW9i1NeBuWtahduc+YtuBc4X8bthHPFdUW3fWtNd77/5A0gGnEKSGzaLDavT5AKeFK19SSXzH/47KBQWpGJaJbuZNkBO+ybbpN/sCwdiVXkCXF782TYZpmkflSyb7XQYONflWb1sevtXu5kT47BRXCx1JaDL0FBLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778216; c=relaxed/simple;
	bh=d1xtRXdCaCRCt7BAAKhhACvTBUZNP1DogSjngPtQUh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=STOGDNx/X1ldOPlTW7cW52hfPJZTcIxZaXpNjVylZFdPtkMJNEGtpDS5Wfc9u75tBPl82O08HSlh/73r4NtXy80ik9CRxxmC9ebabi8A9RPn/l6k72MzSZ0o0OqoJgQqDiSCzg7dLJJnqYqUVdIhaB3ZHTkwboqOAgutXQG1Y7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhRZDpE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AD0C4CEEB;
	Fri, 13 Jun 2025 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749778215;
	bh=d1xtRXdCaCRCt7BAAKhhACvTBUZNP1DogSjngPtQUh8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AhRZDpE3dOLXbjNKbRk/s4fk9SBCXxlaX+LzgjxcIWZr6q01jOPAqCTPjhBbKdtc+
	 f0NWbjnlKDIK5oj69EunT3g7P2NXqfTQSUQqfno0n2UEIPrNiifRO4dsdZrK6Mvxjh
	 mmJId2SbKIxsJs0BE77jaB7Fb1azu2lHIHx4rS0YCyH4hsWJZEtB93FzTWGuPHbgiC
	 WLcoZLyzlwQopxWy23AhYlZnLvPwTruC/QgRHcM7mkrCtpLCw3hWl3EtVVdTd3EZA/
	 SG6s86gvgFtRqojzn0807jwDZblLtz4h926HmbaAP3gYAuD9Nh0STyUTjWbYYQPntP
	 cj365vdoiO1cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACEC39EFFCF;
	Fri, 13 Jun 2025 01:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: tcp_ao: fix spelling in seq-ext.c
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977824549.179245.11535347214366508908.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 01:30:45 +0000
References: <20250610071903.67180-1-ankitchauhan2065@gmail.com>
In-Reply-To: <20250610071903.67180-1-ankitchauhan2065@gmail.com>
To: Ankit Chauhan <ankitchauhan2065@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 12:49:03 +0530 you wrote:
> Spelling fix:
> conneciton --> connection
> 
> This is a non-functional change aimed at improving code clarity.
> 
> Signed-off-by: Ankit Chauhan <ankitchauhan2065@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: tcp_ao: fix spelling in seq-ext.c comment
    https://git.kernel.org/netdev/net-next/c/221dfdb2df90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



