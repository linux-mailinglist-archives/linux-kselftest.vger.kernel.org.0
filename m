Return-Path: <linux-kselftest+bounces-41418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C33B55734
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 21:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1542F7C710D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E93935082D;
	Fri, 12 Sep 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMhclOse"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AE32ED41
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706852; cv=none; b=VC2+EZ2WvrtpsyhsZTi4RN/TXXrkgNzf0c125OYAcSH9tqoT3BXdvVpOhKK1/tBh1Su5PNbK1ZEP+GgEYB1+AAvcEpUEJYkAp+w2/h32nqDr9aU0n/UrymkYJON4L/4gqfm+vf7957qAMk9bKdAhJEVsNaNv+JWp8TNX3Ik6diA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706852; c=relaxed/simple;
	bh=UaxWZRT2eVzBCGKMziU2Aq9Id91zLIcnt32JB283AaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uV8oDLgiGY13rpWJdggbRNo4bNOdixXdCylxS5ZJVFDCPELzXbfun7xf87Xhw9cWLUxSzCcn4jNiZuecmSzj5TYav4Q9cC/UizexQLpyKCCvPxMVo9Nvg5QvvZN71stXFKfbOKwbBaFZ9RFb/dS1eT7xA3SJQciNxB0ylgkhEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMhclOse; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1819569f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 12:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706847; x=1758311647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crP5kybyDKEP1L3Fsm57wKH5BFdIt0syo+qIG2jEqhk=;
        b=mMhclOseYfvl0cVXhPsgKksq+KCwHXTcQEx/CbGjJcA842LJo3sh8SJ2HiBFPdyIb6
         FWH+LD7NLongLCEUYafG5+L06PRXcbjvlzmEu+IBfH0fy1JsF8lieMSGYccPhjJhbFrd
         o42ijR1lnTljOjxydmiyGRh6szSXeLYS+1lOGoxjakPfUF1xX2XzaPvAPmA47cGVrY3Q
         j13hO1dTfJWDjlTVCO0yZ1uXOTUS0+LvP7QJRY4SaqjB4ai7EB1AMtEYICwn8tRRVKjq
         0PMSByvAHCN0o7KU8xcnN94Zf2DJPorJVqSRvZRbvzSCiRJUVoERPoa90rFVAiaxfYTa
         geqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706847; x=1758311647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crP5kybyDKEP1L3Fsm57wKH5BFdIt0syo+qIG2jEqhk=;
        b=hLlG+qu4OYIa8kkqSS/fO77NBQfXmpU5SrOv+Bb3D1BNcwt58+qsiJukgnZxHDh/Ax
         S/OxX+otxTHBxuQNe5esxOcnmaxdfhZRMOHh8WALwaGIlqWv6d0TRHMHwZqB4m6DE2Xb
         eqPYfkFL3oAa06z2MvHrzoXDFPIHW3LkaJmSRPlp0bfLKFKfNyvHjxsoHkCYlz9Sz2gn
         /rSegSeyubmSg3dKtW+F5NHYwsg3KDOfY4Gv/SMgqlVS/HfArUetB6KODQjRk9nJPkCO
         2X3yhJH9TH7jqYB/zyrLocvtZpcmz9jUNRVFO7pnz/3JqkGetYFcxFEo9CH1HXmU9VKq
         0B2A==
X-Forwarded-Encrypted: i=1; AJvYcCXdy27B7SohuMIqRBgQsfHO0OvLXZNs4ks0DAFME2ZQ1BRlgL4i4RVNCtTToMfczoIU58GV2JK5dkMq9tBkEew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBUvInVumoyvgH1Te4Qos6ZYVV8gs+qz3UJqVPgXhb+MA/E5e
	D4NerWYN9OES0SLRcTYE5ixOfLG3TwRMlx4UfTf9zARohMXJquyNagdq
X-Gm-Gg: ASbGnctb+2mFzrerlfbFSYCY2+hhH3/IQevQkuea2cGFuDB3baXCSzfIKdVY9vNtePw
	lW3cZFMwn3CvDr1CWtDai3DEyQR1OHWN0H79SmRbV7g4oZsS+J52BKE/jwebA6vc1VtUPJGYhAI
	KSaUDL8wvWhBj6hvjWIYxv8gzDNFj6BcyQJKODT1JqoAJxJEl3OLzn26opJ73DAyAnz11j4ZuvF
	76uinr48IDzGXKHJ4xUhDD0bWzPjGestK/g+NEZ5STegWaH33rV3A6mA5Phim8ZIuAsTzzQQs4X
	HNeiOgZT4bvHrMF/ZnH5+wYSgbuLx+0Hske/om0Z+H3xqDD2TdJMtHsCIgaT43zZ1wDJxAXDjQd
	rG+1NowtCgzQgVlLXY3LNTlf5E6GEoZ8EBHKUJw2jxWl7HVEYRMXNgA56DaXbtT3vRt+q1Njci+
	7UC+eKuHc=
X-Google-Smtp-Source: AGHT+IHYbSxBKDnneqMGe4B4GqdstQRPwP2TMBkU5KGjwaP3qxT6Gii/ajCV1viHAEQt0HDASC1PLw==
X-Received: by 2002:a05:6000:40cb:b0:3da:d015:bf84 with SMTP id ffacd0b85a97d-3e7659cc7e2mr4361632f8f.25.1757706846599;
        Fri, 12 Sep 2025 12:54:06 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:06 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 10/15] selftests: net: genetlink: add packet capture test infrastructure
Date: Fri, 12 Sep 2025 22:53:33 +0300
Message-Id: <20250912195339.20635-11-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases for monitoring Netlink traffic during test execution

Require CONFIG_NLMON.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/Makefile    |   6 +
 tools/testing/selftests/net/genetlink.c | 234 ++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 tools/testing/selftests/net/genetlink.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 69c58362c0ed..0c325ccc5f03 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -71,6 +71,7 @@ TEST_GEN_FILES += bind_bhash
 TEST_GEN_PROGS += sk_bind_sendto_listen
 TEST_GEN_PROGS += sk_connect_zero_addr
 TEST_PROGS += test_ingress_egress_chaining.sh
+TEST_GEN_PROGS += genetlink
 
 TEST_FILES := settings
 
@@ -82,3 +83,8 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread
 $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
 $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
+
+$(OUTPUT)/genetlink: LDLIBS += -lnl-3 -lnl-genl-3
+$(OUTPUT)/genetlink: CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
+
+EXTRA_CLEAN := $(SCRATCH_DIR) $(OUTPUT)/genetlink.pcap
diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
new file mode 100644
index 000000000000..5be9ca68accd
--- /dev/null
+++ b/tools/testing/selftests/net/genetlink.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic Netlink and Netlink test cases
+ *
+ * This test suite validates various aspects of Generic Netlink and Netlink communication
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/genl/mngt.h>
+#include <linux/genetlink.h>
+
+#include "../kselftest_harness.h"
+
+#define MY_GENL_FAMILY_NAME "TEST_GENL"
+#define MY_GENL_CMD_UNSPEC 0
+#define MY_GENL_CMD_ECHO 1
+#define MY_GENL_CMD_SET_VALUE 2
+#define MY_GENL_CMD_GET_VALUE 3
+#define MY_GENL_CMD_EVENT 4
+#define MY_GENL_CMD_NO_ATTRS 5
+
+#define MY_GENL_SMALL_CMD_GET 0
+
+#define MY_GENL_ATTR_UNSPEC 0
+#define MY_GENL_ATTR_DATA 1
+#define MY_GENL_ATTR_VALUE 2
+#define MY_GENL_ATTR_PATH 3
+#define MY_GENL_ATTR_NESTED 4
+#define MY_GENL_ATTR_MAX 4
+
+#define THIRD_GENL_FAMILY_NAME "THIRD_GENL"
+
+#define THIRD_GENL_CMD_ECHO 1
+
+#define THIRD_GENL_ATTR_UNSPEC 0
+#define THIRD_GENL_ATTR_DATA 1
+#define THIRD_GENL_ATTR_FLAG 2
+#define THIRD_GENL_ATTR_MAX 2
+
+#define PATH_GENL_TEST_NUM "/sys/kernel/genl_test/value"
+#define PATH_GENL_TEST_MES "/sys/kernel/genl_test/message"
+#define PATH_GENL_TEST_DEV "/sys/kernel/genl_test/some_info"
+#define PATH_PARALLEL_GENL_MES "/sys/kernel/parallel_genl/message"
+#define PATH_THIRD_GENL_MES "/sys/kernel/third_genl/message"
+
+#define MY_MCGRP_NAME "MY_MCGRP_GENL"
+
+#define GENL_CTRL "nlctrl"
+#define CTRL_ATTR_POLICY_MAX (__CTRL_ATTR_POLICY_DUMP_MAX - 1)
+
+#define PARALLEL_GENL_FAMILY_NAME "PARALLEL_GENL"
+#define PARALLEL_GENL_ATTR_UNSPEC 0
+#define PARALLEL_GENL_CMD_SEND 1
+#define PARALLEL_GENL_CMD_DUMP_INFO 2
+#define PARALLEL_GENL_CMD_SET_VALUE 3
+#define PARALLEL_GENL_CMD_GET_VALUE 4
+
+#define PARALLEL_GENL_ATTR_DATA 1
+#define PARALLEL_GENL_ATTR_BINARY 2
+#define PARALLEL_GENL_ATTR_NAME 3
+#define PARALLEL_GENL_ATTR_DESC 4
+#define PARALLEL_GENL_ATTR_FLAG_NONBLOCK 9
+#define PARALLEL_GENL_ATTR_FLAG_BLOCK 10
+#define PARALLEL_GENL_ATTR_PATH 12
+#define PARALLEL_GENL_ATTR_MAX 12
+
+#define LARGE_GENL_FAMILY_NAME "LARGE_GENL"
+
+/*
+ * Test cases
+ */
+
+/**
+ * TEST(capture_start) - Starts Netlink traffic capture using nlmon interface
+ *
+ * Creates a virtual nlmon interface, enables it and starts packet capture
+ * with tcpdump. Captured packets are saved to 'genetlink.pcap' file.
+ *
+ * Note:
+ * - Requires root privileges
+ * - Creates temporary interface 'nlmon0'
+ * - Runs tcpdump in background
+ * - Adds small delay to ensure capture starts
+ */
+
+TEST(capture_start)
+{
+	printf("Running Test: starting Netlink traffic capture...\n");
+
+	// Only root can monitor Netlink traffic
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	char command[256];
+	int result;
+
+	snprintf(command, sizeof(command), "ip link add nlmon0 type nlmon");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	snprintf(command, sizeof(command), "ip link set nlmon0 up");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	snprintf(command, sizeof(command),
+		 "tcpdump -i nlmon0 -w genetlink.pcap &");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	printf("nlmon is up. Starting netlink process...\n");
+
+	sleep(2);
+
+	printf("Starting Netlink tests...\n");
+}
+
+/**
+ * TEST(capture_end) - Terminates Netlink traffic monitoring session
+ *
+ * Performs controlled shutdown of nlmon capture interface by:
+ * 1. Stopping tcpdump capture process
+ * 2. Bringing down nlmon interface
+ * 3. Deleting nlmon interface
+ *
+ * Test Procedure:
+ * 1. Privilege Check:
+ *    - Verifies root privileges (required for nlmon operations)
+ *    - Gracefully skips if not root
+ *
+ * 2. Capture Termination:
+ *    - Stops tcpdump process (2-second delay for cleanup)
+ *    - Brings nlmon0 interface down
+ *    - Deletes nlmon0 interface
+ *    - Validates each operation succeeds
+ *
+ * 3. Cleanup Verification:
+ *    - Checks system command exit statuses
+ *    - Provides detailed error reporting
+ *
+ * Key Validations:
+ * - Proper termination of monitoring session
+ * - Correct interface teardown
+ * - Root privilege enforcement
+ * - System command error handling
+ *
+ * Expected Behavior:
+ * - tcpdump process should terminate successfully
+ * - nlmon0 interface should deactivate cleanly
+ * - Interface should be removable
+ * - Non-root execution should skip gracefully
+ *
+ * Security Considerations:
+ * - Requires root for network interface control
+ * - Ensures complete capture session cleanup
+ * - Verifies proper resource release
+ *
+ * Note:
+ * - Should be paired with capture_start test
+ * - Includes 2-second delay for process stabilization
+ * - Provides status feedback through printf
+ */
+
+TEST(capture_end)
+{
+	printf("Running Test: stopping Netlink traffic capture...\n");
+
+	// Only root can monitor Netlink traffic
+	if (geteuid()) {
+		SKIP(return, "test requires root");
+		return;
+	}
+
+	char command[256];
+	int result;
+
+	sleep(2);
+
+	snprintf(command, sizeof(command), "pkill tcpdump");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	snprintf(command, sizeof(command), "ip link set nlmon0 down");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	snprintf(command, sizeof(command), "ip link delete nlmon0 type nlmon");
+	result = system(command);
+	ASSERT_EQ(WEXITSTATUS(result), 0);
+	if (result == -1) {
+		perror("system");
+		return;
+	}
+
+	printf("The capturing is over\n");
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


