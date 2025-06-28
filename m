Return-Path: <linux-kselftest+bounces-36059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B14ADAEC874
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 18:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45786175E80
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10DE218EA8;
	Sat, 28 Jun 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XThsJ7hA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542220A5EC;
	Sat, 28 Jun 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126672; cv=none; b=MgG4AYfqDMzxhZWCMl/IzpuNh916JfdLMHUBGDbg+qX9/owbazMM8lcBhMsRRyknyP4oAm/CI+CO/C2mihC2z3IqFMDvNuHnF/VWS1yyxp1aJb2l66f+Zs13d7QBqjWAQIcKP6UeOck6zzJh8baWRibpH6pClJhws+J8zAA1Xpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126672; c=relaxed/simple;
	bh=ZcBXrTQE/EcC9dDxaVoPJkijonw43CRMpiHHbkq1lhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4jfsGYiPlfcDyCwGjZzM81/aElY+bx9CEOLFagZzI4pm0Eei7I0ba5qYn4PvSaBuaaHrW3e6lJ005vbMvk0j8cubGGWSHshkQkRD5ao4o4GolcmIEhpdC/9sGz7559PP/6Zhwyxwsv2vEgxhgVCVTaFYFsAt3abCC/SW95suEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XThsJ7hA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE853C4CEEA;
	Sat, 28 Jun 2025 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126672;
	bh=ZcBXrTQE/EcC9dDxaVoPJkijonw43CRMpiHHbkq1lhE=;
	h=From:To:Cc:Subject:Date:From;
	b=XThsJ7hAgV6a8xSt6c55FYLJn0tcO+6YwzPCau0ZeM05nHNa/XXRbQEnVE7//i18N
	 gXp8xh1FMfVPjYIzjcRc3eOeLoKB1mMHTT6XVbQnRdeKKsLyHVtgJY/OVWA6RupmEh
	 1dmRFYY71+URBRbg5Ocw3EQxypv+MUBPLQpO5/p4YEQzJMWyJGnP1216CrC0N/hfJo
	 UCk+Avr2zCOzZUNDBjz+DIfaNMUGHTkTiuW8jtOrZTZrWkTmfF1i01azhdaU+xujIT
	 oUp0lH0nW8/4nnpfd2BYi6rH6BDSseGIN7nPwnVuhS4WwPxeKTsjckNNbBhwiHAlES
	 2R7AU9ISqp++A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] selftests/damon: add python and drgn based DAMON sysfs functionality tests
Date: Sat, 28 Jun 2025 09:04:22 -0700
Message-Id: <20250628160428.53115-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is the bridge between the user space and the
kernel space for DAMON parameters.  There is no good and simple test to
see if the parameters are set as expected.  Existing DAMON selftests
therefore test end-to-end features.  For example, damos_quota_goal.py
runs a DAMOS scheme with quota goal set against a test program running
an artificial access pattern, and see if the result is as expected.
Such tests cover only a few part of DAMON.  Adding more tests is also
complicated.  Finally, the reliability of the test itself on different
systems is bad.

'drgn' is a tool that can extract kernel internal data structures like
DAMON parameters.  Add a test that passes specific DAMON parameters via
DAMON sysfs reusing _damon_sysfs.py, extract resulting DAMON parameters
via 'drgn', and compare those.  Note that this test is not adding
exhaustive tests of all DAMON parameters and input combinations but very
basic things.  Advancing the test infrastructure and adding more tests
are future works.

Changes from RFC
(https://lore.kernel.org/20250622210330.40490-1-sj@kernel.org)
- Rebase on latest mm-new

SeongJae Park (6):
  selftests/damon: add drgn script for extracting damon status
  selftests/damon/_damon_sysfs: set Kdamond.pid in start()
  selftests/damon: add python and drgn-based DAMON sysfs test
  selftests/damon/sysfs.py: test monitoring attribute parameters
  selftests/damon/sysfs.py: test adaptive targets parameter
  selftests/damon/sysfs.py: test DAMOS schemes parameters setup

 tools/testing/selftests/damon/Makefile        |   1 +
 tools/testing/selftests/damon/_damon_sysfs.py |   3 +
 .../selftests/damon/drgn_dump_damon_status.py | 161 ++++++++++++++++++
 tools/testing/selftests/damon/sysfs.py        | 115 +++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100755 tools/testing/selftests/damon/drgn_dump_damon_status.py
 create mode 100755 tools/testing/selftests/damon/sysfs.py


base-commit: 5ab6feac2d83ebbf0d0d2eedf0505878ba677dcb
-- 
2.39.5

