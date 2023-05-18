Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A8C70787B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 05:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjERDdj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 23:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjERDdj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 23:33:39 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA5B30E6;
        Wed, 17 May 2023 20:33:38 -0700 (PDT)
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3D89B3FDAB;
        Thu, 18 May 2023 03:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684380814;
        bh=kL6aA47L3WqEzNl5PtMbesiM21ZCN2OSCmuu6MyV2UM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=PaTUDXGzVbVRyhjf3Oe9r+ChzzYrmoY7W2d4ctyetr9PK46AebFjdxr7PU14gSXz7
         xOlEQQ97uocBYFuuOe1fMk+N+agp0Epso2s62x1z5MbGNvNzzE9FWeb5y2pkptrM9P
         VtVe0eWAUeN5CPCNXt+M7V4/QLuzMco54aHODhFvw663qu0eMpkPNKE92lomoidX/9
         WZF7a7duapjsK5kAZoVY0glr/X9lcSTfV7LbVIuluDSGx93ttghErZ8BsMHvTzANs2
         AxCBIhqSxojHch1y3qeNZRRorH6zupwLZYJ1ujNFZdyjERujkA+sgqKcgHPRkOk8+5
         6E2VZp3RkvNPg==
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, roxana.nicolescu@canonical.com,
        shuah@kernel.org, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net
Subject: [PATCHv2 net] selftests: fib_tests: mute cleanup error message
Date:   Thu, 18 May 2023 11:33:10 +0800
Message-Id: <20230518033310.19893-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This can even be reproduced with just `./fib_tests.sh -h` as we're
calling cleanup() on exit.

Redirect the error message to /dev/null to mute it.

V2: Update commit message and fixes tag.

Fixes: b60417a9f2b8 ("selftest: fib_tests: Always cleanup before exit")
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

