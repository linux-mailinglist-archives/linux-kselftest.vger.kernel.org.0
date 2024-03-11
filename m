Return-Path: <linux-kselftest+bounces-6221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B2878759
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 19:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4CAB218ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465C4084A;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xae8p1/i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBEF200C8;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182028; cv=none; b=ZJgTNqOTNoo4uTH008Zx/QYUJmuIrINjiT1mnR0YAyrcMrJAbBi+yplv3534GQ90YksvN5emYRBXNKP5MeJGcNN2+FO+2u/6+tZ7AADvTr/rzmOjfNhqyUgU5tPZGATX9U76th0ukAkyt3QbjzAubv9GEK2xh77sd591EZEHfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182028; c=relaxed/simple;
	bh=7Wp4QqWSzaPVlOMf5qqxnVSPEyb33fbIRcxGPn3RQJE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V2pY54YXcfOESkomsHd1SLvEfY9qfGLRXABTsxokVA/FDGqY82kfKwIGtbI0MSMD27fvy3lX20Udkyv87nG+rYcK2Gnfo0eed0emWvK8sSaP5tix/cRAVvFNFizhoEnx/LGco5KUcuAwHA/cX/5H7vdWIijQl+tSNhCiHBG9Fmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xae8p1/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F23E8C433C7;
	Mon, 11 Mar 2024 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182028;
	bh=7Wp4QqWSzaPVlOMf5qqxnVSPEyb33fbIRcxGPn3RQJE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xae8p1/iZCZFiU9rHzJ2oImsn5Z9lEkmeZlqVIyDD6di/HbXnjLfy0/UIDS3qr3Ul
	 cslsObTGs8t5GQTk4Um1NrBHJxdf31hx7N6w4mRNY3r1vfc2BsI9X2POD8ZZxzdtZe
	 J0sk39oTXo/l6+DB/yJrgxKVByKpsoGcjEDLcijg6wqqn4MRWmtIzMewMfwkyIOnDr
	 o+U4dztitKwggDanQqleoLJc+0+4yxOc53xvqGUmQryH6MiT3ZG78gaFeJSEEEft75
	 2jix1+/zv6NPz2+RYe6ID379cmCUQbhlMBDfusA9WYTZbO4c/NUcO1SNBD5dOTaeQp
	 k+EpFM9RSUDug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA35FC39563;
	Mon, 11 Mar 2024 18:33:47 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit next update for Linux 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <a47cb633-dc38-400f-a051-506b1b49fde7@linuxfoundation.org>
References: <a47cb633-dc38-400f-a051-506b1b49fde7@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a47cb633-dc38-400f-a051-506b1b49fde7@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.9-rc1
X-PR-Tracked-Commit-Id: 806cb2270237ce2ec672a407d66cee17a07d3aa2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97ec9715a84e6f0979242e1ea98b9af1a39acf3b
Message-Id: <171018202788.4685.14846419018274693850.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 18:33:47 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, david Gow <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Christian Koenig <Christian.Koenig@amd.com>, Matthew Auld <matthew.auld@intel.com>, Dave Airlie <airlied@redhat.com>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 6 Mar 2024 19:11:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97ec9715a84e6f0979242e1ea98b9af1a39acf3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

