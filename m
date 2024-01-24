Return-Path: <linux-kselftest+bounces-3491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257F483B401
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 22:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F7AB219DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7413540B;
	Wed, 24 Jan 2024 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4Ky3/5Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068912BE96
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132078; cv=none; b=Hk/7AXcYCRbGOc4r8xROR4YHDiv6frFOj4D0g+lqgg9XIxoZ51GxYWDHw+xeWSPKYLBnBC0QrKqM/65J+1Li2W4ftmHDnF2Ma+X8bj+Oclehs2mBDrKBN3fnEEHctN0CFIIpAExM0Z3f0tec9ej4CysvIL5vu9cNhGOGq50VPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132078; c=relaxed/simple;
	bh=+OR3IZR4o43q8csEGATjnLrBgfyVT9+x6BBKc0fk0hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhTZqLkB1ap6eLVB8nyTj6nUaKnzFq42tWa/ibhlaj8NoyyEzolfokzOL/kRqb/6AOm76h7zwt29GKirPWgBKk8J2D4wjHN8A4Y9Kcn8AjcMOzT2/lTKw6/gd0l938zSsNFjJbnpbWxl/H9eSqSRRy/YfPXHKVDwYfiG2UKhonk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4Ky3/5Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706132076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPGo/gu1nZsLthRfSi75w8TPf3ID9glx/33tkwGf49Q=;
	b=K4Ky3/5Z9V4zP2cZxuiLSZpzL393JwaTAI0zkNC+9E9O9KMdRPJEj8yUPzAKZVud174Ak/
	XlI+g1LO1Liu0eBPcjI4JkqAiBt91sAsXpI1nCdMVHqY5EZ2K8mqDTy9t09u1Xt6T5x34r
	73p8eY9QfSlCulLTZVS4HM9+bcjxOWg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-PiTDAoC_OmKjsrZd9dpnCQ-1; Wed,
 24 Jan 2024 16:34:29 -0500
X-MC-Unique: PiTDAoC_OmKjsrZd9dpnCQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7A6F283780F;
	Wed, 24 Jan 2024 21:34:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 57AEB2166B32;
	Wed, 24 Jan 2024 21:34:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/3] selftests: net: remove dependency on ebpf tests
Date: Wed, 24 Jan 2024 22:33:20 +0100
Message-ID: <28e7af7c031557f691dc8045ee41dd549dd5e74c.1706131762.git.pabeni@redhat.com>
In-Reply-To: <cover.1706131762.git.pabeni@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Several net tests requires an XDP program build under the ebpf
directory, and error out if such program is not available.

That makes running successful net test hard, let's duplicate into the
net dir the [very small] program, re-using the existing rules to build
it, and finally dropping the bogus dependency.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/Makefile          |  5 +++--
 tools/testing/selftests/net/udpgro.sh         |  4 ++--
 tools/testing/selftests/net/udpgro_bench.sh   |  4 ++--
 tools/testing/selftests/net/udpgro_frglist.sh |  6 +++---
 tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
 tools/testing/selftests/net/veth.sh           |  4 ++--
 tools/testing/selftests/net/xdp_dummy.c       | 13 +++++++++++++
 7 files changed, 26 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/net/xdp_dummy.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 50818075e566..304d8b852ef0 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -84,6 +84,7 @@ TEST_PROGS += sctp_vrf.sh
 TEST_GEN_FILES += sctp_hello
 TEST_GEN_FILES += csum
 TEST_GEN_FILES += nat6to4.o
+TEST_GEN_FILES += xdp_dummy.o
 TEST_GEN_FILES += ip_local_port_range
 TEST_GEN_FILES += bind_wildcard
 TEST_PROGS += test_vxlan_mdb.sh
@@ -104,7 +105,7 @@ $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
 $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
 $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
 
-# Rules to generate bpf obj nat6to4.o
+# Rules to generate bpf objs
 CLANG ?= clang
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
@@ -139,7 +140,7 @@ endif
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 
-$(OUTPUT)/nat6to4.o: nat6to4.c $(BPFOBJ) | $(MAKE_DIRS)
+$(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o: $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
 	$(CLANG) -O2 --target=bpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) -o $@
 
 $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index af5dc57c8ce9..8802604148dd 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="../bpf/xdp_dummy.bpf.o"
+BPF_FILE="xdp_dummy.o"
 
 # set global exit status, but never reset nonzero one.
 check_err()
@@ -197,7 +197,7 @@ run_all() {
 }
 
 if [ ! -f ${BPF_FILE} ]; then
-	echo "Missing ${BPF_FILE}. Build bpf selftest first"
+	echo "Missing ${BPF_FILE}. Run 'make' first"
 	exit -1
 fi
 
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index cb664679b434..7080eae5312b 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="../bpf/xdp_dummy.bpf.o"
+BPF_FILE="xdp_dummy.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
@@ -84,7 +84,7 @@ run_all() {
 }
 
 if [ ! -f ${BPF_FILE} ]; then
-	echo "Missing ${BPF_FILE}. Build bpf selftest first"
+	echo "Missing ${BPF_FILE}. Run 'make' first"
 	exit -1
 fi
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index dd47fa96f6b3..e1ff645bd3d1 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -7,7 +7,7 @@ source net_helper.sh
 
 readonly PEER_NS="ns-peer-$(mktemp -u XXXXXX)"
 
-BPF_FILE="../bpf/xdp_dummy.bpf.o"
+BPF_FILE="xdp_dummy.o"
 
 cleanup() {
 	local -r jobs="$(jobs -p)"
@@ -85,12 +85,12 @@ run_all() {
 }
 
 if [ ! -f ${BPF_FILE} ]; then
-	echo "Missing ${BPF_FILE}. Build bpf selftest first"
+	echo "Missing ${BPF_FILE}. Run 'make' first"
 	exit -1
 fi
 
 if [ ! -f nat6to4.o ]; then
-	echo "Missing nat6to4 helper. Build bpf nat6to4.o selftest first"
+	echo "Missing nat6to4 helper. Run 'make' first"
 	exit -1
 fi
 
diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index c079565add39..5fa8659ab13d 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-BPF_FILE="../bpf/xdp_dummy.bpf.o"
+BPF_FILE="xdp_dummy.o"
 readonly BASE="ns-$(mktemp -u XXXXXX)"
 readonly SRC=2
 readonly DST=1
diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 2d073595c620..27574bbf2d63 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-BPF_FILE="../bpf/xdp_dummy.bpf.o"
+BPF_FILE="xdp_dummy.o"
 readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
 readonly BASE=`basename $STATS`
 readonly SRC=2
@@ -218,7 +218,7 @@ while getopts "hs:" option; do
 done
 
 if [ ! -f ${BPF_FILE} ]; then
-	echo "Missing ${BPF_FILE}. Build bpf selftest first"
+	echo "Missing ${BPF_FILE}. Run 'make' first"
 	exit 1
 fi
 
diff --git a/tools/testing/selftests/net/xdp_dummy.c b/tools/testing/selftests/net/xdp_dummy.c
new file mode 100644
index 000000000000..d988b2e0cee8
--- /dev/null
+++ b/tools/testing/selftests/net/xdp_dummy.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define KBUILD_MODNAME "xdp_dummy"
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("xdp")
+int xdp_dummy_prog(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


