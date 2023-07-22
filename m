Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAA75D849
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 02:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGVAhk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 20:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGVAhc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 20:37:32 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184EB3C2D;
        Fri, 21 Jul 2023 17:37:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8F3196015F;
        Sat, 22 Jul 2023 02:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986247; bh=dvw4jQyDzBRR25YNVtUBVTam1ATqnuEuxF59MWqbQ3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OuzaO/4b2xlbzps8wDjDBv1+5LFxOHN9iJGYzUH0prsZJ+YuWvMWcAIBLLqi4TfSp
         hT3JTkHNC4bWjQjmnHNWj5CIJ0dnWFFN8RxEVyX6yux63lGeb/qq5+ol5AmuGqInpV
         4wBjNde0MJUMAlQEHVzbmaRp+IGskbTC7UMdIuBk3UahwwM07JQRzmq65QqzUjOI14
         jaoMt2zks1BgadbQueJcIJ2kQgAVSOvcGcFd0l7CV1s47bPuud01klx4Cdf6wPEZL7
         LvMDyD1ochnbwcIhr0RxgExxG+hm1v23sqhMKUKFRaw0ZYLijA+2ez6nV6kjQUqial
         m0gkO2yqjErCA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q2_1_dsYMO7E; Sat, 22 Jul 2023 02:37:25 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 800C860186;
        Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986239; bh=dvw4jQyDzBRR25YNVtUBVTam1ATqnuEuxF59MWqbQ3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGZFZjdVFPNrjDD7A3s2/gq/4PS/wVHydLDSUnWPz0JSvb8NYT8RoIXXwvkH5ukN6
         RN5eBaKDmS5cEpwz5s71AgIDY86Fykd4DpgDt5iKLllqBuFJOHDdBeqmyQSgvF2LdM
         hBmgr/sKoLlgmvoKd7IVacEgWFj189NOW5k42bTfQp/nSFi1KPSDidG4KGyhtclgpT
         yl8kwV0d1HF3U1kXaFlxH1VB2bbwk8K/NEK5xpbpt91vuTH+6FU3eQ3ZXLp4QtKElW
         JpNEaPLs9P6PdEFmBMeBXb11egdu4ygTy+pZBa6zgdngJ83SDE8PfdFfigVYM1URqH
         VGqMGGKRx7a0Q==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Ido Schimmel <idosch@nvidia.com>,
        "GitAuthor: Mirsad Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 09/11] selftests: forwarding: router_mpath_nh_res.sh: add cleanup for SIGTERM sent by timeout
Date:   Sat, 22 Jul 2023 02:36:08 +0200
Message-Id: <20230722003609.380549-9-mirsad.todorovac@alu.unizg.hr>
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

Fixes: 386e3792b52a4 ("selftests: forwarding: Add resilient hashing test")
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
index cb08ffe2356a..57e211d6f859 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
@@ -389,7 +389,7 @@ if [ $? -ne 0 ]; then
 	exit $ksft_skip
 fi
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1

