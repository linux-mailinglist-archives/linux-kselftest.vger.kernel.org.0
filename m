Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0796A72602D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 14:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjFGM7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239471AbjFGM7c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 08:59:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE6D198B;
        Wed,  7 Jun 2023 05:59:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-652d1d3e040so3718872b3a.1;
        Wed, 07 Jun 2023 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686142770; x=1688734770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kX591rv4P6ZbBVZ3ukpsLfIBxD/Dh2uh6P18Ms6o16I=;
        b=XkEpIbFcXJBhTj58idWUX6QhkY5KoPe4pvu7GggguOj2PcV3Y68JJJDD1vwvQZmIUl
         XecblEix3vwLpsDpuEIlDOivW0BGpzqK+RXXyzxK/fS/n15GS3K75paGpadYI3P0HEBS
         sfLiob7wtYSu3ZgM04LwL4UbOaWHHbvcAdwnUljhJu89SBXrB1Be/sqKsTJFgEn+H5pI
         gdO9LnB5vFmr6ZVKm+ourTuP6BXe76Ael/KA2xruZhEq5jMX7QAk3lhNzNt3X0b6GAS0
         l6H4rQwOn7hwrupDFupaNIf4nti0GXeaHTOwBXjB8sfkYOhtcnSXV1oTMCfJIDQm4ml5
         qGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142770; x=1688734770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kX591rv4P6ZbBVZ3ukpsLfIBxD/Dh2uh6P18Ms6o16I=;
        b=HL8z4nseuRuM0PgpYdAPIOE7c+92begvWJ2B1r60GSA5CxQr1n1xD1FMiKf0Sjfskk
         7AvlTEQT8R8ydN9fPWYQyRcht8FaKCtGtQ5xo48/7b8mBuiX3H0yj2ejc0LjCq3vNXUo
         c6E+CTxGo6IToO9NWjv/fHZRerAxvm5Dg2uHLY4YGtwSE+xPB4OusNdQ55Eyp6jAjC+q
         6Vfe6MNcIR+eHbKs340Q8qIIJC4SWfFTznTWgKvJ6zZoR8lltgxkuZ2zGiQeY/VBmhXm
         Np9IjU9NO3yqhl+6CxajIM1Es8C+KPiSgxSco+B/XE9EJ0YwKdhFeqNX89HpXu7diPW4
         ykJA==
X-Gm-Message-State: AC+VfDwQEwHiZ6nxZeqPN8p+xkEJaCovvz1+R502sTD/7dKG6dQoaA0B
        Uz21dqC3yTEPNN9/9dxYOMo=
X-Google-Smtp-Source: ACHHUZ46GPJvOMd7O/EXq0mUT4VGZZE0JjxehAWS6mNRVR/Q1Gv4NYNXzaIfWHfMHL8+sNEubssjMg==
X-Received: by 2002:a05:6a00:2e9b:b0:63d:2c2f:e3a2 with SMTP id fd27-20020a056a002e9b00b0063d2c2fe3a2mr4074294pfb.18.1686142770222;
        Wed, 07 Jun 2023 05:59:30 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.gmail.com with ESMTPSA id p1-20020a62ab01000000b0065434edd521sm7094982pff.196.2023.06.07.05.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:59:29 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     alexei.starovoitov@gmail.com
Cc:     davem@davemloft.net, dsahern@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, x86@kernel.org,
        imagedong@tencent.com, benbjiang@tencent.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 2/3] bpf, x86: clean garbage value in the stack of trampoline
Date:   Wed,  7 Jun 2023 20:59:10 +0800
Message-Id: <20230607125911.145345-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607125911.145345-1-imagedong@tencent.com>
References: <20230607125911.145345-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

There are garbage values in upper bytes when we store the arguments
into stack in save_regs() if the size of the argument less then 8.

As we already reserve 8 byte for the arguments in regs and stack,
it is ok to store/restore the regs in BPF_DW size. Then, the garbage
values in upper bytes will be cleaned.

Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 arch/x86/net/bpf_jit_comp.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 413b986b5afd..e9bc0b50656b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1878,20 +1878,16 @@ static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 
 		if (i <= 5) {
 			/* copy function arguments from regs into stack */
-			emit_stx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_FP,
+			emit_stx(prog, BPF_DW, BPF_REG_FP,
 				 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 				 -(stack_size - i * 8));
 		} else {
 			/* copy function arguments from origin stack frame
 			 * into current stack frame.
 			 */
-			emit_ldx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_0, BPF_REG_FP,
+			emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
 				 (i - 6) * 8 + 0x18);
-			emit_stx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_FP,
-				 BPF_REG_0,
+			emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 				 -(stack_size - i * 8));
 		}
 
@@ -1918,7 +1914,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 			next_same_struct = !next_same_struct;
 		}
 
-		emit_ldx(prog, bytes_to_bpf_size(arg_size),
+		emit_ldx(prog, BPF_DW,
 			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
 			 BPF_REG_FP,
 			 -(stack_size - i * 8));
@@ -1949,12 +1945,9 @@ static void prepare_origin_stack(const struct btf_func_model *m, u8 **prog,
 		}
 
 		if (i > 5) {
-			emit_ldx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_0, BPF_REG_FP,
+			emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
 				 (i - 6) * 8 + 0x18);
-			emit_stx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_FP,
-				 BPF_REG_0,
+			emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 				 -(stack_size - (i - 6) * 8));
 		}
 
-- 
2.40.1

