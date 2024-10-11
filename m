Return-Path: <linux-kselftest+bounces-19575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4999AF5A
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 01:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F181F2202D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 23:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8FE1E764D;
	Fri, 11 Oct 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiXqDnq3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371DF1E132B;
	Fri, 11 Oct 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689102; cv=none; b=bkO93HK9WerLdQA2M08IvlrRNWW9X+haNJr38z4QKl73N6gMG2roTvWqrhXKxd4Bc3PjycG/qGxqza+O1xYTXDq0rdOiFrjdqKXP8NcmTrdYyYfAuFP0aZ2dzimt6PzxHO9/Ft6H7fbrbZvzS1PR0cV3EoS2x5wd2TYEj6UuD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689102; c=relaxed/simple;
	bh=Xzdolzf/rqA7wvxWxEDW8tmVEVmQVQpY6VVrntwmR/E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dIm2TLMgso0CxBTheDHptauyoD8Jr+blcgQ/8DY2E20M6PplFyMSXUolCzDUFRLHvgTp9rL4nkdrMZp+ZZwNR8CrkzxcezMHkiFXLS7bLBGbL5VRz+Kr8F9M3Gf0LnX1+lW1atYn8GtojVRectI9W8qccDorqH2jWb7zElRf6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiXqDnq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175DCC4CEC3;
	Fri, 11 Oct 2024 23:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728689102;
	bh=Xzdolzf/rqA7wvxWxEDW8tmVEVmQVQpY6VVrntwmR/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aiXqDnq3ncI7GLm6h/KB0uTLfg+UBgb2LAYciRgCID+3DSapHaF22MYy8L5wGGKzT
	 Y8wnNi54ry1eIWz6EnOqGVbUiEAyKg3hJKT5HqbjClZUqRiV3UL3VQjJy1pvzE9W7a
	 B0c0pauoU7pxChJ1GAWQjYpRI88M/U4MV83E3JmvSeOikjGJy8N9K8ww7RPcHOhwFZ
	 WEWUi5xgoH6vchWllmlxSvq3ozv5AYxsjgwHxLku9qC8Zi8sA7yPMNRiSl+UOrgn0z
	 6ephlgz+458EMaWbMH99brZ5I5/2qK/6vf2A5HY+9YWrgU5pz2ZltZlI2sw3uKF3dm
	 saUdl0y+eUEXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0FA38363CB;
	Fri, 11 Oct 2024 23:25:07 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <90ce8994-3963-4e19-8e3a-1f21f3136de7@linuxfoundation.org>
References: <90ce8994-3963-4e19-8e3a-1f21f3136de7@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <90ce8994-3963-4e19-8e3a-1f21f3136de7@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc3
X-PR-Tracked-Commit-Id: 4ee5ca9a29384fcf3f18232fdf8474166dea8dca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09f6b0c8904bfaa1e0601bc102e1b6aa6de8c98f
Message-Id: <172868910640.3026331.921801182725820824.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 23:25:06 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 16:09:09 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09f6b0c8904bfaa1e0601bc102e1b6aa6de8c98f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

