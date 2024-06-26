Return-Path: <linux-kselftest+bounces-12809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC68918342
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5D6B22B52
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B2518E744;
	Wed, 26 Jun 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnLkus0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746E18C35C;
	Wed, 26 Jun 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409633; cv=none; b=KytstjYPYD95HHvt+rxL7nS+qvLGcXQO5BrpNMpIHSfFh3PX3yFjpZnoBGDZGUly635oRWlM9NJdV2tpK04mMJ3P7VKFyorxdWX/m23dE6lnSFKYVZ0ELWC5rQLMsIUjOEQ1gINeun8jwUQn6r7081i/MduJAbnODKTitPz+PQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409633; c=relaxed/simple;
	bh=8DVfI5Mgh3sBj3CpzjHKwk7ojiMdJpUgU0LXrBaKg2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URdVfHAo3IPgOENqsE5SynGoHdFD0MuKtl8/hr3nUFhG7g75lQnkSNUs3zYwYnfivLIye66fJDD5t9/DvPlcSZndwca3LwppeEdjfw+IAvc9yJAWtLGynXZ6Osbu7ojSy7zeXxC8VSsbgu/1LPagesYlfWLd9oqtt6US3JksFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnLkus0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D388DC32782;
	Wed, 26 Jun 2024 13:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719409632;
	bh=8DVfI5Mgh3sBj3CpzjHKwk7ojiMdJpUgU0LXrBaKg2c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AnLkus0ScJlNtHUTw9KITY2V/hjtnycgXxOlFC6L5c1V24zrpjWKsjW8TkYOaVf3v
	 9CItVAIaGnzFxkKbnhCVlRZ4/CwyQlgqkAw8SQv5sO3n46QT5juEiOCD8lgLZgFitt
	 tiewbBnUoZqfVRSobPMgMIiGe40JN9fqfOHztEpTIa6cgNo+fl68HT9W/Ucdl9ykBw
	 Mmjr2nxEXyYoRfH6pcaazP/ZcoBbK7ey7QVtmZzHfV52BISMc8DeTNRIdf8Eo0Xnm+
	 a7DXzkiDeOrKeetS+wTOSxFZRqNti19Ibj3OJl2v2sO15iYRtsQtwZVnJgu+bKJuRb
	 qmprk5Se1UmAw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 26 Jun 2024 15:46:33 +0200
Subject: [PATCH HID v2 12/13] selftests/hid: add another test for injecting
 an event from an event hook
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-hid_hw_req_bpf-v2-12-cfd60fb6c79f@kernel.org>
References: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
In-Reply-To: <20240626-hid_hw_req_bpf-v2-0-cfd60fb6c79f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719409602; l=4137;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=8DVfI5Mgh3sBj3CpzjHKwk7ojiMdJpUgU0LXrBaKg2c=;
 b=DvtSTPl9Sbeel8MPOCTiv0xr/zIBIx8/BnIBFF/7gK7Yik5kufwDTjLOlFE4C8CavsG79lPZW
 dAQDSh/zHOnAqyrKfAvW448xXEFrBMKWxNpmKPQHR6ixZeHhFdbGTj6
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Similar to test_multiply_events_wq: we receive one event and inject a
new one. But given that this time we are already in the event hook, we
can use hid_bpf_try_input_report() directly as this function will not
sleep.

Note that the injected event gets processed before the original one this
way.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v2
---
 tools/testing/selftests/hid/hid_bpf.c              | 36 ++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c            | 39 ++++++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  4 +++
 3 files changed, 79 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 31637b3b8db5..36bbad8e0f9f 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -1168,6 +1168,42 @@ TEST_F(hid_bpf, test_multiply_events_wq)
 	ASSERT_EQ(buf[1], 3);
 }
 
+/*
+ * Attach hid_multiply_event to the given uhid device,
+ * retrieve and open the matching hidraw node,
+ * inject one event in the uhid device,
+ * check that the program sees it and can add extra data
+ */
+TEST_F(hid_bpf, test_multiply_events)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_test_multiply_events" },
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
+	ASSERT_EQ(err, 9) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 2);
+	ASSERT_EQ(buf[1], 47);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 9) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 2);
+	ASSERT_EQ(buf[1], 52);
+}
+
 /*
  * Attach hid_insert{0,1,2} to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index f539a7a223cf..46feeb91d1d5 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -522,3 +522,42 @@ SEC(".struct_ops.link")
 struct hid_bpf_ops test_multiply_events_wq = {
 	.hid_device_event = (void *)hid_test_multiply_events_wq,
 };
+
+SEC("?struct_ops/hid_device_event")
+int BPF_PROG(hid_test_multiply_events, struct hid_bpf_ctx *hid_ctx, enum hid_report_type type)
+{
+	__u8 *data = hid_bpf_get_data(hid_ctx, 0 /* offset */, 9 /* size */);
+	__u8 buf[9];
+	int ret;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	if (data[0] != 1)
+		return 0;
+
+	/*
+	 * we have to use an intermediate buffer as hid_bpf_input_report
+	 * will memset data to \0
+	 */
+	__builtin_memcpy(buf, data, sizeof(buf));
+
+	buf[0] = 2;
+	buf[1] += 5;
+	ret = hid_bpf_try_input_report(hid_ctx, HID_INPUT_REPORT, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * In real world we should reset the original buffer as data might be garbage now,
+	 * but it actually now has the content of 'buf'
+	 */
+	data[1] += 5;
+
+	return 9;
+}
+
+SEC(".struct_ops.link")
+struct hid_bpf_ops test_multiply_events = {
+	.hid_device_event = (void *)hid_test_multiply_events,
+};
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 8014383846d2..c72e44321764 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -89,6 +89,10 @@ extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx,
 				enum hid_report_type type,
 				__u8 *data,
 				size_t buf__sz) __ksym;
+extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx,
+				    enum hid_report_type type,
+				    __u8 *data,
+				    size_t buf__sz) __ksym;
 
 /* bpf_wq implementation */
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;

-- 
2.44.0


