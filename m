Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9097596CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGSN3h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGSN3g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:29:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D917CD;
        Wed, 19 Jul 2023 06:29:35 -0700 (PDT)
X-QQ-mid: bizesmtp64t1689773366ta76pyye
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:29:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: LE7C6P2vL8Q0BfRZgcjdiJo/UnSCVOS7IsH3kWwbRfH751nnH5xq5eegkb9A2
        fIPhBWPApGLEc4HeEOh9ygUCa1hiysXtH+GoUhabzIewq4cHCs0VvUrucmoUpPo/CW3mduS
        dnAMPba5AQnAdblgdV+pfY/UKnR0FRv6U2/uyqXm3kgl4Z54ucn6Ifaw56tFSqCDe0Cp/FJ
        349rlhWoDaRkk2l5RshiaORaK9Dg7I9UC2ThBpndLQC3IT7lweIiUO5odkE5wsOpd1hVdn4
        NBQQ4Ld0AAZyumP4QjkWIKvsuaBBaxqaRJXbpFNEbzk1mj6+CecA69hItVvArxI8I6XYEb2
        DJA56O+h4dTZ+Z/GIORbsN96NTx7vb9iyJmj0n+c/fBq0ye9Axb+YJ73hz7W+QmxxFLhtGN
        I+Qth9VpW/4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12510972291821297194
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 11/14] selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
Date:   Wed, 19 Jul 2023 21:29:24 +0800
Message-Id: <3056b81ad829b512ef89c2ae0772d92b69efa0cf.1689759351.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689759351.git.falcon@tinylab.org>
References: <cover.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The little-endian powerpc64le compilers provided by Ubuntu and Fedora
are able to compile big endian kernel and big endian nolibc-test [1].

These default CROSS_COMPILE settings allow us to test target
architectures with:

    $ cd /path/to/tools/testing/selftests/nolibc/

    $ for arch in powerpc powerpc64 powerpc64le; do \
        make run-user XARCH=$arch | grep "status: "; \
      done

If want to use another cross compiler, please simply pass CROSS_COMPILE
or CC as before.

For example, it is able to build 64-bit nolibc-test with the big endian
powerpc64-linux-gcc crosstool from [2]:

    $ wget -c https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
    $ tar xvf x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
    $ export PATH=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/:$PATH

    $ export CROSS_COMPILE_powerpc64=powerpc64-linux-
    $ export CROSS_COMPILE_powerpc64le=powerpc64-linux-
    $ for arch in powerpc64 powerpc64le; do \
        make run-user XARCH=$arch | grep "status: "; \
      done

Or specify CC directly with full path:

    $ export CC=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc
    $ for arch in powerpc64 powerpc64le; do \
        make run-user XARCH=$arch | grep "status: "; \
      done

[1]: https://github.com/open-power/skiboot
[2]: https://mirrors.edge.kernel.org/pub/tools/crosstool/

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 3c2be27747ea..eec2935672ad 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -43,6 +43,9 @@ IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # CROSS_COMPILE: cross toolchain prefix by architecture
+CROSS_COMPILE_powerpc     ?= powerpc-linux-gnu-
+CROSS_COMPILE_powerpc64   ?= powerpc64le-linux-gnu-
+CROSS_COMPILE_powerpc64le ?= powerpc64le-linux-gnu-
 CROSS_COMPILE             ?= $(CROSS_COMPILE_$(XARCH))
 
 # make sure CC is prefixed with CROSS_COMPILE
-- 
2.25.1

