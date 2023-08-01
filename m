Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3176A876
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 07:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjHAFsc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 01:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjHAFsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 01:48:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C4119;
        Mon, 31 Jul 2023 22:48:26 -0700 (PDT)
X-QQ-mid: bizesmtp64t1690868901t0c02f9n
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Aug 2023 13:48:19 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: W+onFc5Tw4NPiGH5LHtUKH8SpenMHSikuPbIg86FMMkhn+3tjiXobadjp8olQ
        VwS36oE07P5MVVnltHrjj0JsD2MwK2GlE2yCZ0KZ2jO5Lwn4aybxqRwdf7T1BCrOIL7BERn
        Dl1T4ZjZWwK1xJKY2tcU7k/1UElf9uJ4e0S8cVEh4R7hoxvzV7q1rh3GClYASlG4MMWG3df
        70vklwg5IwpkuSkOe/bIfstP7WFVUhbum++4GnvBF1vnAHNGKi8KaBERsUtUiuJvXcwgzE8
        KKlDVyRRZly8xZywlY6lPWo23WXfBXmsOzTrQAEksEHW8Mkg7D/tFuFh5M41tCOg8y1Uv8d
        wHbHW6wYLPShWT6YMlgCwA+OBQ2kaCjwoezemz1xHEEFlREvGr4PBRAAKTAng==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9204860643675782347
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org, w@1wt.eu
Subject: [PATCH v2 08/10] selftests/nolibc: avoid sign-compare warnings
Date:   Tue,  1 Aug 2023 13:48:19 +0800
Message-Id: <20230801054819.37659-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801-nolibc-warnings-v2-8-1ba5ca57bd9b@weissschuh.net>
References: <20230801-nolibc-warnings-v2-8-1ba5ca57bd9b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> These warnings will be enabled later so avoid triggering them.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index cb17cccd0bc7..82714051c72f 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -749,7 +749,7 @@ static int test_mmap_munmap(void)
>  	};
>  
>  	page_size = getpagesize();
> -	if (page_size < 0)
> +	if (page_size == 0)
>  		return -1;
>

It was my mistake before, but do we need to align with the one used in
test_getpagesize():

    static int test_getpagesize(void)
    {
            long x = getpagesize();
            int c;
    
            if (x < 0)
                    return x;

Use 'long' instead of 'size_t' to declare page_size?

Thanks,
Zhangjin

>  	/* find a right file to mmap, existed and accessible */
> @@ -998,7 +998,7 @@ static int run_stdlib(int min, int max)
>  #define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
>  	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
>  
> -static int expect_vfprintf(int llen, size_t c, const char *expected, const char *fmt, ...)
> +static int expect_vfprintf(int llen, int c, const char *expected, const char *fmt, ...)
>  {
>  	int ret, fd, w, r;
>  	char buf[100];
> 
> -- 
> 2.41.0
