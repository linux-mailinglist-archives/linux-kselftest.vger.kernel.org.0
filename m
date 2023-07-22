Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4413975D846
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 02:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGVAhf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 20:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjGVAha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 20:37:30 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A283C13;
        Fri, 21 Jul 2023 17:37:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8601E6017F;
        Sat, 22 Jul 2023 02:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986245; bh=pTPk5QVJQzy4beH8ZuTqLRthaCgM62PmnWjd63M9UV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gAN3W35FU0YoUJaDkx6ltr9K5vnKfLaV9/25bnRwbqBaN2Y27AZ/HD5Wqd2Ul1Mf
         rhE+BDCI+iqSJqydmp+GFmViBwi1Pk9CFZdIlOoRhpERqAWWWgKpD83fqdD/m9Pt0o
         htBHCy4ZI2jWJztgw+LmgyhIvvfybK5E9ipW2Do+gqP/QRT3JVsKPgpIbVNstoY46Q
         VN8HAN7HF7npa2SkPPvNgod9MxZRYHdUOLmRxe9Y02IVnTC0lZJfHj8TYykwFGPvSo
         oU1cC2RPctXdHynJRrJQ3RiJu0fCstfr/KXNXS7w6xs2W7vZiXpvYL6/qVmuqMHk+u
         wWAQdz7q/lX1A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k8aBC5yL3xMl; Sat, 22 Jul 2023 02:37:23 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 68C3A60182;
        Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986239; bh=pTPk5QVJQzy4beH8ZuTqLRthaCgM62PmnWjd63M9UV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWoEkSWWwGtCwM7ho0noxsldMed1jWELG2CyVEaX8Dd6Ohfc7naN320ryGCXWo++u
         z/vw5GA1+TN7HIyrXWwzX5rIWApMPu9uN2Ew1uqz44tFsgWG1sjOIq7jnuV5KX/H+o
         x3juthC2hll+VytPM9mdG3GHj02O8YWxo8CxZgY/8qPG4K0GqldFxyteZlgXIfqHlp
         9wvxR5cEr4SP/bYccsU9Er2q0dqH51fOFbJvLQJ5Jh9a1KyThMzPWBIQi2v/2Q+aoL
         kX8o4IxbtO/ZQWcOVoqAwVRssTKZpD3haM2z99BBogcMg6EgdUO0c2SyWVd+xD7O2x
         yOzsWUfNhYUVA==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Ido Schimmel <idosch@nvidia.com>,
        "GitAuthor: Mirsad Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v1 08/11] selftests: forwarding: no_forwarding.sh: add cleanup for SIGTERM sent by timeout
Date:   Sat, 22 Jul 2023 02:36:07 +0200
Message-Id: <20230722003609.380549-8-mirsad.todorovac@alu.unizg.hr>
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

Fixes: 476a4f05d9b83 ("selftests: forwarding: add a no_forwarding.sh test")
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index af3b398d13f0..f748954aa1cc 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -251,7 +251,7 @@ setup_prepare()
 	ip link set dev $swp2 up
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1

