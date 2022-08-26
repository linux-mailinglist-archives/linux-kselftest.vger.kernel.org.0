Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE75A2077
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 07:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbiHZFus (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 01:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244922AbiHZFur (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 01:50:47 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E608ADCDD;
        Thu, 25 Aug 2022 22:50:45 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11c59785966so843780fac.11;
        Thu, 25 Aug 2022 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=7Isa32vjxy67XTD9NcDv4PtKbRD7YWANWp5LplWp5g0=;
        b=VCz76a4BwVXS1QPdFhtwb0IDkZdia53KpfMTJnGNFikINOrIth/KrxtGCAWC+D0LXC
         6VisE6Ea18HpgaPmr/qeAPb1Aeqy+jWJZyHALf8jbOL5mHcMjei0iRIDIm9x7ZIlWoF8
         oQmURCAtj76kyr393HOg0COITMVmy7NNh/HwP8io3mp+KrhGc20LegcPdb5Ntn9EVnP5
         SRlsainoFY7TAzcw/bfiomWPD7CkMlxeW5vTPHC26+w5GsUGTDXPY9tRiY9mUKA5XOuA
         kv2ziFr3wZxhYNU2vLLlBxXTKcpw48fo1YWqHigGrgaQkd/6y4oV4YIpEvYAqeorapKq
         gyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=7Isa32vjxy67XTD9NcDv4PtKbRD7YWANWp5LplWp5g0=;
        b=4f2VvI1Y3TkjhuDr2vbdthlfxxgBKbMQxN+gbubLXGXJaD06B5P30lEMVQHpDc6VHA
         +hi7wwAOWV2ur2+tL2PD2aPNhyaBCCmsoHUDtLdjYMP9n70uNCqPP+3EQ4pv39t3DnS8
         +J20NpHQHE0/Ox+T4xZkqnq7aS3h8g453Eoi2a5hdny10t23uvILiY/G9V8Ljxk65BJV
         XXxUnR9mxFmPlXE/BYITW8hH6OMLCOmE/DiXLWPsfKpogK3QarGScRnM4XeWLcoAFSZt
         kb2Go2KSFun0+sEx9aQb/rfxnO3eeqwGuKq/k5zj6z53HuTlXRVDqhzVASIOuzMJCG0j
         5GoQ==
X-Gm-Message-State: ACgBeo3IFPHsky5vfH5RWPTcSBFftDYbGsRy534fmzUKst1x0zgd32Nf
        7P/cCPWbdFCdv1q/Tv07lMYHSn6mOgjQJg==
X-Google-Smtp-Source: AA6agR72CATl4WtPtwoUbhrD6jJBGYE2f62n+APBrUkg+W5te4elbSOgFe9TQnZjoYPjuGidVGjFEQ==
X-Received: by 2002:a05:6870:41d5:b0:11c:cbbf:50c7 with SMTP id z21-20020a05687041d500b0011ccbbf50c7mr1188376oac.77.1661493044138;
        Thu, 25 Aug 2022 22:50:44 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id bk9-20020a056830368900b006370b948974sm554544otb.32.2022.08.25.22.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 22:50:43 -0700 (PDT)
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
        Dave Marchevsky <davemarchevsky@fb.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix connect4_prog tcp/socket header type conflict
Date:   Thu, 25 Aug 2022 23:50:24 -0600
Message-Id: <20220826055025.1018491-1-james.hilliard1@gmail.com>
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
with linux/tcp.h to avoid this conflict.

We also need to replace SOL_TCP with equivalent IPPROTO_TCP.

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
 .../selftests/bpf/progs/connect4_prog.c       | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index b241932911db..0f68b8d756b3 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -7,8 +7,7 @@
 #include <linux/bpf.h>
 #include <linux/in.h>
 #include <linux/in6.h>
-#include <sys/socket.h>
-#include <netinet/tcp.h>
+#include <linux/tcp.h>
 #include <linux/if.h>
 #include <errno.h>
 
@@ -52,7 +51,7 @@ static __inline int verify_cc(struct bpf_sock_addr *ctx,
 	char buf[TCP_CA_NAME_MAX];
 	int i;
 
-	if (bpf_getsockopt(ctx, SOL_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
+	if (bpf_getsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, &buf, sizeof(buf)))
 		return 1;
 
 	for (i = 0; i < TCP_CA_NAME_MAX; i++) {
@@ -70,12 +69,12 @@ static __inline int set_cc(struct bpf_sock_addr *ctx)
 	char reno[TCP_CA_NAME_MAX] = "reno";
 	char cubic[TCP_CA_NAME_MAX] = "cubic";
 
-	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &reno, sizeof(reno)))
+	if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, &reno, sizeof(reno)))
 		return 1;
 	if (verify_cc(ctx, reno))
 		return 1;
 
-	if (bpf_setsockopt(ctx, SOL_TCP, TCP_CONGESTION, &cubic, sizeof(cubic)))
+	if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, &cubic, sizeof(cubic)))
 		return 1;
 	if (verify_cc(ctx, cubic))
 		return 1;
@@ -113,15 +112,15 @@ static __inline int set_keepalive(struct bpf_sock_addr *ctx)
 	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_KEEPALIVE, &one, sizeof(one)))
 		return 1;
 	if (ctx->type == SOCK_STREAM) {
-		if (bpf_setsockopt(ctx, SOL_TCP, TCP_KEEPIDLE, &one, sizeof(one)))
+		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_KEEPIDLE, &one, sizeof(one)))
 			return 1;
-		if (bpf_setsockopt(ctx, SOL_TCP, TCP_KEEPINTVL, &one, sizeof(one)))
+		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_KEEPINTVL, &one, sizeof(one)))
 			return 1;
-		if (bpf_setsockopt(ctx, SOL_TCP, TCP_KEEPCNT, &one, sizeof(one)))
+		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_KEEPCNT, &one, sizeof(one)))
 			return 1;
-		if (bpf_setsockopt(ctx, SOL_TCP, TCP_SYNCNT, &one, sizeof(one)))
+		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_SYNCNT, &one, sizeof(one)))
 			return 1;
-		if (bpf_setsockopt(ctx, SOL_TCP, TCP_USER_TIMEOUT, &one, sizeof(one)))
+		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_USER_TIMEOUT, &one, sizeof(one)))
 			return 1;
 	}
 	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_KEEPALIVE, &zero, sizeof(zero)))
@@ -135,7 +134,7 @@ static __inline int set_notsent_lowat(struct bpf_sock_addr *ctx)
 	int lowat = 65535;
 
 	if (ctx->type == SOCK_STREAM) {
-		if (bpf_setsockopt(ctx, SOL_TCP, TCP_NOTSENT_LOWAT, &lowat, sizeof(lowat)))
+		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_NOTSENT_LOWAT, &lowat, sizeof(lowat)))
 			return 1;
 	}
 
-- 
2.34.1

