Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3868875D83C
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 02:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGVAhV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 20:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjGVAhT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 20:37:19 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59663C10;
        Fri, 21 Jul 2023 17:37:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9DD8F6016E;
        Sat, 22 Jul 2023 02:37:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986233; bh=QsuXCGAwOh2wClg+15zK1xj3+9ZgIEV9Mxn1Nstx2xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BO3I7SJcmjm4SpPb87PXXsPW5WvN9Kdq8YMumZhailfO2ze8Jo4+S+uzjkdk37g6q
         d5GoT5fqVbz+EXmLcZnXi/EULG0OZbXVgbsViR5zAL6ejH15iRFkxSx1mh1cQcxQwP
         7c9TH3b0e1JIkMD4gckWNshRV5jTa87EuFHZlYkPlJQb34i1FkANdjYGicJx6rkxtz
         KuHvs3YjadspjlVsol1q/CqI2eG3XVBDAlTdG1+UjQFY3KSO2PoSTk1QDHrad7TIIf
         4Ijk2tKM9WEJY6p3yYIIMyylmerstprPxmK/keZBCbaFEonoFbaAPCGsRlfakBZrQT
         LzAXiq0X8ZyoQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3M1XdNMalUBo; Sat, 22 Jul 2023 02:37:11 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 62D336015F;
        Sat, 22 Jul 2023 02:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986231; bh=QsuXCGAwOh2wClg+15zK1xj3+9ZgIEV9Mxn1Nstx2xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6aZ04F8IDRyBsgkG+RL6hYYCwhX0DL3ddudN29gAXx4bkNQzYDAKleQLQzQOfLAI
         B93l//NPF/WjMJCew7JBgjR+gh6DQ/b+ZW/LulPg5ZJPCT+orGFas9LyKQv6ICnqF9
         3nnJI8Kavw+6fNuoY+6GBd3P/UaZMYieM7mQOyreUf0Yv/Kjmx7p72wfW16PmzJbGW
         XUTe0dbj+j3oqJvLeUb0DldRTRpkNeznr0soEt85eOhDOqlZHqrR46/XaaUyyc0a6R
         Hj+RaBm8iz4z3hGvUAHRIXBt/xaOsD2eXNgn1EDYRaLr/OxSDyt+v6H1E56SB/xFJp
         e1I4JHwatGQfg==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Ido Schimmel <idosch@nvidia.com>,
        "GitAuthor: Mirsad Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 02/11] selftests: forwarding: gre_custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Date:   Sat, 22 Jul 2023 02:36:01 +0200
Message-Id: <20230722003609.380549-2-mirsad.todorovac@alu.unizg.hr>
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

Fixes: 185b0c190bb6d ("selftests: forwarding: Add test for custom multipath hash with IPv4 GRE")
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 .../selftests/net/forwarding/gre_custom_multipath_hash.sh       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
index 0446db9c6f74..ca24dbed3bdf 100755
--- a/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/gre_custom_multipath_hash.sh
@@ -455,7 +455,7 @@ custom_hash()
 	sysctl_restore net.ipv4.fib_multipath_hash_policy
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1

