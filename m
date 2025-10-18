Return-Path: <linux-kselftest+bounces-43503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BFDBEDBC0
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 22:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0BFF34D102
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 20:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE802D8DD6;
	Sat, 18 Oct 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5YXq7PB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4D2D7D2E;
	Sat, 18 Oct 2025 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760820293; cv=none; b=H9dtXr8a9RbrnlbLSHsUhSBRoxKErKbYp4sFj94OifNUTxpEB/06VOqk3GJCLKPGXtqS0lmitbYQ+1d0m5dur4P2yB7Ji7i4WJU7CLXfTfh/dAjOzrtMDwzAE387NYYg37jh6QDgpPO66FGRDY9kUzxC0MPVuBp/kB8LxG50oaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760820293; c=relaxed/simple;
	bh=bP4f3Y9B2E5+Lr10DKBGnctYdQ3B9BDoxl8h6OwnfKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2nXGAbT+rtmGeMBKvDVLWCqZJS39urY9YCynmCA5hoXo+n9MEslWSR+3QbwTyQFtTZvzT1ynvsxOf6KSk580iSSCBlfZoJuCrK7c2RJv5I1gF8nAq4mtCi8JW4RbPH5MBgwfQ/MqSmzKbQmwLbhQchuEMzAzcqGRfjgedzlZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5YXq7PB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC6BC4AF0C;
	Sat, 18 Oct 2025 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760820292;
	bh=bP4f3Y9B2E5+Lr10DKBGnctYdQ3B9BDoxl8h6OwnfKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5YXq7PB1giOnU7iYNgo/idI8CvROxrbR7jU7M0CFA1qnN+VQdIQSz/24Mf0uTOOy
	 /i4Qx+PgMTJFYi1wVBQBwxN30Yp48QF3P2uqbNrAjnLdccxUTnNdZGZfnF9PMy+cJe
	 fYQTRCk29XxiP2D+OXmw7RbFtJB4X1ZxeTC6ozIDGibAoYdRrefq+luzycLCEXouBi
	 ADrjE4f7aQVKLX7bgek+c33B6izgCfPCDB7BMEt+PqjYnkeIi0mJTU+md3EfRJ0/Lh
	 vEOR//vczr2Em5IAGkvoF7F/3SJEcamRTXlW8Jecj+XzMqmAMYrXR3QFSkidd5jl4W
	 Ox8byEWMuqG8A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] drgn_dump_damon_status: dump damon_target->obsolete
Date: Sat, 18 Oct 2025 13:44:43 -0700
Message-ID: <20251018204448.8906-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251018204448.8906-1-sj@kernel.org>
References: <20251018204448.8906-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new field of damon_target for pin-point target removal, namely
obsolete has newly been added.  Extend drgn_dump_damon_status.py to dump
it, for easily writing a future DAMON selftests of it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 7233369a3a44..cb4fdbe68acb 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -73,6 +73,7 @@ def target_to_dict(target):
         ['pid', int],
         ['nr_regions', int],
         ['regions_list', regions_to_list],
+        ['obsolete', bool],
         ])
 
 def targets_to_list(targets):
-- 
2.47.3

