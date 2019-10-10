Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE7D2CF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJJOwu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 10:52:50 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2363 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJOwu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 10:52:50 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5d9f45574a9-22438; Thu, 10 Oct 2019 22:51:03 +0800 (CST)
X-RM-TRANSID: 2eea5d9f45574a9-22438
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65d9f4555d17-54180;
        Thu, 10 Oct 2019 22:51:03 +0800 (CST)
X-RM-TRANSID: 2ee65d9f4555d17-54180
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms@verge.net.au>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH v6 0/3] selftests: netfilter: introduce test cases for ipvs
Date:   Thu, 10 Oct 2019 22:50:52 +0800
Message-Id: <1570719055-25110-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series patch include test cases for ipvs.

The test topology is who as below:
+--------------------------------------------------------------+
|                      |                                       |
|         ns0          |         ns1                           |
|      -----------     |     -----------    -----------        |
|      | veth01  | --------- | veth10  |    | veth12  |        |
|      -----------    peer   -----------    -----------        |
|           |          |                        |              |
|      -----------     |                        |              |
|      |  br0    |     |-----------------  peer |--------------|
|      -----------     |                        |              |
|           |          |                        |              |
|      ----------     peer   ----------      -----------       |
|      |  veth02 | --------- |  veth20 |     | veth12  |       |
|      ----------      |     ----------      -----------       |
|                      |         ns2                           |
|                      |                                       |
+--------------------------------------------------------------+

Test results:
# selftests: netfilter: ipvs.sh
# Testing DR mode...
# Testing NAT mode...
# Testing Tunnel mode...
# ipvs.sh: PASS
ok 6 selftests: netfilter: ipvs.sh

Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

Haishuang Yan (3):
  selftests: netfilter: add ipvs test script
  selftests: netfilter: add ipvs nat test case
  selftests: netfilter: add ipvs tunnel test case

 tools/testing/selftests/netfilter/Makefile |   2 +-
 tools/testing/selftests/netfilter/ipvs.sh  | 228 +++++++++++++++++++++++++++++
 2 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/netfilter/ipvs.sh

--
1.8.3.1



