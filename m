Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3F788237
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 10:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbjHYIhU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 04:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbjHYIgo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 04:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA831FF2;
        Fri, 25 Aug 2023 01:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BD6164175;
        Fri, 25 Aug 2023 08:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A501FC433CC;
        Fri, 25 Aug 2023 08:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692952602;
        bh=ZRxhja+kWh95QQ9Ag5tsl+R/z0NeWzN9jHlu0C7A4wA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ft+8pwJyuWHEfv4Jl7PdNA12K2RPuM6IDfiaadzHshHHqYz1dFU4H1rXpJMxZDIQx
         6WnBtnSNWpdPeCZwuVRLxMzU2o22MxJVx29n1xnV97mJXenykoSu1mtuwuyFOX0Z6k
         5YS+ESe4wewwrbSMD+rqyizPXG3H91b2a4QfelR44e+VaIyGd5ztW7AE5VdbcWOEKn
         +un/KtsRYlXpRMDqUyR0ublP6/5ITXfQMELxz+rCeO7gkLzYruy0SWtcyOsSCii6nc
         a4xZfHQIx/co4aJ0GeZbU02icMfWj9DOCZ8Dei3KvM1olfOAXzYAQfEf2adUhw7luK
         dT70CsaI6jSLA==
From:   Benjamin Tissoires <bentiss@kernel.org>
Date:   Fri, 25 Aug 2023 10:36:31 +0200
Subject: [PATCH 1/3] selftests/hid: ensure we can compile the tests on
 kernels pre-6.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230825-wip-selftests-v1-1-c862769020a8@kernel.org>
References: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
In-Reply-To: <20230825-wip-selftests-v1-0-c862769020a8@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692952596; l=2354;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ZRxhja+kWh95QQ9Ag5tsl+R/z0NeWzN9jHlu0C7A4wA=;
 b=iimzBHHTtnw9UqT5LTPnPjH2BmblUlmSaOVOnH9AokjeoHggqohBXHVXAhGNKTDsWMAp+ZDkr
 if9Qg/YhTcsBAMcZJyNG0YP8pdfdEPEJYwJ+j4k+6GM4wtitaQ6IbZJ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
BTF.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/progs/hid.c             |  3 ---
 tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

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
index 4fff31dbe0e7..749097f8f4d9 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -5,6 +5,26 @@
 #ifndef __HID_BPF_HELPERS_H
 #define __HID_BPF_HELPERS_H
 
+/* "undefine" structs in vmlinux.h, because we "override" them below */
+#define hid_bpf_ctx hid_bpf_ctx___not_used
+#include "vmlinux.h"
+#undef hid_bpf_ctx
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
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
+};
+
 /* following are kfuncs exported by HID for HID-BPF */
 extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
 			      unsigned int offset,

-- 
2.39.1

