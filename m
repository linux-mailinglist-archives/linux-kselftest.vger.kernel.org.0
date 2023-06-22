Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C5A73949F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 03:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjFVBdQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 21:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjFVBdP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 21:33:15 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE18D1BF4
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 18:33:08 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 9B2ED24002A
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 03:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687397587; bh=Db7tJRwCI2sfN/eoZqTNayUe3toQkg0kEoXA0Xol1V4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=jkKpchV6d5qDaXAUgzQiTGyr9g3/w9QXL5Kpt7xGTH362QeFX6QraF5uTQ1aWcqLR
         nFJ3voqtkUW2uaJkbUZlMihuBBBJQgKHqTSHvywR1nUaG+w+7AhBGGLdnfCkYg1K4y
         yt+L/XAgBk1m/07Q5E/GZ7qdOpx8FABvpSpdeuaRlKKfkrwVoaouHgsOE1eBEVtnx7
         zAPa3N1mq5ThvTNS1P6N84MVYsscVm6V7VVybgWBNL45nFiuAY6wZQiWPFHsrd3HOq
         Eyz8/xJX1Eb+7nxBJpG54GAMt4BLCGuH7V/WMc8JS9egZdPRUmGjEt9VuZWsmfXj51
         /4vMiy4xI6OZw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmjYS3Kq6z6txs;
        Thu, 22 Jun 2023 03:33:00 +0200 (CEST)
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
Subject: [PATCH 5/8] tcp: fix comment typo
Date:   Thu, 22 Jun 2023 01:26:31 +0000
Message-Id: <20230622012627.15050-6-shamrocklee@posteo.net>
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

Spell "transmissions" properly.

Found by searching for keyword "tranm".

Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bf8b22218dd4..6f072095211e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2867,7 +2867,7 @@ static void tcp_process_loss(struct sock *sk, int flag, int num_dupack,
 	}
 	if (tcp_is_reno(tp)) {
 		/* A Reno DUPACK means new data in F-RTO step 2.b above are
-		 * delivered. Lower inflight to clock out (re)tranmissions.
+		 * delivered. Lower inflight to clock out (re)transmissions.
 		 */
 		if (after(tp->snd_nxt, tp->high_seq) && num_dupack)
 			tcp_add_reno_sack(sk, num_dupack, flag & FLAG_ECE);
-- 
2.38.1

