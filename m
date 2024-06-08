Return-Path: <linux-kselftest+bounces-11474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D8E9010B6
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B8C282AB2
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8A817966D;
	Sat,  8 Jun 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLqrZXOy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C889179652;
	Sat,  8 Jun 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837291; cv=none; b=lUbJC2vmzSPCAucrjFbYNC9IOs/fzhNwffH+PP9/aiNO+9eoquxtxfvNqN54Azphh0tY7vhnwuD0IP2JJq65nW6a1BltZr4Y0kMtkc2Ml6TGRP3jxjGGGk+p3HR/a4IZI2P/xdgzrROedScF1rv92gfPV/+hfkHXiolzSH5k1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837291; c=relaxed/simple;
	bh=h5CB26I20SEzuJWzCaBWDsFR6O9I0MvQtx7Y5XppM6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0eE3Pl1FBurJ/khZcVoX5Mf9C28OQfMjPGM9sz7Vy0Oi1C6J5Q//NxE5J2aUO2jd1s9+iLJpcl0oWtJKHkPow1kuUHR3jSoBxLL1/7vZflhegMD8bJXquL/JJ9R8HOXtX0n0wLcdQ0nuFPOEs+NfTyp/5DQJuPEkO4VxxIZCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLqrZXOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D71CC4AF07;
	Sat,  8 Jun 2024 09:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837291;
	bh=h5CB26I20SEzuJWzCaBWDsFR6O9I0MvQtx7Y5XppM6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PLqrZXOyRKtqGn6N5VT6i8BZ8S8sYcwNW0c97XgQWgfbEQGM/+7ViF3g+hk+gB9Uq
	 ITN91RFYGr/2m5r5P5RGPdXcuhf2345hixY+9XYuRe5xax4XH6vhJxhGvWUi8dw2se
	 dYHT9aumq2kNfyg+FgHuQY9F0ARwqBNLlEc5egLQtIFHQFRj9EV5oFaoL3WXkqqao2
	 Nl+Mm2xPL7eq2iehm4YQgpacd2ZVPuKr8LT+QzG1dr8ydqL8VbNcUAAqwQL8ZxQaV1
	 tVHTsZTZQDHOKNG1QsdRMPG5CVuoTDyXB/ZGxrbtRd2mKVFnayQEyZp7gc2v/GN1NJ
	 l9E8IGRF7rb2Q==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:16 +0200
Subject: [PATCH HID v3 04/16] selftests/hid: convert the hid_bpf selftests
 with struct_ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-4-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=11693;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=h5CB26I20SEzuJWzCaBWDsFR6O9I0MvQtx7Y5XppM6c=;
 b=XFRZmWKC09Td+NEVlqT07pg8hNm0STgORW5ZFR/2vhHsKELOKL4dznqQd11rYI98vw0J+pgTD
 Y/MIgeX5VmoBOGstQXtnDDMRrQzfRtzGxeUQdD2CkbL1x4n/MwJmMWf
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We drop the need for the attach() bpf syscall, but we need to set up
the hid_id field before calling __load().

The .bpf.c part is mechanical: we create one struct_ops per HID-BPF
program, as all the tests are for one program at a time.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

changes in v2:
- use BPF_F_BEFORE
---
 tools/testing/selftests/hid/hid_bpf.c              | 59 +++++++++--------
 tools/testing/selftests/hid/progs/hid.c            | 76 +++++++++++++++-------
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 19 ++----
 3 files changed, 89 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index f825623e3edc..967dfe6b58cb 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -460,7 +460,7 @@ FIXTURE(hid_bpf) {
 	int hid_id;
 	pthread_t tid;
 	struct hid *skel;
-	int hid_links[3]; /* max number of programs loaded in a single test */
+	struct bpf_link *hid_links[3]; /* max number of programs loaded in a single test */
 };
 static void detach_bpf(FIXTURE_DATA(hid_bpf) * self)
 {
@@ -472,7 +472,7 @@ static void detach_bpf(FIXTURE_DATA(hid_bpf) * self)
 
 	for (i = 0; i < ARRAY_SIZE(self->hid_links); i++) {
 		if (self->hid_links[i])
-			close(self->hid_links[i]);
+			bpf_link__destroy(self->hid_links[i]);
 	}
 
 	hid__destroy(self->skel);
@@ -527,14 +527,7 @@ static void load_programs(const struct test_program programs[],
 			  FIXTURE_DATA(hid_bpf) * self,
 			  const FIXTURE_VARIANT(hid_bpf) * variant)
 {
-	int attach_fd, err = -EINVAL;
-	struct attach_prog_args args = {
-		.retval = -1,
-	};
-	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattr,
-			    .ctx_in = &args,
-			    .ctx_size_in = sizeof(args),
-	);
+	int err = -EINVAL;
 
 	ASSERT_LE(progs_count, ARRAY_SIZE(self->hid_links))
 		TH_LOG("too many programs are to be loaded");
@@ -545,35 +538,41 @@ static void load_programs(const struct test_program programs[],
 
 	for (int i = 0; i < progs_count; i++) {
 		struct bpf_program *prog;
+		struct bpf_map *map;
+		int *ops_hid_id;
 
 		prog = bpf_object__find_program_by_name(*self->skel->skeleton->obj,
 							programs[i].name);
 		ASSERT_OK_PTR(prog) TH_LOG("can not find program by name '%s'", programs[i].name);
 
 		bpf_program__set_autoload(prog, true);
+
+		map = bpf_object__find_map_by_name(*self->skel->skeleton->obj,
+							  programs[i].name + 4);
+		ASSERT_OK_PTR(map) TH_LOG("can not find struct_ops by name '%s'",
+					  programs[i].name + 4);
+
+		/* hid_id is the first field of struct hid_bpf_ops */
+		ops_hid_id = bpf_map__initial_value(map, NULL);
+		ASSERT_OK_PTR(ops_hid_id) TH_LOG("unable to retrieve struct_ops data");
+
+		*ops_hid_id = self->hid_id;
 	}
 
 	err = hid__load(self->skel);
 	ASSERT_OK(err) TH_LOG("hid_skel_load failed: %d", err);
 
-	attach_fd = bpf_program__fd(self->skel->progs.attach_prog);
-	ASSERT_GE(attach_fd, 0) TH_LOG("locate attach_prog: %d", attach_fd);
-
 	for (int i = 0; i < progs_count; i++) {
-		struct bpf_program *prog;
+		struct bpf_map *map;
 
-		prog = bpf_object__find_program_by_name(*self->skel->skeleton->obj,
-							programs[i].name);
-		ASSERT_OK_PTR(prog) TH_LOG("can not find program by name '%s'", programs[i].name);
-
-		args.prog_fd = bpf_program__fd(prog);
-		args.hid = self->hid_id;
-		args.insert_head = programs[i].insert_head;
-		err = bpf_prog_test_run_opts(attach_fd, &tattr);
-		ASSERT_GE(args.retval, 0)
-			TH_LOG("attach_hid(%s): %d", programs[i].name, args.retval);
+		map = bpf_object__find_map_by_name(*self->skel->skeleton->obj,
+							  programs[i].name + 4);
+		ASSERT_OK_PTR(map) TH_LOG("can not find struct_ops by name '%s'",
+					  programs[i].name + 4);
 
-		self->hid_links[i] = args.retval;
+		self->hid_links[i] = bpf_map__attach_struct_ops(map);
+		ASSERT_OK_PTR(self->hid_links[i]) TH_LOG("failed to attach struct ops '%s'",
+							 programs[i].name + 4);
 	}
 
 	self->hidraw_fd = open_hidraw(self->dev_id);
@@ -648,13 +647,17 @@ TEST_F(hid_bpf, test_attach_detach)
 		{ .name = "hid_first_event" },
 		{ .name = "hid_second_event" },
 	};
+	struct bpf_link *link;
 	__u8 buf[10] = {0};
-	int err, link;
+	int err, link_fd;
 
 	LOAD_PROGRAMS(progs);
 
 	link = self->hid_links[0];
-	ASSERT_GT(link, 0) TH_LOG("HID-BPF link not created");
+	ASSERT_OK_PTR(link) TH_LOG("HID-BPF link not created");
+
+	link_fd = bpf_link__fd(link);
+	ASSERT_GE(link_fd, 0) TH_LOG("HID-BPF link FD not valid");
 
 	/* inject one event */
 	buf[0] = 1;
@@ -673,7 +676,7 @@ TEST_F(hid_bpf, test_attach_detach)
 
 	/* pin the first program and immediately unpin it */
 #define PIN_PATH "/sys/fs/bpf/hid_first_event"
-	err = bpf_obj_pin(link, PIN_PATH);
+	err = bpf_obj_pin(link_fd, PIN_PATH);
 	ASSERT_OK(err) TH_LOG("error while calling bpf_obj_pin");
 	remove(PIN_PATH);
 #undef PIN_PATH
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index f67d35def142..614f1aa32649 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -14,8 +14,8 @@ struct attach_prog_args {
 __u64 callback_check = 52;
 __u64 callback2_check = 52;
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx)
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
 {
 	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 3 /* size */);
 
@@ -29,8 +29,14 @@ int BPF_PROG(hid_first_event, struct hid_bpf_ctx *hid_ctx)
 	return hid_ctx->size;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_second_event, struct hid_bpf_ctx *hid_ctx)
+SEC(".struct_ops.link")
+struct hid_bpf_ops first_event = {
+	.hid_device_event = (void *)hid_first_event,
+	.hid_id = 2,
+};
+
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_second_event, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
 {
 	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
 
@@ -42,8 +48,13 @@ int BPF_PROG(hid_second_event, struct hid_bpf_ctx *hid_ctx)
 	return hid_ctx->size;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_change_report_id, struct hid_bpf_ctx *hid_ctx)
+SEC(".struct_ops.link")
+struct hid_bpf_ops second_event = {
+	.hid_device_event = (void *)hid_second_event,
+};
+
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_change_report_id, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
 {
 	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 3 /* size */);
 
@@ -55,15 +66,10 @@ int BPF_PROG(hid_change_report_id, struct hid_bpf_ctx *hid_ctx)
 	return 9;
 }
 
-SEC("syscall")
-int attach_prog(struct attach_prog_args *ctx)
-{
-	ctx->retval = hid_bpf_attach_prog(ctx->hid,
-					  ctx->prog_fd,
-					  ctx->insert_head ? HID_BPF_FLAG_INSERT_HEAD :
-							     HID_BPF_FLAG_NONE);
-	return 0;
-}
+SEC(".struct_ops.link")
+struct hid_bpf_ops change_report_id = {
+	.hid_device_event = (void *)hid_change_report_id,
+};
 
 struct hid_hw_request_syscall_args {
 	/* data needs to come at offset 0 so we can use it in calls */
@@ -181,7 +187,12 @@ static const __u8 rdesc[] = {
 	0xc0,			/* END_COLLECTION */
 };
 
-SEC("?fmod_ret/hid_bpf_rdesc_fixup")
+/*
+ * the following program is marked as sleepable (struct_ops.s).
+ * This is not strictly mandatory but is a nice test for
+ * sleepable struct_ops
+ */
+SEC("?struct_ops.s/hid_rdesc_fixup")
 int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hid_ctx)
 {
 	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4096 /* size */);
@@ -200,8 +211,13 @@ int BPF_PROG(hid_rdesc_fixup, struct hid_bpf_ctx *hid_ctx)
 	return sizeof(rdesc) + 73;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_test_insert1, struct hid_bpf_ctx *hid_ctx)
+SEC(".struct_ops.link")
+struct hid_bpf_ops rdesc_fixup = {
+	.hid_rdesc_fixup = (void *)hid_rdesc_fixup,
+};
+
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_test_insert1, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
 {
 	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
 
@@ -217,8 +233,14 @@ int BPF_PROG(hid_test_insert1, struct hid_bpf_ctx *hid_ctx)
 	return 0;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_test_insert2, struct hid_bpf_ctx *hid_ctx)
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_insert1 = {
+	.hid_device_event = (void *)hid_test_insert1,
+	.flags = BPF_F_BEFORE,
+};
+
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_test_insert2, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
 {
 	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
 
@@ -234,8 +256,13 @@ int BPF_PROG(hid_test_insert2, struct hid_bpf_ctx *hid_ctx)
 	return 0;
 }
 
-SEC("?fmod_ret/hid_bpf_device_event")
-int BPF_PROG(hid_test_insert3, struct hid_bpf_ctx *hid_ctx)
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_insert2 = {
+	.hid_device_event = (void *)hid_test_insert2,
+};
+
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_test_insert3, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
 {
 	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 4 /* size */);
 
@@ -250,3 +277,8 @@ int BPF_PROG(hid_test_insert3, struct hid_bpf_ctx *hid_ctx)
 
 	return 0;
 }
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_insert3 = {
+	.hid_device_event = (void *)hid_test_insert3,
+};
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 9cd56821d0f1..e02e24e3eab3 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -20,9 +20,6 @@
 #define HID_REQ_SET_REPORT       HID_REQ_SET_REPORT___not_used
 #define HID_REQ_SET_IDLE         HID_REQ_SET_IDLE___not_used
 #define HID_REQ_SET_PROTOCOL     HID_REQ_SET_PROTOCOL___not_used
-#define HID_BPF_FLAG_NONE        HID_BPF_FLAG_NONE___not_used
-#define HID_BPF_FLAG_INSERT_HEAD HID_BPF_FLAG_INSERT_HEAD___not_used
-#define HID_BPF_FLAG_MAX         HID_BPF_FLAG_MAX___not_used
 
 #include "vmlinux.h"
 
@@ -40,9 +37,6 @@
 #undef HID_REQ_SET_REPORT
 #undef HID_REQ_SET_IDLE
 #undef HID_REQ_SET_PROTOCOL
-#undef HID_BPF_FLAG_NONE
-#undef HID_BPF_FLAG_INSERT_HEAD
-#undef HID_BPF_FLAG_MAX
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
@@ -57,10 +51,8 @@ enum hid_report_type {
 };
 
 struct hid_bpf_ctx {
-	__u32 index;
-	const struct hid_device *hid;
+	struct hid_device *hid;
 	__u32 allocated_size;
-	enum hid_report_type report_type;
 	union {
 		__s32 retval;
 		__s32 size;
@@ -76,17 +68,14 @@ enum hid_class_request {
 	HID_REQ_SET_PROTOCOL		= 0x0B,
 };
 
-enum hid_bpf_attach_flags {
-	HID_BPF_FLAG_NONE = 0,
-	HID_BPF_FLAG_INSERT_HEAD = _BITUL(0),
-	HID_BPF_FLAG_MAX,
-};
+#ifndef BPF_F_BEFORE
+#define BPF_F_BEFORE (1U << 3)
+#endif
 
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,
 			      const size_t __sz) __ksym;
-extern int hid_bpf_attach_prog(unsigned int hid_id, int prog_fd, u32 flags) __ksym;
 extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
 extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
 extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,

-- 
2.44.0


