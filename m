Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B35472ACDF
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjFJQMO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjFJQMM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:12:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB73AA6
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:11:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7fcdc7f7fso18544525e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413514; x=1689005514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3P6DoN0vMoBt7/jBf5PoPo2lq1kqkFmcm+6WBlxPHlU=;
        b=ajj1rWhVU62cX0uvTmws1xN0lplftToZRkdNgw/Pk3ahobvD+VVB4jGJJBHmysni4V
         LLvwFH3zNo2qgsejEdK2F3Wgi9B8+imkOFaCenXyk3tZgX4tmyc1X4UoKZ5EIhf0Kkve
         9+oC3UXp+gd2KSg3ZCiQ/dkXXG7LmN2MDFzuAJY1Er/U0785pOL79CMygTkkOD5amD9i
         w9KQLqod0XmelCYzNVMK9M7VZnhXx5YErF0I9rAr95eQSbwZlhYPVGYbPydVBYSdwpnp
         Lr15oA34rlGKn0yC9e2XKvR5QI0V4mmsYlxeq/Qd0X0JqUzzSsmSGBBJh5WpoNwmWhRZ
         Lq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413514; x=1689005514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P6DoN0vMoBt7/jBf5PoPo2lq1kqkFmcm+6WBlxPHlU=;
        b=Nd7ET8+dtddwS4bhG1R3MftHcQT69yRd1xh8mDFZZ5w66GaWhn4bHO8m+3teEaWNvm
         AoclZsc7KCcCjU0RDCTUiSE5vLc6O0Hb2AZu1P5x+V1vIBz7Awd/4T/AOWcmzUYqRejQ
         TE/7g1zvA8tyE8wGl1o9GIW5jOlpuI9vy6IUSfyodjkXHhdj46HjlAkvbUb1yraHEcgO
         8K+zKtt23L4qKVcyt3k7IMJheeNJhjmHebVTPICrQ2VRwdLD8rE9a9ZNDvsmRXWpxKhT
         BQMkbAgJG7kQp9PoMbv5XdTb8YQGb9WGfo0wXxYQ6jb/nnGH6BSVmC6FIXQ3LYY+jukd
         mV4Q==
X-Gm-Message-State: AC+VfDwDipvlxVnH/mGZIbE9gj+FGFSkJv2Yb6DevVQlrAhr7BEZmW+q
        GE2Dj/Wn++XGeh6LpePd4GDOKA==
X-Google-Smtp-Source: ACHHUZ70KXXrALne5jgdnVR8SQBDi6i8gQr0OFGRLARgu7VOGXhUR0OFq9liIc2jQugKHRR80ZORNA==
X-Received: by 2002:a1c:7910:0:b0:3f7:c92:57a0 with SMTP id l16-20020a1c7910000000b003f70c9257a0mr4024882wme.14.1686413514722;
        Sat, 10 Jun 2023 09:11:54 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:11:54 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 10 Jun 2023 18:11:42 +0200
Subject: [PATCH net 07/17] selftests: mptcp: join: skip Fastclose tests if
 not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-7-2896fe2ee8a3@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hpK3COV30R7KW2JqTbaevEJpA95Jm3bfpnISdIK/9s4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC+h99A8gxcMN7TFLxmeK2y9vGpcbyYNipwv
 L3vn9yLC8qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvgAKCRD2t4JPQmmg
 cw6kD/9rz2Thh9KafcIBoVVXUXF0XchjzIIOePFKkS4fmrfx9ck2WUyZhTFMfh00hGyboSJvhET
 7BGtcOk/jEa/0k/CB6nWQwSXVc4W3VywSLbISuKbegio3lvKUh69mfRn56Nmcji2kdJzhickweO
 j0HOtVWYvWxP60DNwCCyMDqVY5K0jVaMRmodKYcPbbmcf4aFpUWUHZ9/fr2MtRhcde7+5/cLD31
 UY3h6V3Smy8nLmxLZVGLFOXSXJgAXkJYludt0Qi8mzMZPuDP37+W/BDSZC2piLuhSZMM+53YxUw
 2hdza1o3hTb+5ztWj8EJnVV39l1DQReedHLT4tdRWNT+N9XxFKTLD50oAzLtu2eBgfThhRPBS/4
 1e2Jvp/R2iUpPldcJ80HH4a622KvBcH4zQL5FKHpvCFghbMwDVZySv4UIKff5QVZsn6CGKXG4bk
 ssiztdb21Thh5kXsUl1eFk4Z9Y3YbxjzR5pM5RlTLCZ1U+WDxqhq3GLb0GfadOOkyuYUlr5Acj0
 hEseHiYeh1RDS7tQcsanYGrbTSdxjm/fqb7WzHZnmrlYcA5nQMvnISck/4w6+XEphnhRcEoQHDn
 QRNJPwnRPLbGLL0JsOq8IZJx+gwW0zxJSe4dlYvZLAQU2GFjUdES91+5+iECGdAM0ubQOMX2sJh
 0T8iNIYSnmZo2nQ==
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

One of them is the support of MP_FASTCLOSE introduced in commit
f284c0c77321 ("mptcp: implement fastclose xmit path").

If the MIB counter is not available, the test cannot be verified and the
behaviour will not be the expected one. So we can skip the test if the
counter is missing.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3da39febb09e..cfd43037c6d5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -261,6 +261,19 @@ reset()
 	return 0
 }
 
+# $1: test name ; $2: counter to check
+reset_check_counter()
+{
+	reset "${1}" || return 1
+
+	local counter="${2}"
+
+	if ! nstat -asz "${counter}" | grep -wq "${counter}"; then
+		mark_as_skipped "counter '${counter}' is not available"
+		return 1
+	fi
+}
+
 # $1: test name
 reset_with_cookies()
 {
@@ -3121,14 +3134,14 @@ fullmesh_tests()
 
 fastclose_tests()
 {
-	if reset "fastclose test"; then
+	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
-	if reset "fastclose server test"; then
+	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert

-- 
2.40.1

