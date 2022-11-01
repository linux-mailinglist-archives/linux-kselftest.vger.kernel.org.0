Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2440F6151C8
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 19:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKAStU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKAStT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 14:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2925FCF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 11:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667328502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7ie1yf5gnqJej0Jdp4B4ph0EWrk81soUHngI0zbagow=;
        b=Y1QAcZZNSKcs14NCzUXKUNw1C6cPm/yYKAeHT5jbuGcjF6bWuYJW6l+4/WOlbRjr66s0RN
        +MUWg+e6+ImEq0da+bQpfkJZ/3NWgIHwdFAruMKBhyU4YUoG30EyMuWeCeRg04JgWVpB5v
        YcEO8bGMQYJmDexYejUVe5p84M3f0+8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-p3Iz677wNkCvAHXe8FdEyQ-1; Tue, 01 Nov 2022 14:48:20 -0400
X-MC-Unique: p3Iz677wNkCvAHXe8FdEyQ-1
Received: by mail-qt1-f197.google.com with SMTP id cm12-20020a05622a250c00b003a521f66e8eso4708602qtb.17
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Nov 2022 11:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ie1yf5gnqJej0Jdp4B4ph0EWrk81soUHngI0zbagow=;
        b=eqR+qK1gfRcSqiTSG/F1Xssyl45+LunbHFq+cgT+hPfb9dDHXhysp0kBMTRrtHCK1F
         ZDDQJ7bXARx6FGeZIgE47sekg2jPDEj5jB9l8u0kcAr/4rem3fpwwyoz1IlUVxRpaWLH
         dhzinNJYKTEOvHO7n/DUD2ccIXjVGROqtEqbM5RHkxacubWHDOfJhnsH8qvpPgHyAJd2
         erN2uh89WXrTsRb4gUN4mkeP0I+6woptkwns1UlBlK+uqm+5OO4NzI5iFvneb2UmMwPc
         l+XUhzs470mula8F3EXDj3cGF7qCby4KKfEb0R+cvyjY6Yog9h/wNGakm9/V5e/dukke
         NgzQ==
X-Gm-Message-State: ACrzQf2hvAVT6FQtK57fIAUlXSyyDCckLpvXRTDvIaUl/79eu9cvyEsY
        HbJUm259gTDp5fhB3kqIMSSuYwpdE914Etskh9CfDcQOLUqYNwipN0oN0a0fC207R5tx7I+ITIy
        3ko6IrCDrT7lB2GTENwYkKvBDs5ka
X-Received: by 2002:a05:6214:c2d:b0:4bb:fce3:bb30 with SMTP id a13-20020a0562140c2d00b004bbfce3bb30mr8927604qvd.16.1667328499895;
        Tue, 01 Nov 2022 11:48:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM67UmKZbA62ABhdvT+lYMvZ1rpVwKDjdkJ6Oa1NJ5uofq+84se+nFHREf5K9o/MZk0H6WmkqA==
X-Received: by 2002:a05:6214:c2d:b0:4bb:fce3:bb30 with SMTP id a13-20020a0562140c2d00b004bbfce3bb30mr8927586qvd.16.1667328499652;
        Tue, 01 Nov 2022 11:48:19 -0700 (PDT)
Received: from fedora.redhat.com (modemcable149.19-202-24.mc.videotron.ca. [24.202.19.149])
        by smtp.gmail.com with ESMTPSA id fb24-20020a05622a481800b003a51d65b8basm4579638qtb.36.2022.11.01.11.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:48:18 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Adrien Thierry <athierry@redhat.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/net: give more time to udpgro bg processes to complete startup
Date:   Tue,  1 Nov 2022 14:48:08 -0400
Message-Id: <20221101184809.50013-1-athierry@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In some conditions, background processes in udpgro don't have enough
time to set up the sockets. When foreground processes start, this
results in the test failing with "./udpgso_bench_tx: sendmsg: Connection
refused". For instance, this happens from time to time on a Qualcomm
SA8540P SoC running CentOS Stream 9.

To fix this, increase the time given to background processes to
complete the startup before foreground processes start.

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
This is a continuation of the hack that's present in those tests. Other
ideas are welcome to fix this in a more permanent way.

 tools/testing/selftests/net/udpgro.sh         | 4 ++--
 tools/testing/selftests/net/udpgro_bench.sh   | 2 +-
 tools/testing/selftests/net/udpgro_frglist.sh | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro.sh b/tools/testing/selftests/net/udpgro.sh
index ebbd0b282432..6a443ca3cd3a 100755
--- a/tools/testing/selftests/net/udpgro.sh
+++ b/tools/testing/selftests/net/udpgro.sh
@@ -50,7 +50,7 @@ run_one() {
 		echo "failed" &
 
 	# Hack: let bg programs complete the startup
-	sleep 0.1
+	sleep 0.2
 	./udpgso_bench_tx ${tx_args}
 	ret=$?
 	wait $(jobs -p)
@@ -117,7 +117,7 @@ run_one_2sock() {
 		echo "failed" &
 
 	# Hack: let bg programs complete the startup
-	sleep 0.1
+	sleep 0.2
 	./udpgso_bench_tx ${tx_args} -p 12345
 	sleep 0.1
 	# first UDP GSO socket should be closed at this point
diff --git a/tools/testing/selftests/net/udpgro_bench.sh b/tools/testing/selftests/net/udpgro_bench.sh
index fad2d1a71cac..8a1109a545db 100755
--- a/tools/testing/selftests/net/udpgro_bench.sh
+++ b/tools/testing/selftests/net/udpgro_bench.sh
@@ -39,7 +39,7 @@ run_one() {
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx -t ${rx_args} -r &
 
 	# Hack: let bg programs complete the startup
-	sleep 0.1
+	sleep 0.2
 	./udpgso_bench_tx ${tx_args}
 }
 
diff --git a/tools/testing/selftests/net/udpgro_frglist.sh b/tools/testing/selftests/net/udpgro_frglist.sh
index 832c738cc3c2..7fe85ba51075 100755
--- a/tools/testing/selftests/net/udpgro_frglist.sh
+++ b/tools/testing/selftests/net/udpgro_frglist.sh
@@ -44,7 +44,7 @@ run_one() {
 	ip netns exec "${PEER_NS}" ./udpgso_bench_rx ${rx_args} -r &
 
 	# Hack: let bg programs complete the startup
-	sleep 0.1
+	sleep 0.2
 	./udpgso_bench_tx ${tx_args}
 }
 
-- 
2.38.1

