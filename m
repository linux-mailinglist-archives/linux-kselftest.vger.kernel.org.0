Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014467394B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 03:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjFVBgG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 21:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFVBgF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 21:36:05 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AEB185
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 18:36:03 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A48CB240107
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 03:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687397761; bh=vn5lWO9L26Hc+cT/azimR/ufDacqIFsyS9y1ITX9c+Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=EylOBdjc7dp88u898CPNSrTu/ltrxjDY0bDTIW3B9ZkgQVwDnWo8gwTU25mdpY7HG
         nQ9d2vuTXWne4OWH/VNRsqjDJ7ri+vh7Ib5C1glP84wPZb/d2wpPbk3IRGalCUzlHv
         sP2OAcbXccVUUpgECJC6FvK2IAR1zUNgahtkTu2zqi01L17dmK5JYejsiM/2FVQ3sH
         4Rv9FtZiuak6UqnhnQAXATWxs4nWbqxEsYdj+YyoQx0SpjsP7TVUtH+LVYt910xIfc
         oMHH3FI9zZvwaXbeoh7t4yskIuCUW9RWUE7bkWV/p45QqPT1Bp8Gn3Jl+zLSs/jl+p
         mXl52eYvBbkQw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Qmjcp1kcSz6twX;
        Thu, 22 Jun 2023 03:35:53 +0200 (CEST)
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
Subject: [PATCH 8/8] scripts/spelling.txt: Add "transmit" patterns
Date:   Thu, 22 Jun 2023 01:26:37 +0000
Message-Id: <20230622012627.15050-9-shamrocklee@posteo.net>
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

Add "transmit"-related patterns misspelled with the first "s" missing.

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 scripts/spelling.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f8bd6178d17b..c81e489ba4cf 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1319,6 +1319,12 @@ ressource||resource
 ressources||resources
 restesting||retesting
 resumbmitting||resubmitting
+retranmission||retransmission
+retranmissions||retransmissions
+retranmit||retransmit
+retranmits||retransmits
+retranmitted||retransmitted
+retranmitting||retransmitting
 retransmited||retransmitted
 retreived||retrieved
 retreive||retrieve
@@ -1553,6 +1559,11 @@ tranasction||transaction
 tranceiver||transceiver
 tranfer||transfer
 tranmission||transmission
+tranmissions||transmissions
+tranmit||transmit
+tranmits||transmits
+tranmitted||transmitted
+tranmitting||transmitting
 transcevier||transceiver
 transciever||transceiver
 transferd||transferred
-- 
2.38.1

