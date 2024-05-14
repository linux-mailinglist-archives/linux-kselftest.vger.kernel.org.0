Return-Path: <linux-kselftest+bounces-10191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3370B8C5B3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A7EB22C1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA2181313;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ7U+pBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825E181307;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712117; cv=none; b=p5SE4p7rzlPy+tGZ4K3Ty8/PVjbnu/pTxENYza9WXkjQx+4cwLF98M5PaEWuh0KXPxEcZaYUbrwLUY3oNFyEphK25m+bIpd99nqRbYxmOY7142HOhbykTk/oV18PEIyMb/0+UNFRTb0Cm6UYS/ovzxs1BcCQZyn7yvZS1zp8mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712117; c=relaxed/simple;
	bh=CrnxRQxTJLYxbveN6wZ3IHPEFJHEKLCxEKpHf5uaAac=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uErEg8B7eoiMLSXRdwXXOvlMB8CeCOuUPoEre9JlwQ653BU3epREzH8CCLDtKB41iUXyDZrFawe0HnPQXx5RJA8zna7PSKqiiB/M7q0S4Xhn+sh6Pv2v7s5wVQ3oxPbKDNDXo95iXxSyx7FHedAoVpulVZC3sXVzrhNGeyAOwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ7U+pBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 369BEC32782;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715712117;
	bh=CrnxRQxTJLYxbveN6wZ3IHPEFJHEKLCxEKpHf5uaAac=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gQ7U+pBpqSb7ip/vcqoL/FYQQRBO99rEFX8cZv52N3ec8k4qCFAU0SWdaR+wr64ME
	 if3lGbVR4xUZDJbnYU0Tpf78+D1ngxMaRpu2k1XkPay533bp8i31cx0UF+Hb5IgB5i
	 y7na+WLDC93jj+gXS8iL8sy2dMJ0T3OX1ZhWL4ZiK4jPjc+z5m27YinSQaexlQ44xs
	 /RDT9ro6HP/aoizyCETL7X5t4ar7deVXeJEhUVNxNs0dX/QkUTFHAfLGjezKxcj9Lp
	 MHMTXUmbPnyqAMwJAAf1xIKQxptHLAuhuBvOgjgRzQ5uB6xDAmFK6G7CB4x74bl9oC
	 mus/31lXaSGeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CECCC1614E;
	Tue, 14 May 2024 18:41:57 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ba088745-e2ab-4124-bdfd-378cf6ed3c41@linuxfoundation.org>
References: <ba088745-e2ab-4124-bdfd-378cf6ed3c41@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <ba088745-e2ab-4124-bdfd-378cf6ed3c41@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.10-rc1
X-PR-Tracked-Commit-Id: 5496b9b77d7420652202b73cf036e69760be5deb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 896d3fce84e7798520eb11b0e53abdcfb47b21be
Message-Id: <171571211718.4202.6506102403672620697.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 18:41:57 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 10:10:38 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/896d3fce84e7798520eb11b0e53abdcfb47b21be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

