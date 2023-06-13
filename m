Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0288572E316
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 14:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbjFMMc4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 08:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbjFMMcw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 08:32:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942812A
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 05:32:46 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 737283F26A
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686659564;
        bh=s8oiugOPYK9Dhcf05PcUqQ0uJRqSYmL//F/FBXFcDYU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=abF36MvdrnPVD0tJpxet2GZaenk5pplCvD7Z8mQ1DzWIl14aBwN574oR4jWOydBUE
         IwUrlTaPwtZ99u8RWYYYCY+WpIq/2y12znUjq2nHxSzklelBJsYvsxEf8mIUdf1x0y
         WLjGvdlJZkglaH/bMzMEpQFdk7BJxCxUljwej04vFeWWp9iHOEtzyhme5mC+VcKbqS
         RCV35bF3EJn5BIL9tQWQMmbHcNL3VoRVoGF7q1hyZQggi0ZV121sM8952y76XR+vi4
         hMlA2vKsFA5X5eJnY5p65W3agJ2Hor8FmB0ImA6LGGbvmwa3rDv1ukoXiHF9p/Qvrk
         Kmx/lSrjAit8A==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39cd7644d31so2056518b6e.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 05:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659563; x=1689251563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8oiugOPYK9Dhcf05PcUqQ0uJRqSYmL//F/FBXFcDYU=;
        b=AtL89baGmJ36d7v8ZUmIayjH81cNaNGKNJ6rsIRFcbrGhQ2pBQ2XJew8zgid77M1+6
         CpNYS65nO6hmGCaDrHqAeWvPyRAjb00wqpAsBei6weCVAgSvWKB7P24fe2lBSNZ/ncJM
         SkDl4xXZiAV+hL6JE04gvyTeUF0rnGU0TpS8aAyEL2gRammK49+oljeCOdolvTV1iFwU
         ZMFDOMG0UWsbI8SMEYPxuvZJeL3abmfARX/3sg5odgfbJ2BfZsj88osJpORzxJ+z71WP
         nKeUziXPFi7/iZZsOa9hfwme07FvhZwxkfKxuXuDVyyoTmlik48Kokbckf0xTKRbivWU
         tX3Q==
X-Gm-Message-State: AC+VfDyBpogbvcLMZgYHvaEw3fULtSllybV3kPEDVp/+hLMVKA3KnUU5
        iNQcuGtcfGFii/23awcHEUtGxr2GEFLmrkSH3LsILfQvmdfeEXYyIqccKyBlf0tTq4xUB9x9dFa
        z/fVUzkKbInUDzKypSUDAMUZq57yuMiWfZce0wxmJop0G0w==
X-Received: by 2002:a05:6808:2029:b0:39b:8f0c:3936 with SMTP id q41-20020a056808202900b0039b8f0c3936mr8877793oiw.27.1686659563353;
        Tue, 13 Jun 2023 05:32:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76ZZK3YPGukqTaHOoEllIrqdQ/1dfxoxjqq/bifAMPKB0UdD1asUrpytepcx6C1urVcEQYcg==
X-Received: by 2002:a05:6808:2029:b0:39b:8f0c:3936 with SMTP id q41-20020a056808202900b0039b8f0c3936mr8877775oiw.27.1686659563111;
        Tue, 13 Jun 2023 05:32:43 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:ac1a:e505:990c:70e9])
        by smtp.gmail.com with ESMTPSA id z26-20020a056808049a00b0039c532c9ae1sm4838116oid.55.2023.06.13.05.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:32:42 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, dsahern@gmail.com
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] selftests: net: vrf-xfrm-tests: change authentication and encryption algos
Date:   Tue, 13 Jun 2023 09:32:21 -0300
Message-Id: <20230613123222.631897-4-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613123222.631897-1-magali.lemes@canonical.com>
References: <20230613123222.631897-1-magali.lemes@canonical.com>
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

The vrf-xfrm-tests tests use the hmac(md5) and cbc(des3_ede)
algorithms for performing authentication and encryption, respectively.
This causes the tests to fail when fips=1 is set, since these algorithms
are not allowed in FIPS mode. Therefore, switch from hmac(md5) and
cbc(des3_ede) to hmac(sha1) and cbc(aes), which are FIPS compliant.

Fixes: 3f251d741150 ("selftests: Add tests for vrf and xfrms")
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
No change in v4.
No change in v3.
 
Changes in v2:
 - Add R-b tag.

 tools/testing/selftests/net/vrf-xfrm-tests.sh | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/vrf-xfrm-tests.sh b/tools/testing/selftests/net/vrf-xfrm-tests.sh
index 184da81f554f..452638ae8aed 100755
--- a/tools/testing/selftests/net/vrf-xfrm-tests.sh
+++ b/tools/testing/selftests/net/vrf-xfrm-tests.sh
@@ -264,60 +264,60 @@ setup_xfrm()
 	ip -netns host1 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_4} dst ${h2_4} ${devarg}
 
 	ip -netns host2 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_4} dst ${h2_4}
 
 
 	ip -netns host1 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_4} dst ${h1_4} ${devarg}
 
 	ip -netns host2 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_4} dst ${h1_4}
 
 
 	ip -6 -netns host1 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_6} dst ${h2_6} ${devarg}
 
 	ip -6 -netns host2 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_6} dst ${h2_6}
 
 
 	ip -6 -netns host1 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_6} dst ${h1_6} ${devarg}
 
 	ip -6 -netns host2 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_6} dst ${h1_6}
 }
 
-- 
2.34.1

