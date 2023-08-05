Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E2E771193
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 20:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHESr1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 14:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjHESr0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 14:47:26 -0400
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670622D72;
        Sat,  5 Aug 2023 11:47:22 -0700 (PDT)
X-QQ-mid: bizesmtp82t1691261231ty7dc1hm
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 02:47:10 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: IflLXxRcVR1gTGRr2ilcxmRzcus46IF74wtKQ1oFpYWF072KtLJW0K9dIyVlQ
        tohiSan5e61KVmLF1i837mkqkFeEpBoKGRNFKxoJR7iO7LtaKY504LrTMtnCdLw3BYmNgR0
        uAi3fjj2iGvwuTi3rX88NGC8qRmaNrQaKg1Z9XcDF7Lj0ZJrxsHLZIh4VM2TT+i3H1cW0y7
        qcJ+At/jX0gv6Djuqg7s54+B6Il6vJ24id4luOv9ZOxNwnxIXbeIPQr5OH2x0C04z0ga7vt
        Hxy0/9GCxzQbl2AlPzJ6lKTqHblp+b1WlhabeplbLHHAzCY/Vvi5tTAuJrvo/1ny6BZSttY
        kHzK8vCDkB0l2k6jjCiaTu9GUsveogjLy9M0n/VrT6raAe5sFlMMbf46ftfwEgLPzuxUDYw
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2403698746126952363
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: [PATCH v6 8/8] selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
Date:   Sun,  6 Aug 2023 02:47:09 +0800
Message-Id: <2c3ac4542621ddc4b2cab006ae8e3a7b709921f1.1691259983.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691259983.git.falcon@tinylab.org>
References: <cover.1691259983.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 45d231b9c5c2..b4171a754eb2 100644
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


