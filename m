Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084267DDD4A
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 08:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjKAHeO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 03:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjKAHeL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 03:34:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1950EC2;
        Wed,  1 Nov 2023 00:34:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40806e4106dso3227515e9.1;
        Wed, 01 Nov 2023 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698824047; x=1699428847; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHuPB109KsQAxIHXMrlfX3Zfn2UV329R/EJ5GBjTAOI=;
        b=E8JPvk6fJHiqZWBVw0kxYop0PlUsEL+0LDnpTssztnyoYP7wFNfI6jDaboazB5aVrW
         yBd4EOQAiK2MajaVXqVw2B6HtC4FN+vGW5mNGGQ6prnGi9/1yVu+Xt4FMgzsiOqw2aYP
         OYj0W8rS5AjLRyzpXrjEd8+yAVFQkfB/oC292n+nJZIYG6uqw+te0bQSx5kLTRPuS++K
         JUxIEb8ubUfgbXbLu2EAQjd7q3Vn+WX07QS4gicGJKASXmnjRxWOFVtdnbQ6fgVspoKw
         aABYvrciqGgHwz6/DVJ5zgzRFzGlgh6BnAfIm21/d33GiQ15tI1JY00bXfls3SxbmSZ0
         rbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698824047; x=1699428847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHuPB109KsQAxIHXMrlfX3Zfn2UV329R/EJ5GBjTAOI=;
        b=YKQ2b7t31Tb1gP/eTyppwxClTKSp68GIk11+dFrXnAnBxuINoDYrndTs66ittSN+1l
         5uSd8ZRb/lReMOG1rKXEpWyjh63WklyGorLphpZHpoMVCmLrhITwfvRdEfgfegOF7oe1
         rhLSy//VwgHwNKxO7NmkSq9NJzBDQUlOtL6mLxeAh4FK2GBBYPGIVoopEFs7ygH6RGXN
         rdwybHGsKPlPV3bG2QRZbFw1LuCSu/i2jud5IUjCD+QKrg+/2t+oYqBjtb71lIwyOS1V
         u//kDQKu4WDzh8ZkIA2Ph+EwjW5/6v4OgKi/7KaC0ngYZLF+hu4tImdm6xRSD8TJYwCQ
         Th1Q==
X-Gm-Message-State: AOJu0Yy4kbGReFGreefQ5VCucaABJorPiMsg5sukgvulhHopHSlfCgin
        ZwaHqFP1pt+sbXbQwImuBg==
X-Google-Smtp-Source: AGHT+IEhxdHR/YLhVI5/c2P3kkhilenaQsxl9mV0OvTnc/apOPp4unZhJeY3tOBK5JHGieC0khQu3w==
X-Received: by 2002:a05:600c:3146:b0:408:36bb:5b0c with SMTP id h6-20020a05600c314600b0040836bb5b0cmr1999352wmo.7.1698824047195;
        Wed, 01 Nov 2023 00:34:07 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id i18-20020adff312000000b0032d893d8dc8sm3401810wro.2.2023.11.01.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 00:34:06 -0700 (PDT)
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 01 Nov 2023 08:33:23 +0100
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add test for immediate spilled
 to stack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-fix-check-stack-write-v2-2-cb7c17b869b0@gmail.com>
References: <20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com>
In-Reply-To: <20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698824042; l=1562;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=RsQQJC1kz5RaWMBIQa3UXHDscXwUBIZwC2LrZY94Ug8=;
 b=2D5CtDRRnmzsb7u21FbfWzwordfaO3zTME3qmQjlmraBAi9/A0FMHxGNxSA46wa/qzpYzel7r
 UmnA7cRuRo0ArLRb4cHvE6XOa70EBWAn2hWXkDvKy1bqnB/iQqna2wF
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test to check if the verifier correctly reason about the sign
of an immediate spilled to stack by BPF_ST instruction.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
index 3af2501082b2..0ba23807c46c 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_st_mem.c
@@ -65,3 +65,35 @@
 	.expected_attach_type = BPF_SK_LOOKUP,
 	.runs = -1,
 },
+{
+	"BPF_ST_MEM stack imm sign",
+	/* Check if verifier correctly reasons about sign of an
+	 * immediate spilled to stack by BPF_ST instruction.
+	 *
+	 *   fp[-8] = -44;
+	 *   r0 = fp[-8];
+	 *   if r0 s< 0 goto ret0;
+	 *   r0 = -1;
+	 *   exit;
+	 * ret0:
+	 *   r0 = 0;
+	 *   exit;
+	 */
+	.insns = {
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, -44),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8),
+	BPF_JMP_IMM(BPF_JSLT, BPF_REG_0, 0, 2),
+	BPF_MOV64_IMM(BPF_REG_0, -1),
+	BPF_EXIT_INSN(),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	/* Use prog type that requires return value in range [0, 1] */
+	.prog_type = BPF_PROG_TYPE_SK_LOOKUP,
+	.expected_attach_type = BPF_SK_LOOKUP,
+	.result = VERBOSE_ACCEPT,
+	.runs = -1,
+	.errstr = "0: (7a) *(u64 *)(r10 -8) = -44        ; R10=fp0 fp-8_w=-44\
+	2: (c5) if r0 s< 0x0 goto pc+2\
+	2: R0_w=-44",
+},

-- 
2.34.1

