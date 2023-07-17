Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B39756491
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjGQNWL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjGQNV4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D767CC
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso47135695e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600103; x=1692192103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffO4W4EQWHxo8KIqV6iOyAqVl124f23PZCphXPbte4k=;
        b=GZ6kbwSRmtwJ9H8oQAfoPajp7rwgWWQXDMXZ0EgKAT5DXLgd7jeKshMFBHyU7onFnj
         bF95vFhkWt8KZfwF5cmKnaboYllwi30bWC0K6KC7fSDekhk1cs/66QFRX7KWfImzaNGK
         Wm7JlUsO91gbrZD7mx6t2tSUwxwe5+/24dIFkz4qS16jgoVCI4/w9viGnQCSoZWMbyIw
         dwFcykHacoB5zLZfTGbdGxlm07WsMqnkbrG5Ss4fFuEn+mco0QskNGspfsH2ibYxdw/I
         eoBzZfHYREYd138/jg+L9vHjsAXHE96XTo1xLzLDPRAXQgXZ+7bn0/3rj5hoBbfHEXOR
         NrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600103; x=1692192103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffO4W4EQWHxo8KIqV6iOyAqVl124f23PZCphXPbte4k=;
        b=UYPKDRuh4QYJ/rKF+kwKn3CRDnLtXiu+6nFqaJ++JsJpge8OsJJdur5+hlJTabZsBO
         V5rPokkgEFqLMiHwNPtUZiH20cOyzgjMp0iXDwm/rM2Exx+hW8a6zDqdCySKSAXb7CIb
         87Zv0F69hyZv2HX8du9BoDuinSK8Ytd1nOMILkUCWgRdthCwtlkSka2+PVQdCt1+pD36
         DaY00P3aZ6Kn+Z9BcdmfFhd1KJK6R00lmHnp69e32Iq/G6xQa2Vz6biptQJbOro8OS2h
         rCreAoQWyfcJZKo3CBv2FdTtw1W1pbWuALqbsZhX0rxDiiQdTdM9CuQCDzekvvMkftj9
         n8SA==
X-Gm-Message-State: ABy/qLZjVVoX0BGv0DG+AeyXqaIIoxzfx/XHcZT7zTtvhcBCSxOrrglx
        u55zsgHbW23mb27kOTsDWTMsbg==
X-Google-Smtp-Source: APBJJlE+swCqfwfWW8CZu6GIMx6TAqPUztdyPMl1HVwqJeXUp83LK01rJCNTLJey19jQh/EKMXv7Bw==
X-Received: by 2002:adf:f802:0:b0:314:3503:15ac with SMTP id s2-20020adff802000000b00314350315acmr10661582wrp.10.1689600103187;
        Mon, 17 Jul 2023 06:21:43 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:42 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:29 +0200
Subject: [PATCH net-next 09/13] selftests: mptcp: join: format subtests
 results in TAP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-9-695127e0ad83@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=NF5CIKc8WYRjOdcI7eA+jp7LCxbfGJNcFz42dEbqk4w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdJAXydFet2+2QoGL+wn0r5wPmaTMV1qF4Q
 AQbX/TVvoOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 c/Z+EACqbNbameFCixDbpc8StNWaeuTfwLcbViHXjPAaAKPKVeN/FdmR+pkQSP7ZlY8RQpcfqYS
 miGYRn9NP7zEsb/D2FizCOvE213sVA3OIGNlAcDX4nGz6aqGAJM1XIg5H9ZTcd4jwCzAW6ewR9q
 bV6wQuVD+9aLiDHyQOrS6IwgxezBafNF8nTk+2aKVAL/aDoNwqTjnp7T+V+JGeymQphbZAto6OD
 6J5KknYHdNm+2fmNGJ9VIJVJpd1YYTb/16hdzgHTZ8P1nZmxjhrrqW3IRVG4wM0gdaQw8xg7YPo
 TFzx7FJPsjG0KGnVY//YetjfeLT71KEnf7cg78Ee1v2bYNAYBAdpnaSPATGTOUaJ37AnE1klOmP
 suY/Vu/ASEKmX//j6IMV1LRe8tMd4gbErO38iGL2RhSkRKh+ksFvTyj4M1umCGStF+A76zj3yOq
 GT3CDpwt7D26ZPAXQxGZzXctkwBns3/HYonQ6xJCKYPQdAjgFPwT9vowwtUfIUEMhvk7jZrRM7U
 Zob2NQU58uPId4X3zrjpbVSWADBUmTM9F1PkUBP1/GYFmk+7dmiWYQGUHOOL5sjwy+b4omi/i9p
 Ii4L3yZlZ6Dh2cXLjv6K1d/TmJilJBmIhLvWNh/uR06c4uXf/FPH+t6XgllE1XPXz0OD0S19gPv
 Hynf1ni+73tru5Q==
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

This patch formats subtests results in TAP in mptcp_join.sh selftest.

In this selftest and before starting each subtest, the 'reset' function
is called. We can then check if the previous test has passed, failed or
has been skipped from there.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 37 +++++++++++++++++++++----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b5eeea4c3efa..f336f86d652e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -39,7 +39,9 @@ evts_ns1=""
 evts_ns2=""
 evts_ns1_pid=0
 evts_ns2_pid=0
-stats_dumped=0
+last_test_failed=0
+last_test_skipped=0
+last_test_ignored=1
 
 declare -A all_tests
 declare -a only_tests_ids
@@ -101,7 +103,6 @@ init_partial()
 		fi
 	done
 
-	stats_dumped=0
 	check_invert=0
 	validate_checksum=$checksum
 
@@ -216,6 +217,8 @@ mark_as_skipped()
 
 	print_title "[ skip ] ${msg}"
 	printf "\n"
+
+	last_test_skipped=1
 }
 
 # $@: condition
@@ -248,14 +251,32 @@ skip_test()
 	return 0
 }
 
+append_prev_results()
+{
+	if [ ${last_test_failed} -eq 1 ]; then
+		mptcp_lib_result_fail "${TEST_NAME}"
+	elif [ ${last_test_skipped} -eq 1 ]; then
+		mptcp_lib_result_skip "${TEST_NAME}"
+	elif [ ${last_test_ignored} -ne 1 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
+	fi
+
+	last_test_failed=0
+	last_test_skipped=0
+	last_test_ignored=0
+}
+
 # $1: test name
 reset()
 {
+	append_prev_results
+
 	TEST_NAME="${1}"
 
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if skip_test; then
+		last_test_ignored=1
 		return 1
 	fi
 
@@ -442,10 +463,13 @@ reset_with_tcp_filter()
 fail_test()
 {
 	ret=1
-	failed_tests[${TEST_COUNT}]="${TEST_NAME}"
 
-	[ "${stats_dumped}" = 0 ] && dump_stats
-	stats_dumped=1
+	# just in case a test is marked twice as failed
+	if [ ${last_test_failed} -eq 0 ]; then
+		failed_tests[${TEST_COUNT}]="${TEST_NAME}"
+		dump_stats
+		last_test_failed=1
+	fi
 }
 
 get_failed_tests_ids()
@@ -3599,4 +3623,7 @@ if [ ${ret} -ne 0 ]; then
 	echo
 fi
 
+append_prev_results
+mptcp_lib_result_print_all_tap
+
 exit $ret

-- 
2.40.1

