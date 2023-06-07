Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59E57267A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFGRnc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjFGRn3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 13:43:29 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65521FD7
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 10:43:27 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 30D583F1D1
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Jun 2023 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686159804;
        bh=29oAQXm1vubqWw6n+W3ki/F3nkC70PmxLYid2aXxsMY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JqMc/SXTQbCtI6T704W/CdgiNpjSwaWFgDjyAU4DsrKmsS9zxOMN7K1Qh5AhJfeKQ
         UjS1T91fv8qGjKSZE+p8F/nBUBkLEp7EAswgBNSSzc+lST8ODntOHxev9mwVs4yak+
         9Dv7PG+fYgckDB0EA6sRJCL3wsbgL1HBfwkHq9vnGr5rgQ4dQvhv9umlNCZHhKQrkr
         Kuye1A5GUJTXKO6GqjjLIEG9yTC1mWzyhYBG4DPI1TL1UKA8rKcD3ABT5TFCVCL8By
         E4rY25Z612Tuvxbu4JPy2GIZ24+GVIdu37I7x13+CGgbReUXCB6ZoZGs1l03PVa+ie
         /k1y2+Rv/cx+A==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-19f1f3aaae6so7296836fac.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jun 2023 10:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159800; x=1688751800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29oAQXm1vubqWw6n+W3ki/F3nkC70PmxLYid2aXxsMY=;
        b=MBELOzBy5Q+B5QVf4BST+awyDJpKtX998URwpyAVE4jDeDQfbiHw/3GYl5kQkN86mf
         Hi15cxqmcHShPAGDl1ktGpMQluuiW9+r1ijSrNGbtQdOOZ9LEj62kcSxBtgOITOIVEYF
         Tm7gNeIJJ0iXyy4ptBkj6EfS8fod0G4CX/JO0ZkfQIG2P8UUnc61aromZGEq4ifnBPFk
         yGexCppg2+1tKQKHf+5CZ41V94lwEin30Qx2BWndcqhgGxWHDgxW8npjkItyHGjZpC43
         Ny3334xfkIsajs4RE5m2jcjmyb7MnOzqwBt3X8G3JfGwpJyuiBKbTRzAWiCGFfA8Ogf7
         CrxA==
X-Gm-Message-State: AC+VfDxDkYAxvfUaPZh+mJcBOBKQDvphWGfhEHQ6HWgwQGtz4/8it5Ia
        AnxwjwPNBaNyzxdHwICjxzxlJPUST22u/FzoeiZZvSgKKz3tADFaItGVjf5OHYqhEa8LcM7t9aJ
        Gb1Qbk5KgKwoUOYWkSzpjsiJv/5QIv4kj2I1yqvR6IffIqA==
X-Received: by 2002:a05:6870:d343:b0:1a3:b43:9c88 with SMTP id h3-20020a056870d34300b001a30b439c88mr5870242oag.34.1686159800625;
        Wed, 07 Jun 2023 10:43:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ766oAJ56zMbU7HSmkwtI2C3rOqyJHM8UGEwfRspDmam1gxj9T7PZk5HFQWFzUo+t+bKzFXUg==
X-Received: by 2002:a05:6870:d343:b0:1a3:b43:9c88 with SMTP id h3-20020a056870d34300b001a30b439c88mr5870234oag.34.1686159800416;
        Wed, 07 Jun 2023 10:43:20 -0700 (PDT)
Received: from mingau.. ([2804:7f0:b443:8cea:efdc:2496:54f7:d884])
        by smtp.gmail.com with ESMTPSA id c10-20020a9d75ca000000b006ac75cff491sm2176016otl.3.2023.06.07.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:43:20 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, dsahern@gmail.com
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] selftests: net: fcnal-test: check if FIPS mode is enabled
Date:   Wed,  7 Jun 2023 14:43:02 -0300
Message-Id: <20230607174302.19542-4-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607174302.19542-1-magali.lemes@canonical.com>
References: <20230607174302.19542-1-magali.lemes@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are some MD5 tests which fail when the kernel is in FIPS mode,
since MD5 is not FIPS compliant. Add a check and only run those tests
if FIPS mode is not enabled.

Fixes: f0bee1ebb5594 ("fcnal-test: Add TCP MD5 tests")
Fixes: 5cad8bce26e01 ("fcnal-test: Add TCP MD5 tests for VRF")
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
 tools/testing/selftests/net/fcnal-test.sh | 27 ++++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 21ca91473c09..ee6880ac3e5e 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -92,6 +92,13 @@ NSC_CMD="ip netns exec ${NSC}"
 
 which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 
+# Check if FIPS mode is enabled
+if [ -f /proc/sys/crypto/fips_enabled ]; then
+	fips_enabled=`cat /proc/sys/crypto/fips_enabled`
+else
+	fips_enabled=0
+fi
+
 ################################################################################
 # utilities
 
@@ -1216,7 +1223,7 @@ ipv4_tcp_novrf()
 	run_cmd nettest -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 1 "No server, device client, local conn"
 
-	ipv4_tcp_md5_novrf
+	[ "$fips_enabled" = "1" ] || ipv4_tcp_md5_novrf
 }
 
 ipv4_tcp_vrf()
@@ -1270,9 +1277,11 @@ ipv4_tcp_vrf()
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
 	# run MD5 tests
-	setup_vrf_dup
-	ipv4_tcp_md5
-	cleanup_vrf_dup
+	if [ "$fips_enabled" = "0" ]; then
+		setup_vrf_dup
+		ipv4_tcp_md5
+		cleanup_vrf_dup
+	fi
 
 	#
 	# enable VRF global server
@@ -2772,7 +2781,7 @@ ipv6_tcp_novrf()
 		log_test_addr ${a} $? 1 "No server, device client, local conn"
 	done
 
-	ipv6_tcp_md5_novrf
+	[ "$fips_enabled" = "1" ] || ipv6_tcp_md5_novrf
 }
 
 ipv6_tcp_vrf()
@@ -2842,9 +2851,11 @@ ipv6_tcp_vrf()
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
 	# run MD5 tests
-	setup_vrf_dup
-	ipv6_tcp_md5
-	cleanup_vrf_dup
+	if [ "$fips_enabled" = "0" ]; then
+		setup_vrf_dup
+		ipv6_tcp_md5
+		cleanup_vrf_dup
+	fi
 
 	#
 	# enable VRF global server
-- 
2.34.1

