Return-Path: <linux-kselftest+bounces-32885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E580AB4867
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 02:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECCD19E7346
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 00:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950123F9C5;
	Tue, 13 May 2025 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcEDlNKN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C431EAF9;
	Tue, 13 May 2025 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096041; cv=none; b=tQJyTtfL/9w/nt7qwxqS/KRvD6GFLBfwmhb2LfovLAtNkg3169nLptGTuG8B7gSHQtlEEfXT0Q8gTEKiUa13xfBhrDglhcWNXcYF+pdMYH9wNNS9p+w1x0W0kk3A+rrd3p22/Ji2RZzouPUUrXzNO9FL6OoRtM5V5ndZqNEdFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096041; c=relaxed/simple;
	bh=gbT4zBBAKCXpJbSQH0+kVh2pAjcJfe6GwmW44Gl+wU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BS5mCqkjQLNplqtzLTopVdj1Umi3kCypg+LJv7mMDLwValFrm8Wx5ru9WzNIOj3NWMMV95lLZ765yM1JaR2tbZGPILxo2r81Wh8QaHdgFV9KHIUxjUcIeyiIRh4dia6738XaPe1evuwivyIYnSVYil3u0X5G9VrzmVfCkiUPtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcEDlNKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935F3C4CEE7;
	Tue, 13 May 2025 00:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096040;
	bh=gbT4zBBAKCXpJbSQH0+kVh2pAjcJfe6GwmW44Gl+wU0=;
	h=From:To:Cc:Subject:Date:From;
	b=EcEDlNKNRuTSlKTP9vEiGZIhUokNA6hIhaXksGC2sVVOU5DlKjqZB5s5KQnvqkaHP
	 GN6Wc4F5P1cGhrHTmX4DqsvTPYdrFFjTtT+7sfswNqKfkS/IBczADRuX6FKogkrgFj
	 E+5k3OpnvWf+awfra0twsgyGQIodBspAYWMffj/R6RaCaPWteCHPAkLcpFAWHfO+9S
	 OHxthbyqN8I9zMb/1ex9y2tZ+wCEsf+SO3ieug4u6wWGSNLcFoKch5fr76EARNhQ7k
	 FnjKUIpWKS+KTSvAsKJnz1zaBHNNVD+s3GNz8f8t8L3+UNHJkKVGk0yhp4jf8sW6W/
	 A6lrjenSMjS6Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/6] mm/damon: minor fixups and improvements for code, tests, and documents
Date: Mon, 12 May 2025 17:27:09 -0700
Message-Id: <20250513002715.40126-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yet another batch of miscellaneous DAMON changes.  Fix and improve minor
problems in code, tests and documents.

SeongJae Park (6):
  mm/damon/core: warn and fix nr_accesses[_bp] corruption
  mm/damon/sysfs-schemes: fix wrong comment on
    damons_sysfs_quota_goal_metric_strs
  mm/damon/paddr: remove unused variable, folio_list, in damon_pa_stat()
  mm/damon/tests/core-kunit: add a test for
    damos_set_filters_default_reject()
  selftests/damon/_damon_sysfs: read tried regions directories in order
  Docs/damon: update titles and brief introductions to explain DAMOS

 Documentation/admin-guide/mm/damon/index.rst  | 11 ++-
 Documentation/mm/damon/index.rst              |  6 +-
 mm/damon/core.c                               | 14 ++++
 mm/damon/paddr.c                              |  1 -
 mm/damon/sysfs-schemes.c                      |  2 +-
 mm/damon/tests/core-kunit.h                   | 70 +++++++++++++++++++
 tools/testing/selftests/damon/_damon_sysfs.py |  5 ++
 7 files changed, 98 insertions(+), 11 deletions(-)


base-commit: fb227aa50d133236ef02a71dd9e3d510f4fad42f
-- 
2.39.5


