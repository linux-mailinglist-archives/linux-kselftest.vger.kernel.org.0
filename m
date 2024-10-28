Return-Path: <linux-kselftest+bounces-20870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F3F9B3E6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AE81C21015
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6A1EE02D;
	Mon, 28 Oct 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adxrEJO2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CDF1E1C0D;
	Mon, 28 Oct 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158265; cv=none; b=Wg6cH42ww92cebEMCY57xISKFs/bLVqQn+iZdPBAfOItBhtyuHaT+VJV4UOZb4N3C0cautnUUVqot2jNXyfJvmmrqCkIAeqwOwBLu6w+30ky1CQdjaSYijvbTBTxPTddYHT9wVOUHCml//6Alp8QACM23KWyqfYH0xFUhUuzrH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158265; c=relaxed/simple;
	bh=HKc1o0/C7r3MGYeFYTfFeVOVH7j7sttnDPnYOtW0PLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KqGydC8OY/lb/2hU883iMx4DYQB61zZjPSXh5D/Lwm7WfLpiHXf54nXJJMJs5XTsrqALM0umJGNV8TVwDbhWOhuZ1oIBiLMfFAX4jQbpqzePRe1z7b3FLo2U8avJOG1Wl5kZ5czGsyqnp9lnuQXbZnjfgK9m1Xr2a/IG6Xr9dH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adxrEJO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC259C4CEC3;
	Mon, 28 Oct 2024 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158265;
	bh=HKc1o0/C7r3MGYeFYTfFeVOVH7j7sttnDPnYOtW0PLk=;
	h=From:To:Cc:Subject:Date:From;
	b=adxrEJO24bmDoUKOpxXJ2+XvWjOSq9UIh01TnE0Bz3BEZeD0H6ZyerkfxcL1Iz4M3
	 pX0AAMPF8F8mTqdy8C3ptJFFUKkntaG42GqROikR8EKrOCppaWJUAToU2e6OWoy4iw
	 MWYMH7eXYfOwR2xQpfQhzH3mPGDpAMJQg2+g9ZFXYB8/++wii+3DnkmL/17GSjlS+O
	 Vvv3jTsECw3AWsGLUWz+MxSApzdEg6l6tatlHrQJBJkNgdZLPS2MtSd342YsdyFrQh
	 TikkI6isIeTBjyqpn3FnHNlWu8oaA8ksuwoOwEb8adUWDEEdeKwneZXZjQCW7aC1LJ
	 rGJKfwZtvVguA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Paniakin <apanyaki@amazon.com>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] damon/{self,kunit}tests: minor fixups for DAMON debugfs interface tests
Date: Mon, 28 Oct 2024 16:30:52 -0700
Message-Id: <20241028233058.283381-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixup small broken window panes in DAMON selftests and kunit tests.

First four patches clean up DAMON debugfs interface selftests output, by
fixing segmentation fault of a test program (patch 1), removing
unnecessary debugging messages (patch 2), and hiding error messages from
expected failures (patches 3 and 4).

Following two patches fix copy-paste mistakes in DAMON Kconfig help
message that copied from debugfs kunit test (patch 5) and a comment on
the debugfs kunit test code (patch 6).

Signed-off-by: SeongJae Park <sj@kernel.org>

Andrew Paniakin (1):
  selftests/damon/huge_count_read_write: provide sufficiently large
    buffer for DEPRECATED file read

SeongJae Park (5):
  selftests/damon/huge_count_read_write: remove unnecessary debugging
    message
  selftests/damon/_debugfs_common: hide expected error message from
    test_write_result()
  selftests/damon/debugfs_duplicate_context_creation: hide errors from
    expected file write failures
  mm/damon/Kconfig: update DBGFS_KUNIT prompt copy for SYSFS_KUNIT
  mm/damon/tests/dbgfs-kunit: fix the header double inclusion guarding
    ifdef comment

 mm/damon/Kconfig                                           | 2 +-
 mm/damon/tests/dbgfs-kunit.h                               | 2 +-
 tools/testing/selftests/damon/_debugfs_common.sh           | 7 ++++++-
 .../selftests/damon/debugfs_duplicate_context_creation.sh  | 2 +-
 tools/testing/selftests/damon/huge_count_read_write.c      | 4 +---
 5 files changed, 10 insertions(+), 7 deletions(-)


base-commit: 13583c750117b4e10cdaf5578dcc7723b305ce4e
-- 
2.39.5


