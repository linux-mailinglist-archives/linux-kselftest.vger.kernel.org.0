Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525E1739493
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 03:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFVBcY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 21:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFVBcX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 21:32:23 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCD61BD5
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 18:32:22 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B0A3A240101
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 03:32:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687397540; bh=V9k96scDZkwEItaNXbCiChE4dAzMQL5AXCtzZjXTyjY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=lBIvaDU2cgL+XJ78CbU1QOzvjxWxUEOE/UCb//cMF2huKX9dQgHMQFNlxekRPoZkV
         HUZK1HXRcoro3PqE35yhfMPdXSvAdfwuNI7/yO9gNcCHxSYvmjthu/N9D2SXh1a91i
         KTmjgch7Tkc+QqkXq1LScMr0WMyUtfPMWNd+plKwqUFwjrXQSq49zBDzI3t9ijrQ8L
         tk4CxBLMM+DiQs2x4IkwLs+l/x89XBq4AM+QOoMh7UJXuAxjx+1FEVi4bVYwYZoyNx
         QDArqUW9I3Xh7gF3VFK2/EMDI2k26T+GVwMe09zHKLx2GMUb7QnHUtLAIJ53wHn/78
         TF2ptWQ6CmU7g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmjXY1hkqz6txl;
        Thu, 22 Jun 2023 03:32:12 +0200 (CEST)
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
Subject: [PATCH 3/8] zd1211rw: fix comment typo
Date:   Thu, 22 Jun 2023 01:26:27 +0000
Message-Id: <20230622012627.15050-4-shamrocklee@posteo.net>
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

Spell "transmits" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
index 850c26bc9524..8505d84eeed6 100644
--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1006,7 +1006,7 @@ static void tx_urb_complete(struct urb *urb)
  * @usb: the zd1211rw-private USB structure
  * @skb: a &struct sk_buff pointer
  *
- * This function tranmits a frame to the device. It doesn't wait for
+ * This function transmits a frame to the device. It doesn't wait for
  * completion. The frame must contain the control set and have all the
  * control set information available.
  *
-- 
2.38.1

