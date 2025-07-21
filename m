Return-Path: <linux-kselftest+bounces-37789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE434B0CE64
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 01:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435A87A744A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 23:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAF242D66;
	Mon, 21 Jul 2025 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9/6YUAD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD912E7F;
	Mon, 21 Jul 2025 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141793; cv=none; b=DMhV7UIrTCG+Cx6U1+yW2FZ1yBEuprcxja0vP8AN8REpXyXAW9yzLRz2q/Akp7RsDtXC+avTTZaHg8UmbDkEMFDLSYh2iyxJlR3z+K54QPzJwBytFxDcI3OGR2VPfGIWlBtDzh+H1qtFryGmg9LZT7TIfQdh/03mtNbFtLBZlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141793; c=relaxed/simple;
	bh=jA7cI6GljoyzvgPHlj6eXM0tNrqjohOQVZaogSq2M+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IWhvH+cwv2Y9vdVpjbaXLS03Q2JdOAXBjpwMNbzprbZoX5ZIANUjA5yVw29gmTq2MRjplgieFLvZjwUrmQ8IYsP/fmH2TrokYFYIxIIUTvmcgk0YvTPTOD45Cqmu32k4pfTjujuA+eKJGxlbM6ik/dA/uxJ1rwfwC/elhYFuEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9/6YUAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4931CC4CEED;
	Mon, 21 Jul 2025 23:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753141792;
	bh=jA7cI6GljoyzvgPHlj6eXM0tNrqjohOQVZaogSq2M+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i9/6YUADIilWqRwmlBu5l2l1AOF9RhOVbn7cNYfUBbZwHgPzScyylsQO+/wmFh2Jj
	 sZRYwq02TYgjo+3o+WADTRNGVRem3vnMfKivQBMUsD408P9WIsEw311UbwmhGwY8nU
	 mRrkvjqPthbJQVADeHOhshQjUF6rXeYFdPUatF3adFDv5g4ldsL8M075nStjHkR47M
	 NsHLl94qPNdby/X7mR53lAMdc7tBqLl002E5/zpkDTBmLKn+pfrPiHAsgd/awGwx3s
	 jJqPBcljPZJ6rDaRYAQFC8vNtlbZWDGZpEjFOU8nsJZAWN+EUnvqjLhZq8YkLbIi0/
	 3wPf9XxlrPOGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7D383B267;
	Mon, 21 Jul 2025 23:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] selftests: mptcp: connect: cover alt modes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314181066.233941.7549258562829367580.git-patchwork-notify@kernel.org>
Date: Mon, 21 Jul 2025 23:50:10 +0000
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
In-Reply-To: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, cpaasch@openai.com, dcaratti@redhat.com,
 fw@strlen.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 20:43:27 +0200 you wrote:
> mptcp_connect.sh can be executed manually with "-m <MODE>" and "-C" to
> make sure everything works as expected when using "mmap" and "sendfile"
> modes instead of "poll", and with the MPTCP checksum support.
> 
> These modes should be validated, but they are not when the selftests are
> executed via the kselftest helpers. It means that most CIs validating
> these selftests, like NIPA for the net development trees and LKFT for
> the stable ones, are not covering these modes.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] selftests: mptcp: connect: also cover alt modes
    https://git.kernel.org/netdev/net/c/37848a456fc3
  - [net,v2,2/2] selftests: mptcp: connect: also cover checksum
    https://git.kernel.org/netdev/net/c/fdf0f60a2bb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



