Return-Path: <linux-kselftest+bounces-25368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C998A21F4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE37188481E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1B195980;
	Wed, 29 Jan 2025 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVEoiwXE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97F81474A7;
	Wed, 29 Jan 2025 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738161397; cv=none; b=MYv9X/GRTlfeNDx1MPUQQplREv9JZqmvA06f5TbOK6IFWwiMheMWYF6gxWWHMLoJsR1va4U/s6NNUtMg02QxOb5WsZHLFsfzLQL4AMJkR5QuORtpVwjoB+27yOqg98eES8d/v8IePsE1qDZA7MJg0xpVLIrq5qNwuWvjX02wDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738161397; c=relaxed/simple;
	bh=GdEI/Xk2j5FiMtc++O5jVQhNKnf5OWc1lfUXq0M/18Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDbZpo+lxsrWXi5Wl7I6Y5MDfxF/1w/1Q2bApVJ6ayVMYGG+yr7m75vzECBPF590Pu75OCzMF5KzbALQfFTwd2tbn/kp2llsAJ4SUcgyP6zvcaw8clKsHMsRF/0rAXJUo3DUsvk8gzIzZw+3tmybIH1KyhjSxxyV49os/xyV6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVEoiwXE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso47785775e9.0;
        Wed, 29 Jan 2025 06:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738161394; x=1738766194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sIfHEvcxCY3pnpcdFB+oh5QhdHA0BfWgcYNXklwgHQ=;
        b=gVEoiwXEhbU7gcgOlXvyBV/94kE87QEpe2/EAJjQDGG8TDFHwpqszN2RnO7a2VJJ3r
         BVT9um0fuUzwsT/akDGHGZqf6hF3p/1vYxECEQm+b7jldCW5xLcCT7dvk+gC2mF9RcJn
         CzVfgdWWWTkRWRE82escxV14YLFklHOfxtmS1AwGpQr5QKavDYRsgAVyRV2zxtdJLfXc
         sHhKxkKpGt3FvIiUpKmjY9QPeeE2H1plvUZje6a4xr6ozK4IMIdYFtlrhLhUTOM5drrL
         qy+MZPh94vZMSdT2JljT4Aa+Uatrp4TvVr7HEcPzLSK5E9zBDixUoSCJXwEt5XPMBr5A
         ZI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738161394; x=1738766194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sIfHEvcxCY3pnpcdFB+oh5QhdHA0BfWgcYNXklwgHQ=;
        b=msPYg1/NEkngLUwdm70XMq7HFeeKqrDyLd9ZPwxr5z2YvInk5h6NAaU/rz0nxn510W
         0Hb/xavHFUtw8TDIMCTESv/wtgqfXrNJzgfF7otaKk/5q+/6CQUpIzIZFAIlFPpdAVO+
         Vh6ZY6ogvuKKnM1n2fzMK5tQ2VLF97jUStOFeUEKcqUsAyqd3iMsmuydoKLIIRmeoX47
         2CQ3lmofjmz+hgR3uO7zpQ3OJpSp7it/NE41vpoEiphdLk13BYXDwGHfxfiibtGySXxm
         grhjeDsDnlj1gviH+uexI5kYVHQP9J9k9ct/Byep7eLmpWOqukaspP7Ribq5cIeboDjm
         Pcfg==
X-Forwarded-Encrypted: i=1; AJvYcCV5DuS3nWj0z9tdxWVBePjvBWLJnxsXwOVNQOL3mt+kWc36NsCVsvT8y6IiynfUPmiG35kOOqdrIBghFgJr49A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm++kkmT598d7GVi8SQZfsBBOzCs6x3zKQLpHb4Lpx9XbMndIw
	GInGIHxBEo5uhF6T1x4gXG1cTQg95Cv2iNsOvI3g0p7osqYH9pCBZfplCqrm
X-Gm-Gg: ASbGncsM/Oh1iyY09IsZ/fsqtGRkp9OAGZKGqx0mSdI/2d2buffv4uh5G7GHxsfcRNs
	/y4JwrDl0zTZJ/wmkrdG7V1BhIcCMQ3GYMtI/sFypq5NdlB0TYm2aWaPo7X1onsdwUY09xQF40U
	OCruDEEdL8bC3tUUm8oKrbzryVexxMkbX6N1zWnB+JL+X7iE+ZyxCuc1rrSc9muLUX9KOBBv/02
	iT+XumUd5oTvhOLDTtPyNpT2OkzQvIMPpu6f7M2j2iouJ8TMFhq/viOl8My72JbbXywCCIXFizj
	TY1OHzvMuVmbkJTvxse4MOANpbYiM15UqDYPfw==
X-Google-Smtp-Source: AGHT+IFIFR8iv/eVaU11QgIa3cyc7+1szefMZosV1a+eSFkjJCYbCxA9WYj1pFXZGMSpdhB9/X2Z0w==
X-Received: by 2002:a05:600c:1f15:b0:434:f335:83b with SMTP id 5b1f17b1804b1-438dc3a84aamr31947285e9.5.1738161393326;
        Wed, 29 Jan 2025 06:36:33 -0800 (PST)
Received: from localhost.localdomain ([2001:4c4e:1eb5:de00:1ff8:8b09:84cb:1239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc6df36sm26472465e9.25.2025.01.29.06.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 06:36:32 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	davem@davemloft.net,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next 1/1] selftests: net: Add support for testing SO_RCVMARK and SO_RCVPRIORITY
Date: Wed, 29 Jan 2025 15:36:01 +0100
Message-ID: <20250129143601.16035-2-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129143601.16035-1-annaemesenyiri@gmail.com>
References: <20250129143601.16035-1-annaemesenyiri@gmail.com>
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

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/so_rcv_listener.c | 147 ++++++++++++++++++
 tools/testing/selftests/net/test_so_rcv.sh    |  56 +++++++
 3 files changed, 204 insertions(+)
 create mode 100644 tools/testing/selftests/net/so_rcv_listener.c
 create mode 100755 tools/testing/selftests/net/test_so_rcv.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 73ee88d6b043..98f05473e672 100644
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
diff --git a/tools/testing/selftests/net/so_rcv_listener.c b/tools/testing/selftests/net/so_rcv_listener.c
new file mode 100644
index 000000000000..53b09582a7e3
--- /dev/null
+++ b/tools/testing/selftests/net/so_rcv_listener.c
@@ -0,0 +1,147 @@
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
+	char cbuf[1024];
+	char recv_buf[1024];
+	struct iovec iov[1];
+	struct msghdr msg;
+	struct sockaddr_in recv_addr;
+
+	parse_args(argc, argv);
+
+	recv_fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
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
+	memset(&recv_addr, 0, sizeof(recv_addr));
+	recv_addr.sin_family = AF_INET;
+	recv_addr.sin_port = htons(atoi(opt.service));
+
+	if (inet_pton(AF_INET, opt.host, &recv_addr.sin_addr) <= 0) {
+		perror("Invalid address");
+		ret_value = -errno;
+		goto cleanup;
+	}
+
+	err = bind(recv_fd, (struct sockaddr *)&recv_addr, sizeof(recv_addr));
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
index 000000000000..12d37f9ab905
--- /dev/null
+++ b/tools/testing/selftests/net/test_so_rcv.sh
@@ -0,0 +1,56 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+HOST=127.0.0.1
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
+for test_name in "${!TESTS[@]}"; do
+	echo "Running $test_name test"
+	arg=${TESTS[$test_name]}
+
+	./so_rcv_listener $arg $HOST $PORT &
+	LISTENER_PID=$!
+
+	if ./cmsg_sender $arg $HOST $PORT; then
+		echo "Sender succeeded for $test_name"
+	else
+		echo "Sender failed for $test_name"
+		kill "$LISTENER_PID" 2>/dev/null
+		wait "$LISTENER_PID"
+		check_result 1
+		continue
+	fi
+
+	wait "$LISTENER_PID"
+	LISTENER_EXIT_CODE=$?
+
+	if [ "$LISTENER_EXIT_CODE" -eq 0 ]; then
+		echo "Rcv test OK for $test_name"
+		check_result 0
+	else
+		echo "Rcv test FAILED for $test_name"
+		check_result 1
+	fi
+done
+
+if [ "$FAILED_TESTS" -ne 0 ]; then
+	echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
+	exit 1
+else
+	echo "OK - All $TOTAL_TESTS tests passed"
+	exit 0
+fi
-- 
2.43.0


