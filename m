Return-Path: <linux-kselftest+bounces-44473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A086C23123
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2AF3A515F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 02:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AC30B50D;
	Fri, 31 Oct 2025 02:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnqIe2Yu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7114A8B;
	Fri, 31 Oct 2025 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879127; cv=none; b=MsdtfP+sFO2yo8PvcdjuSqFPLGZrSA6h7K+ZlARuGyRUPLiHscJrJIt+I91TSiXga4dgsctwdzhPlgo3cwCIRS7aeti/2ZXsz15X0GjJDvOAMXlii93leTOpVnSztJw5+6ST+iGp1Z3Pxet0iP4B7OGwWlqOS1z8fO9lBHhcX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879127; c=relaxed/simple;
	bh=lAzko19TNTJ1DFAs9YN75f3vihiFcTEUS8K3/JjRXLY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dbON49LLQSgKC9gLxJ0SyFM5Nb1wrbSOiQJdawe5IMOInk61YvanF6PMG6BCBFXw1Pi62vk9XILU2yiklA0XmuMg8bPZynSw919/ZwhG8sKol69FbcoxVkWe9MhFhcREBOIUkjzyL7ehe3AWC9ialwgUtl4x2V22Xta8ZChyOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnqIe2Yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D77C4CEFD;
	Fri, 31 Oct 2025 02:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761879126;
	bh=lAzko19TNTJ1DFAs9YN75f3vihiFcTEUS8K3/JjRXLY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pnqIe2YuRjYizXhdCWFGa3IvW68thfFZDG2wmnUKmN7uVPYxaQK0sfAUVbXJsWnMR
	 KimFvV6SvpclYnSAp9JcJPvYmgAWv0+ZPvw6QrwkOZOTwxPNULR74vjZRjP6Pz0GO1
	 rrDAtEjBZUbfgKuPxTvXXm4ejRQp2309X8rg3bF3y9TKrgDUPnJkB39H5AmqegHXiR
	 OqcmLUclt/cBpVDI9ZRZGnSw8JVRpGzUWet3X0IOL9gaMDUS63vRSXOqT+2IViafxu
	 9gj0zI3yVkUxgvr74NCtgQeF6GHPUJLZk8EA3AJQn4WLGcrXVMWdC8Gz0sWfEnA3yL
	 o3jDAnkFFGb2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FDF3A78A76;
	Fri, 31 Oct 2025 02:51:44 +0000 (UTC)
Subject: Re: [GIT PULL] kunit fixes update for Linux 6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <b5aa8141-b80d-487b-b3e9-fea244e69ca8@linuxfoundation.org>
References: <b5aa8141-b80d-487b-b3e9-fea244e69ca8@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <b5aa8141-b80d-487b-b3e9-fea244e69ca8@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.18-rc4
X-PR-Tracked-Commit-Id: f3903ec76ae6afcdba0347681d1dda005fb145cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1806838686ef74cde74e590d13984dec7c0233d6
Message-Id: <176187910308.4119220.2839102668033968435.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 02:51:43 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, raemoar63@gmail.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Oct 2025 14:23:27 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1806838686ef74cde74e590d13984dec7c0233d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

