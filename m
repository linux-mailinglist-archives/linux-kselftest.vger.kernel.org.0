Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530EE63F7EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 20:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLATK4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 14:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiLATKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 14:10:48 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8878C5E04;
        Thu,  1 Dec 2022 11:10:47 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fz10so2121966qtb.3;
        Thu, 01 Dec 2022 11:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lBn7HA8s73zkhGBNG3m4Sb/6k6XYlgLSYhUWX2vb1I=;
        b=R1N6Q+6EHAvFNQV7/6IZX3Aixg6UnmIt/9PjjzdEbOApqMebnO6IX1H7Mb50Gm02gz
         VXdj+LWNboN0dcXgELaAg69k6+dZ4o68EkPz+PyNYIIo2VN1SQo89z8JZtKnvL9057it
         leOaMYglJnV+FUMHAgoarShMntNo1M1DLtf34CvYeOjRmsXWyjkoZFYOM570hcHsHqGJ
         xpMlzjuNgXuC0ILwBMhTPAsg9vA6a7InK0DJmlHmuCPCY8GgUKwob5zyBYaJHdTKBEF1
         6N9919eAfx3ZqrhGhRfecNzr7v13/YbmRVEyYbhbdqqSc1SX6k+JorAXSrFE3d5DDvMd
         3EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lBn7HA8s73zkhGBNG3m4Sb/6k6XYlgLSYhUWX2vb1I=;
        b=okGilCwvprJ5/rkBpGExkY+Sgm3fvsF/dnwKYWsa2hMFbeGmrx/Km/mn/cWXTUgK3m
         +FVAVs6Boz5rJnVccVaY0TBe2mA5VBP6CHAXSGjNXhcwBIsP2peuk+y9iRCGHKp0IArg
         SMPi6nupN0JYt6RaZhITGhgD4633GIp4danywS54rR5Bvpw0TsDmVB8PRIBwfSLYL6og
         SkmZZxqFMoMZctPiOBjEy8uF5AxO50PSgH/GCznmfYPMU/UZlOGmtwa+6y2YN+yU2gpM
         mp9AcerXncv3t3wrpGVhvZJLHb2hmigjJPgyaO4vxWOZC0OqCnsNwlbdhLNjGTs3YOBF
         UGiA==
X-Gm-Message-State: ANoB5plw8vh+h/cprNjwE3GiE+Nlxa1quiu8wGE3hzqa3lT17j2YnxvF
        QWEDB6VYu78264gPyq4nUeb1mPxrXYm+mn1R
X-Google-Smtp-Source: AA0mqf4KtmNIsiq/zeXOvH+tkCJJ6Gmy0Ia5DiailXwqblPE+ac8gkWv7sEJwtKzv1A5t2Ns4XyLOQ==
X-Received: by 2002:a37:be45:0:b0:6fb:f7a0:987d with SMTP id o66-20020a37be45000000b006fbf7a0987dmr48096466qkf.191.1669921846406;
        Thu, 01 Dec 2022 11:10:46 -0800 (PST)
Received: from james-x399.localdomain (71-33-132-231.hlrn.qwest.net. [71.33.132.231])
        by smtp.gmail.com with ESMTPSA id bs17-20020a05620a471100b006bbc3724affsm4006972qkb.45.2022.12.01.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:10:45 -0800 (PST)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] selftests/bpf: add GCC compatible builtins to bpf_legacy.h
Date:   Thu,  1 Dec 2022 12:09:39 -0700
Message-Id: <20221201190939.3230513-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The bpf_legacy.h header uses llvm specific load functions, add
GCC compatible variants as well to fix tests using these functions
under GCC.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: David Faust <david.faust@oracle.com>
---
 tools/testing/selftests/bpf/bpf_legacy.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_legacy.h b/tools/testing/selftests/bpf/bpf_legacy.h
index 845209581440..256c2a90aa20 100644
--- a/tools/testing/selftests/bpf/bpf_legacy.h
+++ b/tools/testing/selftests/bpf/bpf_legacy.h
@@ -2,6 +2,15 @@
 #ifndef __BPF_LEGACY__
 #define __BPF_LEGACY__
 
+#if __GNUC__ && !__clang__
+/* Functions to emit BPF_LD_ABS and BPF_LD_IND instructions.  We
+ * provide the "standard" names as synonyms of the corresponding GCC
+ * builtins.  Note how the SKB argument is ignored.
+ */
+#define load_byte(skb,off) __builtin_bpf_load_byte((off))
+#define load_half(skb,off) __builtin_bpf_load_half((off))
+#define load_word(skb,off) __builtin_bpf_load_word((off))
+#else
 /* llvm builtin functions that eBPF C program may use to
  * emit BPF_LD_ABS and BPF_LD_IND instructions
  */
@@ -11,6 +20,7 @@ unsigned long long load_half(void *skb,
 			     unsigned long long off) asm("llvm.bpf.load.half");
 unsigned long long load_word(void *skb,
 			     unsigned long long off) asm("llvm.bpf.load.word");
+#endif
 
 #endif
 
-- 
2.34.1

