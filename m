Return-Path: <linux-kselftest+bounces-44597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2EEC284EA
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C786C3BF01A
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FE02FFF80;
	Sat,  1 Nov 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVlar5I+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22572FF641;
	Sat,  1 Nov 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021239; cv=none; b=G62u4SeFDglLPwjYPnLYNDuttHTUfEMHaCkjaEkgvHLcfTkt+Ab9QcrS7iDBzKtTf5/cKbIjxyTJjeCYA6l0ky0xyK6Sd7sFNNt9bzlV9UULa8a6URcX7ySlaqkyZOKPV01smlmkxtR6WPjyqooKNY8g+1u4afHglV7rf4Cd/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021239; c=relaxed/simple;
	bh=oHkIjcA8qu06VIriuctGm/Bl5usqrU/VIxGOhoxmkJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQQSisXmlem4k59L3Huiv/d/WIPKHzuYmEpobNhDwD759vFWH3HzcvMcFtUFFH86TuApq0ruyZRhGASXROOErBFYLR3HHJLI7CugGS6iPSFMjjIZjU6QPkg6ewwlNzy/lsScM95qgUIgkS/5psIuxtnzatGH7Ax4OFMJTbIpMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVlar5I+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AC2C19424;
	Sat,  1 Nov 2025 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021239;
	bh=oHkIjcA8qu06VIriuctGm/Bl5usqrU/VIxGOhoxmkJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVlar5I+77xLhdhlMqli0zqKISxDQR3PpChs2MikS2WxH/2uyinmBsbauj612EoNj
	 C8OL+5Xy/Cxfqhusr8xL7TjP+9PSq3bTiYIwRF+k/+ffUroFfgo2kCLqr83007Uf81
	 6z8/swOvObW2pChaUmpj+/JwA9YLy97/EeyBMw0H8UH4MrrfVKX3z1mduQ+47OBuTX
	 QbTHYq6Fk3O39yYp0+879I5R4zEB6n5rMTlzK/BkFOEXRfCh3W6BsZFHRSMSjffyXA
	 KtdQiGk+SQ673mbnyPMruQ0jUBC1AtNdG89NwgiODKTbylUasjPnZ8nEtzrGkJu87S
	 0grc33RzWwU4Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/22] mm/damon/tests/core-kunit: handle alloc failures in damon_test_update_monitoring_result()
Date: Sat,  1 Nov 2025 11:20:05 -0700
Message-ID: <20251101182021.74868-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101182021.74868-1-sj@kernel.org>
References: <20251101182021.74868-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_update_monitoring_result() is assuming all dynamic memory
allocation in it will succeed.  Those are indeed likely in the real use
cases since those allocations are too small to fail, but theoretically
those could fail.  In the case, inappropriate memory access can happen.
Fix it by appropriately cleanup pre-allocated memory and skip the
execution of the remaining tests in the failure cases.

Fixes: f4c978b6594b ("mm/damon/core-test: add a test for damon_update_monitoring_results()")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index e38c95f86a68..10c9953581ee 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -429,6 +429,9 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	struct damon_attrs new_attrs;
 	struct damon_region *r = damon_new_region(3, 7);
 
+	if (!r)
+		kunit_skip(test, "region alloc fail");
+
 	r->nr_accesses = 15;
 	r->nr_accesses_bp = 150000;
 	r->age = 20;
-- 
2.47.3

