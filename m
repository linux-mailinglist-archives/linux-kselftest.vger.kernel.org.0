Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDCC781B67
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Aug 2023 02:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjHTAJ7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Aug 2023 20:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHTAJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Aug 2023 20:09:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BEB6A864;
        Sat, 19 Aug 2023 12:50:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fedba79923so10620545e9.2;
        Sat, 19 Aug 2023 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692474644; x=1693079444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed1L9DO87oWFUUO+hp/1iqQshAPP0RxGE8TIKJiSCVI=;
        b=ermcIWZ7aKo/ZIQrmHAtx9i82fs+DGo+8+rdar7aCA9iNpKRHZC6bf3Y1UMuhhDvhS
         OEKlPDS4iwOpeE9WRZsgadEkAS6l1oBb1Fy4SiSBf6HhaOpulUf6WBqmZ/8BEHVvqfgo
         CUdqJpfieU5a7o2IEywBAfO4WGusMddJDGeDfDZwTtUiiHmgj8mnCfDuDrLiysMNpZL2
         m9yjNFdpr/zpEBe6EQOQ3foIV1FnqSfEYUo85ZAr3kW8PuPxKIcdZw8HV8jVyzfTDG5u
         Qu5VseudUycp3ygf1mQq69cHeP1r9AeHw6Mh+qyXwVlcpcWiZqoKU93/hjCG4o/B5vba
         k2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692474644; x=1693079444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed1L9DO87oWFUUO+hp/1iqQshAPP0RxGE8TIKJiSCVI=;
        b=P0TpFKom131tZkmonNEnh9r9T66OI4/j4aTKe7duqvFyHOLk/TKd45Sz6V/kuCD9FZ
         cSFgsk+K2/Rxf0RK6VDsDVkoxKvoDA0bZ1GlHgRTa1eaDqsQFL7U62y8eAmZWnjQX+Bb
         fT5rwp4iyOvuWUOzOVTQwheZV6ONQIBkqeXZEq9VAmeyVR3OxsFvIgII4uu/LA8zvTOB
         0GLKQHTmkdfHsUIdEX7AUY5GoPMy03R/7Zzfd2xXUZWYk9RvLrIQdDotnq/ByBeRt2Bh
         yr2JAD2tVnx7al5Savur/e76mqhzhSASrFP/SQyZkuUOu9oTIyLQ94tp7ZPoxqrlD2aX
         FZLg==
X-Gm-Message-State: AOJu0Yy4DvRBPcuyS+651/qEGFCyri92L+shBo4GSK2EkN0nmko7aHW8
        WvgIF9H9AXDBj8MxDcOLe5FwUV4P+sd/2yYR
X-Google-Smtp-Source: AGHT+IGGsfzB1e+jD2yQqE1ZxZhkWAdlFaDNtEQytVeoXH1m7gO9tnE8fsk5i7jvoJSe14A7P6Fkdg==
X-Received: by 2002:a7b:c8d0:0:b0:3fc:7d2:e0c0 with SMTP id f16-20020a7bc8d0000000b003fc07d2e0c0mr1819335wml.27.1692474644304;
        Sat, 19 Aug 2023 12:50:44 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([5.194.84.172])
        by smtp.gmail.com with ESMTPSA id l19-20020a1c7913000000b003fe26bf65e7sm6861382wme.13.2023.08.19.12.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 12:50:43 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        pabeni@redhat.com, edumazet@google.com, shuah@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH 2/2] selftests/net: replace ternary operator with min()/max()
Date:   Sat, 19 Aug 2023 23:50:05 +0400
Message-Id: <20230819195005.99387-3-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warning:
tools/testing/selftests/net/udpgso_bench_tx.c:297:18-19: WARNING opportunity for min()
tools/testing/selftests/net/udpgso_bench_tx.c:354:27-28: WARNING opportunity for min()
tools/testing/selftests/net/so_txtime.c:129:24-26: WARNING opportunity for max()
tools/testing/selftests/net/so_txtime.c:96:30-31: WARNING opportunity for max()

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
---
 tools/testing/selftests/net/Makefile          | 2 ++
 tools/testing/selftests/net/so_txtime.c       | 7 ++++---
 tools/testing/selftests/net/udpgso_bench_tx.c | 6 +++---
 3 files changed, 9 insertions(+), 6 deletions(-)

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
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 2672ac0b6d1f..2936174e7de4 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -33,6 +33,8 @@
 #include <unistd.h>
 #include <poll.h>
 
+#include "kselftest.h"
+
 static int	cfg_clockid	= CLOCK_TAI;
 static uint16_t	cfg_port	= 8000;
 static int	cfg_variance_us	= 4000;
@@ -93,8 +95,7 @@ static void do_send_one(int fdt, struct timed_send *ts)
 		msg.msg_controllen = sizeof(control);
 
 		tdeliver = glob_tstart + ts->delay_us * 1000;
-		tdeliver_max = tdeliver_max > tdeliver ?
-			       tdeliver_max : tdeliver;
+		tdeliver_max = max(tdeliver_max, tdeliver);
 
 		cm = CMSG_FIRSTHDR(&msg);
 		cm->cmsg_level = SOL_SOCKET;
@@ -126,7 +127,7 @@ static void do_recv_one(int fdr, struct timed_send *ts)
 		error(1, 0, "read: %dB", ret);
 
 	tstop = (gettime_ns(cfg_clockid) - glob_tstart) / 1000;
-	texpect = ts->delay_us >= 0 ? ts->delay_us : 0;
+	texpect = max(ts->delay_us, 0);
 
 	fprintf(stderr, "payload:%c delay:%lld expected:%lld (us)\n",
 			rbuf[0], (long long)tstop, (long long)texpect);
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index 477392715a9a..e92a7a753959 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -25,7 +25,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "../kselftest.h"
+#include "kselftest.h"
 
 #ifndef ETH_MAX_MTU
 #define ETH_MAX_MTU 0xFFFFU
@@ -294,7 +294,7 @@ static int send_udp(int fd, char *data)
 	total_len = cfg_payload_len;
 
 	while (total_len) {
-		len = total_len < cfg_mss ? total_len : cfg_mss;
+		len = min(total_len, cfg_mss);
 
 		ret = sendto(fd, data, len, cfg_zerocopy ? MSG_ZEROCOPY : 0,
 			     cfg_connected ? NULL : (void *)&cfg_dst_addr,
@@ -351,7 +351,7 @@ static int send_udp_sendmmsg(int fd, char *data)
 			error(1, 0, "sendmmsg: exceeds max_nr_msg");
 
 		iov[i].iov_base = data + off;
-		iov[i].iov_len = cfg_mss < left ? cfg_mss : left;
+		iov[i].iov_len = min(cfg_mss, left);
 
 		mmsgs[i].msg_hdr.msg_iov = iov + i;
 		mmsgs[i].msg_hdr.msg_iovlen = 1;
-- 
2.34.1

