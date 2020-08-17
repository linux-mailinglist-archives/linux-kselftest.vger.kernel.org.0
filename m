Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118F2245AD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Aug 2020 04:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHQCxm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Aug 2020 22:53:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgHQCxg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Aug 2020 22:53:36 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1k7VHB-0008NU-Vz
        for linux-kselftest@vger.kernel.org; Mon, 17 Aug 2020 02:53:34 +0000
Received: by mail-pl1-f197.google.com with SMTP id bc7so9090735plb.4
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Aug 2020 19:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3thZXTBTKrCmlLY4l7vI4Z+3HdNyGpWqEUhf/airL/4=;
        b=GSLrxYzRKvfXqORf7qXcQBSInmCf6C3CVzOAhzm6mtPk/tAePVG7M9KLEM7SKKVHrt
         dDZGWDANin7yMbv2nDAmPAekLHq+h0NeqAbTGN1VqQmAsoldKDbpfTACR8aW91bHItZ3
         9x3MtOLLqwjouRKRSp9jZEwfrcxCLEBZYJB5Js6iH+6y50GHWJkLBEnNz4/h9qCP4NJ1
         XHNmydYVlB29vu5h7PyuxEjqbllC47ze+qY3D/FvNkzpJ3EYrWCsZs5DVdiF1e7rmyy1
         fZhGvj/dDeZY25Hjpn15YJ+XMynn52nlHXTrx2cGxV0WpgI/+1kbm6dC2XC3mDnlTqiG
         +hyg==
X-Gm-Message-State: AOAM5325bWnfguhtryl1A707nydLTt1kOIGBeF0iS75wds9cR2+nv6Hb
        nrtMWZnLf9J5oiyIvRnhLzWZrHoZNy820Tdj6dAu4aOpY3ImAa509eKUf1PaWtpXozPhGvytxZy
        60q3DBcq7tr4+KdjPtfZLVUkSprNxNO2cJklUg92o2ryB
X-Received: by 2002:a17:902:9a90:: with SMTP id w16mr9349556plp.181.1597632812246;
        Sun, 16 Aug 2020 19:53:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYSrXFxMVskI/6CjR5bWlyUSO/dR2wuoqndwsRqss2tPsixONO1ZHIaA3LLldYtnYjj5KQsw==
X-Received: by 2002:a17:902:9a90:: with SMTP id w16mr9349547plp.181.1597632811920;
        Sun, 16 Aug 2020 19:53:31 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id ez7sm15094834pjb.10.2020.08.16.19.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 19:53:31 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org
Cc:     po-hsu.lin@canonical.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCHv2] selftests: rtnetlink: load fou module for kci_test_encap_fou()
Date:   Mon, 17 Aug 2020 10:52:13 +0800
Message-Id: <20200813044422.46713-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
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

Add the CONFIG_NET_FOU into the config file as well. Which needs at
least to be set as a loadable module.

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
+CONFIG_NET_FOU=m
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

