Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A5F633E70
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 15:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiKVOGm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 09:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiKVOGG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 09:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B0820F5E
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 06:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669125801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiZt6CO0d2Q/fNRLdOiB+spVHV87735/SJe/WQ/NZzg=;
        b=XW/UOn0+hG7VIE1Cg3AxvBMtkQzTXOl8vdr6Ouw04djBnnOTno2YUgjKCZHMrVhYGKBtMO
        Vw4fMxxTWtbSswMbHWRYGqwrIHXrCR10B2iPlLgG6NkXyV5u1OONsQ2GLOZPa4S9Kzqmtm
        lRTuhgyAKgHOZoLNc5JG5gBqmWk/vQY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-KbIRkdF1M_2eJfwfZ3i_ZA-1; Tue, 22 Nov 2022 09:03:14 -0500
X-MC-Unique: KbIRkdF1M_2eJfwfZ3i_ZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73174801585;
        Tue, 22 Nov 2022 14:03:13 +0000 (UTC)
Received: from RHTPC1VM0NT.redhat.com (unknown [10.22.16.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE54040C6EC6;
        Tue, 22 Nov 2022 14:03:11 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Pravin B Shelar <pshelar@ovn.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Graf <tgraf@suug.ch>, dev@openvswitch.org,
        Eelco Chaudron <echaudro@redhat.com>,
        Ilya Maximets <i.maximets@ovn.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC net-next 4/6] selftests: openvswitch: adjust datapath NL message
Date:   Tue, 22 Nov 2022 09:03:05 -0500
Message-Id: <20221122140307.705112-5-aconole@redhat.com>
In-Reply-To: <20221122140307.705112-1-aconole@redhat.com>
References: <20221122140307.705112-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The netlink message for creating a new datapath takes an array
of ports for the PID creation.  This shouldn't cause much issue
but correct it for future messages where we need to do decode
of datapath information that could include the per-cpu PID
map

Fixes: 25f16c873fb1 ("selftests: add openvswitch selftest suite")
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index d654fe1fe4e6..fe14da358901 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -71,7 +71,7 @@ class OvsDatapath(GenericNetlinkSocket):
         nla_map = (
             ("OVS_DP_ATTR_UNSPEC", "none"),
             ("OVS_DP_ATTR_NAME", "asciiz"),
-            ("OVS_DP_ATTR_UPCALL_PID", "uint32"),
+            ("OVS_DP_ATTR_UPCALL_PID", "array(uint32)"),
             ("OVS_DP_ATTR_STATS", "dpstats"),
             ("OVS_DP_ATTR_MEGAFLOW_STATS", "megaflowstats"),
             ("OVS_DP_ATTR_USER_FEATURES", "uint32"),
@@ -141,7 +141,7 @@ class OvsDatapath(GenericNetlinkSocket):
 
         msg["attrs"].append(["OVS_DP_ATTR_USER_FEATURES", dpfeatures])
         if not shouldUpcall:
-            msg["attrs"].append(["OVS_DP_ATTR_UPCALL_PID", 0])
+            msg["attrs"].append(["OVS_DP_ATTR_UPCALL_PID", [0]])
 
         try:
             reply = self.nlm_request(
-- 
2.34.3

