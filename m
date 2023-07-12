Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC58750D67
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjGLQDd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjGLQDc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 12:03:32 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE7F10D2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 09:03:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so56685815e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689177809; x=1691769809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9u2n4oF6gKDwyM+Ju8cehthdYltlnqgxYGHl0ZLlW3U=;
        b=tI8OVDl13n23zaNluWbFvX5H141FPddM9NqMoNcTexnPwJOtrlxGVuBCGSNzteSqEL
         1AQeZpBgnS7lC+FSub4Cf/e/hn2w1WSb/eHtRS44+/nQLSDhZVPJOe3tVLlc17ox4HsJ
         jZMU0DGdHfC9WdAuspsNKNFcsSJLF+5oibzHFlBS049RZ+gz1tqF6b6VSeNaqAY8Ok6p
         BWJcCtqowZz7L5BImjGE6BkawNtCBXDgtsiwMTcALyuqmyrP6lK0ZK9rOJhsyQP6dvOx
         LOCdP0RdgG8UNkjUBxGVTfZ/QiBqNNrhyfaSSoTFt/PRXHNytPn5fNE4ZcExX4Zvjuhu
         oRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177809; x=1691769809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u2n4oF6gKDwyM+Ju8cehthdYltlnqgxYGHl0ZLlW3U=;
        b=M5rbA/QX3CjoUehKbeIirRmUihRk/iWqVfGx8j3oCzZWOEuXHbzI2z8YNyWk8cPnGC
         J4H++TLrxU6JCdcEIvAk/4i6rg6LbbK/jx/wJ/3Mj5gvNEU3PKUn1/yDib0ITFGv5EhU
         XoS9s5OUPNb7hjvwSW4H6OHGNIt5Q7Yuw5MfHaRe0ZF4e24jlZfs0R5MZ5CfalMWamaY
         4wENdz/dOHf82CJsDPUjeHoHbf7cCw6mWtJ8Th8SWpj8sX8LU5uM/bdLzxiTYEIrDEfZ
         6Kvilanvs0zzM7JUFi0qEIEj/CuGCeQIIXeFVRJNqNCqXDuwxV8AD4TWBFvdFrZQp6/t
         kW5g==
X-Gm-Message-State: ABy/qLalrPOJQQuJtQH8cw0zGDpvCRqG3+Zw41oQNlk3MHCjlnY/1zMm
        yVmuT9GE3asXYAzxaBf9itkfP0Sl3bHBchLFQBNua2g9
X-Google-Smtp-Source: APBJJlE1hPgM9f5lTnKel6lQ6pyrQy/CEeKP/OLzmYF7bX4AOtZ2Cu5kssAzDMw9CEhzsPT7mdwV2Q==
X-Received: by 2002:a1c:7917:0:b0:3fb:a937:6024 with SMTP id l23-20020a1c7917000000b003fba9376024mr20270918wme.29.1689177809028;
        Wed, 12 Jul 2023 09:03:29 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003fbb9339b29sm15972581wmr.42.2023.07.12.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:03:28 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Wed, 12 Jul 2023 18:03:17 +0200
Subject: [PATCH net-next 2/4] selftests: mptcp: add fastclose env var
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-2-f1c8b62fbf95@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=0Cy1x2l+pB/Y+z3Y4YGTHEQ52Bgd8t4VtWzV0XJI0HE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkrs7NwHvlS8umYV88K0uLcJSLK6DfJE3YsXBlD
 YpKMdy2l5OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZK7OzQAKCRD2t4JPQmmg
 cyH5D/9fZhRFNCAtGpBFEUo51XLdfcPXBouhjGxsGEWrTpfJee735Bb4QjP+aq+12XeeGqYFfYg
 BIt4ZbJZnnrbFw1OB6iqiFnr9Y88itffELRjll/ls5QwNHBoiVq5GWmIGRk56FAasikbffdb0mB
 QH9aA3kaup2Xj6EP4Qji//Mu78UDUItWHCw4Ve1GAmpOKGJPshCpPQpmytNJUB6wwIbqwt9UAHe
 IjiIKSiVS6FxA6u5JGW5rETJUqgLSHvNi5/Wy+VI9X0jgfDqcfrxcJCsznd+62Uc0ckJ11jhEGo
 Iw5HDNGiu+LR8eUPMpMRKErikcRpOweUn46jiFugfy+IqX2qS/xcIwptekjdI6O7VXQrqFvLAEd
 R1kj+lqdYushxIXHbk++nz8p6DWknkjXXx3Dyhb0iMASdmedU/xe/ZXJ+1QV17rZ3noHkK4sfnA
 OKHQGXiq2gAyKk5R77McvjrTTgu6Kh6lQfHO+Wjgt9ryjUBZtKqafBFWTW6xmPw9XrKlzgWzibO
 Y5hNfcgafv8e9gmGhpGcIVjJSxZNfg7k7prRQA6EEwa61XNCO/VxqLfrToVnVCmPTomPTat9UW4
 uCeAZqWF0N3HD542UIKiBD4HhdulpDqXB/ww7gCeXojEQcjcJkkhImI/0GS9MmwqeUHbK6aB3Pa
 u7FJFx+aMNCBvew==
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

Use a new env var fastclose instead of passing fastclose to addr_nr_ns2.
It can be set with 'server' or 'client':

  addr_nr_ns2=fastclose_client \
          run_tests $ns1 $ns2 10.0.1.1

  ->

  fastclose=client \
          run_tests $ns1 $ns2 10.0.1.1.

With this change, the fullmesh flag setting code can be moved into
pm_nl_set_endpoint() from do_transfer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b0aaeead56c4..3e8c560938f2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -55,6 +55,7 @@ unset test_linkfail
 unset addr_nr_ns1
 unset addr_nr_ns2
 unset sflags
+unset fastclose
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -832,6 +833,12 @@ pm_nl_set_endpoint()
 	local addr_nr_ns2=${addr_nr_ns2:-0}
 	local sflags=${sflags:-""}
 
+	local flags="subflow"
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
 	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
@@ -984,6 +991,7 @@ do_transfer()
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
+	local fastclose=${fastclose:-""}
 
 	:> "$cout"
 	:> "$sout"
@@ -1020,11 +1028,10 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+	if [ -n "${fastclose}" ]; then
 		if [ ${test_linkfail} -le 1 ]; then
 			echo "fastclose tests need test_linkfail argument"
 			fail_test
@@ -1033,7 +1040,7 @@ do_transfer()
 
 		# disconnect
 		trunc_size=${test_linkfail}
-		local side=${addr_nr_ns2:10}
+		local side=${fastclose}
 
 		if [ ${side} = "client" ]; then
 			extra_cl_args="-f ${test_linkfail}"
@@ -1046,10 +1053,6 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
@@ -3186,7 +3189,7 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		test_linkfail=1024 addr_nr_ns2=fastclose_client \
+		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
@@ -3194,7 +3197,7 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		test_linkfail=1024 addr_nr_ns2=fastclose_server \
+		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert

-- 
2.40.1

