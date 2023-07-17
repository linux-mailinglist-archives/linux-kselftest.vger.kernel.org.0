Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4675647E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjGQNWH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjGQNVs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E54C1980
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbf7fbe722so46092765e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600096; x=1692192096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C19OOQjys4g0HZbyxfn1tMfB0ZlUmaAeplCvwpV4yU8=;
        b=kV3uMPCmfenfR9XYgoBJYMtkwY8ae2Sutqmrw4sXe3sPEP8pTMFjy7PI7baLLsfvgc
         dXTXoxmIpYMlr2reVA1Qrvgk0f5QSWbLj2Sm4BpCE59Dxz+TDRQgVFWOKvB4wg38oZ5Q
         sDCBgG0J4Q3zHhffNPUcQF/idNBhKv+D5/oLeZqCgD/baMgZEIrWSLrR3QMuDdvr1wp2
         M+B/Q1Ve8LvnFq7zBfDH84TCDi5gRixEbHKY/VdZk6mTdq4Kf1CKK477mopgA4w9Ga1o
         pU4zieiE9n5DtoJ2MzZLCKkb/lCb3YOFQ/kT3ar70cWRAVp9r1HgZa3H4aghcEUgVgA/
         XXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600096; x=1692192096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C19OOQjys4g0HZbyxfn1tMfB0ZlUmaAeplCvwpV4yU8=;
        b=Jh43KzOfBQoJvjLhdaEt+dmy6+L0ULqqFdsY6kO3Yvodz7WG3DZZa8tJGJN92apLMH
         JgZYc0OwIPATSAke6vGgtfb0w+dRQFYdXBZnYxt3N9iyN3m2iH///oQeizB85qcE1yvV
         p8PNFv95dqrlKIomXmV0AJAqt+jMvGEwnh0iH3WMM0IlyCKUhfObKaC/ArE091IXi355
         PdFOu4UUW5dEJKnfD+arxqvpNYI0hhSBgL2u784u0BxxPWWwzNmUJgAGC2Etkih5j7vg
         5VJS6yJ4LktHgKyZzeXJriFNq5iJX1DG8kXQXvHULthghWF/E1oRG3YC0hKPihk8x0IV
         Y7RA==
X-Gm-Message-State: ABy/qLaBbuPlJ+TxUfb1wIIhLvm+cFjtGknLCJ49JORkuc/oHkd3e5at
        Z/zYCgGDneNgxCTNt6EhykMR0w==
X-Google-Smtp-Source: APBJJlEHEKtYBQlHrAmHpe7KvaH3pOGz7GH9IagvGAJVNabSEEePcghaij24VGRT0fUDgYtLfNnO0A==
X-Received: by 2002:adf:fd4a:0:b0:30f:c012:b529 with SMTP id h10-20020adffd4a000000b0030fc012b529mr12388036wrs.56.1689600096776;
        Mon, 17 Jul 2023 06:21:36 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:36 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:22 +0200
Subject: [PATCH net-next 02/13] selftests: mptcp: userspace pm: don't stop
 if error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-2-695127e0ad83@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2583;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=qss0q7bvLOJAvB4X0z+6G5X/nAHFAPMEdRnJxgxYDi0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBdufpDnSGqM9fSwPxtyCcCBIzkSdpT4xGDp
 XwYzeG8l7yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 c9fzD/oDC4yV0L9hFbGiam/FWu7nxOXtN2xdtkmY+MNIPQYe3BtWmpYD6y03J2zZ4z5WzQhViOp
 x9Il8IxPjm2XVWBcGkAOO+h4lAsDcUGNv1sLK1tLykizSAEWZvbjASAVE0dYy9pDWdgcb2AT7BL
 Fz4xADpq0O2ex6NMkR1RLVJmBhJ5vBeOrbsViqPtXR+RdwUgA88nWFHIjTmnyNYvMSJUa5j/aXb
 OLk2YKq5QSNI1OrBjbET8n7OVEQ7BVYmQJZiGYNH6i2d1eYy9CfnOaC9I041wY0LQtIm49y+oje
 iy1f0sE8JUoDG/x3Dd4f3NG3YKTf9C3QMx2dNBJPrg4e1k7peDIW8RwGGFLagF1PSwhv0Uu44Fk
 /kWcfN04R8DtWwe2TIDftL/IkM5fjXS3N+d7aPJikIiFKi7o6jRx2ZrukO9gHLdhPIqfjNXcNxV
 +8JoMBlDRBtLq0rx944pZ0GQmH7UfrvjuKg0VDOMlSooP6AUE8Aqww4p0s4sIeI9/K8MfeWTo7G
 nHw/JSRtHj7IbJL7OWipVnFQkm1IisbBmF6buS3Qb6h+R9ATb5qUeu5OsHNzASX7jsvo20dQKGd
 fnFyWABiXb0v88frMjC4BLtwSedc6kgOZ/sRDVYsPmmsO0IQ7Sk01ICT9ZcpikZod+9HfqESPxC
 GViUa3FGaVlxcng==
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

No more tests were executed after a failure but it is still interesting
to get results for all the tests to better understand what's still OK
and what's not after a modification.

Now we only exit earlier if the two connections cannot be established.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b180133a30af..c57ce4df4973 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -52,6 +52,7 @@ sec=$(date +%s)
 rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
+ret=0
 
 print_title()
 {
@@ -257,21 +258,21 @@ check_expected_one()
 # $@: all var names to check
 check_expected()
 {
-	local ret=0
+	local rc=0
 	local var
 
 	for var in "${@}"
 	do
-		check_expected_one "${var}" "${ret}" || ret=1
+		check_expected_one "${var}" "${rc}" || rc=1
 	done
 
-	if [ ${ret} -eq 0 ]
+	if [ ${rc} -eq 0 ]
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
 		return 0
 	fi
 
-	exit 1
+	ret=1
 }
 
 verify_announce_event()
@@ -323,7 +324,7 @@ test_announce()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n\ttype defined: %s\n" "${type}"
-		exit 1
+		ret=1
 	fi
 
 	# ADD_ADDR from the client to server machine reusing the subflow port
@@ -423,7 +424,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
-		exit 1
+		ret=1
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
@@ -438,7 +439,7 @@ test_remove()
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
 		stdbuf -o0 -e0 printf "[FAIL]\n"
-		exit 1
+		ret=1
 	fi
 
 	# RM_ADDR from the client to server machine
@@ -859,7 +860,7 @@ test_prio()
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
 		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		exit 1
+		ret=1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
 	fi
@@ -870,7 +871,7 @@ test_prio()
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
 		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		exit 1
+		ret=1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
 	fi
@@ -961,4 +962,4 @@ test_subflows_v4_v6_mix
 test_prio
 test_listener
 
-exit 0
+exit ${ret}

-- 
2.40.1

