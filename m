Return-Path: <linux-kselftest+bounces-30393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5B1A81A2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 02:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EBE4C13AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 00:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F24142E6F;
	Wed,  9 Apr 2025 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REG/xxJ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A201141987;
	Wed,  9 Apr 2025 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744160182; cv=none; b=mQD74leY7P85CDK5FFiT3jnOMycJIffAcwz79Fkj56ZRHN0WNsJOi8/hu92mA1B1BH9ECdQJVBh20HrQE78irst0AjDXwVI5ATmqJX4kHInuHGtWcTrvzexuSn0zCfbjWL7x9rR+Say+AJercpzmqaWBYDkL/oJbFyDmQKws2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744160182; c=relaxed/simple;
	bh=yIqqGRpuP5tz1BIGe+rmwYRIap+gHCN7D1JOnIkOaGE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OYfMrLB/l/9MYgN1399IuxQvGVI5Uy+WM0J/zGtrolDceUM5286waFPH/oRUWc4D17BLaYxiqzfzT0Iwgzrqsrhl28xGwdfCwFXniFmcSvck0sb5nNwuJXKNrCbS+cFzMkUdgYMQcwnLDHYDNSYyJZ85N6p8cWRrC17dIAjD4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REG/xxJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3D0C4CEE5;
	Wed,  9 Apr 2025 00:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744160181;
	bh=yIqqGRpuP5tz1BIGe+rmwYRIap+gHCN7D1JOnIkOaGE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=REG/xxJ6C8wSs4pduhfSJ6p6lgvDsISJVzYw6n8hxelaHQPK+WqUKhCL+KdhBFle5
	 4tPdS4QzfWiCcm6CVPGJhsWvsxjjKg3JxYft3l0eqgav9B3/3gRugRL3mTYEdF8rR0
	 clqGBD1jC5AfRwvnegixKSyqFOZFy+Gy5CCUn9HZRvLh4JDJpEHm8PDmt6gi07QJN9
	 n2yIoW4DvhBQvlhqWp1zJNsks2nk+Qh2+hfw2LfvmpHRHq35wnzQfnubBB8lw3jbIM
	 gItHQNhoQT9lAUrVDu22Ycd4hnZaR8NYFxBQeMBv6WyEOi78PNUu2TE2wewCQJlx7a
	 mLsUoRGw6JeeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34C1F38111D4;
	Wed,  9 Apr 2025 00:57:00 +0000 (UTC)
Subject: Re: [GIT PULL] kunit fixes update for Linux 6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <a39f11cb-a88e-4275-9fe7-8a000ccdefd7@linuxfoundation.org>
References: <a39f11cb-a88e-4275-9fe7-8a000ccdefd7@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a39f11cb-a88e-4275-9fe7-8a000ccdefd7@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.15-rc2
X-PR-Tracked-Commit-Id: d1be0cf3b8aeae75bc8fff5b7a3e01ebfe276008
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a24588245776dafc227243a01bfbeb8a59bafba9
Message-Id: <174416021890.2266559.3203240796206869078.pr-tracker-bot@kernel.org>
Date: Wed, 09 Apr 2025 00:56:58 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 8 Apr 2025 16:31:50 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a24588245776dafc227243a01bfbeb8a59bafba9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

