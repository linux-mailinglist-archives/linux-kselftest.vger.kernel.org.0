Return-Path: <linux-kselftest+bounces-12423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE57911FB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB84C1C23754
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA2C16FF4C;
	Fri, 21 Jun 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y95VSf8S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7416FF45;
	Fri, 21 Jun 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960202; cv=none; b=CGLJn7pjiicfnCKx06r4oEBF/hKbRKrR+xHb+d0Xd48C3UO+Jlw4KGhPopSyT0TvPPQ+Fcj1M05wQN0SIOxp1a2v+qJC8q6JJPLg/0WXYm9kTIWoHABAnqIp+eH0HV0m9OfbKHEAwfMJ9Jx5JzpEJ1HsksWTHFNg7Quw81EUFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960202; c=relaxed/simple;
	bh=qgIL2pfeVPMy+yjTbCR/4FWbbSxIm5yu+kZ643MTzrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0Kdt9Jn1z5vEYgDWptiSmeJ8xmZNcz72g6JAuDbxZmNR2p962H0f/KvEosHU7FS8G2m1cpUjIkVxvMi04I6FgLCfEhYYqa/ZbyzT1bdduFIyM+nPPOuWM4zKUzKA8DHKkzO1asQNYTkRQjSL8nDRShfFxsfzv+xRV3W2HJX8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y95VSf8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8ABC2BBFC;
	Fri, 21 Jun 2024 08:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960201;
	bh=qgIL2pfeVPMy+yjTbCR/4FWbbSxIm5yu+kZ643MTzrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y95VSf8SDU9SlJZS3K94It9+oBmTJNhgsLGi/fEPJuMdzRve5GAq70H3yVMZV5hq9
	 RbVSQnKuB3v4QSFHcKY2vdyqqDc9gS/BaBiJrm5u1C9WrWR0LxVz9TbXmE8y6KhPNQ
	 o/X+PZD7RLTRwsujGb+FMyLzsck/bXj165leFCmUkbs+2n35wI7ikR/ms+1Em7pybW
	 kUq+02OCb2hCGvjqje6AxrGg+Q9hmLI+ZucSFHApz58wNEaiVyAty87HCfTLx81p/D
	 DfUSinhrkajmMfYRRLv7xzytsdeuDhf3aNo5TqdgxtTMiwDpWvvfsNrdic1f1AROcD
	 EUc3kwGNmJy8A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:54 +0200
Subject: [PATCH HID 09/12] selftests/hid: add wq test for
 hid_bpf_input_report()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-9-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=4966;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=qgIL2pfeVPMy+yjTbCR/4FWbbSxIm5yu+kZ643MTzrs=;
 b=BS/dL3KjFvBYFfc7XdxqRZNVJq1IDX8G1kq3v141lK30YIl/FypTAT6K8aJAoAgQaVOLTyYZH
 BFKKgLtI0KpDZaWpOjfQG+QhVqPGv+ArOMrwho0enhOjHbWsiP/AhYF
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Now that bpf_wq is available, we can write a test with it. Having
hid_bpf_input_report() waiting for the device means that we can
directly call it, and we get that event when the device is ready.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c              | 38 +++++++++++
 tools/testing/selftests/hid/progs/hid.c            | 79 ++++++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  9 +++
 3 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 40aedd1d9dc5..31637b3b8db5 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -1130,6 +1130,44 @@ TEST_F(hid_bpf, test_hid_infinite_loop_output_report_call)
 				 err);
 }
 
+/*
+ * Attach hid_multiply_event_wq to the given uhid device,
+ * retrieve and open the matching hidraw node,
+ * inject one event in the uhid device,
+ * check that the program sees it and can add extra data
+ */
+TEST_F(hid_bpf, test_multiply_events_wq)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_multiply_events_wq" },
+	};
+	__u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 1);
+	ASSERT_EQ(buf[1], 47);
+
+	usleep(100000);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 9) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 2);
+	ASSERT_EQ(buf[1], 3);
+}
+
 /*
  * Attach hid_insert{0,1,2} to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 1fa288b76cd5..f539a7a223cf 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -443,3 +443,82 @@ SEC(".struct_ops.link")
 struct hid_bpf_ops test_infinite_loop_output_report = {
 	.hid_hw_output_report = (void *)hid_test_infinite_loop_output_report,
 };
+
+struct elem {
+	struct bpf_wq work;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} hmap SEC(".maps");
+
+static int wq_cb_sleepable(void *map, int *key, struct bpf_wq *work)
+{
+	__u8 buf[9] = {2, 3, 4, 5, 6, 7, 8, 9, 10};
+	struct hid_bpf_ctx *hid_ctx;
+
+	hid_ctx = hid_bpf_allocate_context(*key);
+	if (!hid_ctx)
+		return 0; /* EPERM check */
+
+	hid_bpf_input_report(hid_ctx, HID_INPUT_REPORT, buf, sizeof(buf));
+
+	hid_bpf_release_context(hid_ctx);
+
+	return 0;
+}
+
+static int test_inject_input_report_callback(int *key)
+{
+	struct elem init = {}, *val;
+	struct bpf_wq *wq;
+
+	if (bpf_map_update_elem(&hmap, key, &init, 0))
+		return -1;
+
+	val = bpf_map_lookup_elem(&hmap, key);
+	if (!val)
+		return -2;
+
+	wq = &val->work;
+	if (bpf_wq_init(wq, &hmap, 0) != 0)
+		return -3;
+
+	if (bpf_wq_set_callback(wq, wq_cb_sleepable, 0))
+		return -4;
+
+	if (bpf_wq_start(wq, 0))
+		return -5;
+
+	return 0;
+}
+
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_test_multiply_events_wq, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
+{
+	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 9 /* size */);
+	int hid = hid_ctx->hid->id;
+	int ret;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	if (data[0] != 1)
+		return 0;
+
+	ret = test_inject_input_report_callback(&hid);
+	if (ret)
+		return ret;
+
+	data[1] += 5;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_multiply_events_wq = {
+	.hid_device_event = (void *)hid_test_multiply_events_wq,
+};
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index e02e24e3eab3..8014383846d2 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -90,4 +90,13 @@ extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx,
 				__u8 *data,
 				size_t buf__sz) __ksym;
 
+/* bpf_wq implementation */
+extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
+extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
+extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
+		int (callback_fn)(void *map, int *key, struct bpf_wq *wq),
+		unsigned int flags__k, void *aux__ign) __ksym;
+#define bpf_wq_set_callback(timer, cb, flags) \
+	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
+
 #endif /* __HID_BPF_HELPERS_H */

-- 
2.44.0


