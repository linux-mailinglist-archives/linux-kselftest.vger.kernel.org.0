Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA07BBB7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjJFPOS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjJFPOP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 11:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D35CE9
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Oct 2023 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696605190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBBTecis4bs5YluD0BKJX2HGCbDC8Ki7O67H1hXsk1U=;
        b=AVSkpYhZYHFl70XdrUID0/m3sLYBxOd08yyJKT7W6hjw2y1yfUd7bn/IS/yx1JWHbyb6go
        NrgsJqnay2Sl08e2isoM1bnnuIxP1CEZ7dAhMiPhl9UDtH68vU7sV5es3wRpFucMf3DyPL
        bFlKB1G7NlQbh3qFfOzjgUE7ZBKPYgA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-J__u-p-BPL6NobSryWhYgw-1; Fri, 06 Oct 2023 11:13:02 -0400
X-MC-Unique: J__u-p-BPL6NobSryWhYgw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2FF23C1E9D3;
        Fri,  6 Oct 2023 15:13:01 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65D6A40D1EA;
        Fri,  6 Oct 2023 15:13:01 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Adrian Moreno <amorenoz@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>
Subject: [PATCH net 4/4] selftests: openvswitch: Fix the ct_tuple for v4
Date:   Fri,  6 Oct 2023 11:12:58 -0400
Message-Id: <20231006151258.983906-5-aconole@redhat.com>
In-Reply-To: <20231006151258.983906-1-aconole@redhat.com>
References: <20231006151258.983906-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Caught during code review.

Fixes: e52b07aa1a54 ("selftests: openvswitch: add flow dump support")
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 153042c1e8c13..ed7bef7ca6883 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1119,12 +1119,14 @@ class ovskey(nla):
                 "src",
                 lambda x: str(ipaddress.IPv4Address(x)),
                 int,
+                convert_ipv4,
             ),
             (
                 "dst",
                 "dst",
-                lambda x: str(ipaddress.IPv6Address(x)),
+                lambda x: str(ipaddress.IPv4Address(x)),
                 int,
+                convert_ipv4,
             ),
             ("tp_src", "tp_src", "%d", int),
             ("tp_dst", "tp_dst", "%d", int),
-- 
2.40.1

