Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCB756493
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGQNWJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjGQNVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683F5172D
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3141c3a7547so4264478f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600099; x=1692192099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XP0y7t3kq38V56UBCnjCXyTrhLSaaVq0nk76VWsX+IM=;
        b=ZYJOez/gty3uTPWvjzQvz+z6jeL9ECgaes6dymaXHQ8qLGCu5XWzRGLUSr3Dsyr3yp
         aaz+IuBwWg8/QtyGidmTEy3AiUa8CPuM1J+ZINPDOphEvCJTqL/DbTH16AMdk6uZO/ut
         jf4k4kKvZMN8gVzoz0AqNWCkzLUQadBsAN1RETkoFIDUDKZsaLP9LD/ijCZVwsUZK4n4
         e/J5S41Ge3Rw/t3F/nw6jO0PLvY5wbt+MrXRMxvtshm/Bh88HRhRNpb/eigNFA48VY8G
         G4hAf6WFCkwnCNsz/92Ki9OILdGt1KKD3PlxZgR9H5J4sjiyeQqlvHXo5MaaRVpnOxJY
         NUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600099; x=1692192099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP0y7t3kq38V56UBCnjCXyTrhLSaaVq0nk76VWsX+IM=;
        b=XIBpgrIGa3l/NNiSzg7kRQn3p4HOI7VUWOgZc7qP8FaOO9xKXTDOpZ6Y9IkTKTnr4C
         eQHDpDgZWvz5sIErHXvJwtGXEg7i0nuzgrpfdBIJgnkcuWvQtzYt1Fmkj3gilCR81MSK
         OrRJqhmbZsaiSvRvpYEQdtrfMDiFFwGTGEA8lpKknkBDhX0ZQj2wd+rW+nnOUYk7ykQA
         jTrex/1M0D9ncFcc46vowDNfv6EiI6gf/Vgrq2dmtGwy3XJ1QPWXGW0NUY8sBtoyi/3U
         wVAB0sQg3roWTX8Y2h0Oil5NLYudxTCTNakG5yxbpPWsTKPfmRv6VOXhCsXuQAQQ8+aP
         tyNQ==
X-Gm-Message-State: ABy/qLbxL6Y6p9CNb42Hey/ylDu1INGYvk2wXeGdvmv+fyXduTvmqfFk
        hQENM9tUNb10Y9iIBKmeJBP4sw==
X-Google-Smtp-Source: APBJJlEz9IgYxbe1QRGZ/qEyAqpzgMsPieM4udr9jun+7w7MCNlaDLscGbQiJaaHth0yMi2Iu34uDw==
X-Received: by 2002:adf:e803:0:b0:315:99b8:c785 with SMTP id o3-20020adfe803000000b0031599b8c785mr9675003wrm.9.1689600098568;
        Mon, 17 Jul 2023 06:21:38 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:38 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:24 +0200
Subject: [PATCH net-next 04/13] selftests: mptcp: userspace_pm: uniform
 results printing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-4-695127e0ad83@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14131;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=erirk5vwpzG3y2MaLJIyNr7TNxmUcEQylQYgZzgEYWA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBd3HO3rKIOVwGcsCZmwax1K+iIUPWW609gT
 qxbU+NrNdOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 c8T+EADUuZWa8qPonpyga338l06ws6NDvhEcKN3SAkbG6/Phy4gGjwsOJlz1dglvNgFaLRr9+C/
 YNxewXd9RhsC1/7gSo28zFQsbVGxccTfyCX2mF3jSEiZnaLabrVIs/Pv4stuRSgxzPh72s/mNie
 x62btovYNxFGBUZcmetoC31C42sfblxq6Yvv+BLF9SdAa3b3ctWM9xs94H1xVKOkcLVaMJVHtsU
 RInqkqX3K4GUkMPB+mJ8uj07jg+afoyqIRx83/kCj2Er1378Fy/JReAL1mZLYGWOTBq7wzF7S5i
 z1eupGzlyOK2CoVvlKkjT5XC37hfEZoMOYgEctTkaeFLYpncVQnJexaKovoucyohANjpgwps1o2
 lIGtYopjO0+1LeA2ARg6uoPpkGC6IofIxxS+z6AxeVUgTDCr475EtLLAq9RxcBJnLtoFPtUaAcZ
 YBrw0JuQntn6bqy4Vor22BeVrpJvnK+/lBrV0Fxq1VJBUCOSZntT4TAUMCgHIDjpjTjARsAxb4A
 LNNuh3n+qATmvkKhtvzSiCy6Rh3JBFVEsMMAPV64W4eu0Gw4foLAXHTVYH/DQdWVk0HGr4Ddmyd
 nPDNNb9BngkKJoqEYpr8d10dFyHZJwzoP3E1P6jCnjTTx6YZae60vl5/QO1TpKejJRtLwzOredw
 fCBSVjLN58fhPXA==
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

There are a few reasons to do that:

- When the tabs are not printed as 8 spaces, some results were not
  properly aligned

- Some lines printing the test name were very long due to the use of a
  lot of spaces/tabs at the end and stdbuf at the beginning.

- To reduce duplicated code, e.g. to print what has failed and set the
  status

But by centralising how the test results are printed, this also prepares
future commits to avoid more duplicated code and ease the tracking of
the different subtests.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 141 ++++++++++++----------
 1 file changed, 79 insertions(+), 62 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 63d348693e98..6b733b97d358 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -65,6 +65,38 @@ print_title()
 	stdbuf -o0 -e0 printf "INFO: %s\n" "${1}"
 }
 
+# $1: test name
+print_test()
+{
+	stdbuf -o0 -e0 printf "%-63s" "${1}"
+}
+
+print_results()
+{
+	stdbuf -o0 -e0 printf "[%s]\n" "${1}"
+}
+
+test_pass()
+{
+	print_results " OK "
+}
+
+test_skip()
+{
+	print_results "SKIP"
+}
+
+# $1: msg
+test_fail()
+{
+	print_results "FAIL"
+	ret=1
+
+	if [ -n "${1}" ]; then
+		stdbuf -o0 -e0 printf "\t%s\n" "${1}"
+	fi
+}
+
 kill_wait()
 {
 	[ $1 -eq 0 ] && return 0
@@ -127,7 +159,8 @@ ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
 ip -net "$ns2" link set ns2eth1 up
 
 print_title "Init"
-stdbuf -o0 -e0 printf "Created network namespaces ns1, ns2         \t\t\t[OK]\n"
+print_test "Created network namespaces ns1, ns2"
+test_pass
 
 make_file()
 {
@@ -212,16 +245,13 @@ make_connection()
 	server_serverside=$(grep "type:1," "$server_evts" |
 			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
 
-	stdbuf -o0 -e0 printf "Established IP%s MPTCP Connection ns2 => ns1    \t\t" $is_v6
+	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
 		   [ "$server_serverside" = 1 ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n"
-		stdbuf -o0 -e0 printf "\tExpected tokens (c:%s - s:%s) and server (c:%d - s:%d)\n" \
-			"${client_token}" "${server_token}" \
-			"${client_serverside}" "${server_serverside}"
+		test_fail "Expected tokens (c:${client_token} - s:${server_token}) and server (c:${client_serverside} - s:${server_serverside})"
 		exit 1
 	fi
 
@@ -255,7 +285,7 @@ check_expected_one()
 
 	if [ "${prev_ret}" = "0" ]
 	then
-		stdbuf -o0 -e0 printf "[FAIL]\n"
+		test_fail
 	fi
 
 	stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.\n" \
@@ -276,11 +306,11 @@ check_expected()
 
 	if [ ${rc} -eq 0 ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 		return 0
 	fi
 
-	ret=1
+	return 1
 }
 
 verify_announce_event()
@@ -326,13 +356,12 @@ test_announce()
 
 	local type
 	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
-	stdbuf -o0 -e0 printf "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    \t\t"
+	print_test "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token"
 	if [ "$type" = "" ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n\ttype defined: %s\n" "${type}"
-		ret=1
+		test_fail "type defined: ${type}"
 	fi
 
 	# ADD_ADDR from the client to server machine reusing the subflow port
@@ -340,7 +369,7 @@ test_announce()
 	ip netns exec "$ns2"\
 	   ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id $client_addr_id dev\
 	   ns2eth1 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.2 (ns2) => ns1, reuse port \t\t" $client_addr_id
+	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
 			      "$client4_port"
@@ -349,7 +378,7 @@ test_announce()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann\
 	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR6 id:%d dead:beef:2::2 (ns2) => ns1, reuse port\t\t" $client_addr_id
+	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
 			      "$client_addr_id" "$client6_port" "v6"
@@ -359,7 +388,7 @@ test_announce()
 	client_addr_id=$((client_addr_id+1))
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
 	   $client_addr_id dev ns2eth1 port $new4_port > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.2 (ns2) => ns1, new port \t\t\t" $client_addr_id
+	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
 			      "$client_addr_id" "$new4_port"
@@ -370,7 +399,7 @@ test_announce()
 	# ADD_ADDR from the server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.1 (ns1) => ns2, reuse port \t\t" $server_addr_id
+	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$app4_port"
@@ -379,7 +408,7 @@ test_announce()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR6 id:%d dead:beef:2::1 (ns1) => ns2, reuse port\t\t" $server_addr_id
+	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
 			      "$server_addr_id" "$app6_port" "v6"
@@ -389,7 +418,7 @@ test_announce()
 	server_addr_id=$((server_addr_id+1))
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
 	   $server_addr_id dev ns1eth2 port $new4_port > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR id:%d 10.0.2.1 (ns1) => ns2, new port \t\t\t" $server_addr_id
+	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
 			      "$server_addr_id" "$new4_port"
@@ -423,39 +452,34 @@ test_remove()
 	local invalid_token=$(( client4_token - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token $invalid_token id\
 	   $client_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1, invalid token                    \t"\
-	       $client_addr_id
+	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
 	local type
 	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	if [ "$type" = "" ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n"
-		ret=1
+		test_fail
 	fi
 
 	# RM_ADDR using an invalid addr id should result in no action
 	local invalid_id=$(( client_addr_id + 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1, invalid id                    \t"\
-	       $invalid_id
+	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
 	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
 	if [ "$type" = "" ]
 	then
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	else
-		stdbuf -o0 -e0 printf "[FAIL]\n"
-		ret=1
+		test_fail
 	fi
 
 	# RM_ADDR from the client to server machine
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1                                \t"\
-	       $client_addr_id
+	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -464,8 +488,7 @@ test_remove()
 	client_addr_id=$(( client_addr_id - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $client_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns2 => ns1                                \t"\
-	       $client_addr_id
+	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
 
@@ -473,8 +496,7 @@ test_remove()
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
 	   $client_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR6 id:%d ns2 => ns1                               \t"\
-	       $client_addr_id
+	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
 
@@ -484,8 +506,7 @@ test_remove()
 	# RM_ADDR from the server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns1 => ns2                                \t"\
-	       $server_addr_id
+	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -494,7 +515,7 @@ test_remove()
 	server_addr_id=$(( server_addr_id - 1 ))
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
 	   $server_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR id:%d ns1 => ns2                                \t" $server_addr_id
+	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
 
@@ -502,7 +523,7 @@ test_remove()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
 	   $server_addr_id > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "RM_ADDR6 id:%d ns1 => ns2                               \t" $server_addr_id
+	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
 }
@@ -529,25 +550,24 @@ verify_subflow_events()
 	local dport
 	local locid
 	local remid
+	local info
+
+	info="${e_saddr} (${e_from}) => ${e_daddr} (${e_to})"
 
 	if [ "$e_type" = "$SUB_ESTABLISHED" ]
 	then
 		if [ "$e_family" = "$AF_INET6" ]
 		then
-			stdbuf -o0 -e0 printf "CREATE_SUBFLOW6 %s (%s) => %s (%s)    "\
-			       "$e_saddr" "$e_from" "$e_daddr" "$e_to"
+			print_test "CREATE_SUBFLOW6 ${info}"
 		else
-			stdbuf -o0 -e0 printf "CREATE_SUBFLOW %s (%s) => %s (%s)         \t"\
-			       "$e_saddr" "$e_from" "$e_daddr" "$e_to"
+			print_test "CREATE_SUBFLOW ${info}"
 		fi
 	else
 		if [ "$e_family" = "$AF_INET6" ]
 		then
-			stdbuf -o0 -e0 printf "DESTROY_SUBFLOW6 %s (%s) => %s (%s)   "\
-			       "$e_saddr" "$e_from" "$e_daddr" "$e_to"
+			print_test "DESTROY_SUBFLOW6 ${info}"
 		else
-			stdbuf -o0 -e0 printf "DESTROY_SUBFLOW %s (%s) => %s (%s)         \t"\
-			       "$e_saddr" "$e_from" "$e_daddr" "$e_to"
+			print_test "DESTROY_SUBFLOW ${info}"
 		fi
 	fi
 
@@ -818,7 +838,7 @@ test_subflows_v4_v6_mix()
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server6_token" id\
 	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
-	stdbuf -o0 -e0 printf "ADD_ADDR4 id:%d 10.0.2.1 (ns1) => ns2, reuse port\t\t" $server_addr_id
+	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
 			      "$server_addr_id" "$app6_port"
@@ -863,25 +883,23 @@ test_prio()
 	sleep 0.5
 
 	# Check TX
-	stdbuf -o0 -e0 printf "MP_PRIO TX                                                 \t"
+	print_test "MP_PRIO TX"
 	count=$(ip netns exec "$ns2" nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
-		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		ret=1
+		test_fail "Count != 1: ${count}"
 	else
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	fi
 
 	# Check RX
-	stdbuf -o0 -e0 printf "MP_PRIO RX                                                 \t"
+	print_test "MP_PRIO RX"
 	count=$(ip netns exec "$ns1" nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
 	[ -z "$count" ] && count=0
 	if [ $count != 1 ]; then
-		stdbuf -o0 -e0 printf "[FAIL]\n\tCount != 1: %d\n" "${count}"
-		ret=1
+		test_fail "Count != 1: ${count}"
 	else
-		stdbuf -o0 -e0 printf "[OK]\n"
+		test_pass
 	fi
 }
 
@@ -898,11 +916,9 @@ verify_listener_events()
 	local sport
 
 	if [ $e_type = $LISTENER_CREATED ]; then
-		stdbuf -o0 -e0 printf "CREATE_LISTENER %s:%s\t\t\t\t\t"\
-			$e_saddr $e_sport
+		print_test "CREATE_LISTENER $e_saddr:$e_sport"
 	elif [ $e_type = $LISTENER_CLOSED ]; then
-		stdbuf -o0 -e0 printf "CLOSE_LISTENER %s:%s\t\t\t\t\t"\
-			$e_saddr $e_sport
+		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
 	type=$(grep "type:$e_type," $evt |
@@ -927,7 +943,8 @@ test_listener()
 	print_title "Listener tests"
 
 	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
-		stdbuf -o0 -e0 printf "LISTENER events                                            \t[SKIP] Not supported\n"
+		print_test "LISTENER events"
+		test_skip
 		return
 	fi
 

-- 
2.40.1

