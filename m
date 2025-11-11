Return-Path: <linux-kselftest+bounces-45354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B3C4F7B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08630189C5B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FC52C1780;
	Tue, 11 Nov 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTdymFss"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A62C11F5;
	Tue, 11 Nov 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886669; cv=none; b=BLp6HeP+4pSW2zAqrBkpgtybOIq7PgMT9PO15meidUc/HMzpE8iehAYWDMpAUN3F+hMfcKJTLimhXC0awepA7LVRfdPWvO64OSH1czGlCgZBcMcIRkFrDmLEyhWXdSuBwpk1R9Mwf/8FmCAlQqYXyfGxQL6jS92OTB6LesdhXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886669; c=relaxed/simple;
	bh=+8bf6ecH2QvmrcQl2a7rJm2jNUhjf8tGWK0R12xiYjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZqVLs1Q5pdbn0sDGW/aqhd+XDzWKRzUqiWU/moFcPpt0aLEKvR++zuB8NFyUxbt2o+86kWEhPXd18mg4zbYQA1Ia84F0YEHOEXg19eEQGKXGwicrUigapD3jtZeH4gTcInQ8UYvGoYtqZYXFXI5Sp2EYPy3O7g15qHR3w9ZJJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTdymFss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EA8C4CEFB;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886669;
	bh=+8bf6ecH2QvmrcQl2a7rJm2jNUhjf8tGWK0R12xiYjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTdymFssBjyFKZQvY9G5+u54zM6i/+Y4DTZAt0CIeOQDITh6nLowUfB2sTsgOz3uB
	 pgc2KrrqQHpnatga8xi7CQ5mlgLiVf3IfzofdVbdNeGDtBolgZ6QfixzluMbHTyDUa
	 eyCkNpGQKJM4hZx1bvGAxutK20scr0IQuyY9Ef03FAgYpKn8XsVFcyn0ZKL9/qMIOm
	 ZtcNNlgg9YAMgyymYON55BB6n7QIpZ/krFt+5dx4ZD49Z8WE5GPuO1q+XtFptUMrsH
	 mslTc6T6m5UPLhWDP+Agna40O5ACC3ecBjRMY3r/Hy81pTaaYgrjxhveaA7yi4QLnN
	 VIQt0RDIb5BVw==
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
Subject: [PATCH 08/11] mm/damon/core: pass migrate_dests to damos_commit_dests()
Date: Tue, 11 Nov 2025 10:44:07 -0800
Message-ID: <20251111184415.141757-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111184415.141757-1-sj@kernel.org>
References: <20251111184415.141757-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_dests() receives 'struct damos' pointers, while it uses
only their ->migrate_dests fields.  This makes code unnecessarily
difficult to read.  It also makes unit tests writing complicated.
Refactor the function to receive pointers to the ->migrate_dests fields.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 06ad359024ad..a14cc73c2cab 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1000,36 +1000,32 @@ static void damos_set_filters_default_reject(struct damos *s)
 		damos_filters_default_reject(&s->ops_filters);
 }
 
-static int damos_commit_dests(struct damos *dst, struct damos *src)
+static int damos_commit_dests(struct damos_migrate_dests *dst,
+		struct damos_migrate_dests *src)
 {
-	struct damos_migrate_dests *dst_dests, *src_dests;
+	if (dst->nr_dests != src->nr_dests) {
+		kfree(dst->node_id_arr);
+		kfree(dst->weight_arr);
 
-	dst_dests = &dst->migrate_dests;
-	src_dests = &src->migrate_dests;
-
-	if (dst_dests->nr_dests != src_dests->nr_dests) {
-		kfree(dst_dests->node_id_arr);
-		kfree(dst_dests->weight_arr);
-
-		dst_dests->node_id_arr = kmalloc_array(src_dests->nr_dests,
-			sizeof(*dst_dests->node_id_arr), GFP_KERNEL);
-		if (!dst_dests->node_id_arr) {
-			dst_dests->weight_arr = NULL;
+		dst->node_id_arr = kmalloc_array(src->nr_dests,
+			sizeof(*dst->node_id_arr), GFP_KERNEL);
+		if (!dst->node_id_arr) {
+			dst->weight_arr = NULL;
 			return -ENOMEM;
 		}
 
-		dst_dests->weight_arr = kmalloc_array(src_dests->nr_dests,
-			sizeof(*dst_dests->weight_arr), GFP_KERNEL);
-		if (!dst_dests->weight_arr) {
+		dst->weight_arr = kmalloc_array(src->nr_dests,
+			sizeof(*dst->weight_arr), GFP_KERNEL);
+		if (!dst->weight_arr) {
 			/* ->node_id_arr will be freed by scheme destruction */
 			return -ENOMEM;
 		}
 	}
 
-	dst_dests->nr_dests = src_dests->nr_dests;
-	for (int i = 0; i < src_dests->nr_dests; i++) {
-		dst_dests->node_id_arr[i] = src_dests->node_id_arr[i];
-		dst_dests->weight_arr[i] = src_dests->weight_arr[i];
+	dst->nr_dests = src->nr_dests;
+	for (int i = 0; i < src->nr_dests; i++) {
+		dst->node_id_arr[i] = src->node_id_arr[i];
+		dst->weight_arr[i] = src->weight_arr[i];
 	}
 
 	return 0;
@@ -1076,7 +1072,7 @@ static int damos_commit(struct damos *dst, struct damos *src)
 	dst->wmarks = src->wmarks;
 	dst->target_nid = src->target_nid;
 
-	err = damos_commit_dests(dst, src);
+	err = damos_commit_dests(&dst->migrate_dests, &src->migrate_dests);
 	if (err)
 		return err;
 
-- 
2.47.3

