Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7377A1A7
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 20:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjHLSKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Aug 2023 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLSKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Aug 2023 14:10:22 -0400
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D91704;
        Sat, 12 Aug 2023 11:10:23 -0700 (PDT)
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 37CI9v8r016225
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 12 Aug 2023 20:09:57 +0200
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net-next v2 0/2] seg6: add NEXT-C-SID support for SRv6 End.X behavior
Date:   Sat, 12 Aug 2023 20:09:24 +0200
Message-Id: <20230812180926.16689-1-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the Segment Routing (SR) architecture a list of instructions, called
segments, can be added to the packet headers to influence the forwarding and
processing of the packets in an SR enabled network.

Considering the Segment Routing over IPv6 data plane (SRv6) [1], the segment
identifiers (SIDs) are IPv6 addresses (128 bits) and the segment list (SID
List) is carried in the Segment Routing Header (SRH). A segment may correspond
to a "behavior" that is executed by a node when the packet is received.
The Linux kernel currently supports a large subset of the behaviors described
in [2] (e.g., End, End.X, End.T and so on).

In some SRv6 scenarios, the number of segments carried by the SID List may
increase dramatically, reducing the MTU (Maximum Transfer Unit) size and/or
limiting the processing power of legacy hardware devices (due to longer IPv6
headers).

The NEXT-C-SID mechanism [3] extends the SRv6 architecture by providing several
ways to efficiently represent the SID List.
By leveraging the NEXT-C-SID, it is possible to encode several SRv6 segments
within a single 128 bit SID address (also referenced as Compressed SID
Container). In this way, the length of the SID List can be drastically reduced.

The NEXT-C-SID mechanism is built upon the "flavors" framework defined in [2].
This framework is already supported by the Linux SRv6 subsystem and is used to
modify and/or extend a subset of existing behaviors.

In this patchset, we extend the SRv6 End.X behavior in order to support the
NEXT-C-SID mechanism.

In details, the patchset is made of:
 - patch 1/2: add NEXT-C-SID support for SRv6 End.X behavior;
 - patch 2/2: add selftest for NEXT-C-SID in SRv6 End.X behavior.


From the user space perspective, we do not need to change the iproute2 code to
support the NEXT-C-SID flavor for the SRv6 End.X behavior. However, we will
update the man page considering the NEXT-C-SID flavor applied to the SRv6 End.X
behavior in a separate patch.

Comments, improvements and suggestions are always appreciated.

Thank you all,
Andrea

[1] - https://datatracker.ietf.org/doc/html/rfc8754
[2] - https://datatracker.ietf.org/doc/html/rfc8986
[3] - https://datatracker.ietf.org/doc/html/draft-ietf-spring-srv6-srh-compression

v1 -> v2:
 - Fix author tags in the commit message in patch 2/2, thanks to Paolo Abeni;

 - Remove unnecessary supp_ops == 0 check in patch 1/2, thanks to Hangbin Liu;

 - Fix 'is it possible' -> 'it is possible' in cover letter, thanks to
   Hangbin Liu.

Andrea Mayer (1):
  seg6: add NEXT-C-SID support for SRv6 End.X behavior

Paolo Lungaroni (1):
  selftests: seg6: add selftest for NEXT-C-SID flavor in SRv6 End.X
    behavior

 net/ipv6/seg6_local.c                         |  108 +-
 tools/testing/selftests/net/Makefile          |    1 +
 .../net/srv6_end_x_next_csid_l3vpn_test.sh    | 1213 +++++++++++++++++
 3 files changed, 1302 insertions(+), 20 deletions(-)
 create mode 100755 tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh

-- 
2.20.1

