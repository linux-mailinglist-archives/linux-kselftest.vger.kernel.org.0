Return-Path: <linux-kselftest+bounces-46959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7910CA1FE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 00:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A89530285FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 23:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634702ED159;
	Wed,  3 Dec 2025 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjuYgXSC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F5B2EA14E;
	Wed,  3 Dec 2025 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806005; cv=none; b=vGuMav0iN6ob+0h3BykdXcR8xEiEBftS19xNm/IVnhxPbUgF1+ZUkaYVQkQjTE8SgYZc+SSFWeFWcwvmBjHRjxcx0MRsPSqwc0QTABNXtjZqPrhEKRQAAZQYeVhKk4J2wSw4n8RcNr+RUaFgAZVmfHK+E8JBD6sB1pGZCjkydF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806005; c=relaxed/simple;
	bh=hzS1to0Wojcl7X2iDqaf0+D8BzHcNYu2AqdMgvjwKrY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DXL2AYkkSx+9cjSb/shtjA3ANqVvouSHg/oN8OPAgHK615gkHXnlVqIWHue3Mrahjxe5Y/90W5OPezK/GypAK+j1pCUAq0dl926ilqAWvf7tISIQXHt97v5riBIb/reVo69NCw7Y+s0LnajYxzsQv9jAHYOZpUsgdqsWJngpHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjuYgXSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A699C4CEF5;
	Wed,  3 Dec 2025 23:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764806005;
	bh=hzS1to0Wojcl7X2iDqaf0+D8BzHcNYu2AqdMgvjwKrY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LjuYgXSCcithxQim0BC6rwVGfGQQbs1rhgxsfMmuKR8W8/+YZjZdbiQENg6aAPc21
	 NS1JmDT6Nltqimakdaf0kQLE1bsWYztP9j698EBQ92gR/IOuPFsUF8ygplYPeGo4hp
	 PHWANzfVcaq8vA0kRGOEvW2Z+wGgFq/ikV0dgEQ0un0jytsv1edm7EYz052Y+flciz
	 js5On0dbsVWJA9B2CWqxzVNHcxcEiGe1iR0lFGwV5kPq0YvQerMRAhjco26zfELhHS
	 3bcAvCwkFPlAtvnQx+CfVAKqaDa+b3moq5V61sjIf/D3mKS1HaJjqhHNpQUF+P7LOW
	 VVg9WpyAijjJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F290C3AA9A81;
	Wed,  3 Dec 2025 23:50:24 +0000 (UTC)
Subject: Re: [GIT PULL] kselftest next update for Linux 6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <180cca32-0d89-499a-bb36-c89e55736156@linuxfoundation.org>
References: <180cca32-0d89-499a-bb36-c89e55736156@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <180cca32-0d89-499a-bb36-c89e55736156@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.19-rc1
X-PR-Tracked-Commit-Id: a2f7990d330937a204b86b9cafbfef82f87a8693
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2488655b2f6b9d7d4afc19ecc1e7b1dccd67b13c
Message-Id: <176480582377.130731.494240999446657783.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 23:50:23 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 2 Dec 2025 15:09:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2488655b2f6b9d7d4afc19ecc1e7b1dccd67b13c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

