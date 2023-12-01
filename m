Return-Path: <linux-kselftest+bounces-933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C5800302
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34318B20E27
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 05:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5868747E;
	Fri,  1 Dec 2023 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDbYrWz7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885435666
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Dec 2023 05:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04C81C433C9;
	Fri,  1 Dec 2023 05:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701408516;
	bh=vzhtAJwMVYRIQx4OHRIKuU8rIYXOIdBLH8Ej4oeUtao=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qDbYrWz7iCa0OzQAxGYS16GMRwSFy5B3mALNUrksV9SohP5wwYUxOk3oV7EMqh0Jq
	 hFh3ONl9NXdZtLFSGSlX7OwNAG7aqCqwG1ZUUfKyUhPgjhANNxdbxBqByOyBoswdnZ
	 QcuzkkCtY+R0YEHmo+1QGw0nB9zZVkztVhg+tQTsa1+o4B4Y7Vio+G4sgPQNlMbOgB
	 JvWRNq8yd2hET7B5g5kKPcSE7FpmFu58WvbsiUaN1jJd30s5+QGEbLAbxYATicy+61
	 QGWk/yPz0/QrsBkn3aBNC30wvDL2B2nVxY0LfToF7GZOZHsN10NsQFUPspr7Tydt8Y
	 YQDWPmwfbbCrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5A60C4166E;
	Fri,  1 Dec 2023 05:28:35 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <c26192e6-df1e-450a-ac2d-e18fc0d77fe9@linuxfoundation.org>
References: <c26192e6-df1e-450a-ac2d-e18fc0d77fe9@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <c26192e6-df1e-450a-ac2d-e18fc0d77fe9@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.7-rc4
X-PR-Tracked-Commit-Id: 1bddcf77ce6668692fc15e968fd0870d5524d112
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47669f40b14c32c9771e0852f7cd3a12eb044c2f
Message-Id: <170140851593.12146.5450133622067567233.pr-tracker-bot@kernel.org>
Date: Fri, 01 Dec 2023 05:28:35 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Nov 2023 09:58:39 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47669f40b14c32c9771e0852f7cd3a12eb044c2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

