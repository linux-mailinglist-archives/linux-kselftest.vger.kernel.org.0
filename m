Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CF1794316
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjIFSd4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 14:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbjIFSdv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 14:33:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794A9172C;
        Wed,  6 Sep 2023 11:33:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so156768f8f.2;
        Wed, 06 Sep 2023 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694025205; x=1694630005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtDAfb39ZYubUMCOEk1qZOBpZCAofwQ4xmthOS0X+3o=;
        b=aT/CweoZ6rmWSwATUjyDMl/gOX2I6aB9yOyNCR1spO9PyJBymo6qJjxXY1ljnacKih
         ZToWxIceAUGcKt2I4PScrGfM+dN5kcE/sUJz3Z0UGprrliaFX5UCVwIjLfTz7W4/EAhe
         /3BqGhqKKIE+t3hwmfQqWfMuoOo1xqkORvo+iEiHEkfioTtwFaNPmLZsYA/j7DLfNA1U
         pxkv5vjtOuztbPeJXIcJYx9905p6vC+uWkZhU+p/b1VyeyLxIAvzu5VhzKzPGWn15NSY
         cMaKotxCnCGE37nmeyU0ddpeCopxo+XIG4TT30MPV1qVHo4S9aCfioUqKbeL96pQdKx3
         Hpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025205; x=1694630005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtDAfb39ZYubUMCOEk1qZOBpZCAofwQ4xmthOS0X+3o=;
        b=OTFq3cnRIk7oBmYUvtCTAOxSO6DUtr/73wmA2C5maKj4dnBvnNO/5HArUul9Q42+sx
         g/Kuolc/Xk74maiCuMkToWmt2KRM9jfVZzh61jIEbgbAAoDEVUNfS0PQGxmJewDFJD31
         e+6jNQmYnB+an9BK5ifFUVAEWx6Zfh3Zo7aWb+3UCRytS9FzcgXJ4jXtSowt/97n43Kp
         f5c62O1jegu76ItFx+CzqrGwWIeGktWJamvd3QILHwg527f3FY4CRTbBBaeILr52soDP
         eTE+brY2DHiL3JjKe8ltHxlxLNAE819O1WuujhIPiQrfDUd1mapWuXisHa3ebU0J2+vu
         9pFA==
X-Gm-Message-State: AOJu0YzSBQXGcKKaOlrWU5TSpbjFBB2BplRw1vhirJ9XpvgiWTY9D3PV
        sdim2oa2RyjDa5V8IduZRFM=
X-Google-Smtp-Source: AGHT+IEz+QlAVOBpdX9sT0us/nqZrZxdKYyxIUBbGgJapKwG6O9eU5K+6bwfnP0GpW0fTAgNhALN4w==
X-Received: by 2002:adf:efc2:0:b0:317:3b13:94c3 with SMTP id i2-20020adfefc2000000b003173b1394c3mr3037733wrp.41.1694025204750;
        Wed, 06 Sep 2023 11:33:24 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm21094891wrt.67.2023.09.06.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:33:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 4/8] arm32, bpf: add support for unconditional bswap instruction
Date:   Wed,  6 Sep 2023 18:33:16 +0000
Message-Id: <20230906183320.1959008-5-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906183320.1959008-1-puranjay12@gmail.com>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
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
use the same for unconditional bswap. just treat the unconditional scenario
the same as big-endian conversion.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 56ea8022e989..f837db5c71b1 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1633,8 +1633,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
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

