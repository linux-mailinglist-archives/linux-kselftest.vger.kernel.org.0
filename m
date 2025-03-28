Return-Path: <linux-kselftest+bounces-29874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37045A74245
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 03:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84723B6183
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 02:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7E20DD56;
	Fri, 28 Mar 2025 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvDVeIK6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5BA13D89D;
	Fri, 28 Mar 2025 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743128991; cv=none; b=iuWBgGBmzSmFRto4pFDFAupWv8boV8sVIRYWSnIGrwttiGOzhjcbMW5ovYEuxv0DVcJASwXawA7fO6szUj2qU+QHVXkz/BoR3sqrUvIFY7sXzd9q9lZ43wR+x4wvA+uiAc7gddc3CkKQ2Q/2s/9I9RKNMUg0DPgkaYYaU47l8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743128991; c=relaxed/simple;
	bh=fZjBQXKbzvp4PvIfvKMm/X6dbHEzS9oe17yDlVOH6iY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FFZcFcEcfceRCZJiKXJFuMWYo08vTakR+GRlXvmG9DUDVsY4+p03BMMUqUnG27zX+uKUH1+CIA8nq+eBcE9w6SCy3l0mIJWtdx3js9ooTXb/MZZo306RKMoZHwCHlInxea/QqthMCEMSN0PjMG767pXdlCOxwhbbATLYURsjfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvDVeIK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266EFC4CEDD;
	Fri, 28 Mar 2025 02:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743128991;
	bh=fZjBQXKbzvp4PvIfvKMm/X6dbHEzS9oe17yDlVOH6iY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kvDVeIK6nLtvnp5Ugw1+EXAjaxyWd45Cpym1dUHUmBb8ZW7Y5xLJ8UHLgSzCppVeT
	 PUnvuzlqlQAuBpuNuiYtwZ0Xh+aouYJ+2EDKXsuaLsWEiOofwVukEFB9OcNrfpLQyZ
	 nN51UN76iH3iJ07d2IVEbwUiQthKkfYYAq9JmjaoXLkCQQIe0SK2zRNjJiKxrYdaBl
	 RlK5oTG3OCPzsJwncv0vZZGHarSMo1cISdD6N0uLn48SMT0rIIRdsksID2bXoZdt5k
	 FSPa/ljnkK1tT1f5+EUsoHcTxQ7re1jnVKVS1tKfjSVWu75ZuNSIi/yNgGaN5gBoNi
	 BdwlprbM6fbkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEBFB380AAEB;
	Fri, 28 Mar 2025 02:30:28 +0000 (UTC)
Subject: Re: [GIT PULL] kunit next update for Linux 6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <2bc29da1-5c77-45a4-ab75-7afc6f9210be@linuxfoundation.org>
References: <2bc29da1-5c77-45a4-ab75-7afc6f9210be@linuxfoundation.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <2bc29da1-5c77-45a4-ab75-7afc6f9210be@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.15-rc1
X-PR-Tracked-Commit-Id: 2e0cf2b32f72b20b0db5cc665cd8465d0f257278
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a10c7949adf94356e56d5c8878f6fc3f25bd0c15
Message-Id: <174312902723.2321319.13357008960559029910.pr-tracker-bot@kernel.org>
Date: Fri, 28 Mar 2025 02:30:27 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>, "kuba@kernel.org" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Mar 2025 21:05:06 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a10c7949adf94356e56d5c8878f6fc3f25bd0c15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

