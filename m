Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0786183A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 17:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiKCQCh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiKCQCN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 12:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498E41B7A7
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667491127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35vI4iNIZI7SVC8N/h2i/xxhLm+SVmqisQHlXI8u33A=;
        b=EF6D3n7XEgoIr/XiGUn/a6CeoZFmid2PTxeULCJMN1lZzR6KchIITa2QY+8LZeqFXVmRwm
        2TWEdbrr05daVFsime23kgEZQcKNlHDzq1EGwWo1ClQuwFawaQ3HeO9L7fb8jo05dERi5Y
        ax7pkWrAcvaqopqDkiM9wU3O+Z+Vyyk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-APgFDwdSM_u_ytZbRaf-ZA-1; Thu, 03 Nov 2022 11:58:46 -0400
X-MC-Unique: APgFDwdSM_u_ytZbRaf-ZA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA3652823803;
        Thu,  3 Nov 2022 15:58:45 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.192.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E493A4A9254;
        Thu,  3 Nov 2022 15:58:43 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH hid v12 14/15] samples/hid: add Surface Dial example
Date:   Thu,  3 Nov 2022 16:57:55 +0100
Message-Id: <20221103155756.687789-15-benjamin.tissoires@redhat.com>
In-Reply-To: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a more complete HID-BPF example.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v12:
- use the shared hid_bpf_attach.bpf.c program

changes in v11:
- use samples/hid instead of samples/bpf

no changes in v10

changes in v9:
- extend the usage section
- add sleep while waiting
- changed the title of the commit

no changes in v8

changes in v7:
- remove unnecessary __must_check definition

new in v6

fix sample hid_surface_dial
---
 samples/hid/.gitignore             |   1 +
 samples/hid/Makefile               |   6 +-
 samples/hid/hid_bpf_helpers.h      |   2 +
 samples/hid/hid_surface_dial.bpf.c | 134 +++++++++++++++++
 samples/hid/hid_surface_dial.c     | 226 +++++++++++++++++++++++++++++
 5 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 samples/hid/hid_surface_dial.bpf.c
 create mode 100644 samples/hid/hid_surface_dial.c

diff --git a/samples/hid/.gitignore b/samples/hid/.gitignore
index 8cb45592e29a..3ea0fed3bbad 100644
--- a/samples/hid/.gitignore
+++ b/samples/hid/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 hid_mouse
+hid_surface_dial
 *.out
 *.skel.h
 /vmlinux.h
diff --git a/samples/hid/Makefile b/samples/hid/Makefile
index 8fe6ccfc5f29..026288280a03 100644
--- a/samples/hid/Makefile
+++ b/samples/hid/Makefile
@@ -7,6 +7,7 @@ pound := \#
 
 # List of programs to build
 tprogs-y += hid_mouse
+tprogs-y += hid_surface_dial
 
 # Libbpf dependencies
 LIBBPF_SRC = $(TOOLS_PATH)/lib/bpf
@@ -19,6 +20,7 @@ EXTRA_HEADERS := hid_bpf_attach.h
 EXTRA_BPF_HEADERS := hid_bpf_helpers.h
 
 hid_mouse-objs := hid_mouse.o
+hid_surface_dial-objs := hid_surface_dial.o
 
 # Tell kbuild to always build the programs
 always-y := $(tprogs-y)
@@ -156,6 +158,7 @@ libbpf_hdrs: $(LIBBPF)
 .PHONY: libbpf_hdrs
 
 $(obj)/hid_mouse.o: $(obj)/hid_mouse.skel.h
+$(obj)/hid_surface_dial.o: $(obj)/hid_surface_dial.skel.h
 
 -include $(HID_SAMPLES_PATH)/Makefile.target
 
@@ -201,10 +204,11 @@ $(obj)/%.bpf.o: $(src)/%.bpf.c $(EXTRA_BPF_HEADERS_SRC) $(obj)/vmlinux.h
 		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-c $(filter %.bpf.c,$^) -o $@
 
-LINKED_SKELS := hid_mouse.skel.h
+LINKED_SKELS := hid_mouse.skel.h hid_surface_dial.skel.h
 clean-files += $(LINKED_SKELS)
 
 hid_mouse.skel.h-deps := hid_mouse.bpf.o hid_bpf_attach.bpf.o
+hid_surface_dial.skel.h-deps := hid_surface_dial.bpf.o hid_bpf_attach.bpf.o
 
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
 
diff --git a/samples/hid/hid_bpf_helpers.h b/samples/hid/hid_bpf_helpers.h
index c555aeef5e37..4fff31dbe0e7 100644
--- a/samples/hid/hid_bpf_helpers.h
+++ b/samples/hid/hid_bpf_helpers.h
@@ -10,6 +10,8 @@ extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,
 			      const size_t __sz) __ksym;
 extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
+extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
+extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
 extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
 			      __u8 *data,
 			      size_t buf__sz,
diff --git a/samples/hid/hid_surface_dial.bpf.c b/samples/hid/hid_surface_dial.bpf.c
new file mode 100644
index 000000000000..1f80478c0918
--- /dev/null
+++ b/samples/hid/hid_surface_dial.bpf.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Benjamin Tissoires
+ */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "hid_bpf_helpers.h"
+
+#define HID_UP_BUTTON		0x0009
+#define HID_GD_WHEEL		0x0038
+
+SEC("fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_event, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 9 /* size */);
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* Touch */
+	data[1] &= 0xfd;
+
+	/* X */
+	data[4] = 0;
+	data[5] = 0;
+
+	/* Y */
+	data[6] = 0;
+	data[7] = 0;
+
+	return 0;
+}
+
+/* 72 == 360 / 5 -> 1 report every 5 degrees */
+int resolution = 72;
+int physical = 5;
+
+struct haptic_syscall_args {
+	unsigned int hid;
+	int retval;
+};
+
+static __u8 haptic_data[8];
+
+SEC("syscall")
+int set_haptic(struct haptic_syscall_args *args)
+{
+	struct hid_bpf_ctx *ctx;
+	const size_t size = sizeof(haptic_data);
+	u16 *res;
+	int ret;
+
+	if (size > sizeof(haptic_data))
+		return -7; /* -E2BIG */
+
+	ctx = hid_bpf_allocate_context(args->hid);
+	if (!ctx)
+		return -1; /* EPERM check */
+
+	haptic_data[0] = 1;  /* report ID */
+
+	ret = hid_bpf_hw_request(ctx, haptic_data, size, HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+
+	bpf_printk("probed/remove event ret value: %d", ret);
+	bpf_printk("buf: %02x %02x %02x",
+		   haptic_data[0],
+		   haptic_data[1],
+		   haptic_data[2]);
+	bpf_printk("     %02x %02x %02x",
+		   haptic_data[3],
+		   haptic_data[4],
+		   haptic_data[5]);
+	bpf_printk("     %02x %02x",
+		   haptic_data[6],
+		   haptic_data[7]);
+
+	/* whenever resolution multiplier is not 3600, we have the fixed report descriptor */
+	res = (u16 *)&haptic_data[1];
+	if (*res != 3600) {
+//		haptic_data[1] = 72; /* resolution multiplier */
+//		haptic_data[2] = 0;  /* resolution multiplier */
+//		haptic_data[3] = 0;  /* Repeat Count */
+		haptic_data[4] = 3;  /* haptic Auto Trigger */
+//		haptic_data[5] = 5;  /* Waveform Cutoff Time */
+//		haptic_data[6] = 80; /* Retrigger Period */
+//		haptic_data[7] = 0;  /* Retrigger Period */
+	} else {
+		haptic_data[4] = 0;
+	}
+
+	ret = hid_bpf_hw_request(ctx, haptic_data, size, HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	bpf_printk("set haptic ret value: %d -> %d", ret, haptic_data[4]);
+
+	args->retval = ret;
+
+	hid_bpf_release_context(ctx);
+
+	return 0;
+}
+
+/* Convert REL_DIAL into REL_WHEEL */
+SEC("fmod_ret/hid_bpf_rdesc_fixup")
+int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4096 /* size */);
+	__u16 *res, *phys;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* Convert TOUCH into a button */
+	data[31] = HID_UP_BUTTON;
+	data[33] = 2;
+
+	/* Convert REL_DIAL into REL_WHEEL */
+	data[45] = HID_GD_WHEEL;
+
+	/* Change Resolution Multiplier */
+	phys = (__u16 *)&data[61];
+	*phys = physical;
+	res = (__u16 *)&data[66];
+	*res = resolution;
+
+	/* Convert X,Y from Abs to Rel */
+	data[88] = 0x06;
+	data[98] = 0x06;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+u32 _version SEC("version") = 1;
diff --git a/samples/hid/hid_surface_dial.c b/samples/hid/hid_surface_dial.c
new file mode 100644
index 000000000000..bceea53d39b0
--- /dev/null
+++ b/samples/hid/hid_surface_dial.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 Benjamin Tissoires
+ *
+ * This program will morph the Microsoft Surface Dial into a mouse,
+ * and depending on the chosen resolution enable or not the haptic feedback:
+ * - a resolution (-r) of 3600 will report 3600 "ticks" in one full rotation
+ *   wihout haptic feedback
+ * - any other resolution will report N "ticks" in a full rotation with haptic
+ *   feedback
+ *
+ * A good default for low resolution haptic scrolling is 72 (1 "tick" every 5
+ * degrees), and set to 3600 for smooth scrolling.
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <libgen.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <unistd.h>
+
+#include <linux/bpf.h>
+#include <linux/errno.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "hid_surface_dial.skel.h"
+#include "hid_bpf_attach.h"
+
+static bool running = true;
+
+struct haptic_syscall_args {
+	unsigned int hid;
+	int retval;
+};
+
+static void int_exit(int sig)
+{
+	running = false;
+	exit(0);
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"%s: %s [OPTIONS] /sys/bus/hid/devices/0BUS:0VID:0PID:00ID\n\n"
+		"  OPTIONS:\n"
+		"    -r N\t set the given resolution to the device (number of ticks per 360°)\n\n",
+		__func__, prog);
+	fprintf(stderr,
+		"This program will morph the Microsoft Surface Dial into a mouse,\n"
+		"and depending on the chosen resolution enable or not the haptic feedback:\n"
+		"- a resolution (-r) of 3600 will report 3600 'ticks' in one full rotation\n"
+		"  wihout haptic feedback\n"
+		"- any other resolution will report N 'ticks' in a full rotation with haptic\n"
+		"  feedback\n"
+		"\n"
+		"A good default for low resolution haptic scrolling is 72 (1 'tick' every 5\n"
+		"degrees), and set to 3600 for smooth scrolling.\n");
+}
+
+static int get_hid_id(const char *path)
+{
+	const char *str_id, *dir;
+	char uevent[1024];
+	int fd;
+
+	memset(uevent, 0, sizeof(uevent));
+	snprintf(uevent, sizeof(uevent) - 1, "%s/uevent", path);
+
+	fd = open(uevent, O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		return -ENOENT;
+
+	close(fd);
+
+	dir = basename((char *)path);
+
+	str_id = dir + sizeof("0003:0001:0A37.");
+	return (int)strtol(str_id, NULL, 16);
+}
+
+static int attach_prog(struct hid_surface_dial *skel, struct bpf_program *prog, int hid_id)
+{
+	struct attach_prog_args args = {
+		.hid = hid_id,
+		.retval = -1,
+	};
+	int attach_fd, err;
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattr,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+
+	attach_fd = bpf_program__fd(skel->progs.attach_prog);
+	if (attach_fd < 0) {
+		fprintf(stderr, "can't locate attach prog: %m\n");
+		return 1;
+	}
+
+	args.prog_fd = bpf_program__fd(prog);
+	err = bpf_prog_test_run_opts(attach_fd, &tattr);
+	if (err) {
+		fprintf(stderr, "can't attach prog to hid device %d: %m (err: %d)\n",
+			hid_id, err);
+		return 1;
+	}
+	return 0;
+}
+
+static int set_haptic(struct hid_surface_dial *skel, int hid_id)
+{
+	struct haptic_syscall_args args = {
+		.hid = hid_id,
+		.retval = -1,
+	};
+	int haptic_fd, err;
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattr,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+
+	haptic_fd = bpf_program__fd(skel->progs.set_haptic);
+	if (haptic_fd < 0) {
+		fprintf(stderr, "can't locate haptic prog: %m\n");
+		return 1;
+	}
+
+	err = bpf_prog_test_run_opts(haptic_fd, &tattr);
+	if (err) {
+		fprintf(stderr, "can't set haptic configuration to hid device %d: %m (err: %d)\n",
+			hid_id, err);
+		return 1;
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	struct hid_surface_dial *skel;
+	struct bpf_program *prog;
+	const char *optstr = "r:";
+	const char *sysfs_path;
+	int opt, hid_id, resolution = 72;
+
+	while ((opt = getopt(argc, argv, optstr)) != -1) {
+		switch (opt) {
+		case 'r':
+			{
+				char *endp = NULL;
+				long l = -1;
+
+				if (optarg) {
+					l = strtol(optarg, &endp, 10);
+					if (endp && *endp)
+						l = -1;
+				}
+
+				if (l < 0) {
+					fprintf(stderr,
+						"invalid r option %s - expecting a number\n",
+						optarg ? optarg : "");
+					exit(EXIT_FAILURE);
+				};
+
+				resolution = (int) l;
+				break;
+			}
+		default:
+			usage(basename(argv[0]));
+			return 1;
+		}
+	}
+
+	if (optind == argc) {
+		usage(basename(argv[0]));
+		return 1;
+	}
+
+	sysfs_path = argv[optind];
+	if (!sysfs_path) {
+		perror("sysfs");
+		return 1;
+	}
+
+	skel = hid_surface_dial__open_and_load();
+	if (!skel) {
+		fprintf(stderr, "%s  %s:%d", __func__, __FILE__, __LINE__);
+		return -1;
+	}
+
+	hid_id = get_hid_id(sysfs_path);
+	if (hid_id < 0) {
+		fprintf(stderr, "can not open HID device: %m\n");
+		return 1;
+	}
+
+	skel->data->resolution = resolution;
+	skel->data->physical = (int)(resolution / 72);
+
+	bpf_object__for_each_program(prog, *skel->skeleton->obj) {
+		/* ignore syscalls */
+		if (bpf_program__get_type(prog) != BPF_PROG_TYPE_TRACING)
+			continue;
+
+		attach_prog(skel, prog, hid_id);
+	}
+
+	signal(SIGINT, int_exit);
+	signal(SIGTERM, int_exit);
+
+	set_haptic(skel, hid_id);
+
+	while (running)
+		sleep(1);
+
+	hid_surface_dial__destroy(skel);
+
+	return 0;
+}
-- 
2.36.1

