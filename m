Return-Path: <linux-kselftest+bounces-9558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A11C8BD68E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 22:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3622BB20FF0
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD5615CD42;
	Mon,  6 May 2024 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RZ+RptK2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0315B997
	for <linux-kselftest@vger.kernel.org>; Mon,  6 May 2024 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028822; cv=none; b=aS9myUnkEx/eIaa9CwFyw7ccJ4kRW9bY9Ahi+HUuLMuxcjDHC71yZJrFD21LBS8GCSyX123acO7Bot7vOZ70dmpgrGJyxaEzaU4NO+tbd1L12jMiLCFtOkggvAmSehBxWUT6XFN5N8j3xQ97Y4FJCZ4e8ii4PbxMfB9XG0jv3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028822; c=relaxed/simple;
	bh=6WzZW5A7prKkyPBstB4o6EWZ+BYYXcPcTb+GVvBRWeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OthskqnjJKLi9ECqAVZMtO0zAn9eVPbqSawU88HEwRsnkgInq2gXpi3VPg0J9B1BSryqGv37sllyGvrvQTjSHTCAXLSklkFPcH7y0H7/1HU79JFkOp+c2iDtQpzdaGg6NmVpZ46czCXo5Cp6L88RmbEn8+WwDbocZTjtBfrdrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RZ+RptK2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so2309920b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2024 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715028820; x=1715633620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=37IsvG5uzo6zvAWDaiRFgFSIj/fPT6QL1vAqI4tA0ac=;
        b=RZ+RptK2kREWvugd6Z9DNedVSNSn8DSFXRonTpnfxFzM1ocgepV6OeC9utG+3DPop6
         Ta4OzrlYxQpUpZPDE+MebmYlFYtfookNYgx71tkkJdO6zspvefEUQpoZm6VTKDPsFNbZ
         f3Mt+Op4yZ/s8tk07T35xRFhr9t4S43iPWfiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715028820; x=1715633620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37IsvG5uzo6zvAWDaiRFgFSIj/fPT6QL1vAqI4tA0ac=;
        b=M8UTf3gRNtv9Dwdiq2/ycXtbEKjcaq+bi/zjgBd37FVc8aM69F3K5FWiLGsRo9Mvba
         c+QyyRIs4I4w6aAlSIWCAmRF8CxiMFFyMbrEBcePwNhQsN/C6ZPzhl9xnJ+vEaT3urMr
         anHbMvHp71vGdGMwblb3+3fr7wScaiJGEN7LzdDznE6JRhNpwka+xVV8xtVMOKgILpUn
         gbcUE3pYhh/MTvhDzWjiAh6oDjyyvyYeM3EwAzXvJHiSmfk5s6Hbiic3D+teqGwi6kcC
         DE5y/BNzl511rU+1juzHpIuRKNnR57h6z/RzrrGL0HNZm8EOW6BehLnpPGz3fyyqOMr6
         s6mA==
X-Gm-Message-State: AOJu0Yzh5qBSgiHwEkMRDk9MWPHi2KGBeHM1/Bqxb2SIJnkK/ufUuH81
	Gfi91Q/OfQ44E6SxjCRkcSKJ6P2EAL70LfAnwCQOCZk1+7F+YK3URiCFHI88OYY6cqWbvmdz1Ac
	41h9YWF/8VKFSne+Vq+UnLTt0Bohc4Y7TwZ4MVLxjOcV6rpOXGSNo1Zf4Kn4GDceJmok+EM07KH
	oPKDR6VMEMfZzmL9DOUekK2eZHuwKQtLUDLjxACYP/hh8F7N4=
X-Google-Smtp-Source: AGHT+IGNDFzugS9+uMkoMuHk8mtOzpWvoY+LxKHtcCsVky71WRajvQzFJedmT2ImZOmmyCHKHKjqyA==
X-Received: by 2002:a05:6a20:3d90:b0:1a3:ae75:d6f5 with SMTP id s16-20020a056a203d9000b001a3ae75d6f5mr13991866pzi.20.1715028819526;
        Mon, 06 May 2024 13:53:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id p40-20020a056a0026e800b006f44d0df062sm6289521pfw.125.2024.05.06.13.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:53:38 -0700 (PDT)
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
Subject: [PATCH net-next v2] selftest: epoll_busy_poll: epoll busy poll tests
Date: Mon,  6 May 2024 20:53:22 +0000
Message-Id: <20240506205326.70502-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test for the epoll busy poll ioctls, using the kernel
selftest harness.

This test ensures that the ioctls have the expected return codes and
that the kernel properly gets and sets epoll busy poll parameters.

The test can be expanded in the future to do real busy polling (provided
another machine to act as the client is available).

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   2 +-
 tools/testing/selftests/net/epoll_busy_poll.c | 271 ++++++++++++++++++
 3 files changed, 273 insertions(+), 1 deletion(-)
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
index 5befca249452..b0b893009867 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -67,7 +67,7 @@ TEST_GEN_FILES += ipsec
 TEST_GEN_FILES += ioam6_parser
 TEST_GEN_FILES += gro
 TEST_GEN_PROGS = reuseport_bpf reuseport_bpf_cpu reuseport_bpf_numa
-TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls tun tap
+TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls tun tap epoll_busy_poll
 TEST_GEN_FILES += toeplitz
 TEST_GEN_FILES += cmsg_sender
 TEST_GEN_FILES += stress_reuseport_listen
diff --git a/tools/testing/selftests/net/epoll_busy_poll.c b/tools/testing/selftests/net/epoll_busy_poll.c
new file mode 100644
index 000000000000..166fabc6cc7e
--- /dev/null
+++ b/tools/testing/selftests/net/epoll_busy_poll.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
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
+#include "../kselftest_harness.h"
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
+FIXTURE(invalid_fd)
+{
+	int invalid_fd;
+	struct epoll_params params;
+};
+
+FIXTURE_SETUP(invalid_fd)
+{
+	int ret;
+
+	ret = socket(AF_UNIX, SOCK_DGRAM, 0);
+	EXPECT_NE(-1, ret)
+		TH_LOG("error creating unix socket");
+
+	self->invalid_fd = ret;
+}
+
+FIXTURE_TEARDOWN(invalid_fd)
+{
+	int ret;
+
+	ret = close(self->invalid_fd);
+	EXPECT_EQ(0, ret);
+}
+
+TEST_F(invalid_fd, test_invalid_fd)
+{
+	int ret;
+
+	ret = ioctl(self->invalid_fd, EPIOCGPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCGPARAMS on invalid epoll FD should error");
+
+	EXPECT_EQ(ENOTTY, errno)
+		TH_LOG("EPIOCGPARAMS on invalid epoll FD should set errno to ENOTTY");
+
+	memset(&self->params, 0, sizeof(struct epoll_params));
+
+	ret = ioctl(self->invalid_fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS on invalid epoll FD should error");
+
+	EXPECT_EQ(ENOTTY, errno)
+		TH_LOG("EPIOCSPARAMS on invalid epoll FD should set errno to ENOTTY");
+}
+
+FIXTURE(epoll_busy_poll)
+{
+	int fd;
+	struct epoll_params params;
+	struct epoll_params *invalid_params;
+};
+
+FIXTURE_SETUP(epoll_busy_poll)
+{
+	int ret;
+
+	ret = epoll_create1(0);
+	EXPECT_NE(-1, ret)
+		TH_LOG("epoll_create1 failed?");
+
+	self->fd = ret;
+}
+
+FIXTURE_TEARDOWN(epoll_busy_poll)
+{
+	int ret;
+
+	ret = close(self->fd);
+	EXPECT_EQ(0, ret);
+}
+
+TEST_F(epoll_busy_poll, test_get_params)
+{
+	/* begin by getting the epoll params from the kernel
+	 *
+	 * the default should be default and all fields should be zero'd by the
+	 * kernel, so set params fields to garbage to test this.
+	 */
+	int ret = 0;
+
+	self->params.busy_poll_usecs = 0xff;
+	self->params.busy_poll_budget = 0xff;
+	self->params.prefer_busy_poll = 1;
+	self->params.__pad = 0xf;
+
+	ret = ioctl(self->fd, EPIOCGPARAMS, &self->params);
+	EXPECT_EQ(0, ret)
+		TH_LOG("ioctl EPIOCGPARAMS should succeed");
+
+	EXPECT_EQ(0, self->params.busy_poll_usecs)
+		TH_LOG("EPIOCGPARAMS busy_poll_usecs should have been 0");
+
+	EXPECT_EQ(0, self->params.busy_poll_budget)
+		TH_LOG("EPIOCGPARAMS busy_poll_budget should have been 0");
+
+	EXPECT_EQ(0, self->params.prefer_busy_poll)
+		TH_LOG("EPIOCGPARAMS prefer_busy_poll should have been 0");
+
+	EXPECT_EQ(0, self->params.__pad)
+		TH_LOG("EPIOCGPARAMS __pad should have been 0");
+
+	self->invalid_params = (struct epoll_params *)0xdeadbeef;
+	ret = ioctl(self->fd, EPIOCGPARAMS, self->invalid_params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCGPARAMS should error with invalid params");
+
+	EXPECT_EQ(EFAULT, errno)
+		TH_LOG("EPIOCGPARAMS with invalid params should set errno to EFAULT");
+}
+
+TEST_F(epoll_busy_poll, test_set_invalid)
+{
+	int ret;
+
+	memset(&self->params, 0, sizeof(struct epoll_params));
+
+	self->params.__pad = 1;
+
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS non-zero __pad should error");
+
+	EXPECT_EQ(EINVAL, errno)
+		TH_LOG("EPIOCSPARAMS non-zero __pad errno should be EINVAL");
+
+	self->params.__pad = 0;
+	self->params.busy_poll_usecs = (unsigned int)INT_MAX + 1;
+
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS should error busy_poll_usecs > S32_MAX");
+
+	EXPECT_EQ(EINVAL, errno)
+		TH_LOG("EPIOCSPARAMS busy_poll_usecs > S32_MAX errno should be EINVAL");
+
+	self->params.__pad = 0;
+	self->params.busy_poll_usecs = 32;
+	self->params.prefer_busy_poll = 2;
+
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS should error prefer_busy_poll > 1");
+
+	EXPECT_EQ(EINVAL, errno)
+		TH_LOG("EPIOCSPARAMS prefer_busy_poll > 1 errno should be EINVAL");
+
+	self->params.__pad = 0;
+	self->params.busy_poll_usecs = 32;
+	self->params.prefer_busy_poll = 1;
+
+	/* set budget well above kernel's NAPI_POLL_WEIGHT of 64 */
+	self->params.busy_poll_budget = 65535;
+
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS should error busy_poll_budget > NAPI_POLL_WEIGHT");
+
+	EXPECT_EQ(EPERM, errno)
+		TH_LOG("EPIOCSPARAMS errno should be EPERM busy_poll_budget > NAPI_POLL_WEIGHT");
+
+	self->invalid_params = (struct epoll_params *)0xdeadbeef;
+	ret = ioctl(self->fd, EPIOCSPARAMS, self->invalid_params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("EPIOCSPARAMS should error when epoll_params is invalid");
+
+	EXPECT_EQ(EFAULT, errno)
+		TH_LOG("EPIOCSPARAMS should set errno to EFAULT when epoll_params is invalid");
+}
+
+TEST_F(epoll_busy_poll, test_set_and_get_valid)
+{
+	int ret;
+
+	memset(&self->params, 0, sizeof(struct epoll_params));
+
+	self->params.busy_poll_usecs = 25;
+	self->params.busy_poll_budget = 16;
+	self->params.prefer_busy_poll = 1;
+
+	ret = ioctl(self->fd, EPIOCSPARAMS, &self->params);
+
+	EXPECT_EQ(0, ret)
+		TH_LOG("EPIOCSPARAMS with valid params should not error");
+
+	/* check that the kernel returns the same values back */
+
+	memset(&self->params, 0, sizeof(struct epoll_params));
+
+	ret = ioctl(self->fd, EPIOCGPARAMS, &self->params);
+
+	EXPECT_EQ(0, ret)
+		TH_LOG("EPIOCGPARAMS should not error");
+
+	EXPECT_EQ(25, self->params.busy_poll_usecs)
+		TH_LOG("params.busy_poll_usecs incorrect");
+
+	EXPECT_EQ(16, self->params.busy_poll_budget)
+		TH_LOG("params.busy_poll_budget incorrect");
+
+	EXPECT_EQ(1, self->params.prefer_busy_poll)
+		TH_LOG("params.prefer_busy_poll incorrect");
+
+	EXPECT_EQ(0, self->params.__pad)
+		TH_LOG("params.__pad was not 0");
+}
+
+TEST_F(epoll_busy_poll, test_invalid_ioctl)
+{
+	int invalid_ioctl = EPIOCGPARAMS + 10;
+	int ret;
+
+	ret = ioctl(self->fd, invalid_ioctl, &self->params);
+
+	EXPECT_EQ(-1, ret)
+		TH_LOG("invalid ioctl should return error");
+
+	EXPECT_EQ(EINVAL, errno)
+		TH_LOG("invalid ioctl should set errno to EINVAL");
+}
+
+TEST_HARNESS_MAIN
-- 
2.25.1


