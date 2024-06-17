Return-Path: <linux-kselftest+bounces-12088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C2F90B947
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5500DB296AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C011991DD;
	Mon, 17 Jun 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYjVOHfX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4511991BA
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647356; cv=none; b=Rx7N/N+GMMZ6V4Iwvms3+49O4FW24PuLK2uxh2AqoJP03vfx27tbdJjUgR8FGdzhF0ruf4lFke6Nlk8t+Abgj7Sdn6iSWTWdELOVwa3jQsfFwSSs+pQXkynmei9IEb2hAXZwOv9Y+kO2oOyY91vSBMXatTSr9SNpf+HC70MYX00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647356; c=relaxed/simple;
	bh=u/uGR3jAn/ZszarKH22xmRSDF+SoW0xvgXaPJHTzmWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8YoM6gC00PCyDcs/9pzIpWrPocUZDfJtxX0sZsggc5mgaMYSKH0cWinKU+ERrqfKKBISo9apOrTwtcDvqn+4FMbmilptgZYoB3/D1Bd9UIziMwnt5HFU8AEugUFAwA7pGnerP90/OMXJxsSuqF6g/LE8hjHjs90zqrHPHENu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYjVOHfX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718647353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyqUKDTdoe16mTnmkgIMa81u/9MKRInVuBcoq3GBxsE=;
	b=iYjVOHfXh3T7B/xI7SHc9Np4oC8AIzWMjweplMZrflbBjbcMV6XAX7qIz8pxahdT9lXcVG
	AdOmsdLWowo1WEhUz2Cm2IcFFG8/5MYVvx+weKOJPdIE7crjsmqUhiDNjjYH2mqoRxJauP
	nP/pcVFSK6ppDMIxTwEj3swrd4ynMLM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-tpXUcal3NVWZd0sUTx6bZw-1; Mon,
 17 Jun 2024 14:02:28 -0400
X-MC-Unique: tpXUcal3NVWZd0sUTx6bZw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E507E19560AD;
	Mon, 17 Jun 2024 18:02:25 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9C291956087;
	Mon, 17 Jun 2024 18:02:22 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 1/7] selftests: openvswitch: Support explicit tunnel port creation.
Date: Mon, 17 Jun 2024 14:02:12 -0400
Message-ID: <20240617180218.1154326-2-aconole@redhat.com>
In-Reply-To: <20240617180218.1154326-1-aconole@redhat.com>
References: <20240617180218.1154326-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The OVS module can operate in conjunction with various types of
tunnel ports.  These are created as either explicit tunnel vport
types, OR by creating a tunnel interface which acts as an anchor
for the lightweight tunnel support.

This patch adds the ability to add tunnel ports to an OVS
datapath for testing various scenarios with tunnel ports.  With
this addition, the vswitch "plumbing" will at least be able to
push packets around using the tunnel vports.  Future patches
will add support for setting required tunnel metadata for lwts
in the datapath.  The end goal will be to push packets via these
tunnels, and will be used in an upcoming commit for testing the
path MTU.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 81 +++++++++++++++++--
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 1dd057afd3fb..8f92215303a3 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -10,6 +10,7 @@ import ipaddress
 import logging
 import multiprocessing
 import re
+import socket
 import struct
 import sys
 import time
@@ -29,6 +30,7 @@ try:
     from pyroute2.netlink.exceptions import NetlinkError
     from pyroute2.netlink.generic import GenericNetlinkSocket
     import pyroute2
+    import pyroute2.iproute
 
 except ModuleNotFoundError:
     print("Need to install the python pyroute2 package >= 0.6.")
@@ -1617,7 +1619,7 @@ class OvsVport(GenericNetlinkSocket):
             ("OVS_VPORT_ATTR_PORT_NO", "uint32"),
             ("OVS_VPORT_ATTR_TYPE", "uint32"),
             ("OVS_VPORT_ATTR_NAME", "asciiz"),
-            ("OVS_VPORT_ATTR_OPTIONS", "none"),
+            ("OVS_VPORT_ATTR_OPTIONS", "vportopts"),
             ("OVS_VPORT_ATTR_UPCALL_PID", "array(uint32)"),
             ("OVS_VPORT_ATTR_STATS", "vportstats"),
             ("OVS_VPORT_ATTR_PAD", "none"),
@@ -1625,6 +1627,13 @@ class OvsVport(GenericNetlinkSocket):
             ("OVS_VPORT_ATTR_NETNSID", "uint32"),
         )
 
+        class vportopts(nla):
+            nla_map = (
+                ("OVS_TUNNEL_ATTR_UNSPEC", "none"),
+                ("OVS_TUNNEL_ATTR_DST_PORT", "uint16"),
+                ("OVS_TUNNEL_ATTR_EXTENSION", "none"),
+            )
+
         class vportstats(nla):
             fields = (
                 ("rx_packets", "=Q"),
@@ -1693,7 +1702,7 @@ class OvsVport(GenericNetlinkSocket):
                 raise ne
         return reply
 
-    def attach(self, dpindex, vport_ifname, ptype):
+    def attach(self, dpindex, vport_ifname, ptype, dport, lwt):
         msg = OvsVport.ovs_vport_msg()
 
         msg["cmd"] = OVS_VPORT_CMD_NEW
@@ -1702,12 +1711,43 @@ class OvsVport(GenericNetlinkSocket):
         msg["dpifindex"] = dpindex
         port_type = OvsVport.str_to_type(ptype)
 
-        msg["attrs"].append(["OVS_VPORT_ATTR_TYPE", port_type])
         msg["attrs"].append(["OVS_VPORT_ATTR_NAME", vport_ifname])
         msg["attrs"].append(
             ["OVS_VPORT_ATTR_UPCALL_PID", [self.upcall_packet.epid]]
         )
 
+        TUNNEL_DEFAULTS = [("geneve", 6081),
+                           ("vxlan", 4789)]
+
+        for tnl in TUNNEL_DEFAULTS:
+            if ptype == tnl[0]:
+                if not dport:
+                    dport = tnl[1]
+
+                if not lwt:
+                    vportopt = OvsVport.ovs_vport_msg.vportopts()
+                    vportopt["attrs"].append(
+                        ["OVS_TUNNEL_ATTR_DST_PORT", socket.htons(dport)]
+                    )
+                    msg["attrs"].append(
+                        ["OVS_VPORT_ATTR_OPTIONS", vportopt]
+                    )
+                else:
+                    port_type = OvsVport.OVS_VPORT_TYPE_NETDEV
+                    ipr = pyroute2.iproute.IPRoute()
+
+                    if tnl[0] == "geneve":
+                        ipr.link("add", ifname=vport_ifname, kind=tnl[0],
+                                 geneve_port=dport,
+                                 geneve_collect_metadata=True,
+                                 geneve_udp_zero_csum6_rx=1)
+                    elif tnl[0] == "vxlan":
+                        ipr.link("add", ifname=vport_ifname, kind=tnl[0],
+                                 vxlan_learning=0, vxlan_collect_metadata=1,
+                                 vxlan_udp_zero_csum6_rx=1, vxlan_port=dport)
+                break
+        msg["attrs"].append(["OVS_VPORT_ATTR_TYPE", port_type])
+
         try:
             reply = self.nlm_request(
                 msg, msg_type=self.prid, msg_flags=NLM_F_REQUEST | NLM_F_ACK
@@ -2053,12 +2093,19 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
     for iface in ndb.interfaces:
         rep = vpl.info(iface.ifname, ifindex)
         if rep is not None:
+            opts = ""
+            vpo = rep.get_attr("OVS_VPORT_ATTR_OPTIONS")
+            if vpo:
+                dpo = vpo.get_attr("OVS_TUNNEL_ATTR_DST_PORT")
+                if dpo:
+                    opts += " tnl-dport:%s" % socket.ntohs(dpo)
             print(
-                "  port %d: %s (%s)"
+                "  port %d: %s (%s%s)"
                 % (
                     rep.get_attr("OVS_VPORT_ATTR_PORT_NO"),
                     rep.get_attr("OVS_VPORT_ATTR_NAME"),
                     OvsVport.type_to_str(rep.get_attr("OVS_VPORT_ATTR_TYPE")),
+                    opts,
                 )
             )
 
@@ -2120,12 +2167,30 @@ def main(argv):
         "--ptype",
         type=str,
         default="netdev",
-        choices=["netdev", "internal"],
+        choices=["netdev", "internal", "geneve", "vxlan"],
         help="Interface type (default netdev)",
     )
+    addifcmd.add_argument(
+        "-p",
+        "--dport",
+        type=int,
+        default=0,
+        help="Destination port (0 for default)"
+    )
+    addifcmd.add_argument(
+        "-l",
+        "--lwt",
+        type=bool,
+        default=True,
+        help="Use LWT infrastructure instead of vport (default true)."
+    )
     delifcmd = subparsers.add_parser("del-if")
     delifcmd.add_argument("dpname", help="Datapath Name")
     delifcmd.add_argument("delif", help="Interface name for adding")
+    delifcmd.add_argument("-d",
+                          "--dellink",
+                          type=bool, default=False,
+                          help="Delete the link as well.")
 
     dumpflcmd = subparsers.add_parser("dump-flows")
     dumpflcmd.add_argument("dumpdp", help="Datapath Name")
@@ -2186,7 +2251,8 @@ def main(argv):
             print("DP '%s' not found." % args.dpname)
             return 1
         dpindex = rep["dpifindex"]
-        rep = ovsvp.attach(rep["dpifindex"], args.addif, args.ptype)
+        rep = ovsvp.attach(rep["dpifindex"], args.addif, args.ptype,
+                           args.dport, args.lwt)
         msg = "vport '%s'" % args.addif
         if rep and rep["header"]["error"] is None:
             msg += " added."
@@ -2207,6 +2273,9 @@ def main(argv):
             msg += " removed."
         else:
             msg += " failed to remove."
+        if args.dellink:
+            ipr = pyroute2.iproute.IPRoute()
+            ipr.link("del", index=ipr.link_lookup(ifname=args.delif)[0])
     elif hasattr(args, "dumpdp"):
         rep = ovsdp.info(args.dumpdp, 0)
         if rep is None:
-- 
2.45.1


