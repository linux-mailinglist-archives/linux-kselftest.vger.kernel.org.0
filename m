Return-Path: <linux-kselftest+bounces-21269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 759EA9B87E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 01:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A45B2283A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 00:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C557D13BAD5;
	Fri,  1 Nov 2024 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nCCg3sz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C4130A73
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422174; cv=none; b=iUlcz2PfRh9xTRbwz8EWTNfjTi++SCYmOnJrpsARU7Au8uvP4O7wdlu0fHHv8FcLNK+cc5HgeQUvhuZZHoXPrXWLBfqf8L/Kq2sVpuQnB5nD55lfQJGYvcC+eWHqa6oXyHRyLqjuyPB38BOjSOeS+NwmX8MrUsauF/HxSKLBV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422174; c=relaxed/simple;
	bh=TFXbJW6wVeRX+arBDsjadpw5E4y4OvAphmOQrEKaPIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gl+fKQ/uoB4nIT7UiheQIxBLEiizZECz90Fe5rXUABBlYlXr2veD1eJoRCknK87LlW3EMMlqYHae23ATbXAVO9CPUI1yV99Uptnw3G0RECKH6vQLNXEL/bYdizIdDDQShJOaJD7jor8JebDCLh3jW1iRMoIGgResqeLUm/pHUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nCCg3sz5; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71811707775so826300a34.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730422165; x=1731026965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkoSEaVvEKME4ZqF6oQuraqIgV/sbYh4Q6GVty3dPs8=;
        b=nCCg3sz5XtQ1E3mqfbb+LCBMl1KeYtMH2zFXKz8JAtW7aeB7i5oa1DOzkczXhXleU4
         8IRZN/hOsTKhGoxZel3eSMDI2yTgDWPo74xsCwUVFTezkKTi9Ja39uzMzV4L0TuRaFA1
         Ad6QJNeP5xKG/cdzEiHCgeSauuTupDRuMa7ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422165; x=1731026965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkoSEaVvEKME4ZqF6oQuraqIgV/sbYh4Q6GVty3dPs8=;
        b=ffqmt4J0WNWNp6KFUo7XKe8uVdVHa7UtTZotdt9Laf5NuEKZtMiLlfOei/PA6eyRoF
         cvjtzcaGweFbty0saB8zBsEL8tc6T1V318abGE5kJxzmA6eWXp2kj4e7fGzsgAw3l8RU
         PVpMbiiIuA+TXBa3GcpgiaDbxIlnxnbpteAw+TMi0tqZzetKs2wg1OEf+P4FZ2kV4kzx
         yMNrzHoqHpgDpqPm6IxNDR8+DZy/EPLlMm+4V4bLbbAcygr/xndGWcKT9rv8qb8Bjgis
         Rzpdqn9Ji64xFIKV7sTpBxR5Vk/WBlDW91ZyZr+STLyc2u3OjCw8gu2EGgH0ArodIWn2
         A39A==
X-Forwarded-Encrypted: i=1; AJvYcCUisH9Zi5KeZzGpzO2V9m0/Zl7glt/1/bfnSN3SW0otbxoEuQxTBwSjfHfDTOVeWeqnI3PdJEiFG1TZ7rWKtJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgcrirtFC9o+NTbWFgRcCUrhX50AysdfUzmKMXm+uPH0JoGTU
	hPOB8af5aGcyiXF0MyvTSqeVTDCULRzYbeKkpHgi3zpeiFvtb+5D5UOarrdKX/U=
X-Google-Smtp-Source: AGHT+IEDVwLwzF5d/8qYC9UrmWwdMTMdr3jym2akk77xaWJwrb7upupKTbx/Un21wVI9DTh6SWf04g==
X-Received: by 2002:a05:6830:3152:b0:718:99a0:2168 with SMTP id 46e09a7af769-719ca174bd6mr2051826a34.4.1730422164808;
        Thu, 31 Oct 2024 17:49:24 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12c27sm1585365a12.93.2024.10.31.17.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:24 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH net-next v3 6/7] selftests: net: Add busy_poll_test
Date: Fri,  1 Nov 2024 00:48:33 +0000
Message-Id: <20241101004846.32532-7-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101004846.32532-1-jdamato@fastly.com>
References: <20241101004846.32532-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an epoll busy poll test using netdevsim.

This test is comprised of:
  - busy_poller (via busy_poller.c)
  - busy_poll_test.sh which loads netdevsim, sets up network namespaces,
    and runs busy_poller to receive data and netcat to send data.

The selftest tests two different scenarios:
  - busy poll (the pre-existing version in the kernel)
  - busy poll with suspend enabled (what this series adds)

The data transmit is a 1MiB temporary file generated from /dev/urandom
and the test is considered passing if the md5sum of the input file to
netcat matches the md5sum of the output file from busy_poller.

netdevsim was chosen instead of veth due to netdevsim's support for
netdev-genl.

For now, this test uses the functionality that netdevim provides. In the
future, perhaps netdevsim can be extended to emulate device IRQs to more
thoroughly test all pre-existing kernel options (like defer_hard_irqs)
and suspend.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 v3:
   - New in v3

 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   2 +
 tools/testing/selftests/net/busy_poll_test.sh | 164 ++++++++++++
 tools/testing/selftests/net/busy_poller.c     | 245 ++++++++++++++++++
 4 files changed, 412 insertions(+)
 create mode 100755 tools/testing/selftests/net/busy_poll_test.sh
 create mode 100644 tools/testing/selftests/net/busy_poller.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 217d8b7a7365..85b0c4a2179f 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -2,6 +2,7 @@
 bind_bhash
 bind_timewait
 bind_wildcard
+busy_poller
 cmsg_sender
 diag_uid
 epoll_busy_poll
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 26a4883a65c9..4b5f3d7d900b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -69,6 +69,7 @@ TEST_GEN_FILES += hwtstamp_config rxtimestamp timestamping txtimestamp
 TEST_GEN_FILES += ipsec
 TEST_GEN_FILES += ioam6_parser
 TEST_GEN_FILES += gro
+TEST_GEN_FILES += busy_poller
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
 TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls tun tap epoll_busy_poll
 TEST_GEN_FILES += toeplitz
@@ -96,6 +97,7 @@ TEST_PROGS += fdb_flush.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
 TEST_PROGS += bpf_offload.py
+TEST_PROGS += busy_poll_test.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := ncdevmem
diff --git a/tools/testing/selftests/net/busy_poll_test.sh b/tools/testing/selftests/net/busy_poll_test.sh
new file mode 100755
index 000000000000..bf33737691a4
--- /dev/null
+++ b/tools/testing/selftests/net/busy_poll_test.sh
@@ -0,0 +1,164 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+source net_helper.sh
+
+NSIM_DEV_1_ID=$((256 + RANDOM % 256))
+NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
+NSIM_DEV_2_ID=$((512 + RANDOM % 256))
+NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_2_ID
+
+NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
+NSIM_DEV_SYS_DEL=/sys/bus/netdevsim/del_device
+NSIM_DEV_SYS_LINK=/sys/bus/netdevsim/link_device
+NSIM_DEV_SYS_UNLINK=/sys/bus/netdevsim/unlink_device
+
+YNL_PATH=$(realpath $(dirname ${0}))/../../../net/ynl/cli.py
+SPEC_PATH=$(realpath $(dirname ${0}))/../../../../Documentation/netlink/specs/netdev.yaml
+
+check_ynl()
+{
+	if [ ! -f ${YNL_PATH} ]; then
+		echo "YNL path invalid: ${YNL_PATH}"
+		exit 1
+	fi
+
+	if [ ! -f ${SPEC_PATH} ]; then
+		echo "spec path invalid: ${SPEC_PATH}"
+		exit 1
+	fi
+}
+
+setup_ns()
+{
+	set -e
+	ip netns add nssv
+	ip netns add nscl
+
+	NSIM_DEV_1_NAME=$(find $NSIM_DEV_1_SYS/net -maxdepth 1 -type d ! \
+		-path $NSIM_DEV_1_SYS/net -exec basename {} \;)
+	NSIM_DEV_2_NAME=$(find $NSIM_DEV_2_SYS/net -maxdepth 1 -type d ! \
+		-path $NSIM_DEV_2_SYS/net -exec basename {} \;)
+
+	# ensure the server has 1 queue
+	ethtool -L $NSIM_DEV_1_NAME combined 1 2>/dev/null
+
+	ip link set $NSIM_DEV_1_NAME netns nssv
+	ip link set $NSIM_DEV_2_NAME netns nscl
+
+	ip netns exec nssv ip addr add '192.168.1.1/24' dev $NSIM_DEV_1_NAME
+	ip netns exec nscl ip addr add '192.168.1.2/24' dev $NSIM_DEV_2_NAME
+
+	ip netns exec nssv ip link set dev $NSIM_DEV_1_NAME up
+	ip netns exec nscl ip link set dev $NSIM_DEV_2_NAME up
+
+	set +e
+}
+
+cleanup_ns()
+{
+	ip netns del nscl
+	ip netns del nssv
+}
+
+test_busypoll()
+{
+	tmp_file=$(mktemp)
+	out_file=$(mktemp)
+
+	# fill a test file with random data
+	dd if=/dev/urandom of=${tmp_file} bs=1M count=1 2> /dev/null
+
+	timeout -k 60s 60s ip netns exec nssv ./busy_poller -p48675 -b192.168.1.1 -m8 -u0 -P1 -g16 -o${out_file}&
+
+	wait_local_port_listen nssv 48675 tcp
+
+	ip netns exec nscl nc -N 192.168.1.1 48675 < $tmp_file
+
+	wait
+
+	tmp_file_md5sum=$(md5sum $tmp_file | cut -f1 -d' ')
+	out_file_md5sum=$(md5sum $out_file | cut -f1 -d' ')
+
+	if [ "$tmp_file_md5sum" = "$out_file_md5sum" ]; then
+		res=0
+	else
+		echo "md5sum mismatch"
+		echo "input file md5sum: ${tmp_file_md5sum}";
+		echo "output file md5sum: ${out_file_md5sum}";
+		res=1
+	fi
+
+	rm $out_file $tmp_file
+
+	return $res
+}
+
+test_busypoll_with_suspend()
+{
+	# set the suspend parameter for the server via its IFIDX
+
+	DUMP_CMD="${YNL_PATH} --spec ${SPEC_PATH} --dump napi-get --json=\"{\\\"ifindex\\\": ${NSIM_DEV_1_IFIDX}}\" --output-json"
+	NSIM_DEV_1_NAPIID=$(ip netns exec nssv bash -c "$DUMP_CMD")
+	NSIM_DEV_1_NAPIID=$(echo $NSIM_DEV_1_NAPIID | jq '.[] | .id')
+
+	SUSPEND_CMD="${YNL_PATH} --spec ${SPEC_PATH} --do napi-set --json=\"{\\\"id\\\": ${NSIM_DEV_1_NAPIID}, \\\"irq-suspend-timeout\\\": 20000000, \\\"gro-flush-timeout\\\": 50000, \\\"defer-hard-irqs\\\": 100}\""
+	NSIM_DEV_1_SETCONFIG=$(ip netns exec nssv bash -c "$SUSPEND_CMD")
+
+	test_busypoll
+	return $?
+}
+
+###
+### Code start
+###
+
+check_ynl
+
+modprobe netdevsim
+
+# linking
+
+echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
+echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
+udevadm settle
+
+setup_ns
+
+NSIM_DEV_1_FD=$((256 + RANDOM % 256))
+exec {NSIM_DEV_1_FD}</var/run/netns/nssv
+NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
+
+NSIM_DEV_2_FD=$((256 + RANDOM % 256))
+exec {NSIM_DEV_2_FD}</var/run/netns/nscl
+NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
+if [ $? -ne 0 ]; then
+	echo "linking netdevsim1 with netdevsim2 should succeed"
+	cleanup_ns
+	exit 1
+fi
+
+test_busypoll
+if [ $? -ne 0 ]; then
+	echo "test_busypoll failed"
+	cleanup_ns
+	exit 1
+fi
+
+test_busypoll_with_suspend
+if [ $? -ne 0 ]; then
+	echo "test_busypoll_with_suspend failed"
+	cleanup_ns
+	exit 1
+fi
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_UNLINK
+
+echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_DEL
+
+cleanup_ns
+
+modprobe -r netdevsim
+
+exit 0
diff --git a/tools/testing/selftests/net/busy_poller.c b/tools/testing/selftests/net/busy_poller.c
new file mode 100644
index 000000000000..b49d67ce0ca8
--- /dev/null
+++ b/tools/testing/selftests/net/busy_poller.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
+#include <errno.h>
+#include <error.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <arpa/inet.h>
+#include <netinet/in.h>
+
+#include <sys/ioctl.h>
+#include <sys/epoll.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+
+/* if the headers haven't been updated, we need to define some things */
+#if !defined(EPOLL_IOC_TYPE)
+struct epoll_params {
+	uint32_t busy_poll_usecs;
+	uint16_t busy_poll_budget;
+	uint8_t prefer_busy_poll;
+
+	/* pad the struct to a multiple of 64bits */
+	uint8_t __pad;
+};
+
+#define EPOLL_IOC_TYPE 0x8A
+#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
+#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
+#endif
+
+static uint32_t cfg_port = 8000;
+static struct in_addr cfg_bind_addr = { .s_addr = INADDR_ANY };
+static char *cfg_outfile;
+static int cfg_max_events = 8;
+
+/* busy poll params */
+static uint32_t cfg_busy_poll_usecs;
+static uint16_t cfg_busy_poll_budget;
+static uint8_t cfg_prefer_busy_poll;
+
+static void usage(const char *filepath)
+{
+	error(1, 0,
+	      "Usage: %s -p<port> -b<addr> -m<max_events> -u<busy_poll_usecs> -P<prefer_busy_poll> -g<busy_poll_budget> -o<outfile>",
+	      filepath);
+}
+
+static void parse_opts(int argc, char **argv)
+{
+	int ret;
+	int c;
+
+	if (argc <= 1)
+		usage(argv[0]);
+
+	while ((c = getopt(argc, argv, "p:m:b:u:P:g:o:")) != -1) {
+		switch (c) {
+		case 'u':
+			cfg_busy_poll_usecs = strtoul(optarg, NULL, 0);
+			if (cfg_busy_poll_usecs == ULONG_MAX ||
+			    cfg_busy_poll_usecs > UINT32_MAX)
+				error(1, ERANGE, "busy_poll_usecs too large");
+			break;
+		case 'P':
+			cfg_prefer_busy_poll = strtoul(optarg, NULL, 0);
+			if (cfg_prefer_busy_poll == ULONG_MAX ||
+			    cfg_prefer_busy_poll > 1)
+				error(1, ERANGE,
+				      "prefer busy poll should be 0 or 1");
+			break;
+		case 'g':
+			cfg_busy_poll_budget = strtoul(optarg, NULL, 0);
+			if (cfg_busy_poll_budget == ULONG_MAX ||
+			    cfg_busy_poll_budget > UINT16_MAX)
+				error(1, ERANGE,
+				      "busy poll budget must be [0, UINT16_MAX]");
+			break;
+		case 'p':
+			cfg_port = strtoul(optarg, NULL, 0);
+			if (cfg_port > UINT16_MAX)
+				error(1, ERANGE, "port must be <= 65535");
+			break;
+		case 'b':
+			ret = inet_aton(optarg, &cfg_bind_addr);
+			if (ret == 0)
+				error(1, errno,
+				      "bind address %s invalid", optarg);
+			break;
+		case 'o':
+			cfg_outfile = strdup(optarg);
+			if (!cfg_outfile)
+				error(1, 0, "outfile invalid");
+			break;
+		case 'm':
+			cfg_max_events = strtol(optarg, NULL, 0);
+
+			if (cfg_max_events == LONG_MIN ||
+			    cfg_max_events == LONG_MAX ||
+			    cfg_max_events <= 0)
+				error(1, ERANGE,
+				      "max events must be > 0 and < LONG_MAX");
+			break;
+		}
+	}
+
+	if (optind != argc)
+		usage(argv[0]);
+}
+
+static void epoll_ctl_add(int epfd, int fd, uint32_t events)
+{
+	struct epoll_event ev;
+
+	ev.events = events;
+	ev.data.fd = fd;
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev) == -1)
+		error(1, errno, "epoll_ctl add fd: %d", fd);
+}
+
+static void setnonblock(int sockfd)
+{
+	int flags;
+
+	flags = fcntl(sockfd, F_GETFL, 0);
+
+	if (fcntl(sockfd, F_SETFL, flags | O_NONBLOCK) == -1)
+		error(1, errno, "unable to set socket to nonblocking mode");
+}
+
+static void write_chunk(int fd, char *buf, ssize_t buflen)
+{
+	ssize_t remaining = buflen;
+	char *buf_offset = buf;
+	ssize_t writelen = 0;
+	ssize_t write_result;
+
+	while (writelen < buflen) {
+		write_result = write(fd, buf_offset, remaining);
+		if (write_result == -1)
+			error(1, errno, "unable to write data to outfile");
+
+		writelen += write_result;
+		remaining -= write_result;
+		buf_offset += write_result;
+	}
+}
+
+static void run_poller(void)
+{
+	struct epoll_event events[cfg_max_events];
+	struct epoll_params epoll_params = {0};
+	struct sockaddr_in server_addr;
+	int i, epfd, nfds;
+	ssize_t readlen;
+	int outfile_fd;
+	char buf[1024];
+	int sockfd;
+	int conn;
+	int val;
+
+	outfile_fd = open(cfg_outfile, O_WRONLY | O_CREAT, 0644);
+	if (outfile_fd == -1)
+		error(1, errno, "unable to open outfile: %s", cfg_outfile);
+
+	sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (sockfd == -1)
+		error(1, errno, "unable to create listen socket");
+
+	server_addr.sin_family = AF_INET;
+	server_addr.sin_port = htons(cfg_port);
+	server_addr.sin_addr = cfg_bind_addr;
+
+	epoll_params.busy_poll_usecs = cfg_busy_poll_usecs;
+	epoll_params.busy_poll_budget = cfg_busy_poll_budget;
+	epoll_params.prefer_busy_poll = cfg_prefer_busy_poll;
+	epoll_params.__pad = 0;
+
+	val = 1;
+	if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val)))
+		error(1, errno, "poller setsockopt reuseaddr");
+
+	setnonblock(sockfd);
+
+	if (bind(sockfd, (struct sockaddr *)&server_addr,
+		 sizeof(struct sockaddr_in)))
+		error(0, errno, "poller bind to port: %d\n", cfg_port);
+
+	if (listen(sockfd, 1))
+		error(1, errno, "poller listen");
+
+	epfd = epoll_create1(0);
+	if (ioctl(epfd, EPIOCSPARAMS, &epoll_params) == -1)
+		error(1, errno, "unable to set busy poll params");
+
+	epoll_ctl_add(epfd, sockfd, EPOLLIN | EPOLLOUT | EPOLLET);
+
+	for (;;) {
+		nfds = epoll_wait(epfd, events, cfg_max_events, -1);
+		for (i = 0; i < nfds; i++) {
+			if (events[i].data.fd == sockfd) {
+				conn = accept(sockfd, NULL, NULL);
+				if (conn == -1)
+					error(1, errno,
+					      "accepting incoming connection failed");
+
+				setnonblock(conn);
+				epoll_ctl_add(epfd, conn,
+					      EPOLLIN | EPOLLET | EPOLLRDHUP |
+					      EPOLLHUP);
+			} else if (events[i].events & EPOLLIN) {
+				for (;;) {
+					readlen = read(events[i].data.fd, buf,
+						       sizeof(buf));
+					if (readlen > 0)
+						write_chunk(outfile_fd, buf,
+							    readlen);
+					else
+						break;
+				}
+			} else {
+				/* spurious event ? */
+			}
+			if (events[i].events & (EPOLLRDHUP | EPOLLHUP)) {
+				epoll_ctl(epfd, EPOLL_CTL_DEL,
+					  events[i].data.fd, NULL);
+				close(events[i].data.fd);
+				close(outfile_fd);
+				return;
+			}
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	parse_opts(argc, argv);
+	run_poller();
+	return 0;
+}
-- 
2.25.1


