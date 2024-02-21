Return-Path: <linux-kselftest+bounces-5192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF54A85E332
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9E5287950
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16684FD8;
	Wed, 21 Feb 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4NLUfJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D081AA3;
	Wed, 21 Feb 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532764; cv=none; b=KtcJuhsb2YpAQ/OEBTDH8KYhVwAcG3jYn6geiS5/nw84HixPLyCyVVxG9PzSM7P4CoWceP2xBlb4tuRn3OUNc6IyL85kwS+nM6aNQmbhggoEwu7qjqCvxDF85oLVnVR5Pn4Bw+x3NjybNgpzDTWURD9yz/wQhk3v5PDTypa2MzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532764; c=relaxed/simple;
	bh=TtpobMMu80H5N4HlAwS872e0X6zIMx4ZXZINEqECFG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogU8edUS8ngyk3AVK8gMEZVeMprQlXr6q3TRX0BwKfnOyr7Q2tssIgs9WQe53IBTql9tKvU3hiTxZkM9RqPXQYpjYZlYeSkG+6JF6bqnRagbmLxysBsSjYBR0gtd/aMbNlisVmSFtPgoxG8M1BA7jLJNkeax54s2XQUo+sofTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4NLUfJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE7EC43601;
	Wed, 21 Feb 2024 16:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708532764;
	bh=TtpobMMu80H5N4HlAwS872e0X6zIMx4ZXZINEqECFG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J4NLUfJmXHd/29pu0o91PmvPaBM7350lH59pHtHwEvmFthvtFmklHRcfBK9d36ggv
	 kcmtcWf2dwCVQlexKW3Too2HIvL24/kkbeCLWgkxq2F8z7ThNSYX6wINhPQUy1OVPj
	 ZFftLnvxlg2z7K6PYoHDbY/MxDVXZEwHx7EU20gvgYFmuA5iWQh4Hmf7Qq42s4tUs1
	 kbKv70zo9sdLbub67NwaPz8Jl0Fsq5fjquMf5rXATC69ZbrkBY2QusxZMapR6YaCmn
	 mhQYm/7qOzVCdeNMq4qTDpILesI6ks96BHGKkVcf9rbbIEv8tj2jbdVF4SbK1/moGH
	 cAPEJnK6wFMog==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 21 Feb 2024 17:25:25 +0100
Subject: [PATCH RFC bpf-next v3 09/16] HID: bpf/dispatch: regroup kfuncs
 definitions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-hid-bpf-sleepable-v3-9-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
In-Reply-To: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708532719; l=3521;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=TtpobMMu80H5N4HlAwS872e0X6zIMx4ZXZINEqECFG0=;
 b=T33LfFftYVbRgn8ui1NAZaKDxcIcF6nO+CzP83MtS0HpUbPOCpJ/D50R/OgWDqPW35i3EGMvT
 noF8L43G4s4ByXqsa9Tnmx6vjw6FZXDr6fjECinHtfnfXGAC6mB5TUs
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

No code change, just move down the hid_bpf_get_data() kfunc definition
so we have only one block of __bpf_kfunc_start/end_defs()

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

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
2.43.0


