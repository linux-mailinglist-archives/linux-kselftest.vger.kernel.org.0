Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD8E765D55
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjG0U2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjG0U2b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:28:31 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861CE30CD;
        Thu, 27 Jul 2023 13:28:28 -0700 (PDT)
X-QQ-mid: bizesmtp77t1690489698t82ph8cm
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:28:17 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: dKvkn8qoLrE2yLn96qy5k0fzTpwuyKtkiBSpI4LwdFyOeVirP6jaXvT0wq5IB
        lyhlNscOT+zA2kHB7tqoZ7sJwvbTr525TCosc7zMPGfENlCjXaycc0d9ITayDt+FcvVnqoa
        CYH8kqgk62UIvsOM6IRf45fZm/tD16k4QVwCphU4X6zJSbEt3vx4jGjLm2aCkaZ0J3EdBhi
        7B+qe6+RI/NJPVFoMTuzy+BKEtxQcWXRqOEGuzqmBtamF70BLvlykk4dHD5nh7usejRRyLB
        JCBuYBm7V062gzUOMueR6pXzenYc9e5+ti7FqyhKWD/TTxpPm7P7gsGppuRl9ksU7QLJfXx
        KcL5CCZD+J3JP9LDFEiXmJZhnWcgiXe2saCrF9nZ6UbWxScnTXfUrYeU7FLGvh2Jk8EGX/e
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16216814846800268763
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 06/12] selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
Date:   Fri, 28 Jul 2023 04:28:17 +0800
Message-Id: <41e2aa9e4299dd35cfeef9fecc2a6a02a7b49d90.1690489039.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690489039.git.falcon@tinylab.org>
References: <cover.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
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

The little-endian powerpc64le compilers provided by Ubuntu and Fedora
are able to compile big endian kernel and big endian nolibc-test [1].

These default CROSS_COMPILE settings allow to test target architectures
with:

    $ cd /path/to/tools/testing/selftests/nolibc/

    $ for arch in ppc ppc64 ppc64le; do \
        make run-user ARCH=$arch | grep "status: "; \
      done

If want to use another cross compiler, please simply pass CROSS_COMPILE
or CC as before.

For example, it is able to build 64-bit nolibc-test with the big endian
powerpc64-linux-gcc crosstool from [2]:

    $ wget -c https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
    $ tar xvf x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
    $ export PATH=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/:$PATH

    $ export CROSS_COMPILE_ppc64=powerpc64-linux-
    $ export CROSS_COMPILE_ppc64le=powerpc64-linux-
    $ for arch in ppc64 ppc64le; do \
        make run-user ARCH=$arch | grep "status: "; \
      done

Or specify CC directly with full path:

    $ export CC=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc
    $ for arch in ppc64 ppc64le; do \
        make run-user ARCH=$arch | grep "status: "; \
      done

[1]: https://github.com/open-power/skiboot
[2]: https://mirrors.edge.kernel.org/pub/tools/crosstool/

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 3f15c7f7ef76..6385915d16c9 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -46,6 +46,9 @@ IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # CROSS_COMPILE: cross toolchain prefix by architecture
+CROSS_COMPILE_ppc       ?= powerpc-linux-gnu-
+CROSS_COMPILE_ppc64     ?= powerpc64le-linux-gnu-
+CROSS_COMPILE_ppc64le   ?= powerpc64le-linux-gnu-
 CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
 
 # make sure CC is prefixed with CROSS_COMPILE
-- 
2.25.1

