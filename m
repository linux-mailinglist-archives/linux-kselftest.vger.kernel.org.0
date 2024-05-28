Return-Path: <linux-kselftest+bounces-10783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758408D1C8C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0781B244F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FD171E40;
	Tue, 28 May 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4R+nlNL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5E171679;
	Tue, 28 May 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902137; cv=none; b=eTx6B2MUjS+1osp8SFMCLwk895QC+pAy6AeYMfE4/6A6ZnE10uig/yhfswZBpTNnYTdOoKkDIaq0L/N5qJCA6WcvJSUylW8oc5HW4zpkqnJx5/RlwkxSmxiFZ3uxNLTZhD8XA+Y3n+jdR0GdK/kJSRJ3nY+noBLQjWwB+KcaQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902137; c=relaxed/simple;
	bh=r5PRmmxJaUk08rAPSCBzO9oSNG9qSKMUcqLqCcrKXiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTl8pU3S6m8Mb3m8G6TeRi9guMXkdnD0WO8cX9M1x9N0QoRejp3d9KPLpBpNe13JE36ZTGBiLt0C8JHTX2pq3EonHIWFA08NcyX+cdzzLtvrpn3oYJqdnyDWEoM+7Kg8+4PdmfPYpxZcopn7ySbWljtIhk5kuCjIzwvKiBctABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4R+nlNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A32C3277B;
	Tue, 28 May 2024 13:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902137;
	bh=r5PRmmxJaUk08rAPSCBzO9oSNG9qSKMUcqLqCcrKXiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a4R+nlNLumi2QM5Rv8uuN48nmEzt4Pj1X60btY+MADHG3O4nmsdzG1UjPRdEskAUl
	 Ql0R47Bd6wyKxm/tPeHOonVj6DTzPGdZAnIb/lZxylw3c64xx7/aITCLFc/MCYFepW
	 8gsQtDBedaEpJbFGKGJOOOCyDnQgy096qcRGnZewCQCDYPgKPE2p/PGPcLyNikQ0mz
	 /RwhOOEvyrdqQmujoBPkpZ7pI1etcYXcGbqZwI/JQs6RjZQv4X0dRXtn0ikW5LdhIc
	 qFbSWxFyP7gnix/fKuxSMACmsZoT5YyAElCoduX5sBzY1GVrqLfDFNPmAq8lan19jt
	 CY59CIpm7FFUA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 28 May 2024 15:14:47 +0200
Subject: [PATCH HID 09/13] selftests/hid: add subprog call test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-hid_bpf_struct_ops-v1-9-8c6663df27d8@kernel.org>
References: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
In-Reply-To: <20240528-hid_bpf_struct_ops-v1-0-8c6663df27d8@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716902113; l=2874;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=r5PRmmxJaUk08rAPSCBzO9oSNG9qSKMUcqLqCcrKXiQ=;
 b=Bb/kgLvMa2H3hEIhee/vec2iqeL/yB3axdtRrtdDBokZLYyrCJOgC7ir2UEXwkV6TTffDYk5r
 EdVtWZdCRUKB+HLe/6fAzN1E9G7QqrJmHMO38lFOEg/HkoJhS0gQ8UR
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

I got a weird verifier error with a subprog once, so let's have a test
for it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c   | 41 +++++++++++++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c | 24 +++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 967dfe6b58cb..45e173db35bd 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -638,6 +638,47 @@ TEST_F(hid_bpf, raw_event)
 	ASSERT_EQ(buf[2], 52);
 }
 
+/*
+ * Attach hid_first_event to the given uhid device,
+ * retrieve and open the matching hidraw node,
+ * inject one event in the uhid device,
+ * check that the program sees it and can change the data
+ */
+TEST_F(hid_bpf, subprog_raw_event)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_subprog_first_event" },
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
+	ASSERT_EQ(buf[2], 47);
+
+	/* inject another event */
+	memset(buf, 0, sizeof(buf));
+	buf[0] = 1;
+	buf[1] = 47;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[2], 52);
+}
+
 /*
  * Ensures that we can attach/detach programs
  */
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 9adace26e8aa..efa3c7d292bc 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -35,6 +35,30 @@ struct hid_bpf_ops first_event = {
 	.hid_id = 2,
 };
 
+int __hid_subprog_first_event(struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
+{
+	__u8 *rw_data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 3 /* size */);
+
+	if (!rw_data)
+		return 0; /* EPERM check */
+
+	rw_data[2] = rw_data[1] + 5;
+
+	return hid_ctx->size;
+}
+
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_subprog_first_event, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
+{
+	return __hid_subprog_first_event(hid_ctx, type);
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops subprog_first_event = {
+	.hid_device_event = (void *)hid_subprog_first_event,
+	.hid_id = 2,
+};
+
 SEC("?struct_ops/hid_device_event")
 int BPF_PROG(hid_second_event, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
 {

-- 
2.44.0


