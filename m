Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB5C763B48
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjGZPjw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 11:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbjGZPjv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 11:39:51 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4611B0;
        Wed, 26 Jul 2023 08:39:47 -0700 (PDT)
X-QQ-mid: bizesmtp66t1690385976t7iihfqr
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 23:39:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 5CNn+SP0K2tQLkLI/cB/7TfAh0HH7fuHBPafOFaqQnjr3ys+wr1X4G4JaRvR3
        qPhRkkyyBgrAbZmDj01gVf2L2n+yDdZ+0WmHnYX8TidhXLfBFqjQH31IeTrcQFqKUJ01ef8
        TRVG8Dcm/GIJKfkP8eQG737aDgDu3wrz7B+JpJovDb1TzhgQtLn95kLwxpa52sPZ34mts8/
        fBDhlKnpUNm7i3QiVPiNrgc9VWjbKCaxsaGL/qJBE1oD7dtFLn2EkNY7DpXy78wSaw//3pE
        01G2Wl7jsxwndshWM7nYirSptn/dK+43F3FetgHMHXCkYmH1wJoMMZVO1TTCIKAafyruU5d
        nMC0Hqiz831rW2AAzKr+8S8nUBm1ycYGn6Jzzxqga0rYWrR5MMX8yvsAymbqWZbZk12CfH4
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17309130325439017752
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de, w@1wt.eu
Subject: [PATCH v2 4/7] selftests/nolibc: add XARCH and ARCH mapping support
Date:   Wed, 26 Jul 2023 23:39:35 +0800
Message-Id: <20230726153935.252238-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4260bf6df7417ba5395e7a1f71609690bbd11b17.1690373704.git.falcon@tinylab.org>
References: <4260bf6df7417ba5395e7a1f71609690bbd11b17.1690373704.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> [...]
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Link: https://lore.kernel.org/lkml/20230702171715.GD16233@1wt.eu/
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 27 ++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>  
> [...]
>  REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
> @@ -102,7 +110,7 @@ help:
>  	@echo "  run-user     runs the executable under QEMU (uses \$$ARCH, \$$TEST)"
>  	@echo "  initramfs    prepare the initramfs with nolibc-test"
>  	@echo "  defconfig    create a fresh new default config (uses \$$ARCH)"
> -	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$ARCH)"
> +	@echo "  kernel       (re)build the kernel with the initramfs (uses $$ARCH)"

and a wrongly removed '\' here.

Thanks,
Zhangjin

>  	@echo "  run          runs the kernel in QEMU after building it (uses \$$ARCH, \$$TEST)"
>  	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$ARCH, \$$TEST)"
>  	@echo "  clean        clean the sysroot, initramfs, build and output files"
> @@ -111,12 +119,13 @@ help:
>  	@echo ""
>  	@echo "Currently using the following variables:"
>  	@echo "  ARCH          = $(ARCH)"
> +	@echo "  XARCH         = $(XARCH)"
>  	@echo "  CROSS_COMPILE = $(CROSS_COMPILE)"
>  	@echo "  CC            = $(CC)"
>  	@echo "  OUTPUT        = $(OUTPUT)"
>  	@echo "  TEST          = $(TEST)"
> -	@echo "  QEMU_ARCH     = $(if $(QEMU_ARCH),$(QEMU_ARCH),UNKNOWN_ARCH) [determined from \$$ARCH]"
> -	@echo "  IMAGE_NAME    = $(if $(IMAGE_NAME),$(IMAGE_NAME),UNKNOWN_ARCH) [determined from \$$ARCH]"
> +	@echo "  QEMU_ARCH     = $(if $(QEMU_ARCH),$(QEMU_ARCH),UNKNOWN_ARCH) [determined from \$$XARCH]"
> +	@echo "  IMAGE_NAME    = $(if $(IMAGE_NAME),$(IMAGE_NAME),UNKNOWN_ARCH) [determined from \$$XARCH]"
>  	@echo ""
>  
>  all: run
> -- 
> 2.25.1
