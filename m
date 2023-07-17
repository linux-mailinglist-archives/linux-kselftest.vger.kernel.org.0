Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EBB75647C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjGQNWG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGQNVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8239D173E
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so27662125e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600096; x=1692192096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kr2AzBRfYACYia6y2Av8CufiUUfBunWf8ETFzPluqvU=;
        b=H5/mwHbEYNveDOqdlUX0cUL3i7qHKpCwbOpxgZ46I6qOOVZW4XwSHyM4RDeGw98EHJ
         Oajx6JR8P9VD4UzjFVYulv2jt6Htvgwk64G/87emrTSOGQMny0npddW+23IUCj2EZj/X
         aH1cKjEuDeN1gCAs1IglD4zTAAHknSr0NGrbyz2FGP06FWmv6/+4xKo5Eth23SIhdqLG
         ku7RpqG90Oobqtu7/6xHUoTKCtyTD/0TNvU/ROz48FqBNPSyuHqBKvKVq2rVCcLI4U04
         UGvny/RZ84Aip8e3ui5hkWKpuceILHf3KPZO2c3mnT6bXDjPAfdj5/RtRneZbsTC3Xvh
         4kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600096; x=1692192096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr2AzBRfYACYia6y2Av8CufiUUfBunWf8ETFzPluqvU=;
        b=DY6+e/6KwyXx0vNNaAeve3yuvzm0LesLfXtXIOdToC1w+trGovJuKyvtoq7jA1XbO6
         qD0p3oQSBM2LsOhLFn7GdUxo2Cd/vdm7KqeHHUoLoJ+Q8QHyfpQNpn5bFJ47ZbX4TiO/
         CudKwESqzjw3UFaSWetbWhocKbWxud36HmqUc2nuxq9Xcc2fAYPPQF4FDF0BCSdfXujf
         24ONZikkSMVyG4dg37YDF0WY+sbyUF4CnytwBcZ7FL9xxHFzcaJsdZQTCnon9kFfdTaZ
         nYv3aWVv5pH+h/zvtWeGFXQWfXFgsuD7CwvLtwSRqeWjthQH0cYj/guvZjP3E6g9Nlly
         3yag==
X-Gm-Message-State: ABy/qLYWZzNuAxbgHqsAcMOX9Cp5jE1GsLdj2bOwND3Ysr/m2i9pEZm0
        sZYZ8Qa8bzrSECX0hhm7sf9pBAJQ6Eysoe62X57R6g==
X-Google-Smtp-Source: APBJJlFYICsMft+WcGkxINI+SI/Oi7NTF3hfmg6XpnY8a3HX2GNoV1DIs6tJYPZB94/e2Nrt2b1Z3g==
X-Received: by 2002:adf:df88:0:b0:30a:e70d:8022 with SMTP id z8-20020adfdf88000000b0030ae70d8022mr8114781wrl.26.1689600095802;
        Mon, 17 Jul 2023 06:21:35 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:35 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:21 +0200
Subject: [PATCH net-next 01/13] selftests: mptcp: connect: don't stop if
 error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-1-695127e0ad83@tessares.net>
References: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
In-Reply-To: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=BZbHJ3Y6ueyONCNTSrZvU0X5fH4lC2FRHHi4A5I/Hx0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdaLCz2MpRc8eRh4gcle2c3UnBb8uCuhf2z
 VDiX1GNkkeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 c790D/wKpOoEy/0ACxy4+pHyNhiv2mFoHysOXWvMUxHm10XxfUHDaZSC/9uYH4KTTdOTFChu1Rc
 2ACe7/Avf8Uy8uPk3vlHgC14T5lXIm0ksebCy03pPqJop4UpSbbcpG090XS9hY30BrFrXb2fbuK
 43DSvauxBrZjlCCdPt+8m90t5s/XUa5HnuIwgAXrYL640WfCcFuzeeL5wmX/sQnjYuD7TUfVkeA
 TYU+8Wu8nPglOItk3gURt1irR2rs9+CZKtWm+iAb9ZpNICXCQWrh6tRrhHMkgWr0pJI0/2Yt8R6
 uYtmVd6NRHbc/xjOfet7VyfMqGfKkc0vlrf73gaWKYtCbnjTQnVI8qPIY9nGeUDmPtfabiNBu6F
 +ix6KPKAdi5rPQV65qkdCTRMRKAXu87VRFBHHn8sgjxMgiGpnfT005httgGcSBAh55/4g6qeekI
 kllCvKgWCRbnJpAY6TYGZnXvRmenV+9kvhbJQRJbFVIJj5zbPgfEjs8uNBVSz5XliginWrpjqo0
 nDNVrzeH/Fl1UrGQJ/IjSZHK6I0sGJjvObikI+oLeS2IGVXk2jxiS5+hbVJE1edSu/D8E7bvUPT
 uBf+BuzPP2AM7qtl4roS8Q5Clph2NmBRSNrC7vOOTLT2rHnEfE6AlB2y2TFsTjwh9hTcfgzrBwe
 YBV0+1tFUudMjcQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

No more tests were executed after a failure but it is still interesting
to get results for all the tests to better understand what's still OK
and what's not after a modification.

Now we only exit earlier if the basic tests are failing: no ping going
through namespaces or unable to transfer data on the loopback interface.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index bbae40882bfa..0f060af01a84 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -7,6 +7,7 @@ time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
 ret=0
+final_ret=0
 sin=""
 sout=""
 cin_disconnect=""
@@ -837,14 +838,25 @@ display_time()
 	echo "Time: ${time_run} seconds"
 }
 
-stop_if_error()
+log_if_error()
 {
 	local msg="$1"
 
 	if [ ${ret} -ne 0 ]; then
 		echo "FAIL: ${msg}" 1>&2
+
+		final_ret=${ret}
+		ret=0
+
+		return ${final_ret}
+	fi
+}
+
+stop_if_error()
+{
+	if ! log_if_error "${@}"; then
 		display_time
-		exit ${ret}
+		exit ${final_ret}
 	fi
 }
 
@@ -934,23 +946,24 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
 	run_tests "$ns4" $sender 10.0.3.1
 	run_tests "$ns4" $sender dead:beef:3::1
 
-	stop_if_error "Tests with $sender as a sender have failed"
+	log_if_error "Tests with $sender as a sender have failed"
 done
 
 run_tests_peekmode "saveWithPeek"
 run_tests_peekmode "saveAfterPeek"
-stop_if_error "Tests with peek mode have failed"
+log_if_error "Tests with peek mode have failed"
 
 # MPTFO (MultiPath TCP Fatopen tests)
 run_tests_mptfo
-stop_if_error "Tests with MPTFO have failed"
+log_if_error "Tests with MPTFO have failed"
 
 # connect to ns4 ip address, ns2 should intercept/proxy
 run_test_transparent 10.0.3.1 "tproxy ipv4"
 run_test_transparent dead:beef:3::1 "tproxy ipv6"
-stop_if_error "Tests with tproxy have failed"
+log_if_error "Tests with tproxy have failed"
 
 run_tests_disconnect
+log_if_error "Tests of the full disconnection have failed"
 
 display_time
-exit $ret
+exit ${final_ret}

-- 
2.40.1

