Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE186EE96E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 23:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjDYVMR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 17:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjDYVMO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 17:12:14 -0400
X-Greylist: delayed 1403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 14:12:09 PDT
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD7C178;
        Tue, 25 Apr 2023 14:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AOVG5I1DSvWz8UNhmIDlF3Fpix1rzT7Iys/S5bVmUTc=; b=q7G0FPZMWPn+rXo2GWJh26ma54
        TJCWTmzgGbfZckMTEf1SJXj0YzNugjq8T9/JCSwRmFO1Cjn2GKIZ6c7ztgGkkX2RUFPfg3tNvZyCc
        nC6CykoJBQ5+cg06ChiSfs5Dfu56YuJjSuobPJDIzcxH3LQ0rq8C7dzNId6VMec+nIo7AFj62WZFO
        brZbxfCzhy60JU6lsF4Qw2LKb7XPm3HiyVQuZh8Zr2J+CjKlO0ltyEDO0AT7NQAfvpTf7pGTTuw/0
        X/27L3x1Ne7dCXMsCrkoSZBrPQD+4J5vHOj3tvl6+HPJ+Z1KQtjWlhcdAWCwe8rjIM4cgo5kUwEmj
        +zzaaAsw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1prPxG-009bfZ-4q; Tue, 25 Apr 2023 22:12:06 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Jan Engelhardt <jengelh@inai.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Kai Liu <kai.liu@suse.com>, linux-kselftest@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH nf] selftests: netfilter: fix libmnl pkg-config usage
Date:   Tue, 25 Apr 2023 22:11:39 +0100
Message-Id: <20230425211139.518381-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZEgArba2jGAGy0/Z@calendula>
References: <ZEgArba2jGAGy0/Z@calendula>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

1. Don't hard-code pkg-config
2. Remove distro-specific default for CFLAGS
3. Use pkg-config for LDLIBS

Fixes: a50a88f026fb ("selftests: netfilter: fix a build error on openSUSE")
Suggested-by: Jan Engelhardt <jengelh@inai.de>
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 tools/testing/selftests/netfilter/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index 4504ee07be08..3686bfa6c58d 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -8,8 +8,11 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
 	conntrack_vrf.sh nft_synproxy.sh rpath.sh
 
-CFLAGS += $(shell pkg-config --cflags libmnl 2>/dev/null || echo "-I/usr/include/libmnl")
-LDLIBS = -lmnl
+HOSTPKG_CONFIG := pkg-config
+
+CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
+LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
+
 TEST_GEN_FILES =  nf-queue connect_close
 
 include ../lib.mk
-- 
2.39.2

