Return-Path: <linux-kselftest+bounces-17301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B049B96E0E3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 19:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C700C1C2321F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4448F1A257F;
	Thu,  5 Sep 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4f5dKpL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1D1A00FA;
	Thu,  5 Sep 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725556326; cv=none; b=M20VNmfJTiWem7liGZdPEcstBqqQzf4rcf+eQhWCa5avhGojpRONP2nKZhO8EqGuQIXKwJzJ7aEhtCv93JeeTthqCFVQKCb5Wp8Zfh4IiJqk+ndGtXr6SU+EZJbrR5JSmgBbeQNToahw3t0s5q9CijFwu64Xq/jNIO+KvK1gSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725556326; c=relaxed/simple;
	bh=sYbWgUdn68kAf7xNxGrORwXsQYGMxv0bWG/09r2vfNM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QbJ2LsQymPiF8hH6xhITRQ9gyexZcvCQC4JfhVMfD81/Z5RimYmC8Ai22h/W0VVH46qigrdD4PrxrlX4+zugv1oPW9h2wE14uwk2cGTabRsHowRzpHXeYPn7wXZJiwRx2Lq3cXAVFDdp3oj4VmnHAoiRxZbaYWR2BDPPmZaqoUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4f5dKpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9723BC4CEC3;
	Thu,  5 Sep 2024 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725556325;
	bh=sYbWgUdn68kAf7xNxGrORwXsQYGMxv0bWG/09r2vfNM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n4f5dKpLEy0TQ0Yd+17IRiThhR1smExwj7A6dmH9UX7yVZg79crF4ZS3dkbcylsLY
	 l7JYUqM//8GFF5pyVFQNm7qLywLo62vo2Ah5n1TuvJabfoELKC00rqKgfA5KaeZLQJ
	 wGPp/TCOPWErcyugiCrqBaUES81CnsInnXXshJJA1H0F2xkKC/s4G7AD9LehxXGNhq
	 n9hJWtRz7h1kFuUrkZNYZTpLC1Wgs4ZQT0WDJ1mhh8vzWn9yQHgzushBrCeiDJjxxy
	 1/nGXIVl/As7iIvnKIxoUFMwIKGaOUzaPzSHh6zv5qi5ohQn5sSeIQDa4hT5Bf+9ZT
	 s/sRR3+sbdPjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5F33806651;
	Thu,  5 Sep 2024 17:12:07 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <4fa8a1d6-ac65-477a-aab4-814e02eea2b8@linuxfoundation.org>
References: <4fa8a1d6-ac65-477a-aab4-814e02eea2b8@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4fa8a1d6-ac65-477a-aab4-814e02eea2b8@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.11-rc7
X-PR-Tracked-Commit-Id: f2c6dbd220170c2396fb019ead67fbada1e23ebd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 120434e5b305defa1fb1e7a38421ed08f93243d5
Message-Id: <172555632613.1768720.2230352386703120930.pr-tracker-bot@kernel.org>
Date: Thu, 05 Sep 2024 17:12:06 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 4 Sep 2024 15:39:40 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/120434e5b305defa1fb1e7a38421ed08f93243d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

