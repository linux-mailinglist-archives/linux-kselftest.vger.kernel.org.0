Return-Path: <linux-kselftest+bounces-43308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7498BE2048
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 09:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17A03B0B97
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B49319870;
	Thu, 16 Oct 2025 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iNfMiG2A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF713195E1;
	Thu, 16 Oct 2025 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600790; cv=none; b=ZD1ebMxhImEdRGcrOhhPr2T/QjkiuO/CbGcWP84T7sPsWqy1xqYabS9UoEi9Wbs5Y6Seodkxmpd7DBA7KoNs/zEixQ13Aovx5fAaLWiWM6MLT+uCXE8b5LKoSq9beHpJC+e1Bl8CMIMV7/PvynTZKvEIbKFDg8hgsYV838wDqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600790; c=relaxed/simple;
	bh=h604/0gPdQgeIgxXDAkaljJ0Od0j2JsTghTy+N+3pX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHs8BonHDU/jpQ7YrelP7zYpAmo4zwElQ3bnvP1UMiE1vcZlxOEGxHflbW3yIg73xr63TQwEhyHlIT0swDBNsGajxkvlbzJwH3e3DOLg6jI2xEBZ1hiWGeMcFGBLB6zwpDM07TyT4Ra2RQ0dov6MGooIfmddC1Yb4myeQJxwLmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iNfMiG2A; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 23F0FC0358A;
	Thu, 16 Oct 2025 07:46:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 533E16062C;
	Thu, 16 Oct 2025 07:46:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28F07102F22AA;
	Thu, 16 Oct 2025 09:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760600785; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=h+bGwFdB2RinX88+7xXz9AJVRdq645xgVOTya+QXTIM=;
	b=iNfMiG2Ac4ClCjJoAdTBmoKFtOHoT3OP8r0RkqQSlsA5V6ydkNGXB4j8cBHDqdM+Otau8d
	8M+2c1Vw5BLpRQs7xs7MlA0Zvx74tIguVPrtr3ffbI93Pali3dVj/T5xBsFjx8dNxOJF2v
	1kYzy1M05CU6mWHHWWd2cwrLYZNhcmx87xjzgd5i1Ra8JHUrgs6m/rUdWNKLX4XP1ZM3AT
	IC9n+hjjLOnOTnWeEp8L4mI8UCMe7O62bV+YfzcrzSvQ6/8+O/dXqOqnodkKDheph1RMGS
	dXADsQPipypKxyvoM0T8rftK9o0YNjoMFAq2cmZTNXKLOfHQe04wV0TP4328IA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Thu, 16 Oct 2025 09:45:44 +0200
Subject: [PATCH bpf-next v5 15/15] selftests/bpf: test_xsk: Integrate
 test_xsk.c to test_progs framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-xsk-v5-15-662c95eb8005@bootlin.com>
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
In-Reply-To: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

test_xsk.c isn't part of the test_progs framework.

Integrate the tests defined by test_xsk.c into the test_progs framework
through a new file : prog_tests/xsk.c. ZeroCopy mode isn't tested in it
as veth peers don't support it.

Move test_xsk{.c/.h} to prog_tests/.

Add the find_bit library to test_progs sources in the Makefile as it is
is used by test_xsk.c

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/Makefile               |  13 +-
 .../selftests/bpf/{ => prog_tests}/test_xsk.c      |   0
 .../selftests/bpf/{ => prog_tests}/test_xsk.h      |   0
 tools/testing/selftests/bpf/prog_tests/xsk.c       | 146 +++++++++++++++++++++
 tools/testing/selftests/bpf/xskxceiver.c           |   2 +-
 5 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f7369ab5b1dc33585aa84268620885547c802ab0..160faa2f1cb42b76f83bfd34f9b3c43f3605792d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -543,6 +543,8 @@ TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
 				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
 TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
 				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
+TRUNNER_LIB_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
+				 $$(filter %.c,$(TRUNNER_LIB_SOURCES)))
 TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
 TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
 TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
@@ -686,6 +688,10 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
 
+$(TRUNNER_LIB_OBJS): $(TRUNNER_OUTPUT)/%.o:$(TOOLSDIR)/lib/%.c
+	$$(call msg,LIB-OBJ,$(TRUNNER_BINARY),$$@)
+	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
+
 # non-flavored in-srctree builds receive special treatment, in particular, we
 # do not need to copy extra resources (see e.g. test_btf_dump_case())
 $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
@@ -699,6 +705,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
+			     $(TRUNNER_LIB_OBJS)			\
 			     $(RESOLVE_BTFIDS)				\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
@@ -745,6 +752,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 $(VERIFY_SIG_HDR)		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
+TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
@@ -782,6 +790,7 @@ endif
 TRUNNER_TESTS_DIR := map_tests
 TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_maps.c
+TRUNNER_LIB_SOURCES :=
 TRUNNER_EXTRA_FILES :=
 TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 TRUNNER_BPF_CFLAGS :=
@@ -803,8 +812,8 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
 # Include find_bit.c to compile xskxceiver.
-EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c
-$(OUTPUT)/xskxceiver: $(EXTRA_SRC) test_xsk.c test_xsk.h xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
+EXTRA_SRC := $(TOOLSDIR)/lib/find_bit.c prog_tests/test_xsk.c prog_tests/test_xsk.h
+$(OUTPUT)/xskxceiver: $(EXTRA_SRC) xskxceiver.c xskxceiver.h $(OUTPUT)/network_helpers.o $(OUTPUT)/xsk.o $(OUTPUT)/xsk_xdp_progs.skel.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
similarity index 100%
rename from tools/testing/selftests/bpf/test_xsk.c
rename to tools/testing/selftests/bpf/prog_tests/test_xsk.c
diff --git a/tools/testing/selftests/bpf/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
similarity index 100%
rename from tools/testing/selftests/bpf/test_xsk.h
rename to tools/testing/selftests/bpf/prog_tests/test_xsk.h
diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
new file mode 100644
index 0000000000000000000000000000000000000000..7ce5ddd7d3fc848df27534f00a6a9f82fbc797c5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <net/if.h>
+#include <stdarg.h>
+
+#include "network_helpers.h"
+#include "test_progs.h"
+#include "test_xsk.h"
+#include "xsk_xdp_progs.skel.h"
+
+#define VETH_RX "veth0"
+#define VETH_TX "veth1"
+#define MTU	1500
+
+int setup_veth(bool busy_poll)
+{
+	SYS(fail,
+	"ip link add %s numtxqueues 4 numrxqueues 4 type veth peer name %s numtxqueues 4 numrxqueues 4",
+	VETH_RX, VETH_TX);
+	SYS(fail, "sysctl -wq net.ipv6.conf.%s.disable_ipv6=1", VETH_RX);
+	SYS(fail, "sysctl -wq net.ipv6.conf.%s.disable_ipv6=1", VETH_TX);
+
+	if (busy_poll) {
+		SYS(fail, "echo 2 > /sys/class/net/%s/napi_defer_hard_irqs", VETH_RX);
+		SYS(fail, "echo 200000 > /sys/class/net/%s/gro_flush_timeout", VETH_RX);
+		SYS(fail, "echo 2 > /sys/class/net/%s/napi_defer_hard_irqs", VETH_TX);
+		SYS(fail, "echo 200000 > /sys/class/net/%s/gro_flush_timeout", VETH_TX);
+	}
+
+	SYS(fail, "ip link set %s mtu %d", VETH_RX, MTU);
+	SYS(fail, "ip link set %s mtu %d", VETH_TX, MTU);
+	SYS(fail, "ip link set %s up", VETH_RX);
+	SYS(fail, "ip link set %s up", VETH_TX);
+
+	return 0;
+
+fail:
+	return -1;
+}
+
+void delete_veth(void)
+{
+	SYS_NOFAIL("ip link del %s", VETH_RX);
+	SYS_NOFAIL("ip link del %s", VETH_TX);
+}
+
+int configure_ifobj(struct ifobject *tx, struct ifobject *rx)
+{
+	rx->ifindex = if_nametoindex(VETH_RX);
+	if (!ASSERT_OK_FD(rx->ifindex, "get RX ifindex"))
+		return -1;
+
+	tx->ifindex = if_nametoindex(VETH_TX);
+	if (!ASSERT_OK_FD(tx->ifindex, "get TX ifindex"))
+		return -1;
+
+	tx->shared_umem = false;
+	rx->shared_umem = false;
+
+
+	return 0;
+}
+
+static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
+{
+	struct ifobject *ifobj_tx, *ifobj_rx;
+	struct test_spec test;
+	int ret;
+
+	ifobj_tx = ifobject_create();
+	if (!ASSERT_OK_PTR(ifobj_tx, "create ifobj_tx"))
+		return;
+
+	ifobj_rx = ifobject_create();
+	if (!ASSERT_OK_PTR(ifobj_rx, "create ifobj_rx"))
+		goto delete_tx;
+
+	if (!ASSERT_OK(setup_veth(false), "setup veth"))
+		goto delete_rx;
+
+	if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "conigure ifobj"))
+		goto delete_veth;
+
+	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
+	if (!ret) {
+		ifobj_tx->hw_ring_size_supp = true;
+		ifobj_tx->set_ring.default_tx = ifobj_tx->ring.tx_pending;
+		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
+	}
+
+	if (!ASSERT_OK(init_iface(ifobj_rx, worker_testapp_validate_rx), "init RX"))
+		goto delete_veth;
+	if (!ASSERT_OK(init_iface(ifobj_tx, worker_testapp_validate_tx), "init TX"))
+		goto delete_veth;
+
+	test_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
+
+	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	if (!ASSERT_OK_PTR(test.tx_pkt_stream_default, "TX pkt generation"))
+		goto delete_veth;
+	test.rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	if (!ASSERT_OK_PTR(test.rx_pkt_stream_default, "RX pkt generation"))
+		goto delete_veth;
+
+
+	test_init(&test, ifobj_tx, ifobj_rx, mode, test_to_run);
+	ret = test.test_func(&test);
+	if (ret != TEST_SKIP)
+		ASSERT_OK(ret, "Run test");
+	pkt_stream_restore_default(&test);
+
+	if (ifobj_tx->hw_ring_size_supp)
+		hw_ring_size_reset(ifobj_tx);
+
+	pkt_stream_delete(test.tx_pkt_stream_default);
+	pkt_stream_delete(test.rx_pkt_stream_default);
+	xsk_xdp_progs__destroy(ifobj_tx->xdp_progs);
+	xsk_xdp_progs__destroy(ifobj_rx->xdp_progs);
+
+delete_veth:
+	delete_veth();
+delete_rx:
+	ifobject_delete(ifobj_rx);
+delete_tx:
+	ifobject_delete(ifobj_tx);
+}
+
+void test_ns_xsk_skb(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			test_xsk(&tests[i], TEST_MODE_SKB);
+	}
+}
+
+void test_ns_xsk_drv(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			test_xsk(&tests[i], TEST_MODE_DRV);
+	}
+}
+
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 8707f4a0fac64e1ebb6a4241edf8e874a1eb67c3..a54904783c757d282e3b99194aaed5f74d510763 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -90,7 +90,7 @@
 #include <sys/mman.h>
 #include <sys/types.h>
 
-#include "test_xsk.h"
+#include "prog_tests/test_xsk.h"
 #include "xsk_xdp_progs.skel.h"
 #include "xsk.h"
 #include "xskxceiver.h"

-- 
2.51.0


