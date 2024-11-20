Return-Path: <linux-kselftest+bounces-22378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6E59D42DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 21:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A3F1F226F5
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 20:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE750170A2E;
	Wed, 20 Nov 2024 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KacLQQZK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC015855C;
	Wed, 20 Nov 2024 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732133406; cv=none; b=VzEnTvLOiLpncBoE2c4UKoSP6CQTyxMWrGBtnyf0c50ULGrcJpIuUmxY5FTmeYgoBtqmiidLgMngVM36/csTWQW4Dt6TbpkccVcUsRMiwuYn3/YhDA5j0d8JkY0yNfiOQ7L6lr8zrZIqTGkov2EBUApLEivnKiqZV/m7hfIsg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732133406; c=relaxed/simple;
	bh=7As3HBwUomQn+EwYIRDhmtmG5naKxNQ/Zjfp9tG5avY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DNNsrKJpR1c6F9q1vtsvmjNW2Iki55S1fytafFLMuVuKu+TSGzwYZtlv2X0Z6/7bJXfAA8pINmg3RmLVVnksPL5883T+ssiLot2kFlwqikw08eI0JXmGxiZvj18kEkbs+pwuQqTOwBQNqHr7bsFU8pqkW7hY1O6y1zcvqRGl57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KacLQQZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47712C4CECD;
	Wed, 20 Nov 2024 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732133406;
	bh=7As3HBwUomQn+EwYIRDhmtmG5naKxNQ/Zjfp9tG5avY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KacLQQZKD4PrY3yYlC4V42XLsILZxwS+hin+z76bfoug3jEGlESjqaROZV74RuVdz
	 X2fEMQpFXbD4PaLZoNUXEmOizA82x55IZWQF0FXodT5L5Y7YHbVwDEWJ/Svkdgp3JH
	 CzrNucshhzJ1y4RLojntCLOHpeXuH56UQwkiLhZyMJZqqKYL9/sZAuSMSGNSgmajyU
	 izoxoAYahX9fPn+e9pe/sVniMCtztE06abAYd8konSq+SH3ZtiA6nXEM/DWwXK2vO3
	 REyA0ED2BPROq0PBRNVFnWhERU5QyiiMlnXtS06hF1oW2FXBf8KE3KYQQxAwVHejS7
	 MjPdThr2RKuCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 346AB3809A80;
	Wed, 20 Nov 2024 20:10:19 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest update for Linux 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <4c781cbc-d77b-4ddb-8a6b-72514f55b6c8@linuxfoundation.org>
References: <4c781cbc-d77b-4ddb-8a6b-72514f55b6c8@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <4c781cbc-d77b-4ddb-8a6b-72514f55b6c8@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.13-rc1
X-PR-Tracked-Commit-Id: a44c26d7fa74a5f4d2795a5c55a2d6ec1ebf1e38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 856385e0c56e7739bddea869e7a17f040211a2fc
Message-Id: <173213341781.1333813.7197162804373428701.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 20:10:17 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 13:40:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/856385e0c56e7739bddea869e7a17f040211a2fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

