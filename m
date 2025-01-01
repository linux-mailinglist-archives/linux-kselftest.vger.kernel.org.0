Return-Path: <linux-kselftest+bounces-23805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCC9FF4F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jan 2025 22:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35AA718824C6
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jan 2025 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB685931;
	Wed,  1 Jan 2025 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odGBA8SU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA801F5FA;
	Wed,  1 Jan 2025 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735767336; cv=none; b=IlOFwMn+eOFsmiN3dNkeB1NWp9lRzqmnbIiCh/j0StDUVU0Gi+5Ueu/BuK9fagWdjTeFoI5FeFVigvRtOkXZWPGL6EDGMsbxiasQbLEeIiRhQtvX0u5j2PwrH0yvCDJl2RLdp+kbdxNJphb/LCOWHd1tDuMmmJN19MStHS8fgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735767336; c=relaxed/simple;
	bh=VI1FVtTdDy6zRISgwkKnUfrXpXMVcNAmZGQ25y0xwEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=frgIP8Us/CU+ytYsfYM5nVKF142p0j7opsah+SU5XOQpwZ5uplNTeqDpuS90bL8W8Y1iA0rfIDc3dSF2Y2+2WiIPOhN1jkmjZVn8TvfVG+J9zxiw9PbLL/hN3p96haULy/IfnYfX5AguuDuvuw5d0XCMVA5BxhbqHbwr3vQmEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odGBA8SU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48247C4CECE;
	Wed,  1 Jan 2025 21:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735767335;
	bh=VI1FVtTdDy6zRISgwkKnUfrXpXMVcNAmZGQ25y0xwEI=;
	h=From:To:Cc:Subject:Date:From;
	b=odGBA8SUpOMTRk0lWCE5KBuLhXp5s7lgYnpbTfXfVNf4otCnhc5EK1ujpEJAlvuXT
	 HMK5Jm7tqRPDNW9Bm5LG4JLzsAH3kWGHzy++ykCUDDK7i8DmSPndwvdwS/DWl4reTV
	 quUTJjeHjic3oo+V57TmmK2C8z7Qe61jhUzi4UJfDQ0XWa+jk7uOPvYqRFAC5BpX3H
	 uqn5PYO1vRI8AxbSj8z8DTGjCeNLrzDrZ5y9EUPTkYiF6dupQpYOG9rLo7qQeSlzQ8
	 duA4Da+a4Q48HWLUUsX2QEVlcLwk52+QDCMvDd8cEAQTxd2zDNY/c2TI81ZguokdWO
	 4eYcjw+HPzA/g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] mm/damon: remove DAMON debugfs interface
Date: Wed,  1 Jan 2025 13:35:20 -0800
Message-Id: <20250101213527.74203-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON debugfs interface was the only user interface of DAMON at the
beginning[1].  However, it turned out the interface would be not good
enough for long-term flexibility and stability.

In Feb 2022[2], we therefore introduced DAMON sysfs interface as an
alternative user interface that aims long-term flexibility and
stability.  With its introduction, DAMON debugfs interface has announced
to be deprecated in near future.

In Feb 2023[3], we announced the official deprecation of DAMON debugfs
interface.  In Jan 2024[4], we further made the deprecation difficult to
be ignored.

In Oct 2024[5], we posted an RFC version of this patch series as the
last notice.

And as of this writing, no problem or concerns about the removal plan
have reported.  Apparently users are already moved to the alternative,
or made good plans for the change.

Remove the DAMON debugfs interface code from the tree.  Given the past
timeline and the absence of reported problems or concerns, it is safe
enough to be done.

[1] https://lore.kernel.org/20210716081449.22187-1-sj38.park@gmail.com
[2] https://lore.kernel.org/20220228081314.5770-1-sj@kernel.org
[3] https://lore.kernel.org/20230209192009.7885-1-sj@kernel.org
[4] https://lore.kernel.org/20240130013549.89538-1-sj@kernel.org
[5] https://lore.kernel.org/20241015175412.60563-1-sj@kernel.org

Changes from RFC
(https://lore.kernel.org/20241015175412.60563-1-sj@kernel.org)
- Rebased on latest mm-unstable
- Update and wordsmith commit messages

SeongJae Park (7):
  Docs/admin-guide/mm/damon/usage: remove DAMON debugfs interface
    documentation
  Docs/mm/damon/design: update for removal of DAMON debugfs interface
  selftests/damon/config: remove configs for DAMON debugfs interface
    selftests
  selftests/damon: remove tests for DAMON debugfs interface
  kunit: configs: remove configs for DAMON debugfs interface tests
  mm/damon: remove DAMON debugfs interface kunit tests
  mm/damon: remove DAMON debugfs interface

 Documentation/admin-guide/mm/damon/usage.rst  |  309 -----
 Documentation/mm/damon/design.rst             |   23 +-
 mm/damon/Kconfig                              |   30 -
 mm/damon/Makefile                             |    1 -
 mm/damon/dbgfs.c                              | 1148 -----------------
 mm/damon/tests/.kunitconfig                   |    7 -
 mm/damon/tests/dbgfs-kunit.h                  |  173 ---
 tools/testing/kunit/configs/all_tests.config  |    3 -
 tools/testing/selftests/damon/.gitignore      |    3 -
 tools/testing/selftests/damon/Makefile        |   11 +-
 tools/testing/selftests/damon/config          |    1 -
 .../testing/selftests/damon/debugfs_attrs.sh  |   17 -
 .../debugfs_duplicate_context_creation.sh     |   27 -
 .../selftests/damon/debugfs_empty_targets.sh  |   21 -
 .../damon/debugfs_huge_count_read_write.sh    |   22 -
 .../damon/debugfs_rm_non_contexts.sh          |   19 -
 .../selftests/damon/debugfs_schemes.sh        |   19 -
 .../selftests/damon/debugfs_target_ids.sh     |   19 -
 .../damon/debugfs_target_ids_pid_leak.c       |   68 -
 .../damon/debugfs_target_ids_pid_leak.sh      |   22 -
 ...fs_target_ids_read_before_terminate_race.c |   80 --
 ...s_target_ids_read_before_terminate_race.sh |   14 -
 .../selftests/damon/huge_count_read_write.c   |   46 -
 23 files changed, 11 insertions(+), 2072 deletions(-)
 delete mode 100644 mm/damon/dbgfs.c
 delete mode 100644 mm/damon/tests/dbgfs-kunit.h
 delete mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_duplicate_context_creation.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_empty_targets.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_rm_non_contexts.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_schemes.sh
 delete mode 100755 tools/testing/selftests/damon/debugfs_target_ids.sh
 delete mode 100644 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
 delete mode 100755 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
 delete mode 100644 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
 delete mode 100755 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
 delete mode 100644 tools/testing/selftests/damon/huge_count_read_write.c

-- 
2.39.5

