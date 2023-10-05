Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570C67BA4D0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbjJEQK7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbjJEQJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 12:09:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCBEB2A7;
        Thu,  5 Oct 2023 08:55:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4099C433CD;
        Thu,  5 Oct 2023 15:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696521356;
        bh=Bys1WVOEmDbhQYrXkqjsHDKHnLJh8N2r8hiIygj+vZk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VNbm8RBF3c0TqiaXfPc8LeNS/yAMhTg3vGsxI/kgPjQWTDTS2MkL8a406qeiqXgAc
         LUfd2xVr0p4lf+LVIAs9w95jovFNwY6uZGLABjCUItlRw9jJUNUZwQBYszCHZTfnDd
         UAOo4M59IRwGDgOptxpK1icCLKXrQCMZ85mGAwi/+3LTrNFAfhJW1DKmEFau0FNY6m
         /NNbRIz7vzpFqbuMgRfmlXubpLoA14MKVdlqR8P2rsJe2T1ntT8OStCN1YGONBRL6I
         oY+hMsJgs2dkdLG+BcppQRFNLgJcIIXaxV7fQ1UOJEf6ArhbyMXQnMrwaBCRkoJd2r
         BiBi1LhfHRq4A==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Thu, 05 Oct 2023 17:55:32 +0200
Subject: [PATCH v3 1/3] selftests/hid: ensure we can compile the tests on
 kernels pre-6.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v3-1-639963c54109@kernel.org>
References: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
In-Reply-To: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696521351; l=4601;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Bys1WVOEmDbhQYrXkqjsHDKHnLJh8N2r8hiIygj+vZk=;
 b=A3WDQOElTVS7RO+kzoxx9v3yEz4D62ho7M/szwJvz4Qu8mi9GzdHe66ADW1uECvTlOIKiGNYi
 bVyoxabpFlrBUNu92TtLm38lVWnrnYiZvQRziVxkls6nhn2lVIiUf/e
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For the hid-bpf tests to compile, we need to have the definition of
struct hid_bpf_ctx. This definition is an internal one from the kernel
and it is supposed to be defined in the generated vmlinux.h.

This vmlinux.h header is generated based on the currently running kernel
or if the kernel was already compiled in the tree. If you just compile
the selftests without compiling the kernel beforehand and you are running
on a 6.2 kernel, you'll end up with a vmlinux.h without the hid_bpf_ctx
definition.

Use the clever trick from tools/testing/selftests/bpf/progs/bpf_iter.h
to force the definition of that symbol in case we don't find it in the
BTF and also add __attribute__((preserve_access_index)) to further
support CO-RE functionality for these tests.

Signed-off-by: Justin Stitt <justinstitt@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Build
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/progs/hid.c            |  3 -
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 77 ++++++++++++++++++++++
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/hid/progs/hid.c b/tools/testing/selftests/hid/progs/hid.c
index 88c593f753b5..1e558826b809 100644
--- a/tools/testing/selftests/hid/progs/hid.c
+++ b/tools/testing/selftests/hid/progs/hid.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Red hat */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
 #include "hid_bpf_helpers.h"
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index 4fff31dbe0e7..65e657ac1198 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -5,6 +5,83 @@
 #ifndef __HID_BPF_HELPERS_H
 #define __HID_BPF_HELPERS_H
 
+/* "undefine" structs and enums in vmlinux.h, because we "override" them below */
+#define hid_bpf_ctx hid_bpf_ctx___not_used
+#define hid_report_type hid_report_type___not_used
+#define hid_class_request hid_class_request___not_used
+#define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
+#define HID_INPUT_REPORT         HID_INPUT_REPORT___not_used
+#define HID_OUTPUT_REPORT        HID_OUTPUT_REPORT___not_used
+#define HID_FEATURE_REPORT       HID_FEATURE_REPORT___not_used
+#define HID_REPORT_TYPES         HID_REPORT_TYPES___not_used
+#define HID_REQ_GET_REPORT       HID_REQ_GET_REPORT___not_used
+#define HID_REQ_GET_IDLE         HID_REQ_GET_IDLE___not_used
+#define HID_REQ_GET_PROTOCOL     HID_REQ_GET_PROTOCOL___not_used
+#define HID_REQ_SET_REPORT       HID_REQ_SET_REPORT___not_used
+#define HID_REQ_SET_IDLE         HID_REQ_SET_IDLE___not_used
+#define HID_REQ_SET_PROTOCOL     HID_REQ_SET_PROTOCOL___not_used
+#define HID_BPF_FLAG_NONE        HID_BPF_FLAG_NONE___not_used
+#define HID_BPF_FLAG_INSERT_HEAD HID_BPF_FLAG_INSERT_HEAD___not_used
+#define HID_BPF_FLAG_MAX         HID_BPF_FLAG_MAX___not_used
+
+#include "vmlinux.h"
+
+#undef hid_bpf_ctx
+#undef hid_report_type
+#undef hid_class_request
+#undef hid_bpf_attach_flags
+#undef HID_INPUT_REPORT
+#undef HID_OUTPUT_REPORT
+#undef HID_FEATURE_REPORT
+#undef HID_REPORT_TYPES
+#undef HID_REQ_GET_REPORT
+#undef HID_REQ_GET_IDLE
+#undef HID_REQ_GET_PROTOCOL
+#undef HID_REQ_SET_REPORT
+#undef HID_REQ_SET_IDLE
+#undef HID_REQ_SET_PROTOCOL
+#undef HID_BPF_FLAG_NONE
+#undef HID_BPF_FLAG_INSERT_HEAD
+#undef HID_BPF_FLAG_MAX
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <linux/const.h>
+
+enum hid_report_type {
+	HID_INPUT_REPORT		= 0,
+	HID_OUTPUT_REPORT		= 1,
+	HID_FEATURE_REPORT		= 2,
+
+	HID_REPORT_TYPES,
+};
+
+struct hid_bpf_ctx {
+	__u32 index;
+	const struct hid_device *hid;
+	__u32 allocated_size;
+	enum hid_report_type report_type;
+	union {
+		__s32 retval;
+		__s32 size;
+	};
+} __attribute__((preserve_access_index));
+
+enum hid_class_request {
+	HID_REQ_GET_REPORT		= 0x01,
+	HID_REQ_GET_IDLE		= 0x02,
+	HID_REQ_GET_PROTOCOL		= 0x03,
+	HID_REQ_SET_REPORT		= 0x09,
+	HID_REQ_SET_IDLE		= 0x0A,
+	HID_REQ_SET_PROTOCOL		= 0x0B,
+};
+
+enum hid_bpf_attach_flags {
+	HID_BPF_FLAG_NONE = 0,
+	HID_BPF_FLAG_INSERT_HEAD = _BITUL(0),
+	HID_BPF_FLAG_MAX,
+};
+
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,

-- 
2.39.1

