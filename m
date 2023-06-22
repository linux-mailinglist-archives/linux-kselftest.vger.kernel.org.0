Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B277A7394A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 03:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjFVBdq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 21:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjFVBdo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 21:33:44 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054951FD8
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 18:33:35 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9C2EE24002F
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 03:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687397613; bh=ua0QK6EC/OqIc9NpFWckWJA/7En1GQHaNHUYKDQh45A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=HfdEgLLZGnqn8oxDQy5cJS0VAWIGo38Lmvtq9HsQSdPiokJhWu1RzrTs/kuMYV+3s
         EA71sePC2PEtYxgNjWV8/AkFESitDoJnX7q2IbQCFByxvsDxZWRvXeuybCgBRjwPLw
         9ZBusiKAduWw1Mh1vWWPUiXoEUv8kd2auxzLGxlWHDXy0EJ47Uyho0oRavSg4t+mlc
         Glxq+bKZ2gg1FWxXhppKqRa3RTnMCRnIVAWhJi0ONfjjLqg3d4Xl8sVl5cu1AER1Jw
         WQVzpBRvvYbUmcSY+KpYpxuDpws3g+wzKsBkXTdq9RVK2tKje6j698CCCOvFtG5qFE
         t2gab8Gqj64/Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmjYy1Vy9z6twX;
        Thu, 22 Jun 2023 03:33:25 +0200 (CEST)
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
Subject: [PATCH 6/8] net/tls: fix comment typo
Date:   Thu, 22 Jun 2023 01:26:33 +0000
Message-Id: <20230622012627.15050-7-shamrocklee@posteo.net>
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

Spell "retransmit" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 net/tls/tls_device_fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 7fbb1d0b69b3..b28c5e296dfd 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -271,7 +271,7 @@ static int fill_sg_in(struct scatterlist *sg_in,
 		 * There is a corner case where the packet contains
 		 * both an acked and a non-acked record.
 		 * We currently don't handle that case and rely
-		 * on TCP to retranmit a packet that doesn't contain
+		 * on TCP to retransmit a packet that doesn't contain
 		 * already acked payload.
 		 */
 		if (!is_start_marker)
-- 
2.38.1

