Return-Path: <linux-kselftest+bounces-17437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DE96FED6
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 03:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F6F285D70
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 01:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386C2CAB;
	Sat,  7 Sep 2024 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkE/PzlZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B164A923;
	Sat,  7 Sep 2024 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725671353; cv=none; b=nkXB5B9QTlYF6zq7/SmoaUpU4DTmJ/+0m5scoPl66N3cwzsoVBD65GDoj9yv2uqn0aJ/ZLUMTiw3+Fp5u+Es2HHDCO54OOTlJQmBT7RkfcSGzUO4vvAudrrYFPezFOLIDoJLNJlb45XgqUqGzRofkDzmwi5Ml6LCYfwZ7TzqLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725671353; c=relaxed/simple;
	bh=0LgNh+bb22VEH8GBDdZ74Ng8ApiqcQzXbWqJ8cv/LEw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ntb/tCn85nkLTtJFnu99NQm+bOI7eDRmsuokCroiWUWN1PHDB7bSPIZkD4QNpLvBGwuSd2Gb7Fw1PUasV1AIvhEGmK7GaviCwaZXbZFbD7/gPd+RH6kk7OGVV8vbbL2VOhl7WNAlXcBRuhi5RlBYbuhFoYtXdpYVxMkXElZH9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkE/PzlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191F2C4CEC4;
	Sat,  7 Sep 2024 01:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725671353;
	bh=0LgNh+bb22VEH8GBDdZ74Ng8ApiqcQzXbWqJ8cv/LEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TkE/PzlZklyIEVN0WsYJLZX41yzEwGdKzPD/244TxshMlU88pLm/60M3O6500Mg6e
	 D6Q6WoN9D8GBIOHaA+IA2HKSK64t9PWKijeAb11TKXiU0oUM7L7JOzrOG8H8aPovYn
	 vDe0YCfV5BsH8ONHwnR0xXImbGtSaagDFUruVlYNSrsTRS/j8g6yR7U07Rf4W+kLX3
	 txjAlD2Tu2aqUc9TjFnIF4r0gl0SZKMRzWVmVELMkRsCvMYh3HNv5eS11iZQ2M72sZ
	 BlXT7n/mu5dNOLsNSArnqfswHahrWjEsWTqMEEJv4XRWjjRm30m3rnEj3fqamLzlYq
	 /+YjaI/qKq6qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D6D3805D82;
	Sat,  7 Sep 2024 01:09:15 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes second update for Linux 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <27a3fc9b-436d-43f2-a8ff-b2d68922009b@linuxfoundation.org>
References: <27a3fc9b-436d-43f2-a8ff-b2d68922009b@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <27a3fc9b-436d-43f2-a8ff-b2d68922009b@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.11-rc7-2
X-PR-Tracked-Commit-Id: 12cb32a52eb607dc4d0e45fe6f4cf946d08da0fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b31c4492884252a8360f312a0ac2049349ddf603
Message-Id: <172567135371.2572367.2163800521578538947.pr-tracker-bot@kernel.org>
Date: Sat, 07 Sep 2024 01:09:13 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 6 Sep 2024 14:46:31 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.11-rc7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b31c4492884252a8360f312a0ac2049349ddf603

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

