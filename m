Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09501756ADE
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjGQRlC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGQRlC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 13:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D1511C
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689615613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4zjgn0cYB98ujXpFEQtfUyI4X2KQIDCSEQefL4BBIc=;
        b=R7F/xu9Mc8h0fWEtL3oiEqmD1P3ORkVylDqRcBhg1GAVQizQVVQgbf2jQPn/6EL2Y4l+Z8
        89/7jf4XXrRGtgfukhbw+C6/NOwF+sP5p/euXsmpI0h7sOAZsKfhBXV+yalvGIgUiVxTOF
        p5fkBFz7z6F931H62q9C4LIvub9BbAI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-f0zjSi9zMfajXB3HMCz9RA-1; Mon, 17 Jul 2023 13:40:12 -0400
X-MC-Unique: f0zjSi9zMfajXB3HMCz9RA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-315a03cae87so2259217f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 10:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689615611; x=1692207611;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4zjgn0cYB98ujXpFEQtfUyI4X2KQIDCSEQefL4BBIc=;
        b=iMYDFLBRlTMH9cMLJ+0nVZCLAWX9/I0SWvkvBjhZALrsIN3iFon6OQ7SZQNMdGO65L
         D2g3w/XYXa+u4uw0SXo2fAq0xxmN+bTNbtNqAvj3tK6ApKnL0zIKRwJ3GSLBs5nfI9dA
         +MWtgB83B0ZZEBX60pJuMppbFnRGklfBYQsvowdiWKq94rejJy3TygMaWP5k5TL1eQ2x
         POD99mXGX3pV+TTgZtF6GNqOQ4pErb/MRDtx4jp59sQgzjcCxcvwC6feoXq7ru4e1VdR
         MrXhBwSjYCpBQJYpKT2nrHMgkvJK4GT6MM+zL1fAPLL8QJGhiYfeK0W+OgdAdOU67yG6
         FMOg==
X-Gm-Message-State: ABy/qLYC5LiIwwyhR2chTyx0uUYf1w7aW2lEXpb8Qnf/910sVnFg1IwD
        n8TNB08/JbruPwsj4cYe5Dqaey3nv+AqBiM7t8aeMAIJu8g5EyaQHG/FdV26/4Dr8RptMrp2Imx
        yxhVnyMbUV8w3S8r+ZDwEm07n02db
X-Received: by 2002:a5d:6a4b:0:b0:314:2d59:c6d5 with SMTP id t11-20020a5d6a4b000000b003142d59c6d5mr8812528wrw.15.1689615611229;
        Mon, 17 Jul 2023 10:40:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHEPgjdDbvTWro3bKwzreEOmxLeSINhxQaDSvP7WJA9cGucuWmHNwMsfnwVewA5GsbLTJHKRQ==
X-Received: by 2002:a5d:6a4b:0:b0:314:2d59:c6d5 with SMTP id t11-20020a5d6a4b000000b003142d59c6d5mr8812516wrw.15.1689615610882;
        Mon, 17 Jul 2023 10:40:10 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c62d6.dip0.t-ipconnect.de. [91.12.98.214])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d56c3000000b0030ae3a6be4asm42184wrw.72.2023.07.17.10.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:40:10 -0700 (PDT)
Message-ID: <20501a7c-19f6-4154-aebc-49df04c9b043@redhat.com>
Date:   Mon, 17 Jul 2023 19:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-7-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 6/8] selftests/mm: Make migration test robust to
 failure
In-Reply-To: <20230717103152.202078-7-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.07.23 12:31, Ryan Roberts wrote:
> The `migration` test currently has a number of robustness problems that
> cause it to hang and leak resources.
> 
> Timeout: There are 3 tests, which each previously ran for 60 seconds.
> However, the timeout in mm/settings for a single test binary was set to
> 45 seconds. So when run using run_kselftest.sh, the top level timeout
> would trigger before the test binary was finished. Solve this by meeting
> in the middle; each of the 3 tests now runs for 20 seconds (for a total
> of 60), and the top level timeout is set to 90 seconds.
> 
> Leaking child processes: the `shared_anon` test fork()s some children
> but then an ASSERT() fires before the test kills those children. The
> assert causes immediate exit of the parent and leaking of the children.
> Furthermore, if run using the run_kselftest.sh wrapper, the wrapper
> would get stuck waiting for those children to exit, which never happens.
> Solve this by deferring any asserts until after the children are killed.
> The same pattern is used for the threaded tests for uniformity.
> 
> With these changes, the test binary now runs to completion on arm64,
> with 2 tests passing and the `shared_anon` test failing.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/migration.c | 14 ++++++++++----
>   tools/testing/selftests/mm/settings    |  2 +-
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
> index 379581567f27..189d7d9070e8 100644
> --- a/tools/testing/selftests/mm/migration.c
> +++ b/tools/testing/selftests/mm/migration.c
> @@ -15,7 +15,7 @@
>   #include <time.h>
>   
>   #define TWOMEG (2<<20)
> -#define RUNTIME (60)
> +#define RUNTIME (20)
>   
>   #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>   
> @@ -118,6 +118,7 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>   {
>   	uint64_t *ptr;
>   	int i;
> +	int ret;
>   
>   	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>   		SKIP(return, "Not enough threads or NUMA nodes available");
> @@ -131,9 +132,10 @@ TEST_F_TIMEOUT(migration, private_anon, 2*RUNTIME)
>   		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
>   			perror("Couldn't create thread");
>   
> -	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
> +	ret = migrate(ptr, self->n1, self->n2);
>   	for (i = 0; i < self->nthreads - 1; i++)
>   		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
> +	ASSERT_EQ(ret, 0);

Why is that required? This does not involve fork.

>   }
>   
>   /*
> @@ -144,6 +146,7 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>   	pid_t pid;
>   	uint64_t *ptr;
>   	int i;
> +	int ret;
>   
>   	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
>   		SKIP(return, "Not enough threads or NUMA nodes available");
> @@ -161,9 +164,10 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
>   			self->pids[i] = pid;
>   	}
>   
> -	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
> +	ret = migrate(ptr, self->n1, self->n2);
>   	for (i = 0; i < self->nthreads - 1; i++)
>   		ASSERT_EQ(kill(self->pids[i], SIGTERM), 0);
> +	ASSERT_EQ(ret, 0);


Might be cleaner to also:

diff --git a/tools/testing/selftests/mm/migration.c 
b/tools/testing/selftests/mm/migration.c
index 379581567f27..b3f12b9847ec 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -11,6 +11,7 @@
  #include <numaif.h>
  #include <sys/mman.h>
  #include <sys/types.h>
+#include <sys/prctl.h>
  #include <signal.h>
  #include <time.h>

@@ -155,10 +156,12 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
         memset(ptr, 0xde, TWOMEG);
         for (i = 0; i < self->nthreads - 1; i++) {
                 pid = fork();
-               if (!pid)
+               if (!pid) {
+                       prctl(PR_SET_PDEATHSIG, SIGHUP);
                         access_mem(ptr);
-               else
+               } else {
                         self->pids[i] = pid;
+               }
         }

         ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);


Then, whenever the parent dies, all child processes get zapped.


-- 
Cheers,

David / dhildenb

