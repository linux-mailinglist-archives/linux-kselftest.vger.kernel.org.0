Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5C74165F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjF1Q2u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 12:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231876AbjF1Q2Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 12:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687969663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p4aTkijo2VWCdZMtA0JJ02vptyXjYA3s/Z8Gy0bvVn8=;
        b=XbYxVrMBKEIjeN2VAS9s5VpAlnOlDb24qo4SI53QDC3TyUPuMPdSe0zNvS7Pq3AyHfsitw
        VwSGTCuqdHsK+KVKcfo4epkUfFts+FZbwTLDx3/6p6gglvPPyavV3B4h5wYVE8tzD4/RSZ
        kPC/ohDJmPltJ2gV+oA88CWxmlCc36I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-X7Ch1nZpM4O91x4npQ86Bg-1; Wed, 28 Jun 2023 12:27:40 -0400
X-MC-Unique: X7Ch1nZpM4O91x4npQ86Bg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3FA63814958;
        Wed, 28 Jun 2023 16:27:15 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.32.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63A0B40BB4D;
        Wed, 28 Jun 2023 16:27:15 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dev@openvswitch.org, Pravin Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Ilya Maximets <i.maximets@ovn.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/4] selftests: openvswitch: add flow programming cases
Date:   Wed, 28 Jun 2023 12:27:10 -0400
Message-Id: <20230628162714.392047-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The openvswitch selftests currently contain a few cases for managing the
datapath, which includes creating datapath instances, adding interfaces,
and doing some basic feature / upcall tests.  This is useful to validate
the control path.

Add the ability to program some of the more common flows with actions. This
can be improved overtime to include regression testing, etc.

Aaron Conole (4):
  selftests: openvswitch: add an initial flow programming case
  selftests: openvswitch: add a test for ipv4 forwarding
  selftests: openvswitch: add basic ct test case parsing
  selftests: openvswitch: add ct-nat test case with ipv4

 .../selftests/net/openvswitch/openvswitch.sh  | 223 ++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 507 ++++++++++++++++++
 2 files changed, 730 insertions(+)

-- 
2.40.1

