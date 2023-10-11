Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63C67C5DD4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 21:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjJKTue (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjJKTud (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 15:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D0D94
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Oct 2023 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697053782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dBw9jQqyC4NTEUrlFCMr+yRaRJ2fHw1SppPxUk03e4k=;
        b=cLJqCcqhfphFicNXORiMvWuQB9FpDLPNC1ECYs3Q+McBEyPfmVEa1QnvNKzYWhhzXLuwlQ
        v8+ytCUocvbCrpcFzyHcG612G1pfRifOIADdcUwUQquKLHa0QrQm+02HMlWzuOw9UTrrXy
        bI0PfyYitu1eyo0+uUUqlL8kpAiuJ8g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-8nc4PH9ONs2n_JXZ4hQRYw-1; Wed, 11 Oct 2023 15:49:41 -0400
X-MC-Unique: 8nc4PH9ONs2n_JXZ4hQRYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69BEE832D33;
        Wed, 11 Oct 2023 19:49:40 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.34.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A511A1C060B5;
        Wed, 11 Oct 2023 19:49:39 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Adrian Moreno <amorenoz@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, shuah@kernel.org
Subject: [PATCH net v2 0/4] selftests: openvswitch: Minor fixes for some systems
Date:   Wed, 11 Oct 2023 15:49:35 -0400
Message-ID: <20231011194939.704565-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A number of corner cases were caught when trying to run the selftests on
older systems.  Missed skip conditions, some error cases, and outdated
python setups would all report failures but the issue would actually be
related to some other condition rather than the selftest suite.

Address these individual cases.

Aaron Conole (4):
  selftests: openvswitch: Add version check for pyroute2
  selftests: openvswitch: Catch cases where the tests are killed
  selftests: openvswitch: Skip drop testing on older kernels
  selftests: openvswitch: Fix the ct_tuple for v4

 .../selftests/net/openvswitch/openvswitch.sh  | 21 +++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    | 48 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 3 deletions(-)

-- 
2.41.0

