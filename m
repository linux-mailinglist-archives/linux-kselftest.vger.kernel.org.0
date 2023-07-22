Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359F875D844
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 02:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGVAhd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jul 2023 20:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjGVAha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jul 2023 20:37:30 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C492A3C0F;
        Fri, 21 Jul 2023 17:37:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 77ED96017E;
        Sat, 22 Jul 2023 02:37:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986245; bh=HwfcetItcDbQUyVPKY4tZ80kehqSuVRT0oF1J5uK1jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YU8RSR1NdCV/Dx023N2TtGwF4TBdKLIXZT92YhyTHSblD0kq8uhOg2mnZ0aAzqAKq
         BSJZubtRgAGky2lzWdeN7ZZPPuPXNY1c6iwgxLObo3VMdBT8aiaeOG3T9/Z31T1Uqf
         NVoMofEpSQsEoL6/f8BL6auiKCQlRjPHV79RKj6jAMfbAvFoTFTWvPIT3kpEota2n9
         ETfJoaxH/E3j4e3IAj6BKkJTFdZbJEgq8Sri6FZe2Z5DUtqOqudVrJ9VTjZkdM5uQC
         aC7hdSiXPDirw4rufwL5WK32TwgEVUYy+P35LyozA2Bcltplaram48rrIs0N958Cny
         jIFhzQsMi6E+w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tNUQ11GI3Fis; Sat, 22 Jul 2023 02:37:23 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 5C07B6017F;
        Sat, 22 Jul 2023 02:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1689986239; bh=HwfcetItcDbQUyVPKY4tZ80kehqSuVRT0oF1J5uK1jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvbBph3ZrKfysIxky4I+z2iwcdApcxGddnedz4YAw5O/IlbZ68eSBQ0tTwDS8rvUv
         275u6hTPPkRZBpkeNld7kzEjNk6wMBg+kv1AJBfXLm6q/e22TL6DztB5/3HLCLsjva
         jrU1Uf4GUzWfvB9ywTTT+Me/1ESdKDO6XEQmPSs3OCJ8v/Wk5Q7XB6tJctrtYNCe0U
         1q6FeG8O3hEiJonuluTinO5BmuWtB2NuthjZJvxzsC76wyqELRpdmbbDe/FAdzIFcV
         1dKAHDh3ifknAqbbk/o10EOAPZM5NDLX7pSLYR2Sr8lPeTahwt9xRTn3oCc87jzMfk
         JtWJ/HlHF7I2A==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Ido Schimmel <idosch@nvidia.com>,
        "GitAuthor: Mirsad Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Suryaputra <ssuryaextr@gmail.com>
Subject: [PATCH v1 07/11] selftests: forwarding: ip6gre_inner_v4_multipath.sh: add cleanup for SIGTERM sent by timeout
Date:   Sat, 22 Jul 2023 02:36:06 +0200
Message-Id: <20230722003609.380549-7-mirsad.todorovac@alu.unizg.hr>
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

Fixes: 2800f2485417a ("selftests: forwarding: Test multipath hashing on inner IP pkts for GRE tunnel")
Cc: Stephen Suryaputra <ssuryaextr@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
---
 .../selftests/net/forwarding/ip6gre_inner_v4_multipath.sh       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh b/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh
index a257979d3fc5..093cae3c2a49 100755
--- a/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/ip6gre_inner_v4_multipath.sh
@@ -295,7 +295,7 @@ multipath_ipv4()
 	multipath4_test "Weighted MP 11:45" 11 45
 }
 
-trap cleanup EXIT
+trap cleanup INT TERM EXIT
 
 setup_prepare
 setup_wait
-- 
2.34.1

