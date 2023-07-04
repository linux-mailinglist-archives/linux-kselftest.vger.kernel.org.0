Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E7747921
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jul 2023 22:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGDUpA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jul 2023 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjGDUo7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jul 2023 16:44:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA25510D5
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Jul 2023 13:44:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fba545d743so78294065e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jul 2023 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688503496; x=1691095496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbs49TeREvqiLDtiZ2Z4ZyV3x/f9tvCjUJNddKBzHqM=;
        b=71EEytLCLqTLccLzoPuPNNeb09hv4H7omNK0iWbNSc7k+BRsAfXs7LypSn311LKrpK
         j85zL7PrtNLLWhQh3Ni6YkxakmFLZkyoTrQ8UIXWW4+bgqE8FifXrsb74vFd5XkFoECd
         8wKS+dZuhR8+mjsLqdKY0kmcGE6Rvpedn0JiyaL+1vRfIgPS4xZSTVPKkIITj+YQxhvr
         EfOcxxSpNI3yWrf89stjIhEzecBYFlKA4s41NbIqME3RUdXSXeqaGxbYU5Jb06HKUrms
         wcCC+NCp6HnHITxrzyOKtYG72LP1MvFOfpQ5riSXWr6AzR42/zDtD5I+VdRchqByZ6J7
         I3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688503496; x=1691095496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbs49TeREvqiLDtiZ2Z4ZyV3x/f9tvCjUJNddKBzHqM=;
        b=ILUZT4ejHet6QF9oqRo7FXQMnYQVSxMfOuigU+rUnqD9wV0yvMDCSV2sMBdQHm2DYl
         eLIhHKU9Y1Z5KFjp91s18ZjiZ8dFL6LuKuk6ppnKdYEDZTdy+IG/674weXdprrszqmyU
         dm5nQ6+xO+wbjjpmojStb0XD8DNrqJxVNvBCSPQZIkoXH6kKq4CuM+1bWQjETNsBUrTK
         wDPv0Uu5GG4aEVa8+Jqm8pRcnkmGOUvDlOf/SBR3C0/vmmytR4oVAJ0mQcVEDwbbmrKQ
         VkmkC5csbkxQa5mtUt71Ir12/fT+euZ9lpcGsVz5uZVFKevPy3LGFD2WkUD0xaLipDfq
         zO+A==
X-Gm-Message-State: AC+VfDz1qn0ul7nNtGEqvoAQwTn90cCI/6L9nYiSAshyX1g5A9fxFAs0
        15n5HAWu0fW5IjmoWjW/NbSKXg==
X-Google-Smtp-Source: ACHHUZ7OfLkD4EL1eZnOC6SEWIJqO7T1GYXlDxM0eers3/RaR8s/fjvsySnar7tgGhowCyYNqnPUYA==
X-Received: by 2002:a1c:6a07:0:b0:3fa:934c:8356 with SMTP id f7-20020a1c6a07000000b003fa934c8356mr12936237wmc.10.1688503496449;
        Tue, 04 Jul 2023 13:44:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y4-20020a05600c364400b003fa74bff02asm115332wmq.26.2023.07.04.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 13:44:56 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 04 Jul 2023 22:44:36 +0200
Subject: [PATCH net 4/9] selftests: mptcp: sockopt: use 'iptables-legacy'
 if available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-4-d7e67c274ca5@tessares.net>
References: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
In-Reply-To: <20230704-upstream-net-20230704-misc-fixes-6-5-rc1-v1-0-d7e67c274ca5@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Kishen Maloor <kishen.maloor@intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hNWOoD7/LcwT6MxZn3z9Ny8SyuT+nO+3gHstFbn1a9M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpITDErJzB3ia+oVRtyW4uFBhqIl7+o0+PF3/9
 GfcPSzELw+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKSEwwAKCRD2t4JPQmmg
 c5AtD/sHKEDly/PyEbPrTJenSQYp6qxYdSsKRj2UOokdmfmCiKDxM13u5H1sC+bIp1cLmjybPro
 bGAOxX4kCmRzF26gYCE/fUgy6vHQc1XUYushwdYcVQcqCCiuj7bh74qdLqsYXXfbsE4xaFwmXi6
 U0eMJ2+w3bIfq+jvqGX5ze+51ltqqWVnHK4YM8kCJlUzOMK/towrnmaOsB6rejwyPafV91Xia4l
 0+22YYZYKE2XJtrcfK6LYFwdA/kclrmhUE3la+quoDrFxQhsvPV7eTrlFp707atnNkVK3im7yXb
 Uhyy06xh2uI/50D3kRuvgTXsCJyUIIb5mrmXGvFj/COI48NzYaNSuvxEprxcvbkplbwTyeKczKT
 gEH0G2Ubg9VtHVBfs5o/e1rm2030i9DK6HeSX92OSs3TfNtelL2lpdupLlh1ZDDfzpIfnVsdR7l
 MWczEoXNVQr9C669SFN0ORYOdY8/ZIRzASTCAFNT6DFRZj1YGXT9wCHB1XCvySEqoJ78lAgAmq5
 pFlaFxb1Pvn1D04PIZpI+kp8J2zZB2/gXqJFLBqIkzfzIjdBKBwAPbIu8Fj9VDxbmh5OM5UaXXE
 UM6NLfmlkzIMV2o22UG6st/3zcEIx05nLvfEW+PREMuaK6gxHvSubCzQwPp5dh2m3sSAqsGAd/Y
 mEYSiwGdbDn6Fkw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

IPTables commands using 'iptables-nft' fail on old kernels, at least
on v5.15 because it doesn't see the default IPTables chains:

  $ iptables -L
  iptables/1.8.2 Failed to initialize nft: Protocol not supported

As a first step before switching to NFTables, we can use iptables-legacy
if available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f295a371ff14..c21bfd7f0c01 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -12,6 +12,8 @@ ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
+iptables="iptables"
+ip6tables="ip6tables"
 
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
@@ -25,7 +27,7 @@ add_mark_rules()
 	local m=$2
 
 	local t
-	for t in iptables ip6tables; do
+	for t in ${iptables} ${ip6tables}; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
 
@@ -95,14 +97,14 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+# Use the legacy version if available to support old kernel versions
+if iptables-legacy -V &> /dev/null; then
+	iptables="iptables-legacy"
+	ip6tables="ip6tables-legacy"
+elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
-fi
-
-ip6tables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+elif ! ip6tables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without ip6tables tool"
 	exit $ksft_skip
 fi
@@ -112,10 +114,10 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	local tables=iptables
+	local tables=${iptables}
 
 	if [ $af -eq 6 ];then
-		tables=ip6tables
+		tables=${ip6tables}
 	fi
 
 	local counters values

-- 
2.40.1

