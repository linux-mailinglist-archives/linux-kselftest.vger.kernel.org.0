Return-Path: <linux-kselftest+bounces-4275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8E84D2FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B628E481
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 20:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92A61DDC5;
	Wed,  7 Feb 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgtfnZ2H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2F1B942;
	Wed,  7 Feb 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337901; cv=none; b=VsD90LdTGlOVD5roUm9MWkviYH6V/LzUHnL+fu/BeHL6O3iK4e7O7xvFSccWQqZzSBZ7s3T4RGZqzfkptmkTnZLVvdBOKbGpuinQA82ox6yQ14K8HJTjWGiRgGwClqD6t54ycuel8Ii/ijUujvnTW40CxEbNIyuHP3sKrWyp4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337901; c=relaxed/simple;
	bh=SF63Uy/W6gSlPDVcToCt1nQO7SUTdRa2P7SsA0ShYjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZZmTUmgggDswgQadpqHeAscAVBN77VO7omvG0/Rw7uscJNdpvFi0IFFFGPlzl92ftctgrqqXzxN3qS5iFjejqR9ChyhCQ5PM3iqQ4mqA5xtipwPQv7HPWZ7fAF0notebCOOgQVfd+ZyvPxfcNcaRmLCiAR+4CTVwc8cOADkw6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgtfnZ2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520F1C433C7;
	Wed,  7 Feb 2024 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337900;
	bh=SF63Uy/W6gSlPDVcToCt1nQO7SUTdRa2P7SsA0ShYjQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mgtfnZ2HwNFkfRgtZgwVLxmVy7gbrtkqYaqlJBri8LGwuN+Oczb0VxW9S4xI0Ro7B
	 OLA5fWfLDJeod7M0QdiFlXoXFHE8WUQ0YsJafPw8451Wbm1ZfRWbv0ZqvmL8fj2WdW
	 YSOPTnfvNxO1co5/RMQDwIRUVfRARe0qv9Z3JO5/FmFBxR0TdpxptOzSchuVRo03N/
	 bn+hrIlWXRDBi4pOJu6AkIvsBlHClBmtDbsWAAKGP1K9yshrtCRulMj5x0nZNw0ZGJ
	 dZKCiiQ0OVHqxAamNIHI3Krog1qMn0FsaxylaPdVKtCgikasmTboNe6yUq6mEJ0leH
	 j2aN5mXc5STYQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] selftests/damon: add more tests for core functionalities and corner cases
Date: Wed,  7 Feb 2024 12:31:26 -0800
Message-Id: <20240207203134.69976-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continue DAMON selftests' test coverage improvement works with a trivial
improvement of the test code itself.  The sequence of the patches in
patchset is as follows.

The first five patches add two DAMON core functionalities tests.  Those
begins with three patches (patches 1-3) that update the test-purpose
DAMON sysfs interface wrapper to support DAMOS quota, stats, and apply
interval features, respectively.  The fourth patch implements and adds a
selftest for DAMOS quota feature, using the DAMON sysfs interface
wrapper's newly added support of the quota and the stats feature.  The
fifth patch further implements and adds a selftest for DAMOS apply
interval using the DAMON sysfs interface wrapper's newly added support
of the apply interval and the stats feature.

Two patches (patches 6 and 7) for implementing and adding two corner
cases handling selftests follow.  Those try to avoid two previously
fixed bugs from recurring.

Finally, a patch for making DAMON debugfs selftests dependency checker
to use /proc/mounts instead of the hard-coded mount point assumption
follows.

SeongJae Park (8):
  selftests/damon/_damon_sysfs: support DAMOS quota
  selftests/damon/_damon_sysfs: support DAMOS stats
  selftests/damon/_damon_sysfs: support DAMOS apply interval
  selftests/damon: add a test for DAMOS quota
  selftests/damon: add a test for DAMOS apply intervals
  selftests/damon: add a test for a race between target_ids_read() and
    dbgfs_before_terminate()
  selftests/damon: add a test for the pid leak of
    dbgfs_target_ids_write()
  selftests/damon/_chk_dependency: get debugfs mount point from
    /proc/mounts

 tools/testing/selftests/damon/.gitignore      |  2 +
 tools/testing/selftests/damon/Makefile        |  5 ++
 .../selftests/damon/_chk_dependency.sh        |  9 ++-
 tools/testing/selftests/damon/_damon_sysfs.py | 77 ++++++++++++++++--
 .../selftests/damon/damos_apply_interval.py   | 67 ++++++++++++++++
 tools/testing/selftests/damon/damos_quota.py  | 67 ++++++++++++++++
 .../damon/debugfs_target_ids_pid_leak.c       | 68 ++++++++++++++++
 .../damon/debugfs_target_ids_pid_leak.sh      | 22 +++++
 ...fs_target_ids_read_before_terminate_race.c | 80 +++++++++++++++++++
 ...s_target_ids_read_before_terminate_race.sh | 14 ++++
 10 files changed, 403 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/damon/damos_apply_interval.py
 create mode 100755 tools/testing/selftests/damon/damos_quota.py
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.c
 create mode 100755 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.c
 create mode 100755 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh


base-commit: f51e629727d8cc526a3156a2c80489b8f050410f
-- 
2.39.2


