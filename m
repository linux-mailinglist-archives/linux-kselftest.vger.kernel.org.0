Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6441575649C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjGQNWY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjGQNV7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94819A8
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so27663765e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600106; x=1692192106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tR/LJB40BUwADc/pwwmcTzztR5wwy/3EmzcIcXvVX4c=;
        b=RVq6ECuQK75XPg625PuyZk/vuwCZtgV4CDD86UVQWoQaMxR96HIOTqdKCt2y6nshgv
         JNrXIsYc55RWgOJaAZAvNmgEreLAPVOrw/e5H36lUBQf1Lda6oxp/rbU10Q8pFb+M8wl
         wpXu4IknE+Mj1kM0cs5Ze9dht4JV42kCJKrypfdbZRQT1S0HyPBBqu+8UdJZqd//Q2RP
         jGKCo54LrqRk4kTRHkfKuj3Oi5JqCWfhUtK1twdwIdXkuCsRM+J1K1mrw+eI/cwjugbT
         dhu0UQDD5GTcvvt+/lUfwDze3H1zd1VCGQ2nguHkkylSZ69zoHlPGMzmxHSgxxv8hgRX
         rODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600106; x=1692192106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tR/LJB40BUwADc/pwwmcTzztR5wwy/3EmzcIcXvVX4c=;
        b=ZvMyhK3KNqyQKuA7i7bhbcM3i89VdcxRBH8YDi3dZXZJH53E2LyPphP3EvK0kWAY1x
         cIUUqP1Qe7gcqHDwFbhUGvrraUS411YBKuBcfxLm4ZhQHRhcPd8gxqHwPGyygadU4/wX
         yvKyQ4OcNGAw5VafFQZDrkLtgLppW2S7gdhXIANY4FwY8Woe3PFMCTURwI1uu0H/sF4J
         We6d2um1TA1HmNWOMrtHbmmqNVnqGm9VWY5Xn8Kh8m22hnDIZJqolnEsVrpOY50fM06f
         2039VojiGp2mY8StJ6BmghRNOBTATPWvPBk/3KHXY5EzqUlILQ4jLfYVAUq2QbKi5UDF
         h7lQ==
X-Gm-Message-State: ABy/qLYHD0O2onn7ozfghL0uv2yA5MSKcB61aeQZ8azPXu5IOPVZCDpv
        C2fHa5usmTDDNk28vosfz9fULw==
X-Google-Smtp-Source: APBJJlEAjEIkZzFg1xpSGORc1Ma3+MxqV3kCTR9x9DdhZvLcNmHRC9oJxls2CM51sbXcCBViC1oqZw==
X-Received: by 2002:a05:600c:1c85:b0:3fb:b18a:f32d with SMTP id k5-20020a05600c1c8500b003fbb18af32dmr8639841wms.17.1689600106007;
        Mon, 17 Jul 2023 06:21:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:45 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:32 +0200
Subject: [PATCH net-next 12/13] selftests: mptcp: sockopt: format subtests
 results in TAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-12-695127e0ad83@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3690;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=9nR8A93d0e86OQ/7UoAc/x6Y3435nw7FvvrFqKMr2dU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdxhnH73KyrLNYwW8aivzd0fWnwiEXYwsJH
 OmfraFujx+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 c9iuEADjRHncRcQ/ZQ8Ww/stxWnLd6tuQdX35msua88nbGfhEIoaldifeH7VhfXq/A5PyrUVRrh
 w/dmuiMf/spiFcfAI4ZS98FLC+0fH65c8t3nzyxEcF66IJ1sv9muup+1erA0y+IPehGSgphC7QC
 OZkp3xIGTJ8JhBC2ALQNDL8TweeaSCeCEnRVsqPPtiiSlcws/Zkr/oo5GcZfO4EJfjFuS8n/0Lw
 Rj7q7dGLWF/hVMzsi7ZASX3iACK2Mdlzs69oNwqAQhBWlSuZKYlAnrzFoA+zCJMqhxOtQrx8Sr7
 euP/ra6+JvoKTYhg04SCxp2Aw3Um7sve+4cRHZc8bmczzrhj6iFVPLMrq8MizFfg89KPvJs7RC5
 zLiDxIbjCsVkUlN2r7Mzi+xWs7T2KIrHOzS0NocYHrEcIef5cKLkyih1v1P2jEO3rDTCWjzwTsu
 d6tMK20SIPqiOMpmGADir1SgQN3SzBh5ahIc9kLm+aXrsjK9C8EN8j98vqNHDd6FUnMLjaYQq9j
 GGnKRcbZDAp5AhHJRcpOet7yYd80dPyvUoNCAZakeOTuQh6UGO4Tv9h0zMSdY6QhAgxrmo2u6Z/
 CtWMTv4FH/EP+s2witZWFfwkz2vVHQzzg7E3DXpGHJ2R5No6spWtPFgXCuazBC/c5fyH75eDFtY
 Ad5qrGkpTYF5pkg==
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

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CIs executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

This patch formats subtests results in TAP in mptcp_sockopt.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index dc8d473fc82c..8c8694f21e7d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -183,11 +183,13 @@ do_transfer()
 
 	local mptcp_connect="./mptcp_connect -r 20"
 
-	local local_addr
+	local local_addr ip
 	if is_v6 "${connect_addr}"; then
 		local_addr="::"
+		ip=ipv6
 	else
 		local_addr="0.0.0.0"
+		ip=ipv4
 	fi
 
 	cmsg="TIMESTAMPNS"
@@ -223,6 +225,8 @@ do_transfer()
 		echo -e "\nnetns ${connector_ns} socket stat for ${port}:" 1>&2
 		ip netns exec ${connector_ns} ss -Menita 1>&2 -o "dport = :$port"
 
+		mptcp_lib_result_fail "transfer ${ip}"
+
 		ret=1
 		return 1
 	fi
@@ -236,9 +240,11 @@ do_transfer()
 	fi
 
 	check_transfer $cin $sout "file received by server"
-
 	rets=$?
 
+	mptcp_lib_result_code "${retc}" "mark ${ip}"
+	mptcp_lib_result_code "${rets}" "transfer ${ip}"
+
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
 		return 0
 	fi
@@ -264,6 +270,7 @@ do_mptcp_sockopt_tests()
 
 	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
 		echo "INFO: MPTCP sockopt not supported: SKIP"
+		mptcp_lib_result_skip "sockopt"
 		return
 	fi
 
@@ -272,18 +279,22 @@ do_mptcp_sockopt_tests()
 
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt" 1>&2
+		mptcp_lib_result_fail "sockopt v4"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_result_pass "sockopt v4"
 
 	ip netns exec "$ns_sbox" ./mptcp_sockopt -6
 	lret=$?
 
 	if [ $lret -ne 0 ]; then
 		echo "FAIL: SOL_MPTCP getsockopt (ipv6)" 1>&2
+		mptcp_lib_result_fail "sockopt v6"
 		ret=$lret
 		return
 	fi
+	mptcp_lib_result_pass "sockopt v6"
 }
 
 run_tests()
@@ -310,10 +321,12 @@ do_tcpinq_test()
 	if [ $lret -ne 0 ];then
 		ret=$lret
 		echo "FAIL: mptcp_inq $@" 1>&2
+		mptcp_lib_result_fail "TCP_INQ: $*"
 		return $lret
 	fi
 
 	echo "PASS: TCP_INQ cmsg/ioctl $@"
+	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
 
@@ -323,6 +336,7 @@ do_tcpinq_tests()
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
 		echo "INFO: TCP_INQ not supported: SKIP"
+		mptcp_lib_result_skip "TCP_INQ"
 		return
 	fi
 
@@ -367,4 +381,6 @@ if [ $ret -eq 0 ];then
 fi
 
 do_tcpinq_tests
+
+mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.40.1

