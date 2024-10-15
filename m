Return-Path: <linux-kselftest+bounces-19766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604B199F472
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097311F24FE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D401F76D9;
	Tue, 15 Oct 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npxNuknr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168B16EBE8;
	Tue, 15 Oct 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014862; cv=none; b=If7rWz1guHfLSaUQzOGG0cyWYZprn2bRgRVqMD38+629uOkkdKCMwk7pchP7j2WYYQRnmM5u0mcOuUduVGOMNEA9SMpkmUqp5/Y2S2FqNfG/EM1PhVe5QrV6bMMdamwiLXziAVi/oCGUTVh/vrBI4WtOQSyNGdFCVpcMWW9dWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014862; c=relaxed/simple;
	bh=WfG2PlaOTZkS3YXMbBJ7ZIAnb6kLrko4vWQD4DTsP0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=azIelJEJQjcQI874yptueUgRo8KXXkXe7J5XdNW73XBzhDrE6qaKRisLXEnt+ox/SJw/i+Ol514lpDUDxJ5y2esg23502W3ermrnSuyr/2mdXN/Pz5gwcUulDIdjEY605/+JuluJ/woM5zYxs7MoKYSOhOPuTg40YCBLSkHFz78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npxNuknr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB23C4CEC6;
	Tue, 15 Oct 2024 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729014861;
	bh=WfG2PlaOTZkS3YXMbBJ7ZIAnb6kLrko4vWQD4DTsP0Q=;
	h=From:To:Cc:Subject:Date:From;
	b=npxNuknrOhCHHHWob+cHkhRkt34VVmZhX+xzacT++fxFr18Imzs+dSoMrz+BnPvlB
	 +uT+MsJXmvEKYvzoiDmCwc5Z22jS5iUXsk9nhpqL6QqVGjVwFpKjvU5SwoaYPaY7FN
	 S+3bxG+j/BB5QGilOQvry3CWna3EHZtezuJCgcVdNOor3RRypOGNaxci4zjCvviuet
	 Bp4gA+tYeU4Ai0Gea7SZYu7UjcHXuiZG7SB/rSVczzDRcDc8YIc60zTx3ZIn+Db9BC
	 llJgZqSE6xRV9dpEIU4HXVG/2yEUJRO+Awaukul8n12u3pYghwf2wPfvaq4kXi2Na6
	 /MexoYtNdW/vQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] mm/damon: remove DAMON debugfs interface
Date: Tue, 15 Oct 2024 10:54:05 -0700
Message-Id: <20241015175412.60563-1-sj@kernel.org>
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

And as of this writing (2024-10-14), no problem or concerns about the
deprecation have reported.  Apparently users are already moved to the
alternative, or made good plans for the change.

Remove the DAMON debugfs interface code from the tree.  Given the past
timeline and the absence of reported problems or concerns, it is safe
enough to be done.  That said, we will not drop the RFC tag of this
patch series at least until the end of this year, to use this as the
real last call for users.

[1] https://lore.kernel.org/20210716081449.22187-1-sj38.park@gmail.com
[2] https://lore.kernel.org/20220228081314.5770-1-sj@kernel.org
[3] https://lore.kernel.org/20230209192009.7885-1-sj@kernel.org
[4] https://lore.kernel.org/20240130013549.89538-1-sj@kernel.org

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
 .../selftests/damon/huge_count_read_write.c   |   48 -
 23 files changed, 11 insertions(+), 2074 deletions(-)
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


base-commit: 5ef943709a1b88304aa6e8cb8683a25bf81874f0
-- 
2.39.5


