Return-Path: <linux-kselftest+bounces-4669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29FA854FFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 18:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABC828D339
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEA6127B4D;
	Wed, 14 Feb 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDd1cxWi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2C84A37;
	Wed, 14 Feb 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931184; cv=none; b=uzFCJB6fAKdegnj0pkNjPe+jl5yWfdi7f00nP6iZ4zY7++uDO3SCTkqWwjvvjJT9BwuyFKS92RO0SnzhJC9d6S1eGGX1YwzTL+RFkCfvK7MrehIrMzAoImKa+z/NpcPd6vujKPG6E+BEd2A1+N/GJT1/+6urjKj8F0eGU6KrYl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931184; c=relaxed/simple;
	bh=PU+I3eS6cHBmwm4SgiKJZyWi+Zr3RNPwKsVpYhPf5k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCTIRNRPM36j9FqflKzn728hf9MwyzWoquREdhI0SNz1NWMbEUDym7UE13Mp64pbSurma8N15buQNeLyvOGeTfio95GIHMd7f7a+lHoA+uwzXBmLfxNBKydxcPoZlTBkPhrjl6z8c+RNCfswXCLYAJMjAUoOCmmPkRfCBsR0HOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDd1cxWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE346C43390;
	Wed, 14 Feb 2024 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707931183;
	bh=PU+I3eS6cHBmwm4SgiKJZyWi+Zr3RNPwKsVpYhPf5k4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cDd1cxWiYwELvwUBnoMX0vHoQZR/ez6dv80xmCyueLX0/x2GazDUS9oA/UL3mjeiE
	 pFyVGBbkheN5coonqeYSCY7u1sO4qXIghbMg0Q2LhSKs+STmpUCu9uxJz4B+ACP27w
	 rcTxQe6Mmw8sjG1tAj5PSjFm9dctljIESY2yPOIpI7EruAT20W1JG0BznO2MWMWLbD
	 CjiE+9X5U2VBFc9TgJdf/LMiV6UxRdABdIXedXphD6DVKlV/K64gXzkkljHIU5RRP/
	 m1wM0EE40cw89CLZ/KloG3HGR/JNf5yqFPiNot7mAkXLb5NQMrOuRdnZWhVUSHXuUj
	 GG2/vjkUzDo9Q==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 14 Feb 2024 18:18:39 +0100
Subject: [PATCH RFC bpf-next v2 10/10] selftests/hid: add test for
 bpf_timer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hid-bpf-sleepable-v2-10-5756b054724d@kernel.org>
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
In-Reply-To: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707931135; l=8194;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=PU+I3eS6cHBmwm4SgiKJZyWi+Zr3RNPwKsVpYhPf5k4=;
 b=g91iULn/RIdO4qMTzjZNWDRByiGpz0YQYg4DYiv1FZen6lFdP319S6f1vChI7eDlxK9Rs/gvi
 mBIT7wy7dsNAKNt8g2Xt7D2TTYegHj2BneC8hl9vLSSXIowq/TDi0MX
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This test checks that we can actually delay a workload in a sleepable
context through bpf_timer.

When an event is injected, we push it on a map of type queue and schedule
a work.
When that work kicks in, it pulls the event from the queue, and wakes
up userspace through a ring buffer.

The use of the ring buffer is there to not have sleeps in userspace
because we have no guarantees of the timing of when those jobs will be
called.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

new in v2
---
 tools/testing/selftests/hid/hid_bpf.c              |  83 +++++++++++
 tools/testing/selftests/hid/progs/hid.c            | 152 +++++++++++++++++++++
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  |   2 +
 3 files changed, 237 insertions(+)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index f825623e3edc..c16efb43dd91 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -875,6 +875,89 @@ TEST_F(hid_bpf, test_hid_user_raw_request_call)
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
+TEST_F(hid_bpf, test_hid_schedule_work_defer_events_2)
+{
+	struct hid_hw_request_syscall_args args = {
+		.retval = -1,
+		.size = 10,
+	};
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, tattrs,
+			    .ctx_in = &args,
+			    .ctx_size_in = sizeof(args),
+	);
+	const struct test_program progs[] = {
+		{ .name = "hid_defer_bpf_timer" },
+	};
+	struct ring_buffer *rb = NULL;
+	__u8 buf[10] = {0};
+	int prog_fd, err;
+
+	LOAD_PROGRAMS(progs);
+
+	/* Set up ring buffer polling */
+	rb = ring_buffer__new(bpf_map__fd(self->skel->maps.rb), handle_event, NULL, NULL);
+	ASSERT_OK_PTR(rb) TH_LOG("Failed to create ring buffer");
+	ASSERT_EQ(workload_data, 0);
+
+	args.hid = self->hid_id;
+	prog_fd = bpf_program__fd(self->skel->progs.hid_setup_timer);
+
+	err = bpf_prog_test_run_opts(prog_fd, &tattrs);
+
+	ASSERT_OK(err) TH_LOG("error while calling bpf_prog_test_run_opts");
+
+	/* check that there is no data to read from hidraw */
+	memset(buf, 0, sizeof(buf));
+	err = read(self->hidraw_fd, buf, sizeof(buf));
+	ASSERT_EQ(err, -1) TH_LOG("read_hidraw");
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
index f67d35def142..05afa056167e 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -250,3 +250,155 @@ int BPF_PROG(hid_test_insert3, struct hid_bpf_ctx *hid_ctx)
 
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
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 8);
+} rb SEC(".maps");
+
+struct elem {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1024);
+	__type(key, u32);
+	__type(value, struct elem);
+} timer_map SEC(".maps");
+
+/* callback for timer_map timers */
+
+static int timer_cb1(void *map, int *key, struct bpf_timer *timer)
+{
+	struct hid_bpf_ctx *hid_ctx;
+	struct test_report buf;
+	__u8 *rb_elem;
+	int err;
+	int i, ret = 0;
+
+	/* do not pop the event, it'll be done in hid_offload_test() when
+	 * notifying user space, this also allows to retry sending it
+	 * if hid_bpf_input_report fails
+	 */
+	if (bpf_map_peek_elem(&queue, &buf))
+		return 0;
+
+	hid_ctx = hid_bpf_allocate_context(*key);
+	if (!hid_ctx)
+		return 0; /* EPERM check */
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
+		bpf_timer_start(timer, 5 * 1000, 0);
+
+		goto out;
+	}
+
+	if (bpf_map_pop_elem(&queue, &buf))
+		goto out;
+
+	rb_elem = bpf_ringbuf_reserve(&rb, sizeof(*rb_elem), 0);
+	if (!rb_elem)
+		goto out;
+
+	*rb_elem = buf.data[1];
+
+	bpf_ringbuf_submit(rb_elem, 0);
+
+	/* call ourself once again until there is no more events in the queue */
+	bpf_timer_start(timer, 10 * 1000 * 1000, 0);
+
+ out:
+	hid_bpf_release_context(hid_ctx);
+	return 0;
+}
+
+#define CLOCK_MONOTONIC		1
+
+SEC("?fmod_ret/hid_bpf_device_event")
+int BPF_PROG(hid_defer_bpf_timer, struct hid_bpf_ctx *hctx)
+{
+	__u8 *data = hid_bpf_get_data(hctx, 0 /* offset */, 4 /* size */);
+	struct test_report buf = {
+		.data = {2, 3, 4, 5, 6, 7},
+	};
+	struct bpf_timer *timer;
+	int key = hctx->hid->id;
+	struct elem init = {};
+
+	if (!data)
+		return 0; /* EPERM check */
+
+	/* Only schedule a delayed work when reportID is 1, otherwise
+	 * simply forward it to hidraw
+	 */
+	if (data[0] != 1)
+		return 0;
+
+	bpf_map_push_elem(&queue, &buf, BPF_ANY);
+	buf.data[0] = 2;
+	buf.data[1] = 4;
+	buf.data[2] = 6;
+	bpf_map_push_elem(&queue, &buf, BPF_ANY);
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (!timer)
+		return 3;
+
+	bpf_timer_set_sleepable_cb(timer, timer_cb1);
+
+	if (bpf_timer_start(timer, 5 * 1000 * 1000, 0) != 0)
+		return 2;
+
+	return -1; /* discard the event */
+}
+
+SEC("syscall")
+int hid_setup_timer(struct hid_hw_request_syscall_args *args)
+{
+	struct hid_bpf_ctx *ctx;
+	struct bpf_timer *timer;
+	struct elem init = {};
+	int key = args->hid;
+	int i, ret = 0;
+
+	ctx = hid_bpf_allocate_context(args->hid);
+	if (!ctx)
+		return -1; /* EPERM check */
+
+	bpf_map_update_elem(&timer_map, &key, &init, 0);
+
+	timer = bpf_map_lookup_elem(&timer_map, &key);
+	if (!timer) {
+		hid_bpf_release_context(ctx);
+		return 1;
+	}
+
+	bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SLEEPABLE);
+
+	hid_bpf_release_context(ctx);
+
+	return 0;
+}
+
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 9cd56821d0f1..8235a28e7dee 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -100,5 +100,7 @@ extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx,
 				enum hid_report_type type,
 				__u8 *data,
 				size_t buf__sz) __ksym;
+extern int bpf_timer_set_sleepable_cb(struct bpf_timer *timer,
+		int (callback_fn)(void *map, int *key, struct bpf_timer *timer)) __ksym;
 
 #endif /* __HID_BPF_HELPERS_H */

-- 
2.43.0


