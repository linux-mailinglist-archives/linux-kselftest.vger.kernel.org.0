Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99CE6D1921
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCaH7K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 03:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjCaH7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 03:59:03 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C79DEB75;
        Fri, 31 Mar 2023 00:59:01 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h7so11138265ila.5;
        Fri, 31 Mar 2023 00:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680249540; x=1682841540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q5KGlHi5wnLx2SIZLoystkSne8tLI4F5rVbfhqJXGD4=;
        b=PRSnrgJgt1InfsExYjToiiyuB8zlta3OrV8Xnqg4qHLhj0TFtI0Wyuk4w92SB6sPUo
         7V5PAyFOYM9pOXL1aABslzPiA8aR6JA2Bz91IpxH8UhTjr5ldvtKiyFjcXwwB3gTfsHd
         dkmgCYgSJaI6N1IKTR3MTvSHNLteqfCmd5Lw38BxaqGpirV0JFPBbAcU/OWdJZVas31u
         hxqRXtFdJWZME2rqiu8tramRi9FNKR4JJtLYZ+vB1qxaZSCnYYpnfz/a5QdRXEkEAOFu
         qYFOXRAgoDNbsAyejZ598bWQVEnF4GfDDAXdzpUcpDhBPTzsbVWVWZ3T2QvheUUsXWOW
         CVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680249540; x=1682841540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5KGlHi5wnLx2SIZLoystkSne8tLI4F5rVbfhqJXGD4=;
        b=e5ZFWO3QetPX6ikwc6cDhGkRIiQMQH7MphKsxTJCV7RaSWcyc9N29PAm9djudkYUO3
         jmdTuqfWS2vfRRi22ajucYZdX1njf38BIija8Ch2JQphAwwrBbcz/9veW5mUnQU6QvwX
         dNoKCLcrjWGHiRSXW92TTf2XeGC4HCzj4w4tXvG6LoIUgGnmMVnA1NHPt8zsoimHKRrL
         0PYt9fSazD/fWLf6yl3TIxoaeiNbG16Hc11nwPViQQ5c9mkUJIT8Fr7vz5T9/1mdz5Eg
         xBWL86RG7BJ5nbEea7jektWYkLLlpqZgBUYJdScJ7Otj/mwFtwgQr8xSlMtDwp9BkaR0
         BiKQ==
X-Gm-Message-State: AAQBX9cheZVGydzh/IgPdurxDTpshzEUo+OqRP/gMpO6Gnj3194EHc+t
        DPetDHQ7e7B+t6GOUYwnDctKutoYjZ4EGDxk
X-Google-Smtp-Source: AKy350b81uKbmsgB8Rii3gKqpRAIaooWoURBrhmC3x+6idvr2wVrYBAHCk93aTRV5aDP28niNHIzDQ==
X-Received: by 2002:a92:c90a:0:b0:325:ea77:e882 with SMTP id t10-20020a92c90a000000b00325ea77e882mr16576938ilp.29.1680249540184;
        Fri, 31 Mar 2023 00:59:00 -0700 (PDT)
Received: from james-x399.localdomain (97-118-150-219.hlrn.qwest.net. [97.118.150.219])
        by smtp.gmail.com with ESMTPSA id o6-20020a92c046000000b0032628feb0bcsm470561ilf.11.2023.03.31.00.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:58:59 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
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
Subject: [PATCH bpf-next] selftests/bpf: Fix conflicts with built-in functions in bench_local_storage_create
Date:   Fri, 31 Mar 2023 01:58:42 -0600
Message-Id: <20230331075848.1642814-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The fork function in gcc is considered a built in function due to
being used by libgcov when building with gnu extensions.

Rename fork to sched_process_fork to prevent this conflict.

See details:
https://github.com/gcc-mirror/gcc/commit/d1c38823924506d389ca58d02926ace21bdf82fa
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82457

Fixes the following error:

In file included from progs/bench_local_storage_create.c:6:
progs/bench_local_storage_create.c:43:14: error: conflicting types for
built-in function 'fork'; expected 'int(void)'
[-Werror=builtin-declaration-mismatch]
   43 | int BPF_PROG(fork, struct task_struct *parent, struct
task_struct *child)
      |              ^~~~

Fixes: cbe9d93d58b1 ("selftests/bpf: Add bench for task storage creation")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
---
 tools/testing/selftests/bpf/benchs/bench_local_storage_create.c | 2 +-
 tools/testing/selftests/bpf/progs/bench_local_storage_create.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
index abb0321d4f34..cff703f90e95 100644
--- a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
@@ -95,7 +95,7 @@ static void setup(void)
 			exit(1);
 		}
 	} else {
-		if (!bpf_program__attach(skel->progs.fork)) {
+		if (!bpf_program__attach(skel->progs.sched_process_fork)) {
 			fprintf(stderr, "Error attaching bpf program\n");
 			exit(1);
 		}
diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
index 7c851c9d5e47..e4bfbba6c193 100644
--- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
+++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
@@ -40,7 +40,7 @@ int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
 }
 
 SEC("tp_btf/sched_process_fork")
-int BPF_PROG(fork, struct task_struct *parent, struct task_struct *child)
+int BPF_PROG(sched_process_fork, struct task_struct *parent, struct task_struct *child)
 {
 	struct storage *stg;
 
-- 
2.34.1

