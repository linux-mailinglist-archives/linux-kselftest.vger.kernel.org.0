Return-Path: <linux-kselftest+bounces-17594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF051973A56
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301B51F254BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDB01A08C4;
	Tue, 10 Sep 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrhUvZhx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C21A08B0;
	Tue, 10 Sep 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979443; cv=none; b=aaIgXIQiPoMoQMjoZtB0m2X7mJpO2vgmUi4RaqrLDitcAaDF5ZdvzsYQWV46Sm4mtRbSyyDRDFPubbMV2sSIoweFtSXh/l7VSFDnh5kqdEXNjMgd+QeYzcHvMO9q5GELBfHfiHuV7Mt1ZODLDOvkj/g05UVXrv5Bsg+q90tePWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979443; c=relaxed/simple;
	bh=htugAPk+PkAXQlk8Fs9wvuB/VI+A0TtvtJjDu1Tu61s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4EY3Iym6xQG1Tp3nUiFlBttC+5o+DI7R3AwJ9uceImiQpb+lBQQ5tsYCs0XjyepyBZJ7dZuWCBUAsv+1qsZvTFIsIMNnwjJI3r/qkVxUxmCk9bFL//hRsMiKO+sJU+0f87EQ2KX5i7ilIr95H7sfk75pMisBoaaR036wOSzJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrhUvZhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A64FC4CED0;
	Tue, 10 Sep 2024 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979443;
	bh=htugAPk+PkAXQlk8Fs9wvuB/VI+A0TtvtJjDu1Tu61s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DrhUvZhxdINERtmj+7Bp2zSJ7bfnv3p4qxwIjuLtpSnpdInyDZwGXaXII0S4S7IqX
	 lJoRojAx+KXW269q94fcJR+2gMysLYxqkkuEc5/uCER5lQ/CgvcslVxBUZDPVjoTn5
	 WDxrH9L7uNtB0GSdQ6Z8D4C35zZ29oxAaQWYBEZVljNF0xtMAs33dRZmYqPf1oVn3g
	 qoQ8+O6ttqvu3/1miSPOroCJROcSB5s+U4NE0zbE9f1kfa5KDHBs9JdjoSkw16528S
	 2SJufzQd7iAKh4cpPK5AJRIhDIKLe292vzWnPIhOFJD1Yjj/ZLJfjsX+G+kkaorOU+
	 IVdY7rqf76GSA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 10 Sep 2024 23:43:42 +0900
Subject: [PATCH HID v2 06/11] selftests/hid: cleanup C tests by adding a
 common struct uhid_device
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-hid-bpf-hid-generic-v2-6-083dfc189e97@kernel.org>
References: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
In-Reply-To: <20240910-hid-bpf-hid-generic-v2-0-083dfc189e97@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, Vicki Pfau <vi@endrift.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725979428; l=15743;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=htugAPk+PkAXQlk8Fs9wvuB/VI+A0TtvtJjDu1Tu61s=;
 b=9U53oWpImgp1DdNSN1dtz0yxi3FDRxDfEX0ORSk1x/HrMaiXJH58xZN6eXkJWI1LiR7SJ29jW
 93csPyZkSiPDqYOHgj5eJiroTEfLgsW7FHxRq8jlam3i3tKWMdyzSiO
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Allows to have an abstract class uhid_device which handles all of the
uhid part without having to mess up with individual fds.

struct attach_prog_args is now never used in hid_bpf.c, so drop it as well

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/hid_bpf.c    | 77 +++++++++++---------------------
 tools/testing/selftests/hid/hid_common.h | 74 ++++++++++++++++++++----------
 tools/testing/selftests/hid/hidraw.c     | 36 +++++----------
 3 files changed, 87 insertions(+), 100 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index d10cf6883683..17ccbf5ff4b5 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -4,13 +4,6 @@
 #include "hid_common.h"
 #include <bpf/bpf.h>
 
-struct attach_prog_args {
-	int prog_fd;
-	unsigned int hid;
-	int retval;
-	int insert_head;
-};
-
 struct hid_hw_request_syscall_args {
 	__u8 data[10];
 	unsigned int hid;
@@ -21,11 +14,8 @@ struct hid_hw_request_syscall_args {
 };
 
 FIXTURE(hid_bpf) {
-	int dev_id;
-	int uhid_fd;
+	struct uhid_device hid;
 	int hidraw_fd;
-	int hid_id;
-	pthread_t tid;
 	struct hid *skel;
 	struct bpf_link *hid_links[3]; /* max number of programs loaded in a single test */
 };
@@ -54,10 +44,10 @@ static void detach_bpf(FIXTURE_DATA(hid_bpf) * self)
 FIXTURE_TEARDOWN(hid_bpf) {
 	void *uhid_err;
 
-	uhid_destroy(_metadata, self->uhid_fd);
+	uhid_destroy(_metadata, &self->hid);
 
 	detach_bpf(self);
-	pthread_join(self->tid, &uhid_err);
+	pthread_join(self->hid.tid, &uhid_err);
 }
 #define TEARDOWN_LOG(fmt, ...) do { \
 	TH_LOG(fmt, ##__VA_ARGS__); \
@@ -66,23 +56,10 @@ FIXTURE_TEARDOWN(hid_bpf) {
 
 FIXTURE_SETUP(hid_bpf)
 {
-	time_t t;
 	int err;
 
-	/* initialize random number generator */
-	srand((unsigned int)time(&t));
-
-	self->dev_id = rand() % 1024;
-
-	self->uhid_fd = setup_uhid(_metadata, self->dev_id);
-
-	/* locate the uev, self, variant);ent file of the created device */
-	self->hid_id = get_hid_id(self->dev_id);
-	ASSERT_GT(self->hid_id, 0)
-		TEARDOWN_LOG("Could not locate uhid device id: %d", self->hid_id);
-
-	err = uhid_start_listener(_metadata, &self->tid, self->uhid_fd);
-	ASSERT_EQ(0, err) TEARDOWN_LOG("could not start udev listener: %d", err);
+	err = setup_uhid(_metadata, &self->hid);
+	ASSERT_OK(err);
 }
 
 struct test_program {
@@ -129,7 +106,7 @@ static void load_programs(const struct test_program programs[],
 		ops_hid_id = bpf_map__initial_value(map, NULL);
 		ASSERT_OK_PTR(ops_hid_id) TH_LOG("unable to retrieve struct_ops data");
 
-		*ops_hid_id = self->hid_id;
+		*ops_hid_id = self->hid.hid_id;
 	}
 
 	/* we disable the auto-attach feature of all maps because we
@@ -157,7 +134,7 @@ static void load_programs(const struct test_program programs[],
 
 	hid__attach(self->skel);
 
-	self->hidraw_fd = open_hidraw(self->dev_id);
+	self->hidraw_fd = open_hidraw(&self->hid);
 	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
 }
 
@@ -192,7 +169,7 @@ TEST_F(hid_bpf, raw_event)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* check that hid_first_event() was executed */
 	ASSERT_EQ(self->skel->data->callback_check, 42) TH_LOG("callback_check1");
@@ -208,7 +185,7 @@ TEST_F(hid_bpf, raw_event)
 	memset(buf, 0, sizeof(buf));
 	buf[0] = 1;
 	buf[1] = 47;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* check that hid_first_event() was executed */
 	ASSERT_EQ(self->skel->data->callback_check, 47) TH_LOG("callback_check1");
@@ -239,7 +216,7 @@ TEST_F(hid_bpf, subprog_raw_event)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -252,7 +229,7 @@ TEST_F(hid_bpf, subprog_raw_event)
 	memset(buf, 0, sizeof(buf));
 	buf[0] = 1;
 	buf[1] = 47;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -303,7 +280,7 @@ TEST_F(hid_bpf, test_attach_detach)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -326,14 +303,14 @@ TEST_F(hid_bpf, test_attach_detach)
 	/* detach the program */
 	detach_bpf(self);
 
-	self->hidraw_fd = open_hidraw(self->dev_id);
+	self->hidraw_fd = open_hidraw(&self->hid);
 	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
 
 	/* inject another event */
 	memset(buf, 0, sizeof(buf));
 	buf[0] = 1;
 	buf[1] = 47;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -352,7 +329,7 @@ TEST_F(hid_bpf, test_attach_detach)
 	memset(buf, 0, sizeof(buf));
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -382,7 +359,7 @@ TEST_F(hid_bpf, test_hid_change_report)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -412,7 +389,7 @@ TEST_F(hid_bpf, test_hid_user_input_report_call)
 
 	LOAD_BPF;
 
-	args.hid = self->hid_id;
+	args.hid = self->hid.hid_id;
 	args.data[0] = 1; /* report ID */
 	args.data[1] = 2; /* report ID */
 	args.data[2] = 42; /* report ID */
@@ -458,7 +435,7 @@ TEST_F(hid_bpf, test_hid_user_output_report_call)
 
 	LOAD_BPF;
 
-	args.hid = self->hid_id;
+	args.hid = self->hid.hid_id;
 	args.data[0] = 1; /* report ID */
 	args.data[1] = 2; /* report ID */
 	args.data[2] = 42; /* report ID */
@@ -506,7 +483,7 @@ TEST_F(hid_bpf, test_hid_user_raw_request_call)
 
 	LOAD_BPF;
 
-	args.hid = self->hid_id;
+	args.hid = self->hid.hid_id;
 	args.data[0] = 1; /* report ID */
 
 	prog_fd = bpf_program__fd(self->skel->progs.hid_user_raw_request);
@@ -539,7 +516,7 @@ TEST_F(hid_bpf, test_hid_filter_raw_request_call)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -565,7 +542,7 @@ TEST_F(hid_bpf, test_hid_filter_raw_request_call)
 	/* detach the program */
 	detach_bpf(self);
 
-	self->hidraw_fd = open_hidraw(self->dev_id);
+	self->hidraw_fd = open_hidraw(&self->hid);
 	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
 
 	err = ioctl(self->hidraw_fd, HIDIOCGFEATURE(sizeof(buf)), buf);
@@ -641,7 +618,7 @@ TEST_F(hid_bpf, test_hid_filter_output_report_call)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -667,7 +644,7 @@ TEST_F(hid_bpf, test_hid_filter_output_report_call)
 	/* detach the program */
 	detach_bpf(self);
 
-	self->hidraw_fd = open_hidraw(self->dev_id);
+	self->hidraw_fd = open_hidraw(&self->hid);
 	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
 
 	err = write(self->hidraw_fd, buf, 3);
@@ -742,7 +719,7 @@ TEST_F(hid_bpf, test_multiply_events_wq)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -780,7 +757,7 @@ TEST_F(hid_bpf, test_multiply_events)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -816,7 +793,7 @@ TEST_F(hid_bpf, test_hid_infinite_loop_input_report_call)
 	buf[1] = 2;
 	buf[2] = 42;
 
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -867,7 +844,7 @@ TEST_F(hid_bpf, test_hid_attach_flags)
 
 	/* inject one event */
 	buf[0] = 1;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
diff --git a/tools/testing/selftests/hid/hid_common.h b/tools/testing/selftests/hid/hid_common.h
index f151f151a1ed..a7d836a35bb1 100644
--- a/tools/testing/selftests/hid/hid_common.h
+++ b/tools/testing/selftests/hid/hid_common.h
@@ -19,6 +19,13 @@
 	__typeof__(b) _b = (b); \
 	_a < _b ? _a : _b; })
 
+struct uhid_device {
+	int dev_id;		/* uniq (random) number to identify the device */
+	int uhid_fd;
+	int hid_id;		/* HID device id in the system */
+	pthread_t tid;		/* thread for reading uhid events */
+};
+
 static unsigned char rdesc[] = {
 	0x06, 0x00, 0xff,	/* Usage Page (Vendor Defined Page 1) */
 	0x09, 0x21,		/* Usage (Vendor Usage 0x21) */
@@ -146,14 +153,14 @@ static int uhid_create(struct __test_metadata *_metadata, int fd, int rand_nb)
 	return uhid_write(_metadata, fd, &ev);
 }
 
-static void uhid_destroy(struct __test_metadata *_metadata, int fd)
+static void uhid_destroy(struct __test_metadata *_metadata, struct uhid_device *hid)
 {
 	struct uhid_event ev;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_DESTROY;
 
-	uhid_write(_metadata, fd, &ev);
+	uhid_write(_metadata, hid->uhid_fd, &ev);
 }
 
 static int uhid_event(struct __test_metadata *_metadata, int fd)
@@ -281,7 +288,8 @@ static int uhid_start_listener(struct __test_metadata *_metadata, pthread_t *tid
 	return 0;
 }
 
-static int uhid_send_event(struct __test_metadata *_metadata, int fd, __u8 *buf, size_t size)
+static int uhid_send_event(struct __test_metadata *_metadata, struct uhid_device *hid,
+			   __u8 *buf, size_t size)
 {
 	struct uhid_event ev;
 
@@ -294,25 +302,7 @@ static int uhid_send_event(struct __test_metadata *_metadata, int fd, __u8 *buf,
 
 	memcpy(ev.u.input2.data, buf, size);
 
-	return uhid_write(_metadata, fd, &ev);
-}
-
-static int setup_uhid(struct __test_metadata *_metadata, int rand_nb)
-{
-	int fd;
-	const char *path = "/dev/uhid";
-	int ret;
-
-	fd = open(path, O_RDWR | O_CLOEXEC);
-	ASSERT_GE(fd, 0) TH_LOG("open uhid-cdev failed; %d", fd);
-
-	ret = uhid_create(_metadata, fd, rand_nb);
-	ASSERT_EQ(0, ret) {
-		TH_LOG("create uhid device failed: %d", ret);
-		close(fd);
-	}
-
-	return fd;
+	return uhid_write(_metadata, hid->uhid_fd, &ev);
 }
 
 static bool match_sysfs_device(int dev_id, const char *workdir, struct dirent *dir)
@@ -421,12 +411,12 @@ static int get_hidraw(int dev_id)
 	return found;
 }
 
-static int open_hidraw(int dev_id)
+static int open_hidraw(struct uhid_device *hid)
 {
 	int hidraw_number;
 	char hidraw_path[64] = { 0 };
 
-	hidraw_number = get_hidraw(dev_id);
+	hidraw_number = get_hidraw(hid->dev_id);
 	if (hidraw_number < 0)
 		return hidraw_number;
 
@@ -434,3 +424,39 @@ static int open_hidraw(int dev_id)
 	sprintf(hidraw_path, "/dev/hidraw%d", hidraw_number);
 	return open(hidraw_path, O_RDWR | O_NONBLOCK);
 }
+
+static int setup_uhid(struct __test_metadata *_metadata, struct uhid_device *hid)
+{
+	const char *path = "/dev/uhid";
+	time_t t;
+	int ret;
+
+	/* initialize random number generator */
+	srand((unsigned int)time(&t));
+
+	hid->dev_id = rand() % 1024;
+
+	hid->uhid_fd = open(path, O_RDWR | O_CLOEXEC);
+	ASSERT_GE(hid->uhid_fd, 0) TH_LOG("open uhid-cdev failed; %d", hid->uhid_fd);
+
+	ret = uhid_create(_metadata, hid->uhid_fd, hid->dev_id);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("create uhid device failed: %d", ret);
+		close(hid->uhid_fd);
+		return ret;
+	}
+
+	/* locate the uevent file of the created device */
+	hid->hid_id = get_hid_id(hid->dev_id);
+	ASSERT_GT(hid->hid_id, 0)
+		TH_LOG("Could not locate uhid device id: %d", hid->hid_id);
+
+	ret = uhid_start_listener(_metadata, &hid->tid, hid->uhid_fd);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("could not start udev listener: %d", ret);
+		close(hid->uhid_fd);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/hid/hidraw.c b/tools/testing/selftests/hid/hidraw.c
index f8b4f7ff292c..5934818b2036 100644
--- a/tools/testing/selftests/hid/hidraw.c
+++ b/tools/testing/selftests/hid/hidraw.c
@@ -9,11 +9,8 @@
 #endif /* HIDIOCREVOKE */
 
 FIXTURE(hidraw) {
-	int dev_id;
-	int uhid_fd;
+	struct uhid_device hid;
 	int hidraw_fd;
-	int hid_id;
-	pthread_t tid;
 };
 static void close_hidraw(FIXTURE_DATA(hidraw) * self)
 {
@@ -25,10 +22,10 @@ static void close_hidraw(FIXTURE_DATA(hidraw) * self)
 FIXTURE_TEARDOWN(hidraw) {
 	void *uhid_err;
 
-	uhid_destroy(_metadata, self->uhid_fd);
+	uhid_destroy(_metadata, &self->hid);
 
 	close_hidraw(self);
-	pthread_join(self->tid, &uhid_err);
+	pthread_join(self->hid.tid, &uhid_err);
 }
 #define TEARDOWN_LOG(fmt, ...) do { \
 	TH_LOG(fmt, ##__VA_ARGS__); \
@@ -37,25 +34,12 @@ FIXTURE_TEARDOWN(hidraw) {
 
 FIXTURE_SETUP(hidraw)
 {
-	time_t t;
 	int err;
 
-	/* initialize random number generator */
-	srand((unsigned int)time(&t));
+	err = setup_uhid(_metadata, &self->hid);
+	ASSERT_OK(err);
 
-	self->dev_id = rand() % 1024;
-
-	self->uhid_fd = setup_uhid(_metadata, self->dev_id);
-
-	/* locate the uev, self, variant);ent file of the created device */
-	self->hid_id = get_hid_id(self->dev_id);
-	ASSERT_GT(self->hid_id, 0)
-		TEARDOWN_LOG("Could not locate uhid device id: %d", self->hid_id);
-
-	err = uhid_start_listener(_metadata, &self->tid, self->uhid_fd);
-	ASSERT_EQ(0, err) TEARDOWN_LOG("could not start udev listener: %d", err);
-
-	self->hidraw_fd = open_hidraw(self->dev_id);
+	self->hidraw_fd = open_hidraw(&self->hid);
 	ASSERT_GE(self->hidraw_fd, 0) TH_LOG("open_hidraw");
 }
 
@@ -79,7 +63,7 @@ TEST_F(hidraw, raw_event)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -101,7 +85,7 @@ TEST_F(hidraw, raw_event_revoked)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -117,7 +101,7 @@ TEST_F(hidraw, raw_event_revoked)
 	/* inject one other event */
 	buf[0] = 1;
 	buf[1] = 43;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	/* read the data from hidraw */
 	memset(buf, 0, sizeof(buf));
@@ -161,7 +145,7 @@ TEST_F(hidraw, poll_revoked)
 	/* inject one event */
 	buf[0] = 1;
 	buf[1] = 42;
-	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+	uhid_send_event(_metadata, &self->hid, buf, 6);
 
 	while (true) {
 		ready = poll(pfds, 1, 5000);

-- 
2.46.0


