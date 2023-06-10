Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B084B72ACD1
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFJQL5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFJQLx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:11:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40130E4
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:11:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so20621775e9.2
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413509; x=1689005509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbCMcIUx++P6SdtXKp4v0Xqp9nJ5C2WK+DmOSVFkYWI=;
        b=OkrifqmXX55yO4FkuGabclI2bqoO6y31QHS0r9xw/jLI+lO52u5kYKZduErpx/V/bD
         ARYC6z4PZnqkEvQzfajdeZ+NhlkixaBJD2GNH4lo27KNXUOsUmiAfDnHV8XEHAn33TwR
         tWi16rZHVucUexDXiLob8dosG/aKk7E5YMz0LkG6cKcPZiodzry0lFjHghVVk8VhMFMi
         5TtPRAvgOyEp44yhwA6z9xgeW9Xx7sCTodA3dXa05YjcNxjqTSNm255l/Av94O+qyuS8
         n2L57Ke2b+0X6KksWQ9QTlIDO/Bns4x7mJ8Fqmc1cCMrTjVLnHWZrpUIjCexXJZI65Df
         3fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413509; x=1689005509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbCMcIUx++P6SdtXKp4v0Xqp9nJ5C2WK+DmOSVFkYWI=;
        b=HKqnjyjy9IT+N4WVpEdFwYbnOCT4/gyCWK50GppoSs7n7Tjo0Sdz23RKpE0BNiq3WA
         //YnUk1zSKwKQBm0kaII8IuaQW85D4Y6MswbEKN1Ur5Sg3J895p9QjLQkjgT56BK2eWq
         sO0RTaHVHX/SzU9mSSQN9C1zGstwftRJmt1dN/fcGQkJmHjLLBrneGUfijr4D5YPPR56
         +dJgJqpEy5q+xxEMhDXQV9BPA7SrYSkERWE1MQHBACGvJXoowL19xAuc64UOjxyEjohf
         lN3u95jF3PvkIq49DKzSl/k7orKjl8rFWPfX9Scrs1N3Ds4wWxeBPJpH8AYDTDKHR+iw
         xXaw==
X-Gm-Message-State: AC+VfDxCGzGXpSAGjpCj1rkm0uiMgrd3/u34rtau1N5V8TjqpYCqrKLm
        R6HahrbBx8D2uW+e/9Doz0bdyA==
X-Google-Smtp-Source: ACHHUZ5wlz6A6rIrbQvMeFaiq5asxJYrpA4MR7RzkZ2k6tR9yrG+PNtzsvJBrkaLVHeDVziVC9ETJQ==
X-Received: by 2002:a05:600c:3785:b0:3f4:2328:b5c2 with SMTP id o5-20020a05600c378500b003f42328b5c2mr2977964wmr.35.1686413509234;
        Sat, 10 Jun 2023 09:11:49 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:11:48 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 10 Jun 2023 18:11:38 +0200
Subject: [PATCH net 03/17] selftests: mptcp: join: helpers to skip tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-3-2896fe2ee8a3@tessares.net>
References: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
In-Reply-To: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-0-2896fe2ee8a3@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Geliang Tang <geliangtang@gmail.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=Lz+CG90Q/jYCqW9q9yYPKVP+ZrLRJq5EixGj4YlvfsI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC9J8WtCudLHdu3pw2KRPMvFMZqLF+DxvfkK
 FVZhqBJlNOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvQAKCRD2t4JPQmmg
 c6HxD/9O/MNGyJjazN49T9UQv63fgVXYnatJP7GDD9kQX0OYx61bP3EnSR66Kh7fiTFvnz4/tKZ
 Q+oKGIiBYx1moIqeIXkFpenYehlPHAHXx4c5/39x2nJkWmyOoY8/9RUhIErdpmAk/0FvVHOBaIF
 93CYxPcWShett7MrQnXx0xZtudzxhrLMesJqAcW71bWeJElSNnyCB7jB7wkuEpNyMYFb5rlsWWM
 Hph1em3uYE2n7rrnKTsQLNxbobiiyeGaR3jx7wsvN/yw9Aw9+Ymr8fkx1gedHT8J4v+YfuenKnd
 7Zp0FY94LBDeTqXXPuPW0Df+6n9/amNQdT1oPpvin5gzxgdG9YlLZOPykVmA2dSMQPqsOGdKzNs
 8EyUFBLDkL7RQx6Kn26snCvnBxzWv76VnT+JIF/uFCoPrX4Mf8NmoaG5Bo/DlT7Wi0gF5DKXMOZ
 qjAa7WSFeXTuajNDhEFWT8aFZaYUm+yPBO6Yaed8bxptsUHdYjqBf9td9Fz1w/FWM1b8423zDJj
 CnwzDE34Qxh3WRstPo2A6sh+Widdt9+hG1YrmunwEYsSFkqlhflVPJJU82YaIAiF9I3PdB7C5VO
 pQ7lrIEZ/tUifWUE7JrJsg8WDsevx0WFJAgYEOW3ds0D1gNPuToO/exvZULEiOCLjWh6HZrDq1w
 d0DBsdLnDgS+7wQ==
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

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

Here are some helpers that will be used to mark subtests as skipped if a
feature is not supported. Marking as a fix for the commit introducing
this selftest to help with the backports.

While at it, also check if kallsyms feature is available as it will also
be used in the following commits to check if MPTCP features are
available before starting a test.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 74cc8a74a9d6..a63aed145393 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -142,6 +142,7 @@ cleanup_partial()
 check_tools()
 {
 	mptcp_lib_check_mptcp
+	mptcp_lib_check_kallsyms
 
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
@@ -191,6 +192,32 @@ cleanup()
 	cleanup_partial
 }
 
+# $1: msg
+print_title()
+{
+	printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${1}"
+}
+
+# [ $1: fail msg ]
+mark_as_skipped()
+{
+	local msg="${1:-"Feature not supported"}"
+
+	mptcp_lib_fail_if_expected_feature "${msg}"
+
+	print_title "[ skip ] ${msg}"
+	printf "\n"
+}
+
+# $@: condition
+continue_if()
+{
+	if ! "${@}"; then
+		mark_as_skipped
+		return 1
+	fi
+}
+
 skip_test()
 {
 	if [ "${#only_tests_ids[@]}" -eq 0 ] && [ "${#only_tests_names[@]}" -eq 0 ]; then

-- 
2.40.1

