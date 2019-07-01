Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B47AC5B3A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2019 06:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfGAEkr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jul 2019 00:40:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33983 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfGAEkr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jul 2019 00:40:47 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hho7Q-0001hk-Tc
        for linux-kselftest@vger.kernel.org; Mon, 01 Jul 2019 04:40:45 +0000
Received: by mail-pg1-f199.google.com with SMTP id t19so2345255pgh.6
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Jun 2019 21:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9vifoJSKcoFZv9bK756pSy0guphf7tbgTB5siI2JqwU=;
        b=VM9eXJSbzrlA4aEEHIhO5JFvJQAUDvtvVtXhvEOVDWQdx2exnkGDP40YH08xML6Jjw
         FmfUoiYmS8Yt8riHLVO5FLfbdnDWPhKSi0GU/1r9Blpd25RdCGOgcWIlOKKkJPNznwCg
         cXuMwfXybgIOoibXZl8XtsOoOL2FSZoKq5lw0PVK6ec5urtEWBX4gTQhis34rGJbiae5
         nfz/XkjW4UDA+ZKUUSqTcX3EtgrCcst2c9IvrLuIfv52M+qOu6iMZoUEI5gsmvvihdyj
         BgTJh7BAajzirOLEvMueopgvd/2Lxoh0Mw+X3FP4SrBWtnlaHoUMEj0HuRJHRm/DvHRj
         C4Aw==
X-Gm-Message-State: APjAAAWEzzZeKy2ql7IPLgx66r6B48Al5fpE3agcupfSydiOslkMET9J
        dV0yNXcTu0Tcu1ESDkETgrxoNd6lFa1yNVhEFjo8tPTUrc4XTSNQjOAM2dVXhlk+bgyB+u1cYYS
        HcICrmTT4WqK63CkYgr3NoHJxLR9gHcjZpOQiP+Hl8fKe
X-Received: by 2002:a17:902:324:: with SMTP id 33mr370878pld.340.1561956043686;
        Sun, 30 Jun 2019 21:40:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrjpjZ50ynx/B04ND0r1L7o7s7teiIgeCRvr0C5WzfvIZjiG3+mRjQfq4G+knSH+kt+kLTVA==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr370862pld.340.1561956043442;
        Sun, 30 Jun 2019 21:40:43 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id h1sm7823505pgv.93.2019.06.30.21.40.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 21:40:42 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2] selftests/net: skip psock_tpacket test if KALLSYMS was not enabled
Date:   Mon,  1 Jul 2019 12:40:31 +0800
Message-Id: <20190701044031.19451-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The psock_tpacket test will need to access /proc/kallsyms, this would
require the kernel config CONFIG_KALLSYMS to be enabled first.

Apart from adding CONFIG_KALLSYMS to the net/config file here, check the
file existence to determine if we can run this test will be helpful to
avoid a false-positive test result when testing it directly with the
following commad against a kernel that have CONFIG_KALLSYMS disabled:
    make -C tools/testing/selftests TARGETS=net run_tests

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/config            |  1 +
 tools/testing/selftests/net/run_afpackettests | 14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 4740404..3dea2cb 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -25,3 +25,4 @@ CONFIG_NF_TABLES_IPV6=y
 CONFIG_NF_TABLES_IPV4=y
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV4=m
+CONFIG_KALLSYMS=y
diff --git a/tools/testing/selftests/net/run_afpackettests b/tools/testing/selftests/net/run_afpackettests
index ea5938e..8b42e8b 100755
--- a/tools/testing/selftests/net/run_afpackettests
+++ b/tools/testing/selftests/net/run_afpackettests
@@ -21,12 +21,16 @@ fi
 echo "--------------------"
 echo "running psock_tpacket test"
 echo "--------------------"
-./in_netns.sh ./psock_tpacket
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	ret=1
+if [ -f /proc/kallsyms ]; then
+	./in_netns.sh ./psock_tpacket
+	if [ $? -ne 0 ]; then
+		echo "[FAIL]"
+		ret=1
+	else
+		echo "[PASS]"
+	fi
 else
-	echo "[PASS]"
+	echo "[SKIP] CONFIG_KALLSYMS not enabled"
 fi
 
 echo "--------------------"
-- 
2.7.4

