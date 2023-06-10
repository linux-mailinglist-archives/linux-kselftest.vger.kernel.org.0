Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14BA72ACFA
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjFJQNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 12:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjFJQMu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 12:12:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2A34226
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30af159b433so2667820f8f.3
        for <linux-kselftest@vger.kernel.org>; Sat, 10 Jun 2023 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686413527; x=1689005527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apU7a4gXwlkiybZ6x2mBbA+4PV1TUCSDbsUSYzUKd4U=;
        b=TRoaGryL5w2MiomzDEAi90aHYFZPMUKIrI1Wh0XjQTGOHUrmV0MWwELt1kGLP1nNW+
         67w0t7y9sdwelvUVLcWZ4UdR2Lj7y93qAQzehEO3C4PGA7mvkB3q75/jKFfD9DVTsdKj
         ZFDHYfhkcdfBQCEEPV8GdvOROKbWOjK6WxlmP3HCm97fk1ZOkR34At/xukDfvHWCbily
         tO1tNOY2pmX+r6aWY3HOWqwiXU1iojxdiYh5uqmpSP74oeXuvkJH8h3p5XecRTtxb6BM
         G/rkLGkkk/Nc8lqTrKmfhdtGHaOiM0Xop9dSwWN2mp43Zd41DbEYEf0UU4+jhIKot72m
         u6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686413527; x=1689005527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apU7a4gXwlkiybZ6x2mBbA+4PV1TUCSDbsUSYzUKd4U=;
        b=We9PGsIloeNH+7e2iptA+pxYDz1gv20NGLOlqbenjWR8053Re5DdE6e4iRNofCZKiM
         If0uGCYZkyToO/vxL4j/AAW4ersUxh5f6ctrxBfoj+2oY3uq/jBBSuKFM5Lx9EOTtr7f
         g6kVAMRGpo2+K7Ovx4D7vwAHXa2W0Plh079V8LtY7Xy7eHIcVwaun06nrng+bL77Kpy0
         1zVPerNMJm5HLqLK/YxcqLjhuXRtEUwCXmQUn/KdQdEX+uzqx5eL/3uMk/HIcNm+Hsrw
         AQQMb0TzmEUSw/xHPa0JbsJOhmh7jxhxGGUlAZfq5FV1ONETtAZs41GOnFtglxL7or61
         9D2Q==
X-Gm-Message-State: AC+VfDxsdZwhtKuLt5hx4pBFCM9p35x+FPQ8aBSTtBq+zLQ1mUwA0woC
        vdUzVMKuy4rozbt9FPwQIzeTxw==
X-Google-Smtp-Source: ACHHUZ58BD2I7xOIcVcJp9qZu3IPomsyDwwMCh6HFJ49+hti+CDLhIbtS5cEW8YWEj/2Hde1xhEkjA==
X-Received: by 2002:a5d:44d2:0:b0:306:2eab:fb8c with SMTP id z18-20020a5d44d2000000b003062eabfb8cmr1628506wrr.42.1686413527023;
        Sat, 10 Jun 2023 09:12:07 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d4349000000b003079c402762sm7431145wrr.19.2023.06.10.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 09:12:06 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 10 Jun 2023 18:11:51 +0200
Subject: [PATCH net 16/17] selftests: mptcp: join: uniform listener tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-upstream-net-20230610-mptcp-selftests-support-old-kernels-part-3-v1-16-2896fe2ee8a3@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=UUluy+Qb+5XbOXHPZryUKVcouQr2uln8U24KgOhfIuY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkhKC+6E5eKBWGTd7nLKzfXoWu5/T2jfNbwj9oW
 cNi8wJ6o6mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZISgvgAKCRD2t4JPQmmg
 c+2mEADul/6GZQjUkWGyziq7Gyz4hkpO5ThJk7PNIpeDHYU5fS6QxKSNhUKdc2yxdSw5S+rj7Sr
 6wnuHmSGr4lxfrLoVi/fEjK5WXtUyVHZoq6IFB3BYJCZnf3CEk/wLpi5S9623gq65lUlsNV5kLK
 9+j4KpPcvJsPh88Gpx9UbR9zteChbcqRsyt8naOll3c1bzAc4ILU3kMLzShMmP69PX4YVhEfltG
 9Ht3wJm5YSabM90VLIrUESJQaHISuPN+UXACiM7bMLYMQsbPKmg6gVd9/x8EYoXThyd0uYLwE5c
 wauA/giOtswJT449ay9FyBCv7pc1yVH6Q1pBC/tjQglOKyz9XBTAXu8XytscXXfa0IaDBJqxj7P
 SoMWcIawO0thWQ7OO70AtwxBh6Tk6jew7kBml90kHFkNa8BQvHOXq6+M89ZSMpkROEY7aAJWJHa
 B1HUYX2LAnWhjD+QG1ILhE4Un5mdpDUBx3oMo8ouHUJLUCHPASjoyjMtHN9yQn4Dslm079RN5Bf
 Ia8/rr+yyUQ0lqPr1x4UrLwr3EPcOefcRgKfzPBLE3ZmB2pgAOyPqsyp953NMz2R590p1QBrqzC
 XrG3us0i5sU7pEomHGhiqWkIPy1iCyURsEoZIf4CUBJ0qxz/JW+dJvt4xqVststmG0eiQIatsqO
 ZjP8aq3aKZ0lViQ==
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

The alignment was different from the other tests because tabs were used
instead of spaces.

While at it, also use 'echo' instead of 'printf' to print the result to
keep the same style as done in the other sub-tests. And, even if it
should be better with, also remove 'stdbuf' and sed's '--unbuffered'
option because they are not used in the other subtests and they are not
available when using a minimal environment with busybox.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 178d023208eb ("selftests: mptcp: listener test for in-kernel PM")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0c22efeba675..281581d3c8eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2765,43 +2765,41 @@ verify_listener_events()
 	local family
 	local saddr
 	local sport
+	local name
 
 	if [ $e_type = $LISTENER_CREATED ]; then
-		stdbuf -o0 -e0 printf "\t\t\t\t\t CREATE_LISTENER %s:%s"\
-			$e_saddr $e_sport
+		name="LISTENER_CREATED"
 	elif [ $e_type = $LISTENER_CLOSED ]; then
-		stdbuf -o0 -e0 printf "\t\t\t\t\t CLOSE_LISTENER %s:%s "\
-			$e_saddr $e_sport
+		name="LISTENER_CLOSED"
+	else
+		name="$e_type"
 	fi
 
+	printf "%-${nr_blank}s %s %s:%s " " " "$name" "$e_saddr" "$e_sport"
+
 	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
 		printf "[skip]: event not supported\n"
 		return
 	fi
 
-	type=$(grep "type:$e_type," $evt |
-	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt |
-		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt |
-		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(grep "type:$e_type," $evt | sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
+	family=$(grep "type:$e_type," $evt | sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
+	sport=$(grep "type:$e_type," $evt | sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	else
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
 	if [ $type ] && [ $type = $e_type ] &&
 	   [ $family ] && [ $family = $e_family ] &&
 	   [ $saddr ] && [ $saddr = $e_saddr ] &&
 	   [ $sport ] && [ $sport = $e_sport ]; then
-		stdbuf -o0 -e0 printf "[ ok ]\n"
+		echo "[ ok ]"
 		return 0
 	fi
 	fail_test
-	stdbuf -o0 -e0 printf "[fail]\n"
+	echo "[fail]"
 }
 
 add_addr_ports_tests()

-- 
2.40.1

