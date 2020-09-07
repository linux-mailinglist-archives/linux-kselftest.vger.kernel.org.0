Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2425F236
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 05:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgIGDuZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Sep 2020 23:50:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49304 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIGDuX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Sep 2020 23:50:23 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kF8Ae-0005v9-Iw
        for linux-kselftest@vger.kernel.org; Mon, 07 Sep 2020 03:50:20 +0000
Received: by mail-pl1-f198.google.com with SMTP id y13so3383779plr.1
        for <linux-kselftest@vger.kernel.org>; Sun, 06 Sep 2020 20:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3g3V+QNt3GCtg2Hc+UJaZtxoWISK1rJHJzXJXHO3wbk=;
        b=JzeemAXJFs0sGJKLionAUb7m6X7vZG8/adBYuhAC8jdB4zhUp2uMZm7ZlXZ98mNSiq
         RZYvLl6BoqWCR8DctVYi2G9YfMn4tJD/b8AlnaeedW4HqSgZv0Aj1EYf7nS2E7KafEpy
         pClgLRF1w7G/AL8j9OJEtqQsKM9QI14anh3s/oFJC8qS/AQpA4lO85fCem7z30ytzAxJ
         K8s61Mi7qEnvXOX3C1qQHO1myMNAh6SiAiVOi/GhJztxrgeFmVtY2uqNCdTw/WT7xeWK
         sJgEmR7k6jwDav9tNFtvCfbSOx3QG1dfoAJOrSscVh0/CPAEa1R0hW2NFckBxpEy86OT
         Q86A==
X-Gm-Message-State: AOAM530Trb2OmcgahhOoT31+aW4rJzbtoFviZc7b7BG7BtKC/AU8SXV3
        h/bB2Sc4fJv9w7rRaFwX/is7y8gIA9d2H6sSf04ZdqnAyiQr8q5XKkBa++5t7itMvPLkSC0Z4Sf
        cd4Kj7P1k8J6PyPyEmhDqNZ1mu4Hu/YTI0TL2Zkvkd4TL
X-Received: by 2002:aa7:8b02:: with SMTP id f2mr17326305pfd.59.1599450618941;
        Sun, 06 Sep 2020 20:50:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiw6zva7WG2JalWfZO5CnnUA49jrjPIHrcrSaL3UTwr1qmqpBYYx79C1OGaVQ4e1GVoN+a1g==
X-Received: by 2002:aa7:8b02:: with SMTP id f2mr17326293pfd.59.1599450618608;
        Sun, 06 Sep 2020 20:50:18 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id e1sm10828706pjv.17.2020.09.06.20.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:50:17 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org
Cc:     po-hsu.lin@canonical.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCHv3] selftests: rtnetlink: load fou module for kci_test_encap_fou() test
Date:   Mon,  7 Sep 2020 11:50:10 +0800
Message-Id: <20200907035010.9154-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
needs the fou module to work. Otherwise it will fail with:

  $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
  RTNETLINK answers: No such file or directory
  Error talking to the kernel

Add the CONFIG_NET_FOU into the config file as well. Which needs at
least to be set as a loadable module.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/config       | 1 +
 tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 3b42c06b..c5e50ab 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -31,3 +31,4 @@ CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_KALLSYMS=y
+CONFIG_NET_FOU=m
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 7c38a90..a711b3e 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -520,6 +520,11 @@ kci_test_encap_fou()
 		return $ksft_skip
 	fi
 
+	if ! /sbin/modprobe -q -n fou; then
+		echo "SKIP: module fou is not found"
+		return $ksft_skip
+	fi
+	/sbin/modprobe -q fou
 	ip -netns "$testns" fou add port 7777 ipproto 47 2>/dev/null
 	if [ $? -ne 0 ];then
 		echo "FAIL: can't add fou port 7777, skipping test"
@@ -540,6 +545,7 @@ kci_test_encap_fou()
 		return 1
 	fi
 
+	/sbin/modprobe -q -r fou
 	echo "PASS: fou"
 }
 
-- 
2.7.4

