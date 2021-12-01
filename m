Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF6D4650CB
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350294AbhLAPIZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:25 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52674 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350240AbhLAPIY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7B8CECE1F98;
        Wed,  1 Dec 2021 15:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0692FC53FD4;
        Wed,  1 Dec 2021 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371100;
        bh=QvKLyeU28c3oSLP1SZ6xf8Zv4RAz+uvm7dyfC1S1NOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6ZOyrMtRVXJ0gxKymQSSiPsPFARFklHLvVFd25Rqhxlm6z2yj2yoHMMMDdW+NsIt
         /Yn5z3lzZ9gQ0rGZPrGNh1G8a0qmIN6BP4lbOfcYFgzr1boPuQJBakCtGTtef9iJrw
         gsZDWFNNxzbDfYQeV7edP04a2bchhDxfIBlOMqmYgKsqT1bE5GN7ciRTVJeVj8cocN
         XqqGW28xR+JnvwZSW7AULLw9Cdq76p7Ka/MfrxLweY5O49ubJGKxCPh6ll0V3droj7
         l40DkKMCXSbmUysDNRgVDYWUhoWnp8pgPFT9RR8pK0HmPHgMds2vHmHoyfaIY3U/hD
         IEs6giIGZpB2g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 02/11] mm/damon/dbgfs: Remove an unnecessary error message
Date:   Wed,  1 Dec 2021 15:04:31 +0000
Message-Id: <20211201150440.1088-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When wrong scheme action is requested via the debugfs interface, DAMON
prints an error message.  Because the function returns error code, this
is not really needed.  Because the code path is triggered by the user
specified input, this can result in kernel log mistakenly being messy.
To avoid the case, this commit removes the message.

Fixes: af122dd8f3c0 ("mm/damon/dbgfs: support DAMON-based Operation Schemes")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 4bf4204444ab..5b628990ae6e 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -210,10 +210,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 				&wmarks.low, &parsed);
 		if (ret != 18)
 			break;
-		if (!damos_action_valid(action)) {
-			pr_err("wrong action %d\n", action);
+		if (!damos_action_valid(action))
 			goto fail;
-		}
 
 		if (min_sz > max_sz || min_nr_a > max_nr_a || min_age > max_age)
 			goto fail;
-- 
2.17.1

