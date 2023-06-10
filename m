Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5803472ACD6
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjFJQLy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjFJQLw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:11:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FABC3A87
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:11:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6da07feb2so28063675e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413507; x=1689005507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcJWVGbSU0dUIbvIjNveh6i0eUkpPqP3eHFiS929B+A=;
        b=7LiGc3P7ncxu18MxPWIri6SjQjGjM7kjAdYBv4qS4/8nKVEAlDTO5Ryc7cDo/nBWm7
         /dZWm8oGlhBTbm1W4sdjv8HYRxn5Zrn7mVZXS835/NMfKXy/6+ZTqkZ7lWxXHElEgTsn
         Z2urlC6n1/sJbVPf6sY9tadQ7xLiWwllH41R16sDWu+UFN2DIGg4rc7W8BMOZg8pb4i3
         7gFyJMfx5qgOiQRAgAk7qz0VKSn/6/FBi/F4K1LYd+eX+dLLdVqT6hCLOILORETg17H7
         kmp1aWuNHc3QfYLsWcRdax78w17rrhr6SV4VDh98QMKZ9GPTnbXF+UzH/2lG0kCKrzNV
         wHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413507; x=1689005507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcJWVGbSU0dUIbvIjNveh6i0eUkpPqP3eHFiS929B+A=;
        b=TWzXUidwwyCJHwHF2tZGazSTo+JEy7FJs8WJobx/JeFnP4p0Ed2NnaUqKt1fMDv9Wj
         JQ2sc+Qn4O49yPYKWch5817P7xXwE2iFadalsZwWjcIpDNfU/J9RazpxeOHvopjnf5iO
         ajzq0tgSSa1SG7zdhNvxmczGmYTOS3V37ZKwCXUyd5Y6d93hsqHkzsL4hrWbO4P1H6zX
         SwegaxaXxScy4NKryPznxXyNDho0mrh9EUTPhbXUyBxan8aUhRNK2H43qydZ6X0fyzMe
         XzM61amzCwHxCKPoa9mj12lJE5/mKRxMK52lb3ypGhvGOnJf7kEJMJ2ZhY5r8SOeallq
         5/Cw==
X-Gm-Message-State: AC+VfDw9C5n03XfuTNyA5iQoGTYCWD10hcUlS4CWQzs0lL2HHZ+hHjRD
        gzTghhGbEIdgl8rVGm/uTW6DFg==
X-Google-Smtp-Source: ACHHUZ6EGpHTgQ61KhnT+WpqYZ4Pz44mNkho11TvylD5C8j51moshXZPKKFv7CWAp1/N2SPjkB8XBw==
X-Received: by 2002:adf:fec1:0:b0:30f:aef1:2add with SMTP id q1-20020adffec1000000b0030faef12addmr1444765wrs.47.1686413507753;
        Sat, 10 Jun 2023 09:11:47 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:11:47 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 10 Jun 2023 18:11:37 +0200
Subject: [PATCH net 02/17] selftests: mptcp: join: use 'iptables-legacy' if
 available
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-2-2896fe2ee8a3@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2321;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=wr7uItaSFcLXiJMNJDpVgU2oEvlx/b3Yp6m2pXKEEpE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC9aTW95InrthBqcIPHSuBLNcpNZ7TqyAQA0
 ETRNnDMvYeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvQAKCRD2t4JPQmmg
 c/SSD/9UORMMaxpWLt/pxXtiA9DlaDIFzYtk8pipZ/BGT6ptcIQbpLNO5hQWR8DAcJ7665T1TwN
 eBNmu+3XDxWejPA34P6eZPs9iYyBI0KlRaZfc2LWHB3eQRSH2inb6NUaaAFnX6d66uTSvag4jQx
 o9o3CnhsaVl4MyaG+N/nURU3bsAVF+25ecXbFPB7+FScgY+tKWOL1FvU3SI5uNPP7uWocxCLWz9
 RzlkKB8kuwny/7wnBWdNUdJef8LIHK6wjwYMst7z0pWSjRkMJVCWNY2Q7v7vLvHmDHuqYYUfBhB
 rh41xelDYVlLcrFW3FWWQCgsp5dpqpDrMcu+KN85lnDs5i2r81tyNJztfWOPj6CxW7Yz0eMqcGA
 5pfF4v8g1P+XtnfhTpRt8jdW9jE9pD+PBGrvuw27jvd+0mq9HqFu94AOIy3GIPo33YB75oFwfYx
 EttzhFJZQjnbuSZxEUdGJM/dN4Eag3dGTKd6J7H+RppqK2FzrAnkc7tfDcuppt4yVndYt3VX1F7
 oT6wkDCspTT62qecxzXveuS/zjcX4Wj9MXMStxxNg1UXilcAatYGcXz/qEgTwdsiEg1Th3oPotT
 4lNt4L/a474v3SQgOsJKPPBBeEzTVFTjl45G/yeGBTcbITOSnkwrvfkUMXItAsE2u9/JQb03XJZ
 OuNgx2e4y2tR5rw==
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

IPTables commands using 'iptables-nft' fail on old kernels, at least
5.15 because it doesn't see the default IPTables chains:

  $ iptables -L
  iptables/1.8.2 Failed to initialize nft: Protocol not supported

As a first step before switching to NFTables, we can use iptables-legacy
if available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 29f0c99d9a46..74cc8a74a9d6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -25,6 +25,8 @@ capout=""
 ns1=""
 ns2=""
 ksft_skip=4
+iptables="iptables"
+ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=0
@@ -146,7 +148,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
-	if ! iptables -V &> /dev/null; then
+	# Use the legacy version if available to support old kernel versions
+	if iptables-legacy -V &> /dev/null; then
+		iptables="iptables-legacy"
+		ip6tables="ip6tables-legacy"
+	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
 	fi
@@ -247,9 +253,9 @@ reset_with_add_addr_timeout()
 
 	reset "${1}" || return 1
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
@@ -314,9 +320,9 @@ reset_with_fail()
 	local ip="${3:-4}"
 	local tables
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	ip netns exec $ns2 $tables \
@@ -704,7 +710,7 @@ filter_tcp_from()
 	local src="${2}"
 	local target="${3}"
 
-	ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
+	ip netns exec "${ns}" ${iptables} -A INPUT -s "${src}" -p tcp -j "${target}"
 }
 
 do_transfer()

-- 
2.40.1

