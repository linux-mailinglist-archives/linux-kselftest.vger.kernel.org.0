Return-Path: <linux-kselftest+bounces-6220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE19878758
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 19:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE92D1F21F7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342702869A;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHKnytkf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E65E200A6;
	Mon, 11 Mar 2024 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182028; cv=none; b=eKs51h982yVexPB8HehN2pBhBAX1kLzGz0WlK/oLAPlrgKjGtT/0Rq5kH/zDWm2KcvhjbmjpDuHGO14nXBARoXMUPLvY4zxkzHWv6sH8GFvieiETieji4FuLrJLKGraY0zrKFdr4cFSzVvfP3sbbaq+MJ884j8p8td643jO78so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182028; c=relaxed/simple;
	bh=PRrJ+9NcJyoZbthkzs8BOQ9UFdhErcu75j9nQYdQ0Jc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Spa7njx/tkOSNrXToFwSpu8qddVqh+Hoaf46Q8Js9BoaumzUi6SMbd3vZG7Hz7QcWbUnl/CJUd0wh03cUI+Jpi19d6V8SQRLNjAy+03SdxxqbZl7VmJee5ti5FRqOO3SBHDasBKG7aTdYMy9RCw5mgNGvuWvpeGf/0eQvkNZaWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHKnytkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1677C433F1;
	Mon, 11 Mar 2024 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182027;
	bh=PRrJ+9NcJyoZbthkzs8BOQ9UFdhErcu75j9nQYdQ0Jc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZHKnytkfQeBCZ3XAPL8B2ikqN9uC8jzxuzrWyz/VFEmm6Yusw6x1/pTqO43rEqq1r
	 1hDjGpnGpE2DHMJh70tgIgEK0J5x8IG0suGfCXwPCnCd6Niv+i0dVedTMd9Ryf3ESm
	 kN8DkQ1h/vkGsTpfMRBy/L+3WeIcOizMphpB6AgniN5Vmyn9Y20jxdVZGBzq3uKWJH
	 7vKd3SvtSLcw9ubLkcQ9CGcPs5guxHszIbGrGD0ls0r2hYI11RzNt030Bb4ZLIRG7W
	 viO1mz/pJWwYYqZZfIjeMv6p7qVZhoBwHdE3762sHsJUAojpNGuSiEbsqlvxWxpDs2
	 09PiLPi0HjgFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7D29D95055;
	Mon, 11 Mar 2024 18:33:47 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest next update for Linux 6.9-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <fc9ccbf3-6b7d-46d3-a8da-54d5dc78a81c@linuxfoundation.org>
References: <fc9ccbf3-6b7d-46d3-a8da-54d5dc78a81c@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fc9ccbf3-6b7d-46d3-a8da-54d5dc78a81c@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.9-rc1
X-PR-Tracked-Commit-Id: 5d94da7ff00ef45737a64d947e7ff45aca972782
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d451b075f776180c6974fd7bc06296829edc2631
Message-Id: <171018202780.4685.14370793767978548730.pr-tracker-bot@kernel.org>
Date: Mon, 11 Mar 2024 18:33:47 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 6 Mar 2024 16:54:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d451b075f776180c6974fd7bc06296829edc2631

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

