Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85107BBB77
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 17:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjJFPN7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjJFPNu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 11:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A71BA6
        for <linux-kselftest@vger.kernel.org>; Fri,  6 Oct 2023 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696605185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IoOSdAcWEnoM23if8NwRWqcJLrYCXde/SbXH5MuvOk=;
        b=AUQmzpqNfS8uBau4L9akyTe7LdBZvP5dfTm06+ZtJbPjVTCP+19v7ntaUmXrbzrfdfAtm4
        PBhjjg0Nww5NLi2tc5pGNr0JNJUmFq/vCLNhTISclhY31+7uQtvRq6dQXQcAqBVyzjI4OP
        AtSFR8zr1kWeC1nBvpUqQhrpunVLj94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-83qTOefDP0Ww2bJv63tvwg-1; Fri, 06 Oct 2023 11:13:02 -0400
X-MC-Unique: 83qTOefDP0Ww2bJv63tvwg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56724801E91;
        Fri,  6 Oct 2023 15:13:01 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBC3640D1BE;
        Fri,  6 Oct 2023 15:13:00 +0000 (UTC)
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
Subject: [PATCH net 3/4] selftests: openvswitch: Skip drop testing on older kernels
Date:   Fri,  6 Oct 2023 11:12:57 -0400
Message-Id: <20231006151258.983906-4-aconole@redhat.com>
In-Reply-To: <20231006151258.983906-1-aconole@redhat.com>
References: <20231006151258.983906-1-aconole@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 .../selftests/net/openvswitch/openvswitch.sh  | 17 ++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 34 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 2a0112be7ead5..ca7090e71bff2 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -144,6 +144,12 @@ ovs_add_flow () {
 	return 0
 }
 
+ovs_del_flows () {
+	info "Deleting all flows from DP: sbx:$1 br:$2"
+	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py del-flows "$2"
+        return 0
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
index 9686ca30d516d..153042c1e8c13 100644
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
2.40.1

