Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7A136093F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 14:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhDOMYe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 08:24:34 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47796 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231391AbhDOMYd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 08:24:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=mqaio@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UVefpBC_1618489448;
Received: from localhost(mailfrom:mqaio@linux.alibaba.com fp:SMTPD_---0UVefpBC_1618489448)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 20:24:09 +0800
From:   Qiao Ma <mqaio@linux.alibaba.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org
Subject: [PATCH] selftests: fix rp_filter testcase failure bug
Date:   Thu, 15 Apr 2021 20:23:34 +0800
Message-Id: <ffde0a9716e7cf89b562f9b1cdcdd9fd1081f4d0.1618489078.git.mqaio@linux.alibaba.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The rp_filter testcase is used to test whether local packets redirected
from dummy1 to lo could pass the checking of rp_filter.

In fact, the packets passed the checking, but the testing process cannot
receive any reply packets, leading to test failure. The reason is that
the device dummy1 lacks ip address, caused the incorrect routing of
reply packets.

This patch adds ip address for dummy1 device.

Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
---
 tools/testing/selftests/net/fib_tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 2b5707738609..9a843ca0b913 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -448,6 +448,7 @@ fib_rp_filter_test()
 	$IP link set dummy0 address 52:54:00:6a:c7:5e
 	$IP link add dummy1 type dummy
 	$IP link set dummy1 address 52:54:00:6a:c7:5e
+	$IP address add 198.51.101.1/24 dev dummy1
 	$IP link set dev dummy1 up
 	$NS_EXEC sysctl -qw net.ipv4.conf.all.rp_filter=1
 	$NS_EXEC sysctl -qw net.ipv4.conf.all.accept_local=1
-- 
2.18.2

