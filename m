Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041F772A06B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 18:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjFIQn4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 12:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFIQnw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 12:43:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F1B3A8C
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 09:43:49 -0700 (PDT)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 30EEE3F18A
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686329028;
        bh=bcQsjAMHkUSKApX68ZuYeihjuMej/C2tdQeqg1IYyqk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WN7X8Otwe4suha9jy/rgf1uUshqQZzimPp31tySHzLM0fD377AT5qHRhLEIn/4cgn
         P+FN61YaLUxSLLPg4g9Beosc2ymCC2IwYGwcFzQ3QjHQqwZWRCrhuYe8I2cZ84s1py
         YSB+OAnrb08f8Yledo2JA1frDfoR2A3Xs3N8EaEzIcpYuKra7Ub8q0S571tX6xmMLZ
         3LtfLTwvVK0X1Jv7xzc0rYxs+LDz2UeudnsBJqYbRtYo3DMuX/kASFptQmy4YA23Rb
         cbaFzoj4lmikHBYJa2k68AwYqb9ayrViOueL/MqvI7fVJhx6Mz1wagEYcMifT+8RLu
         FMADzMlWPAotw==
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-55b36aa3f61so1635118eaf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 09:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329026; x=1688921026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcQsjAMHkUSKApX68ZuYeihjuMej/C2tdQeqg1IYyqk=;
        b=B04fQ/Mo1YQQgtduP2r/wTC4+U3OesBSwrniLegDG3VpZ2f4G/CA+nkiVkMYPUDxgP
         JhNrrQ2j5HSmesHP0WOlNuKtKVgYoDsXHGrfEYhyXskO7wepxL6PARp+e0Z0RSkJjLuq
         A2WsUl2jpD/GCBekSMqc3TAr0TYTwniFaTyk4+4hSVFpn0vt3PHfbqXU6aQfypiQG3Mc
         V2WkjjGKwUrQF7kqCejmmQEA4JTabOfDiOBZqDPI3TQ3oIm9BMPnsa/o6dBp4dGr3fEs
         +0jWnJNLXYl65YyjhA80HDV5ieKrpJivvsFSijTtQa4+F2psGZ8hfOvOzckBlkOwt1pi
         V14g==
X-Gm-Message-State: AC+VfDx5W4xBAqO0Lu/VwwamrzfP74DB8GbvfIk0v1rZfZvYOkMxI4xO
        uYwOPYMp09Rma0eO/3K/RmFsfTuSJlLGrYczPsjva8RmJ+aeokcwNBRjm3iDjCnqMXl4JvwUwVs
        9Hx9VAVrZExzdb7HmxuydBnLQcXzJ0+fs3cMS6E2wZniv5A==
X-Received: by 2002:a05:6870:d8a5:b0:1a3:5bb2:8e98 with SMTP id dv37-20020a056870d8a500b001a35bb28e98mr1489051oab.47.1686329025950;
        Fri, 09 Jun 2023 09:43:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UB4ZzJdwHORXrTeXhKVpTBySccm2pIJnH4b0ycLeDnxw0Yx/fCbGcBs3FEC93LCefV2pmrg==
X-Received: by 2002:a05:6870:d8a5:b0:1a3:5bb2:8e98 with SMTP id dv37-20020a056870d8a500b001a35bb28e98mr1489044oab.47.1686329025687;
        Fri, 09 Jun 2023 09:43:45 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:db64:8f3b:3c73:e436])
        by smtp.gmail.com with ESMTPSA id g17-20020a056870c39100b001726cfeea97sm2360707oao.29.2023.06.09.09.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:43:45 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, dsahern@gmail.com
Cc:     andrei.gherzan@canonical.com, David Ahern <dsahern@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] selftests: net: fcnal-test: check if FIPS mode is enabled
Date:   Fri,  9 Jun 2023 13:43:24 -0300
Message-Id: <20230609164324.497813-4-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609164324.497813-1-magali.lemes@canonical.com>
References: <20230609164324.497813-1-magali.lemes@canonical.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
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

