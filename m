Return-Path: <linux-kselftest+bounces-18549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5737989664
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 19:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A036F1F210FF
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3747F17E00E;
	Sun, 29 Sep 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA4gLGWS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E65B17D346;
	Sun, 29 Sep 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629482; cv=none; b=b8U2lqFWlG1HQMumUVB6V1F4vdXUiLGnGQcacZFSJZqUhjhaIbAjllO+H7B9Va5/jTT1kKtBVesIO26RZxcSbQefMTCkJ5XvRqwYrsCNsZW+ykuUScM0GSre/jj4fIHVCyXM+oGUBQ5Vl0JxWUcKnKg1+NQEZQ2S68cnUm2Xd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629482; c=relaxed/simple;
	bh=Ss6ci3FmGpi3lzFWvYKplqOMsg4GIoY/D6nvyA3YjhA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g5lPCMCCkB2XPW681cCh1K0VTQxDDIC/2KVKImQCU6KP6SvNf4CK+UU1qR6KXokEfKQ9R7oMhDcTSVa35YZSs4r7aDeoIWBkCwQogoJ++8bTMrTj530zjTQtEnGSGe3bvyNmPH8ivJsBQXFrb9nE65Twruy1JT1fwCCv6f1UznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA4gLGWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EF6C4CEC5;
	Sun, 29 Sep 2024 17:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727629481;
	bh=Ss6ci3FmGpi3lzFWvYKplqOMsg4GIoY/D6nvyA3YjhA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rA4gLGWSGkjjsG2I3uJGDFbJdA4DNRk3b2HoUV3wjJwlD5Kq3W+fgLEguztR65xHj
	 PmpG5lbbjFuQKWPUPIa6dnRyOo7Ovt9YsdwsQc9oSH7wxJ9Sw4MnESQJFNHyY0h5WJ
	 zdD4OqKNu6m8TAAdq4ShhLvB9Yrr6U7Nu93Kb3ohuaWB4xtH09Ov/jfw2X3g178psB
	 D48pbu+Tqvi6giePwbwiBy7L/diAW07OWAFkEn8GdCPwLKAZ68Tb2FYBku7Zamsvok
	 H5SE3u35MdhKEhaFNb7FsYvvqJCiJzMp07kg8VUaGiyzukp/I4lwVUsvBBh33FB7Xk
	 FU4RkrriGoY/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF193809A80;
	Sun, 29 Sep 2024 17:04:45 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <8b5ae15e-fce7-48ed-a0cf-8ca0b00c6ea1@linuxfoundation.org>
References: <8b5ae15e-fce7-48ed-a0cf-8ca0b00c6ea1@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <8b5ae15e-fce7-48ed-a0cf-8ca0b00c6ea1@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.12-rc1-fixes
X-PR-Tracked-Commit-Id: 4b721fcc094e9eb6dd4702df8d79ab11e120833d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7ebdb5161bcb98cb27b7490459419e38dee5b9a
Message-Id: <172762948455.2558104.12411269530367474244.pr-tracker-bot@kernel.org>
Date: Sun, 29 Sep 2024 17:04:44 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 28 Sep 2024 11:52:08 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.12-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7ebdb5161bcb98cb27b7490459419e38dee5b9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

