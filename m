Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A816FDBE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 May 2023 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbjEJKuT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 May 2023 06:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbjEJKuP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 May 2023 06:50:15 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3458C40E2;
        Wed, 10 May 2023 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1683715812; x=1715251812;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=D8G7zICS6PJVXNJOjDWWVFXKeW/ytHctEbQLqspKx3I=;
  b=c8i5F1wC0iJ+qlFO0mrMiW7VnBoTzUB0evUZpP9nit1q5BtwACPe5/pJ
   orYoPq30UbFXh/8ayt4+EQx2RiSQjKkqx+NRdxUnFBuQ/9ISXTtKm1Jc4
   MwVQDNzRPaW8oPiTy9ShAssofwTn5NIU6ZSMlTy9KXVlblfM7B9ojtx5Y
   g=;
X-IronPort-AV: E=Sophos;i="5.99,264,1677542400"; 
   d="scan'208";a="1857121"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 10:50:09 +0000
Received: from EX19D002EUA003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id F3D2B44256;
        Wed, 10 May 2023 10:50:07 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D002EUA003.ant.amazon.com (10.252.50.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 May 2023 10:50:06 +0000
Received: from HFA15G9466L0F.amazon.com (10.106.82.11) by
 mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 May 2023 10:50:03 +0000
From:   <amitbern@amazon.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     Amit Bernstein <amitbern@amazon.com>,
        "Matushevsky, Alexander" <matua@amazon.com>,
        Saeed Bshara <saeedb@amazon.com>,
        "Kiyanovski, Arthur" <akiyano@amazon.com>,
        "Dagan, Noam" <ndagan@amazon.com>,
        "Agroskin, Shay" <shayagr@amazon.com>,
        "Arinzon, David" <darinzon@amazon.com>,
        "Itzko, Shahar" <itzko@amazon.com>,
        "Abboud, Osama" <osamaabb@amazon.com>
Subject: [PATCH v1] testptp: fix format specifier in nsec print
Date:   Wed, 10 May 2023 13:49:58 +0300
Message-ID: <20230510104958.13437-1-amitbern@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Amit Bernstein <amitbern@amazon.com>

Fix printf to include leading zeros when the nsec component is less
than 9 digits to ensure correct time representation of "sec.nsec".

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
---
 tools/testing/selftests/ptp/testptp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 198ad5f32..cfa9562f3 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -502,11 +502,11 @@ int main(int argc, char *argv[])
 			interval = t2 - t1;
 			offset = (t2 + t1) / 2 - tp;
 
-			printf("system time: %lld.%u\n",
+			printf("system time: %lld.%09u\n",
 				(pct+2*i)->sec, (pct+2*i)->nsec);
-			printf("phc    time: %lld.%u\n",
+			printf("phc    time: %lld.%09u\n",
 				(pct+2*i+1)->sec, (pct+2*i+1)->nsec);
-			printf("system time: %lld.%u\n",
+			printf("system time: %lld.%09u\n",
 				(pct+2*i+2)->sec, (pct+2*i+2)->nsec);
 			printf("system/phc clock time offset is %" PRId64 " ns\n"
 			       "system     clock time delay  is %" PRId64 " ns\n",
-- 
2.17.1

