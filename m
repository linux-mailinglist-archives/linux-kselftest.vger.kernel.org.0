Return-Path: <linux-kselftest+bounces-10190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60678C5B3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 20:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DAD283A13
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618CC18130A;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxsZuE4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7553E15;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712117; cv=none; b=nKFu2V4rMbkb5QZTFQxTIACaTOpCbfdnHXqr+MtjM7RJCDQY/55U30ny+ZazIfmJVnz6pePhu2Uc2htE2KGIYMawBkgaqR8Bm2mi/jyN1z4dwNuYAwXQt+Dzd68+ikRk3X/UBn0PsBkBXNl30wpiWXuO/r1fCS65Zy7SuHvBhM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712117; c=relaxed/simple;
	bh=GKiUqFBOx+LeaZkD6voDe2LlZovQKn01MVI+n6ogXmA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NX4Z/Sfh1LxEG7jQav7AdgvJIHCX7AJO2rwmHNJnre10mW3joSSzwXTqNGny8XIkX1dyRyyXCCTpkG9/FmzSMfzsAVfZyvCgwl7R+MYYSY6UjJjcgZ/yhV45Td9lUlbgYAaiqmxuU/OQie8e65BRanZ9gUkudNhqoW+8DSHUHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxsZuE4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 155AEC2BD10;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715712117;
	bh=GKiUqFBOx+LeaZkD6voDe2LlZovQKn01MVI+n6ogXmA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GxsZuE4tZyasfiF89t/CT4EiRwl2YEDovp9mzxo6HHDLtZJ9VIy1WWzyxp1gx8TYG
	 iIfD8vNI+at/pjIt5p78UkMSn8ge9PLC1p3D0NTq1kbgtI/c7yzzgfa3QhsYGl8hji
	 t89q6AJBpJXLUAMOY2e/cOYDD5Abz8H7gR+WHCn+mVeV3BFrpODZsowmo5r2rqePm8
	 Fv+Mzqymz2xT5nHPCsLzI3upO3acgzVx3uxsGVzgnuf+Fe4qJiwTyy8Ugw2fqK1Rgm
	 RJ/8MZWZFoXPxVZH0SJgf4Mu4K/DKUs53vv1INzcW6hDV+ykdmENtZ3g3J72PU9QsF
	 sJHvzO/Rg3rvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DCF0C43339;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for Linux 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ddb23594-c519-4436-9219-e2f76f8c38b2@linuxfoundation.org>
References: <ddb23594-c519-4436-9219-e2f76f8c38b2@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <ddb23594-c519-4436-9219-e2f76f8c38b2@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-nolibc-6.10-rc1
X-PR-Tracked-Commit-Id: 0adab2b6b7336fb6ee3c6456a432dad3b1d25647
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b768bf062db22e042a731e4c385bb0b4fa21a0e
Message-Id: <171571211704.4202.16816500327538975010.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 18:41:57 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, "Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 09:13:47 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-nolibc-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b768bf062db22e042a731e4c385bb0b4fa21a0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

