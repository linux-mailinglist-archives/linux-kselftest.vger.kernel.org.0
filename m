Return-Path: <linux-kselftest+bounces-44295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68495C1B50D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB6567121
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A907354AE2;
	Wed, 29 Oct 2025 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I9BzlVuV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1541354AC2;
	Wed, 29 Oct 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746005; cv=none; b=oTTEt/IGKMnIlokrlzVHvJJqgrTrl4wu170NDgRgZY2ScWbVgb92am9WUZ1Ih1KrEsujzkVz+9vGKaDbyqaUu47iruKzhKUC6OPvv+IJImm90kaevDXYePG7+mdfMUHZTCA2LMWSu4IMCHX3BEXBhs6s/bV5GaRduj6kjkFWnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746005; c=relaxed/simple;
	bh=aKHfmfSS+LgZ5jTbLsgfV6ReDnR/p8yx2GH2r8uyEDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dy+pZcXXUpWYsIgzdTvsoPo+0PRmUZ/Ih68GbuGT4YmKZV8sGr6vtMdy27dcM8tas0Ju8ICM5M6NGUFuPnTi09zLKMZFJ/WAqvmGpbfD0Wipvk5yQ0cwLzj5hka2aDPtazIKzAjGoPRgXl8i+xAvkXKBYEXTs6W1fc2ZVSxjQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I9BzlVuV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5A68E4E413BF;
	Wed, 29 Oct 2025 13:53:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F19C606E8;
	Wed, 29 Oct 2025 13:53:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B91E4117F80A4;
	Wed, 29 Oct 2025 14:53:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761746000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p46hFX01ylzlsNCZzl+O7XBxanARmaLcWBkwZPs2L18=;
	b=I9BzlVuV+Kt9cMGmLnhRcUo7NY7xCFqzbg3GyA8NUZqmcVgjORJN9qChHqAcCQlC+SICiz
	EGRpwrzc7Jf/mc3/lfpVVKBttufaT+zYXkwr132ZwsRlAuBLoQMHeu6Pkj5dZEBjer6y3/
	gutWdYS25mRSlETcEaEyqJPro/2coTHfu3wh3YUcMB2yGfnyArqu3e7rN8j5f1+21QK/G/
	0YTS6QgRwiHTrvA1BpFrRUhXPvZqv9PJP8GA/H6Q349N8f9c+3d2ZbBNsjQcI8LEFsl+7R
	PwGdRKUDhZqPn/vn/h9uIQn5kM5rhEixb65P8wRtLYzgMJqT5Qbk4fJiVry8vQ==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 29 Oct 2025 14:52:36 +0100
Subject: [PATCH bpf-next v6 15/15] selftests/bpf: test_xsk: Integrate
 test_xsk.c to test_progs framework
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-xsk-v6-15-5a63a64dff98@bootlin.com>
References: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
In-Reply-To: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
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
index 9fd9bf0780f023423b7ccf29b4fc5f16bef07f53..fa8bf4a18d3bb55d253de281cc8b0ab9073b983a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -545,6 +545,8 @@ TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
 				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
 TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
 				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
+TRUNNER_LIB_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
+				 $$(filter %.c,$(TRUNNER_LIB_SOURCES)))
 TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
 TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
 TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
@@ -688,6 +690,10 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
 
+$(TRUNNER_LIB_OBJS): $(TRUNNER_OUTPUT)/%.o:$(TOOLSDIR)/lib/%.c
+	$$(call msg,LIB-OBJ,$(TRUNNER_BINARY),$$@)
+	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
+
 # non-flavored in-srctree builds receive special treatment, in particular, we
 # do not need to copy extra resources (see e.g. test_btf_dump_case())
 $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
@@ -701,6 +707,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): | $(TRUNNER_BPF_OBJS)
 
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
+			     $(TRUNNER_LIB_OBJS)			\
 			     $(RESOLVE_BTFIDS)				\
 			     $(TRUNNER_BPFTOOL)				\
 			     $(OUTPUT)/veristat				\
@@ -747,6 +754,7 @@ TRUNNER_EXTRA_SOURCES := test_progs.c		\
 			 $(VERIFY_SIG_HDR)		\
 			 flow_dissector_load.h	\
 			 ip_check_defrag_frags.h
+TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
@@ -784,6 +792,7 @@ endif
 TRUNNER_TESTS_DIR := map_tests
 TRUNNER_BPF_PROGS_DIR := progs
 TRUNNER_EXTRA_SOURCES := test_maps.c
+TRUNNER_LIB_SOURCES :=
 TRUNNER_EXTRA_FILES :=
 TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 TRUNNER_BPF_CFLAGS :=
@@ -805,8 +814,8 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
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
index 0000000000000000000000000000000000000000..127ad61c923f675aaba44ed10e100bdc4c3de746
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
+void test_xsk_skb(void)
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
+void test_xsk_drv(void)
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


