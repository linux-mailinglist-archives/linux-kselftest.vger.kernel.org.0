Return-Path: <linux-kselftest+bounces-19083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A116991386
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 02:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF79283E58
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D055231C95;
	Sat,  5 Oct 2024 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW8F7rNR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9838231C94;
	Sat,  5 Oct 2024 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728088418; cv=none; b=JRM7BI2LmFUtSo7DAdUe+9IA9s/OPcRrMB+l08MMQMd2uIckqeg5c4AUNIbNBGHNF8rEOE+irA0HICNUx+myQlXBLwZXobjM0RY/VSfZwrYg0hvDc1XS5FFgD/ZYzAm7/Wa9woC1ydA8KzfuoZpN1cAHwI33d83OdIAeXJILUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728088418; c=relaxed/simple;
	bh=mxqufkjAIMdYste2sLaOPaow7LjOOcdaJF9+nFMaxWk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cfAVIWCPJV0PWnIkMOCwqNfKwdHQ1DdsaQTKHXmGfnfJ0GYHVjm9O9rbptPypm3O+Z9cOgoL+aH1U7rBsvNvj0lygviagE8YmTVRgRUOj/T4Vng22ibwcdMxAeG7XazNwLypeWpEeZHhwntXxjYDTeobDUU5/Q7hRzkrxwgmG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW8F7rNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9855AC4CEC6;
	Sat,  5 Oct 2024 00:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728088417;
	bh=mxqufkjAIMdYste2sLaOPaow7LjOOcdaJF9+nFMaxWk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uW8F7rNRYmjGer8CnMHZt6zPLG/SFC620RJNTk/ziq15GJWby5XCvwLF/tNH0Ni7S
	 V8ahjvZDWZ6mMXPWJKkYsBZzgzV4N/jTDVinZEnrlCPtzwOg75aMpdEqQfROAGMij8
	 Jcv9u0p1RD6v92otBbSWk8idugsAn/7XklAUT3fPoV5HFPn1h8TRQqCT4pueGh09mq
	 9g+o9+zJhgxue+BWg7WLStshD9rJPv5VAmZKmOR8cDGJ/iQ6DLuWRr6pmFNeRPx61l
	 19lhPt6EBcAiP6DDdQ4b3qlfE7oVKEHyDdA/gtltrmK2Y9P6QS/HT5OV09TuIP19/W
	 Ri/v0xHLc9u1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719F43804C88;
	Sat,  5 Oct 2024 00:33:42 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <2d95ac4d-e239-49ba-ad72-368284a3ae25@linuxfoundation.org>
References: <2d95ac4d-e239-49ba-ad72-368284a3ae25@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <2d95ac4d-e239-49ba-ad72-368284a3ae25@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc2
X-PR-Tracked-Commit-Id: c66be905cda24fb782b91053b196bd2e966f95b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27cc6fdf720183dce1dbd293483ec5a9cb6b595e
Message-Id: <172808842090.2812699.5881909665936970435.pr-tracker-bot@kernel.org>
Date: Sat, 05 Oct 2024 00:33:40 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 10:44:57 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27cc6fdf720183dce1dbd293483ec5a9cb6b595e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

