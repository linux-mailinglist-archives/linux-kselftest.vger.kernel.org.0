Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F0B75D847
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 02:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjGVAhi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 20:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjGVAhb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 20:37:31 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F263C2B;
        Fri, 21 Jul 2023 17:37:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9C81C60171;
        Sat, 22 Jul 2023 02:37:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986247; bh=0rIok0EQjGTKvrvF2VSOh1b7Lbci4BJ+WsapvWPqS0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AC2oJSH/7x1aPR0Ere43VQEq6IaMuX7vPYg/F1HX8dPzHq7swg73PqxAnW/j0EnRV
         J8EJ1cGXYulr5N9otXP1xsSFE9z9pSpoeR92NDVzmoDRJlaU2trfR62v9ZWWacUzCP
         1m2UVbJBbFpu2uHzCqUOsjSSmOvqiWWZg6NRjgFTvb2INXMGMjebpb+ImFxU4HAlx6
         1KErleLgXm5SydI2SLwIST2/Kz0VSLd5J++RtaN/3hDyctJ5elic7dlCBTqIQzpcKd
         KE+p6wJMhEjdj2oVai8ya4nW5x2kWYkWVonjzMgYT/unwsnl00Ra8Jg0BfsBUWAnja
         TMnvA29AzEoUQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fNK3DkGWk327; Sat, 22 Jul 2023 02:37:25 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 8F2F360187;
        Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986239; bh=0rIok0EQjGTKvrvF2VSOh1b7Lbci4BJ+WsapvWPqS0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ui6S7uvdNgWhgmba5K9OGGRa5oyfotQUulpVDWyVewiPvWs1Bo0usDI1euBMsMheh
         HsouynCu6slqll51WV1iJZPKE7HogdWh5BqasQD4w3Deej4BbY+vdUYoCFzrDtb0qf
         VfrVakBtXb5tCgcAkt7B/RLsVaZCvHbTH3/P00qVxWQ1YaHQI8LYdmYoAhbBL5CwrW
         Z7wYrgaZBqZoWq8yhGZhvEuNDlqEhd+OggJuIJ2a7GIadDATRqUlFK6dBDs+iU67Qv
         G9b20xWgk+I3c7byt4+b84YDfTgBYAsOtK/KAy5kIDD9CS41hdaU63LJ7EG60tiLfp
         vxa8R1aHr6s+w==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Ido Schimmel <idosch@nvidia.com>,
        "GitAuthor: Mirsad Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH v1 10/11] selftests: forwarding: router_mpath_nh.sh: add cleanup for SIGTERM sent by timeout
Date:   Sat, 22 Jul 2023 02:36:09 +0200
Message-Id: <20230722003609.380549-10-mirsad.todorovac@alu.unizg.hr>
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

Fixes: cab14d1087d9b ("selftests: Add version of router_multipath.sh using nexthop objects")
Cc: David Ahern <dsahern@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 tools/testing/selftests/net/forwarding/router_mpath_nh.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index a0d612e04990..0580519ab6d1 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -414,7 +414,7 @@ if [ $? -ne 0 ]; then
 	exit $ksft_skip
 fi
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1

