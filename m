Return-Path: <linux-kselftest+bounces-18077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D61E97B1C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 17:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891BBB257BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9A194AD6;
	Tue, 17 Sep 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghH1KEwy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF57194ACC;
	Tue, 17 Sep 2024 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585209; cv=none; b=n9D+Uv/XRy17VPL3jWz38yeUGalS4I1oyKlyROf6mnQovWrliXgcJV4/FUaXDorCUEmDuadCORg6vQ0mIHK5LvoOMp+ZJpajDL6nDrEyFVSZs4In3i0w1vpKn2wLQYjPo0l+zgLEWSZi4ISg9YgNfnyMVLy+JxcKofrsaySK528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585209; c=relaxed/simple;
	bh=PUlU5vXQwGw5cMbHe7bOtX3O4lgUzh3x5cVJewm2yd0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EVrQTE7ASkosIs941ZWq0aYroTfIp8cWF14eZ98eSEyoEAxjq70CGfKS+ZhPPVPNYmTe7x+NeF6unxIPP2K+IysDx63gMvZhy2XcV6rNa0a1jUBN9OUJvdA2h9fq91Vjhe5gMz4zb4WP2h6hYwWoZ9ycjINLhGCbrBSqtkPRWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghH1KEwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DD6C4CEC7;
	Tue, 17 Sep 2024 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726585208;
	bh=PUlU5vXQwGw5cMbHe7bOtX3O4lgUzh3x5cVJewm2yd0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ghH1KEwyYK8K9wPwitOT8XuIWFRc11TdK/A4G6/9o+iRbkfAzvTQWZcyVlUGYhhpp
	 VlF4pGftTgwMtKwCvooo+LeVN6nTY+weEQMA3gtSCWKgrxtYP95CKLGFT9mV4kSUhh
	 zYXaFikYf9CWGIvZmMzdd5JajiwsuhvAyKhnfMK85HyahsDcIFyUGpgg7ymhqKThOm
	 WVYhbkzhvgjZXzJty39MUGVnLWBp01LRe0OuZNlosUBA6lETOCssk0ChvC22QAFgds
	 F/ZzyqQTCjCv0jgyKQmMQDBstJYrzKzyfSte1+M+XyGu2kIrS1C48J2V6iPc5Nna42
	 rFVLyASAUyFEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B74393809A80;
	Tue, 17 Sep 2024 15:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <b225fb53-c56a-4d96-8f70-39d013194ab1@linuxfoundation.org>
References: <b225fb53-c56a-4d96-8f70-39d013194ab1@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <b225fb53-c56a-4d96-8f70-39d013194ab1@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-nolibc-6.12-rc1
X-PR-Tracked-Commit-Id: 248f6b935bbd8f7bc211cce2b6fd76be4c449848
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 395b15778e8f1b580334c558c9a6e9f1b28fcc76
Message-Id: <172658521049.168423.6585739739996465146.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 15:00:10 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 17:37:52 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-nolibc-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/395b15778e8f1b580334c558c9a6e9f1b28fcc76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

