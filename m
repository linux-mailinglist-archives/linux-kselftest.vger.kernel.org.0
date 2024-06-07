Return-Path: <linux-kselftest+bounces-11401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594FC900904
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA889282C6C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB619D073;
	Fri,  7 Jun 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkPmT2Pq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3121990CE;
	Fri,  7 Jun 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774134; cv=none; b=Uo35OXDP/FSi2MkGn7fjvmcFvfVojg51BAmqveEjYzmIGylFOtpLm30zo71Gv4TjYCndWG10+2JIaVNFKKrz/jhqEkqtb+YRhNxDcPnal7etA6FmJwJY4YaaiGxVhh6aw2+kgSwPSHc4LGMUrcanZAGq5bVmfxw7pCrFj2IjS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774134; c=relaxed/simple;
	bh=A/OgJAoyz1jfOP1ujKz9EudGw2c1CaLUc4HxTAiFUBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsMfJbxIvydrU5XdDBKzb8XQmBWmoJZ5m5tL0Wjf9QTjwX0mHNwSRmqYHKxR0TKcAIDjU5qkD3HTcjpjjmAfek65fvJbp7IsTZSYWhIEzJfVhCmupEIwM7zeSeoVT+drCRJqxPTCozFPCDh5gMaBhR3zmUedqC+0m9rePocWkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkPmT2Pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9752BC4AF07;
	Fri,  7 Jun 2024 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774133;
	bh=A/OgJAoyz1jfOP1ujKz9EudGw2c1CaLUc4HxTAiFUBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KkPmT2Pq87JghkUNxCrqiCLkgwsimlIIj+YaVDk0G+ThK8FmOy1StGdnEaiGiCNIw
	 Dgd+piOfgVToDVLdBcF89vSMIpZpN4EIgtFgTghgdaMuOL7I9+hv0VgOkdD67uS7C5
	 w4buZHMo7JwRLW/Aa209eIu1LnlFzWH0RYI0YKged0aTWGaytGsV8lFUEvCcMZzBrr
	 T6DrmIJaoW4BtydPEuYVMxMFlQMnAuYp7m2hbObm1oeGvoBJdQJl7Q68xZjXMbu7Y6
	 3ucE687Ma0n4IlGf7H/bVoHj3coTfCUi/JDf+qI0TJ8fxOZTU95fJbIQocoLSDnjcz
	 QAPffffkug5YQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 07 Jun 2024 17:28:29 +0200
Subject: [PATCH HID v2 09/16] selftests/hid: add subprog call test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-hid_bpf_struct_ops-v2-9-3f95f4d02292@kernel.org>
References: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
In-Reply-To: <20240607-hid_bpf_struct_ops-v2-0-3f95f4d02292@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717774109; l=2901;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=A/OgJAoyz1jfOP1ujKz9EudGw2c1CaLUc4HxTAiFUBw=;
 b=WKHdgp6sz43nGVMHWLGQNJDDB4b1BpfKEc2/DH3NXYA79bUelM6WvtPrR743fW19VfA2TTW+8
 ErNo+3thuI4Ai7weQ7lu4CFzbohtb+vDXma/AFQ+6VFXt5UflzCYuDN
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

I got a weird verifier error with a subprog once, so let's have a test
for it.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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


