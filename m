Return-Path: <linux-kselftest+bounces-2785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8ED829226
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 02:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91BC288312
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 01:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFDC2117;
	Wed, 10 Jan 2024 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN5pPPgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBC17E4;
	Wed, 10 Jan 2024 01:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7B56C433C7;
	Wed, 10 Jan 2024 01:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704850256;
	bh=ndgCTDOUkRLw3O/CI3BWboDpmFGl4pmg7O36nRs0fSc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XN5pPPghS5EcJXsPkPAxGkWpuRR1i/6LrYQASjwX5HmIL5W2xpcyid+G2S1uKkXzb
	 BaEpnmIqJGhXB0SotQrxZZYCyD6hSZ37oOrj9kFBOSKP38mH7r8K14g3g8KR3IWy61
	 fw6hwhJSlFR1PSweSPYkAX3pfeIegj810y9NzUb50XB4EhzVRKrCowKZYt77qrbu3E
	 jzw7zNmwZBhjBt66nt8/86vWD2+O4xj78uEioSbj8khRscZWhLwnNTXkzxPZg1J/8I
	 SszjeCgdYzjG6YmQr2ofllXz4VDE/6Lmp/ZAIOvfyMCTm0Ii3yb8ofJFiDnp1ZaIIV
	 8M7tgv6ZKkNFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5F46C4166F;
	Wed, 10 Jan 2024 01:30:56 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for Linux 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <c5ac0cff-c947-4d44-b671-ba3e816329d7@linuxfoundation.org>
References: <c5ac0cff-c947-4d44-b671-ba3e816329d7@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <c5ac0cff-c947-4d44-b671-ba3e816329d7@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-nolibc-6.8-rc1
X-PR-Tracked-Commit-Id: d543d9ddf593b1f4cb1d57d9ac0ad279fe18adaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d09f61e505a614250df24a0f7e646802e40fc87
Message-Id: <170485025673.7649.13961087946661349885.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 01:30:56 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, paulmck@kernel.org, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 8 Jan 2024 17:41:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-nolibc-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d09f61e505a614250df24a0f7e646802e40fc87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

