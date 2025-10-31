Return-Path: <linux-kselftest+bounces-44474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802EC23135
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2963A9E3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 02:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8730FC39;
	Fri, 31 Oct 2025 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWqGixa7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A630F818;
	Fri, 31 Oct 2025 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879132; cv=none; b=XUvJ6j4VFj/oPTlceV48bRStzD4KokBAbjEfMazI4Q/Y/2Qxkit3TdJ7j7vDlqgec7yEZc2KiHaV1h5NbUeGSo6qYVxnRt6AnDq3gWeZKwLbMJCy8F+1jfajnXfI1XB3awiwYEkk4HAcjVhAPKpAEhETUgyrQxVPfZccHQfEWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879132; c=relaxed/simple;
	bh=AZ0ULZSgpM3MyH3fz9XzomWgerUOBAoxhPgYeVK+2ss=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZmbEWHaNlsN+IWiyTijEJ/ipUTmOWe+DPGG5luNsWxHFGEQa2y3ZKF0RgG4v6ZwUoWs1tq20/3iZiSJeFerHB6C72Wkkin81din7068N90NDssRD4AQBykPEak5zHebytjfN4dhbv/onYaUSAp6sw4ICP72oRdIHtdYqYHpM0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWqGixa7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46557C4CEF1;
	Fri, 31 Oct 2025 02:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761879128;
	bh=AZ0ULZSgpM3MyH3fz9XzomWgerUOBAoxhPgYeVK+2ss=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YWqGixa7iKDrFfjKKlJh7JO4FPrz+itMRvvwcq8pE9uIc0FM2MBGonaeMhpfsnEgd
	 T7CzZgtCzb44eSnGP2X6NLs/eB7cNYs44U7Ft3wotcP1XB39uDCrTTwzHYBQzUXh+G
	 YMfgPVWDAk2W8F2Nit7afAeEeywiH1a0yaT7fW/4TRHL/jeFnQ0oa5oFGx8BodrdJD
	 c093RkfyqqiwNmFe25vNqM7HG+a7TxJbkRy4/RAz37k3z632Bz+6QkPGZBrh1we7ZU
	 e7r25fcLqH7CrMSOclhDPeaH+UODKIBKDUmp9mOYdq0FSJ+GD9Dqhk6caVqKIIu/A6
	 eRJ+lCt4Telbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECA3A78A76;
	Fri, 31 Oct 2025 02:51:45 +0000 (UTC)
Subject: Re: [GIT PULL] kselftest fixes update for Linux 6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <d721dc87-5021-4404-af2d-d44489dbe249@linuxfoundation.org>
References: <d721dc87-5021-4404-af2d-d44489dbe249@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <d721dc87-5021-4404-af2d-d44489dbe249@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.18-rc4
X-PR-Tracked-Commit-Id: 920aa3a7705a061cb3004572d8b7932b54463dbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d127176862a93c4b3216bda533d2bee170af5e71
Message-Id: <176187910454.4119220.1842101487197035066.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 02:51:44 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Oct 2025 14:41:08 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d127176862a93c4b3216bda533d2bee170af5e71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

