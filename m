Return-Path: <linux-kselftest+bounces-11889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E6F907AC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB467283FA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49596155A53;
	Thu, 13 Jun 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6Mt2lcX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F415533C
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302441; cv=none; b=pKGxtJQQxFAPHhU5bYIWVpX/Jksl2/KVuadz4tJ/hehxUwKrEmd4VD/2hmL1QfsJtsH+pRvI/f7pvQhNS1ghnkW7hCRYWG76Eag+rxPWoXDYLC6rjLtEjhObddCUNVHtU8qD/w910t4LQXCvEhSvLu7Tgkf2ZcNFGK/CfUQ59dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302441; c=relaxed/simple;
	bh=Da+v1rwnff7FHwRgeW/6uEVLaI9SKiKYemKkRWYaipE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT2ynP6blKGRqjIGoixzIEckha+N9m7S3kR2jLlueqQNSo9SBX/bSrYZjxBAlEIL5Itn3qgS9NsQjiSIMtUjWkkiMKr70w0HStTXxz7e90LHkU32d1ycQW20lYnYpnRT1tSiDkEFo8jO5oVNJ7vrxStwmPbASimYMB0yQ4kasG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6Mt2lcX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718302438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+C3GR+Rn+rRQ0ra4njYqCcQMgQZI0cSR2f16SuswIVo=;
	b=J6Mt2lcXk3rtI7/tYTxyIBqSkLpnYXCwlT1S+kpApT5B7eTaBpNXBR3bYyW2JQhB3vml8l
	4eNL5XolXHRkTUvaH7bhJ+Mpdk3JEVYnMjkjMS7XxfFVSs4sSjp8kE6ET5u4f3qb4oJp8m
	EagX8/0lzzu+MvEgkCRL/rKa6f2cYVE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-M5MbBABeMqeiBn-c7nxZdw-1; Thu,
 13 Jun 2024 14:13:53 -0400
X-MC-Unique: M5MbBABeMqeiBn-c7nxZdw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0183919560B3;
	Thu, 13 Jun 2024 18:13:51 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F16EF19560BF;
	Thu, 13 Jun 2024 18:13:47 +0000 (UTC)
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
	Adrian Moreno <amorenoz@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 4/7] selftests: openvswitch: Add support for tunnel() key.
Date: Thu, 13 Jun 2024 14:13:30 -0400
Message-ID: <20240613181333.984810-5-aconole@redhat.com>
In-Reply-To: <20240613181333.984810-1-aconole@redhat.com>
References: <20240613181333.984810-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This will be used when setting details about the tunnel to use as
transport.  There is a difference between the ODP format between tunnel():
the 'key' flag is not actually a flag field, so we don't support it in the
same way that the vswitchd userspace supports displaying it.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 164 +++++++++++++++++-
 1 file changed, 162 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index fee64c31d4d4..5545e5cab1d6 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -705,7 +705,7 @@ class ovskey(nla):
         ("OVS_KEY_ATTR_ARP", "ovs_key_arp"),
         ("OVS_KEY_ATTR_ND", "ovs_key_nd"),
         ("OVS_KEY_ATTR_SKB_MARK", "uint32"),
-        ("OVS_KEY_ATTR_TUNNEL", "none"),
+        ("OVS_KEY_ATTR_TUNNEL", "ovs_key_tunnel"),
         ("OVS_KEY_ATTR_SCTP", "ovs_key_sctp"),
         ("OVS_KEY_ATTR_TCP_FLAGS", "be16"),
         ("OVS_KEY_ATTR_DP_HASH", "uint32"),
@@ -1265,6 +1265,165 @@ class ovskey(nla):
                 init=init,
             )
 
+    class ovs_key_tunnel(nla):
+        nla_flags = NLA_F_NESTED
+
+        nla_map = (
+            ("OVS_TUNNEL_KEY_ATTR_ID", "be64"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV4_SRC", "ipaddr"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV4_DST", "ipaddr"),
+            ("OVS_TUNNEL_KEY_ATTR_TOS", "uint8"),
+            ("OVS_TUNNEL_KEY_ATTR_TTL", "uint8"),
+            ("OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT", "flag"),
+            ("OVS_TUNNEL_KEY_ATTR_CSUM", "flag"),
+            ("OVS_TUNNEL_KEY_ATTR_OAM", "flag"),
+            ("OVS_TUNNEL_KEY_ATTR_GENEVE_OPTS", "array(uint32)"),
+            ("OVS_TUNNEL_KEY_ATTR_TP_SRC", "be16"),
+            ("OVS_TUNNEL_KEY_ATTR_TP_DST", "be16"),
+            ("OVS_TUNNEL_KEY_ATTR_VXLAN_OPTS", "none"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV6_SRC", "ipaddr"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV6_DST", "ipaddr"),
+            ("OVS_TUNNEL_KEY_ATTR_PAD", "none"),
+            ("OVS_TUNNEL_KEY_ATTR_ERSPAN_OPTS", "none"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV4_INFO_BRIDGE", "flag"),
+        )
+
+        def parse(self, flowstr, mask=None):
+            if not flowstr.startswith("tunnel("):
+                return None, None
+
+            k = ovskey.ovs_key_tunnel()
+            if mask is not None:
+                mask = ovskey.ovs_key_tunnel()
+
+            flowstr = flowstr[len("tunnel("):]
+
+            v6_address = None
+
+            fields = [
+                ("tun_id=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_ID",
+                 0xffffffffffffffff, None, None),
+
+                ("src=", r"([0-9a-fA-F\.]+)", str,
+                 "OVS_TUNNEL_KEY_ATTR_IPV4_SRC", "255.255.255.255", "0.0.0.0",
+                 False),
+                ("dst=", r"([0-9a-fA-F\.]+)", str,
+                 "OVS_TUNNEL_KEY_ATTR_IPV4_DST", "255.255.255.255", "0.0.0.0",
+                 False),
+
+                ("ipv6_src=", r"([0-9a-fA-F:]+)", str,
+                 "OVS_TUNNEL_KEY_ATTR_IPV6_SRC",
+                 "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "::", True),
+                ("ipv6_dst=", r"([0-9a-fA-F:]+)", str,
+                 "OVS_TUNNEL_KEY_ATTR_IPV6_DST",
+                 "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "::", True),
+
+                ("tos=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TOS", 255, 0,
+                 None),
+                ("ttl=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TTL", 255, 0,
+                 None),
+
+                ("tp_src=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TP_SRC",
+                 65535, 0, None),
+                ("tp_dst=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TP_DST",
+                 65535, 0, None),
+            ]
+
+            forced_include = ["OVS_TUNNEL_KEY_ATTR_TTL"]
+
+            for prefix, regex, typ, attr_name, mask_val, default_val, v46_flag in fields:
+                flowstr, value = parse_extract_field(flowstr, prefix, regex, typ, False)
+                if not attr_name:
+                    raise Exception("Bad list value in tunnel fields")
+
+                if value is None and attr_name in forced_include:
+                    value = default_val
+                    mask_val = default_val
+
+                if value is not None:
+                    if v6_address is None and v46_flag is not None:
+                        v6_address = v46_flag
+                    if v6_address is not None and v46_flag is not None \
+                       and v46_flag != v6_address:
+                        raise ValueError("Cannot mix v6 and v4 addresses")
+                    k["attrs"].append([attr_name, value])
+                    if mask is not None:
+                        mask["attrs"].append([attr_name, mask_val])
+                else:
+                    if v6_address is not None and v46_flag is not None \
+                       and v46_flag != v6_address:
+                        continue
+                    if v6_address is None and v46_flag is not None:
+                        continue
+                    if mask is not None:
+                        mask["attrs"].append([attr_name, default_val])
+
+            if k["attrs"][0][0] != "OVS_TUNNEL_KEY_ATTR_ID":
+                raise ValueError("Needs a tunid set")
+
+            if flowstr.startswith("flags("):
+                flowstr = flowstr[len("flags("):]
+                flagspos = flowstr.find(")")
+                flags = flowstr[:flagspos]
+                flowstr = flowstr[flagspos + 1:]
+
+                flag_attrs = {
+                    "df": "OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT",
+                    "csum": "OVS_TUNNEL_KEY_ATTR_CSUM",
+                    "oam": "OVS_TUNNEL_KEY_ATTR_OAM"
+                }
+
+                for flag in flags.split("|"):
+                    if flag in flag_attrs:
+                        k["attrs"].append([flag_attrs[flag], True])
+                        if mask is not None:
+                            mask["attrs"].append([flag_attrs[flag], True])
+
+            flowstr = flowstr[strspn(flowstr, ", ") :]
+            return flowstr, k, mask
+
+        def dpstr(self, mask=None, more=False):
+            printstr = "tunnel("
+
+            flagsattrs = []
+            for k in self["attrs"]:
+                noprint = False
+                if k[0] == "OVS_TUNNEL_KEY_ATTR_ID":
+                    print_str += "tun_id=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV4_SRC":
+                    print_str += "src=%s" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV4_DST":
+                    print_str += "dst=%s" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV6_SRC":
+                    print_str += "ipv6_src=%s" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV6_DST":
+                    print_str += "ipv6_dst=%s" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_TOS":
+                    print_str += "tos=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_TTL":
+                    print_str += "ttl=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_TP_SRC":
+                    print_str += "tp_src=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_TP_DST":
+                    print_str += "tp_dst=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT":
+                    noprint = True
+                    flagsattrs.append("df")
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_CSUM":
+                    noprint = True
+                    flagsattrs.append("csum")
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_OAM":
+                    noprint = True
+                    flagsattrs.append("oam")
+
+                if not noprint:
+                    print_str += ","
+
+            if len(flagsattrs):
+                printstr += "flags(" + "|".join(flagsattrs) + ")"
+            printstr += ")"
+            return printstr
+
     class ovs_key_mpls(nla):
         fields = (("lse", ">I"),)
 
@@ -1273,6 +1432,7 @@ class ovskey(nla):
             ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
             ("OVS_KEY_ATTR_SKB_MARK", "skb_mark", intparse),
             ("OVS_KEY_ATTR_RECIRC_ID", "recirc_id", intparse),
+            ("OVS_KEY_ATTR_TUNNEL", "tunnel", ovskey.ovs_key_tunnel),
             ("OVS_KEY_ATTR_DP_HASH", "dp_hash", intparse),
             ("OVS_KEY_ATTR_CT_STATE", "ct_state", parse_ct_state),
             ("OVS_KEY_ATTR_CT_ZONE", "ct_zone", intparse),
@@ -1745,7 +1905,7 @@ class OvsVport(GenericNetlinkSocket):
         )
 
         TUNNEL_DEFAULTS = [("geneve", 6081),
-                           ("vxlan", 4798)]
+                           ("vxlan", 4789)]
 
         for tnl in TUNNEL_DEFAULTS:
             if ptype == tnl[0]:
-- 
2.45.1


