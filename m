Return-Path: <linux-kselftest+bounces-47778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E37CD3689
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 21:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 660613001E09
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011CF3101AA;
	Sat, 20 Dec 2025 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB6wtsV5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC98248B;
	Sat, 20 Dec 2025 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766261674; cv=none; b=aYk+B8GUPUwSocePOmB4xdxxL9638aEchxBd5RqLsK3LsR2y6UrW7h7bzHCFL6q8Xgfo3rZ0bHB4xcjDLyfTaCW3jwdYIxrbm1NGhCYs57SHz3ghizA7SIY9CwcrN2LyWtrXEXt7kogVEAvgWMSvztQd8Jt+FVNht1EPr/sPLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766261674; c=relaxed/simple;
	bh=nkyvNROWJoXN3FlboOHRnSmcV4s7SfZA/xZ+q0jQ0Jk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MFuxWtIE7Eq6Zyx3kIltIrAMGBsv77wFLiXOYvuE7hahxkDOZHoPZkhInXA9sR0kdvo6yLofNEoTd5lZXQpIJmiMe88c7ZFyQNM7uSYV5l6uI1OqxUAgqqd9FN57Nqd7ieN3L/nSV5jrQ00366v1BL0FG+ivjjUVgfTNx5+EUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB6wtsV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99D1C4CEF5;
	Sat, 20 Dec 2025 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766261674;
	bh=nkyvNROWJoXN3FlboOHRnSmcV4s7SfZA/xZ+q0jQ0Jk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bB6wtsV578hyX1ZwUyBOnn3pIb0o4kAEugmLRqPx8KsDztsAPMI9wlMSh7bxCgc80
	 X+hXxKG9wwvr0kE4MJgj9W8Dg9A7QrUs1wR0iWlkNMrV81ElThn4Nir+W83oHmU9Bk
	 I4cd3rl/3oRjxkPXCjfLHUn1pZI6pYwJ4qgGNV0QcILYBTlclE43a6DHlcKh/ptT+d
	 su1lNFvo8rxZ2fTTfNbbXTZ62DY6rFnBaTCrFoU3n1/CHz8F9j+frOhD3DjZPkBFmo
	 u7p+gNYEtzwH5/9kKk7Ih+buyGA8qsBOsJjankuNF6v+KJ2AV5NbkFkIym/yzsh/1W
	 RN7/QhpaDSbig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2FB83809A05;
	Sat, 20 Dec 2025 20:11:23 +0000 (UTC)
Subject: Re: [GIT PULL] kunit fixes update for Linux 6.19-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <11a7c86a-459d-46c2-bfe5-9237fb586584@linuxfoundation.org>
References: <11a7c86a-459d-46c2-bfe5-9237fb586584@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <11a7c86a-459d-46c2-bfe5-9237fb586584@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.19-rc3
X-PR-Tracked-Commit-Id: c33b68801fbe9d5ee8a9178beb5747ec65873530
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa084c35afa13ab07a860ef0936cd987f9aa0460
Message-Id: <176626148242.129879.13353522451801964160.pr-tracker-bot@kernel.org>
Date: Sat, 20 Dec 2025 20:11:22 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, skhan@linuxfoundation.org, David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, raemoar63@gmail.com, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Dec 2025 01:40:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa084c35afa13ab07a860ef0936cd987f9aa0460

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

