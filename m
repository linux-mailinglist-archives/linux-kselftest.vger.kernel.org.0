Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB374137A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Sep 2021 18:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhIUQfD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Sep 2021 12:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhIUQfA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Sep 2021 12:35:00 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B5C061575
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:33:32 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l22-20020a05622a175600b0029d63a970f6so217997927qtk.23
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Sep 2021 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XXlfpcBmbRno5SA+gst6Gevlk7ltg9389UQ9dhNVCvA=;
        b=Wf+QnXwZGfTR93ea68ZPKzFik9oK5cF0gl/6r7BXDTKkCEkNlT5puLNHR76CLQ4TxS
         sqnivS0sK15CMFeU/ykdAnnhQlLBTCOEwfM3X+Sc1uvAZ3q2dU+XX2CTC6tqtw/qpobw
         jEpk3zQXOidiuHrp/6oAP/MWm+Ybq220aML/CuZnSDiuYveXKux6S17aaiLnikWbL+QL
         k+qzoGVvrmTGw0A2trsphU4lw0U4aTCe3vkkP2ZuPFRvH5Eg6dTZcXR2p3I8D0o3GQAN
         wmv53dN1fi7EhnyFpRlW+rbaFzAB2o8DOg/NIAJK4uDK/coDPCIvKWAdo9GuKq7tFxG7
         uVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XXlfpcBmbRno5SA+gst6Gevlk7ltg9389UQ9dhNVCvA=;
        b=A5yymPU7znW/3XlphPuNRCJUqY4fCVUMZKt2QVqc263hqgR3yHUf/2hyG0KrYhUun3
         1xRWGiVxLAy3r7iDDGRvfYHuczzr2Etjd/n9r6Izats288TyWO2+ErrcbomQ2Stb3dD8
         rJhNW6cFCTv0UPFfoPlAmbeTC2MyH1mWru1uz1jK3KRbFf3uG1foQi9XC+v/Ls2sHb5Y
         trGw/ySHJhfK5FZzgT7aGCVl6DLAe3B6tdaRRgfvJylhumW34oQn0tNBG3de7pZAwGZo
         nmpwYXaBThygLe34i7ice73x7Ho9FL5+idBzk+F1Q+RYebCLYpJTBEoS6557ubMzfx00
         8FJg==
X-Gm-Message-State: AOAM533OCyMop/VJXVZ+oDytBw4nK76UpZg2oXox+Ho4dzVxC3RoHCVn
        en/oFq7Q/dsIfpsKWfGGM1rUxv1QqBnG36zpBMkB
X-Google-Smtp-Source: ABdhPJwgz8JIJfqh2iJ8cYLJJQmL1F5G7QJHu8shYN6bVP9STb44sPjeNHitaFyPqxCJcvfDRzpn0Hr1vzMSdjOiXvAJ
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:ed57:a230:8c3d:64d8])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:124e:: with SMTP id
 t14mr39259664ybu.106.1632242011222; Tue, 21 Sep 2021 09:33:31 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:33:23 -0700
In-Reply-To: <20210921163323.944352-1-axelrasmussen@google.com>
Message-Id: <20210921163323.944352-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210921163323.944352-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 3/3] userfaultfd/selftests: don't rely on GNU extensions for
 random numbers
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Two arguments for doing this:

First, and maybe most importantly, the resulting code is significantly
shorter / simpler.

Then, we avoid using GNU libc extensions. Why does this matter? It makes
testing userfaultfd with the selftest easier e.g. on distros which use
something other than glibc (e.g., Alpine, which uses musl); basically,
it makes the test more portable.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 26 ++++--------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index aad5211f5012..9d9f60e71524 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -57,6 +57,7 @@
 #include <assert.h>
 #include <inttypes.h>
 #include <stdint.h>
+#include <sys/random.h>
 
 #include "../kselftest.h"
 
@@ -528,22 +529,10 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
-	struct random_data rand;
 	unsigned long page_nr = *(&(page_nr)); /* uninitialized warning */
-	int32_t rand_nr;
 	unsigned long long count;
-	char randstate[64];
-	unsigned int seed;
 
-	if (bounces & BOUNCE_RANDOM) {
-		seed = (unsigned int) time(NULL) - bounces;
-		if (!(bounces & BOUNCE_RACINGFAULTS))
-			seed += cpu;
-		bzero(&rand, sizeof(rand));
-		bzero(&randstate, sizeof(randstate));
-		if (initstate_r(seed, randstate, sizeof(randstate), &rand))
-			err("initstate_r failed");
-	} else {
+	if (!(bounces & BOUNCE_RANDOM)) {
 		page_nr = -bounces;
 		if (!(bounces & BOUNCE_RACINGFAULTS))
 			page_nr += cpu * nr_pages_per_cpu;
@@ -551,15 +540,8 @@ static void *locking_thread(void *arg)
 
 	while (!finished) {
 		if (bounces & BOUNCE_RANDOM) {
-			if (random_r(&rand, &rand_nr))
-				err("random_r failed");
-			page_nr = rand_nr;
-			if (sizeof(page_nr) > sizeof(rand_nr)) {
-				if (random_r(&rand, &rand_nr))
-					err("random_r failed");
-				page_nr |= (((unsigned long) rand_nr) << 16) <<
-					   16;
-			}
+			if (getrandom(&page_nr, sizeof(page_nr), 0) != sizeof(page_nr))
+				err("getrandom failed");
 		} else
 			page_nr += 1;
 		page_nr %= nr_pages;
-- 
2.33.0.464.g1972c5931b-goog

