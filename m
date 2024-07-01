Return-Path: <linux-kselftest+bounces-13003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D791DF86
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 14:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19A71F223CE
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F07158DC5;
	Mon,  1 Jul 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwsNN4RE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC4158DC1;
	Mon,  1 Jul 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837608; cv=none; b=Xyx78ZzIbH0GH5wo1MplGw9x2EvoZdJqTqZLLlDrRH/zGqRuC0vzwjeHoTMbfhm8chXyehnvpZkvWOlC0Oh2wqkWFnHzJWXFHhhKb77y96qyy9h0IBPE0lRfK24/jcF1orV5XrjISt4x1J86Nm3xI0ZFNyu1YeQnWsB+bkVdn5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837608; c=relaxed/simple;
	bh=wUTkvXyhHibZnDuwGG5f5DWJ6ZMD2AeiGWNMkuFtnos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMwdY810iHCCHfgKyqnETJLzS4u52/eZPInqdfiLJFwXKevGQh2eBDkNfJwrfaSM05OONMNoPsMy4SKyCyKK8i77rdSPMItDPnL8hsvcpKKm6P0NXUviXvVSbYSH2e7jNvO5Rcxi3nK2OmFzSe7Eu9j08uJu/0eij0p8g/3O6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwsNN4RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94312C2BD10;
	Mon,  1 Jul 2024 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837608;
	bh=wUTkvXyhHibZnDuwGG5f5DWJ6ZMD2AeiGWNMkuFtnos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gwsNN4RE3fVi5nraG6juGC/GU5lGq5v8b8WgcpiYvgwzR7ETQvwIEepI6sLeiE548
	 t+q5GByqu3CWlxbTjEVbQvGGFwukpQ/otyzhMG7qlzZC5fA3MzlwRTPzKJ+lGnDotU
	 u90o/3So0XJHN+s93L5V1jwElv0qEmV0jCMNhI9u+3OqW5zuEOnzfiV5QGdwPnXziF
	 7adP+MtjpixMGXgxQ2P+xDac1uiJtZubcHrObZNE3tFZJBAyBBO+QzYLRHssqyVucb
	 4khIfVAXVXHgkVVUdaghtWHgW96h6vHsbSMqNFbhkooEVl+FUSZYWV5JNvC+KeQZXx
	 hpsnLjLRZS8HA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 01 Jul 2024 14:39:49 +0200
Subject: [PATCH v2 1/4] selftests/hid: ensure CKI can compile our new tests
 on old kernels
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-fix-cki-v2-1-20564e2e1393@kernel.org>
References: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
In-Reply-To: <20240701-fix-cki-v2-0-20564e2e1393@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719837604; l=2168;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=wUTkvXyhHibZnDuwGG5f5DWJ6ZMD2AeiGWNMkuFtnos=;
 b=HQnDH2nfTSNV7IEghujL2e56X8WREttd1ik4zF7a5pVjq+sQyu80g/utFKVTf4M1WYqw6jh9o
 x7wTP+gGa3pAIjcSIaBK8cjU/tMAqktE6PpOFI9IPNTSVh3wiKcWLE4
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
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index c72e44321764..cfe37f491906 100644
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
+				u64 source);
+	int (*hid_rdesc_fixup)(struct hid_bpf_ctx *ctx);
+	int (*hid_hw_request)(struct hid_bpf_ctx *ctx, unsigned char reportnum,
+			       enum hid_report_type rtype, enum hid_class_request reqtype,
+			       u64 source);
+	int (*hid_hw_output_report)(struct hid_bpf_ctx *ctx, u64 source);
+	struct hid_device *hdev;
+};
+
 #ifndef BPF_F_BEFORE
 #define BPF_F_BEFORE (1U << 3)
 #endif

-- 
2.44.0


