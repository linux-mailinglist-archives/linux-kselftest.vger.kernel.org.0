Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A42BF73F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfIZQ7F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 12:59:05 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:25104 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfIZQ7B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 12:59:01 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5d8cec1ae9e-2eb7a; Fri, 27 Sep 2019 00:49:33 +0800 (CST)
X-RM-TRANSID: 2eeb5d8cec1ae9e-2eb7a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5d8cec0ffd4-705b5;
        Fri, 27 Sep 2019 00:49:20 +0800 (CST)
X-RM-TRANSID: 2eea5d8cec0ffd4-705b5
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH 0/3] selftests: netfilter: introduce test cases for ipvs
Date:   Fri, 27 Sep 2019 00:48:49 +0800
Message-Id: <1569516532-708-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
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

Haishuang Yan (3):
  selftests: netfilter: add ipvs test script
  selftests: netfilter: add ipvs nat test case
  selftests: netfilter: add ipvs tunnel test case

 tools/testing/selftests/netfilter/Makefile |   2 +-
 tools/testing/selftests/netfilter/ipvs.sh  | 230 +++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/netfilter/ipvs.sh

-- 
1.8.3.1



