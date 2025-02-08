Return-Path: <linux-kselftest+bounces-26112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01908A2D853
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 20:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F831886780
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3911F30D7;
	Sat,  8 Feb 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwJtyx7u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243CC2F5B;
	Sat,  8 Feb 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739042815; cv=none; b=Gtlfavmhay2yMnApNxVX1LRoOle44DIpUQIDfI052YqmyadaDBt1mNSBG2cf5/QehQWdIwuhSpvBKNvYMI8qoSKKT2NtAR05zG5xOWElVQoXYHYcj3Z+Ge7BBdrPJ9fVp3tX03nldexmrdRwtKvjYmX+uSGeFlex6gRSAodU4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739042815; c=relaxed/simple;
	bh=FgRiLoUeYS/P2a34Mzi77DK32Q9dPe2je058z8o/H5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EiDentDnm5Jiys6iaB7n4LpKZkBEhKwRv1bXtocIaFU36d474tSdxovwGWhIP8UU4fH4+QFvowoT0AfPQjVfLpiRBEW9q16Ak68VGZdm1eP6c1Wunsa4OMoTLWe13Sjkd1UlvwIijhD7OAgEnAHBuSZjoDjCzAZokVdWKrxXIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwJtyx7u; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c05049e67aso31231985a.1;
        Sat, 08 Feb 2025 11:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739042812; x=1739647612; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErecbTkBa9sio41ZFgWnV9foB5CsuNaP3L4bJYj5st4=;
        b=cwJtyx7uZDrt0foIvvQWwxu4m+R+YUdFbO+8cgrE+indWlFyOr4l0puVDd8AZ6KDKg
         OfvSlbPyVadkrfQSnoPgiSfLXiLx5Au7y5YL1F6jLaspeCNU+JInFNdEufqeZQDuPAeZ
         ZnqldA+EboBob27+LSlKQF3qU5VLRGl+KsuT4lESTzdrJf++IvvBz04c2PKan24C+qye
         DQz1QyfXNKi26D22uMbCxlmhUsvC9Snc5hv6NIq3sWyTcD7ovst+y0v/CqxYuQl9mW+D
         nKWVvPTJg/Bg9MRG1FXxl3wh6gVBfkX7pdbKgDCVuQcbx5TDs0RVe0Y0didXv8SIdk22
         zfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739042812; x=1739647612;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErecbTkBa9sio41ZFgWnV9foB5CsuNaP3L4bJYj5st4=;
        b=uxA8JxCagcMVOl5WalbpaxWdPx8LPNmy8o07sd0aoYggkSzsKz9PsQgTGw+fy4XL+z
         HP/d1zOyrYC4jOvwpRfZ1X3SmVeKwKt1JJQ8ojtXQx/YN0FAV8YZB5vHQhk37cg9hZoK
         Xx4u2z3gYjb8NVHfu7bN+ci4fE2f1CMHMF7dyo6T54Nt428hNLENXLLIa3eo7AmqvbLF
         jY5qnBmEHeKM7banEnNWsQWJSMPk0Kltao64KimipGNMspHHVZRbfv+a9nXEy/wkIDCa
         MTfsgl2dTcwv4Bx4fDc+9VWTngbZHbwEy1yN1vnDLLavic7NOt4t4on079YyGRFf9lho
         Ziaw==
X-Forwarded-Encrypted: i=1; AJvYcCUr/YXkDFe7QwgWrqFjkykWtsrturREBlmM0xLXkhoJXlh93ywo3GQZ0C95tKmkT+NCNKuaHRX1akeINIOx3JU=@vger.kernel.org, AJvYcCVcDMmlCkprWNzoLDnM1OHrsY+M9mMga2KAgZwRwk8zkmvYnLb/hBmedc37Kzca6VhgdFavHvfq@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZW3+KB4t6TJbu2MCRiwYkXyHt3pcrqz0sdHr4jt7d/mevJw9
	KDeetbkZQ692GDenwA0WOV/QxfxJgqvjGeWxrVfZmO2ZAcirDCRGVy46F2vj
X-Gm-Gg: ASbGnctREaN8rebKEi9ux/8UF9s0PnBXC3e5zlPrGu8yb3pIVUFfJXVseHP9BG4Mwh1
	8WEhznD9BnBZ3NcwExqGD6tV6HOjGc6Q95nm0jwyyHc1i0RI3ampNcfEls4+Lx2mvHRo5zC02mR
	MU5d3Bp9/CS2W/ZYaqN82zbh+QHeVKRSqjjyyIvI6DYWJ/3S4Qij7x1+Mm0OEnxBSC3kGjLjfNu
	8MyHjeyV3vHD59BfeVdvNMDZXR3gX+rVlJrnVPvhd/J3p5ywzdvtbfJiNn7GwpdlAMritrfdQbs
	erfUYhz8X9ijde5MemcnE3mYngUF3weLzqCt4Q8YQzm1Y1E=
X-Google-Smtp-Source: AGHT+IE7KI6OrHjZVszKf5uuDQy13QYH7ConCPPve/CxaiTLiaoDIoMyAZDafHop59v2SQ4fN/BVkg==
X-Received: by 2002:a05:620a:2844:b0:7b6:79c8:d036 with SMTP id af79cd13be357-7c047ba5549mr1004098285a.3.1739042811923;
        Sat, 08 Feb 2025 11:26:51 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:c58e:ed03:1b60:c56d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec31dsm334474385a.1.2025.02.08.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 11:26:50 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 08 Feb 2025 14:26:43 -0500
Subject: [PATCH v2] blackhole_dev: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250208-blackholedev-kunit-convert-v2-1-182db9bd56ec@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPKvp2cC/42NQQ7CIBBFr9LM2jGAaURX3sN0gXRoJ23BQCWah
 ruLPYH5q/cX722QKDIluDYbRMqcOPgK6tCAHY0fCLmvDEqoVihxxsds7DSGmXrKOL08r2iDzxR
 XvJhWGVknTgqq4BnJ8XuX37vKI6c1xM/eyvL3/qXNEiVqcqK30jmt5W1YDM9HGxboSilfqpTon
 sQAAAA=
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

Add a missing `htons` call that was spotted[0] by kernel test robot
<lkp@intel.com> after initial conversion to KUnit.

Link: https://lore.kernel.org/oe-kbuild-all/202502090223.qCYMBjWT-lkp@intel.com/ [0]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 --kconfig_add CONFIG_NET=y blackholedev
---
Changes in v2:
- Add missing `htons` call. (kernel test robot <lkp@intel.com>)
- Link to v1: https://lore.kernel.org/r/20250207-blackholedev-kunit-convert-v1-1-8ef0dc1ff881@gmail.com
---
 lib/Kconfig.debug                                  | 20 ++++-----
 lib/Makefile                                       |  2 +-
 ...{test_blackhole_dev.c => blackhole_dev_kunit.c} | 47 ++++++++--------------
 tools/testing/selftests/net/Makefile               |  2 +-
 tools/testing/selftests/net/test_blackhole_dev.sh  | 11 -----
 5 files changed, 29 insertions(+), 53 deletions(-)

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
similarity index 68%
rename from lib/test_blackhole_dev.c
rename to lib/blackhole_dev_kunit.c
index ec290ac2a0d9..06834ab35f43 100644
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
@@ -55,7 +52,7 @@ static int __init test_blackholedev_init(void)
 	ip6h = (struct ipv6hdr *)skb_push(skb, sizeof(struct ipv6hdr));
 	skb_set_network_header(skb, 0);
 	ip6h->hop_limit = 32;
-	ip6h->payload_len = data_len + sizeof(struct udphdr);
+	ip6h->payload_len = htons(data_len + sizeof(struct udphdr));
 	ip6h->nexthdr = IPPROTO_UDP;
 	ip6h->saddr = in6addr_loopback;
 	ip6h->daddr = in6addr_loopback;
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


