Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31396DF149
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjDLJ7a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjDLJ73 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 05:59:29 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CD265B8
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 02:59:27 -0700 (PDT)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D7F9C3F42A
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 09:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681293565;
        bh=lPAnInjEPmYSXmdYizwbO/BNtnsYb9zk0SNDJiS3bTc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=KVZ4rVncHngaMgp9erc+RVM5khvF1Wk6s5/lx5l/8HggGEZAWToGw4bIrED7+J58t
         AlGIhVHazS6v+wqq2N9SNmDK3ZfOyXwB8/itRGuOD+QFBZV+CU140DzNbD9Ra3eDBX
         GRN6HGJKWDdFmMWKqPdH8v+I6NLuqy9tqvmHbi6f1iufjlJlHbu35PvNHzaJ0Z0gN9
         y2bw9/MsYipCYFmGxFROpNxPh1wW5W7NIs2H8QbMJSHbbWAvtyGI1P9z4pS+ZfI+s6
         2pZRG+ueXqhVOFAxUYIQJ11GofKS9Q8CmXsYOiQnQnhcbWpJ0ZCxN5sUUYtMK650Fj
         XiBmf3/9RnGZQ==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1842e8a9b8bso6190670fac.16
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 02:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681293565; x=1683885565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPAnInjEPmYSXmdYizwbO/BNtnsYb9zk0SNDJiS3bTc=;
        b=DQiKw5FT0aJvcYWwwSyQjzCqbhtcbaVStnpPCXLqOWCStBoXFb5uAvjDkaER45vCXb
         mT22ALePrKLLb24SIwjx3EDsgOwWUgzjwUUWELJuI1VxFSti6ckjxc4xv3s8Y/oULUal
         lD7ay7L5jeorQDDwRWNY1K+ZC/fM5wxtvDF6RIiCr0kd9JA068DyoH8YPhFxy4TDNz1B
         vku0XnfpRf6ACBSa6UDkOWb+paH3hkLOPTc41tZAgNOTMUOLICCGXCl/nFTzgJ2UubFE
         6L1GmS91UHsDyGI4d8E+06QvuI3qL67oRF2gZkL16488NNdpZuItJBhHhGIK8BlnYoAK
         b38A==
X-Gm-Message-State: AAQBX9c+zaBBlwDGFmvcaS3gE+paTGWmQ8rsa3uZ2XXFvkHF2htwDKXe
        oJL+GGg9dkhSjSiipB+EoTJBeKH4lheVysl7ldswrABbu4TIrDCRyDGW/TfDYaWwKeNIm+QPif7
        tXlIgc2JfJLBihIh2vAoy4f/SKc8bp0shIFsAQB6W+Cw3yQ==
X-Received: by 2002:a05:6870:610d:b0:183:be43:c9b6 with SMTP id s13-20020a056870610d00b00183be43c9b6mr1118732oae.4.1681293564791;
        Wed, 12 Apr 2023 02:59:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yke3E7dyjDyozy6CKNMRJ1yHALwyJpgUMrQxdhYZcZxJvUNLn3rj3fZX932Jte9GiiI4COFQ==
X-Received: by 2002:a05:6870:610d:b0:183:be43:c9b6 with SMTP id s13-20020a056870610d00b00183be43c9b6mr1118714oae.4.1681293564521;
        Wed, 12 Apr 2023 02:59:24 -0700 (PDT)
Received: from localhost.localdomain (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id zr21-20020a056871ae1500b001765b2f6c53sm6045880oab.9.2023.04.12.02.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 02:59:23 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Paolo Pisati <paolo.pisati@canonical.com>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: ignore pointer types check with clang
Date:   Wed, 12 Apr 2023 11:59:12 +0200
Message-Id: <20230412095912.188453-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Building bpf selftests with clang can trigger errors like the following:

  CLNG-BPF [test_maps] bpf_iter_netlink.bpf.o
progs/bpf_iter_netlink.c:32:4: error: incompatible pointer types assigning to 'struct sock *' from 'struct sock___17 *' [-Werror,-Wincompatible-pointer-types]
        s = &nlk->sk;
          ^ ~~~~~~~~
1 error generated.

This is due to the fact that bpftool emits duplicate data types with
different names in vmlinux.h (i.e., `struct sock` in this case) and
these types, despite having a different name, represent in fact the same
object.

Add -Wno-incompatible-pointer-types to CLANG_CLAGS to prevent these
errors.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b677dcd0b77a..0d9ef819a065 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -356,7 +356,8 @@ BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 		\
 	     -I$(abspath $(OUTPUT)/../usr/include)
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
-	       -Wno-compare-distinct-pointer-types
+	       -Wno-compare-distinct-pointer-types \
+	       -Wno-incompatible-pointer-types
 
 $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
 $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
-- 
2.39.2

