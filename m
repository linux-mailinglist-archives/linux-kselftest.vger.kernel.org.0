Return-Path: <linux-kselftest+bounces-33819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B473DAC44DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 23:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CCA7A26EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 21:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C2C241CA3;
	Mon, 26 May 2025 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHzsx8xN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DA2417C6;
	Mon, 26 May 2025 21:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748295513; cv=none; b=e2m+4eU48PoWgB2qWLTWa9qrhsCq/Iws8enQg6q3FA5UYsgqjq/5zcB8VUTIJmzm1JKl5IJCj/jf9al7mScYitDReNflf4zGmpY2aUGwWrdhLEg+zO1cZyc4iyyomAIOjeSsl3QH6XN2d5VdMekeXTwhxLyICsDP2d/PyHsBZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748295513; c=relaxed/simple;
	bh=bxpwu+gwOODMus2OvAt9ecfp6K5DjhFfHszjFAjpC94=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fY+ZxugQ0xqAI7aXS6dYbR1BEHWIC15wepqaG8hfW+xTM5ct2E/64KBhSMRVFDwpeIDgF8G5FukHQZlUanZCufEuVChU6mfBRXhnhMCY8NOjhUQKiuv4XsE4imTlLTWl4rb0HEFmAPkZ8fb+O4Wag3TckAEdALdM1Eol1Ytn+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHzsx8xN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED43C4CEEE;
	Mon, 26 May 2025 21:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748295513;
	bh=bxpwu+gwOODMus2OvAt9ecfp6K5DjhFfHszjFAjpC94=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IHzsx8xNUX7jBCZwRb6RiTO936Y9wzMe+ammXxOrh06wk3Z5Rg/hPV70YK48PTXqR
	 3awHHgcMC6IONERJjG36s6PdUScsRvzXmBSVigzmTQ7eyc6VWLK0whb89Torbkqm5m
	 /iVY6uHn10nf4d97OTC39xleEvcUP10jIINSs2OAGW1yunSLoUJFwuq2sQUnEVY5cA
	 So0LRUjszOMVdiRQRwOB64n00uRMjHN6JRFMP0tuAzoN2venuhzPketFgIOSEw9Sj4
	 3zqtsQbIxDwtD16lWCBqvDB3ZKLVo0BgzFIogSE9Pg2YXjUsGl29ZPZPwJQ8PR7v1d
	 Ci6V9n+g1sM/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC9A3805D8E;
	Mon, 26 May 2025 21:39:08 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest next update for Linux 6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <f7b637e0-76d4-4891-a39e-085c7beed403@linuxfoundation.org>
References: <f7b637e0-76d4-4891-a39e-085c7beed403@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f7b637e0-76d4-4891-a39e-085c7beed403@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.16-rc1
X-PR-Tracked-Commit-Id: 1107dc4c5b06188a3fb4897ceb197eb320a52e85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d2435e1c843ced85e55885282c866208ff9f676
Message-Id: <174829554721.1063943.6938439088529207407.pr-tracker-bot@kernel.org>
Date: Mon, 26 May 2025 21:39:07 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 May 2025 14:12:35 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d2435e1c843ced85e55885282c866208ff9f676

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

