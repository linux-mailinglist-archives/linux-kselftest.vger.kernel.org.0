Return-Path: <linux-kselftest+bounces-13207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D68B927DDD
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 21:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB245B21654
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 19:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B5B1369B0;
	Thu,  4 Jul 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moLC8QlR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3E4CB28;
	Thu,  4 Jul 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121815; cv=none; b=H33OohxdsvlaGvZr2RWnKdI1R5FwM/w5I6NTs2ecRjKlxXsEEZNKxVnn3EWg2QRYqhEnU6BfgH5/0hu4bXl6+hoMaGoX/dcM7XOohY5OQLvMycYzysrnVtfgfCUR/aGGEcIfuq8MgSYLsuckdSHkRHyVEfuikjsA62lXzUswZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121815; c=relaxed/simple;
	bh=TatNQtxn5JyqmX3Ox0iKpM8SH6exsf48BoqyvDPWe5g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rIvaSFiJME3V1MQrhMlRIj5otkH/ZCE3oi+p3kSonGhcrhh89KSkqBRFEFWBRB1k+X8hOVPFGy0tVdrIeLVZ/1/d3xgVYONTndm79nMYj0muq5q+6LorFxLtz4amormbW4qErxjkskguEDsRVtTJZPYqFUJOng0gtAG6wJuBgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moLC8QlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A96FFC3277B;
	Thu,  4 Jul 2024 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720121814;
	bh=TatNQtxn5JyqmX3Ox0iKpM8SH6exsf48BoqyvDPWe5g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=moLC8QlRspJNwkVtBnauz0eSgdNHwCs2eGOFqJC8kcWQZSWm8i3sQqpnWkjxwwWpq
	 YwUV2/E3tEJBwh0OAzdq3WY5Ij9+Xukjg7MZAvORJUkxT1jSoaL4RYDH+nhQM3P7Vs
	 dk3URQpqelgHpgkbweTCKgPIVvSi9LZNI76JvDqPKHveJHdVhOCWzY0KpTpEdhxwgK
	 TmQZc8KZITgGA/Npr81QTBMltMrtn71E6VvYZBSage0vWTAz7yD2B+zne9PyFGS0zB
	 DS/9I7WY8q5QlUr5DcGlWWdlS4o41e2SG/NLZ0Qwpeh3UGEoBDE00EoEH595riZtmX
	 0wiEtnNlYe5DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98BE5C433A2;
	Thu,  4 Jul 2024 19:36:54 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240704123816.669022-1-mic@digikod.net>
References: <20240704123816.669022-1-mic@digikod.net>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240704123816.669022-1-mic@digikod.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/kselftest-fix-2024-07-04
X-PR-Tracked-Commit-Id: 130e42806773013e9cf32d211922c935ae2df86c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d85acef10252c59e3b6c197c61d9252ff950431
Message-Id: <172012181461.16688.4465728826585876343.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jul 2024 19:36:54 +0000
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Brendan Higgins <brendanhiggins@google.com>, Christian Brauner <brauner@kernel.org>, David Gow <davidgow@google.com>, "David S . Miller" <davem@davemloft.net>, Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Jon Hunter <jonathanh@nvidia.com>, Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, Ron Economos <re@w6rz.net>, Ronald Warsow <rwarsow@gmx.de>, Sasha Levin <sashal@kernel.org>, Sean Christopherson <seanjc@google.com>, Shengyu Li <shengyu.li.evgeny@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Will Drewry <wad@chromiu
 m.org>, kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-um@lists.infradead.org, netdev@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  4 Jul 2024 14:38:16 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/kselftest-fix-2024-07-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d85acef10252c59e3b6c197c61d9252ff950431

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

