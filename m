Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62174768DFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjGaHTc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGaHTA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 03:19:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D5E26A9;
        Mon, 31 Jul 2023 00:17:28 -0700 (PDT)
X-QQ-mid: bizesmtp77t1690787842t5hgzyql
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 15:17:21 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: R3vftN8GVq9Ng9++flvTtWIv9fJMIgWnVuZ/h8rqVeqXQUDAkYuVDG2vAG0xb
        vNE1rBohq/0oI7Kkc7FNgHX1zVpKFcioSl7WZtCZl8loiwnyzT1V8OVLYEJGMogqGAcV2sk
        2v3CpYjQN6oN7gEp8Zx+syH7LV0yo2vU8VKmBGoH92StSy2WNCesM725SmTkpRLWCvGuawi
        hNW30Pa0UfXMmobjorvIFkWF7NVnKICaDhqpuVSGtumU9BsiIzilTLT6P6d4GkNnsqnZqaI
        3viVZdhvI8KamgGHRsftoqFLjYKU+ZOINyyFiL9qiOuENdcqeDUw8JBnFgWHec7pzxxNFt8
        GajSuilPI3Y+qY5uSev56okxfJjiezA9rHBz0vdB7zu1MbPWCZC0ReYUWEMeL9jY6haUy0V
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9804258956060213056
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux@weissschuh.net
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        tanyuan@tinylab.org, w@1wt.eu
Subject: Re: [PATCH 4/4] selftests/nolibc: enable -Wall compiler warnings
Date:   Mon, 31 Jul 2023 15:17:18 +0800
Message-Id: <20230731071718.21085-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230731-nolibc-warnings-v1-4-74973d2a52d7@weissschuh.net>
References: <20230731-nolibc-warnings-v1-4-74973d2a52d7@weissschuh.net>
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

> It will help the developers to avoid cruft and detect some bugs.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index f42adef87e12..72227d75c6da 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -79,7 +79,7 @@ endif
>  CFLAGS_s390 = -m64
>  CFLAGS_mips = -EL
>  CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
> -CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
> +CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -Wall \

Very good static analyzer support.

What about further add more options?

    +CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -Wall -Wextra -Werror\

A simple test shows, it can catch more issues.

Thanks,
Zhangjin

>  		$(call cc-option,-fno-stack-protector) \
>  		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
>  LDFLAGS := -s
> 
> -- 
> 2.41.0
