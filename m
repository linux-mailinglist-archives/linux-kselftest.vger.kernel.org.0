Return-Path: <linux-kselftest+bounces-18078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9762F97B1C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 17:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334CB1F214A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED13194C92;
	Tue, 17 Sep 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8H5R02i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0F194C73;
	Tue, 17 Sep 2024 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585210; cv=none; b=e8vWmnba6posOurA5JU/vZbcmL+V7TzX8q/fKg1KVUZH/CrHjjfqSm5ddtsFVWmyeE4p9N6qJ4VBeOANHOxPOwnbLVoK33jQ2lPIdym+dvtn8rQcVZKwPtZelmPXRa2t6caq0LSqk8CNxGKEeUu4VxB68USw1WYtCR5UeJmSzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585210; c=relaxed/simple;
	bh=KMU9TxPvPBc3fhaVv3M0dDsO0hyIx/K+cK7BnHBbCpY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZmI4o5kHV0LX69UMFPLD1SYAz1PVSf7tlLtTbSkHVyD4exF1R5v/wGtzRNp8HS+0A+1W+8eEStiupakxTgzMDQ9uNftMYY8GYGsBN73LdAn5s8cW+i8AUHbVWmBjEVAjyg4z1oygsbkKIekEcjiontZl5FX8suWt5pJX7z2sT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8H5R02i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296CAC4CED0;
	Tue, 17 Sep 2024 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726585210;
	bh=KMU9TxPvPBc3fhaVv3M0dDsO0hyIx/K+cK7BnHBbCpY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N8H5R02iPP6YgPeohY3icALL0HbxRADGkiScT91t1Ce9YRJPjznXjYOJZO2HZR/rH
	 b+3cSAo/+ZChsl3ldDzqBO7njaU5x1LYdRRF+Ji+9/Dpd1g1yHGGMq757rd5BYgq3C
	 dD9zJCDxWwD7MNqOXuysN0G/C1sO70H4Zdtp1F1pIdImTwk8+6VGqLY1jQ0IfEhGk6
	 K8Ke+p/tRfCX8boNPbsN21r1bDE5LyVP86n249YAzBsY6IjmX+d3F4Ku9FbhB/9xog
	 D0Oq0Xs7R+AakgKT5YnRKG3yFCvrr6Se3gCsHsHBKS5PVM4/HvauzzhjyiDLtum0jA
	 jUck1mgIzZt7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196263809A81;
	Tue, 17 Sep 2024 15:00:13 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <2868a5b2-d41e-48df-8b22-cf0d72793f6e@linuxfoundation.org>
References: <2868a5b2-d41e-48df-8b22-cf0d72793f6e@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <2868a5b2-d41e-48df-8b22-cf0d72793f6e@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.12-rc1
X-PR-Tracked-Commit-Id: a0474b8d5974e142461ac7584c996feea167bcc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32b72debef5ab9b8bec32fcf3c5d4a62da8a4db2
Message-Id: <172658521196.168423.2862528446972670562.pr-tracker-bot@kernel.org>
Date: Tue, 17 Sep 2024 15:00:11 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 18:13:16 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32b72debef5ab9b8bec32fcf3c5d4a62da8a4db2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

