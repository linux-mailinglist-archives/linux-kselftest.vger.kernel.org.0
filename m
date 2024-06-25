Return-Path: <linux-kselftest+bounces-12717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9A3916FC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0730C1F22C7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A481779BA;
	Tue, 25 Jun 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i08owaJA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C351459E2;
	Tue, 25 Jun 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338744; cv=none; b=tY6VSjy7dL85+K7gu+mTZ0td443mC7cucUDyG+qZKbSW9rWGZwvVICyK6ePiuDqrzRP/MlTfJ3C0Cm5wOqXrtUYfBe+ELUP9oZlPXqHGziMC1JXqPT/LlLRPtNOXeCqVaZw30FRZeMWz+jfOJvwpIwmZcjIgAGsOgh6oaGJYjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338744; c=relaxed/simple;
	bh=shsXNhCfXHTnED5QM8sxuSUHkfSGO2/rCdvA/fWyJng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uV94zLPU6VDFarF9nA7hZKqOZbxvVjWAsg449xjzX/sNhawIA3CTTqVZNMmqv5wFTeYPwUSR9E8YJ7Loh+C2TLK0EnR+Vf0XwKRqfl6WnZwUtOlu0uv1PibO5Z99/jLlrLo6twQG0T3fKOzO9mM54YuMl7g0BFDZYs9ZB/4Jtdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i08owaJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E08C32781;
	Tue, 25 Jun 2024 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338744;
	bh=shsXNhCfXHTnED5QM8sxuSUHkfSGO2/rCdvA/fWyJng=;
	h=From:To:Cc:Subject:Date:From;
	b=i08owaJAQt4aQchFM+u1qNEciFAPS0MtFm3d+XrItCAi03MbkfywUVJCPFQrtiEkz
	 6L8Sm++wHq1fziDzl/2RdxLSerhuTj0UqArRMJsK9km/JpoNdsxLTFTDHQ2Rs4sRL/
	 DHea+PYzDOc042LpGCa5Ta/jTvaY2pCb6e2hfx61IfXYiequnH11XLO4ubRlrJ6C7t
	 jXTfmo8lhkgi/2L+Vb3nxEi68oKg8LVCXpi4d0SMx1BgjU30NyTAHO9EwlMDxkLlYw
	 1D4q14SJksE9qNfDQVqi3aot+sqcLrjB6ozPmcRUnVS9r866blRB0IU4Pv3d1P3/ro
	 OqzSK1cQDgslg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] selftests/damon: test DAMOS tried regions and {min,max}_nr_regions
Date: Tue, 25 Jun 2024 11:05:30 -0700
Message-Id: <20240625180538.73134-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fix a minor issue in a program for DAMON selftest, and
implement new functionality selftests for DAMOS tried regions and
{min,max}_nr_regions.  The test for max_nr_regions also test the
recovery from online tuning-caused limit violation, which was fixed by a
previous patch [1] titled "mm/damon/core: merge regions aggressively
when max_nr_regions is unmet".

The first patch fixes a minor problem in the articial memory access
pattern generator for tests.  Following 3 patches (2-4) implement
schemes tried regions test.  Then a couple of patches (5-6) implementing
static setup based {min,max}_nr_regions functionality test follows.
Final two patches (7-8) implement dynamic max_nr_regions update test.

[1] https://lore.kernel.org/20240624210650.53960C2BBFC@smtp.kernel.org

SeongJae Park (8):
  selftests/damon/access_memory: use user-defined region size
  selftests/damon/_damon_sysfs: support schemes_update_tried_regions
  selftests/damon: implement a program for even-numbered memory regions
    access
  selftests/damon: implement DAMOS tried regions test
  selftests/damon/_damon_sysfs: implement kdamonds stop function
  selftests/damon: implement test for min/max_nr_regions
  _damon_sysfs: implement commit() for online parameters update
  selftests/damon/damon_nr_regions: test online-tuned max_nr_regions

 tools/testing/selftests/damon/Makefile        |   3 +-
 tools/testing/selftests/damon/_damon_sysfs.py |  65 +++++++-
 tools/testing/selftests/damon/access_memory.c |   2 +-
 .../selftests/damon/access_memory_even.c      |  42 +++++
 .../selftests/damon/damon_nr_regions.py       | 145 ++++++++++++++++++
 .../selftests/damon/damos_tried_regions.py    |  65 ++++++++
 6 files changed, 319 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/damon/access_memory_even.c
 create mode 100644 tools/testing/selftests/damon/damon_nr_regions.py
 create mode 100644 tools/testing/selftests/damon/damos_tried_regions.py


base-commit: 99348045d11f3bac71146b381f90b0aa39855ee7
-- 
2.39.2


