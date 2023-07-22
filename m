Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080B575D843
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 02:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGVAhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 20:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjGVAh3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 20:37:29 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F0D3A9B;
        Fri, 21 Jul 2023 17:37:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 6F40060171;
        Sat, 22 Jul 2023 02:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986243; bh=TDT1v0dxZBetJ381eDhND50soCJEI+UHL2fqhwIyxGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TsXJjIPxljgrUOqt0aas8xuyQKXeDlFyGolY7UOuMhrBoE7g0DdA6BB/ij9coqH+i
         dDYZ8znAm5rIzMSREkNoWT3KUtkjzRh8/0sM+RfDl4gTuUeyLyFKL+AovUrcRQjPox
         /YotyadJJ7yjhhV7MtR1TE+3ExDKV8QV6/8oYaZQCK/3IJFHaPyFBN1/sRazTda3wt
         lvWb8G/2eOpjZFNkv8jE2yrn57zylUNym2PK2ynCH3kNSYN9YMV1oM29QTq9rpdrD0
         XCNhqyd817JrqPZux90hZN1Kae/IODn17RFzGsIbnIhEHHtZEU5FoK0sPY+WdcB9Tw
         BxKsv57xDQl4w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G4Jy_5ef4K22; Sat, 22 Jul 2023 02:37:21 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 4F9756017E;
        Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986239; bh=TDT1v0dxZBetJ381eDhND50soCJEI+UHL2fqhwIyxGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qG6r7ZJA2BEs1rcQe6qLyW+h7b7ynKRJVjn2+uk3DRDUZy2tbrYaFbFztJDPAingx
         gXsvIFBO84y29yAlKyEY3i9PMZcTzaoNbsSZs69X6giGE3J1Wo936O8dtJcxRDiDIY
         CyD0rRUZhv496mPu0h4Ylf7vpm6qG9yoYTCUOrAh93aGJaxfZzOYfUvfdpKLIoFVXH
         51vIPFVnzVevwL2UaUFraeVIk/wsC7qraLC598XGvL/OB5nBXLE4bcFpOELAqQ1WSK
         kCVE+JIX6xBYH+uyDAeolMK0w+wzCh8VmqUr2Fpspl3vYwU03isSr3DKvA0NKhNl6b
         dQAPES9UOCVxg==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Ido Schimmel <idosch@nvidia.com>,
        "GitAuthor: Mirsad Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 06/11] selftests: forwarding: ip6gre_custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Date:   Sat, 22 Jul 2023 02:36:05 +0200
Message-Id: <20230722003609.380549-6-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add trap and cleanup for SIGTERM sent by timeout and SIGINT from
keyboard, for the test times out and leaves incoherent network stack.

Fixes: b7715acba4d3d ("selftests: forwarding: Add test for custom multipath hash with IPv6 GRE")
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 .../selftests/net/forwarding/ip6gre_custom_multipath_hash.sh    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
index d40183b4eccc..ea6270ec7478 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_custom_multipath_hash.sh
@@ -457,7 +457,7 @@ custom_hash()
 	sysctl_restore net.ipv6.fib_multipath_hash_policy
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1

