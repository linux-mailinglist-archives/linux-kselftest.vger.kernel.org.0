Return-Path: <linux-kselftest+bounces-4422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B9084F5FA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4310B242D7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2EE3C68E;
	Fri,  9 Feb 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8WIXYGR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B394D5AB;
	Fri,  9 Feb 2024 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485259; cv=none; b=t0JjwK9IMYoAhHuLgnYABTm4t6YCEROMAkY1TCWN2EDzpOoPLCIK5p/0Kb5NRS0FmyeuX5Q2cvge2f/XxdRaGHZM9f2Nu8cea7uirHgud2zG13xhsUjpvgd4u+4giVcAeSuuh4+yXw4S8rSKQBJ9P9oHUrOy0pNGlYehhsYG3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485259; c=relaxed/simple;
	bh=jM/C5jtwVf0QJjaGgspEoLrblvAlR1ayXyxrrBAm8pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJrbS3AB77ghSu1cBtjA6BQIXjb/9AwT2BCleK/xrqonHTnOLL6XXQihCWSoY9xMphIjPOA/2z6nkeapZdgnpmeWEKZA411ZlEImoW6gaBGB/8P2YQb5Wp5nRGS/Z/3QeTv4Q/KRPEsdft8Cc7loc/8piBPuGwh009plnVAeV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8WIXYGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED04C433C7;
	Fri,  9 Feb 2024 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485259;
	bh=jM/C5jtwVf0QJjaGgspEoLrblvAlR1ayXyxrrBAm8pA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X8WIXYGRhmj7hFUqMyexhVYThi2sF/ij+YjoQTJ7St6GMnoCmL+b1bXakuw/OWgGN
	 ZS5vy26a9mYEcG35/4v3RMG5zhJEAzvWWbKumQzp0OaAhGSpCdfJRPn8L+sfoz8Dqj
	 ZPzecYfx/V4ABvoNDaah0dYOO/R8kZS7zF5C9vcqCNNYbJnY94OjtZjGw5UgzDCcNv
	 ojxcJPJbMKFFGJ0xf8IkF0az5s+vdrPxItNjbGJ2utUAYWjhIQ7K/DHxWgiJbOdlKh
	 KxHxpjZNCGAvhYYw4ZpPJqA9M4AcLEtzANNp/mhcAwQJD1yMXMhBn3qKTw996OWfsu
	 330WJn4byK4MA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 09 Feb 2024 14:26:45 +0100
Subject: [PATCH RFC bpf-next 9/9] selftests/hid: add another set of delayed
 work tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-hid-bpf-sleepable-v1-9-4cc895b5adbd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707485215; l=8833;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=jM/C5jtwVf0QJjaGgspEoLrblvAlR1ayXyxrrBAm8pA=;
 b=qfE7wPQabDS3Vhlac4p2GGeIyPLzKx60tcbpGooUBQtWQlmUIHMWMF/YKok7+eAMVA3fM8QDd
 b54vvFoYGWaB5c4ibcAnqntifN6PrneNb3IOlH1RGwXtr5EqhUwS646
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

These ones are a little bit more complex, but allows to check whether
sleepable tracing functions can be called:

- one event is injected and then pushed into the queue map
- optionally another event gets injected in the queue map
- the events in the queue are then re-injected in the HID stack
- if there is an error, while re-injecting it, we try again 5 ms later
- ensure we can add another event in the queue or call other sleepable
  kfuncs
- ensure we receive the correct events and exactly them

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/hid_bpf.c   | 117 +++++++++++++++++++++++++++++++-
 tools/testing/selftests/hid/progs/hid.c | 104 ++++++++++++++++++++++++++++
 2 files changed, 220 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index bb95ff90951b..cfa42d603acb 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -460,7 +460,7 @@ FIXTURE(hid_bpf) {
 	int hid_id;
 	pthread_t tid;
 	struct hid *skel;
-	int hid_links[3]; /* max number of programs loaded in a single test */
+	int hid_links[4]; /* max number of programs loaded in a single test */
 };
 static void detach_bpf(FIXTURE_DATA(hid_bpf) * self)
 {
@@ -932,6 +932,121 @@ TEST_F(hid_bpf, test_hid_schedule_work)
 	ASSERT_EQ(workload_data, 53);
 }
 
+/*
+ * Call hid_bpf_schedule_delayed_work against the given uhid device,
+ * ensure we can inject events (call a sleepable tracing function),
+ * check that the program is called and does the expected.
+ */
+TEST_F(hid_bpf, test_hid_schedule_work_defer_events)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_defer_event" },
+		{ .name = "hid_offload_inject", .insert_head = 1 },
+		{ .name = "hid_offload_multiply_events" },
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
+	err = ring_buffer__poll(rb, 1000 /* timeout, ms */);
+	ASSERT_EQ(err, 1) TH_LOG("error while calling ring_buffer__poll");
+	ASSERT_EQ(workload_data, 52);
+
+	/* read twice the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 2);
+	ASSERT_EQ(buf[1], 42);
+
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 2);
+	ASSERT_EQ(buf[1], 52);
+
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, -1) TH_LOG("read_hidraw: too many events");
+}
+
+TEST_F(hid_bpf, test_hid_schedule_work_defer_events_2)
+{
+	const struct test_program progs[] = {
+		{ .name = "hid_defer_multiple_events" },
+		{ .name = "hid_offload_inject", .insert_head = 1 },
+		{ .name = "hid_offload_hw_request" },
+		{ .name = "hid_offload_notify" },
+	};
+	struct ring_buffer *rb = NULL;
+	__u8 buf[10] = {0};
+	int err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* Set up ring buffer polling */
+	rb = ring_buffer__new(bpf_map__fd(self->skel->maps.rb), handle_event, NULL, NULL);
+	ASSERT_OK_PTR(rb) TH_LOG("Failed to create ring buffer");
+	ASSERT_EQ(workload_data, 0);
+
+	/* inject one event */
+	buf[0] = 1;
+	buf[1] = 47;
+	buf[2] = 50;
+	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
+
+	err = ring_buffer__poll(rb, 100 /* timeout, ms */);
+	ASSERT_EQ(err, 1) TH_LOG("error while calling ring_buffer__poll");
+	ASSERT_EQ(workload_data, 3);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 2);
+	ASSERT_EQ(buf[1], 3);
+	ASSERT_EQ(buf[2], 4) TH_LOG("leftovers_from_previous_test");
+
+	err = ring_buffer__poll(rb, 100 /* timeout, ms */);
+	ASSERT_EQ(err, 1) TH_LOG("error while calling ring_buffer__poll");
+	ASSERT_EQ(workload_data, 4);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
+	ASSERT_EQ(buf[0], 2);
+	ASSERT_EQ(buf[1], 4);
+	ASSERT_EQ(buf[2], 6);
+
+	/* read the data from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, -1) TH_LOG("read_hidraw");
+}
+
 /*
  * Attach hid_insert{0,1,2} to the given uhid device,
  * retrieve and open the matching hidraw node,
diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 95a03fb0494a..aae8d7a0699e 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -286,6 +286,63 @@ int BPF_PROG(hid_offload_notify, struct hid_bpf_ctx *hid_ctx)
 	return 0;
 }
 
+SEC("?fmod_ret.s/hid_bpf_offload")
+int BPF_PROG(hid_offload_multiply_events, struct hid_bpf_ctx *hid_ctx)
+{
+	struct test_report buf;
+	int err;
+
+	/* do not pop the event, it'll be done in hid_offload_test() when
+	 * notifying user space, this also allows to retry sending it
+	* if hid_bpf_input_report fails */
+	if (bpf_map_peek_elem(&queue, &buf))
+		return 0;
+
+	buf.data[1] += 10;
+	/* inject another event to be processed */
+	if (buf.data[1] < 60)
+		bpf_map_push_elem(&queue, &buf, BPF_ANY);
+
+	return 0;
+}
+
+SEC("?fmod_ret.s/hid_bpf_offload")
+int BPF_PROG(hid_offload_inject, struct hid_bpf_ctx *hid_ctx)
+{
+	struct test_report buf;
+	int err;
+
+	/* do not pop the event, it'll be done in hid_offload_test() when
+	 * notifying user space, this also allows to retry sending it
+	* if hid_bpf_input_report fails */
+	if (bpf_map_peek_elem(&queue, &buf))
+		return 0;
+
+	buf.data[0] = 2;
+
+	/* re-inject the modified event into the HID stack */
+	err = hid_bpf_input_report(hid_ctx, HID_INPUT_REPORT, buf.data, sizeof(buf.data));
+	if (err == -16 /* -EBUSY */) {
+		/*
+		 * This happens when we schedule the work with a 0 delay:
+		 * the thread immediately starts but the current input
+		 * processing hasn't finished yet. So the semaphore is
+		 * already taken, and hid_input_report returns -EBUSY
+		 */
+		/* schedule another attempt */
+		hid_bpf_schedule_delayed_work(hid_ctx, 5);
+
+		/* return an error so that we don't trigger hid_offload_test()
+		 * and pop the element */
+		return err;
+	}
+
+	/* call ourself once again until there is no more events in the queue */
+	hid_bpf_schedule_delayed_work(hid_ctx, 5);
+
+	return 0;
+}
+
 SEC("?fmod_ret/hid_bpf_device_event")
 int BPF_PROG(hid_defer_event, struct hid_bpf_ctx *hctx)
 {
@@ -296,6 +353,11 @@ int BPF_PROG(hid_defer_event, struct hid_bpf_ctx *hctx)
 	if (!data)
 		return 0; /* EPERM check */
 
+	/* Only schedule a delayed work when reportID is 1, otherwise
+	* simply forward it to hidraw */
+	if (data[0] != 1)
+		return 0;
+
 	__builtin_memcpy(&buf.data, data, 6);
 
 	delay = *(__u32 *)&data[2];
@@ -305,3 +367,45 @@ int BPF_PROG(hid_defer_event, struct hid_bpf_ctx *hctx)
 
 	return -1; /* discard the event */
 }
+
+SEC("?fmod_ret.s/hid_bpf_offload")
+int BPF_PROG(hid_offload_hw_request, struct hid_bpf_ctx *hid_ctx)
+{
+	struct test_report buf;
+	__u8 data[6] = {1};
+	int ret;
+
+	ret = hid_bpf_hw_request(hid_ctx,
+				 data,
+				 sizeof(data),
+				 HID_INPUT_REPORT,
+				 HID_REQ_GET_REPORT);
+
+	return 0;
+}
+SEC("?fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_defer_multiple_events, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4 /* size */);
+	struct test_report buf = {
+		.data = {2, 3, 4, 5, 6, 7},
+	};
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* Only schedule a delayed work when reportID is 1, otherwise
+	* simply forward it to hidraw */
+	if (data[0] != 1)
+		return 0;
+
+	bpf_map_push_elem(&queue, &buf, BPF_ANY);
+	buf.data[0] = 2;
+	buf.data[1] = 4;
+	buf.data[2] = 6;
+	bpf_map_push_elem(&queue, &buf, BPF_ANY);
+
+	hid_bpf_schedule_delayed_work(hctx, 10);
+
+	return -1; /* discard the event */
+}

-- 
2.43.0


