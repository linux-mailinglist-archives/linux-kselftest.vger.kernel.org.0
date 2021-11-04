Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B22F4451AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Nov 2021 11:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhKDKs4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Nov 2021 06:48:56 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51176
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhKDKsy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Nov 2021 06:48:54 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 701283F1BF
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Nov 2021 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636022776;
        bh=ZN41nDD8py06mnFa3s9ouXcWZDugqMeS/fkELpZ2qUM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=REJSS0mNDSw/l4TPLBBD6kwmuPW4CKapQ0sGbZ12ju96JzOFlPCNS3jfB7bXlCaNa
         c6hMKU0z6r2CJiGDb9e2OQgDnhOAxueBIx/tA7bn9s1E4yzp+UcInMtMkkMx9hjxn6
         lWE4u6HZXyI9pDnYp2xag2w8Hstyr/sa+01iHYLG47ctmSOCnNI+FoqewHJ0oSz7yq
         AZK6mh382L07dt3c/kVc9CvD20Hpe7AwHzdijzmBECwaA1dRY8/Blko9armNV7xQUZ
         YhWuIWvbFIDmH3WPe2M5AO/4puBD26nMUM7cexjBZKVWdUNIDfytZgjbM59k5FMB+Z
         hftDiAmtVma6Q==
Received: by mail-ed1-f71.google.com with SMTP id u10-20020a50d94a000000b003dc51565894so5272938edj.21
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Nov 2021 03:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZN41nDD8py06mnFa3s9ouXcWZDugqMeS/fkELpZ2qUM=;
        b=n81MVRg+GTkfvMRRnv0gNCqmgRnoVD+jfQ951xWwioYbm0ZiqLs5TKFEWXEf3zJx9I
         eC8J/o1Az09L1Maa1qV3V2or2Yr+sLPWXJcISAaiiDtGoessQIwPp14utUi969IbjMFl
         +k6GLK24lUgzHyrSy0kdSZna1zxj/ElYxxAxIKd6OR+HcNbexg1ThsJGCfg6CELRTIq4
         IRaQbiGI/oPjiFasRwwcVq02MmpgqSkK341hbzqSAUmACD2gOXSkSgWP2aH18y2LXWY+
         mB+thegNXHf9GAKqphZSItVbReVFD26qQ6R67K0j63j9KCCVnxirSjlj+BTqTnl7tT2n
         wUyg==
X-Gm-Message-State: AOAM533YM1jCMO99eQphMaGRRCE+dKesicU/lPgFvZuDwdePqDaOZMQC
        nJFWN3A2qggRp1tI3ul/EKNZng8MYrz4VoB3GxLVJnddEJWDpVAmA+ewgxFaPqYKZNDjWFuxJjh
        jotY0KoZkg4QRGHT7CNZu6SJSdEYuAkB+pQsvc09NN80S9w==
X-Received: by 2002:a17:907:9690:: with SMTP id hd16mr29546068ejc.297.1636022776045;
        Thu, 04 Nov 2021 03:46:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyg44uUWRIXLpI3YABCyqPm2ZeRXQH29L4D/he2NXdV1Ri9DQkShgOR5FoMKKFJ+/3NqYKMPQ==
X-Received: by 2002:a17:907:9690:: with SMTP id hd16mr29546049ejc.297.1636022775850;
        Thu, 04 Nov 2021 03:46:15 -0700 (PDT)
Received: from arighi-desktop.homenet.telecomitalia.it ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id f25sm2618473edv.90.2021.11.04.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 03:46:15 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: properly support IPv6 in GSO GRE test
Date:   Thu,  4 Nov 2021 11:46:13 +0100
Message-Id: <20211104104613.17204-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Explicitly pass -6 to netcat when the test is using IPv6 to prevent
failures.

Also make sure to pass "-N" to netcat to close the socket after EOF on
the client side, otherwise we would always hit the timeout and the test
would fail.

Without this fix applied:

 TEST: GREv6/v4 - copy file w/ TSO                                   [FAIL]
 TEST: GREv6/v4 - copy file w/ GSO                                   [FAIL]
 TEST: GREv6/v6 - copy file w/ TSO                                   [FAIL]
 TEST: GREv6/v6 - copy file w/ GSO                                   [FAIL]

With this fix applied:

 TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
 TEST: GREv6/v4 - copy file w/ GSO                                   [ OK ]
 TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
 TEST: GREv6/v6 - copy file w/ GSO                                   [ OK ]

Fixes: 025efa0a82df ("selftests: add simple GSO GRE test")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/net/gre_gso.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/gre_gso.sh b/tools/testing/selftests/net/gre_gso.sh
index facbb0c80443..fdeb44d621eb 100755
--- a/tools/testing/selftests/net/gre_gso.sh
+++ b/tools/testing/selftests/net/gre_gso.sh
@@ -116,17 +116,18 @@ gre_gst_test_checks()
 {
 	local name=$1
 	local addr=$2
+	local proto=$3
 
-	$NS_EXEC nc -kl $port >/dev/null &
+	$NS_EXEC nc $proto -kl $port >/dev/null &
 	PID=$!
 	while ! $NS_EXEC ss -ltn | grep -q $port; do ((i++)); sleep 0.01; done
 
-	cat $TMPFILE | timeout 1 nc $addr $port
+	cat $TMPFILE | timeout 1 nc $proto -N $addr $port
 	log_test $? 0 "$name - copy file w/ TSO"
 
 	ethtool -K veth0 tso off
 
-	cat $TMPFILE | timeout 1 nc $addr $port
+	cat $TMPFILE | timeout 1 nc $proto -N $addr $port
 	log_test $? 0 "$name - copy file w/ GSO"
 
 	ethtool -K veth0 tso on
@@ -155,7 +156,7 @@ gre6_gso_test()
 	sleep 2
 
 	gre_gst_test_checks GREv6/v4 172.16.2.2
-	gre_gst_test_checks GREv6/v6 2001:db8:1::2
+	gre_gst_test_checks GREv6/v6 2001:db8:1::2 -6
 
 	cleanup
 }
-- 
2.32.0

