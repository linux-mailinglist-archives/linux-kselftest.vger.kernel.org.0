Return-Path: <linux-kselftest+bounces-26686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017CA3672A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 21:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4051893C68
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEB81D95A3;
	Fri, 14 Feb 2025 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXpbrZh8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096E1AA1E0;
	Fri, 14 Feb 2025 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566747; cv=none; b=JC+qVKhTyKp8B0A1BZ7OSwwHJ0XXeYDISBv0nvqPdh3XZrT7g9ct34E81NhJY3OpIt68uki6ABU2lG4FSItANcz5fqA7EsXkYEbmrpYhILdQsY7W8LOKlwkqOyOTpwi9zpc8XgIVXB9oKfa7h07mEotlKmpZgPhqxH++brNf0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566747; c=relaxed/simple;
	bh=mFlGyEVpPTlXv6cGryde7xEh5ORjIleuWyrYtfDjFlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KsHsN14mV3Sd0Vif6pcxwzdmtQ0lIJN18LyPj8MTzbfjMvySU+auHurodn4PjCq16GFterhmBoHYwbkyZLIRYGZl8wgm2JVwRvwUMwKVyvPHBLIBKxRSrebllSBqdwVqXkQNC0BHdAMAalBmR6KWeRJxsl7tRdgb5TpID9YdYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXpbrZh8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f2f748128so466107f8f.1;
        Fri, 14 Feb 2025 12:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739566743; x=1740171543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXeQ5MGj+nMjyi2bW+O+ck5e5Rx8K8X7YXDWKqRftac=;
        b=GXpbrZh82xHRdHqRLU3HBVRyZP3BHcWg6fBKoGTVD8LmquqZbiBJiLyQiMnp1UMG/4
         eJSaoCCsd74FI3gZgSvYU4468MItGc2AkteBAr1cwybYeR8cqqv7/i55cTa+TKEshqRI
         a3juYc4JLLfQ94m3wH9S2UwYapycdDrJkGJMueio2086L8YtfVOMrbATn4LhLSeArVuc
         HJLiZyICILpCQ8KWw84HJf73bIWR5NW70SDi0Umpcp0mUwMlAdbbAWjwOUrL6LF+XHHw
         Ce/kri1/Asbrdm0C9GhBpi7HOqfd9KDvAnZIj9/eM03LysH33saSp7VW1/ZoDkB0cuUg
         DPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739566743; x=1740171543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXeQ5MGj+nMjyi2bW+O+ck5e5Rx8K8X7YXDWKqRftac=;
        b=mOSUCQpopnPp+QYhZPEOj2onH39F9KKUOvJSQHH0rxuPTVq3tn5LS7C63jwPKxj6SO
         UQUwB01r881ZaGbLBCWbE1ogK4hA9M6X/Rsn5Si/87QcQlfw1IsGE6p4FbfgLhOb/It5
         jpA8AzZKD6j0QXliqoc3tlNGhGnO7Mu+irCNNo9OQIX1Aq/LY3QVPD47jUYdISA9kGk8
         Ha1MPHBJK5OHfz65CnlCZow3aB1wHLBSdRsxZH4jVgGGJ2UJOP3Yyhhx6Z5U2ahWxQHU
         iFEM/mEhEWdNlBtVzLlOOWN4glODixVw6pYQeC2T+4l5W05Hj8Z0RG7LjDUAbBT+1OPx
         G/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvdfKMx3tmHnLD1746/CJtHzI42dgpE3iTUYz3PlOg0vgHA/sFaplQlC+QP5IgSWtPucHYtf7qXYbRZkmHCxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXh0bd4cDwew+1TznJr9nG15wwrvq+F5bKFBKOK/ojwrlzzND+
	MpMORhPvWmrmy0TFyTnSPbEUpJPK5cQTCJusjoUAbynjabO4XXskfV3vfjVg
X-Gm-Gg: ASbGncvWyEOS0xeqNSP6YfWhRqG6QHHXb8RWKizmz0tsIVPurTVRDFrgoQ7NJ7EkBik
	RrQbOQwWDk/aKArtI8v7nS1RrbZ49x1orRo5FZuioDktnpBTMy9EM4jA6zll9cF6grGwojhRty0
	nqhdQ4NscPoqmng87UwgynsbaPkuaJlgUoFRJMkaajQSOZzkCVO3aeBE4Y+LrIT8KBck2TXIOS5
	DLcBkwwqRx/z7SvY+u94MrgnWBIpXHPXW2GG4KM4Qj10X83cixJOwJfGn+7fT6jdgsjQViZojnD
	mEmKNHKRRX972W09rof96uG/vRw3EshAHkm+
X-Google-Smtp-Source: AGHT+IESo6J0+zRAVASF/ZMT8KvFhGEgOMm1RoknaLLWwYFt+QhYcQNG5WSTLatUFTsl6tUGc4pYxw==
X-Received: by 2002:a5d:47c3:0:b0:38e:53e7:da50 with SMTP id ffacd0b85a97d-38f33f52fc0mr638664f8f.30.1739566742447;
        Fri, 14 Feb 2025 12:59:02 -0800 (PST)
Received: from localhost.localdomain ([2001:4c4e:1e9e:5700:2a28:d53d:268f:6f1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d237sm84360125e9.21.2025.02.14.12.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 12:59:02 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	horms@kernel.org,
	davem@davemloft.net,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v3] selftests: net: add support for testing SO_RCVMARK and SO_RCVPRIORITY
Date: Fri, 14 Feb 2025 21:58:28 +0100
Message-ID: <20250214205828.48503-1-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce tests to verify the correct functionality of the SO_RCVMARK and 
SO_RCVPRIORITY socket options.

Key changes include:

- so_rcv_listener.c: Implements a receiver application to test the correct 
behavior of the SO_RCVMARK and SO_RCVPRIORITY options.
- test_so_rcv.sh: Provides a shell script to automate testing for these options.
- Makefile: Integrates test_so_rcv.sh into the kernel selftests.

v3:

- Add the C part to TEST_GEN_FILES.
- Ensure the test fails if no cmsg of type opt.name is received
in so_rcv_listener.c
- Rebased on net-next.

v2:

https://lore.kernel.org/netdev/20250210192216.37756-1-annaemesenyiri@gmail.com/
- Add the C part to TEST_GEN_PROGS and .gitignore.
- Modify buffer space and add IPv6 testing option
in so_rcv_listener.c.
- Add IPv6 testing, remove unnecessary comment,
add kselftest exit codes, run both binaries in a namespace,
and add sleep in test_so_rcv.sh.
The sleep was added to ensure that the listener process has
enough time to start before the sender attempts to connect.
- Rebased on net-next.

v1:

https://lore.kernel.org/netdev/20250129143601.16035-2-annaemesenyiri@gmail.com/

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   2 +
 tools/testing/selftests/net/so_rcv_listener.c | 168 ++++++++++++++++++
 tools/testing/selftests/net/test_so_rcv.sh    |  73 ++++++++
 4 files changed, 244 insertions(+)
 create mode 100644 tools/testing/selftests/net/so_rcv_listener.c
 create mode 100755 tools/testing/selftests/net/test_so_rcv.sh

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 28a715a8ef2b..80dcae53ef55 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -42,6 +42,7 @@ socket
 so_incoming_cpu
 so_netns_cookie
 so_txtime
+so_rcv_listener
 stress_reuseport_listen
 tap
 tcp_fastopen_backup_key
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b6271714504d..8d6116b80cf1 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -33,6 +33,7 @@ TEST_PROGS += gro.sh
 TEST_PROGS += gre_gso.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_so_priority.sh
+TEST_PROGS += test_so_rcv.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
 TEST_PROGS += nl_netdev.py
@@ -76,6 +77,7 @@ TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls tun tap epoll_busy_
 TEST_GEN_FILES += toeplitz
 TEST_GEN_FILES += cmsg_sender
 TEST_GEN_FILES += stress_reuseport_listen
+TEST_GEN_FILES += so_rcv_listener
 TEST_PROGS += test_vxlan_vnifiltering.sh
 TEST_GEN_FILES += io_uring_zerocopy_tx
 TEST_PROGS += io_uring_zerocopy_tx.sh
diff --git a/tools/testing/selftests/net/so_rcv_listener.c b/tools/testing/selftests/net/so_rcv_listener.c
new file mode 100644
index 000000000000..4b0b14edce61
--- /dev/null
+++ b/tools/testing/selftests/net/so_rcv_listener.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <errno.h>
+#include <netdb.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+
+#ifndef SO_RCVPRIORITY
+#define SO_RCVPRIORITY 82
+#endif
+
+struct options {
+	__u32 val;
+	int name;
+	int rcvname;
+	const char *host;
+	const char *service;
+} opt;
+
+static void __attribute__((noreturn)) usage(const char *bin)
+{
+	printf("Usage: %s [opts] <dst host> <dst port / service>\n", bin);
+	printf("Options:\n"
+		"\t\t-M val  Test SO_RCVMARK\n"
+		"\t\t-P val  Test SO_RCVPRIORITY\n"
+		"");
+	exit(EXIT_FAILURE);
+}
+
+static void parse_args(int argc, char *argv[])
+{
+	int o;
+
+	while ((o = getopt(argc, argv, "M:P:")) != -1) {
+		switch (o) {
+		case 'M':
+			opt.val = atoi(optarg);
+			opt.name = SO_MARK;
+			opt.rcvname = SO_RCVMARK;
+			break;
+		case 'P':
+			opt.val = atoi(optarg);
+			opt.name = SO_PRIORITY;
+			opt.rcvname = SO_RCVPRIORITY;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	if (optind != argc - 2)
+		usage(argv[0]);
+
+	opt.host = argv[optind];
+	opt.service = argv[optind + 1];
+}
+
+int main(int argc, char *argv[])
+{
+	int err = 0;
+	int recv_fd = -1;
+	int ret_value = 0;
+	__u32 recv_val;
+	struct cmsghdr *cmsg;
+	char cbuf[CMSG_SPACE(sizeof(__u32))];
+	char recv_buf[CMSG_SPACE(sizeof(__u32))];
+	struct iovec iov[1];
+	struct msghdr msg;
+	struct sockaddr_in recv_addr4;
+	struct sockaddr_in6 recv_addr6;
+
+	parse_args(argc, argv);
+
+	int family = strchr(opt.host, ':') ? AF_INET6 : AF_INET;
+
+	recv_fd = socket(family, SOCK_DGRAM, IPPROTO_UDP);
+	if (recv_fd < 0) {
+		perror("Can't open recv socket");
+		ret_value = -errno;
+		goto cleanup;
+	}
+
+	err = setsockopt(recv_fd, SOL_SOCKET, opt.rcvname, &opt.val, sizeof(opt.val));
+	if (err < 0) {
+		perror("Recv setsockopt error");
+		ret_value = -errno;
+		goto cleanup;
+	}
+
+	if (family == AF_INET) {
+		memset(&recv_addr4, 0, sizeof(recv_addr4));
+		recv_addr4.sin_family = family;
+		recv_addr4.sin_port = htons(atoi(opt.service));
+
+		if (inet_pton(family, opt.host, &recv_addr4.sin_addr) <= 0) {
+			perror("Invalid IPV4 address");
+			ret_value = -errno;
+			goto cleanup;
+		}
+
+		err = bind(recv_fd, (struct sockaddr *)&recv_addr4, sizeof(recv_addr4));
+	} else {
+		memset(&recv_addr6, 0, sizeof(recv_addr6));
+		recv_addr6.sin6_family = family;
+		recv_addr6.sin6_port = htons(atoi(opt.service));
+
+		if (inet_pton(family, opt.host, &recv_addr6.sin6_addr) <= 0) {
+			perror("Invalid IPV6 address");
+			ret_value = -errno;
+			goto cleanup;
+		}
+
+		err = bind(recv_fd, (struct sockaddr *)&recv_addr6, sizeof(recv_addr6));
+	}
+
+	if (err < 0) {
+		perror("Recv bind error");
+		ret_value = -errno;
+		goto cleanup;
+	}
+
+	iov[0].iov_base = recv_buf;
+	iov[0].iov_len = sizeof(recv_buf);
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cbuf;
+	msg.msg_controllen = sizeof(cbuf);
+
+	err = recvmsg(recv_fd, &msg, 0);
+	if (err < 0) {
+		perror("Message receive error");
+		ret_value = -errno;
+		goto cleanup;
+	}
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == opt.name) {
+			recv_val = *(__u32 *)CMSG_DATA(cmsg);
+			printf("Received value: %u\n", recv_val);
+
+			if (recv_val != opt.val) {
+				fprintf(stderr, "Error: expected value: %u, got: %u\n",
+					opt.val, recv_val);
+				ret_value = -EINVAL;
+			}
+			goto cleanup;
+		}
+	}
+
+	fprintf(stderr, "Error: No matching cmsg received\n");
+	ret_value = -ENOMSG;
+
+cleanup:
+	if (recv_fd >= 0)
+		close(recv_fd);
+
+	return ret_value;
+}
diff --git a/tools/testing/selftests/net/test_so_rcv.sh b/tools/testing/selftests/net/test_so_rcv.sh
new file mode 100755
index 000000000000..d8aa4362879d
--- /dev/null
+++ b/tools/testing/selftests/net/test_so_rcv.sh
@@ -0,0 +1,73 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+HOSTS=("127.0.0.1" "::1")
+PORT=1234
+TOTAL_TESTS=0
+FAILED_TESTS=0
+
+declare -A TESTS=(
+	["SO_RCVPRIORITY"]="-P 2"
+	["SO_RCVMARK"]="-M 3"
+)
+
+check_result() {
+	((TOTAL_TESTS++))
+	if [ "$1" -ne 0 ]; then
+		((FAILED_TESTS++))
+	fi
+}
+
+cleanup()
+{
+	cleanup_ns $NS
+}
+
+trap cleanup EXIT
+
+setup_ns NS
+
+for HOST in "${HOSTS[@]}"; do
+	PROTOCOL="IPv4"
+	if [[ "$HOST" == "::1" ]]; then
+		PROTOCOL="IPv6"
+	fi
+	for test_name in "${!TESTS[@]}"; do
+		echo "Running $test_name test, $PROTOCOL"
+		arg=${TESTS[$test_name]}
+
+		ip netns exec $NS ./so_rcv_listener $arg $HOST $PORT &
+		LISTENER_PID=$!
+
+		sleep 0.5
+
+		if ! ip netns exec $NS ./cmsg_sender $arg $HOST $PORT; then
+			echo "Sender failed for $test_name, $PROTOCOL"
+			kill "$LISTENER_PID" 2>/dev/null
+			wait "$LISTENER_PID"
+			check_result 1
+			continue
+		fi
+
+		wait "$LISTENER_PID"
+		LISTENER_EXIT_CODE=$?
+
+		if [ "$LISTENER_EXIT_CODE" -eq 0 ]; then
+			echo "Rcv test OK for $test_name, $PROTOCOL"
+			check_result 0
+		else
+			echo "Rcv test FAILED for $test_name, $PROTOCOL"
+			check_result 1
+		fi
+	done
+done
+
+if [ "$FAILED_TESTS" -ne 0 ]; then
+	echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
+	exit ${KSFT_FAIL}
+else
+	echo "OK - All $TOTAL_TESTS tests passed"
+	exit ${KSFT_PASS}
+fi
-- 
2.43.0


