Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F5C7C5DDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjJKTvX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 15:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjJKTvW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 15:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB639C9
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Oct 2023 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697053787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iw1db1f9U7DoYdHPvbNT3gp9obI4+XkIvnwgO5EvR7c=;
        b=BBWDv44lrWVLKNZQi5h8/W3/5dJZaXXjZ7Udv3OY8RdEMKlsfVZQdMEc0rT1ziRxuWKgf8
        ZwNHJveWtirvHsHnXtoPoSVNKYkYfymAiyKD7hq8QDQ9lrje3+QwW+2n7jIe6wcQ2yZntI
        mHu8tU4tzavVQ9MEVGpGEALNskRnqYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-7XB-f4rcMai1ZDVvhylk9A-1; Wed, 11 Oct 2023 15:49:44 -0400
X-MC-Unique: 7XB-f4rcMai1ZDVvhylk9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAAD6185A79C;
        Wed, 11 Oct 2023 19:49:43 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.34.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 433551C060B5;
        Wed, 11 Oct 2023 19:49:42 +0000 (UTC)
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
Subject: [PATCH net v2 3/4] selftests: openvswitch: Skip drop testing on older kernels
Date:   Wed, 11 Oct 2023 15:49:38 -0400
Message-ID: <20231011194939.704565-4-aconole@redhat.com>
In-Reply-To: <20231011194939.704565-1-aconole@redhat.com>
References: <20231011194939.704565-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kernels that don't have support for openvswitch drop reasons also
won't have the drop counter reasons, so we should skip the test
completely.  It previously wasn't possible to build a test case
for this without polluting the datapath, so we introduce a mechanism
to clear all the flows from a datapath allowing us to test for
explicit drop actions, and then clear the flows to build the
original test case.

Fixes: 4242029164d6 ("selftests: openvswitch: add explicit drop testcase")
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
v2: Address intermingled tabs vs. spaces

 .../selftests/net/openvswitch/openvswitch.sh  | 17 ++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 34 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 2a0112be7ead5..f8499d4c87f3f 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -144,6 +144,12 @@ ovs_add_flow () {
 	return 0
 }
 
+ovs_del_flows () {
+	info "Deleting all flows from DP: sbx:$1 br:$2"
+	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py del-flows "$2"
+	return 0
+}
+
 ovs_drop_record_and_run () {
 	local sbx=$1
 	shift
@@ -200,6 +206,17 @@ test_drop_reason() {
 	ip netns exec server ip addr add 172.31.110.20/24 dev s1
 	ip netns exec server ip link set s1 up
 
+	# Check if drop reasons can be sent
+	ovs_add_flow "test_drop_reason" dropreason \
+		'in_port(1),eth(),eth_type(0x0806),arp()' 'drop(10)' 2>/dev/null
+	if [ $? == 1 ]; then
+		info "no support for drop reasons - skipping"
+		ovs_exit_sig
+		return $ksft_skip
+	fi
+
+	ovs_del_flows "test_drop_reason" dropreason
+
 	# Allow ARP
 	ovs_add_flow "test_drop_reason" dropreason \
 		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index e4c24d5edf20c..10b8f31548f84 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1906,6 +1906,32 @@ class OvsFlow(GenericNetlinkSocket):
             raise ne
         return reply
 
+    def del_flows(self, dpifindex):
+        """
+        Send a del message to the kernel that will drop all flows.
+
+        dpifindex should be a valid datapath obtained by calling
+        into the OvsDatapath lookup
+        """
+
+        flowmsg = OvsFlow.ovs_flow_msg()
+        flowmsg["cmd"] = OVS_FLOW_CMD_DEL
+        flowmsg["version"] = OVS_DATAPATH_VERSION
+        flowmsg["reserved"] = 0
+        flowmsg["dpifindex"] = dpifindex
+
+        try:
+            reply = self.nlm_request(
+                flowmsg,
+                msg_type=self.prid,
+                msg_flags=NLM_F_REQUEST | NLM_F_ACK,
+            )
+            reply = reply[0]
+        except NetlinkError as ne:
+            print(flowmsg)
+            raise ne
+        return reply
+
     def dump(self, dpifindex, flowspec=None):
         """
         Returns a list of messages containing flows.
@@ -2068,6 +2094,9 @@ def main(argv):
     addflcmd.add_argument("flow", help="Flow specification")
     addflcmd.add_argument("acts", help="Flow actions")
 
+    delfscmd = subparsers.add_parser("del-flows")
+    delfscmd.add_argument("flsbr", help="Datapath name")
+
     args = parser.parse_args()
 
     if args.verbose > 0:
@@ -2151,6 +2180,11 @@ def main(argv):
         flow = OvsFlow.ovs_flow_msg()
         flow.parse(args.flow, args.acts, rep["dpifindex"])
         ovsflow.add_flow(rep["dpifindex"], flow)
+    elif hasattr(args, "flsbr"):
+        rep = ovsdp.info(args.flsbr, 0)
+        if rep is None:
+            print("DP '%s' not found." % args.flsbr)
+        ovsflow.del_flows(rep["dpifindex"])
 
     return 0
 
-- 
2.41.0

