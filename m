Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FEE75649F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjGQNW0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjGQNWA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:22:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23F1993
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso46231765e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600107; x=1692192107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3swvJblXFY7hepLBKVBwcTERoJ/lBHHAZ93IzbSTQjY=;
        b=B1LieMi6ssPJ6jk46giSdZsI6Tg+Pu6AhOJX7PpJakn5AlzLtdlEZc2DShoKW5tBga
         uw33oR0TTXnriONrH16jPtdmF/wpkd9ckyMpa2X+RXTyd2qD6VJOuqPsNdHV/Lbz6a02
         8vNKICuKsEO90ny1gYraZttYqPiUL+r++lYuCQUZIX06gMiheUzqFuGL7hC7bJ3ldu0i
         43Lj049E1wKRJV1G23AWRRQCb1mlEadrhdfqPtNzAnKySudVSa6vmW2T4bTPI1Po1xwt
         LkDBbYAtgjSCPHJNunupxAw7+eMmspJv3AAM1a/K54YFv/EAwY7ThbyaUAMYpUy7qOBy
         F3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600107; x=1692192107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3swvJblXFY7hepLBKVBwcTERoJ/lBHHAZ93IzbSTQjY=;
        b=NSVRMIzvt4E6hiFdSuNLG/6V8sC2GxO0FyD41BzdAEkoJfiJC4Pn5B3IWOFwPBJO50
         I17x4GiJlEQ3ii4fvkmwW7g4Mfs/Cxl6FdGBJ9C3a9Z6pSmt1QTJsHfEIKeVF75y1I3w
         pNggF9V/SXpuDuKEooeeJMdfegRhQKxktH5QJieP7vbka6NIVf03kxbBRNSlXUFtnjN7
         DvjaFtYiQPGvhFA2Ys0gzJyxtCuA4OQyuuTYgO+soVceDNBGAxDizy/rZ1vMWQhKEpfO
         II2q6oTcXEv0jsIPHBWWrLUrcp/lztFw870ycPBFDwr3miMYe8N67KP2bd+ncUP2xVK4
         Gysw==
X-Gm-Message-State: ABy/qLbnV90xCFgv/5fLMLhoC33leosFa57J79MU3M1sjYv/farJVb6q
        R4ta8TCffVuZL4uMcXZbXyIlTg==
X-Google-Smtp-Source: APBJJlHgqSF5fcJ+5E/hmltr5E2vBzYHvG+Fihohvt0b/KBDtXxiDjKfH2dC7wrqbk71uzAjm4UPsw==
X-Received: by 2002:a5d:5107:0:b0:313:fbd0:9811 with SMTP id s7-20020a5d5107000000b00313fbd09811mr14268710wrt.3.1689600106919;
        Mon, 17 Jul 2023 06:21:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:46 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:33 +0200
Subject: [PATCH net-next 13/13] selftests: mptcp: userspace_pm: format
 subtests results in TAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-13-695127e0ad83@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=O6m1LM84cxrhhzI8uWlZLQYgX+bS7UA+N6Jx+FLdCoQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdvgkqpMjTpRYU+Ynhi6pWe5f+5yr3Y8IC5
 ZB2gwG12gaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 cwvjD/913+F5NjBK/NaWa6bzohUakXQmYfy5cnrNVwS1lbjMgcVY/nMkyhC504v3AodOd2+cx+D
 QKPBYsWhHcWruoVc6/xBqVJP0etAq07k+DD3TDeBZ3oN6APa+X7iMre55R7I+82QZvhiwV6ITs+
 vLl++8X7rcsEzD4sdeMlT7b6AvlDpKRxzrvYacamSlYl741L9pNFBHI+/iXPQvfID9mww+mCVZE
 oABkUyObyyWB2a34yQcS2ItCP+Aex08iUWuRb45wk/X7X16tpdOmp9//FkUI7PdzJKGaixl5GVD
 Ecx8/hxzkCA3z1NsLmYoMf0v2l1sgxtHda1yH9UbTt4CIa3ZfP6GgDFhKnL9QiWH3LJ21COVBqW
 xpGtITHMaxJCQzDaTfx60bY8HNKFXBYmr9MVXJEl7XsP+JjpiewL+bloHhOyuwSsmoLnAyBeOXX
 uW7pSO4kElxj2KpGMwdjvrM5EmWPcVskMddbgyqu/GijABePDGr08JUO40OcWMiLN2nJwYHAHCE
 ebWAzOcZRvpnoRfcci3M6cuJNkJ4myykCWy1U5kJZx3wgdEXn/GlZFTyuJacP+Dc8R0AlKThhr3
 onHe3OORLV6YxAoDg5cISzeC2TLZdZYsKIrO8Egpq6p+NJdOCcZB5BPFprrxXOSGN+HK/WBS7Uc
 HijGL6iTslgB+Ig==
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

This patch formats subtests results in TAP in userspace_pm.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 568ddee1d102..23f8959a8ea8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -59,6 +59,8 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
+test_name=""
+
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
 }
@@ -71,7 +73,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	_printf "%-63s" "${1}"
+	test_name="${1}"
+
+	_printf "%-63s" "${test_name}"
 }
 
 print_results()
@@ -82,11 +86,13 @@ print_results()
 test_pass()
 {
 	print_results " OK "
+	mptcp_lib_result_pass "${test_name}"
 }
 
 test_skip()
 {
 	print_results "SKIP"
+	mptcp_lib_result_skip "${test_name}"
 }
 
 # $1: msg
@@ -98,6 +104,8 @@ test_fail()
 	if [ -n "${1}" ]; then
 		_printf "\t%s\n" "${1}"
 	fi
+
+	mptcp_lib_result_fail "${test_name}"
 }
 
 kill_wait()
@@ -255,6 +263,7 @@ make_connection()
 		test_pass
 	else
 		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
+		mptcp_lib_result_print_all_tap
 		exit 1
 	fi
 
@@ -990,4 +999,5 @@ test_subflows_v4_v6_mix
 test_prio
 test_listener
 
+mptcp_lib_result_print_all_tap
 exit ${ret}

-- 
2.40.1

