Return-Path: <linux-kselftest+bounces-16378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B896043A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C575F2836CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E6198E92;
	Tue, 27 Aug 2024 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp3sl96t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8784198E71;
	Tue, 27 Aug 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746790; cv=none; b=ieUmrV0PaZv2SWfijogS9nYxFUqTSU3FFrQyBvujQ58jHgJdhIRSF0llwlra2z2Tz7qMeb7DAncSl7AmOg0OMwfJJ/IgKr0dVz23KltLOksHG5quqPht6IIGHQGCD+o8dgdGgf4VCoazCaMmeZoDwdQbo6nVspa8GdGUBKVsZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746790; c=relaxed/simple;
	bh=v01kH2TqKohHdf3H7z/Zl0IaXehTrE5i0vq7/wDKAgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYSfGs3wdBro1/QIXaooUPBymP6INjAtvBsqjIn4NJdS7oA2R0xaHr0XUpYKVzI2v3gsqmn7vtTMtdxyfNiVV73zBT/qaWj+Vnv0QzsijG9usdTkp9jGdmf26Jd1cNllM0b0Nk3SELxYWeReQSzYfnevHL14ETtrc77+Jkf9mTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp3sl96t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D662BC58120;
	Tue, 27 Aug 2024 08:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724746790;
	bh=v01kH2TqKohHdf3H7z/Zl0IaXehTrE5i0vq7/wDKAgg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fp3sl96tgJkcNYzfROyvsJ1hDGtK1W7era15cum/plm6oms9gefzthm5ptHPjltTx
	 0TkPNv8m6ZZ3C4F8pXiBa/9wfCKHL+XPzZtFyWOtMR21OKxyHmJXS663qecJOCCr0u
	 +Wa6UHHvr3NhwxvEDi9hJIqGDCzFjkCGqYAp2N/FqeyitpROK+H0sJwwcs8pg0ZW/3
	 xW5Wzr4nJA14LJDw/hFsEVHidSkAKmIhuG9MxDR8LSL/g63XhHyeIgrob1VwiaQOdW
	 6W352BPmIYkxKiG49CgdyV7FBKtprdvaTFIPnj0mZk8aMxtSMfWRfCTN+s2NuLabzD
	 aRbw+wL6yCNQQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 27 Aug 2024 17:19:30 +0900
Subject: [PATCH v5 2/4] selftests/hid: extract the utility part of
 hid_bpf.c into its own header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-hidraw-revoke-v5-2-d004a7451aea@kernel.org>
References: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
In-Reply-To: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724746785; l=24710;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=v01kH2TqKohHdf3H7z/Zl0IaXehTrE5i0vq7/wDKAgg=;
 b=69vbyAvootVCGrDaWs1UndqLQhx6Yuoc45s/DhoR1wKUg2BegXXe+d7WouPYk6VKtgOmUMNsV
 kjsY+0lAdeXD/jlzP3E2BMz7UIS5t6bAj+air1HgyfNtxc+GEG9weir
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

When adding new tests programs, we need the same mechanics to create
new virtual devices, and read from their matching hidraw node.

Extract the common part into its own header so we can easily add new
tests C-files.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v5
---
 tools/testing/selftests/hid/hid_bpf.c    | 437 +------------------------------
 tools/testing/selftests/hid/hid_common.h | 436 ++++++++++++++++++++++++++++++
 2 files changed, 438 insertions(+), 435 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 75b7b4ef6cfa..d10cf6883683 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -1,93 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2022 Red Hat */
+/* Copyright (c) 2022-2024 Red Hat */
 #include "hid.skel.h"
-
-#include "../kselftest_harness.h"
-
+#include "hid_common.h"
 #include <bpf/bpf.h>
-#include <fcntl.h>
-#include <fnmatch.h>
-#include <dirent.h>
-#include <poll.h>
-#include <pthread.h>
-#include <stdbool.h>
-#include <linux/hidraw.h>
-#include <linux/uhid.h>
-
-#define SHOW_UHID_DEBUG 0
-
-#define min(a, b) \
-	({ __typeof__(a) _a = (a); \
-	__typeof__(b) _b = (b); \
-	_a < _b ? _a : _b; })
-
-static unsigned char rdesc[] = {
-	0x06, 0x00, 0xff,	/* Usage Page (Vendor Defined Page 1) */
-	0x09, 0x21,		/* Usage (Vendor Usage 0x21) */
-	0xa1, 0x01,		/* COLLECTION (Application) */
-	0x09, 0x01,			/* Usage (Vendor Usage 0x01) */
-	0xa1, 0x00,			/* COLLECTION (Physical) */
-	0x85, 0x02,				/* REPORT_ID (2) */
-	0x19, 0x01,				/* USAGE_MINIMUM (1) */
-	0x29, 0x08,				/* USAGE_MAXIMUM (3) */
-	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
-	0x25, 0xff,				/* LOGICAL_MAXIMUM (255) */
-	0x95, 0x08,				/* REPORT_COUNT (8) */
-	0x75, 0x08,				/* REPORT_SIZE (8) */
-	0x81, 0x02,				/* INPUT (Data,Var,Abs) */
-	0xc0,				/* END_COLLECTION */
-	0x09, 0x01,			/* Usage (Vendor Usage 0x01) */
-	0xa1, 0x00,			/* COLLECTION (Physical) */
-	0x85, 0x01,				/* REPORT_ID (1) */
-	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
-	0x19, 0x01,				/* USAGE_MINIMUM (1) */
-	0x29, 0x03,				/* USAGE_MAXIMUM (3) */
-	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
-	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
-	0x95, 0x03,				/* REPORT_COUNT (3) */
-	0x75, 0x01,				/* REPORT_SIZE (1) */
-	0x81, 0x02,				/* INPUT (Data,Var,Abs) */
-	0x95, 0x01,				/* REPORT_COUNT (1) */
-	0x75, 0x05,				/* REPORT_SIZE (5) */
-	0x81, 0x01,				/* INPUT (Cnst,Var,Abs) */
-	0x05, 0x01,				/* USAGE_PAGE (Generic Desktop) */
-	0x09, 0x30,				/* USAGE (X) */
-	0x09, 0x31,				/* USAGE (Y) */
-	0x15, 0x81,				/* LOGICAL_MINIMUM (-127) */
-	0x25, 0x7f,				/* LOGICAL_MAXIMUM (127) */
-	0x75, 0x10,				/* REPORT_SIZE (16) */
-	0x95, 0x02,				/* REPORT_COUNT (2) */
-	0x81, 0x06,				/* INPUT (Data,Var,Rel) */
-
-	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
-	0x19, 0x01,				/* USAGE_MINIMUM (1) */
-	0x29, 0x03,				/* USAGE_MAXIMUM (3) */
-	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
-	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
-	0x95, 0x03,				/* REPORT_COUNT (3) */
-	0x75, 0x01,				/* REPORT_SIZE (1) */
-	0x91, 0x02,				/* Output (Data,Var,Abs) */
-	0x95, 0x01,				/* REPORT_COUNT (1) */
-	0x75, 0x05,				/* REPORT_SIZE (5) */
-	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
-
-	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
-	0x19, 0x06,				/* USAGE_MINIMUM (6) */
-	0x29, 0x08,				/* USAGE_MAXIMUM (8) */
-	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
-	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
-	0x95, 0x03,				/* REPORT_COUNT (3) */
-	0x75, 0x01,				/* REPORT_SIZE (1) */
-	0xb1, 0x02,				/* Feature (Data,Var,Abs) */
-	0x95, 0x01,				/* REPORT_COUNT (1) */
-	0x75, 0x05,				/* REPORT_SIZE (5) */
-	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
-
-	0xc0,				/* END_COLLECTION */
-	0xc0,			/* END_COLLECTION */
-};
-
-static __u8 feature_data[] = { 1, 2 };
 
 struct attach_prog_args {
 	int prog_fd;
@@ -105,354 +20,6 @@ struct hid_hw_request_syscall_args {
 	__u8 request_type;
 };
 
-#define ASSERT_OK(data) ASSERT_FALSE(data)
-#define ASSERT_OK_PTR(ptr) ASSERT_NE(NULL, ptr)
-
-#define UHID_LOG(fmt, ...) do { \
-	if (SHOW_UHID_DEBUG) \
-		TH_LOG(fmt, ##__VA_ARGS__); \
-} while (0)
-
-static pthread_mutex_t uhid_started_mtx = PTHREAD_MUTEX_INITIALIZER;
-static pthread_cond_t uhid_started = PTHREAD_COND_INITIALIZER;
-
-static pthread_mutex_t uhid_output_mtx = PTHREAD_MUTEX_INITIALIZER;
-static pthread_cond_t uhid_output_cond = PTHREAD_COND_INITIALIZER;
-static unsigned char output_report[10];
-
-/* no need to protect uhid_stopped, only one thread accesses it */
-static bool uhid_stopped;
-
-static int uhid_write(struct __test_metadata *_metadata, int fd, const struct uhid_event *ev)
-{
-	ssize_t ret;
-
-	ret = write(fd, ev, sizeof(*ev));
-	if (ret < 0) {
-		TH_LOG("Cannot write to uhid: %m");
-		return -errno;
-	} else if (ret != sizeof(*ev)) {
-		TH_LOG("Wrong size written to uhid: %zd != %zu",
-			ret, sizeof(ev));
-		return -EFAULT;
-	} else {
-		return 0;
-	}
-}
-
-static int uhid_create(struct __test_metadata *_metadata, int fd, int rand_nb)
-{
-	struct uhid_event ev;
-	char buf[25];
-
-	sprintf(buf, "test-uhid-device-%d", rand_nb);
-
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_CREATE;
-	strcpy((char *)ev.u.create.name, buf);
-	ev.u.create.rd_data = rdesc;
-	ev.u.create.rd_size = sizeof(rdesc);
-	ev.u.create.bus = BUS_USB;
-	ev.u.create.vendor = 0x0001;
-	ev.u.create.product = 0x0a37;
-	ev.u.create.version = 0;
-	ev.u.create.country = 0;
-
-	sprintf(buf, "%d", rand_nb);
-	strcpy((char *)ev.u.create.phys, buf);
-
-	return uhid_write(_metadata, fd, &ev);
-}
-
-static void uhid_destroy(struct __test_metadata *_metadata, int fd)
-{
-	struct uhid_event ev;
-
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_DESTROY;
-
-	uhid_write(_metadata, fd, &ev);
-}
-
-static int uhid_event(struct __test_metadata *_metadata, int fd)
-{
-	struct uhid_event ev, answer;
-	ssize_t ret;
-
-	memset(&ev, 0, sizeof(ev));
-	ret = read(fd, &ev, sizeof(ev));
-	if (ret == 0) {
-		UHID_LOG("Read HUP on uhid-cdev");
-		return -EFAULT;
-	} else if (ret < 0) {
-		UHID_LOG("Cannot read uhid-cdev: %m");
-		return -errno;
-	} else if (ret != sizeof(ev)) {
-		UHID_LOG("Invalid size read from uhid-dev: %zd != %zu",
-			ret, sizeof(ev));
-		return -EFAULT;
-	}
-
-	switch (ev.type) {
-	case UHID_START:
-		pthread_mutex_lock(&uhid_started_mtx);
-		pthread_cond_signal(&uhid_started);
-		pthread_mutex_unlock(&uhid_started_mtx);
-
-		UHID_LOG("UHID_START from uhid-dev");
-		break;
-	case UHID_STOP:
-		uhid_stopped = true;
-
-		UHID_LOG("UHID_STOP from uhid-dev");
-		break;
-	case UHID_OPEN:
-		UHID_LOG("UHID_OPEN from uhid-dev");
-		break;
-	case UHID_CLOSE:
-		UHID_LOG("UHID_CLOSE from uhid-dev");
-		break;
-	case UHID_OUTPUT:
-		UHID_LOG("UHID_OUTPUT from uhid-dev");
-
-		pthread_mutex_lock(&uhid_output_mtx);
-		memcpy(output_report,
-		       ev.u.output.data,
-		       min(ev.u.output.size, sizeof(output_report)));
-		pthread_cond_signal(&uhid_output_cond);
-		pthread_mutex_unlock(&uhid_output_mtx);
-		break;
-	case UHID_GET_REPORT:
-		UHID_LOG("UHID_GET_REPORT from uhid-dev");
-
-		answer.type = UHID_GET_REPORT_REPLY;
-		answer.u.get_report_reply.id = ev.u.get_report.id;
-		answer.u.get_report_reply.err = ev.u.get_report.rnum == 1 ? 0 : -EIO;
-		answer.u.get_report_reply.size = sizeof(feature_data);
-		memcpy(answer.u.get_report_reply.data, feature_data, sizeof(feature_data));
-
-		uhid_write(_metadata, fd, &answer);
-
-		break;
-	case UHID_SET_REPORT:
-		UHID_LOG("UHID_SET_REPORT from uhid-dev");
-		break;
-	default:
-		TH_LOG("Invalid event from uhid-dev: %u", ev.type);
-	}
-
-	return 0;
-}
-
-struct uhid_thread_args {
-	int fd;
-	struct __test_metadata *_metadata;
-};
-static void *uhid_read_events_thread(void *arg)
-{
-	struct uhid_thread_args *args = (struct uhid_thread_args *)arg;
-	struct __test_metadata *_metadata = args->_metadata;
-	struct pollfd pfds[1];
-	int fd = args->fd;
-	int ret = 0;
-
-	pfds[0].fd = fd;
-	pfds[0].events = POLLIN;
-
-	uhid_stopped = false;
-
-	while (!uhid_stopped) {
-		ret = poll(pfds, 1, 100);
-		if (ret < 0) {
-			TH_LOG("Cannot poll for fds: %m");
-			break;
-		}
-		if (pfds[0].revents & POLLIN) {
-			ret = uhid_event(_metadata, fd);
-			if (ret)
-				break;
-		}
-	}
-
-	return (void *)(long)ret;
-}
-
-static int uhid_start_listener(struct __test_metadata *_metadata, pthread_t *tid, int uhid_fd)
-{
-	struct uhid_thread_args args = {
-		.fd = uhid_fd,
-		._metadata = _metadata,
-	};
-	int err;
-
-	pthread_mutex_lock(&uhid_started_mtx);
-	err = pthread_create(tid, NULL, uhid_read_events_thread, (void *)&args);
-	ASSERT_EQ(0, err) {
-		TH_LOG("Could not start the uhid thread: %d", err);
-		pthread_mutex_unlock(&uhid_started_mtx);
-		close(uhid_fd);
-		return -EIO;
-	}
-	pthread_cond_wait(&uhid_started, &uhid_started_mtx);
-	pthread_mutex_unlock(&uhid_started_mtx);
-
-	return 0;
-}
-
-static int uhid_send_event(struct __test_metadata *_metadata, int fd, __u8 *buf, size_t size)
-{
-	struct uhid_event ev;
-
-	if (size > sizeof(ev.u.input.data))
-		return -E2BIG;
-
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_INPUT2;
-	ev.u.input2.size = size;
-
-	memcpy(ev.u.input2.data, buf, size);
-
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
-}
-
-static bool match_sysfs_device(int dev_id, const char *workdir, struct dirent *dir)
-{
-	const char *target = "0003:0001:0A37.*";
-	char phys[512];
-	char uevent[1024];
-	char temp[512];
-	int fd, nread;
-	bool found = false;
-
-	if (fnmatch(target, dir->d_name, 0))
-		return false;
-
-	/* we found the correct VID/PID, now check for phys */
-	sprintf(uevent, "%s/%s/uevent", workdir, dir->d_name);
-
-	fd = open(uevent, O_RDONLY | O_NONBLOCK);
-	if (fd < 0)
-		return false;
-
-	sprintf(phys, "PHYS=%d", dev_id);
-
-	nread = read(fd, temp, ARRAY_SIZE(temp));
-	if (nread > 0 && (strstr(temp, phys)) != NULL)
-		found = true;
-
-	close(fd);
-
-	return found;
-}
-
-static int get_hid_id(int dev_id)
-{
-	const char *workdir = "/sys/devices/virtual/misc/uhid";
-	const char *str_id;
-	DIR *d;
-	struct dirent *dir;
-	int found = -1, attempts = 3;
-
-	/* it would be nice to be able to use nftw, but the no_alu32 target doesn't support it */
-
-	while (found < 0 && attempts > 0) {
-		attempts--;
-		d = opendir(workdir);
-		if (d) {
-			while ((dir = readdir(d)) != NULL) {
-				if (!match_sysfs_device(dev_id, workdir, dir))
-					continue;
-
-				str_id = dir->d_name + sizeof("0003:0001:0A37.");
-				found = (int)strtol(str_id, NULL, 16);
-
-				break;
-			}
-			closedir(d);
-		}
-		if (found < 0)
-			usleep(100000);
-	}
-
-	return found;
-}
-
-static int get_hidraw(int dev_id)
-{
-	const char *workdir = "/sys/devices/virtual/misc/uhid";
-	char sysfs[1024];
-	DIR *d, *subd;
-	struct dirent *dir, *subdir;
-	int i, found = -1;
-
-	/* retry 5 times in case the system is loaded */
-	for (i = 5; i > 0; i--) {
-		usleep(10);
-		d = opendir(workdir);
-
-		if (!d)
-			continue;
-
-		while ((dir = readdir(d)) != NULL) {
-			if (!match_sysfs_device(dev_id, workdir, dir))
-				continue;
-
-			sprintf(sysfs, "%s/%s/hidraw", workdir, dir->d_name);
-
-			subd = opendir(sysfs);
-			if (!subd)
-				continue;
-
-			while ((subdir = readdir(subd)) != NULL) {
-				if (fnmatch("hidraw*", subdir->d_name, 0))
-					continue;
-
-				found = atoi(subdir->d_name + strlen("hidraw"));
-			}
-
-			closedir(subd);
-
-			if (found > 0)
-				break;
-		}
-		closedir(d);
-	}
-
-	return found;
-}
-
-static int open_hidraw(int dev_id)
-{
-	int hidraw_number;
-	char hidraw_path[64] = { 0 };
-
-	hidraw_number = get_hidraw(dev_id);
-	if (hidraw_number < 0)
-		return hidraw_number;
-
-	/* open hidraw node to check the other side of the pipe */
-	sprintf(hidraw_path, "/dev/hidraw%d", hidraw_number);
-	return open(hidraw_path, O_RDWR | O_NONBLOCK);
-}
-
 FIXTURE(hid_bpf) {
 	int dev_id;
 	int uhid_fd;
diff --git a/tools/testing/selftests/hid/hid_common.h b/tools/testing/selftests/hid/hid_common.h
new file mode 100644
index 000000000000..f151f151a1ed
--- /dev/null
+++ b/tools/testing/selftests/hid/hid_common.h
@@ -0,0 +1,436 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022-2024 Red Hat */
+
+#include "../kselftest_harness.h"
+
+#include <fcntl.h>
+#include <fnmatch.h>
+#include <dirent.h>
+#include <poll.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <linux/hidraw.h>
+#include <linux/uhid.h>
+
+#define SHOW_UHID_DEBUG 0
+
+#define min(a, b) \
+	({ __typeof__(a) _a = (a); \
+	__typeof__(b) _b = (b); \
+	_a < _b ? _a : _b; })
+
+static unsigned char rdesc[] = {
+	0x06, 0x00, 0xff,	/* Usage Page (Vendor Defined Page 1) */
+	0x09, 0x21,		/* Usage (Vendor Usage 0x21) */
+	0xa1, 0x01,		/* COLLECTION (Application) */
+	0x09, 0x01,			/* Usage (Vendor Usage 0x01) */
+	0xa1, 0x00,			/* COLLECTION (Physical) */
+	0x85, 0x02,				/* REPORT_ID (2) */
+	0x19, 0x01,				/* USAGE_MINIMUM (1) */
+	0x29, 0x08,				/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0xff,				/* LOGICAL_MAXIMUM (255) */
+	0x95, 0x08,				/* REPORT_COUNT (8) */
+	0x75, 0x08,				/* REPORT_SIZE (8) */
+	0x81, 0x02,				/* INPUT (Data,Var,Abs) */
+	0xc0,				/* END_COLLECTION */
+	0x09, 0x01,			/* Usage (Vendor Usage 0x01) */
+	0xa1, 0x00,			/* COLLECTION (Physical) */
+	0x85, 0x01,				/* REPORT_ID (1) */
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x01,				/* USAGE_MINIMUM (1) */
+	0x29, 0x03,				/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0x81, 0x02,				/* INPUT (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x81, 0x01,				/* INPUT (Cnst,Var,Abs) */
+	0x05, 0x01,				/* USAGE_PAGE (Generic Desktop) */
+	0x09, 0x30,				/* USAGE (X) */
+	0x09, 0x31,				/* USAGE (Y) */
+	0x15, 0x81,				/* LOGICAL_MINIMUM (-127) */
+	0x25, 0x7f,				/* LOGICAL_MAXIMUM (127) */
+	0x75, 0x10,				/* REPORT_SIZE (16) */
+	0x95, 0x02,				/* REPORT_COUNT (2) */
+	0x81, 0x06,				/* INPUT (Data,Var,Rel) */
+
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x01,				/* USAGE_MINIMUM (1) */
+	0x29, 0x03,				/* USAGE_MAXIMUM (3) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0x91, 0x02,				/* Output (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
+
+	0x06, 0x00, 0xff,			/* Usage Page (Vendor Defined Page 1) */
+	0x19, 0x06,				/* USAGE_MINIMUM (6) */
+	0x29, 0x08,				/* USAGE_MAXIMUM (8) */
+	0x15, 0x00,				/* LOGICAL_MINIMUM (0) */
+	0x25, 0x01,				/* LOGICAL_MAXIMUM (1) */
+	0x95, 0x03,				/* REPORT_COUNT (3) */
+	0x75, 0x01,				/* REPORT_SIZE (1) */
+	0xb1, 0x02,				/* Feature (Data,Var,Abs) */
+	0x95, 0x01,				/* REPORT_COUNT (1) */
+	0x75, 0x05,				/* REPORT_SIZE (5) */
+	0x91, 0x01,				/* Output (Cnst,Var,Abs) */
+
+	0xc0,				/* END_COLLECTION */
+	0xc0,			/* END_COLLECTION */
+};
+
+static __u8 feature_data[] = { 1, 2 };
+
+#define ASSERT_OK(data) ASSERT_FALSE(data)
+#define ASSERT_OK_PTR(ptr) ASSERT_NE(NULL, ptr)
+
+#define UHID_LOG(fmt, ...) do { \
+	if (SHOW_UHID_DEBUG) \
+		TH_LOG(fmt, ##__VA_ARGS__); \
+} while (0)
+
+static pthread_mutex_t uhid_started_mtx = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t uhid_started = PTHREAD_COND_INITIALIZER;
+
+static pthread_mutex_t uhid_output_mtx = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t uhid_output_cond = PTHREAD_COND_INITIALIZER;
+static unsigned char output_report[10];
+
+/* no need to protect uhid_stopped, only one thread accesses it */
+static bool uhid_stopped;
+
+static int uhid_write(struct __test_metadata *_metadata, int fd, const struct uhid_event *ev)
+{
+	ssize_t ret;
+
+	ret = write(fd, ev, sizeof(*ev));
+	if (ret < 0) {
+		TH_LOG("Cannot write to uhid: %m");
+		return -errno;
+	} else if (ret != sizeof(*ev)) {
+		TH_LOG("Wrong size written to uhid: %zd != %zu",
+			ret, sizeof(ev));
+		return -EFAULT;
+	} else {
+		return 0;
+	}
+}
+
+static int uhid_create(struct __test_metadata *_metadata, int fd, int rand_nb)
+{
+	struct uhid_event ev;
+	char buf[25];
+
+	sprintf(buf, "test-uhid-device-%d", rand_nb);
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	strcpy((char *)ev.u.create.name, buf);
+	ev.u.create.rd_data = rdesc;
+	ev.u.create.rd_size = sizeof(rdesc);
+	ev.u.create.bus = BUS_USB;
+	ev.u.create.vendor = 0x0001;
+	ev.u.create.product = 0x0a37;
+	ev.u.create.version = 0;
+	ev.u.create.country = 0;
+
+	sprintf(buf, "%d", rand_nb);
+	strcpy((char *)ev.u.create.phys, buf);
+
+	return uhid_write(_metadata, fd, &ev);
+}
+
+static void uhid_destroy(struct __test_metadata *_metadata, int fd)
+{
+	struct uhid_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	uhid_write(_metadata, fd, &ev);
+}
+
+static int uhid_event(struct __test_metadata *_metadata, int fd)
+{
+	struct uhid_event ev, answer;
+	ssize_t ret;
+
+	memset(&ev, 0, sizeof(ev));
+	ret = read(fd, &ev, sizeof(ev));
+	if (ret == 0) {
+		UHID_LOG("Read HUP on uhid-cdev");
+		return -EFAULT;
+	} else if (ret < 0) {
+		UHID_LOG("Cannot read uhid-cdev: %m");
+		return -errno;
+	} else if (ret != sizeof(ev)) {
+		UHID_LOG("Invalid size read from uhid-dev: %zd != %zu",
+			ret, sizeof(ev));
+		return -EFAULT;
+	}
+
+	switch (ev.type) {
+	case UHID_START:
+		pthread_mutex_lock(&uhid_started_mtx);
+		pthread_cond_signal(&uhid_started);
+		pthread_mutex_unlock(&uhid_started_mtx);
+
+		UHID_LOG("UHID_START from uhid-dev");
+		break;
+	case UHID_STOP:
+		uhid_stopped = true;
+
+		UHID_LOG("UHID_STOP from uhid-dev");
+		break;
+	case UHID_OPEN:
+		UHID_LOG("UHID_OPEN from uhid-dev");
+		break;
+	case UHID_CLOSE:
+		UHID_LOG("UHID_CLOSE from uhid-dev");
+		break;
+	case UHID_OUTPUT:
+		UHID_LOG("UHID_OUTPUT from uhid-dev");
+
+		pthread_mutex_lock(&uhid_output_mtx);
+		memcpy(output_report,
+		       ev.u.output.data,
+		       min(ev.u.output.size, sizeof(output_report)));
+		pthread_cond_signal(&uhid_output_cond);
+		pthread_mutex_unlock(&uhid_output_mtx);
+		break;
+	case UHID_GET_REPORT:
+		UHID_LOG("UHID_GET_REPORT from uhid-dev");
+
+		answer.type = UHID_GET_REPORT_REPLY;
+		answer.u.get_report_reply.id = ev.u.get_report.id;
+		answer.u.get_report_reply.err = ev.u.get_report.rnum == 1 ? 0 : -EIO;
+		answer.u.get_report_reply.size = sizeof(feature_data);
+		memcpy(answer.u.get_report_reply.data, feature_data, sizeof(feature_data));
+
+		uhid_write(_metadata, fd, &answer);
+
+		break;
+	case UHID_SET_REPORT:
+		UHID_LOG("UHID_SET_REPORT from uhid-dev");
+		break;
+	default:
+		TH_LOG("Invalid event from uhid-dev: %u", ev.type);
+	}
+
+	return 0;
+}
+
+struct uhid_thread_args {
+	int fd;
+	struct __test_metadata *_metadata;
+};
+static void *uhid_read_events_thread(void *arg)
+{
+	struct uhid_thread_args *args = (struct uhid_thread_args *)arg;
+	struct __test_metadata *_metadata = args->_metadata;
+	struct pollfd pfds[1];
+	int fd = args->fd;
+	int ret = 0;
+
+	pfds[0].fd = fd;
+	pfds[0].events = POLLIN;
+
+	uhid_stopped = false;
+
+	while (!uhid_stopped) {
+		ret = poll(pfds, 1, 100);
+		if (ret < 0) {
+			TH_LOG("Cannot poll for fds: %m");
+			break;
+		}
+		if (pfds[0].revents & POLLIN) {
+			ret = uhid_event(_metadata, fd);
+			if (ret)
+				break;
+		}
+	}
+
+	return (void *)(long)ret;
+}
+
+static int uhid_start_listener(struct __test_metadata *_metadata, pthread_t *tid, int uhid_fd)
+{
+	struct uhid_thread_args args = {
+		.fd = uhid_fd,
+		._metadata = _metadata,
+	};
+	int err;
+
+	pthread_mutex_lock(&uhid_started_mtx);
+	err = pthread_create(tid, NULL, uhid_read_events_thread, (void *)&args);
+	ASSERT_EQ(0, err) {
+		TH_LOG("Could not start the uhid thread: %d", err);
+		pthread_mutex_unlock(&uhid_started_mtx);
+		close(uhid_fd);
+		return -EIO;
+	}
+	pthread_cond_wait(&uhid_started, &uhid_started_mtx);
+	pthread_mutex_unlock(&uhid_started_mtx);
+
+	return 0;
+}
+
+static int uhid_send_event(struct __test_metadata *_metadata, int fd, __u8 *buf, size_t size)
+{
+	struct uhid_event ev;
+
+	if (size > sizeof(ev.u.input.data))
+		return -E2BIG;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT2;
+	ev.u.input2.size = size;
+
+	memcpy(ev.u.input2.data, buf, size);
+
+	return uhid_write(_metadata, fd, &ev);
+}
+
+static int setup_uhid(struct __test_metadata *_metadata, int rand_nb)
+{
+	int fd;
+	const char *path = "/dev/uhid";
+	int ret;
+
+	fd = open(path, O_RDWR | O_CLOEXEC);
+	ASSERT_GE(fd, 0) TH_LOG("open uhid-cdev failed; %d", fd);
+
+	ret = uhid_create(_metadata, fd, rand_nb);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("create uhid device failed: %d", ret);
+		close(fd);
+	}
+
+	return fd;
+}
+
+static bool match_sysfs_device(int dev_id, const char *workdir, struct dirent *dir)
+{
+	const char *target = "0003:0001:0A37.*";
+	char phys[512];
+	char uevent[1024];
+	char temp[512];
+	int fd, nread;
+	bool found = false;
+
+	if (fnmatch(target, dir->d_name, 0))
+		return false;
+
+	/* we found the correct VID/PID, now check for phys */
+	sprintf(uevent, "%s/%s/uevent", workdir, dir->d_name);
+
+	fd = open(uevent, O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		return false;
+
+	sprintf(phys, "PHYS=%d", dev_id);
+
+	nread = read(fd, temp, ARRAY_SIZE(temp));
+	if (nread > 0 && (strstr(temp, phys)) != NULL)
+		found = true;
+
+	close(fd);
+
+	return found;
+}
+
+static int get_hid_id(int dev_id)
+{
+	const char *workdir = "/sys/devices/virtual/misc/uhid";
+	const char *str_id;
+	DIR *d;
+	struct dirent *dir;
+	int found = -1, attempts = 3;
+
+	/* it would be nice to be able to use nftw, but the no_alu32 target doesn't support it */
+
+	while (found < 0 && attempts > 0) {
+		attempts--;
+		d = opendir(workdir);
+		if (d) {
+			while ((dir = readdir(d)) != NULL) {
+				if (!match_sysfs_device(dev_id, workdir, dir))
+					continue;
+
+				str_id = dir->d_name + sizeof("0003:0001:0A37.");
+				found = (int)strtol(str_id, NULL, 16);
+
+				break;
+			}
+			closedir(d);
+		}
+		if (found < 0)
+			usleep(100000);
+	}
+
+	return found;
+}
+
+static int get_hidraw(int dev_id)
+{
+	const char *workdir = "/sys/devices/virtual/misc/uhid";
+	char sysfs[1024];
+	DIR *d, *subd;
+	struct dirent *dir, *subdir;
+	int i, found = -1;
+
+	/* retry 5 times in case the system is loaded */
+	for (i = 5; i > 0; i--) {
+		usleep(10);
+		d = opendir(workdir);
+
+		if (!d)
+			continue;
+
+		while ((dir = readdir(d)) != NULL) {
+			if (!match_sysfs_device(dev_id, workdir, dir))
+				continue;
+
+			sprintf(sysfs, "%s/%s/hidraw", workdir, dir->d_name);
+
+			subd = opendir(sysfs);
+			if (!subd)
+				continue;
+
+			while ((subdir = readdir(subd)) != NULL) {
+				if (fnmatch("hidraw*", subdir->d_name, 0))
+					continue;
+
+				found = atoi(subdir->d_name + strlen("hidraw"));
+			}
+
+			closedir(subd);
+
+			if (found > 0)
+				break;
+		}
+		closedir(d);
+	}
+
+	return found;
+}
+
+static int open_hidraw(int dev_id)
+{
+	int hidraw_number;
+	char hidraw_path[64] = { 0 };
+
+	hidraw_number = get_hidraw(dev_id);
+	if (hidraw_number < 0)
+		return hidraw_number;
+
+	/* open hidraw node to check the other side of the pipe */
+	sprintf(hidraw_path, "/dev/hidraw%d", hidraw_number);
+	return open(hidraw_path, O_RDWR | O_NONBLOCK);
+}

-- 
2.46.0


