Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16E276845F
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjG3IFn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjG3IFi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 04:05:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA9E1FE8
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Jul 2023 01:05:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fd190065a8so40416895e9.3
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Jul 2023 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690704335; x=1691309135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCqeCrU2BUMxCmMmdaeVjNV60zHyKZc+fhAxY8XjBeU=;
        b=VHrrFm9h1bH0Fa9QZgFGcYoLawQmLPjdabDyJZ7nxZJwnfeH9bQgILDFCp0d83jB7Q
         EAXmG5b9uT/86Igj/oYHgUfrff0wLs+fFJ+Vlvo3jDksPdLUnwh6t4j60uK2aIDfXw6Q
         +ocSCQTkbby0co6GhFa4K2Vz31GLq9FAkYvD7w20SS6Z/O9HCklDpw+NuceIhlKSbKM9
         dSJoCc1yn7lDyF1jlkqe3J+NDf2h76MsGgZ4PZGFFCJ4kYSwCkrqPQVBVxpWMb0+zeRy
         u11uMXMr+87PC3Vn9Wz7JKliN+IUotcXtTQicj2MqwEwuTVbHtqkQTCs8hclkIQY7rcw
         ilPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690704335; x=1691309135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCqeCrU2BUMxCmMmdaeVjNV60zHyKZc+fhAxY8XjBeU=;
        b=WKdp5QKcA7/H76pEIMfzU/Bh6k7mzm3x9hJLyt51WYfJ4bLvsWhX+zQUpuLWGAtIOY
         fwQI3PC75EOnvt3x3YMPI98lZs7Oge3TK6hIkz5216dtRkmtL2s2lOtH3JLUwRKzwsMy
         31ZgaZ3CT6H53eEY01OWuOGgGKigkEJ79dQnKSQRxVw2rTCRyhT9FeJiiXxJ6XGYnAHU
         OSKnkx1wuQQ72BhkvTIFi2w1okjjqEJyRMTTb/QCrCHEBbk+pM5Z4MbB/FFfFwm8p1+i
         H7iUPlIIM0j8Tpm9jLhivoS0OOk3yBBP/aFX5ftqoABflWytnvUVi6R9+NTTbRgA6KdE
         LVIA==
X-Gm-Message-State: ABy/qLYqXTGVkrMWW6OA0ipHDoVsjB4NHqaP01N+OG/PiQ5PuEOVEgIQ
        XgeqVZU0fIPOuaSbAcYjTL+J1w==
X-Google-Smtp-Source: APBJJlHyTb+EVBtZRde9K2uDHYFYTa8duWkyVEV5pxg38GbEiEuvYXV6psjgb5YmCyRiguSE4NZgiA==
X-Received: by 2002:a7b:c8ca:0:b0:3fe:1deb:86 with SMTP id f10-20020a7bc8ca000000b003fe1deb0086mr686260wml.28.1690704334598;
        Sun, 30 Jul 2023 01:05:34 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4407000000b0031766e99429sm9338684wrq.115.2023.07.30.01.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:05:34 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sun, 30 Jul 2023 10:05:18 +0200
Subject: [PATCH net-next 4/4] selftests: mptcp: userspace_pm: unmute
 unexpected errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-4-7e9cc530a9cd@tessares.net>
References: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
In-Reply-To: <20230730-upstream-net-next-20230728-mptcp-selftests-misc-v1-0-7e9cc530a9cd@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=18032;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=H1E8l+IoCAAhEaKmjavXydAmcpLI1bfzXzQFw7v9eF0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkxhnJZCwoyc0XVy636KturOG4/ISQaXMiF8xKu
 XJ12gbqoiOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMYZyQAKCRD2t4JPQmmg
 czhmEADvYmhoAktbkVJ/mwqGZ3oWHGRafcSdxYZsE/KZYF4LxgLao7Ctaf17vTniPNnuH9ymOn8
 gUTZO3f6qsafnV4GEbmnrqri4n2E2mQIRsQGGsv1O8NluIZvk59mO/NvoWE0qMewNd48k6VrMl4
 D/BJvZtq0tOs1/Ju74GodHmyW/AVNg4p0rt8fsPDswUYR6Ga7s6oXifBSRH7Y5zGfUFsnLkgnd4
 OaSEXn5PbKZj3hFILrI445Co9v5/fBK4dViam5SU8ePIVOKWYj1/fQmVE+/TLexZ7QUiMb5AsKL
 OyZAVU/Bh5u56eQ46UpGq1hxoCTy+DvHd+A5HT9A1aG0zrTDdZkAyj/6mqi/r5UuXEc2Y7p8XjG
 /2JFohLLvRyVIP800sfksNsY13El83NV3t8Kx8TK4lorE2fPSitiHvOGBUD15WjWxDqcc0UStyC
 8XMMoBuINzXM5jAE3IxuhUbWaUl8UrPovamIu0PB7qJH/l3BlajdDeCBhnnE27or4OhW+ErdlxN
 3fo7lcypOJs74Hdlwmgme6QNDjP7pdqBEOqqBKv2FVFDqgIotLWv5px5kiKIIJgafVw7sNJ0i5I
 jASS2vAkSUbLtmWfh9+Y4n5RAhDHI3L6O6V1/QiDGg64KyWXasFcpmtMS7AsycvHol8/gcoOAFW
 4JxXdknZzbOU20Q==
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

All pm_nl_ctl commands were muted. If there was an unexpected error with
one of them, this was simply not visible in the logs, making the
analysis very hard. It could also hide misuse of commands by mistake.

Now the output is only muted when we do expect to have an error, e.g.
when giving invalid arguments on purpose.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 100 +++++++++++-----------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 23f8959a8ea8..b25a3e33eb25 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -380,7 +380,7 @@ test_announce()
 	:>"$server_evts"
 	ip netns exec "$ns2"\
 	   ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id $client_addr_id dev\
-	   ns2eth1 > /dev/null 2>&1
+	   ns2eth1
 	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event $server_evts $ANNOUNCED $server4_token "10.0.2.2" $client_addr_id \
@@ -389,7 +389,7 @@ test_announce()
 	# ADD_ADDR6 from the client to server machine reusing the subflow port
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann\
-	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1 > /dev/null 2>&1
+	   dead:beef:2::2 token "$client6_token" id $client_addr_id dev ns2eth1
 	print_test "ADD_ADDR6 id:${client_addr_id} dead:beef:2::2 (ns2) => ns1, reuse port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2"\
@@ -399,7 +399,7 @@ test_announce()
 	:>"$server_evts"
 	client_addr_id=$((client_addr_id+1))
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
-	   $client_addr_id dev ns2eth1 port $new4_port > /dev/null 2>&1
+	   $client_addr_id dev ns2eth1 port $new4_port
 	print_test "ADD_ADDR id:${client_addr_id} 10.0.2.2 (ns2) => ns1, new port"
 	sleep 0.5
 	verify_announce_event "$server_evts" "$ANNOUNCED" "$server4_token" "10.0.2.2"\
@@ -410,7 +410,7 @@ test_announce()
 
 	# ADD_ADDR from the server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
-	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
+	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
@@ -419,7 +419,7 @@ test_announce()
 	# ADD_ADDR6 from the server to client machine reusing the subflow port
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
-	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
+	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR6 id:${server_addr_id} dead:beef:2::1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1"\
@@ -429,7 +429,7 @@ test_announce()
 	:>"$client_evts"
 	server_addr_id=$((server_addr_id+1))
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
-	   $server_addr_id dev ns1eth2 port $new4_port > /dev/null 2>&1
+	   $server_addr_id dev ns1eth2 port $new4_port
 	print_test "ADD_ADDR id:${server_addr_id} 10.0.2.1 (ns1) => ns2, new port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client4_token" "10.0.2.1"\
@@ -490,7 +490,7 @@ test_remove()
 	# RM_ADDR from the client to server machine
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
@@ -499,7 +499,7 @@ test_remove()
 	:>"$server_evts"
 	client_addr_id=$(( client_addr_id - 1 ))
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server4_token" "$client_addr_id"
@@ -507,7 +507,7 @@ test_remove()
 	# RM_ADDR6 from the client to server machine
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client6_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	print_test "RM_ADDR6 id:${client_addr_id} ns2 => ns1"
 	sleep 0.5
 	verify_remove_event "$server_evts" "$REMOVED" "$server6_token" "$client_addr_id"
@@ -517,7 +517,7 @@ test_remove()
 
 	# RM_ADDR from the server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
@@ -526,7 +526,7 @@ test_remove()
 	:>"$client_evts"
 	server_addr_id=$(( server_addr_id - 1 ))
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server4_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	print_test "RM_ADDR id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client4_token" "$server_addr_id"
@@ -534,7 +534,7 @@ test_remove()
 	# RM_ADDR6 from the server to client machine
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl rem token "$server6_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	print_test "RM_ADDR6 id:${server_addr_id} ns1 => ns2"
 	sleep 0.5
 	verify_remove_event "$client_evts" "$REMOVED" "$client6_token" "$server_addr_id"
@@ -610,18 +610,18 @@ test_subflows()
 
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen 10.0.2.2\
-	   "$client4_port" > /dev/null 2>&1 &
+	   "$client4_port" &
 	local listener_pid=$!
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
-	   rport "$client4_port" token "$server4_token" > /dev/null 2>&1
+	   rport "$client4_port" token "$server4_token"
 	sleep 0.5
 	verify_subflow_events $server_evts $SUB_ESTABLISHED $server4_token $AF_INET "10.0.2.1" \
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
@@ -635,31 +635,31 @@ test_subflows()
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
-	   "$client4_port" token "$server4_token" > /dev/null 2>&1
+	   "$client4_port" token "$server4_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
-	   "$client4_token" > /dev/null 2>&1
+	   "$client4_token"
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::2:<subflow-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen dead:beef:2::2\
-	   "$client6_port" > /dev/null 2>&1 &
+	   "$client6_port" &
 	listener_pid=$!
 
 	# ADD_ADDR6 from client to server machine reusing the subflow port
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann dead:beef:2::2 token "$client6_token" id\
-	   $client_addr_id > /dev/null 2>&1
+	   $client_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW6 from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip\
-	   dead:beef:2::2 rport "$client6_port" token "$server6_token" > /dev/null 2>&1
+	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
@@ -673,7 +673,7 @@ test_subflows()
 	# DESTROY_SUBFLOW6 from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
-	   dead:beef:2::2 rport "$client6_port" token "$server6_token" > /dev/null 2>&1
+	   dead:beef:2::2 rport "$client6_port" token "$server6_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
@@ -681,24 +681,24 @@ test_subflows()
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
-	   "$client6_token" > /dev/null 2>&1
+	   "$client6_token"
 	sleep 0.5
 
 	# Attempt to add a listener at 10.0.2.2:<new-port>
 	ip netns exec "$ns2" ./pm_nl_ctl listen 10.0.2.2\
-	   $new4_port > /dev/null 2>&1 &
+	   $new4_port &
 	listener_pid=$!
 
 	# ADD_ADDR from client to server machine using a new port
 	:>"$server_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.2.2 token "$client4_token" id\
-	   $client_addr_id port $new4_port > /dev/null 2>&1
+	   $client_addr_id port $new4_port
 	sleep 0.5
 
 	# CREATE_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport\
-	   $new4_port token "$server4_token" > /dev/null 2>&1
+	   $new4_port token "$server4_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET"\
 			      "10.0.2.1" "10.0.2.2" "$new4_port" "23"\
@@ -712,32 +712,32 @@ test_subflows()
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
-	   $new4_port token "$server4_token" > /dev/null 2>&1
+	   $new4_port token "$server4_token"
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# RM_ADDR from client to server machine
 	ip netns exec "$ns2" ./pm_nl_ctl rem id $client_addr_id token\
-	   "$client4_token" > /dev/null 2>&1
+	   "$client4_token"
 
 	# Capture events on the network namespace running the client
 	:>"$client_evts"
 
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
-	   $app4_port > /dev/null 2>&1 &
+	   $app4_port &
 	listener_pid=$!
 
 	# ADD_ADDR from server to client machine reusing the subflow port
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
-	   $app4_port token "$client4_token" > /dev/null 2>&1
+	   $app4_port token "$client4_token"
 	sleep 0.5
 	verify_subflow_events $client_evts $SUB_ESTABLISHED $client4_token $AF_INET "10.0.2.2"\
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
@@ -750,31 +750,31 @@ test_subflows()
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
-	   $app4_port token "$client4_token" > /dev/null 2>&1
+	   $app4_port token "$client4_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
-	   "$server4_token" > /dev/null 2>&1
+	   "$server4_token"
 	sleep 0.5
 
 	# Attempt to add a listener at dead:beef:2::1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen dead:beef:2::1\
-	   $app6_port > /dev/null 2>&1 &
+	   $app6_port &
 	listener_pid=$!
 
 	# ADD_ADDR6 from server to client machine reusing the subflow port
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann dead:beef:2::1 token "$server6_token" id\
-	   $server_addr_id > /dev/null 2>&1
+	   $server_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW6 from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip\
-	   dead:beef:2::1 rport $app6_port token "$client6_token" > /dev/null 2>&1
+	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET6" "dead:beef:2::2"\
@@ -789,31 +789,31 @@ test_subflows()
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
-	   dead:beef:2::1 rport $app6_port token "$client6_token" > /dev/null 2>&1
+	   dead:beef:2::1 rport $app6_port token "$client6_token"
 	sleep 0.5
 	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR6 from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
-	   "$server6_token" > /dev/null 2>&1
+	   "$server6_token"
 	sleep 0.5
 
 	# Attempt to add a listener at 10.0.2.1:<new-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
-	   $new4_port > /dev/null 2>&1 &
+	   $new4_port &
 	listener_pid=$!
 
 	# ADD_ADDR from server to client machine using a new port
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server4_token" id\
-	   $server_addr_id port $new4_port > /dev/null 2>&1
+	   $server_addr_id port $new4_port
 	sleep 0.5
 
 	# CREATE_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
-	   $new4_port token "$client4_token" > /dev/null 2>&1
+	   $new4_port token "$client4_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET"\
 			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
@@ -826,14 +826,14 @@ test_subflows()
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
-	   $new4_port token "$client4_token" > /dev/null 2>&1
+	   $new4_port token "$client4_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2"\
 			      "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
-	   "$server4_token" > /dev/null 2>&1
+	   "$server4_token"
 }
 
 test_subflows_v4_v6_mix()
@@ -842,14 +842,14 @@ test_subflows_v4_v6_mix()
 
 	# Attempt to add a listener at 10.0.2.1:<subflow-port>
 	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.2.1\
-	   $app6_port > /dev/null 2>&1 &
+	   $app6_port &
 	local listener_pid=$!
 
 	# ADD_ADDR4 from server to client machine reusing the subflow port on
 	# the established v6 connection
 	:>"$client_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl ann 10.0.2.1 token "$server6_token" id\
-	   $server_addr_id dev ns1eth2 > /dev/null 2>&1
+	   $server_addr_id dev ns1eth2
 	print_test "ADD_ADDR4 id:${server_addr_id} 10.0.2.1 (ns1) => ns2, reuse port"
 	sleep 0.5
 	verify_announce_event "$client_evts" "$ANNOUNCED" "$client6_token" "10.0.2.1"\
@@ -858,7 +858,7 @@ test_subflows_v4_v6_mix()
 	# CREATE_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport\
-	   $app6_port token "$client6_token" > /dev/null 2>&1
+	   $app6_port token "$client6_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_ESTABLISHED" "$client6_token"\
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
@@ -872,7 +872,7 @@ test_subflows_v4_v6_mix()
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip 10.0.2.2 lport "$sport" rip 10.0.2.1 rport\
-	   $app6_port token "$client6_token" > /dev/null 2>&1
+	   $app6_port token "$client6_token"
 	sleep 0.5
 	verify_subflow_events "$client_evts" "$SUB_CLOSED" "$client6_token" \
 			      "$AF_INET" "10.0.2.2" "10.0.2.1" "$app6_port" "23"\
@@ -880,7 +880,7 @@ test_subflows_v4_v6_mix()
 
 	# RM_ADDR from server to client machine
 	ip netns exec "$ns1" ./pm_nl_ctl rem id $server_addr_id token\
-	   "$server6_token" > /dev/null 2>&1
+	   "$server6_token"
 	sleep 0.5
 }
 
@@ -965,7 +965,7 @@ test_listener()
 
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
-		$client4_port > /dev/null 2>&1 &
+		$client4_port &
 	local listener_pid=$!
 
 	sleep 0.5
@@ -973,12 +973,12 @@ test_listener()
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
-		$client_addr_id > /dev/null 2>&1
+		$client_addr_id
 	sleep 0.5
 
 	# CREATE_SUBFLOW from server to client machine
 	ip netns exec $ns1 ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
-		rport $client4_port token $server4_token > /dev/null 2>&1
+		rport $client4_port token $server4_token
 	sleep 0.5
 
 	# Delete the listener from the client ns, if one was created

-- 
2.40.1

