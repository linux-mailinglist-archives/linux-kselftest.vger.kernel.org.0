Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470B4243366
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Aug 2020 06:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgHMEof (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Aug 2020 00:44:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46405 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgHMEof (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Aug 2020 00:44:35 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1k656O-0000zb-N9
        for linux-kselftest@vger.kernel.org; Thu, 13 Aug 2020 04:44:32 +0000
Received: by mail-pg1-f197.google.com with SMTP id q5so3256771pgl.5
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Aug 2020 21:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tiz4nVgOo68QI5s9WSMXxhSe1AmwRM+pOa2QZ2cOoyM=;
        b=KCulj4GhVkTAGYhgXfVDjPT6SXqYEBLT8o3tk/I2p+WtBEIxlwL0vRh4AjzeeI3bqE
         SJNtFm4li0PT6lrTxbONqRAhJrO2zdIyPRf2c1jwRPO5YzQTKZrML8uYFMrxdOWgCgoA
         gK6TShbvzEmBcs16YkIKF2n4iln7PlxmZCHVKRTGgFZMHD6aU/8B9Xf2hWQLRgrliA9c
         WnzNKdtqVmjhbOF0PFD1zcRa5efBkJhi/kqmWxMPjbmgvZ2zC2Ntyt4pVyfxNpGtuhvh
         pHEWzNxb5+UDdovqDVGGnvsxyAivCg2bJLVGDv7zy6jfb+tfMGZWR1wT+YL2ATE31LIc
         RK0w==
X-Gm-Message-State: AOAM532svxeOsb9BYhMkORTAvYkYa5geQc0a5MwEGC+0ZyAY9jeZ60Wx
        zWSyzSqeq/VouoPfE7livLX+yow30AT5KAC4UpiEvFUT6unMuzUmza1Noiv7/+fUYcXamd4WiG+
        dNJNXYQAYMpTklSPQhFwttvAc8Z3WUUlHmj01GoyYHhb/
X-Received: by 2002:a17:902:c382:: with SMTP id g2mr2231938plg.120.1597293871317;
        Wed, 12 Aug 2020 21:44:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKeENi2Ukh3RAG5ReF+7QnR8cHk27E89MALm6sVpQMNi0yPoePWGZ4t0AN8I7VgYJQuDtInw==
X-Received: by 2002:a17:902:c382:: with SMTP id g2mr2231915plg.120.1597293870861;
        Wed, 12 Aug 2020 21:44:30 -0700 (PDT)
Received: from localhost.localdomain (114-136-120-176.emome-ip.hinet.net. [114.136.120.176])
        by smtp.gmail.com with ESMTPSA id n26sm3854956pgl.42.2020.08.12.21.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 21:44:30 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org
Cc:     po-hsu.lin@canonical.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] selftests: rtnetlink: load fou module for kci_test_encap_fou()
Date:   Thu, 13 Aug 2020 12:44:22 +0800
Message-Id: <20200813044422.46713-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
needs the fou module to work. Otherwise it will fail with:

  $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
  RTNETLINK answers: No such file or directory
  Error talking to the kernel

Add the CONFIG_NET_FOU into the config file as well.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/config       | 1 +
 tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 3b42c06b..96d2763 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -31,3 +31,4 @@ CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_KALLSYMS=y
+CONFIG_NET_FOU
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index bdbf4b3..7931b65 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -521,6 +521,11 @@ kci_test_encap_fou()
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
@@ -541,6 +546,7 @@ kci_test_encap_fou()
 		return 1
 	fi
 
+	/sbin/modprobe -q -r fou
 	echo "PASS: fou"
 }
 
-- 
2.7.4

