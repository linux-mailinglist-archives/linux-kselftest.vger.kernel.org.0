Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89EB4650CA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350248AbhLAPIY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52668 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245059AbhLAPIX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9ECCCCE1DBB;
        Wed,  1 Dec 2021 15:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BC5C53FCC;
        Wed,  1 Dec 2021 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371099;
        bh=LnVq1MEm2bCsu9Z8LA3AWGyf0J5QJ1npa9erK6XACwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKE1umMNcZcEJrZUq9xVufn4g8c2edh5yFbyvY6b4Wf8XDc0tMQP3s4H832Sk+k1j
         k1gt7arlHYl1vnDooDiRmdiB9y3E3zPE+9ZnmwmFr2OBksR15oA43V2sCaB0Hfr1Js
         4LVeGCcAcTpTg0hqXVC1SYg+cClPnZ4AEt1FK9EEkVy2tshf9TAiejafEuFm3AZZYp
         8Yo78c1orW2M2zl39yXwGG9e1mHS94RJtouxGGCq3ACk3K0ozczPMDjFsTHYyKtjaO
         rWd3DTtmaVARqtl2vbUwoOknnXoANg2BPmd7o+oGeZZqLODhzpZRgCM9hU3DHbu5RT
         dCcyfoS+w6++g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 01/11] mm/damon/core: Use better timer mechanisms selection threshold
Date:   Wed,  1 Dec 2021 15:04:30 +0000
Message-Id: <20211201150440.1088-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

DAMON is using hrtimer if requested sleep time is <=100ms, while the
suggested threshold[1] is <=20ms.  This commit applies the threshold.

[1] Documentation/timers/timers-howto.rst

Fixes: ee801b7dd7822 ("mm/damon/schemes: activate schemes based on a watermarks mechanism")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8cd8fddc931e..ccc62479549a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -978,7 +978,8 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 
 static void kdamond_usleep(unsigned long usecs)
 {
-	if (usecs > 100 * 1000)
+	/* See Documentation/timers/timers-howto.rst for the thresholds */
+	if (usecs > 20 * USEC_PER_MSEC)
 		schedule_timeout_idle(usecs_to_jiffies(usecs));
 	else
 		usleep_idle_range(usecs, usecs + 1);
-- 
2.17.1

