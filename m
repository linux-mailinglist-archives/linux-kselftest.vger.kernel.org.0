Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9151357CFAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 17:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiGUPjm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiGUPig (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 11:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36FED88E06
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658417844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=luT4EpGWZXnfLs99vewJsZVVydHGWY1hV1eYHIc31Ow=;
        b=H5dFwGW7Z44A6xs3k9Nvs9nVWFHOJs/3pY6RkS1D9LHTa6AY6ZwVFT5oKBli4bEuYbHAlj
        z1BJK/ENevw+2B6VB0joLha0YVXmmr2+aL0J+Rb2G8+6MDE0Mtfi33+nOfX/ApWwtpQcHb
        dNMT2qQkfMRpbcaLb1LNk7hC+S+RYEA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-h8ZfGjCEMNibfZvPT4v1VA-1; Thu, 21 Jul 2022 11:37:21 -0400
X-MC-Unique: h8ZfGjCEMNibfZvPT4v1VA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF6B13817A6D;
        Thu, 21 Jul 2022 15:37:19 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.194.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDF832166B26;
        Thu, 21 Jul 2022 15:37:16 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH bpf-next v7 14/24] selftests/bpf: add tests for the HID-bpf initial implementation
Date:   Thu, 21 Jul 2022 17:36:15 +0200
Message-Id: <20220721153625.1282007-15-benjamin.tissoires@redhat.com>
In-Reply-To: <20220721153625.1282007-1-benjamin.tissoires@redhat.com>
References: <20220721153625.1282007-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test is pretty basic:
- create a virtual uhid device that no userspace will like (to not mess
  up the running system)
- attach a BPF prog to it
- open the matching hidraw node
- inject one event and check:
  * that the BPF program can do something on the event stream
  * can modify the event stream
- add another test where we attach/detach BPF programs to see if we get
  errors

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v7

no changes in v6

changes in v5:
- use of the HID device system id instead of fd
- attach to HID device with the new API
- add attach/detach test

changes in v4:
- manually retrieve the hidraw node from the sysfs (we can't get it for
  free from BPF)
- use the new API

changes in v3:
- squashed "hid: rely on uhid event to know if a test device is ready"
  into this one
- add selftests bpf VM config changes
- s/hidraw_ino/hidraw_number/

changes in v2:
- split the series by bpf/libbpf/hid/selftests and samples
---
 tools/testing/selftests/bpf/config           |   3 +
 tools/testing/selftests/bpf/prog_tests/hid.c | 669 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/hid.c      |  45 ++
 3 files changed, 717 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/hid.c
 create mode 100644 tools/testing/selftests/bpf/progs/hid.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c69c119f4bb7..0709b68000f0 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -63,3 +63,6 @@ CONFIG_NETFILTER_XT_MATCH_STATE=y
 CONFIG_IP_NF_FILTER=y
 CONFIG_IP_NF_TARGET_SYNPROXY=y
 CONFIG_IP_NF_RAW=y
+CONFIG_HID=y
+CONFIG_HIDRAW=y
+CONFIG_UHID=y
diff --git a/tools/testing/selftests/bpf/prog_tests/hid.c b/tools/testing/selftests/bpf/prog_tests/hid.c
new file mode 100644
index 000000000000..719d220c8d86
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/hid.c
@@ -0,0 +1,669 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Red Hat */
+#include <test_progs.h>
+#include <testing_helpers.h>
+#include "hid.skel.h"
+
+#include <fcntl.h>
+#include <fnmatch.h>
+#include <dirent.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <linux/uhid.h>
+
+static unsigned char rdesc[] = {
+	0x06, 0x00, 0xff,	/* Usage Page (Vendor Defined Page 1) */
+	0x09, 0x21,		/* Usage (Vendor Usage 0x21) */
+	0xa1, 0x01,		/* COLLECTION (Application) */
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
+struct attach_prog_args {
+	int prog_fd;
+	unsigned int hid;
+	int retval;
+};
+
+static pthread_mutex_t uhid_started_mtx = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t uhid_started = PTHREAD_COND_INITIALIZER;
+
+/* no need to protect uhid_stopped, only one thread accesses it */
+static bool uhid_stopped;
+
+static int uhid_write(int fd, const struct uhid_event *ev)
+{
+	ssize_t ret;
+
+	ret = write(fd, ev, sizeof(*ev));
+	if (ret < 0) {
+		fprintf(stderr, "Cannot write to uhid: %m\n");
+		return -errno;
+	} else if (ret != sizeof(*ev)) {
+		fprintf(stderr, "Wrong size written to uhid: %zd != %zu\n",
+			ret, sizeof(ev));
+		return -EFAULT;
+	} else {
+		return 0;
+	}
+}
+
+static int create(int fd, int rand_nb)
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
+	return uhid_write(fd, &ev);
+}
+
+static void destroy(int fd)
+{
+	struct uhid_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	uhid_write(fd, &ev);
+}
+
+static int uhid_event(int fd)
+{
+	struct uhid_event ev;
+	ssize_t ret;
+
+	memset(&ev, 0, sizeof(ev));
+	ret = read(fd, &ev, sizeof(ev));
+	if (ret == 0) {
+		fprintf(stderr, "Read HUP on uhid-cdev\n");
+		return -EFAULT;
+	} else if (ret < 0) {
+		fprintf(stderr, "Cannot read uhid-cdev: %m\n");
+		return -errno;
+	} else if (ret != sizeof(ev)) {
+		fprintf(stderr, "Invalid size read from uhid-dev: %zd != %zu\n",
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
+		fprintf(stderr, "UHID_START from uhid-dev\n");
+		break;
+	case UHID_STOP:
+		uhid_stopped = true;
+
+		fprintf(stderr, "UHID_STOP from uhid-dev\n");
+		break;
+	case UHID_OPEN:
+		fprintf(stderr, "UHID_OPEN from uhid-dev\n");
+		break;
+	case UHID_CLOSE:
+		fprintf(stderr, "UHID_CLOSE from uhid-dev\n");
+		break;
+	case UHID_OUTPUT:
+		fprintf(stderr, "UHID_OUTPUT from uhid-dev\n");
+		break;
+	case UHID_GET_REPORT:
+		fprintf(stderr, "UHID_GET_REPORT from uhid-dev\n");
+		break;
+	case UHID_SET_REPORT:
+		fprintf(stderr, "UHID_SET_REPORT from uhid-dev\n");
+		break;
+	default:
+		fprintf(stderr, "Invalid event from uhid-dev: %u\n", ev.type);
+	}
+
+	return 0;
+}
+
+static void *read_uhid_events_thread(void *arg)
+{
+	int fd = *(int *)arg;
+	struct pollfd pfds[1];
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
+			fprintf(stderr, "Cannot poll for fds: %m\n");
+			break;
+		}
+		if (pfds[0].revents & POLLIN) {
+			ret = uhid_event(fd);
+			if (ret)
+				break;
+		}
+	}
+
+	return (void *)(long)ret;
+}
+
+static int uhid_start_listener(pthread_t *tid, int uhid_fd)
+{
+	int fd = uhid_fd;
+
+	pthread_mutex_lock(&uhid_started_mtx);
+	if (CHECK_FAIL(pthread_create(tid, NULL, read_uhid_events_thread,
+				      (void *)&fd))) {
+		pthread_mutex_unlock(&uhid_started_mtx);
+		close(fd);
+		return -EIO;
+	}
+	pthread_cond_wait(&uhid_started, &uhid_started_mtx);
+	pthread_mutex_unlock(&uhid_started_mtx);
+
+	return 0;
+}
+
+static int send_event(int fd, u8 *buf, size_t size)
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
+	return uhid_write(fd, &ev);
+}
+
+static int setup_uhid(int rand_nb)
+{
+	int fd;
+	const char *path = "/dev/uhid";
+	int ret;
+
+	fd = open(path, O_RDWR | O_CLOEXEC);
+	if (!ASSERT_GE(fd, 0, "open uhid-cdev"))
+		return -EPERM;
+
+	ret = create(fd, rand_nb);
+	if (!ASSERT_OK(ret, "create uhid device")) {
+		close(fd);
+		return -EPERM;
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
+	int found = -1;
+
+	/* it would be nice to be able to use nftw, but the no_alu32 target doesn't support it */
+
+	d = opendir(workdir);
+	if (d) {
+		while ((dir = readdir(d)) != NULL) {
+			if (!match_sysfs_device(dev_id, workdir, dir))
+				continue;
+
+			str_id = dir->d_name + sizeof("0003:0001:0A37.");
+			found = (int)strtol(str_id, NULL, 16);
+
+			break;
+		}
+		closedir(d);
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
+
+struct test_params {
+	struct hid *skel;
+	int hidraw_fd;
+};
+
+static int prep_test(int dev_id, const char *prog_name, struct test_params *test_data)
+{
+	struct hid *hid_skel = NULL;
+	struct bpf_program *prog = NULL;
+	char buf[64] = {0};
+	int hidraw_fd = -1;
+	int hid_id, attach_fd, err = -EINVAL;
+	struct attach_prog_args args = {
+		.retval = -1,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattr,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+
+	/* locate the uevent file of the created device */
+	hid_id = get_hid_id(dev_id);
+	if (!ASSERT_GE(hid_id, 0, "locate uhid device id"))
+		goto cleanup;
+
+	args.hid = hid_id;
+
+	hid_skel = hid__open();
+	if (!ASSERT_OK_PTR(hid_skel, "hid_skel_open"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(*hid_skel->skeleton->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "find_prog_by_name"))
+		goto cleanup;
+
+	bpf_program__set_autoload(prog, true);
+
+	err = hid__load(hid_skel);
+	if (!ASSERT_OK(err, "hid_skel_load"))
+		goto cleanup;
+
+	attach_fd = bpf_program__fd(hid_skel->progs.attach_prog);
+	if (!ASSERT_GE(attach_fd, 0, "locate attach_prog")) {
+		err = attach_fd;
+		goto cleanup;
+	}
+
+	args.prog_fd = bpf_program__fd(prog);
+	err = bpf_prog_test_run_opts(attach_fd, &tattr);
+	snprintf(buf, sizeof(buf), "attach_hid(%s)", prog_name);
+	if (!ASSERT_EQ(args.retval, 0, buf))
+		goto cleanup;
+
+	hidraw_fd = open_hidraw(dev_id);
+	if (!ASSERT_GE(hidraw_fd, 0, "open_hidraw"))
+		goto cleanup;
+
+	test_data->skel = hid_skel;
+	test_data->hidraw_fd = hidraw_fd;
+
+	return 0;
+
+ cleanup:
+	if (hidraw_fd >= 0)
+		close(hidraw_fd);
+
+	hid__destroy(hid_skel);
+
+	memset(test_data, 0, sizeof(*test_data));
+
+	return err;
+}
+
+static void cleanup_test(struct test_params *test_data)
+{
+	if (!test_data)
+		return;
+
+	if (test_data->hidraw_fd)
+		close(test_data->hidraw_fd);
+
+	hid__destroy(test_data->skel);
+
+	memset(test_data, 0, sizeof(*test_data));
+}
+
+/*
+ * Attach hid_first_event to the given uhid device,
+ * retrieve and open the matching hidraw node,
+ * inject one event in the uhid device,
+ * check that the program sees it and can change the data
+ */
+static int test_hid_raw_event(int uhid_fd, int dev_id)
+{
+	struct hid *hid_skel = NULL;
+	struct test_params params;
+	int err, hidraw_fd = -1;
+	u8 buf[10] = {0};
+	int ret = -1;
+
+	err = prep_test(dev_id, "hid_first_event", &params);
+	if (!ASSERT_EQ(err, 0, "prep_test(hid_first_event)"))
+		goto cleanup;
+
+	hid_skel = params.skel;
+	hidraw_fd = params.hidraw_fd;
+
+	/* check that the program is correctly loaded */
+	ASSERT_EQ(hid_skel->data->callback_check, 52, "callback_check1");
+	ASSERT_EQ(hid_skel->data->callback2_check, 52, "callback2_check1");
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	send_event(uhid_fd, buf, 6);
+
+	/* check that hid_first_event() was executed */
+	ASSERT_EQ(hid_skel->data->callback_check, 42, "callback_check1");
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(hidraw_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, 6, "read_hidraw"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[0], 1, "hid_first_event"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[2], 47, "hid_first_event"))
+		goto cleanup;
+
+	/* inject another event */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 1;
+	buf[1] = 47;
+	send_event(uhid_fd, buf, 6);
+
+	/* check that hid_first_event() was executed */
+	ASSERT_EQ(hid_skel->data->callback_check, 47, "callback_check1");
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(hidraw_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, 6, "read_hidraw"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[2], 52, "hid_first_event"))
+		goto cleanup;
+
+	ret = 0;
+
+cleanup:
+	cleanup_test(&params);
+
+	return ret;
+}
+
+/*
+ * Ensures that we can attach/detach programs
+ */
+static int test_attach_detach(int uhid_fd, int dev_id)
+{
+	struct test_params params;
+	int err, hidraw_fd = -1;
+	u8 buf[10] = {0};
+	int ret = -1;
+
+	err = prep_test(dev_id, "hid_first_event", &params);
+	if (!ASSERT_EQ(err, 0, "prep_test(hid_first_event)"))
+		goto cleanup;
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	send_event(uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(params.hidraw_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, 6, "read_hidraw_with_bpf"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[0], 1, "hid_first_event"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[2], 47, "hid_first_event"))
+		goto cleanup;
+
+	/* pin the program and immediately unpin it */
+#define PIN_PATH "/sys/fs/bpf/hid_first_event"
+	bpf_program__pin(params.skel->progs.hid_first_event, PIN_PATH);
+	remove(PIN_PATH);
+#undef PIN_PATH
+	usleep(100000);
+
+	/* detach the program */
+	cleanup_test(&params);
+
+	hidraw_fd = open_hidraw(dev_id);
+	if (!ASSERT_GE(hidraw_fd, 0, "open_hidraw"))
+		goto cleanup;
+
+	/* inject another event */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 1;
+	buf[1] = 47;
+	send_event(uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(hidraw_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, 6, "read_hidraw_no_bpf"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[0], 1, "event_no_bpf"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[1], 47, "event_no_bpf"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[2], 0, "event_no_bpf"))
+		goto cleanup;
+
+	/* re-attach our program */
+
+	err = prep_test(dev_id, "hid_first_event", &params);
+	if (!ASSERT_EQ(err, 0, "prep_test(hid_first_event)"))
+		goto cleanup;
+
+	/* inject one event */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 1;
+	buf[1] = 42;
+	send_event(uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(params.hidraw_fd, buf, sizeof(buf));
+	if (!ASSERT_EQ(err, 6, "read_hidraw"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[0], 1, "hid_first_event"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(buf[2], 47, "hid_first_event"))
+		goto cleanup;
+
+	ret = 0;
+
+cleanup:
+	if (hidraw_fd >= 0)
+		close(hidraw_fd);
+
+	cleanup_test(&params);
+
+	return ret;
+}
+
+void serial_test_hid_bpf(void)
+{
+	int err, uhid_fd;
+	void *uhid_err;
+	time_t t;
+	pthread_t tid;
+	int dev_id;
+
+	/* initialize random number generator */
+	srand((unsigned int)time(&t));
+
+	dev_id = rand() % 1024;
+
+	uhid_fd = setup_uhid(dev_id);
+	if (!ASSERT_GE(uhid_fd, 0, "setup uhid"))
+		return;
+
+	err = uhid_start_listener(&tid, uhid_fd);
+	ASSERT_OK(err, "uhid_start_listener");
+
+	/* start the tests! */
+	err = test_hid_raw_event(uhid_fd, dev_id);
+	ASSERT_OK(err, "hid");
+	err = test_attach_detach(uhid_fd, dev_id);
+	ASSERT_OK(err, "hid_attach_detach");
+
+	destroy(uhid_fd);
+
+	pthread_join(tid, &uhid_err);
+	err = (int)(long)uhid_err;
+	CHECK_FAIL(err);
+}
diff --git a/tools/testing/selftests/bpf/progs/hid.c b/tools/testing/selftests/bpf/progs/hid.c
new file mode 100644
index 000000000000..fc0a4241643a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/hid.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Red hat */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
+			      unsigned int offset,
+			      const size_t __sz) __ksym;
+extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
+
+struct attach_prog_args {
+	int prog_fd;
+	unsigned int hid;
+	int retval;
+};
+
+__u64 callback_check = 52;
+__u64 callback2_check = 52;
+
+SEC("?fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx)
+{
+	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 3 /* size */);
+
+	if (!rw_data)
+		return 0; /* EPERM check */
+
+	callback_check = rw_data[1];
+
+	rw_data[2] = rw_data[1] + 5;
+
+	return 0;
+}
+
+SEC("syscall")
+int attach_prog(struct attach_prog_args *ctx)
+{
+	ctx->retval = hid_bpf_attach_prog(ctx->hid,
+					  ctx->prog_fd,
+					  0);
+	return 0;
+}
-- 
2.36.1

