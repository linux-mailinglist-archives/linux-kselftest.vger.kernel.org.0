Return-Path: <linux-kselftest+bounces-12868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C338591ABD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 17:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7892E1F2336B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7BF199243;
	Thu, 27 Jun 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp+WXlJi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA491922CD;
	Thu, 27 Jun 2024 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503354; cv=none; b=uJzyqBdsjjaduHO0bhL5/rsVfNAoh4MxJds7ofy3TR+1VWtc+WGO5G7ke0waTCxXml8vCH7bS2zA6ptH5VcORY28rvNQkLfv9kaUtS1IUQX8od3RzA2jzlpAG1S6h5n6Ycu9Vj/qV5gI9T2hejSuzP6sdpAYzof5yqD8s29sYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503354; c=relaxed/simple;
	bh=xgjUZRmQAA3oaZk9hzcDX3hZLFBkFo2wuKMcGzAVB7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pXFfHONVJfyCpQWZ0rXxIbaPyiqybMMMRDF+8jxwMihzK57/fdGy7c9gzIeVN+HLnOh7HSFHYTN40jsJi3kBIOE0fZZjEIWTln43g4tC2o9e2NaFNtm464znyMeaQW5MrUFssVF0Fsi+tDQ7LYMXsBE6PrimdjiP+vL+LEh//QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp+WXlJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAB6C2BBFC;
	Thu, 27 Jun 2024 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719503353;
	bh=xgjUZRmQAA3oaZk9hzcDX3hZLFBkFo2wuKMcGzAVB7o=;
	h=From:Date:Subject:To:Cc:From;
	b=Gp+WXlJid+W5KQva3Or6bBrmAxtgW1JfEYGGFvUqcMHvHeiRIvB2FGkAJxGz24nbH
	 G7L6CTA5F+q4g2VR5yAj1KTQ65zan0/GZLIDNA4kpQ0IQXYdOnkbs7Wf/5uklveGKr
	 pM0CRvrtH2GKG7SIcTeRKL2yyM1qO571EBkNWH9LDuGlW857QfEz7iRCREeZxNCmYp
	 jywdPpKQUbJEpw+Y3Y4H5eAjbo9YKTUP86LTaLFhTWfAH9zX5nLQlht5tYSfSNqVsc
	 Ws0RZouZId2PG2dsU6qucoavHvhR7wp1ZI/LQ0qiUnrhj2cKCx3dtrZxnjPg528EUf
	 hnfLQQP5nQtHw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 27 Jun 2024 17:49:07 +0200
Subject: [PATCH] selftests/hid: ensure CKI can compile our new tests on old
 kernels
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-fix-cki-v1-1-2b47ceac116a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPKJfWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNz3bTMCt3k7EzdNGNzIwtT0+SkNLM0JaDqgqJUoBTYpOjY2loAGLL
 Jn1kAAAA=
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719503352; l=2538;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=xgjUZRmQAA3oaZk9hzcDX3hZLFBkFo2wuKMcGzAVB7o=;
 b=95iTWBmDiE/6+whJH0CAZPlsQ44A96rWBoxXMbzBOr+W6DyK+lrkdI4ij6ksmS7kWoPGSpQ7b
 QfDjmuoPtHCD3OzlQKXT5iyAoA9sLQNdI/k3BCNezixLRIywl6bjnEU
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

In the same way than commit ae7487d112cf ("selftests/hid: ensure we can
compile the tests on kernels pre-6.3") we should expose struct hid_bpf_ops
when it's not available in vmlinux.h.

So unexpose an eventual struct hid_bpf_ops, include vmlinux.h, and
re-export struct hid_bpf_ops.

Fixes: d7696738d66b ("selftests/hid: convert the hid_bpf selftests with struct_ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202406270328.bscLN1IF-lkp@intel.com/
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Same situation than in an early report when HID-BPF was initially
included: the automatically generated vmlinux.h doesn't contain all of
the required structs and the compilation of the bpf program fails.
---
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index c72e44321764..5a911f0e8625 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -7,6 +7,7 @@
 
 /* "undefine" structs and enums in vmlinux.h, because we "override" them below */
 #define hid_bpf_ctx hid_bpf_ctx___not_used
+#define hid_bpf_ops hid_bpf_ops___not_used
 #define hid_report_type hid_report_type___not_used
 #define hid_class_request hid_class_request___not_used
 #define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
@@ -24,6 +25,7 @@
 #include "vmlinux.h"
 
 #undef hid_bpf_ctx
+#undef hid_bpf_ops
 #undef hid_report_type
 #undef hid_class_request
 #undef hid_bpf_attach_flags
@@ -68,6 +70,20 @@ enum hid_class_request {
 	HID_REQ_SET_PROTOCOL		= 0x0B,
 };
 
+struct hid_bpf_ops {
+	int			hid_id;
+	u32			flags;
+	struct list_head	list;
+	int (*hid_device_event)(struct hid_bpf_ctx *ctx, enum hid_report_type report_type,
+				__u64 source);
+	int (*hid_rdesc_fixup)(struct hid_bpf_ctx *ctx);
+	int (*hid_hw_request)(struct hid_bpf_ctx *ctx, unsigned char reportnum,
+			       enum hid_report_type rtype, enum hid_class_request reqtype,
+			       __u64 source);
+	int (*hid_hw_output_report)(struct hid_bpf_ctx *ctx, __u64 source);
+	struct hid_device *hdev;
+};
+
 #ifndef BPF_F_BEFORE
 #define BPF_F_BEFORE (1U << 3)
 #endif

---
base-commit: d3e15189bfd4d0a9d3a7ad8bd0e6ebb1c0419f93
change-id: 20240627-fix-cki-f372855cbf6f

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


