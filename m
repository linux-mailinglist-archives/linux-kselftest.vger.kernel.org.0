Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9394174D6F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 15:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjGJNHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 09:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGJNHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 09:07:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200681FE0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 06:06:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso65926101fa.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jul 2023 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688994310; x=1691586310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuCQJnbemlgFFPZWsFNXaAIe6zz+6UmyaU+BFnlr21U=;
        b=VaDMWo/DY3QxQMwYzEnritcrz0veQlEHLTHyVkvopbeWdMui4cbsiCNnQvIPiIY3hP
         Z/mbbhDjDFR7B0/gH2LCsjuHQnqIxPTBEcMPcpOkK2PLGmBAignnwZontk5F/VnjSQ01
         E/rkhubmmmEQyqfyg9gK48abIbrVISNPYhR7GI3kg5QPL/0SPmAs2uHavOqA2XPV5pi7
         LOGah95Gw+C76Ratj1CD/szLsc+LleWRXvQpACYYpa4ZfR7qzO261saerrtoI5We9Iu+
         viYDnFKZGJOD6XI2HeKeysoTkYGhnYFOdotVuIP2DcH0CS/bCx3x3PzgWiPJtiFOnwl6
         BI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688994310; x=1691586310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuCQJnbemlgFFPZWsFNXaAIe6zz+6UmyaU+BFnlr21U=;
        b=NVhurHuwZVrE0uftYaVE1+LJKWkEvuoMF3g8ey4gRNvWFk9p/Gcf6UelAmQZTeaPml
         hWWD0gCsZF2DkusTbpmnB71OeGqaUq0P7zNOEXxVBOP3HRLji6XLo47xjDbIUI/9gn59
         NatTBBUXbyDoeqtwHaFnjDkg8PiR9lPl0BItRNf1JqdhPb2tYKUCYWtbDrtAxlwXhth7
         1TbqYBUtUCVA1pTjldViMCr7iFlR6uq5b3G5RB9RmELuI/ZHKN0QZnjGb8t3q6LSWV2W
         JR68dt2388GVA57o+t+Z02N0pJgpPCg0cNRbnrUGO52n0GmQ9rAsDsWhNWmxEIsWU8s2
         S+sQ==
X-Gm-Message-State: ABy/qLabyfkRD3YM0NQ8OYwWq+ffPDtaGf9IXgqmwlFy9KFpWIluOIT+
        /CQV03vF0T8JDYYjJ4L2iqs=
X-Google-Smtp-Source: APBJJlF7a5vl4MaVsFv0mXytCXE/ZB2j506raAw2PtlG/xixDbkLsgXvaP4GQsxJy/xw5zJFsI8OMQ==
X-Received: by 2002:a2e:9b8f:0:b0:2b6:d57f:d81 with SMTP id z15-20020a2e9b8f000000b002b6d57f0d81mr9434546lji.53.1688994309427;
        Mon, 10 Jul 2023 06:05:09 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:535c:656e:34e4:18d9:8e8c])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fbca942499sm10224631wmj.14.2023.07.10.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:05:08 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH v0] selftests/bpf: replace manual array size calc with ARRAYSIZE.
Date:   Mon, 10 Jul 2023 17:04:48 +0400
Message-Id: <20230710130448.1558118-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

fixes coccinelle warnings due to manual calculation of array size.

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
---
 tools/testing/selftests/bpf/progs/syscall.c          | 6 +++++-
 tools/testing/selftests/bpf/progs/test_rdonly_maps.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index e550f728962d..9cc25d93c601 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -27,6 +27,10 @@ struct args {
 	BTF_TYPE_ENC(name, BTF_INFO_ENC(BTF_KIND_INT, 0, 0), sz), \
 	BTF_INT_ENC(encoding, bits_offset, bits)
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
+#endif
+
 static int btf_load(void)
 {
 	struct btf_blob {
@@ -82,7 +86,7 @@ int bpf_prog(struct args *ctx)
 	static __u64 value = 34;
 	static union bpf_attr prog_load_attr = {
 		.prog_type = BPF_PROG_TYPE_XDP,
-		.insn_cnt = sizeof(insns) / sizeof(insns[0]),
+		.insn_cnt = ARRAY_SIZE(insns),
 	};
 	int ret;
 
diff --git a/tools/testing/selftests/bpf/progs/test_rdonly_maps.c b/tools/testing/selftests/bpf/progs/test_rdonly_maps.c
index fc8e8a34a3db..7431936ab26c 100644
--- a/tools/testing/selftests/bpf/progs/test_rdonly_maps.c
+++ b/tools/testing/selftests/bpf/progs/test_rdonly_maps.c
@@ -21,6 +21,10 @@ struct {
 	unsigned sum;
 } res = {};
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
+#endif
+
 SEC("raw_tracepoint/sys_enter:skip_loop")
 int skip_loop(struct pt_regs *ctx)
 {
@@ -64,7 +68,7 @@ int full_loop(struct pt_regs *ctx)
 {
 	/* prevent compiler to optimize everything out */
 	unsigned * volatile p = (void *)&rdonly_values.a;
-	int i = sizeof(rdonly_values.a) / sizeof(rdonly_values.a[0]);
+	int i = ARRAY_SIZE(rdonly_values.a);
 	unsigned iters = 0, sum = 0;
 
 	/* validate verifier can allow full loop as well */
-- 
2.34.1

