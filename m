Return-Path: <linux-kselftest+bounces-4712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB5855834
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 01:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37911F22280
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F81389;
	Thu, 15 Feb 2024 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnWV8mnF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8E10F4;
	Thu, 15 Feb 2024 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955958; cv=none; b=ase8iRR5Xh/I28RZgJB542Bb5CbmlTIhiSKdQSyoQXvOo+KT31UkNzd0sAQT9XQKNWae9/3MG68AN+LViwBEHhQZGEK3CExLvkwnhzKAXULtb2X+mfm0DK0wYPdbzWOPVTieG1LNxLPQxzjGzHAMaBH5PFMXQYpPo008ccS3TW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955958; c=relaxed/simple;
	bh=ArMKliqcmzZf+1nmUo4fcElURvndQcK0Htlb+D2cQ6M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PgxZF9sfTUVsMpXuaw6mXX793Vb4t5BKxVW5NmnW1cz7XLR6W714fJfEf9tgFmHSOT8c0GVTEXJKo9n2b6tWj80PaGXWUypUiuObICDElCDALsklpxYfb3AUoPIlpi4yhB9MrBJoxeWukIpSEFHshxwqzTJAGX/TaT0nAzWRg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnWV8mnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFE8BC433F1;
	Thu, 15 Feb 2024 00:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707955957;
	bh=ArMKliqcmzZf+1nmUo4fcElURvndQcK0Htlb+D2cQ6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CnWV8mnF3AdqjPEBHgQmto50B8y33orx6l73zbwwZMBnSMIeYwSCNtbH0SibnxQf5
	 99W5iHrDeM95Zsdn/KAt1HLGax/b65FKrD6+MbUTW5cGwXyz/zRzEvyuG0gILbdd8G
	 G8l/GA7M5vD2/vcrp8ShAZQHeRhJCwAAyvwQ1SnXwh2mZn/js8AZYY3YX5TdIP6JJ6
	 BsCK9KjOgtkfWg5hEXef5ufFKrt7wqJjR9ppWfcorPcHvCndthnycqiVY/67l1Xp9A
	 +ApKG7r4LTpOVLsqLhQ6cxmi4UFoEKf/PxxrHWXTvYmhJVRt20XNCm5mt96VpUJSLe
	 PkQKuCnzRH9Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D166D84BCE;
	Thu, 15 Feb 2024 00:12:37 +0000 (UTC)
Subject: Re: [GIT PULL] KUnit fixes update for Linux 6.8-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <876716d6-f865-42cb-94d0-67e9193a96f3@linuxfoundation.org>
References: <876716d6-f865-42cb-94d0-67e9193a96f3@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <876716d6-f865-42cb-94d0-67e9193a96f3@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.8-rc5
X-PR-Tracked-Commit-Id: 829388b725f8d266ccec32a2f446717d8693eaba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91f842ffe6ca1e97a3966e9e499c3ac6fbcc4bc4
Message-Id: <170795595763.14173.11075755145169428722.pr-tracker-bot@kernel.org>
Date: Thu, 15 Feb 2024 00:12:37 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 13 Feb 2024 17:06:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91f842ffe6ca1e97a3966e9e499c3ac6fbcc4bc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

