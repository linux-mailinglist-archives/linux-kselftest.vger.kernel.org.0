Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C74739483
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 03:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjFVB3h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 21:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFVB3f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 21:29:35 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84AF1BD8
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 18:29:33 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3A18D24002D
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 03:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687397371; bh=D4Csd5WfGqhnig4L4X+fLUt56k9ygxpxQWLQs8PeNuI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=mKMXtX4rHbJ8BeDf4HadpoLOj/M7gHT/VtkFQRJX1+PCs1gWNlDtsV4r4y+Z7fLww
         /TzWkBg/APDT22KiYMTJ2r8Q7ATdK2i89v1M72QYEU8prnFyBQe2IzhpZCrZTf2JO7
         gBDTbbSBRx75z4qRaXkjbh0vTmJG+Z453C5FojiNl3d4xBwSyvx9xiATpqSxaUDrHE
         7ElAgfla+K/MiV1LPWYJXBC0kRCcTKpwzptmBAxhXJ/HN3ayLSM/QyN8bRAhGEjABA
         PpdDayrGpIJ+huAIyvbwulvDTX+5w/eQSDfsWUzIbPxxdK64AJ3yvblMRukWR21RUp
         6BcPj8hL+LaSQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QmjTH2RS3z6tvh;
        Thu, 22 Jun 2023 03:29:23 +0200 (CEST)
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
Subject: [PATCH 0/8] Fix comment typos about "transmit"
Date:   Thu, 22 Jun 2023 01:26:21 +0000
Message-Id: <20230622012627.15050-1-shamrocklee@posteo.net>
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

Fix typos about "transmit" missing the first "s"
found by searching with keyword "tram" in the first 7
patches.

Add related patterns to "scripts/spelling.txt" in the
last patch.

Yueh-Shun Li (8):
  RDMA/rxe: fix comment typo
  i40e, xsk: fix comment typo
  zd1211rw: fix comment typo
  scsi: fix comment typo
  tcp: fix comment typo
  net/tls: fix comment typo
  selftests: mptcp: connect: fix comment typo
  scripts/spelling.txt: Add "transmit" patterns

 drivers/infiniband/sw/rxe/rxe_verbs.h              |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |  2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c       |  2 +-
 drivers/scsi/isci/scu_task_context.h               |  2 +-
 net/ipv4/tcp_input.c                               |  2 +-
 net/tls/tls_device_fallback.c                      |  2 +-
 scripts/spelling.txt                               | 11 +++++++++++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  2 +-
 8 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.38.1

