Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56842750D69
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjGLQDg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjGLQDf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 12:03:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080B199D
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 09:03:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so6389965e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689177811; x=1691769811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVlMBY+5/YKfP6HUFM2GkaKSHEcsx7YOTPwpnWoPGhQ=;
        b=4BmJCuReCrpg05dFkCvUZ3FE/D0vawQvW8csm414hc3xWp5HvpfkUwv3gP7+4Mogpw
         L4MdZQMesOh4xoX9yzFaWt8SAPGu+7h6ZkXFOaa6x6UOwSTreQD2y+m22owSBVOMa9pq
         kTihgmr/UXmtMBz0rY2r6tC9krHO73ufYy2CIOdPim33zB282YghTdkVEam4NTyb61ic
         bVKsb+Q6J9gBs4EoEOVm145E4fzd75L1dfWEIJW3qJH0S5siI/BtFmvTW9qCYuEcLvGE
         o+5MPGZ0pp7PZI358FOemy1gpmigZ6g6JsyqewhQKrAc2oHbMRytbucuhwcq66RCI8VM
         e6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177811; x=1691769811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVlMBY+5/YKfP6HUFM2GkaKSHEcsx7YOTPwpnWoPGhQ=;
        b=GbgkCYfzW9E2r4zzEUGRTHCI5mqbIUdd8THwG3fesM4fEii2wYx5jO/7SUD70CGOCW
         E6npa9KhCRtoVHcS4ZuFOEDvllb3fi6NApVTuSZ85C8rp0jMmwwymZwadtGvz1ttAiia
         eEO29PjG3ZJf6wy8lezzvWbrnT/5rQ4jDeLs02koUmPLsHdlNzfbHJfVG1vcyubsf8Wx
         g19WjFslJVgPM7s7kTaTXx8SOCBvG8wFdNpjDtViwRi0PkxCcP9W23RVPI03OorAgFUY
         cWAgkNbHd8FYegCVXrc1ZoarhPII1fherqv4ZYfH6AKWBzFGNYy221nBePw0BWyzgnB9
         ZVQA==
X-Gm-Message-State: ABy/qLaIWRX6S87c/SHVu5EjJXcV3uN+tJ/7joFB9u4hNLzeXmjZDWHW
        qMNEf4rrnldXX2uQm36GA7UABvKdzMp91/uSlwZxGlOy
X-Google-Smtp-Source: APBJJlF5jH5IX9JbTbV86qFG95PEaAK4e+l9tt3nYQdzf+TVgjJLduhArk6hi+F+GqEuTxP5/LVi/Q==
X-Received: by 2002:a05:600c:4590:b0:3f9:b867:4bb with SMTP id r16-20020a05600c459000b003f9b86704bbmr2356367wmo.2.1689177810940;
        Wed, 12 Jul 2023 09:03:30 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003fbb9339b29sm15972581wmr.42.2023.07.12.09.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:03:30 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Wed, 12 Jul 2023 18:03:19 +0200
Subject: [PATCH net-next 4/4] selftests: mptcp: add speed env var
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-4-f1c8b62fbf95@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=22653;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=LmaWDmR4NwSIDXQringvnl58L1jLrauBfol011sWzkI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkrs7OMfyUbrK8N52VDSv2gl1J/FInwU2Hm97MC
 /Y75Ms/tIeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZK7OzgAKCRD2t4JPQmmg
 cyIuD/sGeFDlhhcCxxJFurnApn89Ow9FK/v2oU+oeY1N441Ix2IV3/Xpx1nuxvgakrKGYBdLAIQ
 MYjwPGOQjr1pTFyWI0ip9BfdnFfbyF8tAQyXWAIb6YRbUnLEwuffO9imgjAPH+3tTdTGfOB0C1x
 aFw4clOHbRYaYSyTsU2y5ZE0i+NCCwaWdtN0qrXH2M2dnop+fDf/L9A0BlF/eNFcW4/yHfRRD8u
 UARNqO72oZidNHRZtBbxjLF8puS603ThNRHTX+Hanz3zsxFxA6dO4CEi/4eQGMr7qeCAvZWM6m6
 81UQaxO6PwR9XdB++62ZMAYwjfCtxZJOQ8NxWwOjxs2Yz92+A1HM8BHZqZmfLETecrGxoDgm3vu
 H48ojDxYdDFHU2mUdWxk1i9Y0zYgWckw7DECmCcevtsqHAfrFY/vT0YM7Pn4clQCjQBFLFKqzC8
 zR7oldzlpKBE6JAyOFYKSq+e/Nx0q+keRLxieivFhHzhwAIA0THfI+4/9ap1Fah0f9WW/g7srI3
 XCN9pJFMTLW0HGmVuvQVKHj05R2/HDsCrZBTsO5F0Vjb1OuN+9JWfgWNdU4sPuITe+X/1ZrG3Cl
 7dOEUWTnj5z1rSoNFCUapOIYadEJGBZK+jzgzCYsuY3+Vu5ry12Ixcn1xCwNZrd8zfXAgeTH3iY
 isDyKRCHP26Bc+Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Geliang Tang <geliang.tang@suse.com>

Use a new env var speed instead of using 'speed' argument of run_tests()
and do_transfer(). It can be set with 'fast', 'slow', or the actual speed
number:

  run_tests $ns1 $ns2 10.0.1.1 slow

  ->

  speed=slow \
          run_tests $ns1 $ns2 10.0.1.1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 230 +++++++++++++-----------
 1 file changed, 125 insertions(+), 105 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5ad95cc382e6..b5eeea4c3efa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -57,6 +57,7 @@ unset addr_nr_ns2
 unset sflags
 unset fastclose
 unset fullmesh
+unset speed
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -988,12 +989,12 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
-	local speed="$6"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
 	local fastclose=${fastclose:-""}
+	local speed=${speed:-"fast"}
 
 	:> "$cout"
 	:> "$sout"
@@ -1026,8 +1027,8 @@ do_transfer()
 		extra_args="-j"
 	elif [ $speed = "slow" ]; then
 		extra_args="-r 50"
-	elif [[ $speed = "speed_"* ]]; then
-		extra_args="-r ${speed:6}"
+	elif [ $speed -gt 0 ]; then
+		extra_args="-r ${speed}"
 	fi
 
 	local extra_cl_args=""
@@ -1165,7 +1166,6 @@ run_tests()
 	local listener_ns="$1"
 	local connector_ns="$2"
 	local connect_addr="$3"
-	local speed="${4:-fast}"
 
 	local size
 	local test_linkfail=${test_linkfail:-0}
@@ -1210,7 +1210,7 @@ run_tests()
 		make_file "$sinfail" "server" $size
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${speed}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
 }
 
 dump_stats()
@@ -1999,7 +1999,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 	fi
 
@@ -2010,7 +2011,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2021,7 +2023,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2033,7 +2036,8 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow &
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2132,7 +2136,8 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2242,7 +2247,8 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2253,7 +2259,8 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2264,7 +2271,8 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 speed_10
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2275,7 +2283,8 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 speed_10
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2288,8 +2297,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2301,8 +2310,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns2=-2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=-2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2312,8 +2321,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2325,8 +2334,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns1=-1 addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2339,8 +2348,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		addr_nr_ns1=-1 addr_nr_ns2=-2 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_10
+		addr_nr_ns1=-1 addr_nr_ns2=-2 speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2353,8 +2362,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		addr_nr_ns1=-3 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_10
+		addr_nr_ns1=-3 speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2367,8 +2376,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		addr_nr_ns1=-3 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_10
+		addr_nr_ns1=-3 speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2381,8 +2390,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		addr_nr_ns1=-8 addr_nr_ns2=-8 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2395,8 +2404,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		addr_nr_ns1=-8 addr_nr_ns2=-8 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2414,8 +2423,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		addr_nr_ns1=-8 addr_nr_ns2=-8 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2428,8 +2437,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		addr_nr_ns1=-8 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2440,8 +2449,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns2=-9 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=-9 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2451,8 +2460,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=-9 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-9 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2465,8 +2474,8 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		addr_nr_ns2=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2474,8 +2483,8 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2484,8 +2493,8 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 	fi
 
@@ -2493,8 +2502,8 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		addr_nr_ns2=2 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 	fi
 
@@ -2502,8 +2511,8 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		addr_nr_ns1=2 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		addr_nr_ns1=2 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2516,14 +2525,16 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2533,7 +2544,8 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2543,8 +2555,8 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=-1 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		addr_nr_ns1=-1 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2556,8 +2568,8 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		addr_nr_ns1=-1 addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2658,7 +2670,8 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 	fi
 
@@ -2668,7 +2681,8 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:2::1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2679,7 +2693,8 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:2::1
 		chk_join_nr 1 1 1
 	fi
 
@@ -2691,8 +2706,8 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		fullmesh=1 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+		fullmesh=1 speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 4 4 4
 	fi
 }
@@ -2705,8 +2720,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		sflags=nobackup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=nobackup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2717,8 +2732,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2730,8 +2745,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2740,7 +2755,8 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2749,7 +2765,8 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2757,8 +2774,8 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2767,8 +2784,8 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2857,8 +2874,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2874,8 +2891,8 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns1=-1 addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2888,8 +2905,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		addr_nr_ns1=-8 addr_nr_ns2=-2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -3091,8 +3108,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		addr_nr_ns1=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns1=1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3104,8 +3121,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		fullmesh=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		fullmesh=1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3117,8 +3134,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		fullmesh=2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		fullmesh=2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3131,8 +3148,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		fullmesh=2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		fullmesh=2 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3143,8 +3160,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 sflags=fullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=1 sflags=fullmesh speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3155,8 +3172,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		fullmesh=1 sflags=nofullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		fullmesh=1 sflags=nofullmesh speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3167,8 +3184,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 sflags=backup,fullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=1 sflags=backup,fullmesh speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3180,8 +3197,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		sflags=nobackup,nofullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=nobackup,nofullmesh speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3356,8 +3373,8 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		sflags=backup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3370,8 +3387,8 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+		addr_nr_ns2=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -3381,7 +3398,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3401,7 +3419,8 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3424,7 +3443,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 slow 2>/dev/null &
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3447,8 +3467,8 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		test_linkfail=4 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_20 2>/dev/null &
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2

-- 
2.40.1

