Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86845784CAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjHVWHW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 18:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHVWHW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 18:07:22 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CEDF1B9;
        Tue, 22 Aug 2023 15:07:19 -0700 (PDT)
Received: from UbuntuVM-18.efytirfs5hsengjwslc1ligxab.xx.internal.cloudapp.net (unknown [20.72.208.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8811A2126CD6;
        Tue, 22 Aug 2023 15:07:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8811A2126CD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692742038;
        bh=ccvcmxKiUzDpgLMe6MY0JLVApyZVXWCFreGvGxxSy8k=;
        h=From:To:Cc:Subject:Date:From;
        b=qCLXJOqaVbypJI1xgc0o9bQjz5O56c9z6O2uibHeeA+p9OA4FCJ69VapxdCFTKGm9
         Uh0HR62602PgPemQQz/zxRmxXxeGackiUuCJyJEShXwDyXK5Hc1lvqqAH0dtdJb7GP
         88V5SlfLGiar6rv/3h/3yB0JHnXi1idcxOaKIYJ8=
From:   Hardik Garg <hargar@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bjorn@kernel.org
Subject: [PATCH 6.1] selftests/net: mv bpf/nat6to4.c to net folder
Date:   Tue, 22 Aug 2023 22:07:10 +0000
Message-Id: <20230822220710.3992-1-hargar@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

commit 3c107f36db06 ("selftests/net: mv bpf/nat6to4.c to net folder")
backport this v6.4 commit to v6.1 to fix this error:
error: unable to open output file 'linux/kselftest/net/bpf/nat6to4.o':
'No such file or directory'

There are some issues with the bpf/nat6to4.c building.

1. It use TEST_CUSTOM_PROGS, which will add the nat6to4.o to
   kselftest-list file and run by common run_tests.
2. When building the test via `make -C tools/testing/selftests/
   TARGETS="net"`, the nat6to4.o will be build in selftests/net/bpf/
   folder. But in test udpgro_frglist.sh it refers to ../bpf/nat6to4.o.
   The correct path should be ./bpf/nat6to4.o.
3. If building the test via `make -C tools/testing/selftests/ TARGETS="net"
   install`. The nat6to4.o will be installed to kselftest_install/net/
   folder. Then the udpgro_frglist.sh should refer to ./nat6to4.o.

To fix the confusing test path, let's just move the nat6to4.c to net folder
and build it as TEST_GEN_FILES.

Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-tests")
Tested-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://lore.kernel.org/r/20230118020927.3971864-1-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
---
 tools/testing/selftests/net/Makefile          | 50 ++++++++++++++++++-
 tools/testing/selftests/net/bpf/Makefile      | 14 ------
 .../testing/selftests/net/{bpf => }/nat6to4.c |  0
 tools/testing/selftests/net/udpgro_frglist.sh |  8 +--
 4 files changed, 52 insertions(+), 20 deletions(-)
 delete mode 100644 tools/testing/selftests/net/bpf/Makefile
 rename tools/testing/selftests/net/{bpf => }/nat6to4.c (100%)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 69c58362c0ed..48d1a68be1d5 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -71,14 +71,60 @@ TEST_GEN_FILES += bind_bhash
 TEST_GEN_PROGS += sk_bind_sendto_listen
 TEST_GEN_PROGS += sk_connect_zero_addr
 TEST_PROGS += test_ingress_egress_chaining.sh
+TEST_GEN_FILES += nat6to4.o
 
 TEST_FILES := settings
 
 include ../lib.mk
 
-include bpf/Makefile
-
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread
 $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
 $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
+
+# Rules to generate bpf obj nat6to4.o
+CLANG ?= clang
+SCRATCH_DIR := $(OUTPUT)/tools
+BUILD_DIR := $(SCRATCH_DIR)/build
+BPFDIR := $(abspath ../../../lib/bpf)
+APIDIR := $(abspath ../../../include/uapi)
+
+CCINCLUDE += -I../bpf
+CCINCLUDE += -I../../../../usr/include/
+CCINCLUDE += -I$(SCRATCH_DIR)/include
+
+BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
+
+MAKE_DIRS := $(BUILD_DIR)/libbpf
+$(MAKE_DIRS):
+	mkdir -p $@
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) $(2) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+ifneq ($(CROSS_COMPILE),)
+CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif
+
+CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
+
+$(OUTPUT)/nat6to4.o: nat6to4.c $(BPFOBJ) | $(MAKE_DIRS)
+	$(CLANG) -O2 -target bpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) -o $@
+
+$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)		       \
+	   $(APIDIR)/linux/bpf.h					       \
+	   | $(BUILD_DIR)/libbpf
+	$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/     \
+		    EXTRA_CFLAGS='-g -O0'				       \
+		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
+
+EXTRA_CLEAN := $(SCRATCH_DIR)
diff --git a/tools/testing/selftests/net/bpf/Makefile b/tools/testing/selftests/net/bpf/Makefile
deleted file mode 100644
index 8ccaf8732eb2..000000000000
--- a/tools/testing/selftests/net/bpf/Makefile
+++ /dev/null
@@ -1,14 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-CLANG ?= clang
-CCINCLUDE += -I../../bpf
-CCINCLUDE += -I../../../../lib
-CCINCLUDE += -I../../../../../usr/include/
-
-TEST_CUSTOM_PROGS = $(OUTPUT)/bpf/nat6to4.o
-all: $(TEST_CUSTOM_PROGS)
-
-$(OUTPUT)/%.o: %.c
-	$(CLANG) -O2 -target bpf -c $< $(CCINCLUDE) -o $@
-
-EXTRA_CLEAN := $(TEST_CUSTOM_PROGS)
diff --git a/tools/testing/selftests/net/bpf/nat6to4.c b/tools/testing/selftests/net/nat6to4.c
similarity index 100%
rename from tools/testing/selftests/net/bpf/nat6to4.c
rename to tools/testing/selftests/net/nat6to4.c
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index c9c4b9d65839..0a6359bed0b9 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -40,8 +40,8 @@ run_one() {
 
 	ip -n "${PEER_NS}" link set veth1 xdp object ${BPF_FILE} section xdp
 	tc -n "${PEER_NS}" qdisc add dev veth1 clsact
-	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol ipv6 bpf object-file ../bpf/nat6to4.o section schedcls/ingress6/nat_6  direct-action
-	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol ip bpf object-file ../bpf/nat6to4.o section schedcls/egress4/snat4 direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 ingress prio 4 protocol ipv6 bpf object-file nat6to4.o section schedcls/ingress6/nat_6  direct-action
+	tc -n "${PEER_NS}" filter add dev veth1 egress prio 4 protocol ip bpf object-file nat6to4.o section schedcls/egress4/snat4 direct-action
         echo ${rx_args}
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
@@ -88,8 +88,8 @@ if [ ! -f ${BPF_FILE} ]; then
 	exit -1
 fi
 
-if [ ! -f bpf/nat6to4.o ]; then
-	echo "Missing nat6to4 helper. Build bpfnat6to4.o selftest first"
+if [ ! -f nat6to4.o ]; then
+	echo "Missing nat6to4 helper. Build bpf nat6to4.o selftest first"
 	exit -1
 fi
 
-- 
2.33.8

