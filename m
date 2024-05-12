Return-Path: <linux-kselftest+bounces-10110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC18C361D
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2024 12:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F7A1F212A0
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 May 2024 10:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3919A1CD24;
	Sun, 12 May 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="n6YJ3OFJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA821CAB8
	for <linux-kselftest@vger.kernel.org>; Sun, 12 May 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715511436; cv=none; b=I0g+dwAlLo5nDox3+68zXKcuFB83k7oY8zlV0V7DVcvvsYcdkaR1e/YRwL8nSuSWdFPyodm7iNlFg2S5xVbLqWD1mMTQCIHeMl7Vab1WIUXJjB6fEqVOmGO9FQ8u+TjKMfi+fEha0CHlVNxJweF9fW4yqVo2cXWrxC+fprhQaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715511436; c=relaxed/simple;
	bh=6K4mWNvEVxf0D2mRiXc39TcNks2VNhZHAk+y2vumSe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+7ApqDPTMfyaTKnk9agVVrCXLAASiiRop95qZ5xjc6OTKGkrSLRT/34NCtBo49BPJHiWQUATsBcGZ2EBQyRwGbuyiGj/1PnQJbWiG1Mqp3YTDKONnHpdKD2Z1gGgcl2dzF0qzzWcwXgSV1p0IZKmJXiFgnSFS59K7Fd3ggH6Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=n6YJ3OFJ; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VcfhN47xpz8FW;
	Sun, 12 May 2024 12:57:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715511428;
	bh=EF6C0AxPKx3Rr03GQ/CspouJVXujlSY9SWJekRRc0Os=;
	h=From:To:Cc:Subject:Date:From;
	b=n6YJ3OFJwTnXQvwJ4HS013+4irGRMaBZALgIxTdqhZjQePQHEvGh4GwBQBsm65kk/
	 ap/bEUMY6n1Nyn70uRmzx2TbxXSNTkJbgvt2haeKKIvfzh0qApCIGV29D3VF98GW+/
	 OipiXDgU0T5SGRmmDfU/JgUzw54SgpPWuYfoI8FE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VcfhL1ln1zKlP;
	Sun, 12 May 2024 12:57:06 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
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
	netdev@vger.kernel.org
Subject: [GIT PULL] Kselftest fixes for v6.9
Date: Sun, 12 May 2024 12:56:57 +0200
Message-ID: <20240512105657.931466-1-mic@digikod.net>
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

Without reply from Shuah, and given the importance of these fixes [1], here is
a PR to fix Kselftest (broken since v6.9-rc1) for at least KVM, pidfd, and
Landlock.  I cannot test against all kselftests though.  This has been in
linux-next since the beginning of this week, and so far only one issue has been
reported [2] and fixed [3].

Feel free to take this PR if you see fit.

Regards,
 Mickaël

[1] https://lore.kernel.org/r/Zjo1xyhjmehsRhZ2@google.com
[2] https://lore.kernel.org/r/202405100339.vfBe0t9C-lkp@intel.com
[3] https://lore.kernel.org/r/20240511171445.904356-1-mic@digikod.net

--
The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/kselftest-fix-vfork-2024-05-12

for you to fetch changes up to 323feb3bdb67649bfa5614eb24ec9cb92a60cf33:

  selftests/harness: Handle TEST_F()'s explicit exit codes (2024-05-11 19:18:47 +0200)

----------------------------------------------------------------
Fix Kselftest's vfork() side effects

See https://lore.kernel.org/r/20240511171445.904356-1-mic@digikod.net

----------------------------------------------------------------
Mickaël Salaün (10):
      selftests/pidfd: Fix config for pidfd_setns_test
      selftests/landlock: Fix FS tests when run on a private mount point
      selftests/harness: Fix fixture teardown
      selftests/harness: Fix interleaved scheduling leading to race conditions
      selftests/landlock: Do not allocate memory in fixture data
      selftests/harness: Constify fixture variants
      selftests/pidfd: Fix wrong expectation
      selftests/harness: Share _metadata between forked processes
      selftests/harness: Fix vfork() side effects
      selftests/harness: Handle TEST_F()'s explicit exit codes

 tools/testing/selftests/kselftest_harness.h      | 127 +++++++++++++++++------
 tools/testing/selftests/landlock/fs_test.c       |  83 +++++++++------
 tools/testing/selftests/pidfd/config             |   2 +
 tools/testing/selftests/pidfd/pidfd_setns_test.c |   2 +-
 4 files changed, 147 insertions(+), 67 deletions(-)

