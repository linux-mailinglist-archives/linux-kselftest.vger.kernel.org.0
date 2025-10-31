Return-Path: <linux-kselftest+bounces-44508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87179C23BE4
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B8504F6DB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5D533F8A5;
	Fri, 31 Oct 2025 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oTX+zpVq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4F329382
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897935; cv=none; b=M/oSQmvYkg5BFWcIko2fYjmP+FAmfO+olSIal6nw4XaZVmt8A5bQXnPcbhAqF+Vuh0WrWm+2feB2FFaFEnyD0Ue+DY/CvDksBJLzpqE8PRP+HYAix46e2/fhyRuHMPpah+6Z1yYBXzJuYWP8GpcCOZCNu1e2sD7bEg/cJwCikVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897935; c=relaxed/simple;
	bh=7gmfHG2LMcsz64kwZgWjeJgDLBz91qHWvwk35kKLFj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7vNzlF7/hpUHqoZYvYfz2Hl+GFWqOGtKoMJTxaWxnj1t44y1ycztCDitqGkUX+6Hp5epy+jN5KYu40DfwoHn4SV/M5U84hij9hBX9vZ+YVMMheprnnq4P8Al2fHAC7+lzoWiT/jl5bWWrVzg9dJbjbTNCrwujw0qAwxm9PbESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oTX+zpVq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2C4544E41431;
	Fri, 31 Oct 2025 08:05:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0204D60704;
	Fri, 31 Oct 2025 08:05:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D0601180FB70;
	Fri, 31 Oct 2025 09:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761897929; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zLibuzXxWa/gHDzup86Us+9qKqNyVvpcBmw6tvGfxLg=;
	b=oTX+zpVqU46ecu2LhPagNjvvrnJSO6h49xZQPgGg6D9D1mi08E+P810iIOvWGC382Yq24l
	8K4Va0dmTEpPf2ZIuI6yDyazhHYQ2Wf+aU4wlilVMt80v58ZkVRi1d6XcDb/Kise/ek2Pi
	TMLnieGrY07TNamAGrs4c3b1MjMlUyFuK+o8cA2CX4UA/IMv2Dz0qV/0qwBFc/wupxH+Pv
	k1ShI8RmCClSW1WIGYwvsCvZAUbzBwQmJRRSkD6yRItW+81qHRg/qSJ2h6rrHLOh6bTgqb
	tyj61qhzg9HsNlyAxDFN4WQ580J8vDmU1gRB3P4TCAG5gWluiNx4v7mhvzD6uA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 09:04:51 +0100
Subject: [PATCH bpf-next v7 15/15] selftests/bpf: test_xsk: Integrate
 test_xsk.c to test_progs framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-xsk-v7-15-39fe486593a3@bootlin.com>
References: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
In-Reply-To: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
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
 tools/testing/selftests/bpf/prog_tests/xsk.c       | 151 +++++++++++++++++++++
 tools/testing/selftests/bpf/xskxceiver.c           |   2 +-
 5 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 73681e63c3e13960a022dc4c817694e56d3646c6..93dbafa050c97377fc11278f131668c8726153b0 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -544,6 +544,8 @@ TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
 				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
 TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
 				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
+TRUNNER_LIB_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
+				 $$(filter %.c,$(TRUNNER_LIB_SOURCES)))
 TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
 TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
 TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
@@ -687,6 +689,10 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
 
+$(TRUNNER_LIB_OBJS): $(TRUNNER_OUTPUT)/%.o:$(TOOLSDIR)/lib/%.c
+	$$(call msg,LIB-OBJ,$(TRUNNER_BINARY),$$@)
+	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
+
 # non-flavored in-srctree builds receive special treatment, in particular, we
 # do not need to copy extra resources (see e.g. test_btf_dump_case())
 $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
@@ -700,6 +706,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
+			     $(TRUNNER_LIB_OBJS)			\
 			     $(RESOLVE_BTFIDS)				\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
@@ -746,6 +753,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 $(VERIFY_SIG_HDR)		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
+TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
@@ -783,6 +791,7 @@ endif
 TRUNNER_TESTS_DIR := map_tests
 TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_maps.c
+TRUNNER_LIB_SOURCES :=
 TRUNNER_EXTRA_FILES :=
 TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 TRUNNER_BPF_CFLAGS :=
@@ -804,8 +813,8 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
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
index 0000000000000000000000000000000000000000..dd4c35c0e428b4ff77c06f1c5889aed92f34984c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
@@ -0,0 +1,151 @@
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
+	if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "conigure ifobj"))
+		goto delete_rx;
+
+	ret = get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
+	if (!ret) {
+		ifobj_tx->hw_ring_size_supp = true;
+		ifobj_tx->set_ring.default_tx = ifobj_tx->ring.tx_pending;
+		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
+	}
+
+	if (!ASSERT_OK(init_iface(ifobj_rx, worker_testapp_validate_rx), "init RX"))
+		goto delete_rx;
+	if (!ASSERT_OK(init_iface(ifobj_tx, worker_testapp_validate_tx), "init TX"))
+		goto delete_rx;
+
+	test_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
+
+	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	if (!ASSERT_OK_PTR(test.tx_pkt_stream_default, "TX pkt generation"))
+		goto delete_rx;
+	test.rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
+	if (!ASSERT_OK_PTR(test.rx_pkt_stream_default, "RX pkt generation"))
+		goto delete_rx;
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
+	if (!ASSERT_OK(setup_veth(false), "setup veth"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			test_xsk(&tests[i], TEST_MODE_SKB);
+	}
+
+	delete_veth();
+}
+
+void test_ns_xsk_drv(void)
+{
+	int i;
+
+	if (!ASSERT_OK(setup_veth(false), "setup veth"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			test_xsk(&tests[i], TEST_MODE_DRV);
+	}
+
+	delete_veth();
+}
+
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 57fa4b3f0decf76b022c79b543b1a906f0c89076..9234a58b0a972dffc2f4a4909334cd67ad0d4a25 100644
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


