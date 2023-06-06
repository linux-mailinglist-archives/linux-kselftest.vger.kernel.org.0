Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E45723F97
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbjFFKdr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbjFFKdl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 06:33:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88DD10C6;
        Tue,  6 Jun 2023 03:33:38 -0700 (PDT)
X-QQ-mid: bizesmtp77t1686047606txn7aw4u
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 06 Jun 2023 18:33:24 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: hoArX50alxGkbZTorGfzuE9D/zkJ22QpJbBObxxDyv0ziBc3Uny1TtpehSPgD
        EV9ER9LFSBjaKelNlzT5ueaWST+tVc2F5H54q4YXLk1h+ouDidqVbK9i/U9tEQQM9XQrexW
        31V6Fj6BDfnvFRy/HaByNdKUdhlwSlj2RV3eHb100GFaqd3gg+pdyJhcLgzuVCbFRQkftB/
        0Y8oA4kfgDF58mpXwJ0nOt56pYD8RJQukuAKNjixoYdwwNfaqbYFk7/ynsM4QPxjTiqUcpF
        TywG3TQU3Eg5NSbXvmiz0DehrLc7M0ArDdG1e2JDiSOt4tqE/JaL4Y6HI2k1Bwbfa80d2ou
        Id/JiMfefNvZGwfUZugWBk1CPqyaTWJG01kV4Ua6nU1VuIR+fBZrP2kBTYbRjd8uj8a5N/G
        faR5YvZJ7+s=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6183842008970657575
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux@weissschuh.net, thomas@t-8ch.de
Subject: [PATCH v2 1/4] tools/nolibc: sys.h: add __syscall() and __sysret() helpers
Date:   Tue,  6 Jun 2023 18:33:24 +0800
Message-Id: <20230606103324.512531-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a42fb9e1bbe0daf7d8a48ea8f44135ef851030d7.1686036862.git.falcon@tinylab.org>
References: <a42fb9e1bbe0daf7d8a48ea8f44135ef851030d7.1686036862.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> most of the library routines share the same code model, let's add two
> helpers to simplify the coding and shrink the code lines too.
> 
> One added for syscall return, one added for syscall call.
> 
> Thomas suggested to use inline function instead of macro for __sysret(),
> and he also helped to simplify the __syscall() a lot.
> 
> Willy suggested to make __sysret() be always inline.
> 
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Link: https://lore.kernel.org/linux-riscv/ZH1+hkhiA2+ItSvX@1wt.eu/
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Link: https://lore.kernel.org/linux-riscv/ea4e7442-7223-4211-ba29-70821e907888@t-8ch.de/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/sys.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 5464f93e863e..c12c14db056e 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -28,6 +28,18 @@
>  #include "errno.h"
>  #include "types.h"
>  
> +/* Syscall return helper, set errno as -ret when ret < 0 */
> +static inline __attribute__((always_inline)) long __sysret(long ret)

Sorry, the run-user/run targets in tools/testing/selftests/nolibc/Makefile
complains about the above line, seems it doesn't support the 'inline' keyword
and requires '__inline__'.

Just checked my own test script and the run-user / run targets, the only
difference is it forcely uses -std=c89, do we need to align with the kernel
Makefile and use -std=gnu11 instead?

Whatever, I need to change this line to align with the other codes, use
__inline__ as we have used in tools/include/nolibc/stdlib.h:

    diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
    index 0cfc5157845a..48365288a903 100644
    --- a/tools/include/nolibc/sys.h
    +++ b/tools/include/nolibc/sys.h
    @@ -29,7 +29,8 @@
     #include "types.h"
     
     /* Syscall return helper, set errno as -ret when ret < 0 */
    -static inline __attribute__((always_inline)) long __sysret(long ret)
    +static __inline__ __attribute__((unused, always_inline))
    +long __sysret(long ret)
     {
            if (ret < 0) {
                    SET_ERRNO(-ret);

Best regards,
Zhangjin

> +{
> +	if (ret < 0) {
> +		SET_ERRNO(-ret);
> +		ret = -1;
> +	}
> +	return ret;
> +}
> +
> +/* Syscall call helper, use syscall name instead of syscall number */
> +#define __syscall(name, ...) __sysret(sys_##name(__VA_ARGS__))
>  
>  /* Functions in this file only describe syscalls. They're declared static so
>   * that the compiler usually decides to inline them while still being allowed
> -- 
> 2.25.1
