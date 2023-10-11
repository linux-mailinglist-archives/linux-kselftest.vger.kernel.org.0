Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE437C5DD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 21:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjJKTue (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjJKTud (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 15:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1AB8
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Oct 2023 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697053786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91TzyC8lAiMG2w2YCIi0bUrneGmE9j31gOJx7+kZs/U=;
        b=CSjO0Xa2oPYQECu7+7rIelXQzZ861s7Rhqx+udvoOLFBzL9bQzDKTRJudwIF0tEPz0VE0E
        q+vVIQzU8yUhLyaqwp2+Jy7fCPERwSeqoRSaPxazZGPHZP21DeFlur6COmp7rhzAD5rGkW
        yOhEOX5cQk9ci983uXOk+ieXeYA473Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-vX6TnARzM2up3P1Duj4RCQ-1; Wed, 11 Oct 2023 15:49:43 -0400
X-MC-Unique: vX6TnARzM2up3P1Duj4RCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3228A832D6D;
        Wed, 11 Oct 2023 19:49:42 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.34.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A2DC1C060B5;
        Wed, 11 Oct 2023 19:49:41 +0000 (UTC)
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
Subject: [PATCH net v2 2/4] selftests: openvswitch: Catch cases where the tests are killed
Date:   Wed, 11 Oct 2023 15:49:37 -0400
Message-ID: <20231011194939.704565-3-aconole@redhat.com>
In-Reply-To: <20231011194939.704565-1-aconole@redhat.com>
References: <20231011194939.704565-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In case of fatal signal, or early abort at least cleanup the current
test case.

Fixes: 25f16c873fb1 ("selftests: add openvswitch selftest suite")
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/openvswitch.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 220c3356901ef..2a0112be7ead5 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -3,6 +3,8 @@
 #
 # OVS kernel module self tests
 
+trap ovs_exit_sig EXIT TERM INT ERR
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-- 
2.41.0

