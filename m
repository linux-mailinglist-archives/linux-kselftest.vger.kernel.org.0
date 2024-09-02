Return-Path: <linux-kselftest+bounces-16993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA442968BCB
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4966CB21003
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847291C62C4;
	Mon,  2 Sep 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loB/Gxmw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F41A3054;
	Mon,  2 Sep 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293708; cv=none; b=IdgQNyU21OOpKMKO0I3MMABeE/lA2vWn8qqYoK60rfuaMr4a8GnvMP4/T8ZSmbZZrqWh+/tBvxFO6EZpTpiwBwVWhhBtmx2CoqmEjtL90KhJTvEDfJeRI8Xvr/5uUm435vJY/b7gFSj/ISrL/ygsA0oO3SO7o9wTBi2EaTWEW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293708; c=relaxed/simple;
	bh=m3oIMhADAyQVl7YG192CntrtfP5ma8pR8cYemrmggas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUjTYN60k3ka5wLJy2fkmhUjFrPc5oG6KoULJgQ/n9+2WHVXyhplJo54+F2BfOVeSw7QBuY0jvhhh1UywbeX932spv95cdo1k8zQ68JVjdTTjfEPioZSxDwfMs4pCEtgwHx/KZLoEdLAJRKSccTRfkaHMPsaewkvucUCfEM293I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loB/Gxmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D35C4AF0C;
	Mon,  2 Sep 2024 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725293707;
	bh=m3oIMhADAyQVl7YG192CntrtfP5ma8pR8cYemrmggas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=loB/GxmwOtF5z32lB/3pMgIOOo1Af9xpDtR1joh8m7eYujKSGxcHmksk8T8ZXWAp2
	 tS+rC+AzjngE2js4MJAD25IiypKo0g+bnuAPjxYwKFhbbo9FMi9xFavoaG/xHLXPU3
	 u2ZVtfqJwZ5clid3HoRIwT2KSW4mu6ZB2DGjyN16q5RCgHdtj99F0GRQeO9t+rPafl
	 FvQtLNjTEeLDcxgrfH88dgTz+c6pYV2YyZ6us+lbaBN7vNtwQfl6J6HCQm4idhnftv
	 a+ZA3WxlC6nJimanwU5iT1MrnWjut96ZXmQuQFiLKR4rdkxERYlCdTStXSXAVr4vvd
	 SaWXYOhjGkbCg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 03 Sep 2024 01:14:33 +0900
Subject: [PATCH HID 3/7] selftests/hid: allow to parametrize
 bus/vid/pid/rdesc on the test device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-hid-bpf-hid-generic-v1-3-9511a565b2da@kernel.org>
References: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
In-Reply-To: <20240903-hid-bpf-hid-generic-v1-0-9511a565b2da@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725293696; l=6724;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=m3oIMhADAyQVl7YG192CntrtfP5ma8pR8cYemrmggas=;
 b=9w7NTjxpXke9Lh2zyhCvbNuWEz7EAHjD6CGznUXqa6d93rfQm+R3qsqaxbOjQJ9UNIMQ5CNxl
 wyVYKW1ottWAmNMMllv54ds4NA068yLcO3DL0hx+0QOYVRI2RJtno0o
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This will be useful to introduce variants in tests to test the
interactions between HID-BPF and some kernel modules.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
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


