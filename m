Return-Path: <linux-kselftest+bounces-16354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C23F95FF84
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC27B2249B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 03:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D54175AB;
	Tue, 27 Aug 2024 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPGrbBE7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD104C83;
	Tue, 27 Aug 2024 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727821; cv=none; b=h4A/OGYvEqscTVRtg7Ne1OFXF6caoh7nd02JSSnsZVSxO1K1VVkfGa5EaBft+hXBQjUUJnPmkgpyq2rYxsyq77qY9Y2LvDjKHS1B8zOR7JLPo0DZue0WMQ57FI7MtSln+9wedUcEodBjdG9CxNrKK7oyNto/bc4V0xxGsjEfQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727821; c=relaxed/simple;
	bh=ryZY5o9HuHU/D4euC7qhLwDsJinJHJ8d0ysi5lUw5z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbrwUJiVVBQna/oJC5DbLAG4HyUjH6TjqlgV03+ZHY8EsIW2VgR3HMGGeGDGTMYcF2Z85l8b/rLMUY48so8zbeUMEkKqcnq4gQF/TdgeIOPlizNducP+kuPqiyiRjxasanpinij08Smg+VwxBFwSE00+EnHkr9vAzdEe4i8MwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPGrbBE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3257C8B7A1;
	Tue, 27 Aug 2024 03:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727820;
	bh=ryZY5o9HuHU/D4euC7qhLwDsJinJHJ8d0ysi5lUw5z4=;
	h=From:To:Cc:Subject:Date:From;
	b=sPGrbBE7l3XhXTJrmM1oa4OWHeDebs+5b+eKjhg79zQXzrStyKy3pn+QCcCt0uoC5
	 2kcOT3BC10wM0CUgjmAyXHRoMDLFdar370ryl9KhCivWDmaPrI+HkHtceECz0wsyiv
	 oWP5Nv6fYqUZpju8sO4oYJj/WC7T6mNV9K4LfVqSV2DiL5X7AygnaQ4dY/Bv7N2tTM
	 2yZo4obc4lNPJc5RnAxoU3k+IPPMlXBNpZDYGSGem5CBAlUK2MRyYnduwa/cLTwG5t
	 IKoYRUPAfr40c7V88byNL5k9qxnSqOUMKVTS5vYvd2KooYJxLUv6lS5cUGXxbhBdCJ
	 wmsH1dYx07Jzg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] misc fixups for DAMON {self,kunit} tests
Date: Mon, 26 Aug 2024 20:03:27 -0700
Message-Id: <20240827030336.7930-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is for minor fixups of DAMON selftests and kunit tests.
First three patches make DAMON selftests more cleanly maintained
(patches 1 and 2) without unnecessary warnings (patch 3).  Following six
patches remove unnecessary test case (patch 4), handle configs
combinations that can make tests fail (patches 5-7), reorganize the test
files following the new guideline (patch 8), and add reference
kunitconfig for DAMON kunit tests (patch 9).

SeongJae Park (9):
  selftests/damon: add access_memory_even to .gitignore
  selftests/damon: cleanup __pycache__/ with 'make clean'
  selftests/damon: add execute permissions to test scripts
  mm/damon/core-test: test only vaddr case on ops registration test
  mm/damon/core-test: fix damon_test_ops_registration() for DAMON_VADDR
    unset case
  mm/damon/dbgfs-test: skip dbgfs_set_targets() test if PADDR is not
    registered
  mm/damon/dbgfs-test: skip dbgfs_set_init_regions() test if PADDR is
    not registered
  mm/damon: move kunit tests to tests/ subdirectory with _kunit suffix
  mm/damon/tests: add .kunitconfig file for DAMON kunit tests

 mm/damon/core.c                               |  2 +-
 mm/damon/dbgfs.c                              |  2 +-
 mm/damon/sysfs.c                              |  2 +-
 mm/damon/tests/.kunitconfig                   | 22 ++++++++++++++++++
 mm/damon/{core-test.h => tests/core-kunit.h}  | 23 ++++++++++++++-----
 .../{dbgfs-test.h => tests/dbgfs-kunit.h}     | 10 ++++++++
 .../{sysfs-test.h => tests/sysfs-kunit.h}     |  0
 .../{vaddr-test.h => tests/vaddr-kunit.h}     |  0
 mm/damon/vaddr.c                              |  2 +-
 tools/testing/selftests/damon/.gitignore      |  1 +
 tools/testing/selftests/damon/Makefile        |  2 ++
 .../selftests/damon/damon_nr_regions.py       |  0
 .../selftests/damon/damos_apply_interval.py   |  0
 tools/testing/selftests/damon/damos_quota.py  |  0
 .../selftests/damon/damos_quota_goal.py       |  0
 .../selftests/damon/damos_tried_regions.py    |  0
 .../damon/debugfs_target_ids_pid_leak.sh      |  0
 ...s_target_ids_read_before_terminate_race.sh |  0
 ...sysfs_update_schemes_tried_regions_hang.py |  0
 ...te_schemes_tried_regions_wss_estimation.py |  0
 20 files changed, 56 insertions(+), 10 deletions(-)
 create mode 100644 mm/damon/tests/.kunitconfig
 rename mm/damon/{core-test.h => tests/core-kunit.h} (96%)
 rename mm/damon/{dbgfs-test.h => tests/dbgfs-kunit.h} (94%)
 rename mm/damon/{sysfs-test.h => tests/sysfs-kunit.h} (100%)
 rename mm/damon/{vaddr-test.h => tests/vaddr-kunit.h} (100%)
 mode change 100644 => 100755 tools/testing/selftests/damon/damon_nr_regions.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_apply_interval.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota_goal.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_tried_regions.py
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py


base-commit: ac23a0bb201e9916faa357d51c387e523813b4ad
-- 
2.39.2


