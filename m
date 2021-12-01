Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9C4650CE
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350309AbhLAPI0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350306AbhLAPIZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00065C061574;
        Wed,  1 Dec 2021 07:05:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4A3C3CE1F99;
        Wed,  1 Dec 2021 15:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4256C56748;
        Wed,  1 Dec 2021 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371101;
        bh=sQWMtyONHmc3W+Sgg4QUiiH5In2nUhULeFdo0mShTis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuLTSc5tK1l9ku/4X3hIvrCsTFR605bwQnRHywxxvsKhtGsDKcvlVLeZ7h1knqpU6
         8Nhz9aLb/+kVTo3gsf+4VFFoLg92ZbukwubUK7KzeRUY1EMtkB/dMoeeU35+Pbxkuf
         XTFRW/rvAGHTQZnYwDgk0nDKlq5k5FUfuBESQBX0G3jf7GRUgOoHOHtRmf23av+jFA
         QEmcYoKlbqy5T6trsm4ct6oNtZ6rpLCkL8blYDltnW6Bhg+ibHCX8HLnaMyPoBMhwh
         tZ06D2moRfmYxvo1CykV4UpTin2lNzjCq3n2zhbEP29Q35J7tdrv3Xzebet3//b1vR
         oVrgNFatqUNVQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 03/11] mm/damon/core: Remove unnecessary error messages
Date:   Wed,  1 Dec 2021 15:04:32 +0000
Message-Id: <20211201150440.1088-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DAMON core prints error messages when damon_target object creation is
failed or wrong monitoring attributes are given.  Because appropriate
error code is returned for each case, the messages are not essential.
Also, because the code path can be triggered with user-specified input,
this could result in kernel log mistakenly being messy.  To avoid the
case, this commit removes the messages.

Fixes: 4bc05954d007 ("mm/damon: implement a debugfs-based user space interface")
Fixes: b9a6ac4e4ede ("mm/damon: adaptively adjust regions")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ccc62479549a..04b8df7fd9e9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -282,7 +282,6 @@ int damon_set_targets(struct damon_ctx *ctx,
 	for (i = 0; i < nr_ids; i++) {
 		t = damon_new_target(ids[i]);
 		if (!t) {
-			pr_err("Failed to alloc damon_target\n");
 			/* The caller should do cleanup of the ids itself */
 			damon_for_each_target_safe(t, next, ctx)
 				damon_destroy_target(t);
@@ -312,16 +311,10 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		    unsigned long aggr_int, unsigned long primitive_upd_int,
 		    unsigned long min_nr_reg, unsigned long max_nr_reg)
 {
-	if (min_nr_reg < 3) {
-		pr_err("min_nr_regions (%lu) must be at least 3\n",
-				min_nr_reg);
+	if (min_nr_reg < 3)
 		return -EINVAL;
-	}
-	if (min_nr_reg > max_nr_reg) {
-		pr_err("invalid nr_regions.  min (%lu) > max (%lu)\n",
-				min_nr_reg, max_nr_reg);
+	if (min_nr_reg > max_nr_reg)
 		return -EINVAL;
-	}
 
 	ctx->sample_interval = sample_int;
 	ctx->aggr_interval = aggr_int;
-- 
2.17.1

