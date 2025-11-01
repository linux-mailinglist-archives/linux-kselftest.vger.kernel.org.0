Return-Path: <linux-kselftest+bounces-44586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29078C28494
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FC8189BFEA
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A0D2882B8;
	Sat,  1 Nov 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoOC/Q9T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93310271A7C;
	Sat,  1 Nov 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021236; cv=none; b=URFnXhH82S3u4v0QHXDfb+l2DCWjyLMNLi0AtzXDywSp7CvMZu+4ZWcNDn1CqRHjU81lKL79Zct4kAgF13JVTbIFtJSLWisLqKccKCXGZeTj7/FLxJk4xLDypjaBAkR+lJAs4A6B0t6iCIEf8//Ji4Let/jwz6gwgEXTNkDDZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021236; c=relaxed/simple;
	bh=YTd/vHBelVnR6mgK17h8ySbO2cFbzynFbPAWylHXqLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiG5IB5tqDuATEhTO1npC3zsJrGoll8I1uL377vjd3ES7bae0MK/9+0x1nyErFdD7gRJApLOaBm8GjVdnZuAR+3ezAKLwpkSGjWXIPzJbu4tAwVqN45PCROOoOCd6rh03g0/gFD2K95KaymKdq23WFOXH6lbPBLNM5tvCTnCuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoOC/Q9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8240C4CEF1;
	Sat,  1 Nov 2025 18:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021236;
	bh=YTd/vHBelVnR6mgK17h8ySbO2cFbzynFbPAWylHXqLk=;
	h=From:To:Cc:Subject:Date:From;
	b=MoOC/Q9TCmUnC9Zl9aJKK4Yg4xuuXinVSTajYDp9j64NVw/rlgaaJbt4ukM9OiZ6Y
	 uadJI7iBu2uFO+7SxgMkGpiBcJ+TjBkSp1poVWyvl2NBGZ/h9l1gA8Yje4Om5EobN5
	 o2lBy8yVeq2buFtnN3egBTJo734aeGWc5JlBREdi6x3B7lYYqwXh8qkpsMZKMLbYQx
	 lsaRHNXbje01iUxvNzpcfGUnvGtU9a9mosNIIUhlXjZsepnxJBawU5OZdSX/4Zl6cR
	 E8Z+2mEU4PKW+loBu6Plk/HfQv8kmh6q82v7VPii4zOFy1D1fl0eSd+XuJPw8rtACa
	 P0/2lWn2IE96Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 15 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/22] mm/damon/tests: fix memory bugs in kunit tests
Date: Sat,  1 Nov 2025 11:19:54 -0700
Message-ID: <20251101182021.74868-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON kunit tests were initially written assuming those will be run on
environments that are well controlled and therefore tolerant to
transient test failures and bugs in the test code itself.  The user-mode
linux based manual run of the tests is one example of such an
environment.  And the test code was written for adding more test
coverage as fast as possible, over making those safe and reliable.

As a result, the tests resulted in having a number of bugs including
real memory leaks, theoretical unhandled memory allocation failures, and
unused memory allocations.  The allocation failures that are not handled
well are unlikely in the real world, since those allocations are too
small to fail.  But in theory, it can happen and cause inappropriate
memory access.

It is arguable if bugs in test code can really harm users.  But, anyway
bugs are bugs that need to be fixed.  Fix the bugs one by one.  Also Cc
stable@ for the fixes of memory leak and unhandled memory allocation
failures.  The unused memory allocations are only a matter of memory
efficiency, so not Cc-ing stable@.

The first patch fixes memory leaks in the test code for the DAMON core
layer.

Following fifteen, three, and one patches respectively fix unhandled
memory allocation failures in the test code for DAMON core layer,
virtual address space DAMON operation set, and DAMON sysfs interface,
one by one per test function.

Final two patches remove memory allocations that are correctly
deallocated at the end, but not really being used by any code.

SeongJae Park (22):
  mm/damon/tests/core-kunit: fix memory leak in
    damon_test_set_filters_default_reject()
  mm/damon/tests/core-kunit: handle allocation failures in
    damon_test_regions()
  mm/damon/tests/core-kunit: handle memory failure from
    damon_test_target()
  mm/damon/tests/core-kunit: handle memory alloc failure from
    damon_test_aggregate()
  mm/damon/tests/core-kunit: handle alloc failures on
    damon_test_split_at()
  mm/damon/tests/core-kunit: handle alloc failures on
    damon_test_merge_two()
  mm/damon/tests/core-kunit: handle alloc failures on
    dasmon_test_merge_regions_of()
  mm/damon/tests/core-kunit: handle alloc failures on
    damon_test_split_regions_of()
  mm/damon/tests/core-kunit: handle alloc failures in
    damon_test_ops_registration()
  mm/damon/tests/core-kunit: handle alloc failures in
    damon_test_set_regions()
  mm/damon/tests/core-kunit: handle alloc failures in
    damon_test_update_monitoring_result()
  mm/damon/tests/core-kunit: handle alloc failure on
    damon_test_set_attrs()
  mm/damon/tests/core-kunit: handle alloc failres in
    damon_test_new_filter()
  mm/damon/tests/core-kunit: handle alloc failure on
    damos_test_commit_filter()
  mm/damon/tests/core-kunit: handle alloc failures on
    damos_test_filter_out()
  mm/damon/tests/core-kunit: handle alloc failures on
    damon_test_set_filters_default_reject()
  mm/damon/tests/vaddr-kunit: handle alloc failures on
    damon_do_test_apply_three_regions()
  mm/damon/tests/vaddr-kunit: handle alloc failures in
    damon_test_split_evenly_fail()
  mm/damon/tests/vaddr-kunit: handle alloc failures on
    damon_test_split_evenly_succ()
  mm/damon/tests/sysfs-kunit: handle alloc failures on
    damon_sysfs_test_add_targets()
  mm/damon/tests/core-kunit: remove unnecessary damon_ctx variable on
    damon_test_split_at()
  mm/damon/tests/core-kunit: remove unused ctx in
    damon_test_split_regions_of()

 mm/damon/tests/core-kunit.h  | 125 ++++++++++++++++++++++++++++++++---
 mm/damon/tests/sysfs-kunit.h |  25 +++++++
 mm/damon/tests/vaddr-kunit.h |  26 +++++++-
 3 files changed, 163 insertions(+), 13 deletions(-)


base-commit: 75f0c76bb8c01fdea838a601dc3326b11177c0d8
-- 
2.47.3

