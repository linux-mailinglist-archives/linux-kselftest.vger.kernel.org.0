Return-Path: <linux-kselftest+bounces-13821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01679334CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 02:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1125283195
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 00:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0419461;
	Wed, 17 Jul 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnW0dTCb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA88C04;
	Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721177352; cv=none; b=nE4MwB2wF+OUitJ1lRnM4VTiosAXc/6JMInEsUdigbA3JPFn1jZRlT6Jva04MyKwS7y9ttjH11fzPaked1Ri/jXH4BKCODIzUZTAsux2ly9Y5bDT/uFCuoLlQdGE7vsMkYGYhCgGvzM+kOdBhGXwaaK/9g9Dk5sj7S1wCQm9Wfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721177352; c=relaxed/simple;
	bh=TUyXCKVOBpTX2mAZ9apK320kk0GHCDYVYAFFtmjmHTs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U8u005w9evkZ4w9/jWjXYg61RjM9PliD+Yzc3SqcSJnaRlaDGSbl6pAeEUMLrUyQaCmJnW35AhirVLfzN/QqVXGh3EXnPuulyDtqW8JecWCz4J704g9PpY5X72xLATd5eTNNdJwglN+nMsmu+sciDzD5SyNzROqEo07Ai5ItSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnW0dTCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB356C4AF09;
	Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721177351;
	bh=TUyXCKVOBpTX2mAZ9apK320kk0GHCDYVYAFFtmjmHTs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tnW0dTCbHAp6ZJHWXex5BK9oAGoeEPfIP5Bs/bM/GVkEtp52jUyP14U44uU6hRpsr
	 NZeVFOOgLccrlWuU7AN/sNWLqm8kZP0PgwmCLXXWLPUdQtlM0gb3DF0kksRnzwbyVA
	 6Su2hrfQMTgEqPSghP/crFB90DoPV4da39I6qfK2Mxb64MDM7YArbfGHTaOgkzFcOw
	 lovna9q7oxLKV8KsQF+GiDV7PM5VNyUfzgZPewiay6n+QUW88652J03/LHDfPEyW2R
	 k9pEnSHzLV9h3Mkzm1pUW+oqqZy9XQp7k3QXHlk7moNgWowFMBlChHoVUlp7Ake+7b
	 QRaYTzh1b2mxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1E13C43443;
	Wed, 17 Jul 2024 00:49:11 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit update for Linux 6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <717f0ac7-1d53-4f07-bed4-166eecd06d55@linuxfoundation.org>
References: <717f0ac7-1d53-4f07-bed4-166eecd06d55@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <717f0ac7-1d53-4f07-bed4-166eecd06d55@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.11-rc1
X-PR-Tracked-Commit-Id: ebf51e460e488511d9ee60b07d00dac68883facf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8d22a3195b8e2eaacbc5073ae1d5d5bb7386de9
Message-Id: <172117735178.30434.2684836636420321254.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 00:49:11 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 11:12:38 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8d22a3195b8e2eaacbc5073ae1d5d5bb7386de9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

