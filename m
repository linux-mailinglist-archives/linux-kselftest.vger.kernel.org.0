Return-Path: <linux-kselftest+bounces-22601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F79DB892
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCDA16419C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0682D1A9B30;
	Thu, 28 Nov 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4x8dQLJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DA1A3BC0;
	Thu, 28 Nov 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800442; cv=none; b=lfmB9qSxWrYicUCpG0mP4aJn/Z8f+0JQ7ykIw4zW7YvZ4BcEUeDA8jYYTMvBh0qPetDTuk1wQMZrYmoKrRlzg8+vDcAdSrzjgF0VZOHzJRwYyyJgThah0q/z3y5iGnXLWtM9UniKgE6MTi6yWIY3iHi5PXRfS8ivxFHZkP1SXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800442; c=relaxed/simple;
	bh=s7ntmLyoK0Ige0yP54n7nzwN2qCmpmvx316Vpb4inks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CXxoh26umEpvjPbSABpoEANAQ6Bkx0PoejZFN7QuSVZoCTpTf5sIQzJzemRpy/6QxPjYd/ze88J+jmVDgwneuCOVvObO+vCdO2uEhb1UNGaHYjMrkoPyMMDznSajBU4KrYFQ0L3pnKzW8BvGYlf7fGuo2AO8gXgWl9Ljk3N/aWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4x8dQLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1117BC4CED3;
	Thu, 28 Nov 2024 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732800442;
	bh=s7ntmLyoK0Ige0yP54n7nzwN2qCmpmvx316Vpb4inks=;
	h=From:Date:Subject:To:Cc:From;
	b=W4x8dQLJLyeKbmnDT2QjsgZfRNMP4shFyIT/3c8z4rXM1Q/HOOYiYE34+B0dse2ok
	 1+ykhOG408CCgxPWHbaO+oPmaBISGvzv+9xC5qywv17Kn84nzFjhejrE3LevibFyiz
	 GO8cD4fznOGsQyuRrH4UVUylijcfaxocejNrCdD/mA692bOAE2lI0Agnth1vGEFLSb
	 pot7E1hZkYLaZuKVPp8IHfmFYxO/vpeP8tznGvRIUecQzi2j2/IHFLdozbuA1/SVK7
	 bzziZ6k3yNig+NLDXsg1lTAIxAGJfGIl3R6wzsedWNepAfakRrLu1QkVr6Sgl0TbKZ
	 PslcPSFNW+O7A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 28 Nov 2024 14:27:16 +0100
Subject: [PATCH HID] selftests/hid: fix kfunc inclusions with newer bpftool
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-fix-new-bpftool-v1-1-c9abdf94a719@kernel.org>
X-B4-Tracking: v=1; b=H4sIALNvSGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyML3bTMCt281HLdpIK0kvz8HF1jw0TLNBPjxMS0pCQloK6ColSgErC
 J0Uoeni5KsbW1ADG4jtxmAAAA
X-Change-ID: 20241128-fix-new-bpftool-31a9f43aafbb
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732800440; l=3659;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=s7ntmLyoK0Ige0yP54n7nzwN2qCmpmvx316Vpb4inks=;
 b=PREaqb+BXRq/tIkrsTWycjKGYBT+dINU4VsCFZL2/q0/YXm/vlTEaUZriVdHDTZk7HtnLrfUL
 /Lrw153FIwxDPxv8iyaIJ2+xt8XzW80dC/LigpAPfgDnrsD++kjCNvz
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

bpftool now embeds the kfuncs definitions directly in the generated
vmlinux.h

This is great, but because the selftests dir might be compiled with
HID_BPF disabled, we have no guarantees to be able to compile the
sources with the generated kfuncs.

If we have the kfuncs, because we have the `__not_used` hack, the newly
defined kfuncs do not match the ones from vmlinux.h and things go wrong.

Prevent vmlinux.h to define its kfuncs and also add the missing `__weak`
symbols for our custom kfuncs definitions

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
This was noticed while bumping the CI to fedora 41 which has an update
of bpftool.

I'll probably take this in for-6.13/upstream-fixes tomorrow if no bots
comes back at me.

Cheers,
Benjamin
---
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index e5db897586bbfe010d8799f6f52fc5c418344e6b..531228b849daebcf40d994abb8bf35e760b3cc4e 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -22,6 +22,9 @@
 #define HID_REQ_SET_IDLE         HID_REQ_SET_IDLE___not_used
 #define HID_REQ_SET_PROTOCOL     HID_REQ_SET_PROTOCOL___not_used
 
+/* do not define kfunc through vmlinux.h as this messes up our custom hack */
+#define BPF_NO_KFUNC_PROTOTYPES
+
 #include "vmlinux.h"
 
 #undef hid_bpf_ctx
@@ -91,31 +94,31 @@ struct hid_bpf_ops {
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,
-			      const size_t __sz) __ksym;
-extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __ksym;
-extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __ksym;
+			      const size_t __sz) __weak __ksym;
+extern struct hid_bpf_ctx *hid_bpf_allocate_context(unsigned int hid_id) __weak __ksym;
+extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __weak __ksym;
 extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
 			      __u8 *data,
 			      size_t buf__sz,
 			      enum hid_report_type type,
-			      enum hid_class_request reqtype) __ksym;
+			      enum hid_class_request reqtype) __weak __ksym;
 extern int hid_bpf_hw_output_report(struct hid_bpf_ctx *ctx,
-				    __u8 *buf, size_t buf__sz) __ksym;
+				    __u8 *buf, size_t buf__sz) __weak __ksym;
 extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx,
 				enum hid_report_type type,
 				__u8 *data,
-				size_t buf__sz) __ksym;
+				size_t buf__sz) __weak __ksym;
 extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx,
 				    enum hid_report_type type,
 				    __u8 *data,
-				    size_t buf__sz) __ksym;
+				    size_t buf__sz) __weak __ksym;
 
 /* bpf_wq implementation */
 extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int flags) __weak __ksym;
 extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __ksym;
 extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 		int (callback_fn)(void *map, int *key, void *wq),
-		unsigned int flags__k, void *aux__ign) __ksym;
+		unsigned int flags__k, void *aux__ign) __weak __ksym;
 #define bpf_wq_set_callback(timer, cb, flags) \
 	bpf_wq_set_callback_impl(timer, cb, flags, NULL)
 

---
base-commit: 919464deeca24e5bf13b6c8efd0b1d25cc43866f
change-id: 20241128-fix-new-bpftool-31a9f43aafbb

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


