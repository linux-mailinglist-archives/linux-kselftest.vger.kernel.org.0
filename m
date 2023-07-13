Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5164A75236A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjGMNVM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjGMNUp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:20:45 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E445F272A
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 06:20:35 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-d28lCVOnM46F5xmYMZv0lA-1; Thu, 13 Jul 2023 09:20:29 -0400
X-MC-Unique: d28lCVOnM46F5xmYMZv0lA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 391B0185A792;
        Thu, 13 Jul 2023 13:20:29 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 402D02166B27;
        Thu, 13 Jul 2023 13:20:28 +0000 (UTC)
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     netdev@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>, kuba@kernel.org,
        simon.horman@corigine.com, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 0/2] add MACsec offload selftests
Date:   Thu, 13 Jul 2023 15:20:22 +0200
Message-Id: <cover.1689173906.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Patch 1 adds MACsec offload to netdevsim (unchanged from v2).

Patch 2 adds a corresponding selftest to the rtnetlink testsuite.

Sabrina Dubroca (2):
  netdevsim: add dummy macsec offload
  selftests: rtnetlink: add MACsec offload tests

 drivers/net/netdevsim/Makefile           |   4 +
 drivers/net/netdevsim/macsec.c           | 356 +++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c           |   3 +
 drivers/net/netdevsim/netdevsim.h        |  34 +++
 tools/testing/selftests/net/rtnetlink.sh |  83 ++++++
 5 files changed, 480 insertions(+)
 create mode 100644 drivers/net/netdevsim/macsec.c

-- 
2.40.1

