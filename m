Return-Path: <linux-kselftest+bounces-26062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B25A2D188
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 00:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29D03ACC70
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 23:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1AF1D86C7;
	Fri,  7 Feb 2025 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1RxTtLd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BC8479;
	Fri,  7 Feb 2025 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971529; cv=none; b=abM/BRRI5Cot1XRyZhTWDkltNe5I7ldkaHWZBfuid1rSKDqQPdbPUtF+tb1zepaMOMx9Y9BDPaioyL2vzkBVxRBrZOpCCypQvgar2qxP9PMvhK8v5rPiQRd1mVSXBpzyfCKfxU76Pl5dpQDBiY2tauaec4haYA7HRfl2+gsi1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971529; c=relaxed/simple;
	bh=BkTWJoWP2WfdeOTFjlr/lcL4ibVk6vt/UZhSO/XKCNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T32BPNyGoRJSCinOdUmIyRPdY6IUzONvOIYmxcHZe6DKGCKLzF4u1f1TPmEccVcV5zsJmL+pH6I9O6C7zVpCi5j+IiCt0f/+IIPZPEKbsD9c7k/B7JCLPjVhggkaiMiOy5AlknSvg8wqZ3161m0liEpNoh4ivPZeXFfcvv7mQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1RxTtLd; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d92e457230so26697926d6.1;
        Fri, 07 Feb 2025 15:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738971527; x=1739576327; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNXBg4daHIABB/yTMDVoSJWD25P1rTtltrI8i7arR5c=;
        b=C1RxTtLdnhlL7HmpabQgkk+natnOikyuv1Qu6MquCqeuDYVIS+Rz0LJGo03pPzHJ1W
         qEclfHItyMtQ8540zC1USnqECDr2cz84tuIyie9vsIveTdBSxOeSgmSOR5ZRbzfjPkxy
         6isTXqeJDuGXbnobc8Mj9iIsbdU8nyLkqRRjLwQ/iF4hUpj27+rjONex1T87d5kIppYR
         8aooo36S98DPFncgyNZ6kCypN7ZtGMhPNcFIXc1nFx8erQExph2dva6eSeqlJ95PRs8O
         jyFhWQ6Ow3/b8JIUKhWCnrra+gEYftOr1JujWL/XA646+RXVp3CVlnwuRuI2Q5CrtV+V
         UMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738971527; x=1739576327;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNXBg4daHIABB/yTMDVoSJWD25P1rTtltrI8i7arR5c=;
        b=nQyVSCkvrXQsPzlFSWu1FEIEpg6c80G9SeAULMsobNdwQpHqbSFbLf2ICKzv3hUP+T
         gQBYyAQEwiK0pdBlJiQBNTHjgLyM23HxnTOgn0R/iHDa+M6Na2YfbZpJTH0jVtKhxVPG
         lxKR1+FFNItxgSWgp0xKJzj65B99gTLnpDY/haKWDIvHXXmto8UiCnCSIm9u/JqQLPyJ
         WmV0d42Jc3cl43HIbLGQFPpU4qYHY5m1f81bt/cWf7z1aZQmL6sfwaHYssXe6FEcLgPH
         gw+oQ3lq/vBvyiGd6xOuEBt2Lo3cFtj53UoHpJUPfC6uyxGd/tXMcSRpSEtIFUV3dqjA
         QvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH/Ma5sePzcyGg0RNdNwyUMMyrVkAvZ5ic9eFtHDoWFK/6C34Ep4Em7nPbs/t+OdM0RuwLN9jSttXo3OUzxJo=@vger.kernel.org, AJvYcCW6S85uZ4pgvtOJVbPTWQSUUeTZq+mxVAR2sLNnPogqxDWCiJoN/E5CbzdIrzogYuydk42j6TKR@vger.kernel.org
X-Gm-Message-State: AOJu0YzGii0NCpvyVGPC9agpInF9rl8HYMrPoKD/Y4/7AHvtUdri4WvN
	L9fv//2en58FPTAQgHzcgUMw3ZInXYKLUUXYDa5alF4i16VcsFJ4
X-Gm-Gg: ASbGncsR5+f4YcIvErB9v94eKrhCaBhp4ZnFIHVcbRVtcrBsGAhBk3tHoPBVe5ZeidK
	8B7cg10evkzjJ4HD2S1015a1egzhHNJ51QcrreiQvXsGilDUYV+XLFQTnD7YnibA6y/xxZiTLdc
	a7aAUVyJAUj72r17RRoOOd7dReMZJAt9B3duXTPumjA4n32OJ3xDnTua4ngYqeZZRSppvDH8yMl
	X1NpV2mLn7iUi5+MX1lvSNnNh7sFr9k1yBEZL9pO3LPjFsotjPTXUzYu7UxC8QMdxeXbGqXWNi5
	shL3P3TjVpqYU1vW+k7fzJxPTqZCn33Y84ugxT3B9+9ZicPmmQ==
X-Google-Smtp-Source: AGHT+IFgwe+y0rnFQIDXEowT8WZlxbeKXv4NpGTED5yOqbyNN1kdkaooufe+2Y2XJ+62b9eMKCK6CA==
X-Received: by 2002:a05:6214:2125:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6e4456e0c44mr73149906d6.38.1738971526687;
        Fri, 07 Feb 2025 15:38:46 -0800 (PST)
Received: from Tamirs-MacBook-Pro.local ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43baacbbasm22006416d6.73.2025.02.07.15.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 15:38:45 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Feb 2025 18:38:41 -0500
Subject: [PATCH] blackhole_dev: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-blackholedev-kunit-convert-v1-1-8ef0dc1ff881@gmail.com>
X-B4-Tracking: v=1; b=H4sIAICZpmcC/x3MQQqAIBBA0avErBuwiYi6SrQwm2ooNLQkkO6ex
 F+9zU8Q2AsH6IsEnqMEcTajKgswm7Yro8zZQIoaRarF6dBm39zBM0fcbysXGmcj+ws73ZCucqo
 myIPT8yLPPx/G9/0A2TrPEmwAAAA=
X-Change-ID: 20250207-blackholedev-kunit-convert-9a52a1a1a032
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Convert this very simple smoke test to a KUnit test.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 --kconfig_add CONFIG_NET=y blackholedev
---
 lib/Kconfig.debug                                  | 20 +++++-----
 lib/Makefile                                       |  2 +-
 ...{test_blackhole_dev.c => blackhole_dev_kunit.c} | 45 ++++++++--------------
 tools/testing/selftests/net/Makefile               |  2 +-
 tools/testing/selftests/net/test_blackhole_dev.sh  | 11 ------
 5 files changed, 28 insertions(+), 52 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..238321830993 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2557,15 +2557,6 @@ config TEST_BPF
 
 	  If unsure, say N.
 
-config TEST_BLACKHOLE_DEV
-	tristate "Test blackhole netdev functionality"
-	depends on m && NET
-	help
-	  This builds the "test_blackhole_dev" module that validates the
-	  data path through this blackhole netdev.
-
-	  If unsure, say N.
-
 config FIND_BIT_BENCHMARK
 	tristate "Test find_bit functions"
 	help
@@ -2888,6 +2879,17 @@ config USERCOPY_KUNIT_TEST
 	  on the copy_to/from_user infrastructure, making sure basic
 	  user/kernel boundary testing is working.
 
+config BLACKHOLE_DEV_KUNIT_TEST
+	tristate "Test blackhole netdev functionality" if !KUNIT_ALL_TESTS
+	depends on NET
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the "blackhole_dev_kunit" module that validates the
+	  data path through this blackhole netdev.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7afbbb8..19ff6993c2bc 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -102,7 +102,6 @@ obj-$(CONFIG_TEST_RUNTIME) += tests/
 obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
 obj-$(CONFIG_TEST_MEMCAT_P) += test_memcat_p.o
 obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
-obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
@@ -393,6 +392,7 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
+obj-$(CONFIG_BLACKHOLE_DEV_KUNIT_TEST) += blackhole_dev_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/test_blackhole_dev.c b/lib/blackhole_dev_kunit.c
similarity index 70%
rename from lib/test_blackhole_dev.c
rename to lib/blackhole_dev_kunit.c
index ec290ac2a0d9..f8f5184d5b43 100644
--- a/lib/test_blackhole_dev.c
+++ b/lib/blackhole_dev_kunit.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * This module tests the blackhole_dev that is created during the
+ * This tests the blackhole_dev that is created during the
  * net subsystem initialization. The test this module performs is
  * by injecting an skb into the stack with skb->dev as the
  * blackhole_dev and expects kernel to behave in a sane manner
@@ -9,9 +9,8 @@
  * Copyright (c) 2018, Mahesh Bandewar <maheshb@google.com>
  */
 
-#include <linux/init.h>
+#include <kunit/test.h>
 #include <linux/module.h>
-#include <linux/printk.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
 #include <linux/udp.h>
@@ -25,17 +24,15 @@
 
 #define UDP_PORT 1234
 
-static int __init test_blackholedev_init(void)
+static void test_blackholedev(struct kunit *test)
 {
 	struct ipv6hdr *ip6h;
 	struct sk_buff *skb;
 	struct udphdr *uh;
 	int data_len;
-	int ret;
 
 	skb = alloc_skb(SKB_SIZE, GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
+	KUNIT_ASSERT_NOT_NULL(test, skb);
 
 	/* Reserve head-room for the headers */
 	skb_reserve(skb, HEAD_SIZE);
@@ -68,32 +65,20 @@ static int __init test_blackholedev_init(void)
 	skb->dev = blackhole_netdev;
 
 	/* Now attempt to send the packet */
-	ret = dev_queue_xmit(skb);
-
-	switch (ret) {
-	case NET_XMIT_SUCCESS:
-		pr_warn("dev_queue_xmit() returned NET_XMIT_SUCCESS\n");
-		break;
-	case NET_XMIT_DROP:
-		pr_warn("dev_queue_xmit() returned NET_XMIT_DROP\n");
-		break;
-	case NET_XMIT_CN:
-		pr_warn("dev_queue_xmit() returned NET_XMIT_CN\n");
-		break;
-	default:
-		pr_err("dev_queue_xmit() returned UNKNOWN(%d)\n", ret);
-	}
-
-	return 0;
+	KUNIT_EXPECT_EQ(test, dev_queue_xmit(skb), NET_XMIT_SUCCESS);
 }
 
-static void __exit test_blackholedev_exit(void)
-{
-	pr_warn("test_blackholedev module terminating.\n");
-}
+static struct kunit_case blackholedev_cases[] = {
+	KUNIT_CASE(test_blackholedev),
+	{},
+};
+
+static struct kunit_suite blackholedev_suite = {
+	.name = "blackholedev",
+	.test_cases = blackholedev_cases,
+};
 
-module_init(test_blackholedev_init);
-module_exit(test_blackholedev_exit);
+kunit_test_suite(blackholedev_suite);
 
 MODULE_AUTHOR("Mahesh Bandewar <maheshb@google.com>");
 MODULE_DESCRIPTION("module test of the blackhole_dev");
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 73ee88d6b043..afa4bcdc5833 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -7,7 +7,7 @@ CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
 CFLAGS += -I../
 
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
-	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
+	      rtnetlink.sh xfrm_policy.sh
 TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_defrag.sh
 TEST_PROGS += udpgso_bench.sh fib_rule_tests.sh msg_zerocopy.sh psock_snd.sh
 TEST_PROGS += udpgro_bench.sh udpgro.sh test_vxlan_under_vrf.sh reuseport_addr_any.sh
diff --git a/tools/testing/selftests/net/test_blackhole_dev.sh b/tools/testing/selftests/net/test_blackhole_dev.sh
deleted file mode 100755
index 3119b80e711f..000000000000
--- a/tools/testing/selftests/net/test_blackhole_dev.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Runs blackhole-dev test using blackhole-dev kernel module
-
-if /sbin/modprobe -q test_blackhole_dev ; then
-	/sbin/modprobe -q -r test_blackhole_dev;
-	echo "test_blackhole_dev: ok";
-else
-	echo "test_blackhole_dev: [FAIL]";
-	exit 1;
-fi

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-blackholedev-kunit-convert-9a52a1a1a032

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


