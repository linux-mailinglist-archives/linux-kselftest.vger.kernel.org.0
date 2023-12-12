Return-Path: <linux-kselftest+bounces-1699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1886A80F632
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61701F210F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 19:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A328005B;
	Tue, 12 Dec 2023 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ/ZB6cd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475380053;
	Tue, 12 Dec 2023 19:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E6EC433C8;
	Tue, 12 Dec 2023 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702408331;
	bh=6tke9Mw73/PmV6sucCIPXGu5OGZe4EV0PkE+FQKIYKI=;
	h=From:To:Cc:Subject:Date:From;
	b=nJ/ZB6cdaAzYm2iVfPA9pB4Kwf3IsNZ2cd5012uIiLCKnE8RjQKaTJKbdn/8HggFL
	 JvHxekh3fKJhlTDeQ/zSEfKQ1OWLhCItYUItlw4h952ge07YwQt/pxbaaLZkUKcSO1
	 y2M6qwdV5GYGwNYGUk0g7gmKprHI11sKdJcJnpMJPY8ObZmVgS9EQW5V3IByuGOUMA
	 srxSoN8X7xIHv06AGfa73Sp/Fjt1qzTEbq10E/vnpXFmnnPTRvSE4JQxCHPOzfM5nX
	 0NAg5wdjmhAJ3TTdZGF0MpX27kxvyl+Ra8R4VU2barlWQvfHh73WyMAWzgahAqKX/C
	 f2pV37Ciqcc1Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] selftests/damon: add Python-written DAMON functionality tests
Date: Tue, 12 Dec 2023 19:12:01 +0000
Message-Id: <20231212191206.52917-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


base-commit: 5794dfaf6d1be564b0912d51d8a714baff329495
-- 
2.34.1


