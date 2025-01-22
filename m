Return-Path: <linux-kselftest+bounces-24970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3066A199EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 21:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4873A995C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E18215F7F;
	Wed, 22 Jan 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnfnISnA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3841C5F12;
	Wed, 22 Jan 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737578293; cv=none; b=AFAsvOgdIbtYsK/FfbFrLxhlFUxXkhsAp7JYbsh65r2A13JfvZ6mTNp7Q2l3B2MC8e68mvzTevGkqakmMNMUKpZSqaLuV2E25mJg5gUqX4xbs9Z2Bkj1lE11qUqhUphqCTMXAxvwv5OLoIoO9sQaEKRiXdjmihC7izFbJhMz/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737578293; c=relaxed/simple;
	bh=J7vxtZ800oyIFktjl7uxiyWChHJyiicnsPSNYiTQJsA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TNvK46ExLZlebxt9PyVeJzLXblXGhE1IRGuhJMaHip1JVNPYUhTyvUHTVcni2yHDNMb4WH+a6dkXwctd6pQFhnVE4+kqmHsrDcVzi+x08F5Hfy0kXdGnel3/TYWOtBzUYxNkBgGo+XRofcRcqPE4AQTxiu7+kxWWOSLwpDyQkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnfnISnA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C75C4CED2;
	Wed, 22 Jan 2025 20:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737578293;
	bh=J7vxtZ800oyIFktjl7uxiyWChHJyiicnsPSNYiTQJsA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lnfnISnARJZ6P1uP3fP8PP8/fAtc54YnBSWueh4aQ+t5DoyAOollY9Ol+RQYcuTNw
	 OUzzZrg0/H7dcrFS3KIbQm+wRRFLUJiPuKI3euXIleO+etGk210re5uV8oDz6UmUQ4
	 ga45UWEbaUdenVB1KYLu23B7HCoM8KpfnZr5IpcyjsINWoHb0N3Pk+vzEdJMLPzhEz
	 w0Da4jVucjh2RxdvRHtPDLgFLbb6kBFniuhivezpN7EIaYAMggHzw45HgMJYiIEWSe
	 1A+WLezDnwLZxmwdAMAzvbrN43hgj9pMR35IK3XFu4dsoBrCmeO8uFnw9OM1iIrtKr
	 a1ADbvqz+dlAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD30380AA62;
	Wed, 22 Jan 2025 20:38:38 +0000 (UTC)
Subject: Re: [GIT PULL] kunit next update for Linux 6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <70eb3d1b-6f91-48da-8854-21f25bd3f289@linuxfoundation.org>
References: <70eb3d1b-6f91-48da-8854-21f25bd3f289@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <70eb3d1b-6f91-48da-8854-21f25bd3f289@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.14-rc1
X-PR-Tracked-Commit-Id: 31691914c392675bdc65d1e72dd8d129a1f0014f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8f17cb6f5abd4e52e89b5768c7016b7dab1e6fe
Message-Id: <173757831724.811340.13712237212851639290.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 20:38:37 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, sfr@canb.auug.org.au, gregkh@linuxfoundation.org, skhan@linuxfoundation.org, shuah@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, brendan.higgins@linux.dev, davidgow@google.com
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 Jan 2025 14:16:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8f17cb6f5abd4e52e89b5768c7016b7dab1e6fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

