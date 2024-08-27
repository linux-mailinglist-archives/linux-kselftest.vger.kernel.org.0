Return-Path: <linux-kselftest+bounces-16357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D340695FF87
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB51F212D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 03:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2FA1C6B8;
	Tue, 27 Aug 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paC+r9cp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C3114A90;
	Tue, 27 Aug 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727827; cv=none; b=s85y+KXtHK5/mM2qmkkLII+dyqY7XtmSftrBBqY6ZN1Zko80qh8KPA2hySzHIHVv70yR1Lnongj7tTkMjcmCuiTBPGFHE4vEsyzuUvdY9P/wyDDUwzHuiBjq07z32QKxhaOk93m81J56fqglOVpAGaj9S9G264paHtC3Ys5KuZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727827; c=relaxed/simple;
	bh=7gL6p1VlDvGym36gs1yc1aMIXOWSsJdQLUDxonxuf5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXeZvrRh9VYBNZf6rYblzhAH4E78z1ww+YvpRug6hPmsNWRnajG7Jqe7/9MBu1daGgeBdJ0ZGntPiAsO9XprQW8hgw4qmPCtz5xK4T/B1QXlJt/OhJGzq/By00ts6/CT8bT2LxZZXBskyzJJFRmOTeKry+NeKSbaK08vrpb4qeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paC+r9cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD5EC8B7B3;
	Tue, 27 Aug 2024 03:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727827;
	bh=7gL6p1VlDvGym36gs1yc1aMIXOWSsJdQLUDxonxuf5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=paC+r9cpn7IVTlF+jU4zauq/8YM7Lb+Cl4FBTEHaY/U6d6YhjE7SlIJiPF33+guWo
	 IkT34TNvb/6HejK6sBnPS7aH5vxH3yMB+CqN41Wu4brdSMDzPgAoiWOT2/xNM9mPbJ
	 w+CYIdEazgEn4gdy8sbnlVwL1c3TpbzEe7R3qDaZmveAlBkgQDFKyrmr4P/RiXwpBj
	 HYI1HCWiwiUoe9tWaA/RCtr/KsiuD2ZC312bAwYckYDCwJKzfDpc5oY3AmNDTry7oY
	 kXltfkhImupOC6VkkEiVKE0Bfqf/MGqjBxuiTOIQstBDhk9GoxR8xeqNmtxEJyiCHC
	 DzoJQZlrHb6aA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] selftests/damon: add execute permissions to test scripts
Date: Mon, 26 Aug 2024 20:03:30 -0700
Message-Id: <20240827030336.7930-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827030336.7930-1-sj@kernel.org>
References: <20240827030336.7930-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some test scripts are missing executable permissions.  It causes
warnings that make the test output unnecessarily verbose.  Add
executable permissions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
Andrew, please note that this patch is for adding the execution
permission to the files.  I guess these need a special handling for your
tooling.

 tools/testing/selftests/damon/damon_nr_regions.py                 | 0
 tools/testing/selftests/damon/damos_apply_interval.py             | 0
 tools/testing/selftests/damon/damos_quota.py                      | 0
 tools/testing/selftests/damon/damos_quota_goal.py                 | 0
 tools/testing/selftests/damon/damos_tried_regions.py              | 0
 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh      | 0
 .../damon/debugfs_target_ids_read_before_terminate_race.sh        | 0
 .../selftests/damon/sysfs_update_schemes_tried_regions_hang.py    | 0
 .../damon/sysfs_update_schemes_tried_regions_wss_estimation.py    | 0
 9 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/damon/damon_nr_regions.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_apply_interval.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_quota_goal.py
 mode change 100644 => 100755 tools/testing/selftests/damon/damos_tried_regions.py
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
 mode change 100644 => 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py

diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_apply_interval.py b/tools/testing/selftests/damon/damos_apply_interval.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_quota_goal.py b/tools/testing/selftests/damon/damos_quota_goal.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/damos_tried_regions.py b/tools/testing/selftests/damon/damos_tried_regions.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh b/tools/testing/selftests/damon/debugfs_target_ids_pid_leak.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh b/tools/testing/selftests/damon/debugfs_target_ids_read_before_terminate_race.sh
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
old mode 100644
new mode 100755
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
old mode 100644
new mode 100755
-- 
2.39.2


