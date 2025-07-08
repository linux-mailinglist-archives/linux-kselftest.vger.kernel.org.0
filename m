Return-Path: <linux-kselftest+bounces-36776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E03AFDA85
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E8F5865AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406F12561C5;
	Tue,  8 Jul 2025 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvcSb6HP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E6255F27;
	Tue,  8 Jul 2025 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012412; cv=none; b=aIWNmk0LrzcJ195t0tuUzC9QCWH5sq+WX5fDCCcCFKN9uVRHCgajTF10RYeCILi4KbQxx+Rr/aXYHRlS+Ppt1tlZ4C9DxzgWNHl82In0A1c1VPallTnr0yHmpM+o4QmHOjzkpOCLUjVP3sV2Z5UOUP46vanlY5gA3y6k/MPVirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012412; c=relaxed/simple;
	bh=Jsnil6tnEoFmmKu9qUsQHPVW9nzazhF5EwOtcXCTVps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT6shhSt+GAHq0anEcS06dhvQawos+j6UOng7Vvi4PMmhKxQpzFwqQ2FWIlaS+7J1aq8S3b6F2ru9ounkgMnr2ZknuQ/guVuX3EO9f6zUQTTTt4SCeR8Exn6t2Lqme6pgnp2YgzsCK1ePHIZDeZhS1K4q6wI0F82FD9Ge2yTnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvcSb6HP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EC9C4CEED;
	Tue,  8 Jul 2025 22:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752012411;
	bh=Jsnil6tnEoFmmKu9qUsQHPVW9nzazhF5EwOtcXCTVps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dvcSb6HPVz0ph4GgARS71rdH96FkVUs+s8SdyxQf6rtzLBNRDFKokpOY3jgwZplkQ
	 /DDP/BRaPZmxNQjXceD13wyv9nAKbjz5pJKaNxJcrQ5KRRAxTmmAt3b13o01uzYqTm
	 OUnVRjt2ZzMxprXeZxuCnZdutnmxUVYp4pkyOPXzanD2/MzVZI2FUgRjnsCrunu4uw
	 7Q+OUb2LhjGpk3H5TtU8s6Yur0ecp28G4lX9wfMuSPwtOEA87urNSfYHbJDjpnVzqE
	 p97NELshrRsDBCrX111Xu/Gvy1rXu0D7EeKDja/Omjp/UMWoV7OKBQybL2bDDJqJkW
	 Dueltm661cuAQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	maxime.chevallier@bootlin.com,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] ethtool: rss: report which fields are configured for hashing
Date: Tue,  8 Jul 2025 15:06:39 -0700
Message-ID: <20250708220640.2738464-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708220640.2738464-1-kuba@kernel.org>
References: <20250708220640.2738464-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ETHTOOL_GRXFH over Netlink. The number of flow types is
reasonable (around 20) so report all of them at once for simplicity.

Do not maintain the flow ID mapping with ioctl at the uAPI level.
This gives us a chance to clean up the confusion that come from
RxNFC vs RxFH (flow direction vs hashing) in the ioctl.
Try to align with the names used in ethtool CLI, they seem to have
stood the test of time just fine. One annoyance is that we still
call L4 ports the weird names, but I guess they also apply to IPSec
(where they cover the SPI) so it is what it is.

 $ ynl --family ethtool --dump rss-get
 {
    "header": {
	"dev-index": 1,
	"dev-name": "enp1s0"
    },
    "hfunc": 1,
    "hkey": b"...",
    "indir": [0, 1, ...],
    "flow-hash": {
        "ether": {"l2da"},
	"ah-esp4": {"ip-src", "ip-dst"},
        "ah-esp6": {"ip-src", "ip-dst"},
        "ah4": {"ip-src", "ip-dst"},
        "ah6": {"ip-src", "ip-dst"},
        "esp4": {"ip-src", "ip-dst"},
        "esp6": {"ip-src", "ip-dst"},
        "ip4": {"ip-src", "ip-dst"},
        "ip6": {"ip-src", "ip-dst"},
        "sctp4": {"ip-src", "ip-dst"},
        "sctp6": {"ip-src", "ip-dst"},
        "udp4": {"ip-src", "ip-dst"},
        "udp6": {"ip-src", "ip-dst"}
        "tcp4": {"l4-b-0-1", "l4-b-2-3", "ip-src", "ip-dst"},
        "tcp6": {"l4-b-0-1", "l4-b-2-3", "ip-src", "ip-dst"},
    },
 }

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml      | 151 ++++++++++++++++++
 Documentation/networking/ethtool-netlink.rst  |   9 +-
 .../uapi/linux/ethtool_netlink_generated.h    |  34 ++++
 net/ethtool/ioctl.c                           |   6 +-
 net/ethtool/rss.c                             | 105 ++++++++++--
 5 files changed, 291 insertions(+), 14 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 49e782a33eb6..c38c03c624f0 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -158,6 +158,35 @@ c-version-name: ethtool-genl-version
       -
         name: pse-event-sw-pw-control-error
         doc: PSE faced an error managing the power control from software
+  -
+    name: rxfh-fields
+    name-prefix: rxh-
+    enum-name:
+    header: linux/ethtool.h
+    type: flags
+    entries:
+      -
+        name: l2da
+        value: 1
+      -
+        name: vlan
+      -
+        name: l3-proto
+      -
+        name: ip-src
+      -
+        name: ip-dst
+      -
+        name: l4-b-0-1
+        doc: src port in case of TCP/UDP/SCTP
+      -
+        name: l4-b-2-3
+        doc: dst port in case of TCP/UDP/SCTP
+      -
+        name: gtp-teid
+      -
+        name: discard
+        value: 31
 
 attribute-sets:
   -
@@ -1447,6 +1476,123 @@ c-version-name: ethtool-genl-version
         name: pse-prio
         type: u32
         name-prefix: ethtool-a-
+  -
+    name: flow
+    attr-cnt-name: --ethtool-a-flow-cnt
+    doc: |
+      Flow types, corresponding to those defined in the old
+      ethtool header for RXFH and RXNFC as ${PROTO}_FLOW.
+      The values are not matching the old ones to avoid carrying
+      into Netlink the IP_USER_FLOW vs IPV4_FLOW vs IPV4_USER_FLOW confusion.
+    attributes:
+      -
+        name: ether
+        type: uint
+        enum: rxfh-fields
+      -
+        name: ip4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: ip6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: tcp4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: tcp6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: udp4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: udp6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: sctp4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: sctp6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: ah4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: ah6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: esp4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: esp6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: ah-esp4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: ah-esp6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpu4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpu6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpc4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpc6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpc-teid4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpc-teid6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpu-eh4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpu-eh6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpu-ul4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpu-ul6
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpu-dl4
+        type: uint
+        enum: rxfh-fields
+      -
+        name: gtpu-dl6
+        type: uint
+        enum: rxfh-fields
   -
     name: rss
     attr-cnt-name: __ethtool-a-rss-cnt
@@ -1478,6 +1624,10 @@ c-version-name: ethtool-genl-version
       -
         name: start-context
         type: u32
+      -
+        name: flow-hash
+        type: nest
+        nested-attributes: flow
   -
     name: plca
     attr-cnt-name: __ethtool-a-plca-cnt
@@ -2307,6 +2457,7 @@ c-version-name: ethtool-genl-version
             - indir
             - hkey
             - input-xfrm
+            - flow-hash
       dump:
         request:
           attributes:
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 07e9808ebd2c..248bc3d93da9 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1969,14 +1969,15 @@ used to ignore context 0s and only dump additional contexts).
 
 Kernel response contents:
 
-=====================================  ======  ==========================
+=====================================  ======  ===============================
   ``ETHTOOL_A_RSS_HEADER``             nested  reply header
   ``ETHTOOL_A_RSS_CONTEXT``            u32     context number
   ``ETHTOOL_A_RSS_HFUNC``              u32     RSS hash func
   ``ETHTOOL_A_RSS_INDIR``              binary  Indir table bytes
   ``ETHTOOL_A_RSS_HKEY``               binary  Hash key bytes
   ``ETHTOOL_A_RSS_INPUT_XFRM``         u32     RSS input data transformation
-=====================================  ======  ==========================
+  ``ETHTOOL_A_RSS_FLOW_HASH``          nested  Header fields included in hash
+=====================================  ======  ===============================
 
 ETHTOOL_A_RSS_HFUNC attribute is bitmap indicating the hash function
 being used. Current supported options are toeplitz, xor or crc32.
@@ -1985,6 +1986,8 @@ indicates queue number.
 ETHTOOL_A_RSS_INPUT_XFRM attribute is a bitmap indicating the type of
 transformation applied to the input protocol fields before given to the RSS
 hfunc. Current supported options are symmetric-xor and symmetric-or-xor.
+ETHTOOL_A_RSS_FLOW_HASH carries per-flow type bitmask of which header
+fields are included in the hash calculation.
 
 PLCA_GET_CFG
 ============
@@ -2436,7 +2439,7 @@ are netlink only.
   ``ETHTOOL_SFLAGS``                  ``ETHTOOL_MSG_FEATURES_SET``
   ``ETHTOOL_GPFLAGS``                 ``ETHTOOL_MSG_PRIVFLAGS_GET``
   ``ETHTOOL_SPFLAGS``                 ``ETHTOOL_MSG_PRIVFLAGS_SET``
-  ``ETHTOOL_GRXFH``                   n/a
+  ``ETHTOOL_GRXFH``                   ``ETHTOOL_MSG_RSS_GET``
   ``ETHTOOL_SRXFH``                   n/a
   ``ETHTOOL_GGRO``                    ``ETHTOOL_MSG_FEATURES_GET``
   ``ETHTOOL_SGRO``                    ``ETHTOOL_MSG_FEATURES_SET``
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 8f30ffa1cd14..96027e26ffba 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -678,6 +678,39 @@ enum {
 	ETHTOOL_A_PSE_MAX = (__ETHTOOL_A_PSE_CNT - 1)
 };
 
+enum {
+	ETHTOOL_A_FLOW_ETHER = 1,
+	ETHTOOL_A_FLOW_IP4,
+	ETHTOOL_A_FLOW_IP6,
+	ETHTOOL_A_FLOW_TCP4,
+	ETHTOOL_A_FLOW_TCP6,
+	ETHTOOL_A_FLOW_UDP4,
+	ETHTOOL_A_FLOW_UDP6,
+	ETHTOOL_A_FLOW_SCTP4,
+	ETHTOOL_A_FLOW_SCTP6,
+	ETHTOOL_A_FLOW_AH4,
+	ETHTOOL_A_FLOW_AH6,
+	ETHTOOL_A_FLOW_ESP4,
+	ETHTOOL_A_FLOW_ESP6,
+	ETHTOOL_A_FLOW_AH_ESP4,
+	ETHTOOL_A_FLOW_AH_ESP6,
+	ETHTOOL_A_FLOW_GTPU4,
+	ETHTOOL_A_FLOW_GTPU6,
+	ETHTOOL_A_FLOW_GTPC4,
+	ETHTOOL_A_FLOW_GTPC6,
+	ETHTOOL_A_FLOW_GTPC_TEID4,
+	ETHTOOL_A_FLOW_GTPC_TEID6,
+	ETHTOOL_A_FLOW_GTPU_EH4,
+	ETHTOOL_A_FLOW_GTPU_EH6,
+	ETHTOOL_A_FLOW_GTPU_UL4,
+	ETHTOOL_A_FLOW_GTPU_UL6,
+	ETHTOOL_A_FLOW_GTPU_DL4,
+	ETHTOOL_A_FLOW_GTPU_DL6,
+
+	__ETHTOOL_A_FLOW_CNT,
+	ETHTOOL_A_FLOW_MAX = (__ETHTOOL_A_FLOW_CNT - 1)
+};
+
 enum {
 	ETHTOOL_A_RSS_UNSPEC,
 	ETHTOOL_A_RSS_HEADER,
@@ -687,6 +720,7 @@ enum {
 	ETHTOOL_A_RSS_HKEY,
 	ETHTOOL_A_RSS_INPUT_XFRM,
 	ETHTOOL_A_RSS_START_CONTEXT,
+	ETHTOOL_A_RSS_FLOW_HASH,
 
 	__ETHTOOL_A_RSS_CNT,
 	ETHTOOL_A_RSS_MAX = (__ETHTOOL_A_RSS_CNT - 1)
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 67f6d900a4ee..cccb4694f5e1 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1101,7 +1101,11 @@ ethtool_set_rxfh_fields(struct net_device *dev, u32 cmd, void __user *useraddr)
 	rc = ops->set_rxfh_fields(dev, &fields, NULL);
 exit_unlock:
 	mutex_unlock(&dev->ethtool->rss_lock);
-	return rc;
+	if (rc)
+		return rc;
+
+	ethtool_rss_notify(dev, fields.rss_context);
+	return 0;
 }
 
 static noinline_for_stack int
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 37a7b20fcd07..41ab9fc67652 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -12,6 +12,7 @@ struct rss_req_info {
 
 struct rss_reply_data {
 	struct ethnl_reply_data		base;
+	bool				has_flow_hash;
 	bool				no_key_fields;
 	u32				indir_size;
 	u32				hkey_size;
@@ -19,6 +20,37 @@ struct rss_reply_data {
 	u32				input_xfrm;
 	u32				*indir_table;
 	u8				*hkey;
+	int				flow_hash[__ETHTOOL_A_FLOW_CNT];
+};
+
+static const u8 ethtool_rxfh_ft_nl2ioctl[] = {
+	[ETHTOOL_A_FLOW_ETHER]		= ETHER_FLOW,
+	[ETHTOOL_A_FLOW_IP4]		= IPV4_FLOW,
+	[ETHTOOL_A_FLOW_IP6]		= IPV6_FLOW,
+	[ETHTOOL_A_FLOW_TCP4]		= TCP_V4_FLOW,
+	[ETHTOOL_A_FLOW_UDP4]		= UDP_V4_FLOW,
+	[ETHTOOL_A_FLOW_SCTP4]		= SCTP_V4_FLOW,
+	[ETHTOOL_A_FLOW_AH_ESP4]	= AH_ESP_V4_FLOW,
+	[ETHTOOL_A_FLOW_TCP6]		= TCP_V6_FLOW,
+	[ETHTOOL_A_FLOW_UDP6]		= UDP_V6_FLOW,
+	[ETHTOOL_A_FLOW_SCTP6]		= SCTP_V6_FLOW,
+	[ETHTOOL_A_FLOW_AH_ESP6]	= AH_ESP_V6_FLOW,
+	[ETHTOOL_A_FLOW_AH4]		= AH_V4_FLOW,
+	[ETHTOOL_A_FLOW_ESP4]		= ESP_V4_FLOW,
+	[ETHTOOL_A_FLOW_AH6]		= AH_V6_FLOW,
+	[ETHTOOL_A_FLOW_ESP6]		= ESP_V6_FLOW,
+	[ETHTOOL_A_FLOW_GTPU4]		= GTPU_V4_FLOW,
+	[ETHTOOL_A_FLOW_GTPU6]		= GTPU_V6_FLOW,
+	[ETHTOOL_A_FLOW_GTPC4]		= GTPC_V4_FLOW,
+	[ETHTOOL_A_FLOW_GTPC6]		= GTPC_V6_FLOW,
+	[ETHTOOL_A_FLOW_GTPC_TEID4]	= GTPC_TEID_V4_FLOW,
+	[ETHTOOL_A_FLOW_GTPC_TEID6]	= GTPC_TEID_V6_FLOW,
+	[ETHTOOL_A_FLOW_GTPU_EH4]	= GTPU_EH_V4_FLOW,
+	[ETHTOOL_A_FLOW_GTPU_EH6]	= GTPU_EH_V6_FLOW,
+	[ETHTOOL_A_FLOW_GTPU_UL4]	= GTPU_UL_V4_FLOW,
+	[ETHTOOL_A_FLOW_GTPU_UL6]	= GTPU_UL_V6_FLOW,
+	[ETHTOOL_A_FLOW_GTPU_DL4]	= GTPU_DL_V4_FLOW,
+	[ETHTOOL_A_FLOW_GTPU_DL6]	= GTPU_DL_V6_FLOW,
 };
 
 #define RSS_REQINFO(__req_base) \
@@ -49,6 +81,37 @@ rss_parse_request(struct ethnl_req_info *req_info, struct nlattr **tb,
 	return 0;
 }
 
+static void
+rss_prepare_flow_hash(const struct rss_req_info *req, struct net_device *dev,
+		      struct rss_reply_data *data, const struct genl_info *info)
+{
+	int i;
+
+	data->has_flow_hash = false;
+
+	if (!dev->ethtool_ops->get_rxfh_fields)
+		return;
+	if (req->rss_context && !dev->ethtool_ops->rxfh_per_ctx_fields)
+		return;
+
+	mutex_lock(&dev->ethtool->rss_lock);
+	for (i = 1; i < __ETHTOOL_A_FLOW_CNT; i++) {
+		struct ethtool_rxfh_fields fields = {
+			.flow_type	= ethtool_rxfh_ft_nl2ioctl[i],
+			.rss_context	= req->rss_context,
+		};
+
+		if (dev->ethtool_ops->get_rxfh_fields(dev, &fields)) {
+			data->flow_hash[i] = -1; /* Unsupported */
+			continue;
+		}
+
+		data->flow_hash[i] = fields.data;
+		data->has_flow_hash = true;
+	}
+	mutex_unlock(&dev->ethtool->rss_lock);
+}
+
 static int
 rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 		struct rss_reply_data *data, const struct genl_info *info)
@@ -153,6 +216,8 @@ static int
 rss_prepare(const struct rss_req_info *request, struct net_device *dev,
 	    struct rss_reply_data *data, const struct genl_info *info)
 {
+	rss_prepare_flow_hash(request, dev, data, info);
+
 	if (request->rss_context)
 		return rss_prepare_ctx(request, dev, data, info);
 	return rss_prepare_get(request, dev, data, info);
@@ -190,7 +255,10 @@ rss_reply_size(const struct ethnl_req_info *req_base,
 	      nla_total_size(sizeof(u32)) +	/* _RSS_HFUNC */
 	      nla_total_size(sizeof(u32)) +	/* _RSS_INPUT_XFRM */
 	      nla_total_size(sizeof(u32) * data->indir_size) + /* _RSS_INDIR */
-	      nla_total_size(data->hkey_size);	/* _RSS_HKEY */
+	      nla_total_size(data->hkey_size) + /* _RSS_HKEY */
+	      nla_total_size(0) +		/* _RSS_FLOW_HASH */
+		nla_total_size(sizeof(u32)) * ETHTOOL_A_FLOW_MAX +
+	      0;
 
 	return len;
 }
@@ -211,17 +279,34 @@ rss_fill_reply(struct sk_buff *skb, const struct ethnl_req_info *req_base,
 		     sizeof(u32) * data->indir_size, data->indir_table)))
 		return -EMSGSIZE;
 
-	if (data->no_key_fields)
-		return 0;
-
-	if ((data->hfunc &&
-	     nla_put_u32(skb, ETHTOOL_A_RSS_HFUNC, data->hfunc)) ||
-	    (data->input_xfrm &&
-	     nla_put_u32(skb, ETHTOOL_A_RSS_INPUT_XFRM, data->input_xfrm)) ||
-	    (data->hkey_size &&
-	     nla_put(skb, ETHTOOL_A_RSS_HKEY, data->hkey_size, data->hkey)))
+	if (!data->no_key_fields &&
+	    ((data->hfunc &&
+	      nla_put_u32(skb, ETHTOOL_A_RSS_HFUNC, data->hfunc)) ||
+	     (data->input_xfrm &&
+	      nla_put_u32(skb, ETHTOOL_A_RSS_INPUT_XFRM, data->input_xfrm)) ||
+	     (data->hkey_size &&
+	      nla_put(skb, ETHTOOL_A_RSS_HKEY, data->hkey_size, data->hkey))))
 		return -EMSGSIZE;
 
+	if (data->has_flow_hash) {
+		struct nlattr *nest;
+		int i;
+
+		nest = nla_nest_start(skb, ETHTOOL_A_RSS_FLOW_HASH);
+		if (!nest)
+			return -EMSGSIZE;
+
+		for (i = 1; i < __ETHTOOL_A_FLOW_CNT; i++) {
+			if (data->flow_hash[i] >= 0 &&
+			    nla_put_uint(skb, i, data->flow_hash[i])) {
+				nla_nest_cancel(skb, nest);
+				return -EMSGSIZE;
+			}
+		}
+
+		nla_nest_end(skb, nest);
+	}
+
 	return 0;
 }
 
-- 
2.50.0


