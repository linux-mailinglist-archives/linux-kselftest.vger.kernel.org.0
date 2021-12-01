Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E04650C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbhLAPIW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59458 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhLAPIW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B8B8B81DE4;
        Wed,  1 Dec 2021 15:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6986AC53FAD;
        Wed,  1 Dec 2021 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371099;
        bh=2rXA7LdErl+8+nyOvssms5c1pTevqPeS6Aq7VNyiOuA=;
        h=From:To:Cc:Subject:Date:From;
        b=Xl8JHR/JDs0hMe0Yt/ylVbk9eT6Kf3yMJYObm3aMd8nUYNf3h97ncCVa2wdy6uLcs
         ilvMOAC6FDYXMUz7T3fdvXb1wzfZzD1+J1avMuEFEkLGVUbVEIsL+XJTinq1NIrgxH
         Ha9qGclJZHoBIVbsjHp2gHhxfqDKtJk+3TFyf+tuHob8dj+FffPd8N3mLEX0gJ6zxJ
         MnlSyF/A3oxbJR0bL+971fH0ceWQzdQDG1hAddWE4YNLqPrgaiOimUNQNSYeyyckjQ
         8kV5Db2jYY6IRYHCF1vytpFVHFebuG5CDCqiMSUeGAhM6bMZs0UiZj2RNsOZN3TS/J
         ZZsPYQ5fBFUEw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 00/11] mm/damon: Trivial fixups and improvements
Date:   Wed,  1 Dec 2021 15:04:29 +0000
Message-Id: <20211201150440.1088-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset contains trivial fixups and improvements for DAMON and its
kunit/kselftest tests.

SeongJae Park (11):
  mm/damon/core: Use better timer mechanisms selection threshold
  mm/damon/dbgfs: Remove an unnecessary error message
  mm/damon/core: Remove unnecessary error messages
  mm/damon/vaddr: Remove an unnecessary warning message
  mm/damon/vaddr-test: Split a test function having >1024 bytes frame
    size
  mm/damon/vaddr-test: Remove unnecessary variables
  selftests/damon: Skip test if DAMON is running
  selftests/damon: Test DAMON enabling with empty target_ids case
  selftests/damon: Test wrong DAMOS condition ranges input
  selftests/damon: Test debugfs file reads/writes with huge count
  selftests/damon: Split test cases

 mm/damon/core.c                               | 14 +---
 mm/damon/dbgfs.c                              |  4 +-
 mm/damon/vaddr-test.h                         | 79 +++++++++----------
 mm/damon/vaddr.c                              |  1 -
 tools/testing/selftests/damon/.gitignore      |  2 +
 tools/testing/selftests/damon/Makefile        |  7 +-
 .../selftests/damon/_debugfs_common.sh        | 52 ++++++++++++
 .../testing/selftests/damon/debugfs_attrs.sh  | 73 +----------------
 .../selftests/damon/debugfs_empty_targets.sh  | 13 +++
 .../damon/debugfs_huge_count_read_write.sh    | 22 ++++++
 .../selftests/damon/debugfs_schemes.sh        | 19 +++++
 .../selftests/damon/debugfs_target_ids.sh     | 19 +++++
 .../selftests/damon/huge_count_read_write.c   | 39 +++++++++
 13 files changed, 214 insertions(+), 130 deletions(-)
 create mode 100644 tools/testing/selftests/damon/.gitignore
 create mode 100644 tools/testing/selftests/damon/_debugfs_common.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_empty_targets.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_huge_count_read_write.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_schemes.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids.sh
 create mode 100644 tools/testing/selftests/damon/huge_count_read_write.c

-- 
2.17.1

