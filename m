Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853DC754366
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjGNTqz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 15:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjGNTqz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 15:46:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1683AA0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 12:46:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so21433275e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689364003; x=1691956003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/XBx+rOW69bTWn7J4y9AfvlrihBcp26V+F+JjCNTmg=;
        b=kdFj+D5dalQPcdbLkQsLpOi5jgUk6B/bsslpNbf+Hgj1cYzoAGJjW+jZoFfqB2axwf
         ztSpaLxI9AkQsOH10pfV2nJ/bakeAkz1Q+UkO0qSyctgeemiBjRDEvaTuVZZCjl0Uysg
         qxPhz6qDXiWoRv1xtISlCQkKcde1LQWkuFBDiwL8K5Sgdy+LO5DFDNGL6RKoyVM+V6fM
         SV48A0cqghuM4QTdXOrVLS9s/rmq3aPkafrWcVLcW9PIl1yHO4tmvXvwXvYQTl9frXZV
         jRuYtydLqWYfydR/nEcrffBV2YhDTGll6e+xs01YnvdwlF4B0x6uNLnTj/BEPlms78fP
         dxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689364003; x=1691956003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/XBx+rOW69bTWn7J4y9AfvlrihBcp26V+F+JjCNTmg=;
        b=E0S1gipswit/BPUsM4H9KYjI14ZrtYhpp7A4jp/EUGCWwrq9Nmw5ARCrQ/qIHgl47u
         Lm1DGBIqjeoYjKQ6PymhP5gjpwLa7yyBZ5XeeVoYGeuTuoIFdy/1p28v9lb9VcLZ2Gk8
         9r29jlvlUtxj9M7WRyst1aR+2cnN7Tm6rffYpMcRCTgt2QvLiA+rLezaDKbMYekaVBw7
         nSBTKtyYzOXfbpxGD9YajsW+AaoswX8yuZuAYMxl2sgGf2r1+n/SwcglSj/XBN6Ofr7C
         taWb1ICjR1kF9T61zoSLNVJl5FCc8uykmZTHxYPvVfy5AN3ECaqOjEr/ps+sCSDc2ovW
         3oPw==
X-Gm-Message-State: ABy/qLYGhBLkwoPSrsaq7Vi6WJbP5tjpsAuPvf2XqcNUuDrU9Ye6j+LC
        /NACjK9EbTg1ktsWf6q+47c=
X-Google-Smtp-Source: APBJJlE6CdAINDs5rFAFfEZ7pFwcVuW8Xt+8zXg44DU7BmOmKcYfSd1HDyIncHQIQaarhvpLLQwm3g==
X-Received: by 2002:a7b:c414:0:b0:3fb:424b:ef6f with SMTP id k20-20020a7bc414000000b003fb424bef6fmr4519454wmi.23.1689364002604;
        Fri, 14 Jul 2023 12:46:42 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:535c:552f:1d2:678e:5d15])
        by smtp.gmail.com with ESMTPSA id v9-20020a1cf709000000b003fc00892c13sm2067125wmh.35.2023.07.14.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 12:46:42 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH v1] selftests/net: replace manual array size calc with ARRAYSIZE macro.
Date:   Fri, 14 Jul 2023 23:46:35 +0400
Message-Id: <20230714194635.1779496-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

fixes coccinelle WARNING: Use ARRAY_SIZE

changelog since v0:
 - update net/Makefile to include kselftest.h
 - remove redefinition of ARRAYSIZE.

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
---
 tools/testing/selftests/net/Makefile          | 2 ++
 tools/testing/selftests/net/csum.c            | 6 ++----
 tools/testing/selftests/net/hwtstamp_config.c | 5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 7f3ab2a93ed6..a06cc25489f9 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -3,6 +3,8 @@
 
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
 CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
+# Additional include paths needed by kselftest.h
+CFLAGS += -I../
 
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
 	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
diff --git a/tools/testing/selftests/net/csum.c b/tools/testing/selftests/net/csum.c
index 702f34a9d506..90eb06fefa59 100644
--- a/tools/testing/selftests/net/csum.c
+++ b/tools/testing/selftests/net/csum.c
@@ -91,6 +91,8 @@
 #include <sys/types.h>
 #include <unistd.h>
 
+#include "kselftest.h"
+
 static bool cfg_bad_csum;
 static int cfg_family = PF_INET6;
 static int cfg_num_pkt = 4;
@@ -123,10 +125,6 @@ static struct sockaddr_in6 cfg_saddr6 = {.sin6_family = AF_INET6};
 #define MAX_HEADER_LEN	(sizeof(struct ipv6hdr) + ENC_HEADER_LEN + sizeof(struct tcphdr))
 #define MAX_PAYLOAD_LEN 1024
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
-#endif
-
 /* Trivial demo encap. Stand-in for transport layer protocols like ESP or PSP */
 struct udp_encap_hdr {
 	uint8_t nexthdr;
diff --git a/tools/testing/selftests/net/hwtstamp_config.c b/tools/testing/selftests/net/hwtstamp_config.c
index 263cc1c34165..873f4937f37f 100644
--- a/tools/testing/selftests/net/hwtstamp_config.c
+++ b/tools/testing/selftests/net/hwtstamp_config.c
@@ -16,9 +16,8 @@
 #include <linux/net_tstamp.h>
 #include <linux/sockios.h>
 
-#ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
-#endif
+#include "kselftest.h"
+
 
 static int
 lookup_value(const char **names, int size, const char *name)
-- 
2.34.1

