Return-Path: <linux-kselftest+bounces-1712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DA480F71F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3212228203F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA46363580;
	Tue, 12 Dec 2023 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X95NT4af"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583563564;
	Tue, 12 Dec 2023 19:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFA9C433C8;
	Tue, 12 Dec 2023 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702410499;
	bh=igd2RnhMFXzUjNiscTu9eDHYyW+3+ewG3ZKhV0p4XGo=;
	h=From:To:Cc:Subject:Date:From;
	b=X95NT4afRyAWsTbccHx94B2W6zzknjz9JqcA0ko1z5FUEoNTBl7Ci88oljGXp5l9U
	 +MDcVdzohghe0yxN+qav+YX16YRFRiO+7n0a8yfPKE5Uv67CS+rgZwxKw5LG992pcM
	 lbTYfra/SJ7b4EozxyjCKF1bAGwmlHxKPhxXy1v2Nvs2LbNJMePXF0xOTsZQYoCqfe
	 42knU6Y/QcMzxziq4TBYGFQRm/HBIjSLfGUfqDg779PmkHUf0g4D2seuunMQv8Iko6
	 TbOwyb4nfQfs8hqd+lo5mt5Lt7Zr899nMncYM4jKYErwoVCVsm49Znn3CKIpO7n9k1
	 FjYLmCmvp/u8w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] selftests/damon: add Python-written DAMON functionality tests
Date: Tue, 12 Dec 2023 19:48:05 +0000
Message-Id: <20231212194810.54457-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1
(https://lore.kernel.org/damon/20231212191206.52917-1-sj@kernel.org/)
- Fix conflicts on latest mm-unstable tree

Changes from RFC
(https://lore.kernel.org/damon/20231202000806.46210-1-sj@kernel.org/)
- Make the working set size estimation test more reliable
- Wordsmith coverletter and commit messages
- Rename _damon.py to _damon_sysfs.py

DAMON exports most of its functionality via its sysfs interface.  Hence
most DAMON functionality tests could be implemented using the interface.
However, because the interfaces require simple but multiple operations
for many controls, writing all such tests from the scratch could be
repetitive and time consuming.

Implement a minimum DAMON sysfs control module, and a couple of DAMON
functionality tests using the control module.  The first test is for
ensuring minimum accuracy of data access monitoring, and the second test
is for finding if a previously found and fixed bug is introduced again.

Note that the DAMON sysfs control module is only for avoiding
duplicating code in tests.  For convenient and general control of DAMON,
users should use DAMON user-space tools that developed for the purpose,
such as damo[1].

[1] https://github.com/damonitor/damo

Patches Sequence
----------------

This patchset is constructed with five patches.  The first three patches
implement a Python-written test implementation-purpose DAMON sysfs
control module.  The implementation is incrementally done in the
sequence of the basic data structure (first patch) first, kdamonds start
command (second patch) next, and finally DAMOS tried bytes update
command (third patch).

Then two patches for implementing selftests using the module follows.
The fourth patch implements a basic functionality test of DAMON for
working set estimation accuracy.  Finally, the fifth patch implements a
corner case test for a previously found bug.

SeongJae Park (5):
  selftests/damon: implement a python module for test-purpose DAMON
    sysfs controls
  selftests/damon/_damon_sysfs: implement kdamonds start function
  selftests/damon/_damon_sysfs: implement updat_schemes_tried_bytes
    command
  selftests/damon: add a test for update_schemes_tried_regions sysfs
    command
  selftests/damon: add a test for update_schemes_tried_regions hang bug

 tools/testing/selftests/damon/Makefile        |   3 +
 tools/testing/selftests/damon/_damon_sysfs.py | 322 ++++++++++++++++++
 tools/testing/selftests/damon/access_memory.c |  41 +++
 ...sysfs_update_schemes_tried_regions_hang.py |  33 ++
 ...te_schemes_tried_regions_wss_estimation.py |  55 +++
 5 files changed, 454 insertions(+)
 create mode 100644 tools/testing/selftests/damon/_damon_sysfs.py
 create mode 100644 tools/testing/selftests/damon/access_memory.c
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py


base-commit: 091b8c820de390a6235595bdb281edab63b9befe
-- 
2.34.1


