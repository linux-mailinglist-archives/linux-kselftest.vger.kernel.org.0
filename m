Return-Path: <linux-kselftest+bounces-12708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E52916F12
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 19:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF96285819
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18817994D;
	Tue, 25 Jun 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVgGKwir"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6F176AD9
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336179; cv=none; b=onwfklhSZtreLyetR/n3Nv/KIgAcY+Xaf5aN1gNpEcBB+GeoGgAknenBOEkQ5Yimu0OB3ZDFMMnfwWBXp0xiQdFireksLSXsRQKgc5hpdxu+OeYvyNBncyrJHFX5ACbzRrvM/bOHqxPK4gAvEZsXLY31r7u3lQGpDvlkrIwSK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336179; c=relaxed/simple;
	bh=WRe5bCifTygH4Aip67peX/SadZB3EhQztuVlv6wmwUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJKyBmd+Bv+nQN0FlgDJhtFmDGDUUn9EXEFGDw/BeuswIdK3+slKJ1EXarhIOZdJKXvhqbw+9qo21owc629xQ+FRIB6WE3jJuU0AqtnS9eb1i2h5KdIhXJSjXuIoXybnGiCgSZGuP8fC0cPxVtVhmMvaDF7/i7nY2T/jNyFdkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVgGKwir; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719336176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vR2+f57PzCGU/T22YKL2mGoBFOBIvM5D9tlMg3TO9+g=;
	b=NVgGKwirOtAdBAjovk6kl2XsLDQzPrJ+4+knipTFD2vSiQlwDmNQGWkojBSrNC1s7u0UW2
	ucRJaBCiHEOMmYSA8Ka3y7Pb5TiDiZE6pegOB1LBCKCEEM0IP+HOSWT7e8a6WwE3wq+RQ4
	+x/BXzuR28Wr1uUbdJGaKtLyUM2PxkQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-pnkXMkt4O_2SDDbKhJlLTg-1; Tue,
 25 Jun 2024 13:22:53 -0400
X-MC-Unique: pnkXMkt4O_2SDDbKhJlLTg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9518219560B7;
	Tue, 25 Jun 2024 17:22:51 +0000 (UTC)
Received: from RHTRH0061144.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31A2E1955E72;
	Tue, 25 Jun 2024 17:22:49 +0000 (UTC)
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
Subject: [PATCH net-next v3 1/7] selftests: openvswitch: Support explicit tunnel port creation.
Date: Tue, 25 Jun 2024 13:22:39 -0400
Message-ID: <20240625172245.233874-2-aconole@redhat.com>
In-Reply-To: <20240625172245.233874-1-aconole@redhat.com>
References: <20240625172245.233874-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index 9f8dec2f6539..02e44c6f0503 100644
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


