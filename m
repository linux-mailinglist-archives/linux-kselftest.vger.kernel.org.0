Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB7A750D68
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjGLQDe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 12:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjGLQDd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 12:03:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65131BDF
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 09:03:31 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso73460755e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689177810; x=1691769810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liX/45MwjWcCDqrEus/1D+DYuEA/UW5nbbNnFzTg4gI=;
        b=fciZYj0HX8H8WkRBLOhTwiSmGL44WONfFZusDuofkVO6jK4hJ11DpBSAZToZkwD/6l
         r2A1JTi7nX31eOZe6mKrjxLbCAw2p6KIf1ykDOvnpSpifT36IvQnorTxgY80+Lk+vlwS
         Hn7dd6Mht7QTVPHtQXa2ZSwwaWq8nmAKMHtts2A/aGAB0XNI0F2Kk3d0uI/bFJcfA2H9
         M7g14jBjbbck1flxpcYXHcelSLhar1XE+qnx0fXVDp4D2Pm4miWv10lAqkklOQEP7RTD
         cX78JPh4WuhdFupprUhkfBCAOmD8bY5g5+z0h4teFj9AgJ6XQvtwmVNuuSEH5Gzfzg7x
         VA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177810; x=1691769810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liX/45MwjWcCDqrEus/1D+DYuEA/UW5nbbNnFzTg4gI=;
        b=aRMs6npozMlK9oE5PAZWvheGAoxeoe366aO3BBVP6QdnwUEO75njNPnS7M9yWj6oQi
         W869irr/Nd93rdypFrCnkVjXPYAv0QYMHP/d9zesDkC8R6MKMuNJZNrTSQBLkO8IkyaX
         chqxZxNZKVCbVx0tRWPDDRWMMKCqdLqgnH1wMxNzklukMGmmSz5oGp+TTEA7UFqflQSZ
         jTbB6trCfXMX4bUM1bddlHTAW7ynNcfKfTvng99NtcLcYrkMKT6hC04rBr762iRXCzZG
         xGlOdrM+C065zBgX6cB7qPxzC1orXHRZ4aJl1Bm0x2BF/1/xEscTDhOecgkQA9IJZPCe
         iVeg==
X-Gm-Message-State: ABy/qLZHb1uWskASroIJrh38ZWjehOdt7qZXDDFVwHa/rRE6LZXoBDw9
        BIzSV7NJNEmc1wrbc+nhC0sXmAjgtpUd/WN78yXYx+71
X-Google-Smtp-Source: APBJJlHYsDEh+dM7ovSJh0vgCSQyPzJOVNvO0661Qz7UfY69Q1BulvSnMIubehn3kaVtMCDc1XNXfw==
X-Received: by 2002:a7b:ce8e:0:b0:3fb:40ec:9483 with SMTP id q14-20020a7bce8e000000b003fb40ec9483mr17500250wmj.16.1689177809971;
        Wed, 12 Jul 2023 09:03:29 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003fbb9339b29sm15972581wmr.42.2023.07.12.09.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:03:29 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Wed, 12 Jul 2023 18:03:18 +0200
Subject: [PATCH net-next 3/4] selftests: mptcp: add fullmesh env var
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-3-f1c8b62fbf95@tessares.net>
References: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-0-f1c8b62fbf95@tessares.net>
In-Reply-To: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-0-f1c8b62fbf95@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     Geliang Tang <geliang.tang@suse.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2983;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ZRZR5HmHd9wxvCYcF2FjC/vJjQ+ch43TVOjqYZkaOMw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkrs7NeL73iGWFIRyzmvVjQ0jsjwYXrWg/7t1IR
 9b4xcL0pxaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZK7OzQAKCRD2t4JPQmmg
 c58SEAC2VJSE5J8PMyNYX+00lVSmRSPa2+qf5HH4NymX9rt4NROp7z48Kx5Z78bIGc3Cp1EWUTL
 INMg4cgamRfzDAdf70UZLoK3QA/QCya75TmGdwxzneTJzx5FIiBSPAI1MPzBWaUAAeOHrrV3E6M
 iyHPgH94H5R0Uj0hpgZLDW7QERGv3ls/PLnNBUOmXo7vW1yOY2eNJicd+mm4P+KYsXGsqeMJ9ZZ
 Qv6G2iYgcZ1ci9jAhUbeiw+Bm2Qg1tUoeVWqkxS0/Y5ZHDixi+yJ7r7nE71er9sitnsZn1zwCmc
 dcG8rCDAq1RUjgRoXEFn4GZrloYAmx0vv1t5MsRIllUTJO493gs1Gyxfq53uQVUxhLxznf7Yi8R
 DYFL04+q7KVcWJe/o/Uirm1Pt4aL+IS1Wwr36wsCFcmkH12JiZ0QBmZCdbtfT/KZ6BDfPNUJcFN
 A9eSpWI8w85NrBk3z6eJE+q70XtiwDm/JPEtYdMcW2J9EFcaTOLnvuWNJiWslLgNFYbhtfr9Y55
 ZFz19uDr9fF5U/ZJczIrr2i55KRJCP/H0PX/GdB+j1Pp9kF5JyObvf5p3N1s5UiFUo55q+kuSJ+
 7+LyhUM/ROZpIaoshS1UK6IHeSTfko6R/uORt0GMA5JKPYCS+TPeCNbh9GInu9WYQcuSlXejEYD
 hKFAr7E+vp6q3hg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Geliang Tang <geliang.tang@suse.com>

Use a new env var fullmesh instead of passing 'fullmesh_*' to addr_nr_ns2.
It can be set with the actual value of addr_nr_ns2 now:

  addr_nr_ns2=fullmesh_1 \
          run_tests $ns1 $ns2 10.0.1.1

  ->

  fullmesh=1 \
          run_tests $ns1 $ns2 10.0.1.1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3e8c560938f2..5ad95cc382e6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -56,6 +56,7 @@ unset addr_nr_ns1
 unset addr_nr_ns2
 unset sflags
 unset fastclose
+unset fullmesh
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -832,11 +833,12 @@ pm_nl_set_endpoint()
 	local addr_nr_ns1=${addr_nr_ns1:-0}
 	local addr_nr_ns2=${addr_nr_ns2:-0}
 	local sflags=${sflags:-""}
+	local fullmesh=${fullmesh:-""}
 
 	local flags="subflow"
-	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+	if [ -n "${fullmesh}" ]; then
 		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
+		addr_nr_ns2=${fullmesh}
 	fi
 
 	# let the mptcp subflow be established in background before
@@ -2689,7 +2691,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		addr_nr_ns2=fullmesh_1 \
+		fullmesh=1 \
 			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 4 4 4
 	fi
@@ -3102,7 +3104,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		addr_nr_ns2=fullmesh_1 \
+		fullmesh=1 \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
@@ -3115,7 +3117,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		addr_nr_ns2=fullmesh_2 \
+		fullmesh=2 \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
@@ -3129,7 +3131,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		addr_nr_ns2=fullmesh_2 \
+		fullmesh=2 \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
@@ -3153,7 +3155,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=fullmesh_1 sflags=nofullmesh \
+		fullmesh=1 sflags=nofullmesh \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1

-- 
2.40.1

