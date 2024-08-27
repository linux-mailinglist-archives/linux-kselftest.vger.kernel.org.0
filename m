Return-Path: <linux-kselftest+bounces-16356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7B95FF86
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1B8282D52
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 03:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382818030;
	Tue, 27 Aug 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxXg0aAY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF81773A;
	Tue, 27 Aug 2024 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727827; cv=none; b=Az3V8kiDR9NaE2PHcmp0AwFeFyU6xNVI3yapO9TcWo5sKQBwNpgmHy5+d1qAnwziaqfKoMyj+N9tp8+sb4D9YwWlqib/DCaMhJDasKO6oswQW45GtAXekT5YrGcKUaGgWmgrPMd04kLcpirPORlbM1Z30NJ6Ez+jlbyOI0G81BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727827; c=relaxed/simple;
	bh=2F3Z7/FjUDbb0bRhSn31gWhRde7Fk7wSW3dzKpCxQOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qfgb/uYMnArHHYq4wslt7hh0CbeEaMs27R2H0OcWDhawMNAxgqMqHSP/1hyrafoK1/dt6KwapNmNgLBIX/d6fk2/5kZlHnV/3VKHUS/mhyoG2BEeLPMTPLBvfs9Mg267zYvGs8iW6g+6aldffMDk1HydU8vUx2bqKL1tCKR/X9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxXg0aAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D526C8B7A6;
	Tue, 27 Aug 2024 03:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727826;
	bh=2F3Z7/FjUDbb0bRhSn31gWhRde7Fk7wSW3dzKpCxQOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxXg0aAYfWgd67ktVrg98gx1cX4O+jFcp1Rx3rqPpBsIiAG9AwfrjAya2I25CL2Li
	 E7oJnrkyFbOrFoaFOrBUPq9J5b594e6aQYCd3JzbsD2tblpSISLs2fiApEmiE/Itxh
	 5NIBKMsfaHLLZ+/Os61lJ4qxphcscOVwVMA/IIFy0fedHlWUjM/9S0tIN1m8iECbjU
	 F/xNi/firvl5QiPm1QauCPN1Cj9n8nzeVfi1AGPHw8kU7lyLOezATpbzmIkzO8tbE5
	 mEHHxFXWrU27uBvurTrZk9Xx0Qkws9/Tc9uxiDi/UFVbrO3I3HtqCK9v+IPTEhvS9h
	 Fv/L4NcANLh/A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] selftests/damon: cleanup __pycache__/ with 'make clean'
Date: Mon, 26 Aug 2024 20:03:29 -0700
Message-Id: <20240827030336.7930-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827030336.7930-1-sj@kernel.org>
References: <20240827030336.7930-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Python-based tests creates __pycache__/ directory.  Remove it with 'make
clean' by defining it as EXTRA_CLEAN.

Fixes: b5906f5f7359 ("selftests/damon: add a test for update_schemes_tried_regions sysfs command")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 1e2e98cc809d..5b2a6a5dd1af 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -25,4 +25,6 @@ TEST_PROGS += debugfs_target_ids_pid_leak.sh
 TEST_PROGS += sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 
+EXTRA_CLEAN = __pycache__
+
 include ../lib.mk
-- 
2.39.2


