Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64A15A204D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 07:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244825AbiHZF3l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 01:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHZF3k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 01:29:40 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506C0C6B48;
        Thu, 25 Aug 2022 22:29:39 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p187so410912iod.8;
        Thu, 25 Aug 2022 22:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2PerLivnrvSdd0mavWmvcz0/j4qWJVcdVBv1WjY02hk=;
        b=di13tgcxcbogmsCesPCpSkIslgXflLwdkH8bdOHbDu49CKwmqwBcgq+MrlQarPL61C
         I3HPaiv/h/lIGkbTdSF6Y8VOLfu59k/xEOthY7KQtobyfbgSZSjNAnlLSK6/MjfSnz1y
         T5fKgE6YWc7BzbYBLB5H1F3M7VW02lSa9ec3oKhb0xQnoVFmFdZ4U8ETVJeq0sxi9eYb
         QTYalyHprILao7vuUjKMfGOGa+pldtXEofVypEgq/vvpxCZsep2E6+s3WdrYQJkYY2CL
         XVva71J86E9R3ixETMhNUXPjgyg82joc9UhT8N180kCD/HDtlQBcnYbVFDga6D4DqaSe
         9aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2PerLivnrvSdd0mavWmvcz0/j4qWJVcdVBv1WjY02hk=;
        b=m9C6yxw0/9zfy5yWMs9RfIodx5TdN80vi6Bq8/ILuAM2ln5Lgc7/tLD+4G8+1xwZDf
         2J236cj8O9C0naUba9ftLO+PRSlSglZ+DjMuJWhTk9zKkBbVGZjrhXjRB4H+OXK9H0KV
         6OHlWRH8hoPBQxwhmakg9pdDkp3v8bTPQdzDQBglIjSLc3BhMUBb1DuyuMTtvQfsrkBE
         o2ip3qTMy/DqTbkYX89yPS7m0FBUtQGGGpX7NhZIU/8T0royrOezELd72Wi6dawD3vi4
         7ZawzGeAi5BTQOG+5uQvfVBwAh8VpR/Ddw3xHfEInpb9TIAPt3oNEw2gS72nNUndbVy/
         Iv6Q==
X-Gm-Message-State: ACgBeo3JHQDZiK8P9/zO7y9gtlnumhQ/fiTxGn/7G95gfrpuJUmo6KpT
        loAum/ailMk5qpWPwtW/szgffhhzIsVCcA==
X-Google-Smtp-Source: AA6agR7/T63jKAWweC+NDftK9Xi2vTp9mWCX/qAkydWSSqfwBa42n2R5WIZJWbLJK/Kq+s9VWc66mQ==
X-Received: by 2002:a05:6638:480a:b0:346:a98b:1764 with SMTP id cp10-20020a056638480a00b00346a98b1764mr3357224jab.108.1661491778100;
        Thu, 25 Aug 2022 22:29:38 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id s14-20020a92cb0e000000b002dd6c2cf81dsm666029ilo.36.2022.08.25.22.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 22:29:37 -0700 (PDT)
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
Subject: [PATCH v2] selftests/bpf: Fix bind{4,6} tcp/socket header type conflict
Date:   Thu, 25 Aug 2022 23:29:22 -0600
Message-Id: <20220826052925.980431-1-james.hilliard1@gmail.com>
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
netinet/tcp.h with sys/socket.h, we can remove these as they are not
actually needed.

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
Changes v1 -> v2:
  - just remove netinet/tcp.h and sys/socket.h
---
 tools/testing/selftests/bpf/progs/bind4_prog.c | 2 --
 tools/testing/selftests/bpf/progs/bind6_prog.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
index 474c6a62078a..a487f60b73ac 100644
--- a/tools/testing/selftests/bpf/progs/bind4_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
@@ -6,8 +6,6 @@
 #include <linux/bpf.h>
 #include <linux/in.h>
 #include <linux/in6.h>
-#include <sys/socket.h>
-#include <netinet/tcp.h>
 #include <linux/if.h>
 #include <errno.h>
 
diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
index c19cfa869f30..d62cd9e9cf0e 100644
--- a/tools/testing/selftests/bpf/progs/bind6_prog.c
+++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
@@ -6,8 +6,6 @@
 #include <linux/bpf.h>
 #include <linux/in.h>
 #include <linux/in6.h>
-#include <sys/socket.h>
-#include <netinet/tcp.h>
 #include <linux/if.h>
 #include <errno.h>
 
-- 
2.34.1

