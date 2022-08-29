Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D915A508C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiH2PsG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiH2Pr6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:47:58 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3997539;
        Mon, 29 Aug 2022 08:47:42 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q81so6880629iod.9;
        Mon, 29 Aug 2022 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=F8MIYXd/Xz7kSxyNJ7px1zHhNcsXalbvXrm8i70TLIA=;
        b=MkC5UdWU6+Imh87+mJ22IPOYrjSDsKYj/4VTRMkEYgobRDMqGcUTHShvbFDDhzGCfI
         hpEMw+y8vqipvOg/wJovZPsZG4SsWXV1vZ6MbVJyhmEGIvj90u6lj00dcPgD/FIEr6Cw
         8f/Zjm2hz5bMd5oWcReckBHYB5sNYrAQaC89N2DEqP8CJPCHkVQcOTiDQifnFV5wV5d+
         epLlyF8v3F6Ih0aOOFpW7B4sYL5E+bgt+EZKZH/abLc7eaPsnUMZlTYe2u44rHyb7BvX
         grt6lZvl574TTY2+i/FHE03X4OEF7srQy3bLB3jQHoNkiYPSqsuvBfSgRKHN9mC/9VYG
         ij0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=F8MIYXd/Xz7kSxyNJ7px1zHhNcsXalbvXrm8i70TLIA=;
        b=puJ6IsDpqy/1mLrjxN69iI2mWtEomQ4cUA9GRxUUIZt5i1uxifdL903jefrOtHcC9+
         5whIO5O68LPTZ7FMhNuDt+WlL9tdG6wXzI2CIemIE65Rh97xseIvuGAGiSepEZMKqHrq
         0VX17t/G/cgE5+jDMmqdF/a2zT9flrUMriqLylCST5DfPwwTcn/qQPG5K3fxT/D2RDr/
         J/9TF11qffvw5iBH3Ss+qAI2LIQutGADfsMW/Y60YsC5UaI5OHW9c8n/Fag8FAipll4j
         rwj1HDdw/HhgjANlRlFmc0qEnRxX/Ybh84OXclZuB+Gq3ipZ2FtFmGhNdp89SEtNbS3z
         TXAg==
X-Gm-Message-State: ACgBeo0+dLUVM7tGp3fNlOxnfDn1bsnXeDeBatws14l9NkEMEf6w7l7S
        6ZmMVclKfj3qqnh9nVb8+LS3tOzk4E+ZwA==
X-Google-Smtp-Source: AA6agR7gk30EK0FrDgzRs3klB18ZOu2JkuAeAChQM6pSN6AXzyQX/5WN+1EMghi/8BQ9UMFKU0OGFg==
X-Received: by 2002:a6b:2ac4:0:b0:688:3a14:2002 with SMTP id q187-20020a6b2ac4000000b006883a142002mr8837385ioq.62.1661788060553;
        Mon, 29 Aug 2022 08:47:40 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id f33-20020a05663832a100b0034294118e1bsm4452576jav.126.2022.08.29.08.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:47:39 -0700 (PDT)
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
        Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/bpf: Fix connect4_prog tcp/socket header type conflict
Date:   Mon, 29 Aug 2022 09:47:09 -0600
Message-Id: <20220829154710.3870139-1-james.hilliard1@gmail.com>
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
netinet/tcp.h and sys/socket.h, we can replace both of these includes
with linux/tcp.h and bpf_tcp_helpers.h to avoid this conflict.

Fixes the following error:
In file included from /usr/include/netinet/tcp.h:91,
                 from progs/connect4_prog.c:11:
/home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
   34 | typedef __INT8_TYPE__ int8_t;
      |                       ^~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
                 from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
                 from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
                 from progs/connect4_prog.c:10:
/usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
   24 | typedef __int8_t int8_t;
      |                  ^~~~~~
/home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
   43 | typedef __INT64_TYPE__ int64_t;
      |                        ^~~~~~~
/usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
   27 | typedef __int64_t int64_t;
      |                   ^~~~~~~

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - use bpf_tcp_helpers.h so we can use SOL_TCP
---
 tools/testing/selftests/bpf/progs/connect4_prog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index b241932911db..23d85f5027d3 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -7,13 +7,13 @@
 #include <linux/bpf.h>
 #include <linux/in.h>
 #include <linux/in6.h>
-#include <sys/socket.h>
-#include <netinet/tcp.h>
+#include <linux/tcp.h>
 #include <linux/if.h>
 #include <errno.h>
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include "bpf_tcp_helpers.h"
 
 #define SRC_REWRITE_IP4		0x7f000004U
 #define DST_REWRITE_IP4		0x7f000001U
-- 
2.34.1

