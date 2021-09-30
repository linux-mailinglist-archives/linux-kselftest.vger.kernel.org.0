Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183A541E34E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 23:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349748AbhI3VZD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 17:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhI3VZD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 17:25:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE027C06176A
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 14:23:19 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id az37-20020a05620a172500b0045e43348ee8so14644846qkb.19
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wbUrvvm0+MYAPUCF6HQK8A4cSFDFNCfNO8ihEMufpf8=;
        b=DXFhvoYgkBKBGW9TTScr4boM8/R+bDeePetODemKEZwYhJLpOOzrVNl6U0O8viIeqk
         pp2IrEkYyQyq4j2XkKfWQ4VittBUoFL9eK6QgTF8xsJnQegzB1LmqaFt8EgKiCyym1JF
         GE/gxRXqPXWqWaj96T8kz7tdyVHIJtP91uuXP/xkt5uGZ9Ozc/hLHZVAjgDUOulIv5Gj
         JqN+T2CECrPI/0jEt+gTV12f8/TErC9CAukhyWp/vFoE+aRLAIFWUO/ZufY6xbX/VP++
         2SBzxCS4wW06iaipZX8I5I10tTC9VxTqNnPo/gvPYQVZ4WpVfyneUQu3oXKgMzRcQd3o
         zngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wbUrvvm0+MYAPUCF6HQK8A4cSFDFNCfNO8ihEMufpf8=;
        b=spN2Tl+4DaLviEdiW4q8CMMe36Jzk289VQOOR6Dtye9sGf9uiROd+N800+7l46tCfd
         vFhoGmJsxyLgewd5qhVXtTdWOdAa91bCxWtt8GQ1pwGY03dXlEFOi8GHwjby9KkLVWKz
         bWSAKqnY5mkFfKc54uiQgGz/YEs8Kk27wb6S9U/njOmF0sSXOEun6vIWbgBOAi29IB6H
         bxXYHTCC+MQ3O/P9cP82PRQ/EM+tURbwi72XXPGYh16ZchlwlBj2EfXWzVyZxGlooo/k
         /sHgI4T6R/QW3kVf4iX6W1BI+y57D7dUbh3rnMos1oNp3wO+Ebc4jhDTyX5cxbTgkI4B
         Ie3w==
X-Gm-Message-State: AOAM533XKX3IaUv2jT6UJwzUSYkhmSuPBHmdyrSB8RkAumv1rBH1tbyh
        BobFhmvzGr7gjnsbPzaeJ8wATr5eqgj1UByi+jOV
X-Google-Smtp-Source: ABdhPJywOpI+b7jm0hToN3nP52PlVum8uravic0hgie7sww9kEWkrOanS+hnSp8P208w/79s1xImwJumjKcifP/pZ7/r
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:fa06:3b29:d3c:37e6])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:12af:: with SMTP id
 w15mr5967689qvu.66.1633036999024; Thu, 30 Sep 2021 14:23:19 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:23:07 -0700
In-Reply-To: <20210930212309.4001967-1-axelrasmussen@google.com>
Message-Id: <20210930212309.4001967-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210930212309.4001967-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 1/3] userfaultfd/selftests: don't rely on GNU extensions
 for random numbers
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 26 ++++--------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 10ab56c2484a..2a71a91559a7 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -57,6 +57,7 @@
 #include <assert.h>
 #include <inttypes.h>
 #include <stdint.h>
+#include <sys/random.h>
 
 #include "../kselftest.h"
 
@@ -501,22 +502,10 @@ static void continue_range(int ufd, __u64 start, __u64 len)
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
@@ -524,15 +513,8 @@ static void *locking_thread(void *arg)
 
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
2.33.0.800.g4c38ced690-goog

