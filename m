Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46CB797EF7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 01:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbjIGXGE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Sep 2023 19:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjIGXGC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Sep 2023 19:06:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25275CF3;
        Thu,  7 Sep 2023 16:05:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-402d499580dso16372315e9.1;
        Thu, 07 Sep 2023 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127956; x=1694732756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY2uLSAvMmV5EWTADN8Db/okXl+6rOvcGyfqMlwBg+g=;
        b=su0qAY/c8azwkBtZUaavjW4dOcBTQ3zb8Q1fwwuH/tTQWkeymi7rkLcd7SsI4+qhzs
         aJXQwlTCcHIGjKHi4fibEYcA6hgIjCZTQMXXBISxNuLvBJ5BK2bvDIFGKsbb9oZEO4Tm
         Owl7M8LojkLu/xuzRqpXNSYREHJbkPrYr1F9/n2NMEkO/pUGV3sxOgz+SLnP3mIG30PG
         CVkoZYQWzcVm+AuJBTah/XLmrx53VWRfXswvnTqpLJgDqqN5FTxAr4oy+cwRGRE9jafe
         H09F26k4JwX6XagYks7bhbqlx7aYxH4ZXjdV9ZfofuW3uInr8JM8xcOtIOHal317roGy
         6nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127956; x=1694732756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lY2uLSAvMmV5EWTADN8Db/okXl+6rOvcGyfqMlwBg+g=;
        b=Kia/VuYm68sVq9xUnvfWpaF2NEA5HxivXWB77nPksNNLhSc1e8qLptA/37DWLydgtV
         3Yg0CQ2Cy8mKtEczhQD9Wf/60xYQty8OnyF+oaLDBN33PKY4exymaRk4RvEZMBlEw0WV
         pjmHUz0aKTe/nreFZo2z6ybLnyTv+etv175L6xBo7ZUdV/4cqy3C3AqLav+k29pJee6B
         jbDas43aSXHpEHffbMEylIBOyy6wngwxloQplgQPa0oTXdsCY8yC/DfkabY0DaCbLr/q
         g/a9RSKR8e1jaSUmL79MnWRkYWn95JQKGIaC47jr4JUohZmr+9P6LMVkYrdnJwzk4O6C
         8+lA==
X-Gm-Message-State: AOJu0YyC1JUJXErtB3YnMkc7M1UL2rtoU7s5iU/ywczyDxbTIUoAEQ9n
        /0rnljJ9zdJZonxnip5HZqs=
X-Google-Smtp-Source: AGHT+IEemVA1z2ZwptRHLDzUvKvj8phhYPaWiQVMDpmx6/W7yUqpbCltoDKGgJsjWUgLW96RMGr7BQ==
X-Received: by 2002:adf:fecd:0:b0:31a:dbd8:95d4 with SMTP id q13-20020adffecd000000b0031adbd895d4mr537381wrs.12.1694127956541;
        Thu, 07 Sep 2023 16:05:56 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-3-249-32-32.eu-west-1.compute.amazonaws.com. [3.249.32.32])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d484d000000b0031f3b04e7cdsm491358wrs.109.2023.09.07.16.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 16:05:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/9] arm32, bpf: add support for unconditional bswap instruction
Date:   Thu,  7 Sep 2023 23:05:45 +0000
Message-Id: <20230907230550.1417590-5-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907230550.1417590-1-puranjay12@gmail.com>
References: <20230907230550.1417590-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/net/bpf_jit_32.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 29a1ccf761fd..a08eba850ddf 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1635,10 +1635,12 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* dst = htole(dst) */
 	/* dst = htobe(dst) */
-	case BPF_ALU | BPF_END | BPF_FROM_LE:
-	case BPF_ALU | BPF_END | BPF_FROM_BE:
+	case BPF_ALU | BPF_END | BPF_FROM_LE: /* also BPF_TO_LE */
+	case BPF_ALU | BPF_END | BPF_FROM_BE: /* also BPF_TO_BE */
+	/* dst = bswap(dst) */
+	case BPF_ALU64 | BPF_END | BPF_FROM_LE: /* also BPF_TO_LE */
 		rd = arm_bpf_get_reg64(dst, tmp, ctx);
-		if (BPF_SRC(code) == BPF_FROM_LE)
+		if (BPF_SRC(code) == BPF_FROM_LE && BPF_CLASS(code) != BPF_ALU64)
 			goto emit_bswap_uxt;
 		switch (imm) {
 		case 16:
-- 
2.39.2

