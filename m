Return-Path: <linux-kselftest+bounces-4421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C87684F5F5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD16728157C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8CF4CB4A;
	Fri,  9 Feb 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um0TGCHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED024CB46;
	Fri,  9 Feb 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485255; cv=none; b=VIx6mz9CHxEQUwLCRV9Gjotrheno55dTpX12GCp56NkRlQ6A42ODlC+2ogACDWZB8olnQJkuksPhs+QPYJAIC1slJGNsuwNKTLLx1Zj5LVydZIL7wIT37FQRnDcu8Sonkdm2PQUNx9nLMAeIsOQ5z/BXagl+xDndaFRBo08AXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485255; c=relaxed/simple;
	bh=H0gLlcpEumNfAiH5R8Kkgzp2VRzJiLxk+3xmyFUI2lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sE36kRnc/zKSMfsUCGWbJN8nN5+K+LyAFJC5SN/QVqMVwgjPT8uhGMDlw0fPVgOJQhzxjaaAXn2YSu4l7YdgNcQ4WarPAREbzZEKPo3+GGqNQHQKC4c4JnJQMKmxICYYvlMnKAHxa8Z5/fEgTCcJlneHRhteaXha8Yqag286sO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um0TGCHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71B4C43390;
	Fri,  9 Feb 2024 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485254;
	bh=H0gLlcpEumNfAiH5R8Kkgzp2VRzJiLxk+3xmyFUI2lw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Um0TGCHkgKtLBNIkimbr6PYvAdg7qvHUflw+EskWi5z/i463yQ3vMkU/vqqEkdRZk
	 fIAROqsCBLPhgwnd3AXxZEGpX7HPmieJPw2alzlt+2ea/bYR/YJXnzlFqITodD2tvV
	 IEvRL8Yl1vxo7aZaB/IYH57nRI3tQF54Evo67Iv4iK11JzyLyVyj1z7jdzEksEXqA6
	 kf/GpzlaZd1CyDqLq5rztRNskvWZZw/suktTw4nPhD6SeEMc95IbS//BqRRgRBwrJU
	 8wxND/dDMhLQWIRreeaRdJd0tBmgzeQDiKkaluy3J2DdHofHp5jcjkevDGWCPdb7Ke
	 US1ViUJHs7GEw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 09 Feb 2024 14:26:44 +0100
Subject: [PATCH RFC bpf-next 8/9] selftests/hid: add test for
 hid_bpf_schedule_delayed_work
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-hid-bpf-sleepable-v1-8-4cc895b5adbd@kernel.org>
References: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
In-Reply-To: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707485215; l=4855;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=H0gLlcpEumNfAiH5R8Kkgzp2VRzJiLxk+3xmyFUI2lw=;
 b=rtrZl5HgR5dYOE0lcHQb801FGiFw3TVlcpDkAghh7CIxxxR5SPZHgxJWqXYs7jHXehPDxjGEK
 tLTDQnUgsbRCW6pWhAp2mvcs7G22tuFKJg9VW2otqG+wwEtYMUy9pMO
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This test checks that we can actually execute in a sleepable context
the job called by hid_bpf_offload().

When an event is injected, we push it on a map of type queue and schedule
a work.
When that work kicks in, it pulls the event from the queue, and wakes
up userspace through a ring buffer.

The use of the ring buffer is there to not have sleeps in userspace
because we have no guarantees of the timing of when those jobs will be
called.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c              | 57 ++++++++++++++++++++++
 tools/testing/selftests/hid/progs/hid.c            | 55 +++++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |  2 +
 3 files changed, 114 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index 9ff02c737144..bb95ff90951b 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -875,6 +875,63 @@ TEST_F(hid_bpf, test_hid_user_raw_request_call)
 	ASSERT_EQ(args.data[1], 2);
 }
 
+static __u8 workload_data;
+
+static int handle_event(void *ctx, void *data, size_t data_sz)
+{
+	const __u8 *e = data;
+
+	workload_data = *e;
+
+	return 0;
+}
+
+/*
+ * Call hid_bpf_schedule_delayed_work against the given uhid device,
+ * check that the program is called and does the expected.
+ */
+TEST_F(hid_bpf, test_hid_schedule_work)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_defer_event" },
+		{ .name = "hid_offload_notify" },
+	};
+	struct ring_buffer *rb = NULL;
+	__u8 buf[10] = {0};
+	__u32* delay;
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* Set up ring buffer polling */
+	rb = ring_buffer__new(bpf_map__fd(self->skel->maps.rb), handle_event, NULL, NULL);
+	ASSERT_OK_PTR(rb) TH_LOG("Failed to create ring buffer");
+	ASSERT_EQ(workload_data, 0);
+
+	delay = (__u32 *)&buf[2];
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 42; /* this will be placed in the ring buffer */
+	*delay = 0;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	err = ring_buffer__poll(rb, 100 /* timeout, ms */);
+	ASSERT_EQ(err, 1) TH_LOG("error while calling ring_buffer__poll");
+
+	ASSERT_EQ(workload_data, 42);
+
+	/* inject one another */
+	buf[0] = 1;
+	buf[1] = 53; /* this will be placed in the ring buffer */
+	*delay = 100;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	err = ring_buffer__poll(rb, 1000 /* timeout, ms */);
+	ASSERT_EQ(err, 1) TH_LOG("error while calling ring_buffer__poll");
+	ASSERT_EQ(workload_data, 53);
+}
+
 /*
  * Attach hid_insert{0,1,2} to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index f67d35def142..95a03fb0494a 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -250,3 +250,58 @@ int BPF_PROG(hid_test_insert3, struct hid_bpf_ctx *hid_ctx)
 
 	return 0;
 }
+
+struct test_report {
+	__u8 data[6];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 8);
+	__type(value, struct test_report);
+} queue SEC(".maps");
+
+struct {
+    __uint(type, BPF_MAP_TYPE_RINGBUF);
+    __uint(max_entries, 8);
+} rb SEC(".maps");
+
+SEC("?fmod_ret.s/hid_bpf_offload")
+int BPF_PROG(hid_offload_notify, struct hid_bpf_ctx *hid_ctx)
+{
+	struct test_report buf;
+	__u8 *rb_elem;
+
+	if (bpf_map_pop_elem(&queue, &buf))
+		return 0;
+
+	rb_elem = bpf_ringbuf_reserve(&rb, sizeof(*rb_elem), 0);
+	if (!rb_elem)
+		return 0;
+
+	*rb_elem = buf.data[1];
+
+	bpf_ringbuf_submit(rb_elem, 0);
+
+	return 0;
+}
+
+SEC("?fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_defer_event, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 6 /* size */);
+	struct test_report buf;
+	__u32 delay;
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	__builtin_memcpy(&buf.data, data, 6);
+
+	delay = *(__u32 *)&data[2];
+
+	bpf_map_push_elem(&queue, &buf, BPF_ANY);
+	hid_bpf_schedule_delayed_work(hctx, delay);
+
+	return -1; /* discard the event */
+}
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 9cd56821d0f1..a844c7e89766 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -100,5 +100,7 @@ extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx,
 				enum hid_report_type type,
 				__u8 *data,
 				size_t buf__sz) __ksym;
+extern bool hid_bpf_schedule_delayed_work(struct hid_bpf_ctx *ctx,
+					  unsigned int delay_ms) __ksym;
 
 #endif /* __HID_BPF_HELPERS_H */

-- 
2.43.0


