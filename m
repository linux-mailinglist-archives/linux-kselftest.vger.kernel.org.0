Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86876E76B
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjHCLwR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjHCLwQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 07:52:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606C42737;
        Thu,  3 Aug 2023 04:52:05 -0700 (PDT)
X-QQ-mid: bizesmtp73t1691063514tuggi7c1
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 19:51:53 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: +ynUkgUhZJk+StiaJH8CjSd7m19whR4AXJZDyTT8ehlxB8pTFlOigr9u1NA37
        tMGbHQ72gY+2gLRcHazy3aFdX9Hnf2SLC/ubLXX+EbxT9MTPwaIvkb8uDyFgBJgmtHHkPD2
        SjxnAPJxgYufC07vMBECkqpS2Yi17kORakhJy9Tw5MSeycf/0NQb8mT+SDK+iXSQzSPjQSI
        0uAbgM7c8zwXf5/Uc9A+dIP1skfQTEQ2zb2ghEffv0Co7xd2Vpo2blf7OptP/xKsPKJ8dpO
        h2J2M+TGThC+UZIepTZ2vvSiM3BtCqUCpdU0t0tBeUIEWwLsauZ6Kk+4yEkCuiGH/EOD5Pk
        vvki6kHaEG1siJI6o+8V7Z/giQQxB6dXMzWQhsc+sie7Gp3Ajynm14NFAZM8NRZMnZbFMrK
        prS+2FB4gUI=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16267713568485263794
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: [PATCH v5 8/8] selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
Date:   Thu,  3 Aug 2023 19:51:52 +0800
Message-Id: <e61964ff55d55529a34d80c65c7913a6bde0c2ac.1691062722.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691062722.git.falcon@tinylab.org>
References: <cover.1691062722.git.falcon@tinylab.org>
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
        make run-user XARCH=$arch | grep "status: "; \
      done

If want to use another cross compiler, please simply pass CROSS_COMPILE
or CC as before.

For example, it is able to build 64-bit nolibc-test with the big endian
powerpc64-linux-gcc crosstool from [2]:

    $ wget -c https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
    $ tar xvf x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
    $ export PATH=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/:$PATH

    $ export CROSS_COMPILE_ppc=powerpc64-linux-
    $ export CROSS_COMPILE_ppc64=powerpc64-linux-
    $ export CROSS_COMPILE_ppc64le=powerpc64-linux-
    $ for arch in ppc ppc64 ppc64le; do \
        make run-user XARCH=$arch | grep "status: "; \
      done

Or specify CC directly with full path:

    $ export CC=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc
    $ for arch in ppc ppc64 ppc64le; do \
        make run-user XARCH=$arch | grep "status: "; \
      done

[1]: https://github.com/open-power/skiboot
[2]: https://mirrors.edge.kernel.org/pub/tools/crosstool/

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 6e34d364a177..16cc33db54e3 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -56,6 +56,9 @@ IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # CROSS_COMPILE: cross toolchain prefix by architecture
+CROSS_COMPILE_ppc       ?= powerpc-linux-gnu-
+CROSS_COMPILE_ppc64     ?= powerpc64le-linux-gnu-
+CROSS_COMPILE_ppc64le   ?= powerpc64le-linux-gnu-
 CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
 
 # make sure CC is prefixed with CROSS_COMPILE
-- 
2.25.1

