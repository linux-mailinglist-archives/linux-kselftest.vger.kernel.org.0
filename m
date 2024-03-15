Return-Path: <linux-kselftest+bounces-6355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B84A87CF33
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 15:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE49D1F233E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED333BB52;
	Fri, 15 Mar 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQZgPncf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFE1BDE0;
	Fri, 15 Mar 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513890; cv=none; b=hR9YHdbUuZ09oKtTUnSaNBLEtg4VGclo1DEu6u8IyTR6/IY8fXNgZ+5o6BgQk3Ycxi+V2mz58oN9ZJtnmUFOhhWXnVh3jRaQNCc+obdUaigl+jzB0sCngf/LPsSHC8IXUBuGJQzZP7CQajxQ6+hg+rWYMsgLJKNvV2/nu4CBzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513890; c=relaxed/simple;
	bh=oLZvjVXr7zNxl0tYVVqGxzqOMyHkWY4EukDLBuqjtGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6LS6MEM4vR/G49m7zRklPiLm9cuBTKUrQ+cK+JKo/b8Lz0L5ltOAO4Z8MyVoINoRqMhXgaxH61FbZFuG5V4pWLuo8L2ooenEWvxhDbAGHKepgcGm90E4a4Pzftx2mf1xZ3qOZSL8yNSHuk1rdKY13FE7rL9aC1PVf5T9dYwl9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQZgPncf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C57CC43399;
	Fri, 15 Mar 2024 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513890;
	bh=oLZvjVXr7zNxl0tYVVqGxzqOMyHkWY4EukDLBuqjtGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CQZgPncfGTG/5mpBofStzL0F7GrEfhlqrhzzu3wdI73bQWSoEOGI8rtOK2tP69Ecb
	 /dvjQSRSNMfuJoENEpB/EiWP+pXrw6d8fil9PGozEsLfFdTYa91Q3Jh9NFcj9NEXdc
	 ojUF1Hf3xLXrxFApJhZ8EB/CS6SDlD83tvKKCvaPbeszLQLjxAawmFTq2lZV9EWqE5
	 4A6ohzkAMyBsO8VXyIRoYl+9Hr9Qx1N6+ci0i3tGelWIREaqNUmDD9/yJJ/NVe5J+Q
	 fIJrVXPhoP08PmXR/Sewi5CCml8BL03rDOJAL64EuihQSbTdGoBBLmZ0ePOSZlWo0u
	 KyBoG3ww6C8VQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 15 Mar 2024 15:44:38 +0100
Subject: [PATCH v4 1/7] HID: bpf/dispatch: regroup kfuncs definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-hid-bpf-new-funcs-v4-1-079c282469d3@kernel.org>
References: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
In-Reply-To: <20240315-b4-hid-bpf-new-funcs-v4-0-079c282469d3@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710513885; l=3541;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=oLZvjVXr7zNxl0tYVVqGxzqOMyHkWY4EukDLBuqjtGw=;
 b=/ra8+t0jpst1C0YN+qdKGFMxcgj5YhI9W4lmREI9BNtYg+4l0B24KuWZodmipU96Q2SwV3Q6+
 ltel/lxtfV2A0OyTGDD1H1V6nFHwuqmXQteFsfrKYM3+zDYWoh5maXr
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

No code change, just move down the hid_bpf_get_data() kfunc definition
so we have only one block of __bpf_kfunc_start/end_defs()

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

no changes in v4

no changes in v3

no changes in v2
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
2.44.0


