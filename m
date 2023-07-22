Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4478C75D839
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 02:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGVAhC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 20:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVAhB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 20:37:01 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF06B35AB;
        Fri, 21 Jul 2023 17:37:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 79CEA6016E;
        Sat, 22 Jul 2023 02:36:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986219; bh=QMQEJwodT9o6IRxHFTIzt5RjgYwj1u0/oGn1cqYAU4c=;
        h=From:To:Cc:Subject:Date:From;
        b=PEQ44MRweThypBxWnT+EIhVDBZ241yyRAcnFa0vAtS/wG5FErRs0pN4x6enAEA7kk
         KSkA+IGdo/3po02P6SU0jYtNOWEy+FxTd02rv+GmNdO9LGbn8MvhEroqEQ163lfa4t
         P8EkjW5SNp5ITRq/8bwN1YneQ+EB6nM3D++j6BjiwKez4pxNhPoqF786Tv9E3KR4Nz
         Y1YNRbcp2T0119cZB4OQtUw/VsRjRCzPIzgvnkuhuv3Um4vif2dpgU4S8mcisFkuxR
         uQb3ugN7jqHwvKUtWcMGWCIiYl2F/yQjtOOXaWSKAs3JZz0L1IoxORnfatdlnVXHxW
         hk2ZGvNPcmFoQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fTkdtiiJxTHU; Sat, 22 Jul 2023 02:36:57 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 35D2F6015F;
        Sat, 22 Jul 2023 02:36:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986217; bh=QMQEJwodT9o6IRxHFTIzt5RjgYwj1u0/oGn1cqYAU4c=;
        h=From:To:Cc:Subject:Date:From;
        b=Gm+fzv98GfXBxtE53VsjjfyRLGd3FzaW5WjkGwUgCO5J6DiGc/2VYnydkWp7ECDJw
         zfA6pDFbnuSz1PtP0ssU7erKX+Symrdh/aN7eLrXv8sfcKCzk2I03cE+nnqHpdj215
         k+Znsb2XfGb0xgWDFKhgv+FomDcB1QPPjNx3/ghG89DpgRi9PSrffqnXNKYx3HTWMr
         Ed//S7kPKUYDbaJHVnxhvoufdzk7I8CaO1qHyEIVK71jQmLIZsKq2yWivegcJEQAr/
         wHMLcOH+nKd9s3KqY13ZKls8k/YbXZM3GRfE2juB1j83ns3yHjUtIdducmXhtIEQDX
         183XBirqKgxeA==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Ido Schimmel <idosch@nvidia.com>,
        "GitAuthor: Mirsad Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 01/11] selftests: forwarding: custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Date:   Sat, 22 Jul 2023 02:36:00 +0200
Message-Id: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
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

Fixes: 511e8db54036c ("selftests: forwarding: Add test for custom multipath hash")
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 tools/testing/selftests/net/forwarding/custom_multipath_hash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
index 56eb83d1a3bd..c7ab883d2515 100755
--- a/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
+++ b/tools/testing/selftests/net/forwarding/custom_multipath_hash.sh
@@ -363,7 +363,7 @@ custom_hash()
 	custom_hash_v6
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1

