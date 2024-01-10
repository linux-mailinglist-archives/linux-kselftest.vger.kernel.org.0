Return-Path: <linux-kselftest+bounces-2787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB1829228
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 02:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BE51C25372
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 01:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8023D0;
	Wed, 10 Jan 2024 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFiBdeFH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8023B1;
	Wed, 10 Jan 2024 01:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1245FC433B1;
	Wed, 10 Jan 2024 01:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704850257;
	bh=WZy2Ojvfd4hEiVr6j2zeNqb4HntQE+agdWnmyqdEy4g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OFiBdeFHcyaFpKj7gTOAyiCcse+gNku99p73VVfZfA+Kuqr8JuvtCCtWK4CoALt9D
	 TErys7+aE2U11pPhcU5XOXDXWH7Q6Lt0TqfjtWroJ7F4B3/7/bLtY+p8e0fw8DyRH4
	 +P1RXchbCFHSRsm+XCnfPWMuo8xF7FNOknWbGXjmvTO8rTw2n64uRcvOf2JPtw4Wxo
	 hrGyPUkX/copHG9IKabHpfAp8XauYZiA/qKDhYFKNntYb9ij8M+JjzIMrmFsuCVYIt
	 pDlnZzwM5qX1e5VeVo2R0YMusQqkzfn/uITg3CAsL1Q1czvsydrSbxYNDlejoraR/C
	 FAA1nw16IC5lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC852C4167D;
	Wed, 10 Jan 2024 01:30:56 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest next update for Linux 6.8-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <1998098c-2a04-4354-b804-c3e99143d273@linuxfoundation.org>
References: <1998098c-2a04-4354-b804-c3e99143d273@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <1998098c-2a04-4354-b804-c3e99143d273@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.8-rc1
X-PR-Tracked-Commit-Id: ee9793be08b1a1c29308a099c01790a3befb390a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab27740f76654ed58dd32ac0ba0031c18a6dea3b
Message-Id: <170485025696.7649.7029531638600456767.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jan 2024 01:30:56 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, skhan@linuxfoundation.org, shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 9 Jan 2024 12:21:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab27740f76654ed58dd32ac0ba0031c18a6dea3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

