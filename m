Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA5A72C506
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 14:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjFLMvt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 08:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjFLMvl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 08:51:41 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D51A1709
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 05:51:32 -0700 (PDT)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 49E113F4B3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686574290;
        bh=9WA1GnTKde4fTKucBDNJJp1kdZH51ghqRlq/wPSryAw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pxZ3WHoGBgraAbMu4KSPBKHD6VDxmJHOm33spjJLz+ZQbaQnWHQ/Ja818bv+3zKdu
         pkAYBOEeXjEx49fk9jVw5FYtJ7sVyVNlN48fAuiqTKJGd5fLWSkPW0NPLX6M9PPcyd
         fc2jfUO7hbqn4L7X83j5Cfb71RebOeFMN4bEs4KT+pw2B9kzR+/RJYMrQVbEpH+4fb
         RyhSi1JDe56/jrNMlr8QQqNQtOQnVTChSJhTMHkWVE/gl1vssmuzOwbFeFYmjgywlN
         0dHvfR/VRrGIPLHB8Q82Fh3YDPscysWCLbQktB8ml7xWftrYDFxSjdtoSg1aldqNpg
         O3jHIEFk+hnHw==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-19f97a46598so2139230fac.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 05:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574288; x=1689166288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WA1GnTKde4fTKucBDNJJp1kdZH51ghqRlq/wPSryAw=;
        b=ljnYoVOUBYGBI6QPwDhRygJCWFq3HVcSSkalgoWM70xV2qPXLKVNC4AjtbmdU1dKcC
         K32kOfpxvPs+EfVKW+wMfETF/KXJxlB/Ox63u88A3dgZHv6ywT6vCXn2emlVbJunYpZ3
         KnEIed+Emuukj0QFIx4a7o78diZviCNz1OGvMjmJhqnl7qbPuc5dwpWeNDPLGsGSv0Ua
         XS9aOFVc29UvyxpmZanHnJx0WaLkzkD/p9HcAx5Fh7udtlgUhZsicrCwblzEopLWrAAH
         Iogs4tAiyYGGYbXU3nUomUgNBfdDqoRHhq5xXbSCRAeqBxDUS/4usOUXIOjbmugteCqO
         +KZw==
X-Gm-Message-State: AC+VfDywtAqEY+lfYHiQkuP9E5fGaPKCTGxa2OecRK1fhQePoLsNRryq
        mbt3uuCEGYKS/crgDKttRm7VflHnuQvI/DPeQsD6IbNnIj99cKMgOi3n4FzBNha0S4oHH8erTMe
        OEQIu+0ph1vFdeQL5E3Spl7bJlAExyqW9+ZpFQ5n+r64B1g==
X-Received: by 2002:a05:6870:6256:b0:196:8dc3:4e16 with SMTP id r22-20020a056870625600b001968dc34e16mr6011824oak.39.1686574287735;
        Mon, 12 Jun 2023 05:51:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zWRS7ZviV1sYFayuCJ8VhSxwjQK/79tiCchsPFEkiZDfJBlJWhoUWPx7Bd1s+FgghYjeJMw==
X-Received: by 2002:a05:6870:6256:b0:196:8dc3:4e16 with SMTP id r22-20020a056870625600b001968dc34e16mr6011809oak.39.1686574287496;
        Mon, 12 Jun 2023 05:51:27 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:d612:b95d:6bdc:8f6d])
        by smtp.gmail.com with ESMTPSA id j22-20020a4ad196000000b00529cc3986c8sm3157193oor.40.2023.06.12.05.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:51:27 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, dsahern@gmail.com
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] selftests: net: vrf-xfrm-tests: change authentication and encryption algos
Date:   Mon, 12 Jun 2023 09:51:06 -0300
Message-Id: <20230612125107.73795-4-magali.lemes@canonical.com>
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

The vrf-xfrm-tests tests use the hmac(md5) and cbc(des3_ede)
algorithms for performing authentication and encryption, respectively.
This causes the tests to fail when fips=1 is set, since these algorithms
are not allowed in FIPS mode. Therefore, switch from hmac(md5) and
cbc(des3_ede) to hmac(sha1) and cbc(aes), which are FIPS compliant.

Fixes: 3f251d741150 ("selftests: Add tests for vrf and xfrms")
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
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

