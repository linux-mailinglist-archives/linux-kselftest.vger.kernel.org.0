Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D14756480
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGQNWI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjGQNVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090C210DF
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso47270095e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600099; x=1692192099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgCRwe/aMLADqB9Zcz9fBB5yZM5sFyh9DEldcukmYmo=;
        b=jd+Cex5nHtocq0KU/b4wrGY3R6Pw8s2028bz/c1x3z0ay2vLZx+wIyfD98ztwTPplL
         h88gw9ffPzoDenGjgwtvnTcFZ3N29WnsFrMWBnU73lwgofY45Cgz9BC4iZ4a/g4iSi4t
         G5oqDscwZH8cx3A+1oTtZh99s96jq+mYJTGmnLgKDs8wTl9kWTQ/MvImI4JeGSYxjWRN
         9BNpbWX/d4QqGWIcGzGkrKiNka6An8h9CVAP3zOLVAkn1//1YTHmznMN93p8XtMZOY/p
         HEz0aUoN3WZcAwuX5bISxfs3HFXzoy1+WyFj2IAXsPaXA+aadmAF+nc/VZkXN8hb8UFD
         1dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600099; x=1692192099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgCRwe/aMLADqB9Zcz9fBB5yZM5sFyh9DEldcukmYmo=;
        b=gUnZG/aSGBlgo3/4G79lT77cDP5DD9GAaUcE06tFfZ2x1AEE/T84itWgaYtpxgU9MQ
         J5LfxUkkX1MBK2zfC7D1Cq2WZuNSyX04xEiPGPz5VDHcPhTcklRJa9D+AS0BKLibLTcv
         q1Ju2Pf8nF98Zwp608GdHngVMFFcqCkxh4zrnBJhfgdDSq6FmujCbxz6MMnoCyTghguv
         TeZFOOG3M6tWqAePjSvm5MeqOGCeS69cx0JuH5+EabONHgVlMq8ae990XyJlyQ5Db1ae
         5QiAIQ+H5ai3J2BPO7cp7EyGIar25xT2BphoUn8ue5MYHaq13PkgOz1IsSaQkYF/kVZ6
         lFfg==
X-Gm-Message-State: ABy/qLYDF6BhnwTvSd5O64xr+1cRSVby6fMbrA4P6vl9AgLVklRk8kFr
        rM787536OfTtk5qRsVJjR3rjQJGS5jWyWVET/bDJxg==
X-Google-Smtp-Source: APBJJlG2vmAPP4DlhcZhqmL+Z8QRHal4MZz8TTpG/CYsXAmIe4ZglDarAT2R5YRbCngAXoDbZupsnw==
X-Received: by 2002:a7b:c451:0:b0:3fb:ef86:e2e with SMTP id l17-20020a7bc451000000b003fbef860e2emr10188694wmi.19.1689600099504;
        Mon, 17 Jul 2023 06:21:39 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:39 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Mon, 17 Jul 2023 15:21:25 +0200
Subject: [PATCH net-next 05/13] selftests: mptcp: userspace_pm: reduce dup
 code around printf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-5-695127e0ad83@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=p5++Rak+cK4tA/cugYjcwaWOIkpGzEvf/nU/c+ap5fo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBd1rDIbZjMBVE1XO2137zJfkHCjI2ZkM4uT
 tEfLR5GPAWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 cxlxD/4n43jKCiIuunRJHRw5x0V1Yi5E6FEhyuz0fK9nt1GfwwDfGHkiSdojoOpHrPK7gp1D8gv
 2SzPQgUbjk4zy04jICHtevJ31jPxktZcvHowtXnVbiVx09LyFu5gimofuOlM+9qTTxvFn/dAorS
 CEXIKV/fEP/j/bWU88NB8H7AyvWu/yg8daUg7bSSfpBS0inovt1PnJDXeYUXj0zKIS7w9FjpTYO
 L//KX/jR1pIXZ3mAHa0UQeb6BbBb+3CGY3wVTDdn1lNuCTeUpTZX+mIRdA7vU8TBT0B1TQSrIh1
 jOtRJuqYOTovM/VpIcCRlSwvXjuViUqRsqOA0FlnxUZH5KuMlz+tb96YzmEzKfKG/wgB7481tLn
 deCjaONrzhC+SWv/rrBNxZPfZvAmtJSrh58jpnjq6EbmgXLIB+02d3mY2JBV8UmlBIZAEjeWVz5
 /AAs82a5SX/gRhswbcuYT+ABxoBghQmUT6xY+ZGJ0f/zvMGsG8hfX/6BhHrSHttHWiYDYf+U/ON
 lWyoWVyZOaS7cbgFsEvm7Quw05wNe8wWfTbJcgBY9N2/oY4FK6PfG0g9e5JKNp/1mGNLT7uoH5G
 cvbuEFjrBkh+ERHKu0/KXgJL2CKUqgA2coq98EDM5+/H/LKMd4qGwSao+/iZWenXqnL+/sngD85
 L2uJwJqqENXjUXw==
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

In this selftest, "printf" is always used with "stdbuf".

With a new helper, it is possible to call "stdbuf" only from one place.
This makes the code a bit clearer to read.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6b733b97d358..568ddee1d102 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -59,21 +59,24 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
+_printf() {
+	stdbuf -o0 -e0 printf "${@}"
+}
 
 print_title()
 {
-	stdbuf -o0 -e0 printf "INFO: %s\n" "${1}"
+	_printf "INFO: %s\n" "${1}"
 }
 
 # $1: test name
 print_test()
 {
-	stdbuf -o0 -e0 printf "%-63s" "${1}"
+	_printf "%-63s" "${1}"
 }
 
 print_results()
 {
-	stdbuf -o0 -e0 printf "[%s]\n" "${1}"
+	_printf "[%s]\n" "${1}"
 }
 
 test_pass()
@@ -93,7 +96,7 @@ test_fail()
 	ret=1
 
 	if [ -n "${1}" ]; then
-		stdbuf -o0 -e0 printf "\t%s\n" "${1}"
+		_printf "\t%s\n" "${1}"
 	fi
 }
 
@@ -127,7 +130,7 @@ cleanup()
 
 	rm -rf $file $client_evts $server_evts
 
-	stdbuf -o0 -e0 printf "Done\n"
+	_printf "Done\n"
 }
 
 trap cleanup EXIT
@@ -288,7 +291,7 @@ check_expected_one()
 		test_fail
 	fi
 
-	stdbuf -o0 -e0 printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
 		"${var}" "${!exp}" "${!var}"
 	return 1
 }

-- 
2.40.1

