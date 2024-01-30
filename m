Return-Path: <linux-kselftest+bounces-3776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C5D843130
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 00:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047261F24D2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FE7D40C;
	Tue, 30 Jan 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POdzpwph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA87D40B;
	Tue, 30 Jan 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657191; cv=none; b=Ee8RmquCQ0W2l4FildEn5rKgrUTyPsIR5ENWQSd4o+1b1+QtD7M+07tXLKgbAjKMr+mkuJOt8seHpZwTiurfVLRg/WtRaU7SH9cnto5pNVaoEY1Y/Nvm16Q+y4/Pi9Vb/P2SqBu10ytMOzhGxCRsJmuo/eo9azR+pczfTw5RFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657191; c=relaxed/simple;
	bh=mXJx1vLFdeC+N52dAqHE1Z5EEWjxSJy43LGa517mDYE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nCsJ3aeXwTKYCVR+KjNWOD636+ha5A1cp2EqPvx4xfRULCXYlXmK06Qf47J9Pk5s1aI62yv0crA5ahuUoQtm2h98QJrfUyKGW7bpVSKI02FskXJNJfqMFzN8wjp0blzyxNkhz74RJ5PNPmklRMEZUY41OVVMm+uZuYl7Ty9Eq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POdzpwph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4857DC43390;
	Tue, 30 Jan 2024 23:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706657191;
	bh=mXJx1vLFdeC+N52dAqHE1Z5EEWjxSJy43LGa517mDYE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=POdzpwph6qMwzZ8w4IMTc3Do01ph8giVJPxGH3Q4MwGyGGzH3vO+4jAxxnLsfKeyP
	 vc/QwkzfRI17HUlAza/X+qvaxPkE9H3kvPXRuR1Mv9NGM0vAPccEzzVfQkWsAmqxEq
	 lUrPhRRMthb0Druvv/qkCp7MLb7m5YB6ZRdo1qDkSzmJ9jO+IZAHy8rYFZSQIUnxDR
	 oI1JArWESNFFYhcgtzlqeMSIA2GAYYcGj/KlsaEqnW2TlY5wKR8kFBaynt2Sj1Rt7W
	 r04WQCXJv8w2qwluHgQXVOuz9ZgWYDfav5jaPSMIotxYpUZI0rG9UyXRyc/rxaDmYg
	 QTAPbUu1RUA4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32F67C4166F;
	Tue, 30 Jan 2024 23:26:31 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.8-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <352c935d-530e-48d6-aaef-b2093066a22f@linuxfoundation.org>
References: <352c935d-530e-48d6-aaef-b2093066a22f@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <352c935d-530e-48d6-aaef-b2093066a22f@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.8-rc3
X-PR-Tracked-Commit-Id: b54761f6e9773350c0d1fb8e1e5aacaba7769d0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1d873a9bfac44a9a455d2ec47b85ea66f7888b9
Message-Id: <170665719119.18648.14311161725531731007.pr-tracker-bot@kernel.org>
Date: Tue, 30 Jan 2024 23:26:31 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Jan 2024 14:48:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1d873a9bfac44a9a455d2ec47b85ea66f7888b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

