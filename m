Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC5E5A1C15
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 00:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiHYWSC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Aug 2022 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHYWSC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Aug 2022 18:18:02 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F1956A6;
        Thu, 25 Aug 2022 15:18:01 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-11c9af8dd3eso26369575fac.10;
        Thu, 25 Aug 2022 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NplIUhMLfPOec8AZZdsvB3N3SHtQQbKwWNlCDqLOTGU=;
        b=SlPWJVV5zZdLa4gstqqlzR1+hBQ5WNclTHjetSzqvpgyYhB4c/jVIiIV09TVkn9kGY
         SnA/ZXIO6/XeruRDnmWdzwIZWifGm3jeNp93O0l41jq16dLNi9aXePfqcqqLmkePLkKd
         ViPButwdAaKmnlS5kgVHpf+HIaFaDBx3C5v57Bq8x3UrPnHwgTGemAKhlh/CY02ykg9x
         5jzBuKcZFQugaBNmwrXaRyx04xPy+nAye+fQnX5QFuWbtettZ8J9iP/uNpVmz90g91ld
         eKzVHiD8YHdABe7lSGoefMrTVdTch7T0FU3aHVXzSEjSbJdCaHo/q/wp9XhAlDPeRhmQ
         ym4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NplIUhMLfPOec8AZZdsvB3N3SHtQQbKwWNlCDqLOTGU=;
        b=wVq2T+P0ttLrfIj55UJcxU4gUoO9cKYHUDL+cLFBRWxI95q7reeKmXOLwk2rXOzBsZ
         ANawGw4dokJrpSLyzC9yF2fgYAxD2GsYKe1UvRmjVabLM10j4gCGWw0UOPIAdn3S9rOZ
         RGJRdiyMXLqUNmc/SMX1dTll72lbTfNm2v4Sd300yTIq353qhaxTV8ouGLRgLZk3/jis
         Mv4Aup/jbvrPjc4CKo1ZY1ywP52TFTRS7cMcvwl/gdzAmMNMVOvICqf4j0oxvdN6fv9N
         EoO/qo4Syw1fELBJG3aFSksEoe23EZciVuMfw4bv0KjU7QKy9IiI/QEFsIMquVA54dXu
         h8vA==
X-Gm-Message-State: ACgBeo0MWkFarm+vs8K25+UVc57t0Qnu47Lm2ktyh6PM6isyEutpAAxy
        8S1bFBKY2hsREgmbn6moRjJRMCcb0Ik=
X-Google-Smtp-Source: AA6agR5uQXYiGy90D0OFm5Nyz97HD/CT/9F+CFp4q0vUBJBAi105LAeM9Yetjtp1p1WWN1m6oH119w==
X-Received: by 2002:a05:6870:171c:b0:10e:40b9:8cd0 with SMTP id h28-20020a056870171c00b0010e40b98cd0mr553037oae.283.1661465879036;
        Thu, 25 Aug 2022 15:17:59 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id i19-20020a056871029300b0011c8c2c9020sm247722oae.33.2022.08.25.15.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 15:17:58 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix bind{4,6} tcp/socket header type conflict
Date:   Thu, 25 Aug 2022 16:17:49 -0600
Message-Id: <20220825221751.258958-1-james.hilliard1@gmail.com>
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

There is a potential for us to hit a type conflict when including
netinet/tcp.h with sys/socket.h, we can replace both of these includes
with linux/tcp.h to avoid this conflict.

Fixes errors like:
In file included from /usr/include/netinet/tcp.h:91,
                 from progs/bind4_prog.c:10:
/home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
   34 | typedef __INT8_TYPE__ int8_t;
      |                       ^~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
                 from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
                 from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
                 from progs/bind4_prog.c:9:
/usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
   24 | typedef __int8_t int8_t;
      |                  ^~~~~~
/home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
   43 | typedef __INT64_TYPE__ int64_t;
      |                        ^~~~~~~
/usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
   27 | typedef __int64_t int64_t;
      |                   ^~~~~~~
make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
 tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
index 474c6a62078a..6bd20042fd53 100644
--- a/tools/testing/selftests/bpf/progs/bind4_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
@@ -6,8 +6,7 @@
 #include <linux/bpf.h>
 #include <linux/in.h>
 #include <linux/in6.h>
-#include <sys/socket.h>
-#include <netinet/tcp.h>
+#include <linux/tcp.h>
 #include <linux/if.h>
 #include <errno.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
index c19cfa869f30..f37617b35a55 100644
--- a/tools/testing/selftests/bpf/progs/bind6_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
@@ -6,8 +6,7 @@
 #include <linux/bpf.h>
 #include <linux/in.h>
 #include <linux/in6.h>
-#include <sys/socket.h>
-#include <netinet/tcp.h>
+#include <linux/tcp.h>
 #include <linux/if.h>
 #include <errno.h>
 
-- 
2.34.1

