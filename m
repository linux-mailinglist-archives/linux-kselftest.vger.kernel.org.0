Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8915D67B046
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 11:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjAYKtU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 05:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjAYKtN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 05:49:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36686577DC
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 02:48:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id fl24so110804wmb.1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 02:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFeFjlVyq7czxhjI1VZOkS1166vM8kNK7PFQZae9ZFw=;
        b=0iKPrMjvnojdKykTl3Y1/BU4/slXFwnpzJfWxjP/I6zsxmz+F29haKh3nobyfuI3IW
         bqjYJVtT+5ztCCfSntHJQ5SJx03uRFH5pXXIq22DgpzpQa1eLr9i07J+Y7LiEyCkNKm6
         NThUMF6I1qgnneftd36p7AXonkFZ4fjDx2Cf0GIecMi1hMTV3YBQ5uJ4PB7HlvaiSi1/
         oRBrCGHNDowu8v/piALnxn7JEwYsqZAhjMoxbUauoLUMyiZadI3OJ+BMojvSf0L5s5uK
         XQk/E7ICtR3IbxMTP2hu/t721fxMCZ8AQF50hOY1pH5CCOtPnvfkkO4/LRJ3YqSxranL
         dpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFeFjlVyq7czxhjI1VZOkS1166vM8kNK7PFQZae9ZFw=;
        b=QslK+n8nTd8n+qUxAtE04uX90ACnXWSmgV78wrSEJ5u1Ui7jYGKc1SlviO1Crc9j2Q
         WFWERDzGzcDZCTO5P1Wg2YNdhh6I6dPKgzy+xucOXP/Kgg4UV1PTzTBL4m/e7ucfY/Nv
         1h/hrzATWUxCS/H3rBLZ2k6Tb+HnHzHxdEYykbcIQruZrv0+vQYk3RJgFe9Ur7Py76go
         MUrpTw+PXw0U0rsZKN502v6p54OHwDPyzmNHZyjN1eZ/2BFlI3zRviiILDhVQw8CMa2t
         JyRKE9+tXRm9VrfPzvUQFXQvw5EQpS6Kq0H/aay6i0mHK9/6N0mtTyx49V2SL+nNLW87
         A+Xg==
X-Gm-Message-State: AFqh2kr51pujEN9lDY8c5LEQFNSBtw8Nrg6pR9j2xACHjlPHs8ySrhbh
        ksfyqZzzcutHi83b5wxxnmD6OQ==
X-Google-Smtp-Source: AMrXdXvptRbQHSP6hhhCBCs0bBJe/vPxgaB1q3PVPjyhxjrcTt5/sIY7sxrQUXPnGUYSw/uRN2tP3A==
X-Received: by 2002:a05:600c:5390:b0:3d9:a145:4d1a with SMTP id hg16-20020a05600c539000b003d9a1454d1amr28227018wmb.34.1674643685887;
        Wed, 25 Jan 2023 02:48:05 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c424100b003d9a86a13bfsm1423692wmm.28.2023.01.25.02.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 02:48:05 -0800 (PST)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Wed, 25 Jan 2023 11:47:27 +0100
Subject: [PATCH net-next 7/8] selftests: mptcp: userspace: print error
 details if any
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230123-upstream-net-next-pm-v4-v6-v1-7-43fac502bfbf@tessares.net>
References: <20230123-upstream-net-next-pm-v4-v6-v1-0-43fac502bfbf@tessares.net>
In-Reply-To: <20230123-upstream-net-next-pm-v4-v6-v1-0-43fac502bfbf@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=XsnNPL7z5dm5JxMwwYbNAIpkerjh8rYMC069ugPLZRg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj0QjdsdzWwXQUyHiKXSu4ihI82o0WJpcgSCoHmMK1
 TvyVCcCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY9EI3QAKCRD2t4JPQmmgc6gPEA
 CMqwG7nLxieLA3rVdb76ZtJbgSbkOBnNKeFZCBy+C+1vwjyq8I9ZE9IxbcI1U4udabCNQFs9/k/K1k
 FJ+70fvbjcD3nF8+lNvlo5RPnO/lcGNePYs/IhrkvXEPtdlAeQZhS0Igj1ImL6fSoMKFJG+22UExot
 zUWug7JQlV7DFzJi09ZGJVaM2e9AoMMUucEJ2deTa7/+rXzxK0ChVf0q4PLzZwZEUJbNwAMLdk9boM
 dM/YiempXCSjy3Pfvt3nYJgXkVpUweoEatxVmV3L5QnI9WZCwbw6ctDJZ5qM5WrDrbPClmP6+I8hpu
 pkABtE85NQkphA23jxYZCQmX+M82xcfQbueyTyAvrs8x3hS4tFrX8mkfWHmn7zYdvjtShDNqmvaFhW
 +oXDlNB3uA+Qu8kgQO7kPCJAwgLqNXFukdk4zOlSoxCNZiwKQL7R2W4AF4ukYcYEgr8vkc3zyvYqN3
 07DIPkX2JIl1aDRQ+3L/kS0SXoerW8AdnqSQTwOEKPprQb2jytyGNiXgq48izc4EKMDcW09OYBpQp+
 8LFqzkTUoc31Bl+oO9w4/UxTAsi7iJ28IMhjtiYCXcSQ6rA9qorzoycBaQ8xW0FRISWiBTpOnm84de
 cg9MTYafJrq+JNNeVCWgxbMYRK9/1GjEOV+abhHHCI2vSgLYGcT03PB8XgMw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before, only '[FAIL]' was printed in case of error during the validation
phase.

Now, in case of failure, the variable name, its value and expected one
are displayed to help understand what was wrong.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 33 +++++++++++++++++------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 2f2a85a212b0..259382ad552c 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -201,11 +201,16 @@ make_connection()
 	server_serverside=$(grep "type:1," "$server_evts" |
 			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
 
+	stdbuf -o0 -e0 printf "Established IP%s MPTCP Connection ns2 => ns1    \t\t" $is_v6
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
 		   [ "$server_serverside" = 1 ]
 	then
-		stdbuf -o0 -e0 printf "Established IP%s MPTCP Connection ns2 => ns1    \t\t[OK]\n" $is_v6
+		stdbuf -o0 -e0 printf "[OK]\n"
 	else
+		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "\tExpected tokens (c:%s - s:%s) and server (c:%d - s:%d)\n" \
+			"${client_token}" "${server_token}" \
+			"${client_serverside}" "${server_serverside}"
 		exit 1
 	fi
 
@@ -225,13 +230,26 @@ make_connection()
 	fi
 }
 
-# $1: var name
+# $1: var name ; $2: prev ret
 check_expected_one()
 {
 	local var="${1}"
 	local exp="e_${var}"
+	local prev_ret="${2}"
 
-	[ "${!var}" = "${!exp}" ]
+	if [ "${!var}" = "${!exp}" ]
+	then
+		return 0
+	fi
+
+	if [ "${prev_ret}" = "0" ]
+	then
+		stdbuf -o0 -e0 printf "[FAIL]\n"
+	fi
+
+	stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+		"${var}" "${!var}" "${!exp}"
+	return 1
 }
 
 # $@: all var names to check
@@ -242,7 +260,7 @@ check_expected()
 
 	for var in "${@}"
 	do
-		check_expected_one "${var}" || ret=1
+		check_expected_one "${var}" "${ret}" || ret=1
 	done
 
 	if [ ${ret} -eq 0 ]
@@ -251,7 +269,6 @@ check_expected()
 		return 0
 	fi
 
-	stdbuf -o0 -e0 printf "[FAIL]\n"
 	exit 1
 }
 
@@ -303,7 +320,7 @@ test_announce()
 	then
 		stdbuf -o0 -e0 printf "[OK]\n"
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "[FAIL]\n\ttype defined: %s\n" "${type}"
 		exit 1
 	fi
 
@@ -837,7 +854,7 @@ test_prio()
 	count=$(ip netns exec "$ns2" nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
 		exit 1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"
@@ -848,7 +865,7 @@ test_prio()
 	count=$(ip netns exec "$ns1" nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
 		exit 1
 	else
 		stdbuf -o0 -e0 printf "[OK]\n"

-- 
2.38.1

