Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81C25A201F
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 07:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiHZFH2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 01:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiHZFH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 01:07:27 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CDEA2638;
        Thu, 25 Aug 2022 22:07:25 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11dca1c9c01so801674fac.2;
        Thu, 25 Aug 2022 22:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=w20zjdl+2nu5ShzHX4Z1KBMqL8hO9v7+2YJmoH4D5mY=;
        b=kUTbxhHEjbo4zW+okG7rb9E4aD4KhkUGNRgn5nojzrYRzVHJNx0R1s2PXzcxMokE8o
         Hg3dl4pVEDa3e/Vh83xwlZ50SCRZbv8i8JJ4+a94hHTWFBKN2ElwlMIOQJS8gzw+qwFa
         fCGq0yQSdLJ7qVdy1TmV5QzWLHGT9MHZCdzfiMKnYhSUbCchsGFupZ0quAZMJjX3c5jA
         mjha+vjyb66XnQIWmtr0FBP4zUj7qWVbfPRaKYQ2ldg3B/75C3lcGaRhVgHl28vApg+E
         4uYr34hDMNKWS7v9CK7mtUadNRDs3ZE3PBc7U5Ejij/NyAiCdiRHJKB1bMamtBz4ybUJ
         zsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=w20zjdl+2nu5ShzHX4Z1KBMqL8hO9v7+2YJmoH4D5mY=;
        b=NXrTJvMm3O8p8CYCqBTqjAO45tJcy59MQilV90ABtnnvx8htEOOoCF2j/nXfuv9zx/
         sEmGjfPWfRXWH3gJ3ufTeMrqcvN0+LCVZMmTln7bjU8xos25UAkYolJ6dwI5BZ+dt52q
         LsEP5MxqgjR9+6Sq0obb8cv5xfjA5sdlLXs6gyobYt3czABQ18rPyjnmpIyywwd3oRxq
         jGYMHSNAgiLt1N7NQE+5szD4Zt7pkL3k9qR8nlEzgAGMuyjuq7ZBHP52aP4NX7NqNAR0
         yvhnn9uA0PjqkZxvHih27EpJrP+4nRLTjBbY3vZK2VF7Yf/w9iHKrG1p+2BcwPWvZm1f
         G4Yg==
X-Gm-Message-State: ACgBeo0qWhVtAjUSPDV7eDogWtmGviSiZ2ZTS6Lyor5WbkaoSmCu0xER
        +FV2Emfxvyx8MMHGl6PEdtq6Hs0tnU+yWw==
X-Google-Smtp-Source: AA6agR5+Ss5IaYjMhtBRgd1+RKZlzCdDB+yjD23ZZCCwyE7f+/dzn+z97B8G9NadBdCIT3tx1XAgKw==
X-Received: by 2002:a05:6870:f6a8:b0:11b:d4d1:1459 with SMTP id el40-20020a056870f6a800b0011bd4d11459mr966633oab.245.1661490444152;
        Thu, 25 Aug 2022 22:07:24 -0700 (PDT)
Received: from james-x399.localdomain (71-33-138-207.hlrn.qwest.net. [71.33.138.207])
        by smtp.gmail.com with ESMTPSA id v18-20020a4aa512000000b0044b0465bd07sm616918ook.20.2022.08.25.22.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 22:07:23 -0700 (PDT)
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
        "David S. Miller" <davem@davemloft.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: fix type conflict in test_tc_dtime
Date:   Thu, 25 Aug 2022 23:06:59 -0600
Message-Id: <20220826050703.869571-1-james.hilliard1@gmail.com>
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

The sys/socket.h header isn't required to build test_tc_dtime and may
cause a type conflict.

Fixes the following error:
In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
                 from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
                 from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
                 from progs/test_tc_dtime.c:18:
/usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: error: conflicting types for 'int8_t'; have '__int8_t' {aka 'signed char'}
   24 | typedef __int8_t int8_t;
      |                  ^~~~~~
In file included from progs/test_tc_dtime.c:5:
/home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'char'}
   34 | typedef __INT8_TYPE__ int8_t;
      |                       ^~~~~~
/usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: error: conflicting types for 'int64_t'; have '__int64_t' {aka 'long long int'}
   27 | typedef __int64_t int64_t;
      |                   ^~~~~~~
/home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long int'}
   43 | typedef __INT64_TYPE__ int64_t;
      |                        ^~~~~~~
make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/test_tc_dtime.o] Error 1

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_tc_dtime.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tc_dtime.c b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
index b596479a9ebe..125beec31834 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_dtime.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_dtime.c
@@ -15,7 +15,6 @@
 #include <linux/udp.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
-#include <sys/socket.h>
 
 /* veth_src --- veth_src_fwd --- veth_det_fwd --- veth_dst
  *           |                                 |
-- 
2.34.1

