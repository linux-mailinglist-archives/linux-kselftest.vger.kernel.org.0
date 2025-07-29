Return-Path: <linux-kselftest+bounces-38064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1602B153ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1127C18A7784
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B14254AE7;
	Tue, 29 Jul 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj1RWALV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF825484D;
	Tue, 29 Jul 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818696; cv=none; b=r1prpeQSowFFfq9xNsoH7uyLHEtFvGF4Xl90eODdv64mlgPWaWSAaQSlBrfAPJJTiq3lyuJ9JECQDhP+5lcymG73Cq9MSB/UFFvBtFb2I+mAXXtJEFs3EvquYuVv4o8ffEvqLE/PEpMlLwlWEibAET5Tqf4VmqjFze/XvFLD5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818696; c=relaxed/simple;
	bh=ymhyqKEQ1RQI6zvh9+oL5Gz2XwwnITmmQyPuCjB2FFA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ik8H+OwmGp56ju9etZ5u1fwRv149HaqBv9Ir9x8fNrwV5jo+VyFNzOmvgylt2pPUign67l9fWreIgnLLJzGy3C1oElb4poVpWDdVp34Hh4G/5065x73xCqoFhllfkRG2Poj/TyoJJehQPbblFh38mov3XHcx3uO+llLe1s9bNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj1RWALV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4D9C4CEEF;
	Tue, 29 Jul 2025 19:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818696;
	bh=ymhyqKEQ1RQI6zvh9+oL5Gz2XwwnITmmQyPuCjB2FFA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fj1RWALVhsntF2DLe1ngCs1k2/Z2GsfnNESr2j3JAmm0Y9eWBoLnyYgpNKkThOfvn
	 djhoJeZVtMtObU2PmbL6VoROzn39VvButJ3bMg7cnXyAztsPmR0vRm61q3K6CIJOzc
	 EVhYc4I5ihNiaLDjGoeqW4I2xLjWG6AnZyw3HRol2sYVaUfsdVS9uHJrCyeuxoaFiZ
	 sjZ3P0YjMF4E3kUtDpPCqjesogo8uOFmlfgUvortawP+unaI6Rim1tTuVf5BcjGEf0
	 omwklQks33psZKqYJ+B42dm3zPvM22O9QZESVlGRHaWzfeJDZtGPJVu+3eG1/FevPL
	 s8qacvmXF093g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC96383BF5F;
	Tue, 29 Jul 2025 19:51:53 +0000 (UTC)
Subject: Re: [GIT PULL] kselftest next update for Linux 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <70b0d0f3-08c3-48e6-a18b-553838625b11@linuxfoundation.org>
References: <70b0d0f3-08c3-48e6-a18b-553838625b11@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <70b0d0f3-08c3-48e6-a18b-553838625b11@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.17-rc1
X-PR-Tracked-Commit-Id: 30fb5e134f05800dc424f8aa1d69841a6bdd9a54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0db240bc077fd16cc16bcecfd7f4645bc474aa7e
Message-Id: <175381871230.1621303.12200788035005967737.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 19:51:52 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 17:13:48 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0db240bc077fd16cc16bcecfd7f4645bc474aa7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

