Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE95873948A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 03:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjFVBbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 21:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjFVBbA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 21:31:00 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E411BD7
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 18:30:58 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5EB3B240101
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 03:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687397457; bh=09XlL1/vCcPG0ljTp3PwBDMDDpta1CZKydZBQ7XpElA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=lORN+8euUeR65leU70KFB+GzuyC2mG9G1lWZj6VxVqQrqjtPfe7uox1tDXML8/kLm
         MqYL76DjhUw5q64r9OcfvbYB7u5lKRVuef17z4zdPW+6l3UtNWSKD9N8MX3azYjI7z
         McsiG5Ho9HLWEUfpkEBTa0qs8L4KHoQ/gTyt7AqiSx4oNiMFIMe6sEn/xsqZItTd7y
         NUqwLKpvf8dBH8zsB6c3y4Zv3BOfLq3PEX0E7j4UY8HnA7Pn1Wb57nfwLJzKSlZmA4
         xJz7rYQ9Pa83IwrRuWYg63QKSjaBNU/PZj48dG0g0lTnRpRc/EDN9rtE/pQNHs9/U+
         sKxIKVftt+uTA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmjVy0jmWz6tx4;
        Thu, 22 Jun 2023 03:30:49 +0200 (CEST)
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
Subject: [PATCH 1/8] RDMA/rxe: fix comment typo
Date:   Thu, 22 Jun 2023 01:26:23 +0000
Message-Id: <20230622012627.15050-2-shamrocklee@posteo.net>
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

Spell "retransmitting" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 26a20f088692..aca0f4c7a5cd 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -237,7 +237,7 @@ struct rxe_qp {
 	atomic_t		skb_out;
 	int			need_req_skb;
 
-	/* Timer for retranmitting packet when ACKs have been lost. RC
+	/* Timer for retransmitting packet when ACKs have been lost. RC
 	 * only. The requester sets it when it is not already
 	 * started. The responder resets it whenever an ack is
 	 * received.
-- 
2.38.1

