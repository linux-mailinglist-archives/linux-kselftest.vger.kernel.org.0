Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A2D71F46F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 23:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFAVL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFAVL0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 17:11:26 -0400
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD0C128;
        Thu,  1 Jun 2023 14:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685653886; x=1717189886;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SKdW2ZJfQ+aG3pXjE/jkFIRToVo6FwJhYDU5tpufyjQ=;
  b=j8pmfErYxMI3ezgTJc4a8obvuD4Y17XD6kJC1y8UrdsiYC4aF1S13X8q
   ME/pFWMXy3qYRh/VSOY+Frbx+QxL44q6QEaGNaxZb1oRaWvABGa8mW+p0
   wpyXqDS9lolmbevrRZL3U1+WVUE3sGAKsjdEROdcuPSZUR1VxVBDxZfK+
   U=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="135395904"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 21:11:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id C308B806A7;
        Thu,  1 Jun 2023 21:11:22 +0000 (UTC)
Received: from EX19D002UWC003.ant.amazon.com (10.13.138.183) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 21:11:22 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D002UWC003.ant.amazon.com (10.13.138.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 21:11:22 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 21:11:22 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id 314A2E6E; Thu,  1 Jun 2023 21:11:22 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <shuah@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rishabh Bhatnagar" <risbhat@amazon.com>
Subject: [PATCH] kselftests: Sort the collections list to avoid duplicate tests
Date:   Thu, 1 Jun 2023 21:11:12 +0000
Message-ID: <20230601211112.12724-1-risbhat@amazon.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If the collections list is not sorted uniq doesn't weed out duplicate
tests correctly. Make sure to sort it before running uniq.

Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
---
 tools/testing/selftests/run_kselftest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 97165a83df63..e0cb10c85169 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -85,7 +85,7 @@ if [ -n "$TESTS" ]; then
 	available="$(echo "$valid" | sed -e 's/ /\n/g')"
 fi
 
-collections=$(echo "$available" | cut -d: -f1 | uniq)
+collections=$(echo "$available" | cut -d: -f1 | sort | uniq)
 for collection in $collections ; do
 	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
 	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
-- 
2.39.2

