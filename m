Return-Path: <linux-kselftest+bounces-35945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C30A1AEAC15
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 03:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5551C41B1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0553188713;
	Fri, 27 Jun 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC+C8/s+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77917185955;
	Fri, 27 Jun 2025 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986001; cv=none; b=l2xo8W9MXLUZgYQis50dfpF1TCM3f/3TETMgGL1Pe4YHzszwxR7h8WXc/OPIGpdt4v84eHdwO+dbYfnvJ2YbvEtFsMip3L7Ac/W5Tj42wrtvtSotqcWxeu+sy/iiN3pCumPL1rR8dVEqbddrGyC4+/3lJXpDOdFNAt/Jd21Ql1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986001; c=relaxed/simple;
	bh=fgMf4epiIF2l+AJUyEyR3v4AleYYENPKnpSMPyIzPRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OHTNSFYsSrgydYPYaiDhODrlz2OeOb2cfdDZwxrR+sY++lx57z4BPY1G2fqo6tvVkeaBrJQsqLAOVxhTWIik5ERycvk6vu1ykEDX3udeBzHpsYQqHnCnlXq/j+VV2B/3CcdFbEJBkIOcjOoPO4zY2Tc/btatk2nXunwut44SRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC+C8/s+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824A2C4CEF6;
	Fri, 27 Jun 2025 01:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750986001;
	bh=fgMf4epiIF2l+AJUyEyR3v4AleYYENPKnpSMPyIzPRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aC+C8/s+H81M9t5z+GMn5l4bxMlt4l5hJC3rAQ3K5g3xLZIQRxM2bTY2jcZA3uQ7l
	 P7rBvzLX6DRoWApzj8daiGxiL6AaB56uhWNCwtOOH7XS8zJ4uw6mHqs/Kyty52b7is
	 BL7NkX1yfMWAe34Vz/27nVNf22NWN0UGYucWiLdxH8C+q6GK2ZhjijEuwZ5btVcO84
	 kvmjBR12ySjk8sJNMLurPzEIVQLUqbcTzTlH3obnj2S66uNsSBgg7LX5yRqflgRfhG
	 BcwNQhDYi/oJ4uJmSed13tXyx1GyjQUNJGE+f7VaycZocqlsHM5XQNzXnC5kJJnIDN
	 X6lLr9WUvB8Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710833A40FCB;
	Fri, 27 Jun 2025 01:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: forwarding: lib: Split setup_wait()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175098602599.1388943.17204976288506235120.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 01:00:25 +0000
References: 
 <8e13123236fe3912ae29bc04a1528bdd8551da1f.1750847794.git.petrm@nvidia.com>
In-Reply-To: 
 <8e13123236fe3912ae29bc04a1528bdd8551da1f.1750847794.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 idosch@nvidia.com, mlxsw@nvidia.com, shuah@kernel.org, matttbe@kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 12:41:23 +0200 you wrote:
> setup_wait() takes an optional argument and then is called from the top
> level of the test script. That confuses shellcheck, which thinks that maybe
> the intention is to pass $1 of the script to the function, which is never
> the case. To avoid having to annotate every single new test with a SC
> disable, split the function in two: one that takes a mandatory argument,
> and one that takes no argument at all.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: forwarding: lib: Split setup_wait()
    https://git.kernel.org/netdev/net-next/c/b7863babce0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



