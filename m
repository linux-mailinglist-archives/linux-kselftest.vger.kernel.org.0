Return-Path: <linux-kselftest+bounces-2786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48F829227
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 02:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C80D1F27018
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 01:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA401375;
	Wed, 10 Jan 2024 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZYW/KMR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46317F0;
	Wed, 10 Jan 2024 01:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEF3BC43390;
	Wed, 10 Jan 2024 01:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704850257;
	bh=Nz/RwDIspbayxxCvKSQOr2PUXv1jga7GE4x30Kr92Vs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QZYW/KMRVw8dW58aPH4wtnjcVypPEpeqAw1zPzy4ah/2fTprIt9JgDgV/q52djOXK
	 9YqRDvh4XCN0Dv5HiSvBS3giKzx3xFbY6AUr/XWNA8tbF8JAyRNJrfl38evfytqlAk
	 HFy6Ie+t8ZALMaHW+OP2R/yZvuP2sz7gRfYJWDBSiYftFaX8GXRn8zpD0NkwSJ62JW
	 jo96NtNifyi9L6XtEPfXfhbYS4wLs83KiPX/7wpa6o8f9IN3fMltcaj8Yq0vjyZh0E
	 qLllwQ7D2V1y8ThBjZSJCQ8HV6AEHDIPLrpWDbPlGvKf+g6dUlp7/mDIfu4eVnmiXU
	 tZ4n2x0WixjTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC411DFC690;
	Wed, 10 Jan 2024 01:30:56 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit next update for Linux 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ec8e9234-fcda-4573-96de-ebec9586670b@linuxfoundation.org>
References: <ec8e9234-fcda-4573-96de-ebec9586670b@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <ec8e9234-fcda-4573-96de-ebec9586670b@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.8-rc1
X-PR-Tracked-Commit-Id: 539e582a375dedee95a4fa9ca3f37cdb25c441ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41daf06ea14fdccb34224fbcc5c4f2a6d17814e2
Message-Id: <170485025683.7649.15464286985033463181.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 01:30:56 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Jan 2024 11:37:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41daf06ea14fdccb34224fbcc5c4f2a6d17814e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

