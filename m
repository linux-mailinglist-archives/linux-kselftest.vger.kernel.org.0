Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB62168F3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgGGJZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 05:25:33 -0400
Received: from condef-01.nifty.com ([202.248.20.66]:62161 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGGJZc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 05:25:32 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-01.nifty.com with ESMTP id 0679NRpL013935;
        Tue, 7 Jul 2020 18:23:41 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 0679LLSD013006;
        Tue, 7 Jul 2020 18:21:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 0679LLSD013006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594113685;
        bh=DGOsSYyty8roOyC5A5FX8LaGKLV2BgeM9zt8xr5UYM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDbNjpOzvr7/x76F9KaMdoFrTKEggtICdwPlCWJ2nLX8WlTRLUc0XnIZDJhUUfr9S
         HPlA1ubAq2lrrANKINqbMM9j0unpUpp3xeFrRD5eg57ohA0L8O3BoAhXyVbUuLIxUA
         yg8Ai+v1KElzTAS1qarKG7CBoTSh0aX4xOlT2ZHIJ6Q/mDXkG3cs51o2Vnbz4QkX6/
         rfBfozMdn9L0HmhH2amrvY6S+iHkOqvqOVR2u5q5aMB1pmmlhsADDBuJt6GpiLubdi
         fybtXxsHk7w8cBGHfbU8pLSqAQavPBxRZyN7iDW+fhthgFxD3RuHOQuA+z8me3Xz1C
         5oFmfKmhIPAaQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Tal Gilboa <talgi@mellanox.com>, kunit-dev@googlegroups.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org
Subject: [PATCH v2 2/2] kbuild: trace functions in subdirectories of lib/
Date:   Tue,  7 Jul 2020 18:21:17 +0900
Message-Id: <20200707092117.963394-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707092117.963394-1-masahiroy@kernel.org>
References: <20200707092117.963394-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)

exists here in sub-directories of lib/ to keep the behavior of
commit 2464a609ded0 ("ftrace: do not trace library functions").

Since that commit, not only the objects in lib/ but also the ones in
the sub-directories are excluded from ftrace (although the commit
description did not explicitly mention this).

However, most of library functions in sub-directories are not so hot.
Re-add them to ftrace.

Going forward, only the objects right under lib/ will be excluded.

Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 lib/842/Makefile          | 3 ---
 lib/crypto/Makefile       | 2 --
 lib/dim/Makefile          | 2 --
 lib/fonts/Makefile        | 2 --
 lib/kunit/Makefile        | 3 ---
 lib/livepatch/Makefile    | 2 --
 lib/lz4/Makefile          | 1 -
 lib/lzo/Makefile          | 2 --
 lib/math/Makefile         | 2 --
 lib/mpi/Makefile          | 2 --
 lib/raid6/Makefile        | 3 ---
 lib/reed_solomon/Makefile | 2 --
 lib/xz/Makefile           | 3 ---
 lib/zlib_deflate/Makefile | 2 --
 lib/zlib_dfltcc/Makefile  | 2 --
 lib/zlib_inflate/Makefile | 2 --
 lib/zstd/Makefile         | 1 -
 17 files changed, 36 deletions(-)

diff --git a/lib/842/Makefile b/lib/842/Makefile
index b815e824ae37..6f7aad269288 100644
--- a/lib/842/Makefile
+++ b/lib/842/Makefile
@@ -1,6 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_842_COMPRESS) += 842_compress.o
 obj-$(CONFIG_842_DECOMPRESS) += 842_decompress.o
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index b557ef0b07c2..3a435629d9ce 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 # chacha is used by the /dev/random driver which is always builtin
 obj-y						+= chacha.o
 obj-$(CONFIG_CRYPTO_LIB_CHACHA_GENERIC)		+= libchacha.o
diff --git a/lib/dim/Makefile b/lib/dim/Makefile
index 97fc3e89d34e..1d6858a108cb 100644
--- a/lib/dim/Makefile
+++ b/lib/dim/Makefile
@@ -2,8 +2,6 @@
 # DIM Dynamic Interrupt Moderation library
 #
 
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_DIMLIB) += dim.o
 
 dim-y := dim.o net_dim.o rdma_dim.o
diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
index f951750c179e..ed95070860de 100644
--- a/lib/fonts/Makefile
+++ b/lib/fonts/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Font handling
 
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 font-objs := fonts.o
 
 font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 8c847557ab24..724b94311ca3 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,6 +1,3 @@
-
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
index 9abdf615b088..295b94bff370 100644
--- a/lib/livepatch/Makefile
+++ b/lib/livepatch/Makefile
@@ -2,8 +2,6 @@
 #
 # Makefile for livepatch test code.
 
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
 				test_klp_callbacks_demo.o \
 				test_klp_callbacks_demo2.o \
diff --git a/lib/lz4/Makefile b/lib/lz4/Makefile
index 53da4cab7015..5b42242afaa2 100644
--- a/lib/lz4/Makefile
+++ b/lib/lz4/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 ccflags-y += -O3
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 
 obj-$(CONFIG_LZ4_COMPRESS) += lz4_compress.o
 obj-$(CONFIG_LZ4HC_COMPRESS) += lz4hc_compress.o
diff --git a/lib/lzo/Makefile b/lib/lzo/Makefile
index 9565a555275b..2f58fafbbddd 100644
--- a/lib/lzo/Makefile
+++ b/lib/lzo/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 lzo_compress-objs := lzo1x_compress.o
 lzo_decompress-objs := lzo1x_decompress_safe.o
 
diff --git a/lib/math/Makefile b/lib/math/Makefile
index 49aa50e28185..be6909e943bd 100644
--- a/lib/math/Makefile
+++ b/lib/math/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-y += div64.o gcd.o lcm.o int_pow.o int_sqrt.o reciprocal_div.o
 
 obj-$(CONFIG_CORDIC)		+= cordic.o
diff --git a/lib/mpi/Makefile b/lib/mpi/Makefile
index df7883521619..d5874a7f5ff9 100644
--- a/lib/mpi/Makefile
+++ b/lib/mpi/Makefile
@@ -3,8 +3,6 @@
 # MPI multiprecision maths library (from gpg)
 #
 
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_MPILIB) = mpi.o
 
 mpi-y = \
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 3482d6ae3f3b..b4c0df6d706d 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_RAID6_PQ)	+= raid6_pq.o
 
 raid6_pq-y	+= algos.o recov.o tables.o int1.o int2.o int4.o \
diff --git a/lib/reed_solomon/Makefile b/lib/reed_solomon/Makefile
index a5c9defdac7f..5d4fa68f26cb 100644
--- a/lib/reed_solomon/Makefile
+++ b/lib/reed_solomon/Makefile
@@ -3,7 +3,5 @@
 # This is a modified version of reed solomon lib,
 #
 
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_REED_SOLOMON) += reed_solomon.o
 obj-$(CONFIG_REED_SOLOMON_TEST) += test_rslib.o
diff --git a/lib/xz/Makefile b/lib/xz/Makefile
index fae9b6c7c389..fa6af814a8d1 100644
--- a/lib/xz/Makefile
+++ b/lib/xz/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_XZ_DEC) += xz_dec.o
 xz_dec-y := xz_dec_syms.o xz_dec_stream.o xz_dec_lzma2.o
 xz_dec-$(CONFIG_XZ_DEC_BCJ) += xz_dec_bcj.o
diff --git a/lib/zlib_deflate/Makefile b/lib/zlib_deflate/Makefile
index 1fcefe73536f..2622e03c0b94 100644
--- a/lib/zlib_deflate/Makefile
+++ b/lib/zlib_deflate/Makefile
@@ -7,8 +7,6 @@
 # decompression code.
 #
 
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate.o
 
 zlib_deflate-objs := deflate.o deftree.o deflate_syms.o
diff --git a/lib/zlib_dfltcc/Makefile b/lib/zlib_dfltcc/Makefile
index 7a8067f6e772..8e4d5afbbb10 100644
--- a/lib/zlib_dfltcc/Makefile
+++ b/lib/zlib_dfltcc/Makefile
@@ -6,8 +6,6 @@
 # This is the code for s390 zlib hardware support.
 #
 
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_ZLIB_DFLTCC) += zlib_dfltcc.o
 
 zlib_dfltcc-objs := dfltcc.o dfltcc_deflate.o dfltcc_inflate.o dfltcc_syms.o
diff --git a/lib/zlib_inflate/Makefile b/lib/zlib_inflate/Makefile
index a451e96f9845..27327d3e9f54 100644
--- a/lib/zlib_inflate/Makefile
+++ b/lib/zlib_inflate/Makefile
@@ -14,8 +14,6 @@
 # uncompression can be done without blocking on allocation).
 #
 
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
-
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate.o
 
 zlib_inflate-objs := inffast.o inflate.o infutil.o \
diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index 01be908a2d94..f5d778e7e5c7 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -3,7 +3,6 @@ obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
 obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
 
 ccflags-y += -O3
-ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 
 zstd_compress-y := fse_compress.o huf_compress.o compress.o \
 		   entropy_common.o fse_decompress.o zstd_common.o
-- 
2.25.1

