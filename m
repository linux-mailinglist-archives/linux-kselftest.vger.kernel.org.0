Return-Path: <linux-kselftest+bounces-42664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA4FBB27C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 02 Oct 2025 06:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203F242751A
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Oct 2025 04:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D851DE8BB;
	Thu,  2 Oct 2025 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv7qluA+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A528FD;
	Thu,  2 Oct 2025 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759380414; cv=none; b=Vv7zQljZiZSE/Utf7bD7sg4mkcGsycjQo7O+hQXTM38H5UclyuWGm33obg7PNCfK4fdfKs7xlINYb8gzYD1ThPs8YzcSXoksyWP5SvO+WPu8t9a09IxI0Qrrl4wiDokLdeRQE3otE1b/S8xDvKrOhJNFag4g/Prk8pak+aqreeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759380414; c=relaxed/simple;
	bh=gZB6xSS4heIm8VJUqxRhIUlkJVLfARvCCqPijgkG1Sw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DXCbXMqm1K5y2odFkTo18Dbp1Difp2+G66/oI/LIjL2PDqehKq1mourt45kDnNKoioQuk0ZqbEWaKxg+cZoZ6epk536PZC/YNfRhGQfnk8CXQaoh6Z8Oe172zIglHgzon/ShHHvBcQ23dxa3RNT4NVl9vcxr0aHTJwY9RbUUglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv7qluA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088CFC4CEF9;
	Thu,  2 Oct 2025 04:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759380414;
	bh=gZB6xSS4heIm8VJUqxRhIUlkJVLfARvCCqPijgkG1Sw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dv7qluA+DUUIKuwwLKQNwhCDn6GLvSSsLpyqDnxx+5w/Hg7oSiBSmI6wjnNGJ3Vs8
	 gS4h78TRZQcnZMhS8cxW8tXKfuGyAR5sl/BD/L2R30L777z/1c/3bVHX9Pyar1GNqs
	 STGjtrQcdmvicDTKxuBD4tHyNnwhep5Vg331kA7nvqH2JptW8MEOsIE9zeMJbcvVQ9
	 Cvy/6HIJ4Wblcch3P11AXd5iqi07cZdDeqqZYhMLelWyRtRoTyqwtyyLf46zEMkkaj
	 P1hjfxg4bJ/MEWocIQE+w7RY1Qk0PEG0IyIgb+SKIQNVCH74zRdIoPnjLyLXkQyXKX
	 X5mPGMBUl+guw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FC739D0C1A;
	Thu,  2 Oct 2025 04:46:47 +0000 (UTC)
Subject: Re: [GIT PULL] kunit next update for Linux 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <94479be9-3147-419b-aad9-8cd2a95b62fc@linuxfoundation.org>
References: <94479be9-3147-419b-aad9-8cd2a95b62fc@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kselftest.vger.kernel.org>
X-PR-Tracked-Message-Id: <94479be9-3147-419b-aad9-8cd2a95b62fc@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.18-rc1
X-PR-Tracked-Commit-Id: 285cae57a51664cc94e85de0ff994f9965b3aca8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30bbcb44707a97fcb62246bebc8b413b5ab293f8
Message-Id: <175938040592.2758529.12550845408024656718.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 04:46:45 +0000
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 16:39:35 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30bbcb44707a97fcb62246bebc8b413b5ab293f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

