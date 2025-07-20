Return-Path: <linux-kselftest+bounces-37687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712BAB0B714
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B9175D2A
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F531EE033;
	Sun, 20 Jul 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBoPJ0m9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF301CFBC;
	Sun, 20 Jul 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031817; cv=none; b=MhSMKLv9WE/oSH7lcUaJrpeHP+OGRhuQkiQxASCkKi0sQAJPAHM0XPy2cMA7LSiBLsr8bvxKXelpKOJDt/iM5kCiAheC2lFYptiCTGmGZPMGlJS8ad6QrQRLVxPHbYZ8lGSLzRuqbj4xkJmlEsUpUlW4ETSUmNyVDB+7TrFYU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031817; c=relaxed/simple;
	bh=CcG3DB5w4RBV9H55Eghl8rFNG8gQYXS7ULzywhnSNGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/yhlUJNl4wRpwuFxfK+R+/K//+7PnbLkjpZZjstq8VLq8ro60txD4j2iOYwuFegdjn5MO56+R5uFZtt5LXeZThu6mHPOHnhOWz1o83+rYi8OChsYs72AbjJ3t+JuFGzMh7+MwnaPiySmDTvOMhjSeDKgypOAJKsQ5owSKp3s30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBoPJ0m9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71C6C4CEE7;
	Sun, 20 Jul 2025 17:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031816;
	bh=CcG3DB5w4RBV9H55Eghl8rFNG8gQYXS7ULzywhnSNGg=;
	h=From:To:Cc:Subject:Date:From;
	b=vBoPJ0m9l4O6ITYbJQknF5WDIYk/HVLZvJT2c33e+MYIWfyz4mZCaw8uUZR/wZcSC
	 EEqJ6+FQjSNgCu/LIb6T9VkE6xoPunTdpYh10yH8QJeu2RJx2DbCUz77i+9/C6kEWd
	 fas32jb7wH0Q0Lr1gzNil1mMf6cdBrR/ojnAnUw4ceOIj/7kWNI6ik6rvBoKTu3pgO
	 tOXs2A8EAq7xGdzlvnafwCjxUfco4jzpec2Jnc3+G/bW46ykmIbe9HDMBa++RFM3Dt
	 2ATHC000gEXyHduR3GA1SaWh0IZVWzalXA8rPk2cW3RXKAFu2cWxVsZtxrA8KU2Z8l
	 AVsJaWHaUJK8w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/22] selftests/damon/sysfs.py: test all parameters
Date: Sun, 20 Jul 2025 10:16:30 -0700
Message-Id: <20250720171652.92309-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs.py tests if DAMON sysfs interface is passing the user-requested
parameters to DAMON as expected.  But only the default (minimum)
parameters are being tested.  This is partially because _damon_sysfs.py,
which is the library for making the parameter requests, is not
supporting the entire parameters.  The internal DAMON status dump script
(drgn_dump_damon_status.py) is also not dumping entire parameters.
Extend the test coverage by updating parameters input and status dumping
scripts to support all parameters, and writing additional tests using
those.

This increased test coverage actually found one real bug
(https://lore.kernel.org/20250719181932.72944-1-sj@kernel.org).

First seven patches (1-7) extend _damon_sysfs.py for all parameters
setup.  The eight patch (8) fixes _damon_sysfs.py to use correct max
nr_acceses and age values for their type.  Following three patches
(9-11) extend drgn_dump_damon_status.py to dump full DAMON parameters.
Following nine patches (12-20) refactor sysfs.py for general testing
code reuse, and extend it for full parameters check.  Finally, two
patches (21 and 22) add test cases in sysfs.py for full parameters
testing.

SeongJae Park (22):
  selftests/damon/_damon_sysfs: support DAMOS watermarks setup
  selftests/damon/_damon_sysfs: support DAMOS filters setup
  selftests/damon/_damon_sysfs: support monitoring intervals goal setup
  selftests/damon/_damon_sysfs: support DAMOS quota weights setup
  selftests/damon/_damon_sysfs: support DAMOS quota goal nid setup
  selftests/damon/_damon_sysfs: support DAMOS action dests setup
  selftests/damon/_damon_sysfs: support DAMOS target_nid setup
  selftests/damon/_damon_sysfs: use 2**32 - 1 as max nr_accesses and age
  selftests/damon/drgn_dump_damon_status: dump damos->migrate_dests
  selftests/damon/drgn_dump_damon_status: dump ctx->ops.id
  selftests/damon/drgn_dump_damon_status: dump DAMOS filters
  selftests/damon/sysfs.py: generalize DAMOS Watermarks commit assertion
  selftests/damon/sysfs.py: generalize DamosQuota commit assertion
  selftests/damon/sysfs.py: test quota goal commitment
  selftests/damon/sysfs.py: test DAMOS destinations commitment
  selftests/damon/sysfs.py: generalize DAMOS schemes commit assertion
  selftests/damon/sysfs.py: test DAMOS filters commitment
  selftests/damon/sysfs.py: generalize DAMOS schemes commit assertion
  selftests/damon/sysfs.py: generalize monitoring attributes commit
    assertion
  selftests/damon/sysfs.py: generalize DAMON context commit assertion
  selftests/damon/sysfs.py: test non-default parameters runtime commit
  selftests/damon/sysfs.py: test runtime reduction of DAMON parameters

 tools/testing/selftests/damon/_damon_sysfs.py | 301 +++++++++++++++++-
 .../selftests/damon/drgn_dump_damon_status.py |  63 +++-
 tools/testing/selftests/damon/sysfs.py        | 284 +++++++++++++----
 3 files changed, 568 insertions(+), 80 deletions(-)


base-commit: fc8066077f44a4fd43f8fdb12bc238f8fbeaa3c5
-- 
2.39.5

