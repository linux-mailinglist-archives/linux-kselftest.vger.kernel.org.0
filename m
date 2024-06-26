Return-Path: <linux-kselftest+bounces-12806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F7918329
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB1A1F21BC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CDE1891CE;
	Wed, 26 Jun 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPs0rGUd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6881891C3;
	Wed, 26 Jun 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409628; cv=none; b=L/tH5lvngPpeg1qUuQGP6QRPHCcpw3wcNj59vn3HTVOWO3zu1URKU4vB6ZMYzpTHkJ0Xcu3AUc910UKnGEbHMBP1ySEEbjK2ICqFeoWI4NospCkJxpuMpgFA4WZC6L3HwxnB50PB08D2KAUeXPyeKBafHVKhkUkU0xcUYaP2suE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409628; c=relaxed/simple;
	bh=pVxR2nGx0Ldj0qc8SZTnUn3ognYwSYvy6WKN1a2jEOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5ABVKxaxtHvBwnTDtayNAhTBxaJ+s/oJfeHSVAjSiA+3SoawM/MT/gUc+WgaBmxfScdCna7gScgeFVq1eaj5j9L9IpLQjOv/Fy64QShKL767Z634LMTGDzOd9Dzyb3hT/QTe7N5CO3ljuW5U9R3tLiDl0hLvhtsbx5oaNCR3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPs0rGUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F81C32782;
	Wed, 26 Jun 2024 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409628;
	bh=pVxR2nGx0Ldj0qc8SZTnUn3ognYwSYvy6WKN1a2jEOQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IPs0rGUd9+VabFx5u5Xb+b655SWr5iHyktQnsgeUJfuzxi6q5DFrUP3D7W4383e13
	 uJYzPcsBXjgNumaINSL+vCBE76p6UGbFHeNHS/0/NwDLVfSNVzB++Mxj8JiZbY33jp
	 nogx/SGSoPqsqswrM+eHU7a0kXFsx+19xloeDpGL/X7HMG65SE46tdgnOlEdzrxUa9
	 Irc3BZ+9VFSV1S7CF+TdBgWREMEH//yArZcVX1wFrFhrdzTDVihEjJR2iUygcIPikJ
	 itVSAKdKqUnWRgJVk8fJD4XXaanP61Ub/I9i+05z5uwxFVnP/t8m+UXsxXRjf+R9x0
	 fKBM/EJ/ZxCcA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:31 +0200
Subject: [PATCH HID v2 10/13] selftests/hid: add wq test for
 hid_bpf_input_report()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-10-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=4993;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=pVxR2nGx0Ldj0qc8SZTnUn3ognYwSYvy6WKN1a2jEOQ=;
 b=d3PEEctrWjmF8CwiJUVeQMdGr7PihHRawOlWusQBes+Nb24I8nncPVMJMf0FjUoE5aZv4PYzW
 9RVgvIjMVCcAFCi2h3LLpKhqZZAEIU0hgBhxzL7d19RKI2R770G2UWL
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Now that bpf_wq is available, we can write a test with it. Having
hid_bpf_input_report() waiting for the device means that we can
directly call it, and we get that event when the device is ready.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
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


