Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D628810E9AF
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 12:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLBLmz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 06:42:55 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:41294 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBLmy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 06:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575286975; x=1606822975;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=G7BpDGweuBg7iwhggujxcNqO4v3M0dyigUx22oeY/T0=;
  b=R5CqJdUFhoSIm3OTI/11QFTpBg7VIH0y9YhIgzZg4t7Ow4qsVrTHRu0k
   oQMK7xaOprMxrkJr7nmMglWatLtPKjQWG7BtPGlbzoBEw8b9OkLeudmOu
   g2MShMIWf9LqQlpcRIQUuXWdpgRLcrFo5izNE/EJg56ZNVMWHuV9c+bl3
   M=;
IronPort-SDR: Iri7UEfN/9EXIriRWTUi+FRDCAUBqu+/FoEdxeKrlNp3qzDAx5R9Lr9UHwHkQ4WTduYkyxtGrI
 RDQPmvoBJMmw==
X-IronPort-AV: E=Sophos;i="5.69,268,1571702400"; 
   d="scan'208";a="12391574"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 02 Dec 2019 11:42:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id 87231A247E;
        Mon,  2 Dec 2019 11:42:41 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:42:41 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.217) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:42:37 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <shuah@kernel.org>, <keescook@chromium.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sj38.park@gmail.com>, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 1/2] kselftest/runner: Print new line in print of timeout log
Date:   Mon, 2 Dec 2019 12:42:20 +0100
Message-ID: <20191202114221.827-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.217]
X-ClientProxiedBy: EX13D16UWC003.ant.amazon.com (10.43.162.15) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

If a timeout failure occurs, kselftest kills the test process and prints
the timeout log.  If the test process has killed while printing a log
that ends with new line, the timeout log can be printed in middle of the
test process output so that it can be seems like a comment, as below:

    # test_process_log	not ok 3 selftests: timers: nsleep-lat # TIMEOUT

This commit avoids such problem by printing one more line before the
TIMEOUT failure log.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/kselftest/runner.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 84de7bc74f2c..a8d20cbb711c 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -79,6 +79,7 @@ run_one()
 		if [ $rc -eq $skip_rc ]; then	\
 			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
+			echo "#"
 			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
 		else
 			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
-- 
2.17.1

