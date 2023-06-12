Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE4072C507
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjFLMvz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 08:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjFLMvn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 08:51:43 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564C3171D
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 05:51:34 -0700 (PDT)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F04E3F377
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686574293;
        bh=omMsUqmf+wDARTSBLeWKvRxM4zligfqqpbMttBMt0pg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UA/fdTTAIioDD+O770I8naogOwvF/EA0aLYblU1j+xnd6Z1Tj5UqYXMsJ/eShk1/X
         D13BJQ4A8RMETmWj0NJYefoaCrhikX5Ygov0W1zmEidfrS9q8BjabQEe/6LR6WZNza
         Ob36v2TOKP8ov88b1BxBbcCodNuGGOT07eIyBByBtpkX+DwaIKJCGmiEUkqUMft1r/
         u+ylTox6X7SrBCyZOqgL3hwvIaMFRZ7MLkZD8mjfzSRBLSpKgi67HEpf67QFK9+WXW
         u7hreeTeFeHdqGHLR/3ZBb76RYD+jQ1QLX9LPcfu5bHqkmBnTIgHgs9iRpSUe5qgEe
         R84EcMbX9VLVw==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-55b3fe7a7f4so2850449eaf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 05:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574292; x=1689166292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omMsUqmf+wDARTSBLeWKvRxM4zligfqqpbMttBMt0pg=;
        b=A9GsOQMhOyEO8wQ5Q0TF5y0ooUeA/jrtCUwJ0rkm8mbw1Fg4stwGYw8XmKDS1Ucya3
         emX1aNL2hP2CDGRj3nWDn30YL1spVxyCKRYNrnTnh+p8yNdxO1GUapNIN72PjRm35Md+
         saA7H8a5igg3TGCUJazK8Xqp64hKAXyv1EeRckOknsD+g0YophrbsJfJ0PSX5ELnJUOB
         UsE7OSV40uPvSpqceRSaBx4CyJ6ZkOYgNIEbqYilse+fYdp3xcBI7olSNadRAOOQTI5N
         KkAY6dREH2z6nht7UAXThVz3eF9CO0Gz92Dfm0DAgEaSHQ6dv4IpkWg7FTDFv0jFgKvg
         O33A==
X-Gm-Message-State: AC+VfDxBQ4lNc0gD8SIxjcqZ4MQ/zwSZtzrGYwnQjOWgDkVVziayMoKF
        ViFFJhumBLplIeEsCO8vCkHTL80qA2crCrJ+BGy3IExV4pBUyniMRAzb87LqP+iBkiR2j+P3xVB
        zswr2TOT9e9ugpDKhe9EREhi9IpNdC9b/qDXNeiylSjHqtw==
X-Received: by 2002:a4a:dccc:0:b0:54b:ce85:490a with SMTP id h12-20020a4adccc000000b0054bce85490amr4906215oou.0.1686574292103;
        Mon, 12 Jun 2023 05:51:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zLTOWJnv96ffTmwdgO+vzkEG8P4Mwm7wW1mYTKkUTXLGwXHNy9GMezl/BTJdLH++Nny4/Vg==
X-Received: by 2002:a4a:dccc:0:b0:54b:ce85:490a with SMTP id h12-20020a4adccc000000b0054bce85490amr4906211oou.0.1686574291870;
        Mon, 12 Jun 2023 05:51:31 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:d612:b95d:6bdc:8f6d])
        by smtp.gmail.com with ESMTPSA id j22-20020a4ad196000000b00529cc3986c8sm3157193oor.40.2023.06.12.05.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:51:31 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, dsahern@gmail.com
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] selftests: net: fcnal-test: check if FIPS mode is enabled
Date:   Mon, 12 Jun 2023 09:51:07 -0300
Message-Id: <20230612125107.73795-5-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612125107.73795-1-magali.lemes@canonical.com>
References: <20230612125107.73795-1-magali.lemes@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

