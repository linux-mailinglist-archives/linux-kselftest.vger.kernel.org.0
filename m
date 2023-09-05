Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB55279309D
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjIEVGc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjIEVGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:06:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214C3113;
        Tue,  5 Sep 2023 14:06:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so29679235e9.3;
        Tue, 05 Sep 2023 14:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947983; x=1694552783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V5hh3IDqle2NIe8ow8Gyr5GKd/nqaX7VxxzXo2o22I=;
        b=kUo+eOGN3KNIcOkI/jVAIr4UzPdKgu3iLJmz8hUoy9cGyISCUHquj6WeLosf1JMM2H
         HsEkBnjVs6OLCIFpOT4ux6Svd7L9nN3SfmXACbb79k1mm7Iwx1X+IpUq/5lm/hsqRjX+
         ZaOfj0a3weG5M3sV/QgkQz4j6npKi7eko0EfCXoKZX6xDTOXvbB0ClXH8oPlC/dgAPq/
         W9EyOkJjwFC8Ap/J7mnsAJymbM/R5DYTNNI0qrK4YDW79PHeZfoakchqSy1/8O1pzBnk
         BIDhyVPD15nypTEEI9IaihikLQy+Hp/M/RhPC1zkw5Kno0Cfs94Ykpcyk0cCmb0qjbeM
         gdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947983; x=1694552783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V5hh3IDqle2NIe8ow8Gyr5GKd/nqaX7VxxzXo2o22I=;
        b=eRv52OePkH5LwbmlD+8m3YNev2OjnROiOM9cisZzs6nl7ZjJ1ZxVO2FVLFSPGwCqJM
         NM1Uj2sOLuCAruZYVcLJ4eHTfp0esERbxwa6rL2lMo/rN6PU9CU9YdQjKKEuKZrJImlB
         gUIEBSQJyHvw1Kwq6+GT8PMYGfuCX46QSdRBaNIW21hN4mbHCljDgHzHWKhApCCUvuNk
         x2fIgYp7SA8KawaF2Jo6kQt4jBhy+/EIlxenRrReAnog12V7P6Py2ExfQ7Kx08IexMRs
         mOIFSc9yjipkA+/H+mYHW5Qq/dYOQr4Eb/tkOyV83ea34CPs4ZXL3WDQxcTZ/TA9JO68
         CjfQ==
X-Gm-Message-State: AOJu0YzbD4HJ/CSCNeSCmf5DZzObr+RqcmMKhQQNGwscPNHDqrow6SUm
        fMZk0dPMRQuckGGzNZkQpuQ=
X-Google-Smtp-Source: AGHT+IFsyitguLWJZO0DaUu9peItyEXtjVqXfTt9cClTQTQLY74x7HHyua3qBZGRWhzdoXoPBISJlw==
X-Received: by 2002:a5d:4fd1:0:b0:317:6c16:a8a8 with SMTP id h17-20020a5d4fd1000000b003176c16a8a8mr747056wrw.35.1693947983172;
        Tue, 05 Sep 2023 14:06:23 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00317b063590fsm18427672wrt.55.2023.09.05.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:06:22 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shubham Bansal <illusionist.neo@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: [PATCH bpf-next 1/8] arm32, bpf: add support for 32-bit offset jmp instruction
Date:   Tue,  5 Sep 2023 21:06:14 +0000
Message-Id: <20230905210621.1711859-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230905210621.1711859-1-puranjay12@gmail.com>
References: <20230905210621.1711859-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The cpuv4 adds unconditional jump with 32-bit offset where the immediate
field of the instruction is to be used to calculate the jump offset.

BPF_JA | BPF_K | BPF_JMP32 => gotol +imm => PC += imm.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6a1c9fca5260..b26579da770e 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1761,10 +1761,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* JMP OFF */
 	case BPF_JMP | BPF_JA:
+	case BPF_JMP32 | BPF_JA:
 	{
-		if (off == 0)
+		if (BPF_CLASS(code) == BPF_JMP32 && imm != 0)
+			jmp_offset = bpf2a32_offset(i + imm, i, ctx);
+		else if (BPF_CLASS(code) == BPF_JMP &&  off != 0)
+			jmp_offset = bpf2a32_offset(i + off, i, ctx);
+		else
 			break;
-		jmp_offset = bpf2a32_offset(i+off, i, ctx);
+
 		check_imm24(jmp_offset);
 		emit(ARM_B(jmp_offset), ctx);
 		break;
-- 
2.39.2

