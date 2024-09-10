Return-Path: <linux-kselftest+bounces-17595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1F973A59
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F901C24AA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86B61A2548;
	Tue, 10 Sep 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaTE2ETl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E01A08DB;
	Tue, 10 Sep 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979445; cv=none; b=rxOOtu2HDDlchasWsS+Y4isvXluIWfS7ZqUcmA6Y1AV+DEXexXlmdH5wM32HGtzixWNkY18iNuJH/eGjst+LeBz67nXWwvSINKQjgVRUIrVC0jC/DvBUYMZXWRy/It9FwqBxZ01Y3nXwaBab67nyw6S0Z3tH4r8HsJ5RxInzLmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979445; c=relaxed/simple;
	bh=JfbqgBGrbPRf4Q+i81ZCJ1xRNQLnuvbrzRkeCT0GBRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBLhe7KW1HxMjzZAbacaC+lnGw1apmikCnA+MJDVy6EOjFt3vnrbPq34L7Af7DaV9HfQcvIXfbsDoTXGZU9m+DucFWH6SYi/kNn735zGE89XAmlteXdzl9t0h439vQJw9YNUUoYowiMq7HUkb/78VOzUSQzvFVKbHofIhS0aJ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaTE2ETl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FA8C4CEC4;
	Tue, 10 Sep 2024 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979445;
	bh=JfbqgBGrbPRf4Q+i81ZCJ1xRNQLnuvbrzRkeCT0GBRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PaTE2ETlZNbgSY5WDwpH4EqdZrHAUaF95gfVOO/LIZNoojsXeQftZgywGzJeoroxT
	 JPg2FUrmnqdKwsy4q6XZB2CsPNz/Tvme5V+TFUFtWKKYrJ4rAwEA9yFTJJ/n7pVf0L
	 H7nBk0C9bWK8ImLKXFdtb1P8N+ywQFms7JToCURgjUmvVZHMduHpcj7bnhtR2cqLgP
	 o4hNGk4URMagdO4ZzWJQNlaWbFaOsv66cH7b02IKHsUyneWbG4KsiskHhY2guv9A+B
	 JL59djHRER5KfDbNPdUN29aqKuTWJiIxDgGg6CwmJYocEgI4MByR8L2JzuL5WiHerK
	 HpxnRGBW7RVIw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:43 +0900
Subject: [PATCH HID v2 07/11] selftests/hid: allow to parametrize
 bus/vid/pid/rdesc on the test device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-7-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=6751;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=JfbqgBGrbPRf4Q+i81ZCJ1xRNQLnuvbrzRkeCT0GBRk=;
 b=xVAcS4cnlpjQsJDWLeRz+OzmlDzB3mJIKDEfA28Jxs9i4Blua3zu46Ez68CuposqGojXj8lFr
 i0AaiosyEqlA/eLDTdsQaxcIRmCkxzuZMPlHWfar/mjara7QNlEQQRI
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This will be useful to introduce variants in tests to test the
interactions between HID-BPF and some kernel modules.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/hid_bpf.c    |  2 +-
 tools/testing/selftests/hid/hid_common.h | 46 ++++++++++++++++++++------------
 tools/testing/selftests/hid/hidraw.c     |  2 +-
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 17ccbf5ff4b5..7eb15da62bdc 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -58,7 +58,7 @@ FIXTURE_SETUP(hid_bpf)
 {
 	int err;
 
-	err = setup_uhid(_metadata, &self->hid);
+	err = setup_uhid(_metadata, &self->hid, BUS_USB, 0x0001, 0x0a36, rdesc, sizeof(rdesc));
 	ASSERT_OK(err);
 }
 
diff --git a/tools/testing/selftests/hid/hid_common.h b/tools/testing/selftests/hid/hid_common.h
index a7d836a35bb1..f77f69c6657d 100644
--- a/tools/testing/selftests/hid/hid_common.h
+++ b/tools/testing/selftests/hid/hid_common.h
@@ -23,6 +23,9 @@ struct uhid_device {
 	int dev_id;		/* uniq (random) number to identify the device */
 	int uhid_fd;
 	int hid_id;		/* HID device id in the system */
+	__u16 bus;
+	__u32 vid;
+	__u32 pid;
 	pthread_t tid;		/* thread for reading uhid events */
 };
 
@@ -129,7 +132,9 @@ static int uhid_write(struct __test_metadata *_metadata, int fd, const struct uh
 	}
 }
 
-static int uhid_create(struct __test_metadata *_metadata, int fd, int rand_nb)
+static int uhid_create(struct __test_metadata *_metadata, int fd, int rand_nb,
+		       __u16 bus, __u32 vid, __u32 pid, __u8 *rdesc,
+		       size_t rdesc_size)
 {
 	struct uhid_event ev;
 	char buf[25];
@@ -140,10 +145,10 @@ static int uhid_create(struct __test_metadata *_metadata, int fd, int rand_nb)
 	ev.type = UHID_CREATE;
 	strcpy((char *)ev.u.create.name, buf);
 	ev.u.create.rd_data = rdesc;
-	ev.u.create.rd_size = sizeof(rdesc);
-	ev.u.create.bus = BUS_USB;
-	ev.u.create.vendor = 0x0001;
-	ev.u.create.product = 0x0a37;
+	ev.u.create.rd_size = rdesc_size;
+	ev.u.create.bus = bus;
+	ev.u.create.vendor = vid;
+	ev.u.create.product = pid;
 	ev.u.create.version = 0;
 	ev.u.create.country = 0;
 
@@ -305,15 +310,17 @@ static int uhid_send_event(struct __test_metadata *_metadata, struct uhid_device
 	return uhid_write(_metadata, hid->uhid_fd, &ev);
 }
 
-static bool match_sysfs_device(int dev_id, const char *workdir, struct dirent *dir)
+static bool match_sysfs_device(struct uhid_device *hid, const char *workdir, struct dirent *dir)
 {
-	const char *target = "0003:0001:0A37.*";
+	char target[20] = "";
 	char phys[512];
 	char uevent[1024];
 	char temp[512];
 	int fd, nread;
 	bool found = false;
 
+	snprintf(target, sizeof(target), "%04X:%04X:%04X.*", hid->bus, hid->vid, hid->pid);
+
 	if (fnmatch(target, dir->d_name, 0))
 		return false;
 
@@ -324,7 +331,7 @@ static bool match_sysfs_device(int dev_id, const char *workdir, struct dirent *d
 	if (fd < 0)
 		return false;
 
-	sprintf(phys, "PHYS=%d", dev_id);
+	sprintf(phys, "PHYS=%d", hid->dev_id);
 
 	nread = read(fd, temp, ARRAY_SIZE(temp));
 	if (nread > 0 && (strstr(temp, phys)) != NULL)
@@ -335,7 +342,7 @@ static bool match_sysfs_device(int dev_id, const char *workdir, struct dirent *d
 	return found;
 }
 
-static int get_hid_id(int dev_id)
+static int get_hid_id(struct uhid_device *hid)
 {
 	const char *workdir = "/sys/devices/virtual/misc/uhid";
 	const char *str_id;
@@ -350,10 +357,10 @@ static int get_hid_id(int dev_id)
 		d = opendir(workdir);
 		if (d) {
 			while ((dir = readdir(d)) != NULL) {
-				if (!match_sysfs_device(dev_id, workdir, dir))
+				if (!match_sysfs_device(hid, workdir, dir))
 					continue;
 
-				str_id = dir->d_name + sizeof("0003:0001:0A37.");
+				str_id = dir->d_name + sizeof("0000:0000:0000.");
 				found = (int)strtol(str_id, NULL, 16);
 
 				break;
@@ -367,7 +374,7 @@ static int get_hid_id(int dev_id)
 	return found;
 }
 
-static int get_hidraw(int dev_id)
+static int get_hidraw(struct uhid_device *hid)
 {
 	const char *workdir = "/sys/devices/virtual/misc/uhid";
 	char sysfs[1024];
@@ -384,7 +391,7 @@ static int get_hidraw(int dev_id)
 			continue;
 
 		while ((dir = readdir(d)) != NULL) {
-			if (!match_sysfs_device(dev_id, workdir, dir))
+			if (!match_sysfs_device(hid, workdir, dir))
 				continue;
 
 			sprintf(sysfs, "%s/%s/hidraw", workdir, dir->d_name);
@@ -416,7 +423,7 @@ static int open_hidraw(struct uhid_device *hid)
 	int hidraw_number;
 	char hidraw_path[64] = { 0 };
 
-	hidraw_number = get_hidraw(hid->dev_id);
+	hidraw_number = get_hidraw(hid);
 	if (hidraw_number < 0)
 		return hidraw_number;
 
@@ -425,7 +432,8 @@ static int open_hidraw(struct uhid_device *hid)
 	return open(hidraw_path, O_RDWR | O_NONBLOCK);
 }
 
-static int setup_uhid(struct __test_metadata *_metadata, struct uhid_device *hid)
+static int setup_uhid(struct __test_metadata *_metadata, struct uhid_device *hid,
+		      __u16 bus, __u32 vid, __u32 pid, const __u8 *rdesc, size_t rdesc_size)
 {
 	const char *path = "/dev/uhid";
 	time_t t;
@@ -435,11 +443,15 @@ static int setup_uhid(struct __test_metadata *_metadata, struct uhid_device *hid
 	srand((unsigned int)time(&t));
 
 	hid->dev_id = rand() % 1024;
+	hid->bus = bus;
+	hid->vid = vid;
+	hid->pid = pid;
 
 	hid->uhid_fd = open(path, O_RDWR | O_CLOEXEC);
 	ASSERT_GE(hid->uhid_fd, 0) TH_LOG("open uhid-cdev failed; %d", hid->uhid_fd);
 
-	ret = uhid_create(_metadata, hid->uhid_fd, hid->dev_id);
+	ret = uhid_create(_metadata, hid->uhid_fd, hid->dev_id, bus, vid, pid,
+			  (__u8 *)rdesc, rdesc_size);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("create uhid device failed: %d", ret);
 		close(hid->uhid_fd);
@@ -447,7 +459,7 @@ static int setup_uhid(struct __test_metadata *_metadata, struct uhid_device *hid
 	}
 
 	/* locate the uevent file of the created device */
-	hid->hid_id = get_hid_id(hid->dev_id);
+	hid->hid_id = get_hid_id(hid);
 	ASSERT_GT(hid->hid_id, 0)
 		TH_LOG("Could not locate uhid device id: %d", hid->hid_id);
 
diff --git a/tools/testing/selftests/hid/hidraw.c b/tools/testing/selftests/hid/hidraw.c
index 5934818b2036..821db37ba4bb 100644
--- a/tools/testing/selftests/hid/hidraw.c
+++ b/tools/testing/selftests/hid/hidraw.c
@@ -36,7 +36,7 @@ FIXTURE_SETUP(hidraw)
 {
 	int err;
 
-	err = setup_uhid(_metadata, &self->hid);
+	err = setup_uhid(_metadata, &self->hid, BUS_USB, 0x0001, 0x0a37, rdesc, sizeof(rdesc));
 	ASSERT_OK(err);
 
 	self->hidraw_fd = open_hidraw(&self->hid);

-- 
2.46.0


