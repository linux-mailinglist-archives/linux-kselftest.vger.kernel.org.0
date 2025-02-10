Return-Path: <linux-kselftest+bounces-26209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECAFA2F884
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B269162327
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49351F4635;
	Mon, 10 Feb 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy4S0kRL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A11922E7;
	Mon, 10 Feb 2025 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215376; cv=none; b=HO1CEtox6a8d0OFu+A/vuI5g2oFDzzw3ct4De56zAqlLZeaN0lf0cd1OdfLAFCVnQvrFn+ig9E4YchcL7TN/8q2WH1oxtoRvF/B9IEkPG2/0qFoSBsblP2Rt+JzsqoOzrcGD+tv8tQf3r4ecO+3dCHSGp+aFP+1+wVSAgsqHXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215376; c=relaxed/simple;
	bh=ZbjaCdIgH6xzMFvPeZoLR2damvXo+dfuYveJodhS8A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JktmA9bSf9oUi2skDKA5WeKjDSSv5nT2ZrY3VbKQMZ/GgwvlcR2XnCl7yFAWYLKvnXsdj+HhHXZ0T27q6sd8ZqBEzqyZ9DKJIAvFwlEYA6XTf4jGwkRG1laJIOhIS0IYbxfqCYsc3hxXRmTXkcbRg6tr4pfwJiPEO9JHmo059lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy4S0kRL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361815b96cso31980475e9.1;
        Mon, 10 Feb 2025 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739215373; x=1739820173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6AKnPQLtwMRg0iTC86doV7WXXFzkSpwT4jXjCnq3TlE=;
        b=Hy4S0kRL2k3n/JSPKWnT7Jf/BKUN8Pxzc7tADwM+aBm3JAMKAsllhF9edqryp+4ybP
         o9U8WjDF0x2waozH6hJZGhRmkQilNAwCfnuWBMa3pI17N3HJUYQ9zDj4CimgiYaMB2Gb
         lekSubZHmpmGL2QO43h2p+o5WgonC/+i9zk7H4FN2ZJPb+Ryor6A2rOjlL+GVA9lHra0
         LIouZjZ7tkGUMcBs3JoFg6l+1Adf4py2Qv1IH7JZR2JkCYFLp7Nd6Ls9yuwe0UIog/ce
         uHAte8mwAfJZFNi7z1lvOTP+Mok25ZN6UPqIhuCY9Y44Y1t5MC975U71Eo6Zygx98i/i
         V6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215373; x=1739820173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AKnPQLtwMRg0iTC86doV7WXXFzkSpwT4jXjCnq3TlE=;
        b=bzbSnRozzE1BkMc9FCR0KGfhqqpLB0h0Dv6eb6HCkFUcbJgNlbirEUrW5SI1txUlEZ
         FtujoWVsLsZ9p820PQO9Yo2t0L6qGyRajEfq5lLFhI/91BRp4v/hDCJSh6GAW37Q5KrW
         xsK/0/q/h4CG6k7B50m3gAwDex061c1fhtj8lg3rsyo/epyfD+UuPwEeK6SddLJxmLE4
         K0GlRc5R+Y1Am/VSFpX/PHnlXX+2S6AssUyT5QWb14fDtYWGUCmIwatrq8UhdQRP5X2s
         hWLzauagHAeFOD4DDqp7XoDLaF+nBZ8YK7flt1e4aC0wwdP3FkFEE3+ZiWjDf+i8mn1s
         GGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg6uA+MnTVo3uKNRSQPy9NT2cK6+/c6MYNO/+n7a250IocyRzUjUwgCzOE6D9P1QLQ1ZWZulkCZ0UZ+Lo7xsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyeYvGEnLhprkD+8YUmUB8FrNuGgMUzBtSHqqeGq4GXmXbGymL
	fsqfvKQbFopIWH+nwxC1z36aQX9wAU0AklhrbHVBNpIZ2MK4kvKZNgiHmxbyevA=
X-Gm-Gg: ASbGncvpa2d+tYI44bXoTNjEIm60dk63SrIljZe+yyZTA2hboRyJdbZn1uUtixlOxlA
	wAtQcXbr1SNxW3IW5P06o9HNmPrlz3Ks7LDNsrAgtyk3i/sYfvAp+bRjkm2MpyB0CSiJoUEQjNZ
	cZt1H7UN1Z9GD2d+YHdidiMl/T3AHRI3kI5aHVA+YDYNhy9SsfO/0znEiXwUzOzSfPb5xCJWRdb
	Q42McZ0jMPnCnepxio9+br4O4KJ3nEW7HII3Ow1SiTrdXHFScX4eKv5S66ShCe5VUZYtQyrYvJo
	NAOSDxVnntrdtk0g8YGEeYGLByjpPHniWq4o7A==
X-Google-Smtp-Source: AGHT+IEd5LHpK0IJe7WL0X1x7c7hv1bsicoHdJ2CH+u+fTKnUfNimyHnvl2FUQ058GA+ZRIk5C7qXQ==
X-Received: by 2002:a05:600c:1909:b0:434:fafe:edb with SMTP id 5b1f17b1804b1-439249b04d2mr115837425e9.24.1739215372551;
        Mon, 10 Feb 2025 11:22:52 -0800 (PST)
Received: from localhost.localdomain ([2001:4c4e:1e9e:5700:c582:b55d:adca:7c4b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394328fcb8sm44704455e9.32.2025.02.10.11.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:22:52 -0800 (PST)
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
Subject: [PATCH net-next v2] selftests: net: Add support for testing SO_RCVMARK and SO_RCVPRIORITY
Date: Mon, 10 Feb 2025 20:22:16 +0100
Message-ID: <20250210192216.37756-1-annaemesenyiri@gmail.com>
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

v2:

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
 tools/testing/selftests/net/so_rcv_listener.c | 165 ++++++++++++++++++
 tools/testing/selftests/net/test_so_rcv.sh    |  73 ++++++++
 4 files changed, 241 insertions(+)
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
index 73ee88d6b043..fe3491dea7c5 100644
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
@@ -89,6 +90,7 @@ TEST_GEN_FILES += sctp_hello
 TEST_GEN_FILES += ip_local_port_range
 TEST_GEN_PROGS += bind_wildcard
 TEST_GEN_PROGS += bind_timewait
+TEST_GEN_PROGS += so_rcv_listener
 TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
diff --git a/tools/testing/selftests/net/so_rcv_listener.c b/tools/testing/selftests/net/so_rcv_listener.c
new file mode 100644
index 000000000000..693fc1e3d44d
--- /dev/null
+++ b/tools/testing/selftests/net/so_rcv_listener.c
@@ -0,0 +1,165 @@
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
+				goto cleanup;
+			}
+		}
+	}
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


