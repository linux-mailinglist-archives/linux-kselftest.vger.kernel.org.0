Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E5F7930A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Sep 2023 23:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbjIEVGe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Sep 2023 17:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjIEVGc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Sep 2023 17:06:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D21A3;
        Tue,  5 Sep 2023 14:06:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso1745695e9.0;
        Tue, 05 Sep 2023 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693947986; x=1694552786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF0WYVlSafOxqmOGupU9a2NBQME+S3iohgU1u9q7GJ0=;
        b=gEB8HFdT2e85yHLnRvM4wSVTSs0Eq7rkPMqVB73iLjpp3hwEfwRfLmkzFZxD5XgQMg
         saDO37/XER9+wsB5r/dLneLwpheBk2Aw/X5yAWOS+V/7X8pLZG4tK4anO1xwi8iyB3qu
         ElzJkesmQGrIINwtIvqI5ukIvrDzI7yYkM3pqPwJvX/9OAskcdhZLEq3ycaArmrekGuc
         UzRfvjoN7fwf9xLxCq0CXRJgYBsiPgLgqCn7U96VEjfK5SoGrND0CzWqW0BdwQdPOonm
         5R2WajEkCyMpEvcTNNLZKwmElmDW0cZ4qpt3jxf9uAOykjdG4C9iaEaFL3ifPY6bhxxH
         E/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947986; x=1694552786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF0WYVlSafOxqmOGupU9a2NBQME+S3iohgU1u9q7GJ0=;
        b=RmNVfY5xmDmld6UxonYQRjIn06BHDfebJTWp5HzH3A7D7Ee8hgjF5+5H3sQdlC45VL
         jWFgZPK6TzszoOgt5cBO++ICu6LYDBLu5mQqaMdhJD5uFPUIlv0QBOoT+ebhXOqZV9/r
         66j4J76u/VdglqAx+4rwuaNXciQKI6M86lj+mzfiVoCL2P+nH4oItVEfJ7SklQ3YfIsl
         +urlIUxuhWNsuZzSTY5P+2eJBEVZXL6d56/HvlZv+YWeOwni14oSsKyWBMIYxBlDzRaf
         IsVpgXgXrDPLvZCCu/s+8pGFEC7ClI0h1gWCesCkuzL9BAat8baCOpsn6BviBarvrKlz
         crzw==
X-Gm-Message-State: AOJu0Yx8EgFPtIpnWw9LrUSwP6WmneywWUSHRCu5AVDxno/l42ootGMi
        0t1VsTk2EfstHOV6mDI913RzPar0w9hpkjkvmJ4=
X-Google-Smtp-Source: AGHT+IFUTHQlFvkWGVc9v1xqw4A7vix3qH9dN0XbE9FKfXXILk1VoVJvsXz7Fo8O+GqX2F6oWUXuLQ==
X-Received: by 2002:a05:600c:4215:b0:3ff:a95b:9751 with SMTP id x21-20020a05600c421500b003ffa95b9751mr876678wmh.7.1693947986233;
        Tue, 05 Sep 2023 14:06:26 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00317b063590fsm18427672wrt.55.2023.09.05.14.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:06:25 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/8] arm32, bpf: add support for unconditional bswap instruction
Date:   Tue,  5 Sep 2023 21:06:17 +0000
Message-Id: <20230905210621.1711859-5-puranjay12@gmail.com>
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

The cpuv4 added a new unconditional bswap instruction with following
behaviour:

BPF_ALU64 | BPF_TO_LE | BPF_END with imm = 16/32/64 means:
dst = bswap16(dst)
dst = bswap32(dst)
dst = bswap64(dst)

As we already support converting to big-endian from little-endian we can
use the same for unconditional bswap.
Since ARM32 is always little-endian, just treat the unconditional scenario
the same as big-endian conversion.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 0a30188de660..09496203f13e 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1632,8 +1632,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 	/* dst = htobe(dst) */
 	case BPF_ALU | BPF_END | BPF_FROM_LE:
 	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	/* dst = bswap(dst) */
+	case BPF_ALU64 | BPF_END | BPF_TO_LE:
 		rd = arm_bpf_get_reg64(dst, tmp, ctx);
-		if (BPF_SRC(code) == BPF_FROM_LE)
+		if (BPF_SRC(code) == BPF_FROM_LE && BPF_CLASS(code) != BPF_ALU64)
 			goto emit_bswap_uxt;
 		switch (imm) {
 		case 16:
-- 
2.39.2

