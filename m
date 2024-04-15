Return-Path: <linux-kselftest+bounces-8022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3D28A5A85
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 21:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AD3B2172C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215CF156237;
	Mon, 15 Apr 2024 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfRQOk1k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADADB656;
	Mon, 15 Apr 2024 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209157; cv=none; b=SWmyE1Ki3gxDqWcXti51pbaSY+v/wsN9Mw0hmWI3vzHCuxPgwNHlj6Vw0uEJsfVBiBDgfuaKDE5HkWklgL9wHN6c51c3c5PkFfIkfEY/eyiBFE6cMTQaqv7zwW9Dn/QfTnPuhIEkT2WaEq49YoxcNsfU9t9xCc2VX72SLZ4MZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209157; c=relaxed/simple;
	bh=0yKBmbAjTmyYnjL2Wk5LXQzyZqa/O++6dm/QpVA40HQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=osJwdaA0E0O4i99z5oX2Q/6Fokz0B8jPu/vazIGOMeA1t/AM6GL/Aet0o/KfBHsxGgKbtaijXMKWBg7urOMBGMpZBxCr5yaEeUQMKmpJRyeVP81E1smfDkFswO7rfj9Jbaiwf1GYIggqGelvv2sPrYjUEb+slzqVBmMtNFQwOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfRQOk1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0678C113CC;
	Mon, 15 Apr 2024 19:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713209156;
	bh=0yKBmbAjTmyYnjL2Wk5LXQzyZqa/O++6dm/QpVA40HQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HfRQOk1kL6rLRJs4tb5bAdi1izdNFPh62YjHY0lugPgoVnFWu63C7KPGRpXzvIdks
	 NYvcsMgGE/rd8yYM6FADh/Mjj1OXMkRTBe5nQEFbk/0sTz0SMQdnfZHExhAiNgWZ7+
	 6t9Brmtf+D2woEiD9HOWwHTVN1UvDQaqMHSg4KhZo2VKhm2gZoW+fIp7vNqsLXvWXv
	 vz3fAXgSvcjw63AFQlnclOVYsWgXIENf3tfoFv4k2FfKX70PvQeO//gzNTWWDNk00W
	 DRw2xKwtjLrXhGPcYnWZfsRYT+24cj6Yllrd3z4iKGxkntoZhTrW7ij7EyhLol8ZK4
	 yWe/JEkjeg9rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFFCAC395FE;
	Mon, 15 Apr 2024 19:25:56 +0000 (UTC)
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 6.9-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <c03e09c7-e9a5-4e64-b146-40c14c68bfd5@linuxfoundation.org>
References: <c03e09c7-e9a5-4e64-b146-40c14c68bfd5@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c03e09c7-e9a5-4e64-b146-40c14c68bfd5@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.9-rc5
X-PR-Tracked-Commit-Id: 72d7cb5c190befbb095bae7737e71560ec0fcaa6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fdfcd98f002ade3f92038f7c164d45b2e8b7a79
Message-Id: <171320915670.17830.14371772241084945376.pr-tracker-bot@kernel.org>
Date: Mon, 15 Apr 2024 19:25:56 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Apr 2024 10:23:12 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fdfcd98f002ade3f92038f7c164d45b2e8b7a79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

