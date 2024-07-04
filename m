Return-Path: <linux-kselftest+bounces-13200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDF7927698
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 14:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C361F2412B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8C61AED4C;
	Thu,  4 Jul 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="v5xkoXT9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF501AED3E
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Jul 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097836; cv=none; b=D3rS2gdA+AXKPbO+Psg7Y0Qfd9eg+eSNAYm0p8JK6DTsAbrOwIMtcgrlqAyeJ921Qan6HfHpBkP2ndXVA1qsTlIBqXmfEO7qCd/uRuev2S+AT2Grh+lpMW/GYoekC8b/KX9vUir62PmkYV+RBK8uox0LaT78iueTCUrmY53iiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097836; c=relaxed/simple;
	bh=bqLxJ3KS7JelbDmZbufg+3QXF9H7AsCpHI8xNEyWlAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bh0PadTYXbSuhfMZjw29H5yTJBe8xdTXIcHtH8D2zfRyJW+bJCC2IEZea6c3D18scUFe/yXzQLdj7n3NntoiK2lwyGbjBYIuvTRVaCFV+P3Og57I+EnjI4CoICkeIXyYc5LWz+Q0antNzv6fyc0mK/ym+FjgCCfRPpEep9GbLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=v5xkoXT9; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WFGR31j82zGlt;
	Thu,  4 Jul 2024 14:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720096718;
	bh=oswOPQ88LI9ZZ4dLvGzzNSGgsrVZFJ4bTKOLf0jSje0=;
	h=From:To:Cc:Subject:Date:From;
	b=v5xkoXT9pt4oLWpOuURpdCIOvi1n0uymB7k3u96ouDEmBvC0lD8MqV90lJsEHNyxb
	 9LLj8NgKnPtojW0nAYAXI0k6VeBhNqPxWqzsReKLhg7KTFIRy0m7YhBk+U7Lzlswft
	 y8jT8CBMTr2/BYwxKDDCRKEfmdIRJHlyzwNZgOZo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WFGQy0YxQz14Q;
	Thu,  4 Jul 2024 14:38:33 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jon Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [GIT PULL] Kselftest fixes for v6.10
Date: Thu,  4 Jul 2024 14:38:16 +0200
Message-ID: <20240704123816.669022-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR fixes a few kselftests [1].  This has been in linux-next for a week and
rebased to add Mark Brown's Tested-by.  The race condition found while writing
this fix is not new and seems specific to UML's hostfs (I also tested against
ext4 and btrfs without being able to trigger this issue).

Feel free to take this PR if you see fit.

Regards,
 Mickaël

[1] https://lore.kernel.org/r/9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk

--
The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/kselftest-fix-2024-07-04

for you to fetch changes up to 130e42806773013e9cf32d211922c935ae2df86c:

  selftests/harness: Fix tests timeout and race condition (2024-06-28 16:06:03 +0200)

----------------------------------------------------------------
Fix Kselftests timeout and race condition

----------------------------------------------------------------
Mickaël Salaün (1):
      selftests/harness: Fix tests timeout and race condition

 tools/testing/selftests/kselftest_harness.h | 43 ++++++++++++++++-------------
 1 file changed, 24 insertions(+), 19 deletions(-)

