Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D381F7BC800
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343880AbjJGNmN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjJGNmN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 09:42:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700FB6;
        Sat,  7 Oct 2023 06:42:10 -0700 (PDT)
X-QQ-mid: bizesmtp80t1696686124tki9cnn8
Received: from linux-lab-host.localdomain ( [116.30.131.235])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 07 Oct 2023 21:42:03 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: +ynUkgUhZJk7Fs1t8lUqtLH+EA8mn1TwpN/pWP05T+XG/tIY7HHE3pWYLRvU7
        pe9msVxgs1t4pSKYQRrNZ7pHFhsaR+ZDN8xdpZY1yHm8KuhdtpodfhHL6QgVvoWngzz8vKY
        yP5MBJQLQSxa0+n1Wyp7b1BRA7iyIBRiML7sTqvLHdFRK/ClBu6nMzJqeQhPsAIrS1U6HMg
        HILUJdVdI9p3rjZFPVlB+6t3iH1uzHgqj6mcsO8Wzrrb0fEhnu5U2djZYWDTF3bTHWsF24I
        VmY7yENLJBWnsmW4ZOYPMUfqmnAj4u39XkTtgd8oCfTkiHVDZevNyudZ8p1BZApheHajrKI
        pM3JhFxHU2LkLfGVcC7ivIzRDmPUXk6JelUtFDAj8TzTX6uU2Nu6XOgg9zzPQuRHbyavWBz
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9388055664300987120
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        stable@vger.kernel.org, w@1wt.eu
Subject: [PATCH] Re: tools/nolibc: drop test for getauxval(AT_PAGESZ)
Date:   Sat,  7 Oct 2023 21:42:02 +0800
Message-Id: <20231007134202.6766-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231007-nolibc-auxval-pagesz-v1-1-af00804edead@weissschuh.net>
References: <20231007-nolibc-auxval-pagesz-v1-1-af00804edead@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> The test will not work for systems with pagesize != 4096 like aarch64
> and some others.
>

We have used EXPECT_GE() instead of EXPECT_EQ(), so this should not
fail, do I miss something ?;-)

Thanks,
Zhangjin Wu

> Other testcases are already testing the same functionality:
> * auxv_AT_UID tests getauxval() in general.
> * test_getpagesize() tests pagesize() which directly calls
>   getauxval(AT_PAGESZ).
> 
> Fixes: 48967b73f8fe ("selftests/nolibc: add testcases for startup code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Note:
> 
> This should probably also make it into 6.6.
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index a3ee4496bf0a..7e3936c182dc 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -630,7 +630,6 @@ int run_startup(int min, int max)
>  		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
>  		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
>  		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
> -		CASE_TEST(auxv_AT_PAGESZ);   EXPECT_GE(1, getauxval(AT_PAGESZ), 4096); break;
>  		case __LINE__:
>  			return ret; /* must be last */
>  		/* note: do not set any defaults so as to permit holes above */
> 
> ---
> base-commit: ab663cc32912914258bc8a2fbd0e753f552ee9d8
> change-id: 20231007-nolibc-auxval-pagesz-05f5ff79c4c4
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
