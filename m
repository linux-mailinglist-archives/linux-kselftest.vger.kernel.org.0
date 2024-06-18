Return-Path: <linux-kselftest+bounces-12175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED1790DE77
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 23:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE3CB22D7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 21:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89C17A934;
	Tue, 18 Jun 2024 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM9IpRLJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1613AA44;
	Tue, 18 Jun 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718746401; cv=none; b=jJy6v/K7/7sCcl03G/V+kmIdGOXXa5kEbsKetlFFQzCL3mxE8yje7VCPLWmoQhwnuel1+rZTC5BxAuTNHMGI9nPg2uGzGscU6FFkjJQSTCVxVXL98oKqATfO7UqhvPOMTOlQjOnc5YLYMJh1O4LWcnemZd6tR6BU4gk8m9s/oN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718746401; c=relaxed/simple;
	bh=ktlCxkeNN2m+cMsASQTvod072rETu+DxRKX4AqEkj8Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KiV04oMQW9/MSFUS35Sq2T33z3+EO8i0pFojiBpNzDCRvM/2V6xfzNfpxEse+TqgnPfOdIkOxkFjnimDwL/KaL65adYpR2CvlZ+HpLZWl8IsF3qwF22dG6oTEJKPmSaaR92AJiXud7cKaCweq1i9DvgyooQz2wwZzSwffIF5vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM9IpRLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4486C3277B;
	Tue, 18 Jun 2024 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718746400;
	bh=ktlCxkeNN2m+cMsASQTvod072rETu+DxRKX4AqEkj8Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QM9IpRLJwgP50256mMBOXZi2sEDHrXf7Tz9OPqqR9cI094W+iGrze46EBp9iSiO4t
	 9YKdIl4kWpNDycYin6oEPGkm4sKAecWazmTjc49eMaUZjjjSOAPQTW8QeM5FWRmr4f
	 O/Rdq3LatA41u1iUcODeatnXGQg0d2pQUajrhmDdFKf7LcOjzl51fx5YLGp7lfenbk
	 luhQ04/FQvb0A2RjOs5B+3PhDXDB4kXEToOOGMRWV6CBLZHl4+i/ShETtXnWqZGjkr
	 PDwdj9UVjjexYDEomWPPm532A2/X31ull+a4y7xAghmB2/U5JGtgTipPobho1r5jDb
	 pYm/J1s0lwfWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1E28C4361C;
	Tue, 18 Jun 2024 21:33:20 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for Linux 6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <772723d8-a7bb-4053-be40-b00680b518bf@linuxfoundation.org>
References: <772723d8-a7bb-4053-be40-b00680b518bf@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <772723d8-a7bb-4053-be40-b00680b518bf@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc5
X-PR-Tracked-Commit-Id: ed3994ac847e0d6605f248e7f6776b1d4f445f4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92e5605a199efbaee59fb19e15d6cc2103a04ec2
Message-Id: <171874640071.26682.1305521738242890558.pr-tracker-bot@kernel.org>
Date: Tue, 18 Jun 2024 21:33:20 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 18 Jun 2024 11:42:42 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92e5605a199efbaee59fb19e15d6cc2103a04ec2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

