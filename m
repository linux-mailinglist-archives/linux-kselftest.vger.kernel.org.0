Return-Path: <linux-kselftest+bounces-7217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAC8898D64
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 19:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324391F21AC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF812AAE8;
	Thu,  4 Apr 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVbaDmOE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DA2D7A8;
	Thu,  4 Apr 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252431; cv=none; b=e0OweoI57hP3/LhrGprzDgFPtjMc3qMDbpme2N+j73T83/h6yfJ2fKQRNSV1b/YUMN8Fr6JIEv6BREYbX/kMVj2XR3lI9C/N2cig6GQZu9Mt3JVsesPJIrBvU7cC3xHTDr784eixODh01V/2YIR9lo7w1zl0I9WHqjtFoxA18bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252431; c=relaxed/simple;
	bh=H0eHnkdQlaub70IsZi928QpIFYIoNGGyXmzbUJqap4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l6I5QfYL6NQ0rNxUxCUpCfSPwR9wQcaxnoFRWkagTYVYwiCtpJuDZWyoybVAagFvm8D7k6nP+ZAaD/CH51hFy/RGCGAkrFJsUSbLtUwzGDTTUUVg82Qbkv+4MYoUWCUTSOJ+wGNBgVs+ocO3CEj+GhGqWqBLg840lfvAfoHQcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVbaDmOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 260EAC433F1;
	Thu,  4 Apr 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712252431;
	bh=H0eHnkdQlaub70IsZi928QpIFYIoNGGyXmzbUJqap4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dVbaDmOEGQ2gEoeDfX8MIx4LEc8U/k+c3VC7BQnrqtsHALM4JB411IJ06n9T3PQwc
	 Gf6BPcdIgq36iX4i6/JcOHgdPWXWUrK4A6YFr0sJMxnaosRQ++LyDBvgG6NxAS8au1
	 pC4Qn2cR5OqS8Rq4d27GvU3yUoCd5LzQOsOrgCqWk1cA/vXyNTovvZXOR4tTrJpDqH
	 jdmCPMQZy7OeJjKLZaObgLeSFHYQbFrFAuguIsG9ESZsbPRB+FEn+AX/bGVTVWQ5IG
	 4KXRxgGX2G2pKrKrxQWB42FY691NnErPQ6xRsDjx4AAwvpdw+aU4PZmQCkNZXGIfLX
	 C/bmWoxY/WvdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15D20D84BAC;
	Thu,  4 Apr 2024 17:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] selftests: net: groundwork for YNL-based
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171225243108.12972.5787719487357739933.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 17:40:31 +0000
References: <20240403023426.1762996-1-kuba@kernel.org>
In-Reply-To: <20240403023426.1762996-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, sdf@google.com, donald.hunter@gmail.com,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Apr 2024 19:34:19 -0700 you wrote:
> Currently the options for writing networking tests are C, bash or
> some mix of the two. YAML/Netlink gives us the ability to easily
> interface with Netlink in higher level laguages. In particular,
> there is a Python library already available in tree, under tools/net.
> Add the scaffolding which allows writing tests using this library.
> 
> The "scaffolding" is needed because the library lives under
> tools/net and uses YAML files from under Documentation/.
> So we need a small amount of glue code to find those things
> and add them to TEST_FILES.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] netlink: specs: define ethtool header flags
    https://git.kernel.org/netdev/net-next/c/1d056bf9a4c1
  - [net-next,v2,2/7] tools: ynl: copy netlink error to NlError
    https://git.kernel.org/netdev/net-next/c/b269d2b4a523
  - [net-next,v2,3/7] selftests: net: add scaffolding for Netlink tests in Python
    (no matching commit)
  - [net-next,v2,4/7] selftests: nl_netdev: add a trivial Netlink netdev test
    (no matching commit)
  - [net-next,v2,5/7] netdevsim: report stats by default, like a real device
    (no matching commit)
  - [net-next,v2,6/7] selftests: drivers: add scaffolding for Netlink tests in Python
    (no matching commit)
  - [net-next,v2,7/7] testing: net-drv: add a driver test for stats reporting
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



