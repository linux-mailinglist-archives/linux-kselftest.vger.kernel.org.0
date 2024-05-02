Return-Path: <linux-kselftest+bounces-9287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12838BA22A
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 23:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADDE1F22880
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C41A181BAF;
	Thu,  2 May 2024 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="umNpCyoq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B4181317
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684826; cv=none; b=Gch0eNDFUjngXGA1ENyjlpMpyNxYulgDCa7fKRsLX52jOp6z3rhfbjR2F98Z7sW4j6eR+SK4r16EDENwkLxFKY4NiYD7ciG19TzBj0ZtiFZ69bu1xz/K0m/oPmjXuPTffbyAYmll3hf8YcM/onhNIsz8lcxnUhL3QuFVImbc/iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684826; c=relaxed/simple;
	bh=hUK2jEvBw2kxTtt5wE8bcezHoXk73oM3myWEjpqNG0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S3OzYAHbAtlP90VwdPG7rJ9hJMzzLJ/VglKxfcOrHQkuFK+FXDTWimCYH0tYa//sAi3Mhn+R7UTbsQfJ7SxNvmmScQ0mYXk128hV0HDJTsnYPV4K2cWmWcylrm/jWK9snGjOj0zWd54rCbWPdQAfstNl8DGXBZAeX5hWyAILH6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=umNpCyoq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed627829e6so9835710b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 14:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714684823; x=1715289623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hncUOQWmqOGUoLNpyAkBcgErvZ7+mEaS4U5aue9YWcM=;
        b=umNpCyoqHVGI6XeLlEZ8nq1iz+ZzMIXo5P6P8yrOPVYliH8+oVk4DFXSYGz2BcSPt4
         SzXQMDFGZOHsRag+WCIy1TnCPdkem+/kM7t+NDSkTrMGLmOGSxxrqB3zi5wTIOXK/KCW
         iILDp1SPtAfn3F/QNLzoywcyr5K6dGQo1yNu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714684823; x=1715289623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hncUOQWmqOGUoLNpyAkBcgErvZ7+mEaS4U5aue9YWcM=;
        b=PLBKHqtfGD9dSZi24Qn8XSdS3WTbkutbsTtfz5RzGzNWFblLvIKMeJvQ58pBgMx6OQ
         6mwQIyS9TikrScsaQyMOBn9QPDGUxHmeBKKR5Y1GTDvl8H7wvst25vR+ZDjfz5TTlAqv
         ZrWOtlpMIZxOQxspiKa6+O/lOnpTj+3TuRm/nX8hh6sZY4LBjPtoR7Km2NkTHwLNXBo5
         4+RlQpV3s0oJ9p0avgfvfZPZY4n2dtmQ4X3AdFeTdpuLSuqvRf3525xyVZOq8cutG7Ah
         fkR9+gUlD32/h6cDAhSAqDzbl7SNr5RlEt4OTppmTb+1CPP0US0hUOWFYDB5c0eP85Tn
         aMlQ==
X-Gm-Message-State: AOJu0Ywl1sdUxAUJezZsinoG1eysJQf6nA9E5XrOFK7m66UmpTrWNKWN
	LyIysdMczbhhauoJFL15kCbxm0MELHvJmtLkFnFio1SJaXsD5El14EDy3aXtWPGAtiOU4xof26B
	jHTja/qG/w0KN2Y5sIo3sZ6j6jcA2t9L5V4/M0fYb9bcLHBWpQ4v0KYvXJeB+7zoeaDe3rsN7g+
	5SEMlHUL8AuZuy/Ediiiob1JvPw8BP/uxZD0aB9tFG6J6+QIc=
X-Google-Smtp-Source: AGHT+IEOJcD/NH5H4od1kl2Rjccz0Lt0ltHz/eAsoHtVB7pUoFxr0/GN18Mkn7U4wk0bAkqyOA22cA==
X-Received: by 2002:a05:6a20:ba1:b0:1aa:bde:8c78 with SMTP id i33-20020a056a200ba100b001aa0bde8c78mr915178pzh.54.1714684823412;
        Thu, 02 May 2024 14:20:23 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id ld16-20020a170902fad000b001e4344a7601sm1806712plb.42.2024.05.02.14.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:20:22 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next] selftest: epoll_busy_poll: epoll busy poll tests
Date: Thu,  2 May 2024 21:20:11 +0000
Message-Id: <20240502212013.274758-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test for the epoll busy poll ioctls.

This test ensures that the ioctls have the expected return codes and
that the kernel properly gets and sets epoll busy poll parameters.

The test can be expanded in the future to do real busy polling (provided
another machine to act as the client is available).

To run the test (use -s for "simple" test):

./epoll_busy_poll -s

On success, nothing is written to stdout/stderr and the exit code is 0.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/epoll_busy_poll.c | 279 ++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 tools/testing/selftests/net/epoll_busy_poll.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index d996a0ab0765..777cfd027076 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -5,6 +5,7 @@ bind_wildcard
 csum
 cmsg_sender
 diag_uid
+epoll_busy_poll
 fin_ack_lat
 gro
 hwtstamp_config
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5befca249452..c83c5d9c1ad9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -84,6 +84,7 @@ TEST_GEN_FILES += sctp_hello
 TEST_GEN_FILES += csum
 TEST_GEN_FILES += ip_local_port_range
 TEST_GEN_FILES += bind_wildcard
+TEST_GEN_FILES += epoll_busy_poll
 TEST_PROGS += test_vxlan_mdb.sh
 TEST_PROGS += test_bridge_neigh_suppress.sh
 TEST_PROGS += test_vxlan_nolocalbypass.sh
diff --git a/tools/testing/selftests/net/epoll_busy_poll.c b/tools/testing/selftests/net/epoll_busy_poll.c
new file mode 100644
index 000000000000..3066a41a2acb
--- /dev/null
+++ b/tools/testing/selftests/net/epoll_busy_poll.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Basic per-epoll context busy poll test.
+ *
+ * Only tests the ioctls, but should be expanded to test two connected hosts in
+ * the future
+ */
+
+#define _GNU_SOURCE
+
+#include <error.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/epoll.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
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
+enum epoll_test_types {
+	TEST_UNDEFINED = -1,
+	TEST_SIMPLE = 0,
+};
+
+static enum epoll_test_types test_type = TEST_UNDEFINED;
+
+static void usage(const char *filepath)
+{
+	error(1, 0, "Usage: %s [options]", filepath);
+}
+
+static void parse_opts(int argc, char **argv)
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "s")) != -1) {
+		switch (c) {
+		case 's':
+			test_type = TEST_SIMPLE;
+			break;
+		}
+	}
+
+	if (optind != argc)
+		usage(argv[0]);
+}
+
+static void do_simple_test_get_params(int fd)
+{
+	/* begin by getting the epoll params from the kernel
+	 *
+	 * the default should be default and all fields should be zero'd by the
+	 * kernel, so set params fields to garbage to test this.
+	 */
+	struct epoll_params *invalid_params;
+	struct epoll_params params;
+	int ret = 0;
+
+	params.busy_poll_usecs = 0xff;
+	params.busy_poll_budget = 0xff;
+	params.prefer_busy_poll = 1;
+	params.__pad = 0xf;
+
+	if (ioctl(fd, EPIOCGPARAMS, &params) != 0)
+		error(1, errno, "ioctl EPIOCGPARAMS");
+
+	if (params.busy_poll_usecs != 0)
+		error(1, 0, "EPIOCGPARAMS busy_poll_usecs should have been 0");
+
+	if (params.busy_poll_budget != 0)
+		error(1, 0, "EPIOCGPARAMS busy_poll_budget should have been 0");
+
+	if (params.prefer_busy_poll != 0)
+		error(1, 0, "EPIOCGPARAMS prefer_busy_poll should have been 0");
+
+	if (params.__pad != 0)
+		error(1, 0, "EPIOCGPARAMS __pad should have been 0");
+
+	invalid_params = (struct epoll_params *)0xdeadbeef;
+	ret = ioctl(fd, EPIOCGPARAMS, invalid_params);
+	if (ret != -1)
+		error(1, 0, "EPIOCGPARAMS should error with invalid params");
+
+	if (errno != EFAULT)
+		error(1, 0,
+		      "EPIOCGPARAMS with invalid params should set errno to EFAULT");
+}
+
+static void do_simple_test_set_invalid(int fd)
+{
+	/* Set some unacceptable values and check for error */
+	struct epoll_params *invalid_params;
+	struct epoll_params params;
+	int ret;
+
+	memset(&params, 0, sizeof(struct epoll_params));
+
+	params.__pad = 1;
+
+	ret = ioctl(fd, EPIOCSPARAMS, &params);
+
+	if (ret != -1)
+		error(1, 0, "EPIOCSPARAMS with non-zero __pad should error");
+
+	if (errno != EINVAL)
+		error(1, 0, "EPIOCSPARAMS with non-zero __pad errno should be EINVAL");
+
+	params.__pad = 0;
+	params.busy_poll_usecs = (unsigned int)INT_MAX + 1;
+
+	ret = ioctl(fd, EPIOCSPARAMS, &params);
+
+	if (ret != -1)
+		error(1, 0, "EPIOCSPARAMS should error busy_poll_usecs > S32_MAX");
+
+	if (errno != EINVAL)
+		error(1, 0, "EPIOCSPARAMS with busy_poll_usecs > S32_MAX, errno should be EINVAL");
+
+	params.__pad = 0;
+	params.busy_poll_usecs = 32;
+	params.prefer_busy_poll = 2;
+
+	ret = ioctl(fd, EPIOCSPARAMS, &params);
+
+	if (ret != -1)
+		error(1, 0, "EPIOCSPARAMS should error prefer_busy_poll > 1");
+
+	if (errno != EINVAL)
+		error(1, 0, "EPIOCSPARAMS with prefer_busy_poll > 1 errno should be EINVAL");
+
+	params.__pad = 0;
+	params.busy_poll_usecs = 32;
+	params.prefer_busy_poll = 1;
+	params.busy_poll_budget = 65535;
+
+	ret = ioctl(fd, EPIOCSPARAMS, &params);
+
+	if (ret != -1)
+		error(1, 0, "EPIOCSPARAMS should error busy_poll_budget > NAPI_POLL_WEIGHT");
+
+	if (errno != EPERM)
+		error(1, 0,
+		      "EPIOCSPARAMS with busy_poll_budget > NAPI_POLL_WEIGHT (without CAP_NET_ADMIN) errno should be EPERM");
+
+	invalid_params = (struct epoll_params *)0xdeadbeef;
+	ret = ioctl(fd, EPIOCSPARAMS, invalid_params);
+
+	if (ret != -1)
+		error(1, 0, "EPIOCSPARAMS should error when epoll_params is invalid");
+
+	if (errno != EFAULT)
+		error(1, 0, "EPIOCSPARAMS should set errno to EFAULT when epoll_params is invalid");
+}
+
+static void do_simple_test_set_and_get_valid(int fd)
+{
+	struct epoll_params params;
+	int ret;
+
+	memset(&params, 0, sizeof(struct epoll_params));
+
+	params.busy_poll_usecs = 25;
+	params.busy_poll_budget = 16;
+	params.prefer_busy_poll = 1;
+
+	ret = ioctl(fd, EPIOCSPARAMS, &params);
+
+	if (ret != 0)
+		error(1, errno, "EPIOCSPARAMS with valid params should not error");
+
+	/* check that the kernel returns the same values back */
+
+	memset(&params, 0, sizeof(struct epoll_params));
+
+	ret = ioctl(fd, EPIOCGPARAMS, &params);
+
+	if (ret != 0)
+		error(1, errno, "EPIOCGPARAMS should not error");
+
+	if (params.busy_poll_usecs != 25 ||
+	    params.busy_poll_budget != 16 ||
+	    params.prefer_busy_poll != 1 ||
+	    params.__pad != 0)
+		error(1, 0, "EPIOCGPARAMS returned incorrect values");
+}
+
+static void do_simple_test_invalid_fd(void)
+{
+	struct epoll_params params;
+	int ret;
+	int fd;
+
+	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
+
+	if (fd == -1)
+		error(1, errno, "creating unix socket");
+
+	ret = ioctl(fd, EPIOCGPARAMS, &params);
+
+	if (ret != -1)
+		error(1, 0, "EPIOCGPARAMS on invalid epoll FD should error");
+
+	if (errno != ENOTTY)
+		error(1, 0, "EPIOCGPARAMS on invalid epoll FD should set errno to ENOTTY");
+
+	memset(&params, 0, sizeof(struct epoll_params));
+
+	ret = ioctl(fd, EPIOCSPARAMS, &params);
+
+	if (ret != -1)
+		error(1, 0, "EPIOCSPARAMS on invalid epoll FD should error");
+
+	if (errno != ENOTTY)
+		error(1, 0, "EPIOCSPARAMS on invalid epoll FD should set errno to ENOTTY");
+}
+
+static void do_simple_test_invalid_ioctl(int fd)
+{
+	struct epoll_params params;
+	int invalid_ioctl = EPIOCGPARAMS + 10;
+	int ret;
+
+	ret = ioctl(fd, invalid_ioctl, &params);
+
+	if (ret != -1)
+		error(1, 0, "invalid ioctl should return error");
+
+	if (errno != EINVAL)
+		error(1, 0, "invalid ioctl should set errno to EINVAL");
+}
+
+static void do_simple_test(void)
+{
+	int fd;
+
+	fd = epoll_create1(0);
+	if (fd == -1)
+		error(1, errno, "epoll_create");
+
+	do_simple_test_invalid_fd();
+	do_simple_test_invalid_ioctl(fd);
+	do_simple_test_get_params(fd);
+	do_simple_test_set_invalid(fd);
+	do_simple_test_set_and_get_valid(fd);
+
+	if (close(fd))
+		error(1, errno, "close");
+}
+
+int main(int argc, char **argv)
+{
+	parse_opts(argc, argv);
+
+	if (test_type == TEST_SIMPLE)
+		do_simple_test();
+	else
+		error(1, 0, "unknown test type: %d", test_type);
+
+	return 0;
+}
-- 
2.25.1


