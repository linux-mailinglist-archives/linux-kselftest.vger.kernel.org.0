Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBFF756495
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjGQNWM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjGQNVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06275D7
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3163eb69487so3215430f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600100; x=1692192100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sFM/s1HCkd2y/ZrvPPAnShJqUMBsuZAAEx2AZaOCcE=;
        b=kw5iGD4U6Sq9FcNhR3jXMmUdxt0chBpyC8TSKuYHC/lk5VhnuMruHlHGF9pHbMHstz
         OhnnJ3If0RPnTwlebXxoFcqxa4XG+RhXRZ4xq/HDnCwasT0RvqwGnPfVXL13GFEEnnH9
         b5OAmR6rGXf4TyP8LVwaQEfq0VAhxD794z1CTr8iCZ69pcU4W1cJxYFpxHmO3KY5YOXA
         K0fOb8coiaVEEw6Ig5eOH/n8c6eGK8LHbliOUrKy/Xwj/2qlOGQJKgkjLVhYHAuxyNz+
         n0IWmTR7fw2uyWrcDmqXiZ3oyiolu1kVmA7Lh7lwK8GwOYt/awbzqhEc2S55yICP3nWv
         7MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600100; x=1692192100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sFM/s1HCkd2y/ZrvPPAnShJqUMBsuZAAEx2AZaOCcE=;
        b=VdtOUTYQlQ7Z3NUXCbXJc//ijoWzziSdouwPtRfShRpbJCJKaA7sNdynb/WvjyLoNI
         Cv1lRDoWi7eNJztwMtqI/KqYLGjKX1Mo0yAVBQocKqlPcRJdVr82IgNHPY2Oa9JOjVc3
         8IsZwua1TrVjNaOVNxB6+anjQG5H10Yz9BFEUQ30tW+oI68VSCg8CmMs0NPJCSihfGwU
         dt9YAl7gGsoIkzJh+ltQFC+naoJG9RfrWFEyn108Pe3HLow06n9B/4sZHYwneXXzDGJn
         il7AyJbCPxXDfheIftF3XplUCb9g4CvRaU/TxypFKbOM7ghagaa/MGpyEf871aV87/EV
         Ym0w==
X-Gm-Message-State: ABy/qLa5VKrI+pgHrmslppSvWxDjmIJ9prOA+Gb6wXOquW8GXuhNcRpt
        xHG6Q4agKSEUgFKCd2K8d6SXww==
X-Google-Smtp-Source: APBJJlGiALHxDwrbtLccbfF7x8XUgCJlF1OCxCsCxPGUxxeQVTarypdgVv8791c8Om+i6UQZjKDByQ==
X-Received: by 2002:adf:e882:0:b0:314:1b87:b76d with SMTP id d2-20020adfe882000000b003141b87b76dmr8322681wrm.30.1689600100441;
        Mon, 17 Jul 2023 06:21:40 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:40 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:26 +0200
Subject: [PATCH net-next 06/13] selftests: mptcp: lib: format subtests
 results in TAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-6-695127e0ad83@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3366;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=QXvyVB9sLKzsjse1ydzYpcK9r0QZKo1R9dEoREA7hII=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBddDGhfpQo/ZAKz2ol2EKOKbqCPjllS1O8P
 6kJeQYWxXiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 cw3GD/sGayBZe27cfQlJmwiMT0Vau+FecxDX0sNidQMHpZHPectEiQz8sDu4JjlYK32vbYXxo7L
 TkQ7goFhVdULvsJmwrDyxcfd7ss+Y2pwZyOl2mf0oIHEC/ZUhpcK/z5IdAFlnWcp438DMYcEaXm
 Q90D3+gcnIHYf3+h7EBR1SMEsW68MLmSK817XIWsd0dT2BKv+8LhZVeTe+oerxmGn59k6pir1ua
 xYHq8bdQWnix9nAv0H0s8JaTpxKx/Y90+0hRH4k48S6UR93NOrJFT8FqOgwl/ql24ZyxM0WYZfz
 yjC1pMCI3kZXNbrD1vVliusy9hxeEhAAZDHdXQdVgDXnTMd5+pehc9I+AuNKZQxqJT8s1Ym4ReM
 fE4Ua1oXGcWHAJ+/nDGCNnDCRgyK/QTc4UkennWOIcH0KqwHz1hIgUFW5A66DUPBuAhuclnHyta
 1OYVHT+vpie0KlLUiShR2AJ4lyPNPkReI0cGwQGPRIHU1V21e5TlzAxVkEM0HzZPgv7xRPWUUzz
 YABN//gYvz5/whm7PzmCQhDk74lEQ0XECTLlOQtPgi/mG9BrT1wrfgYj+FoPrUcW3qhiOlcIiK1
 elUQX7Qd3duhXupIOpOBk0PY0uxbTFvPuHtpCoul/jY7hJ2AS8/XVBIVR9Agxz5TZGrG+H1Rpk0
 8AmKYYN+Mp5VYqw==
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

This patch adds some helpers in mptcp_lib.sh to be able to easily format
subtests results in TAP in the different MPTCP selftests.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index f32045b23b89..b1a0fdd0408b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -1,8 +1,12 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
+readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
+
+MPTCP_LIB_SUBTESTS=()
 
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
@@ -102,3 +106,65 @@ mptcp_lib_kversion_ge() {
 
 	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
 }
+
+__mptcp_lib_result_add() {
+	local result="${1}"
+	shift
+
+	local id=$((${#MPTCP_LIB_SUBTESTS[@]} + 1))
+
+	MPTCP_LIB_SUBTESTS+=("${result} ${id} - ${KSFT_TEST}: ${*}")
+}
+
+# $1: test name
+mptcp_lib_result_pass() {
+	__mptcp_lib_result_add "ok" "${1}"
+}
+
+# $1: test name
+mptcp_lib_result_fail() {
+	__mptcp_lib_result_add "not ok" "${1}"
+}
+
+# $1: test name
+mptcp_lib_result_skip() {
+	__mptcp_lib_result_add "ok" "${1} # SKIP"
+}
+
+# $1: result code ; $2: test name
+mptcp_lib_result_code() {
+	local ret="${1}"
+	local name="${2}"
+
+	case "${ret}" in
+		"${KSFT_PASS}")
+			mptcp_lib_result_pass "${name}"
+			;;
+		"${KSFT_FAIL}")
+			mptcp_lib_result_fail "${name}"
+			;;
+		"${KSFT_SKIP}")
+			mptcp_lib_result_skip "${name}"
+			;;
+		*)
+			echo "ERROR: wrong result code: ${ret}"
+			exit ${KSFT_FAIL}
+			;;
+	esac
+}
+
+mptcp_lib_result_print_all_tap() {
+	local subtest
+
+	if [ ${#MPTCP_LIB_SUBTESTS[@]} -eq 0 ] ||
+	   [ "${SELFTESTS_MPTCP_LIB_NO_TAP:-}" = "1" ]; then
+		return
+	fi
+
+	printf "\nTAP version 13\n"
+	printf "1..%d\n" "${#MPTCP_LIB_SUBTESTS[@]}"
+
+	for subtest in "${MPTCP_LIB_SUBTESTS[@]}"; do
+		printf "%s\n" "${subtest}"
+	done
+}

-- 
2.40.1

