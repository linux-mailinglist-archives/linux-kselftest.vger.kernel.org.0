Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7F75D84D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 02:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGVAhp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 20:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjGVAhg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 20:37:36 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D93A84;
        Fri, 21 Jul 2023 17:37:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id AA7CA6016E;
        Sat, 22 Jul 2023 02:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986249; bh=sWsZGt692J5HLzblOPdvGK1H4fS6uyGBmVHdVo25xyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdep9Oq/WlJCI2xzqQkNIZ0+u3/SEiLmfoKCDOS28kJgR5y8OU85NG+BbmnYIgFcF
         MCC9ntPCe420CWIQkibZcDUqs/M9i2GtdZl9rgJnqJlPhfholm3FZPOKt88SvGoLLM
         B68fD8b/q/SCUpII8uMu/1WK+i5UKu3W131LVI9nyY8eqGYF/ba1Jva0AmCYzH18es
         kIdNvp2Dj/boLPKtcvFNilUfjeZ/9aAtUxJNeeXO7EfvYzv/onDUfcRucl1zLUzfzh
         AsY8FiNd8W1wlYgVp+NvXyfhxFOPU2MRlB4WlM7OGeIpzM0NmmSQqXyuPAErKY+jS8
         kbtJO+LvNI/mw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 79G8b3vzwaBk; Sat, 22 Jul 2023 02:37:27 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 9E54760189;
        Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986239; bh=sWsZGt692J5HLzblOPdvGK1H4fS6uyGBmVHdVo25xyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrfRg3QhteGDLZWiP859NVNSPoQl3xNBdNBJ8rgEZuost82DAK24QzpCOGEJgrSr9
         DOxaiPsAv7JQQqKIEZmjXDhXaJT3/iT1/nH0l3Vf6fT94s+QzkzuI0JDk18DXJrGFo
         QcaNf2S69CaaMWh6Wg1E4x1BQ9lbc9UUstoTiBN8whBDIeqPCagev2zmjuQe4mZLQd
         Q8zYpECXNnS/s/XkzN8Gr2YX/CpOhBNmBMCJq2VCj3gKagRFF/idVOs77vn7NNEpMC
         45VdBX1gD1f6QBrn/mHeZQm+PCkm0gN0h6NhAQXIokQmKxgJhAsWKQMus/Yw+PU7UM
         lRZqR4Z8zep8w==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Ido Schimmel <idosch@nvidia.com>,
        "GitAuthor: Mirsad Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 11/11] selftests: forwarding: router_multipath.sh: add cleanup for SIGTERM sent by timeout
Date:   Sat, 22 Jul 2023 02:36:10 +0200
Message-Id: <20230722003609.380549-11-mirsad.todorovac@alu.unizg.hr>
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

Fixes: 937eeb3482748 ("selftests: forwarding: Create test topology for multipath routing")
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 tools/testing/selftests/net/forwarding/router_multipath.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/router_multipath.sh b/tools/testing/selftests/net/forwarding/router_multipath.sh
index 464821c587a5..7b3cfe577e00 100755
--- a/tools/testing/selftests/net/forwarding/router_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/router_multipath.sh
@@ -332,7 +332,7 @@ ping_ipv6()
 	ping6_test $h1 2001:db8:2::2
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1

