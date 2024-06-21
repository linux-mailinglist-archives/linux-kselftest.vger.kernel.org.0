Return-Path: <linux-kselftest+bounces-12425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D411911FBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFFC1C22318
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A006171062;
	Fri, 21 Jun 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzGfzPmm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0917D170840;
	Fri, 21 Jun 2024 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960207; cv=none; b=YMJJzsg4DKJwVPWAHXiX5b0wfwBGmE8bsZ40tJcRxapB+IrcAS2LBlH/VUByzd8zJkS8aU6IFDqOVGB0T3w1v4+LefHSWIfOp5F143AK/ppOuuUlV2RsN3OMcJFa5BMK00PT6lu8MEJTPNmC2+gacwrxglrsdCzmUP5Lo40zF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960207; c=relaxed/simple;
	bh=Sidr9IVF098YrvDo8tE8SvxCe8xbfdabUMipWl2Dckk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vs5qOlsgTQw65tMC1pDGO0AoklftpS/+YvB5oHEXjxVlCJFOOYTk6xwZDeHtwm2oNWRZluuXZuFFfz5bqkV2VA21LZw8TPWeYGfnW6Vn9SRuksnNPruu71400LWDPLEsC2QMrAL8Lc9aAbyNsO9MOZBG+6o6pbHOSeb6CKUk1J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzGfzPmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A656C4AF0C;
	Fri, 21 Jun 2024 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718960206;
	bh=Sidr9IVF098YrvDo8tE8SvxCe8xbfdabUMipWl2Dckk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TzGfzPmmxTJSPqBejpsmOAjlFHkBYuonHHSREgg25ctIb9IVoocyLosFVYipZpP+A
	 9lY8OumyGeFgM9+9bjYSmXTN8cSQGvyxihBJ0gsBUlTDGyNLWnEBzIAuLFinV9ZfaJ
	 Moq/GHVRem3zix8NncWpeBTe36HgRCcuowSQ4nY7LoLuwEDQvgvVsGUsrYGKEyPs+M
	 QhzFflrseB6JNbxu9EEhT8/DDlsSr+1BBhsyhya8+liGyC8JMqgHZDg7TAUNslr9JZ
	 iu+sF6hr/dHaWZ+TDv6ipFS+Kz6z0eOSgDDxidvoLodE8JbLpdudaprvY/mZMGQiiy
	 6pjbyOYCMxEoQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 21 Jun 2024 10:55:56 +0200
Subject: [PATCH HID 11/12] selftests/hid: add another test for injecting an
 event from an event hook
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-hid_hw_req_bpf-v1-11-d7ab8b885a0b@kernel.org>
References: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
In-Reply-To: <20240621-hid_hw_req_bpf-v1-0-d7ab8b885a0b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718960178; l=4110;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Sidr9IVF098YrvDo8tE8SvxCe8xbfdabUMipWl2Dckk=;
 b=NhOXj2Ezd5nDWXRhqA+zAmx7G2MwN/Ogtx7EeThVNapoXrMYVEtVNMCqPhIbjq0CLZyHGrQBa
 hL5rN61ZcnfD3AK6Nqn3TRSp8/5fiH6jzGuUbqfMQyMhHsLltPkYW0E
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


