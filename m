Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A376BE1B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjHATtZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 15:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjHATtT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 15:49:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67A92728;
        Tue,  1 Aug 2023 12:49:14 -0700 (PDT)
X-QQ-mid: bizesmtp68t1690919344to62hk3f
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 03:49:03 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: znfcQSa1hKbBLWA55kcreUoddWXsgcsDCazeEwO2EhbsxtiTpktOt/e/Dttm0
        0d2GKEdeHpAlQwJQc3xXv8/2hBO3KsmrrxKPL3jGr3MWPA9GxVCPnIPATBHor3ACABVMZfj
        7qWXxXaJP9Iuemw10epz54mNEH5W8RCBv5W7s5kCHNz3OBvvp1+UM2hiwsIhhUbGqqyb0ty
        SleE80b0rdcpqcWRlPXfV/cBbMXSyzLv4rd2ZV5IkMC57UPTyJZ3Nn53TDpRn89twxNILW/
        AmBUYGSLbQZEd1guuWP4AnSO0jMoRE69nWaaobj9bGSc3z844fiuw/Pnf+6ZWu0ywsftYTA
        vQKdfHdaPZ9nrpcs8+OO4zIuN7alsc3WiBUB67iSWwgDQVgrItbEX14GQT/LNoDdEQYXqDi
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18295623081681766068
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: [PATCH v4 12/12] selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
Date:   Wed,  2 Aug 2023 03:49:02 +0800
Message-Id: <2780d43e9d0a1e0e39e98b111766503eab01f4d7.1690916314.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690916314.git.falcon@tinylab.org>
References: <cover.1690916314.git.falcon@tinylab.org>
MIME-Version: 1.0
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
index 822cc4bae619..f44a09c39235 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -59,6 +59,9 @@ IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # CROSS_COMPILE: cross toolchain prefix by architecture
+CROSS_COMPILE_ppc       ?= powerpc-linux-gnu-
+CROSS_COMPILE_ppc64     ?= powerpc64le-linux-gnu-
+CROSS_COMPILE_ppc64le   ?= powerpc64le-linux-gnu-
 CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
 
 # make sure CC is prefixed with CROSS_COMPILE
-- 
2.25.1

