Return-Path: <linux-kselftest+bounces-10118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5ED8C3853
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2024 22:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65EF8B20D38
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2024 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA6F53E22;
	Sun, 12 May 2024 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dajm0p5b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729E2F52;
	Sun, 12 May 2024 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715544679; cv=none; b=ocUbTLMHo5uXhN5VBu9uMWD16IQubsJli4Lo8tTHjj7tavpDWsci7q2TXN+EUL5svhNJawYSJgpy6IZHTrJ9v3fauKqrYd9HeEOhqtVl2mJOeiEsNm9+65F7kMv5UUEfxvGksdN1bUnBgdBlkC/spbn4d4D4AlYWNpRV6pOR1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715544679; c=relaxed/simple;
	bh=WxFuKPriljJ3Xa85qH6iujL69qp832395i4t0PU3Sjg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hMtiFpbdl+wnp3lPrjGpY80dTwr26NrYoEHKw4BiZ4gFOYU2T8W5NYM835M/utZGNcNwlDJq86wnI/3tSK8rDg9jKebzy7RMgUPaCNiFzlL8l541EACzpxZWrREAjVxOowLNK6oHwqgB2/NCv67fVVIbck/ruMckyeOX+mt0NDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dajm0p5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32E64C116B1;
	Sun, 12 May 2024 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715544679;
	bh=WxFuKPriljJ3Xa85qH6iujL69qp832395i4t0PU3Sjg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dajm0p5byqeAp6X2BJydLicltnqwT8xPowWWTEe2wryhwQwmpPvFkNJzhWCtOnBSQ
	 xRKkBP30rlRwdF3/TA+dGw6KcDDKccEXuPa+z0IH5Ep01Hx8PRZM2MI4bUnS6uEMA0
	 kUkHwt2OsPxArgtuIGU+9ey6TCZnv3B+W8gXQrN4FBGSrbZR8MeMxsvHwY6xAwsDAM
	 +AZLBuzEuNn0RPxnCI1KUAGoUB+OV71lfzgDQZ3uTt6tp4vUXcCZzq2mjef/yw/Hgw
	 DufQyFnP9hkvpJNKvLz76Pq5nhk2bbv3RlnIGU616w8F3n2RtwFQlHBjMH5P+MfpXl
	 i8g2mArLzRuIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24791E7C0E2;
	Sun, 12 May 2024 20:11:19 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240512105657.931466-1-mic@digikod.net>
References: <20240512105657.931466-1-mic@digikod.net>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240512105657.931466-1-mic@digikod.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/kselftest-fix-vfork-2024-05-12
X-PR-Tracked-Commit-Id: 323feb3bdb67649bfa5614eb24ec9cb92a60cf33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af300a3959290b005f27ab5858bfebcb4840cd66
Message-Id: <171554467912.30874.14448790672055631894.pr-tracker-bot@kernel.org>
Date: Sun, 12 May 2024 20:11:19 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>,
	Ron Economos <re@w6rz.net>, Ronald Warsow <rwarsow@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vge.smtp.subspace.kernel.org,
	r.kernel.org@web.codeaurora.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 May 2024 12:56:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/kselftest-fix-vfork-2024-05-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af300a3959290b005f27ab5858bfebcb4840cd66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

