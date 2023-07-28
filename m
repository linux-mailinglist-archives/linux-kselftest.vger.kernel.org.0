Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A1766C63
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjG1MBf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 08:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbjG1MBT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 08:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9703D3C2F
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 04:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690545588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wkYExyrH0hmK6H5XLA8WFiWWTbpLMfoLOCPaCc3YX2s=;
        b=VH2ocyiB4z4LtE3e2Ge9zTZOB+haQuTg0AOH0+ZLwXmfVP2O2IEVYOcfJ4CZck4TWt283V
        8URsrrTpkyfceucgxRCCF8SxNpwCMP1ZmrgRCWLnRzMjbUIUMLh9HqAbI2XXgw0SlHoKtU
        11kfMCNXnNGvgbkRogcqN0o7kCqY3pg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-hv_Mz3zuPv-n4WqRSpntkQ-1; Fri, 28 Jul 2023 07:59:42 -0400
X-MC-Unique: hv_Mz3zuPv-n4WqRSpntkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84A781008142;
        Fri, 28 Jul 2023 11:59:41 +0000 (UTC)
Received: from RHTPC1VM0NT.redhat.com (unknown [10.22.8.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D70EE207B338;
        Fri, 28 Jul 2023 11:59:40 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Pravin B Shelar <pshelar@ovn.org>,
        Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2 net-next 0/5] selftests: openvswitch: add flow programming cases
Date:   Fri, 28 Jul 2023 07:59:35 -0400
Message-Id: <20230728115940.578658-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changes from original:

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
 .../selftests/net/openvswitch/ovs-dpctl.py    | 601 +++++++++++++++++-
 2 files changed, 800 insertions(+), 24 deletions(-)

-- 
2.40.1

