Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEC276EF64
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbjHCQ15 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbjHCQ1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 12:27:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9184B30D5
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 09:27:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d20548adso987394f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691080070; x=1691684870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwyK6Bv+hcPMKxglSicH9Zo5rWGFycFOmRoBBrYBtwk=;
        b=nVf5cpBl66aqIXNE9mp7PBpSn04vjQNBytFglp9n2PJUdgGvMIzyOBlFIDx55z2c6l
         UosZjIiqUTd4VJvFp+uC+8TkKxdQsrmyBnxTKHR+YVA2qKslZbbVBxVitvUFvAFWowm0
         kegzR5vljiqloxiO08YNKk4DDnaKhbm0uhF5+fbUMrP0o/kXkMyqz9Ubv21Bb5RXAC5H
         cuw2D6wv/55bIM/wJZmktecljrhqnM0S3DPU51xaFTkEAP90FnPfPqbX+FwVmU1Z0DfP
         OcQ0xEXjVkZzzNIdbonGT+WId15gota3ge8Trxl9yR0k7FitTMA8eph3JqeJx7SAOMT8
         99BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080070; x=1691684870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwyK6Bv+hcPMKxglSicH9Zo5rWGFycFOmRoBBrYBtwk=;
        b=XzppLqnXiYaLjs9KO5pII3VR4NcL59J8Nd6hQBu4LPD9bQZ4PxX6TZm9A6q1F0vjFm
         M5m+d7OceF2MEHFWweeaAOQQBIGXW3E3WSElvQfOxr4GRmq5yOAmMMUwCZNqUZBJNWyy
         tP3mjesS+oTsileh0lTWdqb1/xwfbSNPvgWv3qzFjK+oCwd1eCSh/onV1NcbmwutlLaw
         ifW21a852KwzzVmFCOjoJmopLU0vrLGMkzDtvF85AtUejsBXa6RIHUA7xMbkTxinZLTz
         4NRld7UpZraGtCMIDSBbWFMkR2vJ7rdsv4QaUxH8h1frUyFoJO7qmsFLcviCCvSKrlMX
         u7rA==
X-Gm-Message-State: ABy/qLZpq3sJm1s/yYeBhlmdb4CoszIe+KeFmzjzEa8c0EVjMkjm7P0k
        F6QgVayJxjgiKIXmPuRPtrVWXQ==
X-Google-Smtp-Source: APBJJlF3FZ/eBbFsCggo3JU70+7C7vjjNVaKf5HzLiG7UsMnz2F0AveDgWO+kWMUbv1rfJo/AfF75g==
X-Received: by 2002:adf:fdd1:0:b0:317:5b76:826 with SMTP id i17-20020adffdd1000000b003175b760826mr7797679wrs.0.1691080070157;
        Thu, 03 Aug 2023 09:27:50 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm253167wrs.30.2023.08.03.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:27:49 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 03 Aug 2023 18:27:28 +0200
Subject: [PATCH net 2/4] selftests: mptcp: join: fix 'implicit EP' test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-2-6671b1ab11cc@tessares.net>
References: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
In-Reply-To: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=wrR2/gFZisIGtMW223yr33GlqCWjTT9hge1zs/IjHvs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBky9WCE7AUwHgx0yv1SzE8nz8k4s8zOOsGud318
 c9InvFUPBaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMvVggAKCRD2t4JPQmmg
 c9IFEADaaMgin0SaKj+n8cG1OGpW22NLO2EpUY5ZnXx3FXU3uRGomjXOkfZO+n3iLbt5DcJ2KpJ
 dbgxpG3JYbEyzI0D7nXIfAnrZMbOOtv2FG3pZYOi03BONYWwlUIEr3wXiugnFsYKusGC++aVcAy
 37/thitzAnldc1Hih0il6WmMSbbOo7//l1ZT6QkoYzr521Ng0JMV7OmL27UCC34Z2/kyxa/kEg6
 nM86St3sAWSTCayygA3zKZYfdickJ7xwTi6rwJwe4+yCH4C7lmT2wmTFqpS+6m0w0ZeX9dxHnP+
 wltj5XiQqAxIduxAc2wiEaQ8HMDx/xny+XiF3Prhge9cxbCxtSW/fUhW2RPlqlHZ0VffmebbTJ+
 6e4uw9IPT0qBDRa2kiMfmUAalyDBdYkO5QvpexHrOEt+eI42lI42tJ4yTS7tyoSFjE9sMUdiv3i
 n2uHj/8JDQu5X6WbQhBkaaN1NCPb0Rl9ruUPYH8V+EyWOGciL+CJITM5YdnftppRjZKg/pbE03d
 P9AXCC8zxFKzsumUzuPl/sMzBOtjkiwe+cxzNiwo7cQ5wpYx4lygSGm4qJMK11U7BP5vkzXSjib
 ER/U+4UGoQNZWv2L5d/hvzBpsMVD5RiNcyHRyKXQPlkgP9rAgbcFfN6dLSf4tNZ3+m2aJnbKj5l
 qIJsOUy1VR9loaA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Andrea Claudi <aclaudi@redhat.com>

mptcp_join 'implicit EP' test currently fails when using ip mptcp:

  $ ./mptcp_join.sh -iI
  <snip>
  001 implicit EP    creation[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
  Error: too many addresses or duplicate one: -22.
                     ID change is prevented[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
                     modif is allowed[fail] expected '10.0.2.2 10.0.2.2 id 1 signal' found '10.0.2.2 id 1 signal '

This happens because of two reasons:
- iproute v6.3.0 does not support the implicit flag, fixed with
  iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
  flag")
- pm_nl_check_endpoint wrongly expects the ip address to be repeated two
  times in iproute output, and does not account for a final whitespace
  in it.

This fixes the issue trimming the whitespace in the output string and
removing the double address in the expected string.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 067fabc401f1..d01b73a8ed0f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -796,10 +796,11 @@ pm_nl_check_endpoint()
 	fi
 
 	if [ $ip_mptcp -eq 1 ]; then
+		# get line and trim trailing whitespace
 		line=$(ip -n $ns mptcp endpoint show $id)
+		line="${line% }"
 		# the dump order is: address id flags port dev
-		expected_line="$addr"
-		[ -n "$addr" ] && expected_line="$expected_line $addr"
+		[ -n "$addr" ] && expected_line="$addr"
 		expected_line="$expected_line $id"
 		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
 		[ -n "$dev" ] && expected_line="$expected_line $dev"

-- 
2.40.1

