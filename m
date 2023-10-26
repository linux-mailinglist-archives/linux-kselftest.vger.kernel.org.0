Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8217D85BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbjJZPOH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbjJZPOA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 11:14:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8371B9;
        Thu, 26 Oct 2023 08:13:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so14539901fa.0;
        Thu, 26 Oct 2023 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698333236; x=1698938036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHuPB109KsQAxIHXMrlfX3Zfn2UV329R/EJ5GBjTAOI=;
        b=Cy8hC7+TALUUT3KXxaYSplrrcAgNiwrFMu/TiwtDYuH2M2Flw2ekcvg0/64V5CMYB9
         3SRLi5yePPJ1GuySwiEtTPVnESdcMFVg78gXUjCkY+0ZwjsmRWvW2YtbVNa7qxG7dOBV
         BE9qDGHkReBgzpoa3W2LhySZgA9SfzOKXhuPrqEfBU8+fJh3GAWvmvV8Bzwo0d7DKjpZ
         QP/DystILj2licmM0GZXsLEoTQlMjdB831DmvQQd+aKbvLkMmpTNU/sIL5zs2geyDEuV
         hC9z08wt4v1uopi2oPFUL6RDSqNKl0sDJD4j99JzBjyQD8BmHVosPlRnl2sJd7OsC1OK
         zVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698333236; x=1698938036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHuPB109KsQAxIHXMrlfX3Zfn2UV329R/EJ5GBjTAOI=;
        b=f8ZD9Sip1ibjoefOv67E11b/wy5yK8BAXUww4PFXSvdKKGH53UdZtaIcQhCPoFyAXM
         wtBJobqT1HKjkLtZ23i4OkcTMKs3ZL+ClB23L9hvs7RCUBG1CuyK4o14m7l8yyjMg0Or
         sFtCZFrmIJ9ZT79WzJ1i3iXCE0U8VXkY06pNf/qH9M6b8Pl8j5/hlibBLTnHPE15ayDm
         CXYEBOOos9aTLyJTikehQvGB7JxqRQlZRpnOQXos/BeNapH6qCPy1IkGa+Lq6N1DsPKU
         0sVblIY8DpRSA9oEFeVzYmZFOxRjw3wFo7HhH3/W8n62oZkgImORpOvMthRLTPTcjgsG
         u8jA==
X-Gm-Message-State: AOJu0YzsQEmrvjs6FAUVP1QITNQksIRx+K3jiGpq1nkAp961+m5JV3K5
        hmOO+70MDESk9+MtNc8z3g==
X-Google-Smtp-Source: AGHT+IH4Mh22AEQcJ5JDt2JT5H+m//0MlhILIuAKfIAb/KoajFDvbcVaxKB8RtSKm4w1ouyByEk7XQ==
X-Received: by 2002:a2e:a272:0:b0:2c5:1fae:e61f with SMTP id k18-20020a2ea272000000b002c51faee61fmr12511734ljm.6.1698333235292;
        Thu, 26 Oct 2023 08:13:55 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b0040472ad9a3dsm2843778wmo.14.2023.10.26.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:13:54 -0700 (PDT)
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 26 Oct 2023 17:13:11 +0200
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for immediate spilled
 to stack
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-fix-check-stack-write-v1-2-6b325ef3ce7e@gmail.com>
References: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
In-Reply-To: <20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com>
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
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698333232; l=1562;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=RsQQJC1kz5RaWMBIQa3UXHDscXwUBIZwC2LrZY94Ug8=;
 b=Cvvesh2nQ17Rb2nhCZUvaYo8gXO2laztddD1Yrx8dDI21vELJmTTZ/eHfDCttK8NBuKFv4+KE
 /Djj1ND8DX+BgA1wlIutZAHkaCQph8CDzrivel2ApK+E+UNAetg1exX
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

