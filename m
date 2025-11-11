Return-Path: <linux-kselftest+bounces-45345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CABEC4F789
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0B1895A8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7303629BDB3;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz/BecqM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F5329B778;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886667; cv=none; b=srhWhKKORq0gb9ppLa2NEbztANEfB3HN9RnJvnHLCnsOjeLp0UjV3I/N8y7hWsBnGugOj3F9nlTRgNTHL109gwuLDx4ZUKgFjWi9f6g4PqVYyDVSopxT/3TE2DOG9pK1lOq0h+gF1NPKQcdGq9IQx0tfcaw9ZVExGEWsPCpT+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886667; c=relaxed/simple;
	bh=m2hHKtIlg5ETlXGHsaViOdGrXByOpAXl7sGM5smf3nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCog3sGBRzpKW12yVdYqnzpiXM64UbgIBs2AVxe1/G0p6cyy9b9/jYRXjsXUdTL7PlhNEDGWIwZzxi0ajzk45P3o5vCj6i371ar8yHOSMK03VFuja2winh4tXbL0izz5mVrepZK5TIm4tNHADjeE+kXVxCNiCZNOYER4YhrD7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz/BecqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCDAC16AAE;
	Tue, 11 Nov 2025 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886666;
	bh=m2hHKtIlg5ETlXGHsaViOdGrXByOpAXl7sGM5smf3nI=;
	h=From:To:Cc:Subject:Date:From;
	b=Nz/BecqMuxBuI+lNBLETRFlGtiVXVLN4K+dCBpk3eY9BC1/3fVqpb/hTqL4w+KvOp
	 Kgefl7VDI4E4xTEyMn75nXstAkJI4qhaAZE4IYO5AQd9U1xYHh6KuJGkRD44Kb9dWC
	 kOjwltrWdmLoAX8VDNL3F76Y0otKH/XvDNjv0IclF0m9PCW6o0qm6vBII4PEF7Uzja
	 DMXMT5cb9iJoLUGnZZ0gnOWY08hSJd22zNikESwzBOzpqhg5drTTx0xFLwKOehZGZJ
	 54aapKTRXzMrQwvFuPI+a8q1YPbpgIc8GNkw3vfo51eqQT9i1nCyJ6QWwB+oNNrVgf
	 E8Wb4WqQVA2Mw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/11] mm/damon/tests: add more tests for online parameters commit
Date: Tue, 11 Nov 2025 10:43:59 -0800
Message-ID: <20251111184415.141757-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DAMON feature called parameters "commit" allows DAMON API callers and
ABI users to update nearly every DAMON parameter while DAMON is running.
This is being used for flexible DAMON use cases such as taking a
snapshot of the monitoring results with minimum overhead, or adjusting
access-aware system operations (DAMOS) for user-space driven auto-tuning
or investigations.

Compared to the usefulness of the feature and size of the
implementation, the test coverage is pretty small.  Only the filter
commit part has a single test case, namely damos_test_commit_filter().
Actually, we found and fixed a few bugs of the feature in the past.  The
single existing test was also added to avoid reintroduction of a found
bug.

Add more unit tests for the feature.

First four patches (1-4) refactor and extend the existing test for DAMOS
filter commit for multiple test cases.

Next three patches (5-7) add tests for DAMOS quota commit.

Next two patches (8 and 9) refactor damos_commit_dests() for ease of
code reading and test writing, and implement a new unit test of the
function that is being refactored in a test-friendly way.

Final two patches (10 and 11) further add new unit tests for
damos_commit() and damon_commit_target_regions().

SeongJae Park (11):
  mm/damon/tests/core-kunit: remove dynamic allocs on
    damos_test_commit_filter()
  mm/damon/tests/core-kunit: split out damos_test_commit_filter() core
    logic
  mm/damon/tests/core-kunit: extend damos_test_commit_filter_for() for
    union fields
  mm/damon/tests/core-kunit: add test cases to
    damos_test_commit_filter()
  mm/damon/tests/core-kunit: add damos_commit_quota_goal() test
  mm/damon/tests/core-kunit: add damos_commit_quota_goals() test
  mm/damon/tests/core-kunit: add damos_commit_quota() test
  mm/damon/core: pass migrate_dests to damos_commit_dests()
  mm/damon/tests/core-kunit: add damos_commit_dests() test
  mm/damon/tests/core-kunit: add damos_commit() test
  mm/damon/tests/core-kunit: add damon_commit_target_regions() test

 mm/damon/core.c             |  38 ++-
 mm/damon/tests/core-kunit.h | 544 +++++++++++++++++++++++++++++++++++-
 2 files changed, 547 insertions(+), 35 deletions(-)


base-commit: 620a4c1c5116eb811807ea7e63d61846015f69c8
-- 
2.47.3

