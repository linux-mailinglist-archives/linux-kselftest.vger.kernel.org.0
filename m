Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F46FDC72
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 13:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjEJLR4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 May 2023 07:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjEJLRz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 May 2023 07:17:55 -0400
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E6AC2;
        Wed, 10 May 2023 04:17:52 -0700 (PDT)
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 34ABHOil003525
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 10 May 2023 13:17:25 +0200
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net 0/2] selftests: seg6: make srv6_end_dt4_l3vpn_test more robust
Date:   Wed, 10 May 2023 13:16:36 +0200
Message-Id: <20230510111638.12408-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This pachset aims to improve and make more robust the selftests performed to
check whether SRv6 End.DT4 beahvior works as expected under different system
configurations.
Some Linux distributions enable Deduplication Address Detection and Reverse
Path Filtering mechanisms by default which can interfere with SRv6 End.DT4
behavior and cause selftests to fail.

The following patches improve selftests for End.DT4 by taking these two
mechanisms into account. Specifically:
 - patch 1/2: selftests: seg6: disable DAD on IPv6 router cfg for
              srv6_end_dt4_l3vpn_test
 - patch 2/2: selftets: seg6: disable rp_filter by default in
              srv6_end_dt4_l3vpn_test 

Thank you all,
Andrea

Andrea Mayer (2):
  selftests: seg6: disable DAD on IPv6 router cfg for
    srv6_end_dt4_l3vpn_test
  selftets: seg6: disable rp_filter by default in
    srv6_end_dt4_l3vpn_test

 .../selftests/net/srv6_end_dt4_l3vpn_test.sh    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.20.1

