Return-Path: <linux-kselftest+bounces-42665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46330BB27C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 06:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C983236B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 04:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C372C17A1;
	Thu,  2 Oct 2025 04:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubNgZc3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8A285043;
	Thu,  2 Oct 2025 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759380415; cv=none; b=ogaIu/Zpn9pXVT++p1u/MML0vn6hpu2YRZ03mKYLuyjpdKQzbr5Kn15qPr8Gf2f0Ro4QDkqAE1bfw3R3Wi6XFkq9VS0YE647E7Dpf2p20TGC0A8vGp1SLUtvhBGifvTujkPT9ruiU2pxpvBfsUghKmZwgKwB12Lz/I6TIwe+2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759380415; c=relaxed/simple;
	bh=YhNSxuyVuIajgL+nOZSrfAS4SZtkcjgniBBQZTsTktQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DQ7LDoF5ppi/6RqXslNWlUkjX+iVFxsy20yYlMfYhD8S2Xy9y0dnJzWU2htbpj4RK9AD3F01f3t88q4g9W2IO1JbFx7sOeCwP1mxOvrIbKLam1//55JdYFmGqs0o2DPE5/Gu+twVRtfsLR/pnF18NU9bSYoSuQLmVgFhtTBjmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubNgZc3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B727CC4CEFA;
	Thu,  2 Oct 2025 04:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759380415;
	bh=YhNSxuyVuIajgL+nOZSrfAS4SZtkcjgniBBQZTsTktQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ubNgZc3f2KmY5NGNjFSm+AG8U9aWwUB+nTKpvFKSzc9alLxgP4Zj2iOMU2mwNSzbF
	 SWrMoghx+8Klygy5oCMzUeU1A6agBzwfO3ZpSTJ6u05RTkLlsSltAksNDYZ1CqMMhX
	 Y0JK9iN5FKM2U5bfK1Ty9nfVGFndvZFD9NWddlMBgvT87OGj/eU1089FpH+ikY6Kem
	 ouldoI2o0y/sbQExeNmGxPEii+u5XeAaXnFClDG2tNmRg7NhXG+5mJveWm9KJRCycx
	 eI85XFZ7+htWZd/ak9rXU4336lOIJ8G2LI2yoNDI2fM6Mia7ljw0lFkHUTQ+1K99vX
	 503wOzwZa2BCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6539D0C1A;
	Thu,  2 Oct 2025 04:46:49 +0000 (UTC)
Subject: Re: [GIT PULL] kselftest next update for Linux 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <faf206d8-ccd8-48b5-8e7e-d596ddbbcbb6@linuxfoundation.org>
References: <faf206d8-ccd8-48b5-8e7e-d596ddbbcbb6@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <faf206d8-ccd8-48b5-8e7e-d596ddbbcbb6@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.18-rc1
X-PR-Tracked-Commit-Id: 19692013415486febf71343f5cc539a343a2994b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0f53f0d2e761e780608cf72737f93bc75539da4
Message-Id: <175938040781.2758529.2046319963557973929.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 04:46:47 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 17:07:02 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0f53f0d2e761e780608cf72737f93bc75539da4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

