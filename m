Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDD07394AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 03:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjFVBeK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 21:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjFVBeJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 21:34:09 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D91FC6
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 18:34:03 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E594A24002D
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 03:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687397641; bh=Qo7/utFY+AUkkN8SfWpvXJ8a9KR8TVuJ4Y5tbnHu3+4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=nDlet/DGQtB076LH/Ikm3SyWNrgEvqu1HAGDpHrcTdRcJuBKduw6R59CfsoD0lWJ7
         KRpMnwyfbEQkswUZtBgbjjP0ZwTxZ7io6D0gHeTb/EGiMFNXLvNkgpV2zVILzoUJ8X
         cLZoTz4dua/vyfp7cs5k3tbYNXGY+CZkVx17/jrIPlAJ+7tm4czTWZrPJ1aHdMU91/
         s20jeQKR/r+IEaezGpcZhA7XCz5e81OkAlsJacDh3hs3P4FIz3fZR9xlZFvsMp36x6
         f90UzZ6qvD1d/nxgKPmsTG0dOkzZPhoRBSrAXuCDwcJFTUHH2NaMpUAdytA+V+xHu7
         pKBx/d3UIkFnA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmjZV4L7Sz6twX;
        Thu, 22 Jun 2023 03:33:54 +0200 (CEST)
From:   Yueh-Shun Li <shamrocklee@posteo.net>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yueh-Shun Li <shamrocklee@posteo.net>
Subject: [PATCH 7/8] selftests: mptcp: connect: fix comment typo
Date:   Thu, 22 Jun 2023 01:26:35 +0000
Message-Id: <20230622012627.15050-8-shamrocklee@posteo.net>
In-Reply-To: <20230622012627.15050-1-shamrocklee@posteo.net>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Spell "transmissions" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 773dd770a567..13561e5bc0cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -809,7 +809,7 @@ run_tests_disconnect()
 
 	cat $cin $cin $cin > "$cin".disconnect
 
-	# force do_transfer to cope with the multiple tranmissions
+	# force do_transfer to cope with the multiple transmissions
 	sin="$cin.disconnect"
 	cin="$cin.disconnect"
 	cin_disconnect="$old_cin"
-- 
2.38.1

