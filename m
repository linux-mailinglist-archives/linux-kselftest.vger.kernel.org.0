Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF476BF26
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 23:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjHAVXR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 17:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjHAVXQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 17:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B910EA
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Aug 2023 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690924953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MzRC37yNjV65GcpWLeg5IaHGjHuuIxo3iyZAS/bTmpk=;
        b=QZLb8Rr49CcXZqQXgAeQBC/nwb9KrHBkEgVxnKyEzYVKEppG7WJEpFlSt1CWr/f/SJqTXi
        ISnSrtxvUnjP/Hi0C+OLT3L+7OBs5HBKE++RsaKkOqpx0d1QoyqswPbfHBL5IsA9zLnB4H
        JtddXs+IyxbD+QjI2WXigNy0udK3pUU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-Gam-80i0NfCuf3dA2ho7Eg-1; Tue, 01 Aug 2023 17:22:29 -0400
X-MC-Unique: Gam-80i0NfCuf3dA2ho7Eg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 499343C11A01;
        Tue,  1 Aug 2023 21:22:29 +0000 (UTC)
Received: from RHTPC1VM0NT.redhat.com (unknown [10.22.8.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59DA6F7855;
        Tue,  1 Aug 2023 21:22:27 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Pravin B Shelar <pshelar@ovn.org>,
        Adrian Moreno <amorenoz@redhat.com>,
        Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v3 net-next 0/5] selftests: openvswitch: add flow programming cases
Date:   Tue,  1 Aug 2023 17:22:21 -0400
Message-Id: <20230801212226.909249-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The openvswitch selftests currently contain a few cases for managing the
datapath, which includes creating datapath instances, adding interfaces,
and doing some basic feature / upcall tests.  This is useful to validate
the control path.

Add the ability to program some of the more common flows with actions. This
can be improved overtime to include regression testing, etc.

v2->v3:
1. Dropped support for ipv6 in nat() case
2. Fixed a spelling mistake in 2/5 commit message.

v1->v2:
1. Fix issue when parsing ipv6 in the NAT action
2. Fix issue calculating length during ctact parsing
3. Fix error message when invalid bridge is passed
4. Fold in Adrian's patch to support key masks


Aaron Conole (4):
  selftests: openvswitch: add an initial flow programming case
  selftests: openvswitch: add a test for ipv4 forwarding
  selftests: openvswitch: add basic ct test case parsing
  selftests: openvswitch: add ct-nat test case with ipv4

Adrian Moreno (1):
  selftests: openvswitch: support key masks

 .../selftests/net/openvswitch/openvswitch.sh  | 223 +++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 588 +++++++++++++++++-
 2 files changed, 787 insertions(+), 24 deletions(-)

-- 
2.40.1

