Return-Path: <linux-kselftest+bounces-14819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3B3948563
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 00:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E1CB20F83
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6906316CD11;
	Mon,  5 Aug 2024 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMlOMPrB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAF14A096;
	Mon,  5 Aug 2024 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722896190; cv=none; b=idxPNC4/CNd8xN6LK1xVRyAHWkNpcUkVz1n7pAmO1YM7vmzYqNJ53gh4CX+rSkvHLZr+bYOrjuSg40H6rq5GBSKkOTH6srkXTBk9Htv6uB+GjjbA0sDJv+ImsMYPNT315mSjR8OSzS34RaR/OwLwKTeDewiLSRsliQYmqRsPB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722896190; c=relaxed/simple;
	bh=6W6iYCEn001pXoQzwdzr3s8i/AVPGVwvB6XwOInfOqk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JeVVO4IG17j2WYMRS0aXbphWtdwYpO8/T3VrWeSYSSSE+jhT8w5935vDqV+okZDIBQ2jdIB6MxZEiZXUB3/Bq2FAe44EdQ/RESr6bTzWJjbEb9a9usDZomglJwTJu9J4qj+nADceLGBo4GA/XsXM9huYZV2afpzPGCj+WlI7gyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMlOMPrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D78FAC32782;
	Mon,  5 Aug 2024 22:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722896183;
	bh=6W6iYCEn001pXoQzwdzr3s8i/AVPGVwvB6XwOInfOqk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RMlOMPrB7YZnrhZK92gCqbTHooFgHZocAn0xPur6xjvIBMXOMVr5lpIO1H+DEZL5b
	 rIy8h9rCOjR643FguV8Zx97EdfRPqby3jVOApPsMqt5sD2lvE1NRpBitOyyBwMZKv/
	 OSJd/7g5B/D2AfyJ4TQJT2tq8gwSfD3T5i8WC+L5sJsUFIAzfh3suvJ0QAX8pNfbkB
	 +nlEgugwwlIvyKWp1s/Gk/Tt6z31lLoOpBHXikrj8KxqO1FXlogsZN39gLvQMD84Gz
	 EtEykpXAOcwJvj/Ecv5M4BdOH7Bocqr+KOtDcuSq4zu63tk/58EFac+PdMxaWjPKhd
	 lAUmZxTrr/lOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5B23C43337;
	Mon,  5 Aug 2024 22:16:23 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <732e15a1-f219-45b1-8836-ebd5ca3101cf@linuxfoundation.org>
References: <732e15a1-f219-45b1-8836-ebd5ca3101cf@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <732e15a1-f219-45b1-8836-ebd5ca3101cf@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.11-rc3
X-PR-Tracked-Commit-Id: 170c966cbe274e664288cfc12ee919d5e706dc50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b446a2dae984fa5bd56dd7c3a02a426f87e05813
Message-Id: <172289618350.20360.2521473458956241309.pr-tracker-bot@kernel.org>
Date: Mon, 05 Aug 2024 22:16:23 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 5 Aug 2024 15:08:10 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b446a2dae984fa5bd56dd7c3a02a426f87e05813

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

