Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD8371F88C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 04:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjFBCkm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 22:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjFBCkl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 22:40:41 -0400
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jun 2023 19:40:39 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186F18D;
        Thu,  1 Jun 2023 19:40:38 -0700 (PDT)
X-QQ-mid: bizesmtp76t1685673506t6z2puxi
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 02 Jun 2023 10:38:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: rZJGTgY0+YPGzwdzjqt7t/X/3VhreyvgOCYXCo0QKg7NFzI7XTezdNzxMJFju
        Dcb4D8N/iXPWBhFeou+IcHl/zMt1j6LkDSgdrCx88ZcJ8nV/wEc7POcC7Lk5G8aJR7imUF3
        sBGcqW9lbc4To4y84j+j4tNkWcQJ1NWg/GTgYTYVtvMT7E2PbaR7623iotEG8+Ux9Rq2dfh
        TKfjZMjiFnsq5/zninxuVLxAZqku15fJtVJv6pzFclKs/U9yABHDEUdgkEGBTSLSOz/fU7B
        VmglamnjsEsOVfe0uCpwWxthmIGIqtyLJEMmMdlOII3T+Iz+vNXKN04P6pwNlbm3k279DpO
        4M9XqwV7RTCscln5DuuojQjct66ZBXJzX6ok0NC
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6246330034441517476
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     linux@weissschuh.net, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH] selftests/nolibc: remove test gettimeofday_null
Date:   Fri,  2 Jun 2023 10:38:24 +0800
Message-Id: <20230602023824.11004-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530-nolibc-gettimeofday-v1-1-7307441a002b@weissschuh.net>
References: <20230530-nolibc-gettimeofday-v1-1-7307441a002b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

I plan to send the v3 of rv32 series, but this patch may conflict with:

    selftests/nolibc: remove gettimeofday_bad1/2 completely [1]

If this is mergable, perhaps I should wait for your new
2023xxxx-nolibc-rv32+stkp6 ;-)

And I plan to add the gettimeofday_tv and gettimeofday_tv_tz in the new generic
part1.

    selftests/nolibc: add new gettimeofday test cases [2]

Best regards,
Zhangjin

[1]: https://lore.kernel.org/linux-riscv/485fe4e27c1fd1a84d11e9fc47178a48de39263b.1685387484.git.falcon@tinylab.org/T/#u
[2]: https://lore.kernel.org/linux-riscv/20230530112806.404017-1-falcon@tinylab.org/T/#u

> gettimeofday() is not guaranteed by posix to handle a NULL value as first
> argument gracefully.
> On glibc for example it crashes. (When not going through the vdso)
> 
> Link: https://lore.kernel.org/lkml/96f1134d-ce6e-4d82-ae00-1cd4038809c4@t-8ch.de/
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 7de46305f419..0fe615ebb086 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -583,7 +583,6 @@ int run_syscall(int min, int max)
>  		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
>  		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
>  		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
> -		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
>  #ifdef NOLIBC
>  		CASE_TEST(gettimeofday_bad1); EXPECT_SYSER(1, gettimeofday((void *)1, NULL), -1, EFAULT); break;
>  		CASE_TEST(gettimeofday_bad2); EXPECT_SYSER(1, gettimeofday(NULL, (void *)1), -1, EFAULT); break;
> 
> ---
> base-commit: 5b21219d67d3483144d10332709d0c04f733ab93
> change-id: 20230530-nolibc-gettimeofday-6c72a10ba1a3
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>


