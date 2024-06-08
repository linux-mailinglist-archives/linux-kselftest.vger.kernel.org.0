Return-Path: <linux-kselftest+bounces-11479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2459010CE
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27FBF1F216F4
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 09:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E9117BB16;
	Sat,  8 Jun 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8s2XKvl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC217BB05;
	Sat,  8 Jun 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717837303; cv=none; b=ZY05vts3tQOu8c4+/VrNmH6O/5ibTB5cjgGtKrapFhqpwxm+vQGhS/9wZYcJiJh9sPYaTAoqAnou9+D9/FJl1HHZPCATtpFvFGAbNRP1eU22VcRTmuhQUIHOu9hWxp9aYFSBrwjmEMO/sAP7RMO38S5oNzih+bLeiEw6u8uVbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717837303; c=relaxed/simple;
	bh=XOXbeH+nudNU+hzpnIdjEwnDufgfsVsre+2aXUI0WiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3uejYcjZQTQxbzx/8S2kr01jtUul4cIoO2Jo74kfcqcNkxfiF03K+oZ7Z8/4hf2PBXZ6d+YjwxFIkyNDVPsn6lu9E9S5hbvcirsmC7pEKE9wz+PoVPufbExlJoPWkLlBv4rRMSGZKesCzz3NF1AxIh/QIuHeuc45xD3apmfFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8s2XKvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F015FC4AF07;
	Sat,  8 Jun 2024 09:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717837302;
	bh=XOXbeH+nudNU+hzpnIdjEwnDufgfsVsre+2aXUI0WiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M8s2XKvl1n2PjYS1RK31aB7WdFa+45SkLKeStgEp3AEMjWiFlt1LdIGjDXDc0cYcs
	 yFa6mnvLh9wMQ4KH2I3i5aohg46rZFzNxrxPXH3f2NnP4IJquCX0IsU1cHBZveRrJF
	 DDUVS4ER2g9itpSuInNVQwtl8guc6bwXXvAXYOflTodqOe27UoEdyVpXDEpFLlnxlN
	 LvNpY22Y+o1S1DhMWoIq59i5yApEe6eD2rdNxc76rnM4zE3crLzZ8Ww70uP7ynvDMs
	 7OWrkd20ZwJfsaHidbVHVIPZRw2fGRaUWA9C3wljkudwqHZM1NgczeOoxIc6C15RRn
	 w0YWn3WaDbdew==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Sat, 08 Jun 2024 11:01:21 +0200
Subject: [PATCH HID v3 09/16] selftests/hid: add subprog call test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240608-hid_bpf_struct_ops-v3-9-6ac6ade58329@kernel.org>
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717837279; l=2921;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=XOXbeH+nudNU+hzpnIdjEwnDufgfsVsre+2aXUI0WiI=;
 b=V31y0/GjRpPqF7HgJGM9p1Cw2elgDz5SrQlv1dbiy75zzpTo1Q+9z08Uoaky6BVAPJlWmwXYl
 35QpCTtQSGrCBwbN/2lVB1n/lexh0RunBG/WEwAd65OraaEodIMM+89
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

I got a weird verifier error with a subprog once, so let's have a test
for it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v3

no changes in v2
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
index 614f1aa32649..2e7e5a736dc6 100644
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


