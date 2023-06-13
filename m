Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4E72E31B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbjFMMdL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 08:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242047AbjFMMc6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 08:32:58 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22071BD2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 05:32:50 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DCA153F26E
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686659568;
        bh=kHrI60HGgHX5jqkZGeWx9fzAxW6E9mR4OgwfiGnOAxQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=f96N9CTyEtccicTvrNigBS2XUDX38lk3vIKEGmA1ZN5AsE/2NIa/j0pkn+GpilFmm
         V1nnLeNKigedgfSeIsp8BaWomB0UPJM1h5fi2qe0EAnK9OMevqMKtm50e8uY3NdN9E
         Pxl+TgGYq05RMf9k4Nm7c3Rr74fgAieHNNx3iwyh1mgkqvIg3gBchCYQdFW9LpKTGj
         MHZie8LNm9Vl1dcNGdzivsYVwGBaNqBAJSBt/1aIhhj/+AAcMo3LyQoO9H7V9VG4O/
         Sr/r13QghqAvW3L1G7k0k6MlpyNjMDv7yHg5YDKeB1L8Ix9SnxZEHHLNToUsMQ/7q4
         1xUV6F5Zf05bw==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39aa9617c6bso3380054b6e.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 05:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659568; x=1689251568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHrI60HGgHX5jqkZGeWx9fzAxW6E9mR4OgwfiGnOAxQ=;
        b=YouzCpyO8+mcQEPOhz0vKhWFmxFIql4Vzhnkfv47nVm/dYYAfSMGYqSzIeorZPsVYg
         f9m8iHIrQnYtQkk1DVdJW2ixp6/w6oV5TDFIAOWOTXplka2Fe2jgvaJf7uL2DDidCLrj
         Tcb9kVaezs8a+9K72ugXhkevEfSWvlXs60PgZHE8Y1VHOuo9u+3pP+tFkX3IxqnJInD1
         DK1u1Kv7Unwm97b4XKrQGH1WTNV+4/yLdOV4h7icEZK1dz+wpxSz51S8Sb/yqJhHs7iZ
         fx+wk4DgspH4IqeoxjhKB/Vngd2ivX7pndK+Ya0aWbwDX+SaMN4BGOXuETAWkihbkCHw
         WqMw==
X-Gm-Message-State: AC+VfDzTyFHC4klHV2OOpyytKFi6H66q5tICJ813H7YqKvkMPiz8w84n
        TTMz60/rB9gtdwIeQs8vGEgCZjh66Yo/zaF2s8umy/UL9ncFTl5JF8Diu7UHP+sKJGoTtF0TWjR
        O6MQhKUS/4jKrRXhzd0GNAQEwITPNm1/q/3/NE2wH0Gc7tA==
X-Received: by 2002:a54:4808:0:b0:39b:7ba7:bd1e with SMTP id j8-20020a544808000000b0039b7ba7bd1emr6763077oij.11.1686659567824;
        Tue, 13 Jun 2023 05:32:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OQeh1b10s7ZGLTmJ0pP4jyvk53jHubefHpSrwjFFh9fL4c+WcRZ7ueDOIk1giyyKHQPXWpQ==
X-Received: by 2002:a54:4808:0:b0:39b:7ba7:bd1e with SMTP id j8-20020a544808000000b0039b7ba7bd1emr6763057oij.11.1686659567593;
        Tue, 13 Jun 2023 05:32:47 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:ac1a:e505:990c:70e9])
        by smtp.gmail.com with ESMTPSA id z26-20020a056808049a00b0039c532c9ae1sm4838116oid.55.2023.06.13.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:32:47 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, dsahern@gmail.com
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] selftests: net: fcnal-test: check if FIPS mode is enabled
Date:   Tue, 13 Jun 2023 09:32:22 -0300
Message-Id: <20230613123222.631897-5-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613123222.631897-1-magali.lemes@canonical.com>
References: <20230613123222.631897-1-magali.lemes@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
No change in v4.
No change in v3.
 
Changes in v2:
 - Add R-b tag.

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

