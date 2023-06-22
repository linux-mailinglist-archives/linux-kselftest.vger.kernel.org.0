Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1029739499
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 03:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjFVBcu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 21:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjFVBct (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 21:32:49 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055291BFD
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 18:32:44 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9E6D824002E
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 03:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687397562; bh=GKtOed9BmMvqskcyFbDK1sPmS6WF3XBkk8yXvuNWUbY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=dqwOARtvLqk6QjqCZzRf1A9Cb7QJatG9jEA7sCc4rVtQSuZuszhF7NqPFPrY++huU
         GZrEASS+ZEl+A1tvSWjsHEGutpxICMmhoRBrB7H/2tEgLQGPUONvFoON5AKcoiGQjT
         DqpQkt1AeMByfXNnd68Uaen55YvsOhQdY+YoPLOoB7/V66557BtnxeYhqQmWjLRkxN
         A64ltCjbby9MiM/7+1IcJvXemFom3STActCAjjhcKqIrCgGsGp59sWtuOgloLXtDTG
         P6mIJO5CdwG/NmV8lFXxk2CtFouWTiA0xXZGglqS0H/MSEtkqJvtHAKGhwpPNZDodG
         0jH17Xtku+V1g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmjXz26fmz6twX;
        Thu, 22 Jun 2023 03:32:35 +0200 (CEST)
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
Subject: [PATCH 4/8] scsi: fix comment typo
Date:   Thu, 22 Jun 2023 01:26:29 +0000
Message-Id: <20230622012627.15050-5-shamrocklee@posteo.net>
In-Reply-To: <20230622012627.15050-1-shamrocklee@posteo.net>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Spell "transmitting" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 drivers/scsi/isci/scu_task_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/scu_task_context.h b/drivers/scsi/isci/scu_task_context.h
index 869a979eb5b2..582d22d54689 100644
--- a/drivers/scsi/isci/scu_task_context.h
+++ b/drivers/scsi/isci/scu_task_context.h
@@ -845,7 +845,7 @@ struct scu_task_context {
 
 	/**
 	 * This field is used by the SCU TL to determine when to take a snapshot when
-	 * tranmitting read data frames.
+	 * transmitting read data frames.
 	 *    - 0x00 The entire IO
 	 *    - 0x01 32k
 	 *    - 0x02 64k
-- 
2.38.1

