Return-Path: <linux-kselftest+bounces-4415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21184F5D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD40F1C22AF0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 13:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA9E38380;
	Fri,  9 Feb 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhkI/sY8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BC3CF49;
	Fri,  9 Feb 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485228; cv=none; b=aIKvcyisCo7h4mkcgH46+yo9Oc3tSiiYR5FUJ5q4XjeHPg7ihkwM07uh7nXtEtRnTRRpahMsMTiOZ/xCAekcUyMGS3xljrCRQK8ft0AywP4Ibz528rdx5m4fZZeMMr5e+rDZ4zLeeWX8s0A98W+hkqW4W7yvYqNgzyfbXKEuyvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485228; c=relaxed/simple;
	bh=G1d/JrzZNBfaI7qHXNWZSl8CY5ia+RArq97xWn6B1Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ez5ssOJf9pVMu4rXQo63PtqnIsxMv2BPd+lY9z1PzJfCgBcj5TEmHMaMZvBU4VopZOsW5YwVumZh56rZDh3Ef/eyJMXznZGLape9Ay9N/ElRvrc7XU/hNC4K755oYXnuKaJrK6ezo5Q/20Rg+aquKXGxEb0w2YWY34gpRWaOACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhkI/sY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE61C43601;
	Fri,  9 Feb 2024 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485228;
	bh=G1d/JrzZNBfaI7qHXNWZSl8CY5ia+RArq97xWn6B1Qc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OhkI/sY8kmU2i1LrDzpCFL8BPtz/go96jAbtQrq9fhEN9XL9ymZUe80CDwDActfOi
	 f9QkFEVxN9dI05sp5BIlzKPFumJSIbvygKvijBjlB1CHdIV1jaH1Y3f6DIK7Zdrkmc
	 nmMfnyURHQLjDfDHZIkTMAekDgEFHRBiRpqdseWyw0/VavoE5uBJzV3t6t7E2HP0MR
	 gEcpjKIYq//Vlm+De1hKjPVX//4FtPh3IAMLNoNiHWHg9VaNs7WLwp4PZcGpeEOHN0
	 CRncbC6VosY7GLdUgeQGXrb5bGC8qUIXjXsIEJMHilOnVOlmFfz2KQXT1dn+0Pyzta
	 ucp57D4MiTIiw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 09 Feb 2024 14:26:38 +0100
Subject: [PATCH RFC bpf-next 2/9] HID: bpf/dispatch: regroup kfuncs
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-hid-bpf-sleepable-v1-2-4cc895b5adbd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707485215; l=3474;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=G1d/JrzZNBfaI7qHXNWZSl8CY5ia+RArq97xWn6B1Qc=;
 b=MDr1jalLgT27b6gm39vVSyoKtjpWeAOxnJXhWYn33gGAo0NzreZg/We+hpVxfDaS2Fr0KJFfr
 c8XnO2/nwPcDi7v591EUOt/+ohytgnxRhEHn0kuDPOefwx+0ID9lgp/
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

No code change, just move down the hid_bpf_get_data() kfunc definition
so we have only one block of __bpf_kfunc_start/end_defs()

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 80 ++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 42 deletions(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index e630caf644e8..52abb27426f4 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -143,48 +143,6 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *s
 }
 EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
 
-/* Disables missing prototype warnings */
-__bpf_kfunc_start_defs();
-
-/**
- * hid_bpf_get_data - Get the kernel memory pointer associated with the context @ctx
- *
- * @ctx: The HID-BPF context
- * @offset: The offset within the memory
- * @rdwr_buf_size: the const size of the buffer
- *
- * @returns %NULL on error, an %__u8 memory pointer on success
- */
-__bpf_kfunc __u8 *
-hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr_buf_size)
-{
-	struct hid_bpf_ctx_kern *ctx_kern;
-
-	if (!ctx)
-		return NULL;
-
-	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
-
-	if (rdwr_buf_size + offset > ctx->allocated_size)
-		return NULL;
-
-	return ctx_kern->data + offset;
-}
-__bpf_kfunc_end_defs();
-
-/*
- * The following set contains all functions we agree BPF programs
- * can use.
- */
-BTF_KFUNCS_START(hid_bpf_kfunc_ids)
-BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
-BTF_KFUNCS_END(hid_bpf_kfunc_ids)
-
-static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
-	.owner = THIS_MODULE,
-	.set   = &hid_bpf_kfunc_ids,
-};
-
 static int device_match_id(struct device *dev, const void *id)
 {
 	struct hid_device *hdev = to_hid_device(dev);
@@ -281,6 +239,31 @@ static int do_hid_bpf_attach_prog(struct hid_device *hdev, int prog_fd, struct b
 /* Disables missing prototype warnings */
 __bpf_kfunc_start_defs();
 
+/**
+ * hid_bpf_get_data - Get the kernel memory pointer associated with the context @ctx
+ *
+ * @ctx: The HID-BPF context
+ * @offset: The offset within the memory
+ * @rdwr_buf_size: the const size of the buffer
+ *
+ * @returns %NULL on error, an %__u8 memory pointer on success
+ */
+__bpf_kfunc __u8 *
+hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const size_t rdwr_buf_size)
+{
+	struct hid_bpf_ctx_kern *ctx_kern;
+
+	if (!ctx)
+		return NULL;
+
+	ctx_kern = container_of(ctx, struct hid_bpf_ctx_kern, ctx);
+
+	if (rdwr_buf_size + offset > ctx->allocated_size)
+		return NULL;
+
+	return ctx_kern->data + offset;
+}
+
 /**
  * hid_bpf_attach_prog - Attach the given @prog_fd to the given HID device
  *
@@ -474,6 +457,19 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 }
 __bpf_kfunc_end_defs();
 
+/*
+ * The following set contains all functions we agree BPF programs
+ * can use.
+ */
+BTF_KFUNCS_START(hid_bpf_kfunc_ids)
+BTF_ID_FLAGS(func, hid_bpf_get_data, KF_RET_NULL)
+BTF_KFUNCS_END(hid_bpf_kfunc_ids)
+
+static const struct btf_kfunc_id_set hid_bpf_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &hid_bpf_kfunc_ids,
+};
+
 /* our HID-BPF entrypoints */
 BTF_SET8_START(hid_bpf_fmodret_ids)
 BTF_ID_FLAGS(func, hid_bpf_device_event)

-- 
2.43.0


