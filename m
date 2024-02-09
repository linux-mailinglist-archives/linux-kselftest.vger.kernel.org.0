Return-Path: <linux-kselftest+bounces-4420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707084F5EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3881F23A64
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 13:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647C3C48F;
	Fri,  9 Feb 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCuTlZ8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732794C610;
	Fri,  9 Feb 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485250; cv=none; b=ofbeTFOGYlsBWzUXq7o3eDcV1AlDT2KdSARdweM/rkjhIJTsWw6wCmOERHxA/8qUfEZOnlK1EnuvUSkQHl9GJ3/DutR020I29rHBGzqujNlw2V2TYiOtrE9Pr2tZ3Evpo12WommcSv1zQg3uZ56vE7X3E0gdWiYe7SkqLjpWuMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485250; c=relaxed/simple;
	bh=DHGG1H1FpZRL921F5tAO+144piPhKC9ZW9OpLVsQszA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lp7Vy6d6WqymLWfPEbEh/D4hcOAno8yD647ng22paWQq47H/htq5mwlacDo6jcNdat9gkvBaoipZy2GkddQ1qbj58ef3PP/a8LYA5qY+sqJtRBaLhW/PDb8bU9nRNO447gvgZazfBZ8cp94tGHUGyyDOTrz1Lx2haPGWx6s2RwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCuTlZ8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AACC433C7;
	Fri,  9 Feb 2024 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485250;
	bh=DHGG1H1FpZRL921F5tAO+144piPhKC9ZW9OpLVsQszA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BCuTlZ8VypyywABGRaQP+WyN/8kxjjc8zv1O/5/t9z4XtVBz1VMFJRHH1/uUvLUju
	 JdhSRmFji9sIp56xA4mfHl9eNu1oGMgDq3c5Ylrfba5Ujj8p1hoz2zhGzcvP/W8q5R
	 bFUcWxNFF7KMqdnef5AqF2vC+Qab8c9803GVNcyWXnJneR8eY9VyKO/jc2A41Zj7YJ
	 2DryUbA2N0gSLufYqQ0IGtRhIfVnprs7Xp3x6Wy/fqVRLmTsB8Ox4nBLlCPDb2hV0i
	 pxaJU46bhaxmYNxNSwFUtgsWKowBugLtzaI2xde8GCUmGFX3zv2OjhLmrZPRsrbIbF
	 3pdwVOBWCV2OQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 09 Feb 2024 14:26:43 +0100
Subject: [PATCH RFC bpf-next 7/9] HID: bpf: allow to defer work in a
 delayed workqueue
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-hid-bpf-sleepable-v1-7-4cc895b5adbd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707485215; l=35428;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=DHGG1H1FpZRL921F5tAO+144piPhKC9ZW9OpLVsQszA=;
 b=yy5mx6mZsxDpl4SzQl/4+r7pn7eon5OzYJkWlzcr74+6C2NyR9fYrJfn8odgxKCkm29olK445
 fJMsICMngnxCvPgYbiZo2/amWCah57QxOlmx2kJC8dAOJ2Ba3D9TCGE
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This allows to defer work for later for being able to:
1. defer an event:
   Sometimes we receive an out of proximity event, but the device can not
   be trusted enough, and we need to ensure that we won't receive another
   one in the n following milliseconds. So we need to wait those n
   milliseconds, and eventually re-inject that event in the stack.

2. inject new events in reaction to one given event:
   We might want to transform one given event into several. This is the
   case for macro keys where a single key press is supposed to send
   a sequence of key presses. But this could also be used to patch a
   faulty behavior, if a device forgets to send a release event

3. communicate with the device in reaction to one event:
   We might want to communicate back to the device after a given event.
   For example a device might send us an event saying that it came back
   from sleep state and needs to be re-initialized.

Currently we can achieve that by keeping a userspace program around,
raise a bpf event, and let that userspace program inject the events and
commands.
However, we are just keeping that program alive as a daemon for just
scheduling commands, so there is no logic that would justify an actual
userspace wakeup. So a kernel workqueue is simpler to handle.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 Documentation/hid/hid-bpf.rst                   |  24 ++-
 drivers/hid/bpf/entrypoints/entrypoints.bpf.c   |   8 +
 drivers/hid/bpf/entrypoints/entrypoints.lskel.h | 236 +++++++++++++++---------
 drivers/hid/bpf/hid_bpf_dispatch.c              |  94 +++++++++-
 drivers/hid/bpf/hid_bpf_jmp_table.c             |  34 +++-
 include/linux/hid_bpf.h                         |   7 +
 6 files changed, 307 insertions(+), 96 deletions(-)

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index 0765b3298ecf..25b157fd8ed2 100644
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -140,6 +140,7 @@ HID-BPF has the following attachment types available:
 1. event processing/filtering with ``SEC("fmod_ret/hid_bpf_device_event")`` in libbpf
 2. actions coming from userspace with ``SEC("syscall")`` in libbpf
 3. change of the report descriptor with ``SEC("fmod_ret/hid_bpf_rdesc_fixup")`` in libbpf
+4. execute a delayed action with ``SEC("fmod_ret.s/hid_bpf_offload")`` in libbpf
 
 A ``hid_bpf_device_event`` is calling a BPF program when an event is received from
 the device. Thus we are in IRQ context and can act on the data or notify userspace.
@@ -149,6 +150,12 @@ A ``syscall`` means that userspace called the syscall ``BPF_PROG_RUN`` facility.
 This time, we can do any operations allowed by HID-BPF, and talking to the device is
 allowed.
 
+A ``hid_bpf_offload`` is called whenever a HID-BPF program attached to ``hid_bpf_device_event``
+is calling the kfunc ``hid_bpf_schedule_delayed_work``. The jobs are globally
+shared per HID device, this might be called more than expected, because another
+HID-BPF program might call ``hid_bpf_schedule_delayed_work``. So please ensure
+you actually have job scheduled.
+
 Last, ``hid_bpf_rdesc_fixup`` is different from the others as there can be only one
 BPF program of this type. This is called on ``probe`` from the driver and allows to
 change the report descriptor from the BPF program. Once a ``hid_bpf_rdesc_fixup``
@@ -167,13 +174,13 @@ Available tracing functions to attach a HID-BPF program:
 --------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_device_event hid_bpf_rdesc_fixup
+   :functions: hid_bpf_device_event hid_bpf_rdesc_fixup hid_bpf_offload
 
 Available API that can be used in all HID-BPF programs:
 -------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_get_data
+   :functions: hid_bpf_get_data hid_bpf_schedule_delayed_work
 
 Available API that can be used in syscall HID-BPF programs:
 -----------------------------------------------------------
@@ -181,6 +188,19 @@ Available API that can be used in syscall HID-BPF programs:
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
    :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_input_report hid_bpf_allocate_context hid_bpf_release_context
 
+Available API that can be used in sleepable HID-BPF programs:
+-------------------------------------------------------------
+
+When using a sleepable HID-BPF program (attached with ``SEC("fmod_ret.s/hid_bpf_offload")``),
+you can use the following functions:
+
+- ``hid_bpf_hw_request``
+- ``hid_bpf_hw_output_report``
+- ``hid_bpf_input_report``
+- ``hid_bpf_schedule_delayed_work``
+- ``hid_bpf_allocate_context``
+- ``hid_bpf_release_context``
+
 General overview of a HID-BPF program
 =====================================
 
diff --git a/drivers/hid/bpf/entrypoints/entrypoints.bpf.c b/drivers/hid/bpf/entrypoints/entrypoints.bpf.c
index c22921125a1a..fe7d5c808034 100644
--- a/drivers/hid/bpf/entrypoints/entrypoints.bpf.c
+++ b/drivers/hid/bpf/entrypoints/entrypoints.bpf.c
@@ -22,4 +22,12 @@ int BPF_PROG(hid_tail_call, struct hid_bpf_ctx *hctx)
 	return 0;
 }
 
+SEC("fmod_ret.s/__hid_bpf_tail_call_sleepable")
+int BPF_PROG(hid_tail_call_sleepable, struct hid_bpf_ctx *hctx)
+{
+	bpf_tail_call(ctx, &hid_jmp_table, hctx->index);
+
+	return 0;
+}
+
 char LICENSE[] SEC("license") = "GPL";
diff --git a/drivers/hid/bpf/entrypoints/entrypoints.lskel.h b/drivers/hid/bpf/entrypoints/entrypoints.lskel.h
index 35618051598c..8883c436ab8c 100644
--- a/drivers/hid/bpf/entrypoints/entrypoints.lskel.h
+++ b/drivers/hid/bpf/entrypoints/entrypoints.lskel.h
@@ -12,9 +12,11 @@ struct entrypoints_bpf {
 	} maps;
 	struct {
 		struct bpf_prog_desc hid_tail_call;
+		struct bpf_prog_desc hid_tail_call_sleepable;
 	} progs;
 	struct {
 		int hid_tail_call_fd;
+		int hid_tail_call_sleepable_fd;
 	} links;
 };
 
@@ -29,12 +31,24 @@ entrypoints_bpf__hid_tail_call__attach(struct entrypoints_bpf *skel)
 	return fd;
 }
 
+static inline int
+entrypoints_bpf__hid_tail_call_sleepable__attach(struct entrypoints_bpf *skel)
+{
+	int prog_fd = skel->progs.hid_tail_call_sleepable.prog_fd;
+	int fd = skel_raw_tracepoint_open(NULL, prog_fd);
+
+	if (fd > 0)
+		skel->links.hid_tail_call_sleepable_fd = fd;
+	return fd;
+}
+
 static inline int
 entrypoints_bpf__attach(struct entrypoints_bpf *skel)
 {
 	int ret = 0;
 
 	ret = ret < 0 ? ret : entrypoints_bpf__hid_tail_call__attach(skel);
+	ret = ret < 0 ? ret : entrypoints_bpf__hid_tail_call_sleepable__attach(skel);
 	return ret < 0 ? ret : 0;
 }
 
@@ -42,6 +56,7 @@ static inline void
 entrypoints_bpf__detach(struct entrypoints_bpf *skel)
 {
 	skel_closenz(skel->links.hid_tail_call_fd);
+	skel_closenz(skel->links.hid_tail_call_sleepable_fd);
 }
 static void
 entrypoints_bpf__destroy(struct entrypoints_bpf *skel)
@@ -50,6 +65,7 @@ entrypoints_bpf__destroy(struct entrypoints_bpf *skel)
 		return;
 	entrypoints_bpf__detach(skel);
 	skel_closenz(skel->progs.hid_tail_call.prog_fd);
+	skel_closenz(skel->progs.hid_tail_call_sleepable.prog_fd);
 	skel_closenz(skel->maps.hid_jmp_table.map_fd);
 	skel_free(skel);
 }
@@ -73,10 +89,7 @@ entrypoints_bpf__load(struct entrypoints_bpf *skel)
 {
 	struct bpf_load_and_run_opts opts = {};
 	int err;
-
-	opts.ctx = (struct bpf_loader_ctx *)skel;
-	opts.data_sz = 2856;
-	opts.data = (void *)"\
+	static const char opts_data[] __attribute__((__aligned__(8))) = "\
 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
@@ -110,7 +123,7 @@ entrypoints_bpf__load(struct entrypoints_bpf *skel)
 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
 \0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x9f\xeb\x01\0\
-\x18\0\0\0\0\0\0\0\x60\x02\0\0\x60\x02\0\0\x12\x02\0\0\0\0\0\0\0\0\0\x02\x03\0\
+\x18\0\0\0\0\0\0\0\x80\x02\0\0\x80\x02\0\0\x93\x02\0\0\0\0\0\0\0\0\0\x02\x03\0\
 \0\0\x01\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\
 \0\0\x04\0\0\0\x03\0\0\0\x05\0\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\
 \x02\x06\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\0\x02\0\0\0\x04\0\0\0\0\x04\0\0\0\0\0\0\
@@ -123,96 +136,141 @@ entrypoints_bpf__load(struct entrypoints_bpf *skel)
 \0\0\0\0\0\0\0\x1b\x01\0\0\x12\0\0\0\x40\0\0\0\x1f\x01\0\0\x10\0\0\0\x80\0\0\0\
 \x2e\x01\0\0\x14\0\0\0\xa0\0\0\0\0\0\0\0\x15\0\0\0\xc0\0\0\0\x3a\x01\0\0\0\0\0\
 \x08\x11\0\0\0\x40\x01\0\0\0\0\0\x01\x04\0\0\0\x20\0\0\0\0\0\0\0\0\0\0\x02\x13\
-\0\0\0\0\0\0\0\0\0\0\x0a\x1c\0\0\0\x4d\x01\0\0\x04\0\0\x06\x04\0\0\0\x5d\x01\0\
+\0\0\0\0\0\0\0\0\0\0\x0a\x1e\0\0\0\x4d\x01\0\0\x04\0\0\x06\x04\0\0\0\x5d\x01\0\
 \0\0\0\0\0\x6e\x01\0\0\x01\0\0\0\x80\x01\0\0\x02\0\0\0\x93\x01\0\0\x03\0\0\0\0\
 \0\0\0\x02\0\0\x05\x04\0\0\0\xa4\x01\0\0\x16\0\0\0\0\0\0\0\xab\x01\0\0\x16\0\0\
-\0\0\0\0\0\xb0\x01\0\0\0\0\0\x08\x02\0\0\0\xec\x01\0\0\0\0\0\x01\x01\0\0\0\x08\
-\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x17\0\0\0\x04\0\0\0\x04\0\0\0\xf1\x01\0\0\0\
-\0\0\x0e\x18\0\0\0\x01\0\0\0\xf9\x01\0\0\x01\0\0\x0f\x20\0\0\0\x0a\0\0\0\0\0\0\
-\0\x20\0\0\0\xff\x01\0\0\x01\0\0\x0f\x04\0\0\0\x19\0\0\0\0\0\0\0\x04\0\0\0\x07\
-\x02\0\0\0\0\0\x07\0\0\0\0\0\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\x5f\x53\
-\x49\x5a\x45\x5f\x54\x59\x50\x45\x5f\x5f\0\x74\x79\x70\x65\0\x6d\x61\x78\x5f\
-\x65\x6e\x74\x72\x69\x65\x73\0\x6b\x65\x79\x5f\x73\x69\x7a\x65\0\x76\x61\x6c\
-\x75\x65\x5f\x73\x69\x7a\x65\0\x68\x69\x64\x5f\x6a\x6d\x70\x5f\x74\x61\x62\x6c\
-\x65\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x6c\x6f\x6e\x67\x20\x6c\x6f\x6e\x67\
-\0\x63\x74\x78\0\x68\x69\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\x66\x6d\
-\x6f\x64\x5f\x72\x65\x74\x2f\x5f\x5f\x68\x69\x64\x5f\x62\x70\x66\x5f\x74\x61\
-\x69\x6c\x5f\x63\x61\x6c\x6c\0\x2f\x68\x6f\x6d\x65\x2f\x62\x74\x69\x73\x73\x6f\
-\x69\x72\x2f\x53\x72\x63\x2f\x68\x69\x64\x2f\x64\x72\x69\x76\x65\x72\x73\x2f\
-\x68\x69\x64\x2f\x62\x70\x66\x2f\x65\x6e\x74\x72\x79\x70\x6f\x69\x6e\x74\x73\
-\x2f\x65\x6e\x74\x72\x79\x70\x6f\x69\x6e\x74\x73\x2e\x62\x70\x66\x2e\x63\0\x69\
-\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x68\x69\x64\x5f\x74\x61\x69\
-\x6c\x5f\x63\x61\x6c\x6c\x2c\x20\x73\x74\x72\x75\x63\x74\x20\x68\x69\x64\x5f\
-\x62\x70\x66\x5f\x63\x74\x78\x20\x2a\x68\x63\x74\x78\x29\0\x68\x69\x64\x5f\x62\
-\x70\x66\x5f\x63\x74\x78\0\x69\x6e\x64\x65\x78\0\x68\x69\x64\0\x61\x6c\x6c\x6f\
-\x63\x61\x74\x65\x64\x5f\x73\x69\x7a\x65\0\x72\x65\x70\x6f\x72\x74\x5f\x74\x79\
-\x70\x65\0\x5f\x5f\x75\x33\x32\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x69\x6e\
-\x74\0\x68\x69\x64\x5f\x72\x65\x70\x6f\x72\x74\x5f\x74\x79\x70\x65\0\x48\x49\
-\x44\x5f\x49\x4e\x50\x55\x54\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x4f\
-\x55\x54\x50\x55\x54\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x46\x45\x41\
-\x54\x55\x52\x45\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x52\x45\x50\x4f\
-\x52\x54\x5f\x54\x59\x50\x45\x53\0\x72\x65\x74\x76\x61\x6c\0\x73\x69\x7a\x65\0\
-\x5f\x5f\x73\x33\x32\0\x30\x3a\x30\0\x09\x62\x70\x66\x5f\x74\x61\x69\x6c\x5f\
-\x63\x61\x6c\x6c\x28\x63\x74\x78\x2c\x20\x26\x68\x69\x64\x5f\x6a\x6d\x70\x5f\
-\x74\x61\x62\x6c\x65\x2c\x20\x68\x63\x74\x78\x2d\x3e\x69\x6e\x64\x65\x78\x29\
-\x3b\0\x63\x68\x61\x72\0\x4c\x49\x43\x45\x4e\x53\x45\0\x2e\x6d\x61\x70\x73\0\
-\x6c\x69\x63\x65\x6e\x73\x65\0\x68\x69\x64\x5f\x64\x65\x76\x69\x63\x65\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x8a\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\
-\0\0\0\x04\0\0\0\x04\0\0\0\0\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x69\x64\x5f\
-\x6a\x6d\x70\x5f\x74\x61\x62\x6c\x65\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\x79\x12\0\0\0\0\0\0\x61\x23\0\0\0\0\
-\0\0\x18\x52\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x85\0\0\0\x0c\0\0\0\xb7\0\0\0\0\0\0\0\
-\x95\0\0\0\0\0\0\0\0\0\0\0\x0e\0\0\0\0\0\0\0\x8e\0\0\0\xd3\0\0\0\x05\x48\0\0\
-\x01\0\0\0\x8e\0\0\0\xba\x01\0\0\x02\x50\0\0\x05\0\0\0\x8e\0\0\0\xd3\0\0\0\x05\
-\x48\0\0\x08\0\0\0\x0f\0\0\0\xb6\x01\0\0\0\0\0\0\x1a\0\0\0\x07\0\0\0\0\0\0\0\0\
-\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x69\
-\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\0\0\0\0\0\0\x1a\0\0\0\0\0\0\0\
-\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\x01\0\
-\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x5f\
-\x5f\x68\x69\x64\x5f\x62\x70\x66\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\0\0\
+\0\0\0\0\0\xb0\x01\0\0\0\0\0\x08\x02\0\0\0\0\0\0\0\x01\0\0\x0d\x02\0\0\0\x5f\0\
+\0\0\x0b\0\0\0\xec\x01\0\0\x01\0\0\x0c\x17\0\0\0\x6d\x02\0\0\0\0\0\x01\x01\0\0\
+\0\x08\0\0\x01\0\0\0\0\0\0\0\x03\0\0\0\0\x19\0\0\0\x04\0\0\0\x04\0\0\0\x72\x02\
+\0\0\0\0\0\x0e\x1a\0\0\0\x01\0\0\0\x7a\x02\0\0\x01\0\0\x0f\x20\0\0\0\x0a\0\0\0\
+\0\0\0\0\x20\0\0\0\x80\x02\0\0\x01\0\0\x0f\x04\0\0\0\x1b\0\0\0\0\0\0\0\x04\0\0\
+\0\x88\x02\0\0\0\0\0\x07\0\0\0\0\0\x69\x6e\x74\0\x5f\x5f\x41\x52\x52\x41\x59\
+\x5f\x53\x49\x5a\x45\x5f\x54\x59\x50\x45\x5f\x5f\0\x74\x79\x70\x65\0\x6d\x61\
+\x78\x5f\x65\x6e\x74\x72\x69\x65\x73\0\x6b\x65\x79\x5f\x73\x69\x7a\x65\0\x76\
+\x61\x6c\x75\x65\x5f\x73\x69\x7a\x65\0\x68\x69\x64\x5f\x6a\x6d\x70\x5f\x74\x61\
+\x62\x6c\x65\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\x6c\x6f\x6e\x67\x20\x6c\x6f\
+\x6e\x67\0\x63\x74\x78\0\x68\x69\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\
+\x66\x6d\x6f\x64\x5f\x72\x65\x74\x2f\x5f\x5f\x68\x69\x64\x5f\x62\x70\x66\x5f\
+\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\x2f\x68\x6f\x6d\x65\x2f\x62\x74\x69\x73\
+\x73\x6f\x69\x72\x2f\x53\x72\x63\x2f\x68\x69\x64\x2f\x64\x72\x69\x76\x65\x72\
+\x73\x2f\x68\x69\x64\x2f\x62\x70\x66\x2f\x65\x6e\x74\x72\x79\x70\x6f\x69\x6e\
+\x74\x73\x2f\x65\x6e\x74\x72\x79\x70\x6f\x69\x6e\x74\x73\x2e\x62\x70\x66\x2e\
+\x63\0\x69\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\x4f\x47\x28\x68\x69\x64\x5f\x74\
+\x61\x69\x6c\x5f\x63\x61\x6c\x6c\x2c\x20\x73\x74\x72\x75\x63\x74\x20\x68\x69\
+\x64\x5f\x62\x70\x66\x5f\x63\x74\x78\x20\x2a\x68\x63\x74\x78\x29\0\x68\x69\x64\
+\x5f\x62\x70\x66\x5f\x63\x74\x78\0\x69\x6e\x64\x65\x78\0\x68\x69\x64\0\x61\x6c\
+\x6c\x6f\x63\x61\x74\x65\x64\x5f\x73\x69\x7a\x65\0\x72\x65\x70\x6f\x72\x74\x5f\
+\x74\x79\x70\x65\0\x5f\x5f\x75\x33\x32\0\x75\x6e\x73\x69\x67\x6e\x65\x64\x20\
+\x69\x6e\x74\0\x68\x69\x64\x5f\x72\x65\x70\x6f\x72\x74\x5f\x74\x79\x70\x65\0\
+\x48\x49\x44\x5f\x49\x4e\x50\x55\x54\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\
+\x5f\x4f\x55\x54\x50\x55\x54\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x46\
+\x45\x41\x54\x55\x52\x45\x5f\x52\x45\x50\x4f\x52\x54\0\x48\x49\x44\x5f\x52\x45\
+\x50\x4f\x52\x54\x5f\x54\x59\x50\x45\x53\0\x72\x65\x74\x76\x61\x6c\0\x73\x69\
+\x7a\x65\0\x5f\x5f\x73\x33\x32\0\x30\x3a\x30\0\x09\x62\x70\x66\x5f\x74\x61\x69\
+\x6c\x5f\x63\x61\x6c\x6c\x28\x63\x74\x78\x2c\x20\x26\x68\x69\x64\x5f\x6a\x6d\
+\x70\x5f\x74\x61\x62\x6c\x65\x2c\x20\x68\x63\x74\x78\x2d\x3e\x69\x6e\x64\x65\
+\x78\x29\x3b\0\x68\x69\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\x5f\x73\x6c\
+\x65\x65\x70\x61\x62\x6c\x65\0\x66\x6d\x6f\x64\x5f\x72\x65\x74\x2e\x73\x2f\x5f\
+\x5f\x68\x69\x64\x5f\x62\x70\x66\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\x5f\
+\x73\x6c\x65\x65\x70\x61\x62\x6c\x65\0\x69\x6e\x74\x20\x42\x50\x46\x5f\x50\x52\
+\x4f\x47\x28\x68\x69\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\x5f\x73\x6c\
+\x65\x65\x70\x61\x62\x6c\x65\x2c\x20\x73\x74\x72\x75\x63\x74\x20\x68\x69\x64\
+\x5f\x62\x70\x66\x5f\x63\x74\x78\x20\x2a\x68\x63\x74\x78\x29\0\x63\x68\x61\x72\
+\0\x4c\x49\x43\x45\x4e\x53\x45\0\x2e\x6d\x61\x70\x73\0\x6c\x69\x63\x65\x6e\x73\
+\x65\0\x68\x69\x64\x5f\x64\x65\x76\x69\x63\x65\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\x2b\x05\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\x04\0\0\0\x04\0\0\0\
+\0\x04\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x69\x64\x5f\x6a\x6d\x70\x5f\x74\x61\x62\
+\x6c\x65\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x47\x50\
+\x4c\0\0\0\0\0\x79\x12\0\0\0\0\0\0\x61\x23\0\0\0\0\0\0\x18\x52\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\x85\0\0\0\x0c\0\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\
+\x0e\0\0\0\0\0\0\0\x8e\0\0\0\xd3\0\0\0\x05\x48\0\0\x01\0\0\0\x8e\0\0\0\xba\x01\
+\0\0\x02\x50\0\0\x05\0\0\0\x8e\0\0\0\xd3\0\0\0\x05\x48\0\0\x08\0\0\0\x0f\0\0\0\
+\xb6\x01\0\0\0\0\0\0\x1a\0\0\0\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x68\x69\x64\x5f\x74\x61\x69\x6c\x5f\
+\x63\x61\x6c\x6c\0\0\0\0\0\0\0\x1a\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\
+\0\0\0\x10\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\x01\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x5f\x5f\x68\x69\x64\x5f\x62\x70\x66\
+\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\0\0\0\0\0\x47\x50\x4c\0\0\0\0\0\x79\
+\x12\0\0\0\0\0\0\x61\x23\0\0\0\0\0\0\x18\x52\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x85\0\
+\0\0\x0c\0\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\0\0\0\0\x18\0\0\0\0\0\0\0\
+\x8e\0\0\0\x2d\x02\0\0\x05\x68\0\0\x01\0\0\0\x8e\0\0\0\xba\x01\0\0\x02\x70\0\0\
+\x05\0\0\0\x8e\0\0\0\x2d\x02\0\0\x05\x68\0\0\x08\0\0\0\x0f\0\0\0\xb6\x01\0\0\0\
+\0\0\0\x1a\0\0\0\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\x10\0\0\0\x68\x69\x64\x5f\x74\x61\x69\x6c\x5f\x63\x61\x6c\
+\x6c\x5f\x73\0\0\0\0\0\x1a\0\0\0\0\0\0\0\x08\0\0\0\0\0\0\0\0\0\0\0\x01\0\0\0\
+\x10\0\0\0\0\0\0\0\0\0\0\0\x03\0\0\0\x01\0\0\0\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\0\0\x10\0\0\0\0\0\0\0\x5f\x5f\x68\x69\x64\x5f\x62\x70\x66\x5f\
+\x74\x61\x69\x6c\x5f\x63\x61\x6c\x6c\x5f\x73\x6c\x65\x65\x70\x61\x62\x6c\x65\0\
 \0\0";
-	opts.insns_sz = 1192;
-	opts.insns = (void *)"\
+	static const char opts_insn[] __attribute__((__aligned__(8))) = "\
 \xbf\x16\0\0\0\0\0\0\xbf\xa1\0\0\0\0\0\0\x07\x01\0\0\x78\xff\xff\xff\xb7\x02\0\
-\0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x11\0\0\0\0\0\x61\
+\0\x88\0\0\0\xb7\x03\0\0\0\0\0\0\x85\0\0\0\x71\0\0\0\x05\0\x14\0\0\0\0\0\x61\
 \xa1\x78\xff\0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x7c\xff\
 \0\0\0\0\xd5\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x80\xff\0\0\0\0\xd5\
-\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\
-\x01\0\0\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\
-\xbf\x70\0\0\0\0\0\0\x95\0\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\xa8\x09\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\
-\0\0\0\0\0\0\0\xa4\x09\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\
-\0\0\0\0\0\0\0\0\0\x98\x09\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\0\x05\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\x09\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\
-\0\0\x12\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x90\x09\0\0\xb7\x03\0\0\x1c\0\0\0\
-\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xd7\xff\0\0\0\0\x63\x7a\x78\
-\xff\0\0\0\0\x61\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
-\0\0\xbc\x09\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\
-\0\0\0\xb0\x09\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\
-\0\xc5\x07\xca\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\
-\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf8\x09\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x90\
-\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x0a\0\0\x18\x61\0\0\
-\0\0\0\0\0\0\0\0\x88\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\
-\x38\x0a\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xd0\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\
-\x60\0\0\0\0\0\0\0\0\0\0\x40\x0a\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe0\x0a\0\0\
-\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x70\x0a\0\0\x18\x61\0\0\0\0\0\
-\0\0\0\0\0\0\x0b\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
-\x18\x61\0\0\0\0\0\0\0\0\0\0\xf8\x0a\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\x0a\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\
-\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x9c\x0a\0\0\x63\x01\0\0\0\0\0\0\x79\x60\
-\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa0\x0a\0\0\x7b\x01\0\0\0\0\0\0\x61\
-\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x0a\0\0\x63\x01\0\0\0\0\0\
-\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x10\x0b\0\0\xb7\x02\0\0\x14\0\0\0\xb7\x03\0\0\
-\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\
-\x91\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x80\x0a\0\0\x63\x70\x6c\0\0\0\0\0\
-\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\
-\0\0\0\0\0\0\0\0\x80\x0a\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\
-\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xf0\x0a\0\0\x61\x01\0\0\0\0\0\0\xd5\
-\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x7f\xff\0\0\
-\0\0\x63\x7a\x80\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\
-\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\x63\x06\x28\0\0\0\
-\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\
-\0\0\xb7\0\0\0\0\0\0\0\x95\0\0\0\0\0\0\0";
+\x01\x01\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa1\x84\xff\0\0\0\0\xd5\x01\x01\0\0\
+\0\0\0\x85\0\0\0\xa8\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x61\x01\0\0\0\0\
+\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xbf\x70\0\0\
+\0\0\0\0\x95\0\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\x48\x0a\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\
+\0\0\x44\x0a\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\
+\0\0\0\0\x38\x0a\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\x05\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x30\x0a\0\0\x7b\x01\0\0\0\0\0\0\xb7\x01\0\0\x12\0\
+\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x30\x0a\0\0\xb7\x03\0\0\x1c\0\0\0\x85\0\0\0\
+\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\xd4\xff\0\0\0\0\x63\x7a\x78\xff\0\0\0\0\
+\x61\x60\x1c\0\0\0\0\0\x15\0\x03\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x5c\x0a\
+\0\0\x63\x01\0\0\0\0\0\0\xb7\x01\0\0\0\0\0\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x50\
+\x0a\0\0\xb7\x03\0\0\x48\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\
+\xc7\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x63\x71\0\0\0\0\0\0\x18\
+\x60\0\0\0\0\0\0\0\0\0\0\x98\x0a\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x30\x0b\0\0\
+\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xa0\x0a\0\0\x18\x61\0\0\0\0\0\
+\0\0\0\0\0\x28\x0b\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd8\x0a\
+\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x70\x0b\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\
+\0\0\0\0\0\0\0\xe0\x0a\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x80\x0b\0\0\x7b\x01\0\0\
+\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x0b\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\xa0\x0b\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x18\x61\0\
+\0\0\0\0\0\0\0\0\0\x98\x0b\0\0\x7b\x01\0\0\0\0\0\0\x61\x60\x08\0\0\0\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\x38\x0b\0\0\x63\x01\0\0\0\0\0\0\x61\x60\x0c\0\0\0\0\0\
+\x18\x61\0\0\0\0\0\0\0\0\0\0\x3c\x0b\0\0\x63\x01\0\0\0\0\0\0\x79\x60\x10\0\0\0\
+\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x40\x0b\0\0\x7b\x01\0\0\0\0\0\0\x61\xa0\x78\
+\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x68\x0b\0\0\x63\x01\0\0\0\0\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\xb0\x0b\0\0\xb7\x02\0\0\x14\0\0\0\xb7\x03\0\0\x0c\0\0\
+\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\0\0\xc5\x07\x8e\xff\
+\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x20\x0b\0\0\x63\x70\x6c\0\0\0\0\0\x77\x07\
+\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\0\x18\x62\0\0\0\0\0\0\
+\0\0\0\0\x20\x0b\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\0\0\0\xbf\x07\0\0\0\0\
+\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x90\x0b\0\0\x61\x01\0\0\0\0\0\0\xd5\x01\x02\0\
+\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\x7c\xff\0\0\0\0\x63\
+\x7a\x80\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xc8\x0b\0\0\x18\x61\0\0\0\0\0\
+\0\0\0\0\0\x60\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xd0\x0b\
+\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x58\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\
+\0\0\0\0\0\0\0\x08\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xa0\x0c\0\0\x7b\x01\0\0\
+\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x10\x0c\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\
+\xb0\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x40\x0c\0\0\x18\
+\x61\0\0\0\0\0\0\0\0\0\0\xd0\x0c\0\0\x7b\x01\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\
+\0\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xc8\x0c\0\0\x7b\x01\0\0\0\0\0\0\x61\
+\x60\x08\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x68\x0c\0\0\x63\x01\0\0\0\0\0\0\
+\x61\x60\x0c\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x6c\x0c\0\0\x63\x01\0\0\0\0\
+\0\0\x79\x60\x10\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x70\x0c\0\0\x7b\x01\0\0\
+\0\0\0\0\x61\xa0\x78\xff\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\x98\x0c\0\0\x63\
+\x01\0\0\0\0\0\0\x18\x61\0\0\0\0\0\0\0\0\0\0\xe0\x0c\0\0\xb7\x02\0\0\x1e\0\0\0\
+\xb7\x03\0\0\x0c\0\0\0\xb7\x04\0\0\0\0\0\0\x85\0\0\0\xa7\0\0\0\xbf\x07\0\0\0\0\
+\0\0\xc5\x07\x45\xff\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\x50\x0c\0\0\x63\x70\
+\x6c\0\0\0\0\0\x77\x07\0\0\x20\0\0\0\x63\x70\x70\0\0\0\0\0\xb7\x01\0\0\x05\0\0\
+\0\x18\x62\0\0\0\0\0\0\0\0\0\0\x50\x0c\0\0\xb7\x03\0\0\x8c\0\0\0\x85\0\0\0\xa6\
+\0\0\0\xbf\x07\0\0\0\0\0\0\x18\x60\0\0\0\0\0\0\0\0\0\0\xc0\x0c\0\0\x61\x01\0\0\
+\0\0\0\0\xd5\x01\x02\0\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\xc5\x07\
+\x33\xff\0\0\0\0\x63\x7a\x84\xff\0\0\0\0\x61\xa1\x78\xff\0\0\0\0\xd5\x01\x02\0\
+\0\0\0\0\xbf\x19\0\0\0\0\0\0\x85\0\0\0\xa8\0\0\0\x61\xa0\x80\xff\0\0\0\0\x63\
+\x06\x28\0\0\0\0\0\x61\xa0\x84\xff\0\0\0\0\x63\x06\x2c\0\0\0\0\0\x18\x61\0\0\0\
+\0\0\0\0\0\0\0\0\0\0\0\x61\x10\0\0\0\0\0\0\x63\x06\x18\0\0\0\0\0\xb7\0\0\0\0\0\
+\0\0\x95\0\0\0\0\0\0\0";
+
+	opts.ctx = (struct bpf_loader_ctx *)skel;
+	opts.data_sz = sizeof(opts_data) - 1;
+	opts.data = (void *)opts_data;
+	opts.insns_sz = sizeof(opts_insn) - 1;
+	opts.insns = (void *)opts_insn;
+
 	err = bpf_load_and_run(&opts);
 	if (err < 0)
 		return err;
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index e1a650f4a626..afb409a76a63 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -105,6 +105,25 @@ __weak noinline int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx)
 	return 0;
 }
 
+/**
+ * hid_bpf_offload - Called when the workqueue attached to the HID device
+ * is triggered
+ *
+ * @ctx: The HID-BPF context
+ *
+ * @return 0 on success and keep processing; a negative error code to interrupt
+ * the processing of this job.
+ *
+ * Declare an %fmod_ret tracing bpf program to this function and attach this
+ * program through hid_bpf_attach_prog() to have this helper called whenever
+ * hid_bpf_schedule_delayed_work() is called.
+ */
+/* never used by the kernel but declared so we can load and attach a tracepoint */
+__weak noinline int hid_bpf_offload(struct hid_bpf_ctx *ctx)
+{
+	return 0;
+}
+
 u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size)
 {
 	int ret;
@@ -203,6 +222,35 @@ int hid_bpf_reconnect(struct hid_device *hdev)
 	return 0;
 }
 
+static void delayed_work_cb(struct work_struct *work)
+{
+	struct hid_device *hdev = container_of(work, struct hid_device,
+					       bpf.work.work);
+	struct hid_bpf_ctx_kern ctx_kern = {
+		.ctx = {
+			.hid = hdev,
+		},
+	};
+	int ret;
+
+	/* no program has been attached yet */
+	if (!hdev->bpf.work_initialized || hdev->bpf.destroyed)
+		return;
+
+	ret = hid_bpf_prog_run(hdev, HID_BPF_PROG_TYPE_OFFLOAD, &ctx_kern);
+	if (ret < 0)
+		hid_warn_once(hdev, "error while executing HID-BPF delayed work: %d", ret);
+}
+
+static void hid_bpf_prep_worker(struct hid_device *hdev)
+{
+	if (hdev->bpf.work_initialized)
+		return;
+
+	INIT_DELAYED_WORK(&hdev->bpf.work, delayed_work_cb);
+	hdev->bpf.work_initialized = true;
+}
+
 static int do_hid_bpf_attach_prog(struct hid_device *hdev, int prog_fd, struct bpf_prog *prog,
 				  __u32 flags)
 {
@@ -215,10 +263,15 @@ static int do_hid_bpf_attach_prog(struct hid_device *hdev, int prog_fd, struct b
 	if (prog_type >= HID_BPF_PROG_TYPE_MAX)
 		return -EINVAL;
 
-	if (prog_type == HID_BPF_PROG_TYPE_DEVICE_EVENT) {
+	switch (prog_type) {
+	case HID_BPF_PROG_TYPE_DEVICE_EVENT:
 		err = hid_bpf_allocate_event_data(hdev);
 		if (err)
 			return err;
+		break;
+	case HID_BPF_PROG_TYPE_OFFLOAD:
+		hid_bpf_prep_worker(hdev);
+		break;
 	}
 
 	fd = __hid_bpf_attach_prog(hdev, prog_type, prog_fd, prog, flags);
@@ -536,6 +589,34 @@ hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf
 
 	return hid_input_report(hdev, type, buf, size, 0);
 }
+
+/**
+ * hid_bpf_schedule_delayed_work - Put work task in the worqueue associated
+ * with the HID device
+ *
+ * @ctx: The HID-BPF context
+ * @delay_ms: a delay in milli seconds, or 0 for immediate execution
+ *
+ * Return: %false if @work was already on a queue, %true otherwise.  If
+ * @delay is zero and @work is idle, it will be scheduled for immediate
+ * execution.
+ */
+__bpf_kfunc bool
+hid_bpf_schedule_delayed_work(struct hid_bpf_ctx *ctx, unsigned int delay_ms)
+{
+	struct hid_device *hdev;
+
+	if (!ctx)
+		return -EINVAL;
+
+	hdev = (struct hid_device *)ctx->hid; /* discard const */
+
+	if (!hdev->bpf.work_initialized) {
+		return -EINVAL;
+	}
+
+	return schedule_delayed_work(&hdev->bpf.work, msecs_to_jiffies(delay_ms));
+}
 __bpf_kfunc_end_defs();
 
 /*
@@ -544,6 +625,12 @@ __bpf_kfunc_end_defs();
  */
 BTF_KFUNCS_START(hid_bpf_kfunc_ids)
 BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
+BTF_ID_FLAGS(func, hid_bpf_schedule_delayed_work)
+BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(hid_bpf_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
@@ -555,7 +642,9 @@ static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
 BTF_SET8_START(hid_bpf_fmodret_ids)
 BTF_ID_FLAGS(func, hid_bpf_device_event)
 BTF_ID_FLAGS(func, hid_bpf_rdesc_fixup)
+BTF_ID_FLAGS(func, hid_bpf_offload, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, __hid_bpf_tail_call)
+BTF_ID_FLAGS(func, __hid_bpf_tail_call_sleepable, KF_SLEEPABLE)
 BTF_SET8_END(hid_bpf_fmodret_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_fmodret_set = {
@@ -610,6 +699,9 @@ void hid_bpf_destroy_device(struct hid_device *hdev)
 	/* mark the device as destroyed in bpf so we don't reattach it */
 	hdev->bpf.destroyed = true;
 
+	if (hdev->bpf.work_initialized)
+		cancel_delayed_work_sync(&hdev->bpf.work);
+
 	__hid_bpf_destroy_device(hdev);
 }
 EXPORT_SYMBOL_GPL(hid_bpf_destroy_device);
diff --git a/drivers/hid/bpf/hid_bpf_jmp_table.c b/drivers/hid/bpf/hid_bpf_jmp_table.c
index aa8e1c79cdf5..d401add0e2ab 100644
--- a/drivers/hid/bpf/hid_bpf_jmp_table.c
+++ b/drivers/hid/bpf/hid_bpf_jmp_table.c
@@ -59,6 +59,7 @@ static DECLARE_WORK(release_work, hid_bpf_release_progs);
 BTF_ID_LIST(hid_bpf_btf_ids)
 BTF_ID(func, hid_bpf_device_event)			/* HID_BPF_PROG_TYPE_DEVICE_EVENT */
 BTF_ID(func, hid_bpf_rdesc_fixup)			/* HID_BPF_PROG_TYPE_RDESC_FIXUP */
+BTF_ID(func, hid_bpf_offload)				/* HID_BPF_PROG_TYPE_OFFLOAD */
 
 static int hid_bpf_max_programs(enum hid_bpf_prog_type type)
 {
@@ -67,6 +68,8 @@ static int hid_bpf_max_programs(enum hid_bpf_prog_type type)
 		return HID_BPF_MAX_PROGS_PER_DEV;
 	case HID_BPF_PROG_TYPE_RDESC_FIXUP:
 		return 1;
+	case HID_BPF_PROG_TYPE_OFFLOAD:
+		return HID_BPF_MAX_PROGS_PER_DEV;
 	default:
 		return -EINVAL;
 	}
@@ -104,14 +107,30 @@ __weak noinline int __hid_bpf_tail_call(struct hid_bpf_ctx *ctx)
 	return 0;
 }
 
+__weak noinline int __hid_bpf_tail_call_sleepable(struct hid_bpf_ctx *ctx)
+{
+	return 0;
+}
+
 int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
 		     struct hid_bpf_ctx_kern *ctx_kern)
 {
 	struct hid_bpf_prog_list *prog_list;
 	int i, idx, err = 0;
 
-	rcu_read_lock();
-	prog_list = rcu_dereference(hdev->bpf.progs[type]);
+	if (type == HID_BPF_PROG_TYPE_OFFLOAD) {
+		/*
+		 * HID_BPF_PROG_TYPE_OFFLOAD can sleep, so we can not
+		 * take an rcu_read_lock()
+		 * Prevent concurrency by taking &hid_bpf_attach_lock
+		 * instead
+		 */
+		mutex_lock(&hid_bpf_attach_lock);
+		prog_list = hdev->bpf.progs[type];
+	} else {
+		rcu_read_lock();
+		prog_list = rcu_dereference(hdev->bpf.progs[type]);
+	}
 
 	if (!prog_list)
 		goto out_unlock;
@@ -123,7 +142,10 @@ int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
 			continue;
 
 		ctx_kern->ctx.index = idx;
-		err = __hid_bpf_tail_call(&ctx_kern->ctx);
+		if (type == HID_BPF_PROG_TYPE_OFFLOAD)
+			err = __hid_bpf_tail_call_sleepable(&ctx_kern->ctx);
+		else
+			err = __hid_bpf_tail_call(&ctx_kern->ctx);
 		if (err < 0)
 			break;
 		if (err)
@@ -131,7 +153,10 @@ int hid_bpf_prog_run(struct hid_device *hdev, enum hid_bpf_prog_type type,
 	}
 
  out_unlock:
-	rcu_read_unlock();
+	if (type == HID_BPF_PROG_TYPE_OFFLOAD)
+		mutex_unlock(&hid_bpf_attach_lock);
+	else
+		rcu_read_unlock();
 
 	return err;
 }
@@ -557,6 +582,7 @@ int hid_bpf_preload_skel(void)
 	}
 
 	ATTACH_AND_STORE_LINK(hid_tail_call);
+	ATTACH_AND_STORE_LINK(hid_tail_call_sleepable);
 
 	return 0;
 out:
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 17b08f500098..87e72ffadff0 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -5,6 +5,7 @@
 
 #include <linux/bpf.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 #include <uapi/linux/hid.h>
 
 struct hid_device;
@@ -76,6 +77,7 @@ enum hid_bpf_attach_flags {
 /* Following functions are tracepoints that BPF programs can attach to */
 int hid_bpf_device_event(struct hid_bpf_ctx *ctx);
 int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx);
+int hid_bpf_offload(struct hid_bpf_ctx *ctx);
 
 /*
  * Below is HID internal
@@ -83,6 +85,7 @@ int hid_bpf_rdesc_fixup(struct hid_bpf_ctx *ctx);
 
 /* internal function to call eBPF programs, not to be used by anybody */
 int __hid_bpf_tail_call(struct hid_bpf_ctx *ctx);
+int __hid_bpf_tail_call_sleepable(struct hid_bpf_ctx *ctx);
 
 #define HID_BPF_MAX_PROGS_PER_DEV 64
 #define HID_BPF_FLAG_MASK (((HID_BPF_FLAG_MAX - 1) << 1) - 1)
@@ -92,6 +95,7 @@ enum hid_bpf_prog_type {
 	HID_BPF_PROG_TYPE_UNDEF = -1,
 	HID_BPF_PROG_TYPE_DEVICE_EVENT,			/* an event is emitted from the device */
 	HID_BPF_PROG_TYPE_RDESC_FIXUP,
+	HID_BPF_PROG_TYPE_OFFLOAD,
 	HID_BPF_PROG_TYPE_MAX,
 };
 
@@ -129,6 +133,9 @@ struct hid_bpf {
 	bool destroyed;			/* prevents the assignment of any progs */
 
 	spinlock_t progs_lock;		/* protects RCU update of progs */
+
+	struct delayed_work work;
+	bool work_initialized;
 };
 
 /* specific HID-BPF link when a program is attached to a device */

-- 
2.43.0


