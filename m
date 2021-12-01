Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3395F4650CC
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350275AbhLAPI0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59500 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbhLAPIZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78434B82014;
        Wed,  1 Dec 2021 15:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BECC53FAD;
        Wed,  1 Dec 2021 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371102;
        bh=LqY9Ctk3Sg1j0lXQYGLS8aivIzz7RYVNYXV8X4hWops=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQ8dSjxVpueR792RFEpdNWiVG5R/cIx0PcmHyRlWOGB0I4u0YZFttL/8+My0kEM+G
         qGAbDDHXPEtttgiEDA1JELn6nFQtNch76XcOx7MYIyvl++cQbcmCCnyZNJmiswhcvw
         JYNrjtxgPubnRvfq+ghSfgV2t9VZXdBdIpvZHiQZCEoBbZiNztVoOvfTC92FuLPdl4
         sxgLTxXD++8TgF1r3/h5vhO2BuAkwX0tGoNaQDJ3h6HEyk4IQCYqNdHbM1WlaOl2B0
         MxQyX0m4UKuQ9pOd7gvrbIcscfq9PGHTpz0z7IOIzIuU5jde0M6587X0qHv6Kz1Cza
         dBdnS3eY3Wb6A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 04/11] mm/damon/vaddr: Remove an unnecessary warning message
Date:   Wed,  1 Dec 2021 15:04:33 +0000
Message-Id: <20211201150440.1088-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The DAMON virtual address space monitoring primitive prints a warning
message for wrong DAMOS action.  However, it is not essential as the
code returns appropriate failure in the case.  This commit removes the
message to make the log clean.

Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 79481f0c2838..a65b1a4d236c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -617,7 +617,6 @@ static int damon_va_apply_scheme(struct damon_ctx *ctx, struct damon_target *t,
 	case DAMOS_STAT:
 		return 0;
 	default:
-		pr_warn("Wrong action %d\n", scheme->action);
 		return -EINVAL;
 	}
 
-- 
2.17.1

