Return-Path: <linux-kselftest+bounces-4418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F356984F5E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 14:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D421C22572
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E833C46B;
	Fri,  9 Feb 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbzpeaGR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29245943;
	Fri,  9 Feb 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485242; cv=none; b=L+PshHpLMOFaISrsW/80FY2PPtEVN6pCW0bXkfTKBtfnpKvMVAhAHu4JeiJj+BUfk/07tvGz4IrtBZBVUOdH3fw9n5VT46HhKuHkqBxkqGpLPHpVMd7jgfL41fT4ZSEKtEAor+sdgURwmuff6YK97NubaKmDUwDECYUgefotyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485242; c=relaxed/simple;
	bh=eHQzLP8mt/J9TYecehuvw87qoCLfcFZExMaGK6coG4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bA7JBlj9uvfVYaCuvV72JTEO2fyn+DDp7b/CLDm3y57txQ2RSRLrcyUnAEwb6C/V7/37CttPUrto0HE8+JwRX3ZIKIEdTH97be6smwjnUCh/tj/9f4idBis2t1/Wu4jIC7pE0CcV+NX8uWCMRipN/Kuplm0dtUeCe+MdNcj74NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbzpeaGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE42C43394;
	Fri,  9 Feb 2024 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485241;
	bh=eHQzLP8mt/J9TYecehuvw87qoCLfcFZExMaGK6coG4I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dbzpeaGRRctPTuEJX0O44QpQhu0an+7lplsvi/KS9ySdJwcivA3hAnMcnJk1snraE
	 JziXOItJPAOiy31f8vpZnfJGzbOFQFqKJ9nXtZXGYk6ZYoJqi+CLQ+kUgQpIDhY+VZ
	 GJwuE66Ldox1N87uF6Mgh8oPeIEoeoaPLwnuRuhWXGk2t+FCpDcexvYuqC5WFYH6Us
	 OUHvO4qW/KilxIYW/4dwCnp8pft9C9oyJAfPygRYNC1fzkwlZ4fIsfmWiLdc8M13YW
	 m1UHN2kOuKMaWsqGftLKVAU/abhepWdeOKsl/G8Q+uSmEXRKR3zDICVQyHnZkLqNzq
	 sszUiKSnGKGSw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 09 Feb 2024 14:26:41 +0100
Subject: [PATCH RFC bpf-next 5/9] HID: bpf: allow to inject HID event from
 BPF
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-hid-bpf-sleepable-v1-5-4cc895b5adbd@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707485215; l=4095;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=eHQzLP8mt/J9TYecehuvw87qoCLfcFZExMaGK6coG4I=;
 b=7gQnFnY7VrnS3lcxjA8q3nsDUUBUAszsnDCTehyn1yCtX4tialIpT/1UuZYp6IDz37t9mo62x
 qlv6QKXORtXDIcCZ3TEjldNjXXiu3Jnzkm+0FP91tyFOATfnodTzw/p
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

It can be interesting to inject events from BPF as if the event were
to come from the device.
For example, some multitouch devices do not all the time send a proximity
out event, and we might want to send it for the physical device.

Compared to uhid, we can now inject events on any physical device, not
just uhid virtual ones.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 Documentation/hid/hid-bpf.rst      |  2 +-
 drivers/hid/bpf/hid_bpf_dispatch.c | 29 +++++++++++++++++++++++++++++
 drivers/hid/hid-core.c             |  1 +
 include/linux/hid_bpf.h            |  2 ++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index a575004d9025..0765b3298ecf 100644
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -179,7 +179,7 @@ Available API that can be used in syscall HID-BPF programs:
 -----------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_allocate_context hid_bpf_release_context
+   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_hw_output_report hid_bpf_input_report hid_bpf_allocate_context hid_bpf_release_context
 
 General overview of a HID-BPF program
 =====================================
diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index a5b88b491b80..e1a650f4a626 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -508,6 +508,34 @@ hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz)
 	kfree(dma_data);
 	return ret;
 }
+
+/**
+ * hid_bpf_input_report - Inject a HID report in the kernel from a HID device
+ *
+ * @ctx: the HID-BPF context previously allocated in hid_bpf_allocate_context()
+ * @type: the type of the report (%HID_INPUT_REPORT, %HID_FEATURE_REPORT, %HID_OUTPUT_REPORT)
+ * @buf: a %PTR_TO_MEM buffer
+ * @buf__sz: the size of the data to transfer
+ *
+ * @returns %0 on success, a negative error code otherwise.
+ */
+__bpf_kfunc int
+hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *buf,
+		     const size_t buf__sz)
+{
+	struct hid_device *hdev;
+	size_t size = buf__sz;
+	int ret;
+
+	/* check arguments */
+	ret = __hid_bpf_hw_check_params(ctx, buf, &size, type);
+	if (ret)
+		return ret;
+
+	hdev = (struct hid_device *)ctx->hid; /* discard const */
+
+	return hid_input_report(hdev, type, buf, size, 0);
+}
 __bpf_kfunc_end_defs();
 
 /*
@@ -542,6 +570,7 @@ BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
 BTF_ID_FLAGS(func, hid_bpf_hw_request)
 BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
+BTF_ID_FLAGS(func, hid_bpf_input_report)
 BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
 
 static const struct btf_kfunc_id_set hid_bpf_syscall_kfunc_set = {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1243595890ba..b1fa0378e8f4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2975,6 +2975,7 @@ static struct hid_bpf_ops hid_ops = {
 	.hid_get_report = hid_get_report,
 	.hid_hw_raw_request = hid_hw_raw_request,
 	.hid_hw_output_report = hid_hw_output_report,
+	.hid_input_report = hid_input_report,
 	.owner = THIS_MODULE,
 	.bus_type = &hid_bus_type,
 };
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index 5c7ff93dc73e..17b08f500098 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -104,6 +104,8 @@ struct hid_bpf_ops {
 				  size_t len, enum hid_report_type rtype,
 				  enum hid_class_request reqtype);
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len);
+	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
+				u8 *data, u32 size, int interrupt);
 	struct module *owner;
 	const struct bus_type *bus_type;
 };

-- 
2.43.0


