Return-Path: <linux-kselftest+bounces-993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A04308018B1
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 01:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0881F2107C
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E88193;
	Sat,  2 Dec 2023 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8GrkEMH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108ADEA8;
	Sat,  2 Dec 2023 00:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF17C433C7;
	Sat,  2 Dec 2023 00:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475689;
	bh=A1C2zs2bNcPgxvWmPkcCx7AYSR8F7j9qABqqkUnLgSo=;
	h=From:To:Cc:Subject:Date:From;
	b=r8GrkEMHKqnkzCBxXV6dk0fxj2hTrFflggLRLPq6CrikzGUQ5hYicqP17L4pqk5NL
	 Kvqe9zz5t9W1mV8znjB0kuJ4IkkBiUTPOonMYIk3B+hPQqFdmt9wEd6qBojTO6X6y3
	 VaF7fIoMCcnsZ6IuXrbJQ6Q22BzyAY+dfkcgJBrg76baKN3JK/XJx8b+rQimNIWkr2
	 FI0XLIJZ9d9eDnKddcwIzMG+PHxfpY8uOfAZBS92pH3kTqaovu87UFYYgPaoOV+2iX
	 mUSzyhjCX3Be3paIV1thkachdpMZGQgEWmMK9DDpQFtn8QRq2Oz5CEE4I/GNzG/gyn
	 Xg6V2D4b6/Rrw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] selftests/damon: add Python modules for DAMON control and functionality tests
Date: Sat,  2 Dec 2023 00:08:01 +0000
Message-Id: <20231202000806.46210-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON provides almost all control to the user via its sysfs interface.
For that, the interface provides plenty of files and hierarchies.  The
interface is simple enough to be controlled by shell commands including
'cat', 'echo', and redirection.  However, due to the number of files and
the hierarchies, doing that repeatedly is quite tedious.  As a result,
DAMON selftests are containing only simple test cases rather than real
functionality tests.  Having a wrapper script that can be reused to
implement more functionality tests could be helpful.  Writing such
wrapper with shell script might be challenging and not easy to further
maintain and extend for future DAMON interface extensions, though.

To this end, implement a Python-written DAMON sysfs interface wrapper
that could be easily managed and extended for future DAMON interface
extensions.  Further implement one simple functionality test and a
corner case regression test for a previously found bug, using the
wrapper module.  In fact, the bug was found by the test this patchset is
introducing.

Note that the Python wrapper is not supporting full features of DAMON
interface, but only some of those that essential for the tests that this
patchset is introducing.  The wrapper would extended to support more
features, but only with essential ones for such future tests.  The
wrapper will hence keep being simple, small, and constrained.  For
convenient and general use cases of DAMON, users should use DAMON
user-space tools for such purpose, like damo[1].

[1] https://github.com/damonitor/damo

Patches Sequence
----------------

This patchset is constructed with five patches.  The first three patches
implement the Python-written DAMON sysfs interface wrapper in small
steps.  The basic data structure (first patch), kdamond startup command
(second patch), and finally DAMOS tried bytes command (third patch).

Then two patches for adding selftests using the wrapper follows.  The
fourth patch implements a basic functionality test of DAMON for working
set estimation accuracy.  Finally, the fifth patch implements a corner
case test for a previously found bug.

SeongJae Park (5):
  selftests/damon: add a DAMON interface wrapper python module
  selftests/damon/_damon: implement sysfs-based kdamonds start function
  selftests/damon/_damon: implement sysfs updat_schemes_tried_bytes
    command
  selftests/damon: add a test for update_schemes_tried_regions sysfs
    command
  selftests/damon: add a test for update_schemes_tried_regions hang bug

 tools/testing/selftests/damon/Makefile        |   3 +
 tools/testing/selftests/damon/_damon.py       | 322 ++++++++++++++++++
 tools/testing/selftests/damon/access_memory.c |  41 +++
 ...sysfs_update_schemes_tried_regions_hang.py |  33 ++
 ...te_schemes_tried_regions_wss_estimation.py |  48 +++
 5 files changed, 447 insertions(+)
 create mode 100644 tools/testing/selftests/damon/_damon.py
 create mode 100644 tools/testing/selftests/damon/access_memory.c
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py


base-commit: 1be383c41197b82cfd51b2edc7ee515c0b786496
-- 
2.34.1


