Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0621F737192
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 18:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFTQar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 12:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjFTQal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:41 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124AB100
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso3436615e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jun 2023 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278636; x=1689870636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+3rYDno64lq4pcOQfs2XEYgkB99jAmuRJnUEJYNOIc=;
        b=zB+la/wggc1VC58H6IB/lIYOcJsNn6WE5cXkeRqAcHQjo0mcJAdWLsO01M29imNHQs
         aFVQxeown/tMeaceP+i+gwmlYnerZvIAkxtMwAnvgKgviBqWiinXGGGmNZJFWwmTYCde
         l4vIo5530D1BQtAvAB/1ck2FurAumcJHAZLQZBe/Hs6w4GfKSfWPcT9qrkB2vmm1Pk8v
         PST2/f/57g4YtU6h2A6t0ELt3TbnxfFr/l6Ph7EQDfCdjSEZg3fBpYBvQPvRwnliU02y
         668LZ3qMny5GCpor7KvXSIF6Y0rg2zbEkJOIVeQf0j/nlMEbXV5/MzvyUQeQomEy3yMn
         Vvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278636; x=1689870636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+3rYDno64lq4pcOQfs2XEYgkB99jAmuRJnUEJYNOIc=;
        b=BrP0qR4n8br8t23e25UhIEudl1uKXE9pdDHrgjPcZVN8AV8z4YfrhnH7thbx7nFH6e
         G/BwdNkivjcKj2bMevONhAWzqIGCUHgrVZyQsPadr2beZtMoYbQcjuQPi1nsMY/cZHU6
         lDZDSfAHQqnCaIWZLjHnWqLHRBBU/LY5/5EmOmkojsjlRxVG5OEpzD0I1p7hnNRpBZlJ
         oSk3DSBlhnrzJIJwis+1vSxxPJJWQqz3ys0p1bR9cS3s/Wt56uPXPszI7dyskhDWAwl2
         ZK9wKAvKD3Kf8fB9Ax5JtYYGv3fsdeOUn4v10DEOjJEVKs4GUaLr/CZLwscOxqlMofu9
         wqGA==
X-Gm-Message-State: AC+VfDz23yRZuLPC+NSCq+IwGmq/bN365yKh5NUj/VuintCQobXH5t4I
        we+pk5wIWZCFiNnXHg9qpCgo0Q==
X-Google-Smtp-Source: ACHHUZ7u+1/2yjl6pxvJhAWopF9M5YW66PajsfPqku5w3sCkjPNexoxww6Nrrv5Va8TYG+oUp4TCGA==
X-Received: by 2002:a19:ab12:0:b0:4f8:6aec:1a7b with SMTP id u18-20020a19ab12000000b004f86aec1a7bmr3900454lfe.67.1687278636276;
        Tue, 20 Jun 2023 09:30:36 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:36 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Tue, 20 Jun 2023 18:30:20 +0200
Subject: [PATCH net-next 7/9] selftests: mptcp: join: skip check if MIB
 counter not supported (part 2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-7-62b9444bfd48@tessares.net>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3948;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=abzxrEVNoJ7Ql/J02Q0CV6m2IPXwAB1iOgYr8iLGxmU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQk0zIu54dctAVesZxRVGsIecrhRI5w9cjgz
 zfT+ppbciGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUJAAKCRD2t4JPQmmg
 cxo6EACEBIPC0qbn1q/GyzrHITIhcUE8AhlAcrTKBQUfcdQqeDoZCWshA+mVK4fxmTYelZHYN/F
 Mjd+B8zpObxG6YfUCAFqE3nQ8mLJpIpt6aKa1/vY154D1VqVjVCkLLOWj7FEQ7WgOqO982JPcNq
 4eyaVFg8MWQFJI6Iwf5G0ent82gmYg/cWrypgjvJK1xt5QONq/OLZnNNmraEBuIOlJAHGrrNaDG
 xpMicm5UAxKNf2DEWdQd6JbJ96FoKOiflJgrs7+Kechi5gwvz6kS5o5K3KlaAgPJAQ++DgWotwe
 TmpYA2RRds2STezDSghGy/O6WLauaIjhMV/Sd9dRzXijXhWIqZ1kqpbN5XueGKjmKPyd1TiklWH
 dCAUcJtmKYB5OQf4HE2Vh/GrSJqPvYGBlosSgCVQH7Km53keJUIT73qISzhMxbaz9GReiAboZ/2
 g3rz0+y03ExpRQS7BQFuHVKGT5zqbo46Te1+MOTzoW6NASyU5Q/16TOuBr/QTPrJnKjEXJBtpvs
 ptv8BVY/1OJpK5RKk/K6RH0YZq+bptu53g/KG55QLPkmyb3co16BGBH9+Hmf6ck+iCFL0xfPhFx
 wezRXLI3XrLA2f0UBcqiQ8kZpjrubTvxczMqgDYGPNeEJCLsE1hzd9qgHbYI/jDPgBCpLC8zxdn
 ywXqCGdrR5kbUVw==
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

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the MPTCP MIB counters introduced in commit fc518953bc9c
("mptcp: add and use MIB counter infrastructure") and more later. The
MPTCP Join selftest heavily relies on these counters.

If a counter is not supported by the kernel, it is not displayed when
using 'nstat -z'. We can then detect that and skip the verification. A
new helper (get_counter()) has been added recently in the -net tree to
do the required checks and return an error if the counter is not
available.

This commit is similar to the one with the same title applied in the
-net tree but it modifies code only present in net-next for the moment,
see the Fixes commit below.

While at it, we can also remove the use of ${extra_msg} variable which
is never assigned in chk_rm_tx_nr() function and use 'echo' without '-n'
parameter.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 0639fa230a21 ("selftests: mptcp: add explicit check for new mibs")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1b68fe1c0885..a7973d6a40a0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1683,12 +1683,12 @@ chk_add_tx_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${nr_blank}s %s" " " "add TX"
-	count=$(ip netns exec $ns1 nstat -as MPTcpExtAddAddrTx | grep MPTcpExtAddAddrTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-
+	count=$(get_counter ${ns1} "MPTcpExtAddAddrTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
+	elif [ "$count" != "$add_tx_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] TX, expected $add_tx_nr"
 		fail_test
 	else
@@ -1696,9 +1696,10 @@ chk_add_tx_nr()
 	fi
 
 	echo -n " - echo TX "
-	count=$(ip netns exec $ns2 nstat -as MPTcpExtEchoAddTx | grep MPTcpExtEchoAddTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$echo_tx_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtEchoAddTx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$echo_tx_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
 		fail_test
 	else
@@ -1734,9 +1735,10 @@ chk_rm_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rm "
-	count=$(ip netns exec $addr_ns nstat -as MPTcpExtRmAddr | grep MPTcpExtRmAddr | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_nr" ]; then
+	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
 		fail_test
 	else
@@ -1778,16 +1780,15 @@ chk_rm_tx_nr()
 	local rm_addr_tx_nr=$1
 
 	printf "%-${nr_blank}s %s" " " "rm TX "
-	count=$(ip netns exec $ns2 nstat -as MPTcpExtRmAddrTx | grep MPTcpExtRmAddrTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_tx_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtRmAddrTx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$rm_addr_tx_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_tx_nr"
 		fail_test
 	else
-		echo -n "[ ok ]"
+		echo "[ ok ]"
 	fi
-
-	echo "$extra_msg"
 }
 
 chk_prio_nr()

-- 
2.40.1

