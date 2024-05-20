Return-Path: <linux-kselftest+bounces-10450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6028CA3FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 23:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398BB281356
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC62A13957D;
	Mon, 20 May 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIMCpQGp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C361847;
	Mon, 20 May 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241921; cv=none; b=TM8sqXEjTCkbn2ZODWo0xcY+e3C9vXbEvuy4GVl/oUoRt3OeoHk8QCkJtfxibo+P/rftfL8MYRW2nqHfMB3BPVlc6cwaXE/NBlrr8dwSUeVg6R9rVFLahHPx7HeZrYpN9m43E301wUp/CGFrW/Of6fFAhXUicdgRpOEzIGp1jWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241921; c=relaxed/simple;
	bh=5Z0o5pJ87HF4qkDugd6GaJxiEySBHPbmdta/hrrtTQI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DuDxiMjTMhJqo/kSuhxhQ6SxNRFyrZAKxc+0pRaLwfvksptVcChKv+q0MkE/On9uX6fVTASoYSTudw4s8s9UxtXKJHlAN8rhcE9XWeADrkKj2V8Z4XWHRtoyiK2O9o4BIs2eWJ21JklGCVYjLCrkuNuROSmdHfVZKrwtCURB0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIMCpQGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B511C2BD10;
	Mon, 20 May 2024 21:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716241921;
	bh=5Z0o5pJ87HF4qkDugd6GaJxiEySBHPbmdta/hrrtTQI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IIMCpQGphdfFbaPr75sIPKKMx2LX1boBCMF73QPFPCFNIhz3wIjmYD0ngBoseAp3k
	 K8donHg4MvSuwWr7HjbXb7KL7ilFCbWxPQemnOSym+JEGnfBzb9B7gMXsrdaI2zmfK
	 gIosACLB5PxTH77lOXbXRGU5K7+o6vkwnVkBfp0wqHRHSqGPY123t8hrY3X3vPRk2z
	 xSGlPFLlio74V7m2Tc4pXseE4ik0OiuHfaMkQ8Wl7mFM9aUdr88AgzxJioM8CmSMVz
	 0CNT3iTBJWsFp9J13xWtfrctyksL5tbIUUast4RdeiLRu4y4mgWzulXlwOa+J1Z8Sn
	 pvkbIJ2WJkXag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F4A0C43332;
	Mon, 20 May 2024 21:52:01 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for Linux 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1eee575f-91fe-4da8-bd8f-8a8e44fcd4c7@linuxfoundation.org>
References: <1eee575f-91fe-4da8-bd8f-8a8e44fcd4c7@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1eee575f-91fe-4da8-bd8f-8a8e44fcd4c7@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.10-rc1-fixes
X-PR-Tracked-Commit-Id: a97853f25b06f71c23b2d7a59fbd40f3f42d55ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70ec81c2e2b4005465ad0d042e90b36087c36104
Message-Id: <171624192144.28858.1523665933041408999.pr-tracker-bot@kernel.org>
Date: Mon, 20 May 2024 21:52:01 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Edward Liaw <edliaw@google.com>, John Hubbard <jhubbard@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 May 2024 11:34:03 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.10-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70ec81c2e2b4005465ad0d042e90b36087c36104

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

