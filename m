Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC265A1F89
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 05:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbiHZDwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Aug 2022 23:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiHZDwK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Aug 2022 23:52:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828107CAAE;
        Thu, 25 Aug 2022 20:52:09 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p187so301894iod.8;
        Thu, 25 Aug 2022 20:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KpNWz8FLPoRf8HXKT4NVUx/ROvWQMe9GuTyq4+JJvJQ=;
        b=M0DUklRP7+S/Lx4ycAjV8/BdqB1lYK94Vjbif9CCndLqXWMbhwHGGuMwywB7iH++d0
         0yVUqhaaIneCPvsLIxB94fwOaVcKvfvjevhpnZOSxwQmIr89280RxK/teiIVpV5S7Kb/
         cuo5xJlqtrWv+NtPaIBm5vHhqLw3p8dXsujNFqeIeNpw/kk8NLPcxX2UghDIYzCsKdkB
         ic4jasn7YTRFurqJoapCbw3X4u64CFwijUQXDbAItm/+MJXpDqLpQwlkfiKW2LhuBOrj
         NqMTP8GI4/SPDDIY3EbwlqAzmRL39lod/Koqk8MvgbPemLQPDMHKRNOAZy0iPPiqHyGJ
         Q8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KpNWz8FLPoRf8HXKT4NVUx/ROvWQMe9GuTyq4+JJvJQ=;
        b=agHQ2FbOmuQx2cnXg3aEEvsn+9FPUPgeU8SoxPVVW6KZJcGvSlfAe2gmaqbsA++PQD
         OTP5A/XFvEaDSx3gJpIrUVXpFM7losgDlDuaD1qCsgBYPAN6hxX9tt47ilA7WevPmM4k
         X31w7aCmX/eg1my5tddhrXOOoRayouYHqODa1xSFr8YyhyRWu4HrLkK2JVk6fLVXg/wI
         ujRFAbbxdOgEOjb+W2mRNLDeqUOrOx1gEYQUcP9bpE+i6i/Nu+lRYI+IJAf4W4urtHS0
         24n2y0qcKQWEOou33TvANFGjNhAJjn2ctQBcqQPQ/c16nudH+GLjrGulyaK6LCNdmUVC
         2RdA==
X-Gm-Message-State: ACgBeo1cW75tXWnixUNuv1y6U61oWXfNaEcUOzYVS62/dx3DyZ9uiMbb
        Ac4OZOZRJHkd/ZzKE+FDoc8ELNBz0Uc33Q==
X-Google-Smtp-Source: AA6agR6mCE2eHqs2vnpfln9WspFTBY5pF+AX97AeoVrB9ikh4WPNr4/767Jmd4wKsqp8v+NIl7kb1w==
X-Received: by 2002:a02:b80d:0:b0:349:c003:3838 with SMTP id o13-20020a02b80d000000b00349c0033838mr3165903jam.282.1661485928354;
        Thu, 25 Aug 2022 20:52:08 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id m12-20020a0566022e8c00b0067b75781af9sm525784iow.37.2022.08.25.20.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 20:52:07 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
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
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: declare subprog_noise as static in tailcall_bpf2bpf4
Date:   Thu, 25 Aug 2022 21:51:39 -0600
Message-Id: <20220826035141.737919-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Due to bpf_map_lookup_elem being declared static we need to also
declare subprog_noise as static.

Fixes the following error:
progs/tailcall_bpf2bpf4.c:26:9: error: 'bpf_map_lookup_elem' is static but used in inline function 'subprog_noise' which is not static [-Werror]
   26 |         bpf_map_lookup_elem(&nop_table, &key);
      |         ^~~~~~~~~~~~~~~~~~~

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
index b67e8022d500..a017d6b2f1dd 100644
--- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf4.c
@@ -19,7 +19,7 @@ struct {
 int count = 0;
 int noise = 0;
 
-__always_inline int subprog_noise(void)
+static __always_inline int subprog_noise(void)
 {
 	__u32 key = 0;
 
-- 
2.34.1

