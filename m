Return-Path: <linux-kselftest+bounces-18079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02097B1C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 17:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9361C22848
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA4197531;
	Tue, 17 Sep 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDqODFE4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC873196D90;
	Tue, 17 Sep 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585211; cv=none; b=UxuxirYh0mZhb7DC5+yzveAGP2xK0RG/PWQ3xmcrKo+d0fuyRgRMmAKqdRpZ7/6s9kYGfw6kj07FVZpT0krxxndwHOChAciwXtO4W57gPqPgGw7PSS41V3EIcPaSuRpdkcSIjzsaH3phHh1J9uW+i4qaNd9xDhsSMWwrAN8d2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585211; c=relaxed/simple;
	bh=YaxADWUv+InYe4vS7lQY/3IlqlOm46pOkX7forOHb3E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GiK3JDG5ZsVe/8WSfcn+qYtzCe6Xs0gHpe3tylnJA9xw4a+NYSzosLtU9fUmYLhK0+9pyrzli/xP/KFU2EUH1KshsjpckCjoapPXUVPvVNjx9qq+KHx4Jn7+spEucdJp/0LaN2fRVnzWqBNwFPTpdJylltKFA77G9nRdt9NQMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDqODFE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899C4C4CEC7;
	Tue, 17 Sep 2024 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726585211;
	bh=YaxADWUv+InYe4vS7lQY/3IlqlOm46pOkX7forOHb3E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QDqODFE4NdFM13xRy4tQ0Fjk3m0ckntAt87SoEipAoxHNJ7ILS5t93wx0f/z8qbKZ
	 +6GwZggNGF1IzpOFoyX42f+cDenhog+76xvpG0Tw187Ao3hutZmGU1KPF0aur7TfMb
	 yUPBAX0zn+c6R+R4QkUTjJu9kcsSboeeRMNZRe2vIa5u+sFT9oM85aTwPeZk+YwnVO
	 HPBCv+ZDo4/j7wAgwHKnjBLs/QArPbDVLnilz6q9WVcYjk142ACjYu4gMOEtobaUli
	 SfLQa51rgitnJ7xWsyUbGd302P9akAuAmC/5Q37uH053GyIGXwxJI2UbKAbBHfA+v4
	 hx2kbAB8nXjpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 81C363809A81;
	Tue, 17 Sep 2024 15:00:14 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <fec42732-fc6b-4025-8326-38cb8157057c@linuxfoundation.org>
References: <fec42732-fc6b-4025-8326-38cb8157057c@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <fec42732-fc6b-4025-8326-38cb8157057c@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.12-rc1
X-PR-Tracked-Commit-Id: 7fcc9b53216cd87f73cc6dbb404220350ddc93b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 194fcd20ebccbc34bba80d7d9b203920087bb01d
Message-Id: <172658521328.168423.15354061886165730557.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 15:00:13 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 19:43:05 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/194fcd20ebccbc34bba80d7d9b203920087bb01d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

