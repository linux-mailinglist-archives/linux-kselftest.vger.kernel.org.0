Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C9B705E92
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 06:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjEQELo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 00:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQELn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 00:11:43 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC03DE77;
        Tue, 16 May 2023 21:11:41 -0700 (PDT)
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7532F4026B;
        Wed, 17 May 2023 04:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684296699;
        bh=uKNing954xz7FQw7FvKS/pI3qCFzr7vWKfumoDuRopI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kjcenEifqc63vTT9gXN5ixSp9+ueUVddiUV3UxkPaE42AOUVBC+7jC63I31iVkZC4
         R5rrxq/Jc2Hle46v30dOuornMdcL1NCCU2fcQT1uSWD+b7WcLq+v3eYyiUhjgPAl8P
         dDd562+EoGsznrb8d/LjgpkDmaADdw1j32FLqm5scYqerVfwysTBVu+QqszU3e2t8i
         VKqwpgVBerCnaw5a3xd8YQBudXS0Y6uJtDmu92FikmuH8VTtG6kKDAI1F/RslBhRBM
         pq6PF5+utJPlNUePKtKhrhkcrIydDCEhAhTrTMZqghk6Kkqvm5hQULcnhO1mMF44mL
         64HqJqQ918rZA==
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, dsahern@gmail.com, shuah@kernel.org,
        pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net
Subject: [PATCH] selftests: fib_tests: mute cleanup error message
Date:   Wed, 17 May 2023 12:11:19 +0800
Message-Id: <20230517041119.202072-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the end of the test, there will be an error message induced by the
`ip netns del ns1` command in cleanup()

  Tests passed: 201
  Tests failed:   0
  Cannot remove namespace file "/run/netns/ns1": No such file or directory

Redirect the error message to /dev/null to mute it.

Fixes: a0e11da78f48 ("fib_tests: Add tests for metrics on routes")
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/fib_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 7da8ec8..35d89df 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -68,7 +68,7 @@ setup()
 cleanup()
 {
 	$IP link del dev dummy0 &> /dev/null
-	ip netns del ns1
+	ip netns del ns1 &> /dev/null
 	ip netns del ns2 &> /dev/null
 }
 
-- 
2.7.4

