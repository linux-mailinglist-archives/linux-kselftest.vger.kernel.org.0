Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D100F62EC6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 04:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbiKRDoy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 22:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240254AbiKRDox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 22:44:53 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7944C697C2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 19:44:52 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id l127so4116251oia.8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 19:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jGnYXRgUuCOtcxhHcdN3EAOTRD6u/BtPvCMZue/+ZQE=;
        b=Z0vmkWFntUkPh2GZ76Y/bnp2oYyE4jqya+BzsIeqgdc8ywkzdgfVsxijBvxMnQSJ6J
         FYoh3g5fUNxkJQup4YQfAE0LP3JRAyOELUSbC7TMsSlow7k2dJdTzeFzr1g0Ii9XS89Q
         5YTGFgPkOqKTp8rZqtArRHNoQ44fvwNlMfeuv0zhLKIb4A+RyVI7y79bGFVUu+lL95jl
         R2EfWp0lkOGq0f0LGtyg9YW3x+7y6JFqdzK6YGjKJqehgms9rVWU63FtXWl0GqnTODVf
         TpqTukpuAR1amnQBM/74a5X48E4qJsDts/6fzI5fmGFdZlDVDjfyI51sNGof7R26tQQ6
         7yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGnYXRgUuCOtcxhHcdN3EAOTRD6u/BtPvCMZue/+ZQE=;
        b=EMMTfxeqTw+eeIfllh6baEtTmwt49kWiTloRJR5k2eVU0cmDQ5x6FHQUV/SuF0KNkL
         jXnKNlhi746wJiGbywTeuIEq+kunuSMWZUOwKt9zWqZ4yXDzQtYhQASTfaGpNjfDuaoY
         WhVFMJZNEIrCbmzLeq4MznzAQwDd+sA+l0zMaOKqDQC9O1IhhQEwV8aNl/GYanlNPeZG
         DVJ+8Qokr7tpC+WsuYWXM8WJz/HGhZszE3eJzffqind/4Kp9qn0NrP1qdj7VkMygb3QS
         FZBV9wbiI2vgoqNA0krptkuY+UxYun4E5heO93Xesq02r5ZLqQEtTJhkqRYroidzqlLE
         cO2Q==
X-Gm-Message-State: ANoB5pnEV7vrdGjJosN3GpsQMDrLONQvrxi09MARDcQYF8fDD8zeOChp
        A6eXXsiM5oIRs1/+BT1sdIfQtrMBqYzt1ybA
X-Google-Smtp-Source: AA0mqf4JibB582RO1pQUqTHJvrrqUwZDI1rwX5yzn49ORCV6OEqxs5rLaxGDzgQ/h6G/U/6Gng9swQ==
X-Received: by 2002:a54:4705:0:b0:35a:1945:4610 with SMTP id k5-20020a544705000000b0035a19454610mr5297087oik.149.1668743091543;
        Thu, 17 Nov 2022 19:44:51 -0800 (PST)
Received: from alago.cortijodelrio.net ([189.219.72.83])
        by smtp.googlemail.com with ESMTPSA id c23-20020a4ad8d7000000b0047f94999318sm1020032oov.29.2022.11.17.19.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 19:44:51 -0800 (PST)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     linux-kselftest@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/net: Find nettest in current directory
Date:   Thu, 17 Nov 2022 21:44:21 -0600
Message-Id: <20221118034421.994619-1-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The `nettest` binary, built from `selftests/net/nettest.c`,
was expected to be found in the path during test execution of
`fcnal-test.sh` and `pmtu.sh`, leading to tests getting
skipped when the binary is not installed in the system, as can
be seen in these logs found in the wild [1]:

  # TEST: vti4: PMTU exceptions                                         [SKIP]
  [  350.600250] IPv6: ADDRCONF(NETDEV_CHANGE): veth_b: link becomes ready
  [  350.607421] IPv6: ADDRCONF(NETDEV_CHANGE): veth_a: link becomes ready
  # 'nettest' command not found; skipping tests
  #   xfrm6udp not supported
  # TEST: vti6: PMTU exceptions (ESP-in-UDP)                            [SKIP]
  [  351.605102] IPv6: ADDRCONF(NETDEV_CHANGE): veth_b: link becomes ready
  [  351.612243] IPv6: ADDRCONF(NETDEV_CHANGE): veth_a: link becomes ready
  # 'nettest' command not found; skipping tests
  #   xfrm4udp not supported

The `unicast_extensions.sh` tests also rely on `nettest`, but
it runs fine there because it looks for the binary in the
current working directory [2]:

The same mechanism that works for the Unicast extensions tests
is here copied over to the PMTU and functional tests.

[1] https://lkft.validation.linaro.org/scheduler/job/5839508#L6221
[2] https://lkft.validation.linaro.org/scheduler/job/5839508#L7958

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 tools/testing/selftests/net/fcnal-test.sh | 11 +++++++----
 tools/testing/selftests/net/pmtu.sh       | 10 ++++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 31c3b6ebd388..21ca91473c09 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -4196,10 +4196,13 @@ elif [ "$TESTS" = "ipv6" ]; then
 	TESTS="$TESTS_IPV6"
 fi
 
-which nettest >/dev/null
-if [ $? -ne 0 ]; then
-	echo "'nettest' command not found; skipping tests"
-	exit $ksft_skip
+# nettest can be run from PATH or from same directory as this selftest
+if ! which nettest >/dev/null; then
+	PATH=$PWD:$PATH
+	if ! which nettest >/dev/null; then
+		echo "'nettest' command not found; skipping tests"
+		exit $ksft_skip
+	fi
 fi
 
 declare -i nfail=0
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 736e358dc549..dfe3d287f01d 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -686,10 +686,12 @@ setup_xfrm() {
 }
 
 setup_nettest_xfrm() {
-	which nettest >/dev/null
-	if [ $? -ne 0 ]; then
-		echo "'nettest' command not found; skipping tests"
-	        return 1
+	if ! which nettest >/dev/null; then
+		PATH=$PWD:$PATH
+		if ! which nettest >/dev/null; then
+			echo "'nettest' command not found; skipping tests"
+			return 1
+		fi
 	fi
 
 	[ ${1} -eq 6 ] && proto="-6" || proto=""
-- 
2.34.1

