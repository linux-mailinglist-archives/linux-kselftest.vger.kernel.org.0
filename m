Return-Path: <linux-kselftest+bounces-26726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5011A37272
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 08:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFBE3AF28F
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A331531E9;
	Sun, 16 Feb 2025 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqapaPKp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81273A2D;
	Sun, 16 Feb 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739691807; cv=none; b=s9fgU8Kadvd+z8buS4FHxLcdsEK2qMzW4zqsFrv/MCatuM9FnKkwjlIxuvSreoFV2IDIrN9T/4KHHEGaIi8517jIh53sycN+KRXh9w8o3WkSZmDR+mduVcHzVAjkyjMgBSQOSgueu4WgORCYA5eTSFV9NvympSYnjxIbR2pEsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739691807; c=relaxed/simple;
	bh=vnkPTaXwS392lQHSJNXig3Myd7SyoYXVGhj9yFSZpPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5PJN8trcB7b0m4s2wR1znAyTL8LzKa9s8IaZ1pkdcQ+BLl/iI7Onet5xi35BXSPKSEKOqg5gbN88av1az+56K3PXS7PBK0AE6gZ9mnBJ27moNUTemDP1V3mNxyxDwqP2yBNg8IlqJ4+L+tr/Km82gHo7iB/RMMFREwn095vmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqapaPKp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739691806; x=1771227806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnkPTaXwS392lQHSJNXig3Myd7SyoYXVGhj9yFSZpPE=;
  b=YqapaPKp9aIdbOBFzLuShU3guSr8Ot2nPbr0Lm4DywR37DHKSPgNsVPI
   d4cXBK1SDTo0CmdCs7tR6O4lJdTDTl7+hl1J6NtUUsTHIHsll++TSbhT/
   J9QJxWCDGAk1zE8LnceNrWAEpAh2H3UhTaQtLuAfsALHJPK1oTrN6zSDr
   z7+FJmKVg5+Cmeiu94iHw+uumzvFGOUcUJIoIRLMugUHKE4w5wWtKbUMZ
   4P7CyUoxaNhVHNNHKCOOlc3z4JNk8GM1fVkTKgs3kOtl1fH2QGgvddZ6c
   vzGutuwHZeYcw81oPf3DvxXIelWbhWS8EK5JtUiJJ9se+9G/xiakqGRo+
   g==;
X-CSE-ConnectionGUID: qzht8nxdRROHWUJno6IcQQ==
X-CSE-MsgGUID: ULkl8nx2TKmnz3KTlmlEAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40515330"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40515330"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 23:43:24 -0800
X-CSE-ConnectionGUID: 0A9PH0ZaQ96qevPqUymckQ==
X-CSE-MsgGUID: f8EZMhN7SOqhqmMH0qkv3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="114027871"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.38])
  by fmviesa008.fm.intel.com with ESMTP; 15 Feb 2025 23:43:12 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Bouska Zdenek <zdenek.bouska@siemens.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	xdp-hints@xdp-project.net
Subject: [PATCH bpf-next v11 1/5] xsk: Add launch time hardware offload support to XDP Tx metadata
Date: Sun, 16 Feb 2025 15:42:58 +0800
Message-Id: <20250216074302.956937-2-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216074302.956937-1-yoong.siang.song@intel.com>
References: <20250216074302.956937-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the XDP Tx metadata framework so that user can requests launch time
hardware offload, where the Ethernet device will schedule the packet for
transmission at a pre-determined time called launch time. The value of
launch time is communicated from user space to Ethernet driver via
launch_time field of struct xsk_tx_metadata.

Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 Documentation/netlink/specs/netdev.yaml      |  4 ++
 Documentation/networking/xsk-tx-metadata.rst | 62 ++++++++++++++++++++
 include/net/xdp_sock.h                       | 10 ++++
 include/net/xdp_sock_drv.h                   |  1 +
 include/uapi/linux/if_xdp.h                  | 10 ++++
 include/uapi/linux/netdev.h                  |  3 +
 net/core/netdev-genl.c                       |  2 +
 net/xdp/xsk.c                                |  3 +
 tools/include/uapi/linux/if_xdp.h            | 10 ++++
 tools/include/uapi/linux/netdev.h            |  3 +
 10 files changed, 108 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cbb544bd6c84..901b5afb3df0 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -70,6 +70,10 @@ definitions:
         name: tx-checksum
         doc:
           L3 checksum HW offload is supported by the driver.
+      -
+        name: tx-launch-time-fifo
+        doc:
+          Launch time HW offload is supported by the driver.
   -
     name: queue-type
     type: enum
diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index e76b0cfc32f7..df53a10ccac3 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -50,6 +50,10 @@ The flags field enables the particular offload:
   checksum. ``csum_start`` specifies byte offset of where the checksumming
   should start and ``csum_offset`` specifies byte offset where the
   device should store the computed checksum.
+- ``XDP_TXMD_FLAGS_LAUNCH_TIME``: requests the device to schedule the
+  packet for transmission at a pre-determined time called launch time. The
+  value of launch time is indicated by ``launch_time`` field of
+  ``union xsk_tx_metadata``.
 
 Besides the flags above, in order to trigger the offloads, the first
 packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
@@ -65,6 +69,63 @@ In this case, when running in ``XDK_COPY`` mode, the TX checksum
 is calculated on the CPU. Do not enable this option in production because
 it will negatively affect performance.
 
+Launch Time
+===========
+
+The value of the requested launch time should be based on the device's PTP
+Hardware Clock (PHC) to ensure accuracy. AF_XDP takes a different data path
+compared to the ETF queuing discipline, which organizes packets and delays
+their transmission. Instead, AF_XDP immediately hands off the packets to
+the device driver without rearranging their order or holding them prior to
+transmission. Since the driver maintains FIFO behavior and does not perform
+packet reordering, a packet with a launch time request will block other
+packets in the same Tx Queue until it is sent. Therefore, it is recommended
+to allocate separate queue for scheduling traffic that is intended for
+future transmission.
+
+In scenarios where the launch time offload feature is disabled, the device
+driver is expected to disregard the launch time request. For correct
+interpretation and meaningful operation, the launch time should never be
+set to a value larger than the farthest programmable time in the future
+(the horizon). Different devices have different hardware limitations on the
+launch time offload feature.
+
+stmmac driver
+-------------
+
+For stmmac, TSO and launch time (TBS) features are mutually exclusive for
+each individual Tx Queue. By default, the driver configures Tx Queue 0 to
+support TSO and the rest of the Tx Queues to support TBS. The launch time
+hardware offload feature can be enabled or disabled by using the tc-etf
+command to call the driver's ndo_setup_tc() callback.
+
+The value of the launch time that is programmed in the Enhanced Normal
+Transmit Descriptors is a 32-bit value, where the most significant 8 bits
+represent the time in seconds and the remaining 24 bits represent the time
+in 256 ns increments. The programmed launch time is compared against the
+PTP time (bits[39:8]) and rolls over after 256 seconds. Therefore, the
+horizon of the launch time for dwmac4 and dwxlgmac2 is 128 seconds in the
+future.
+
+igc driver
+----------
+
+For igc, all four Tx Queues support the launch time feature. The launch
+time hardware offload feature can be enabled or disabled by using the
+tc-etf command to call the driver's ndo_setup_tc() callback. When entering
+TSN mode, the igc driver will reset the device and create a default Qbv
+schedule with a 1-second cycle time, with all Tx Queues open at all times.
+
+The value of the launch time that is programmed in the Advanced Transmit
+Context Descriptor is a relative offset to the starting time of the Qbv
+transmission window of the queue. The Frst flag of the descriptor can be
+set to schedule the packet for the next Qbv cycle. Therefore, the horizon
+of the launch time for i225 and i226 is the ending time of the next cycle
+of the Qbv transmission window of the queue. For example, when the Qbv
+cycle time is set to 1 second, the horizon of the launch time ranges
+from 1 second to 2 seconds, depending on where the Qbv cycle is currently
+running.
+
 Querying Device Capabilities
 ============================
 
@@ -74,6 +135,7 @@ Refer to ``xsk-flags`` features bitmask in
 
 - ``tx-timestamp``: device supports ``XDP_TXMD_FLAGS_TIMESTAMP``
 - ``tx-checksum``: device supports ``XDP_TXMD_FLAGS_CHECKSUM``
+- ``tx-launch-time-fifo``: device supports ``XDP_TXMD_FLAGS_LAUNCH_TIME``
 
 See ``tools/net/ynl/samples/netdev.c`` on how to query this information.
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index bfe625b55d55..a58ae7589d12 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -110,11 +110,16 @@ struct xdp_sock {
  *     indicates position where checksumming should start.
  *     csum_offset indicates position where checksum should be stored.
  *
+ * void (*tmo_request_launch_time)(u64 launch_time, void *priv)
+ *     Called when AF_XDP frame requested launch time HW offload support.
+ *     launch_time indicates the PTP time at which the device can schedule the
+ *     packet for transmission.
  */
 struct xsk_tx_metadata_ops {
 	void	(*tmo_request_timestamp)(void *priv);
 	u64	(*tmo_fill_timestamp)(void *priv);
 	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
+	void	(*tmo_request_launch_time)(u64 launch_time, void *priv);
 };
 
 #ifdef CONFIG_XDP_SOCKETS
@@ -162,6 +167,11 @@ static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
 	if (!meta)
 		return;
 
+	if (ops->tmo_request_launch_time)
+		if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+			ops->tmo_request_launch_time(meta->request.launch_time,
+						     priv);
+
 	if (ops->tmo_request_timestamp)
 		if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
 			ops->tmo_request_timestamp(priv);
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 784cd34f5bba..fe4afb251719 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -199,6 +199,7 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 #define XDP_TXMD_FLAGS_VALID ( \
 		XDP_TXMD_FLAGS_TIMESTAMP | \
 		XDP_TXMD_FLAGS_CHECKSUM | \
+		XDP_TXMD_FLAGS_LAUNCH_TIME | \
 	0)
 
 static inline bool
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 42ec5ddaab8d..42869770776e 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -127,6 +127,12 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
 
+/* Request launch time hardware offload. The device will schedule the packet for
+ * transmission at a pre-determined time called launch time. The value of
+ * launch time is communicated via launch_time field of struct xsk_tx_metadata.
+ */
+#define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -142,6 +148,10 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+
+			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
+			/* Launch time in nanosecond against the PTP HW Clock */
+			__u64 launch_time;
 		} request;
 
 		struct {
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e4be227d3ad6..aac92afa917e 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -59,10 +59,13 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch Time HW offload is supported
+ *   by the driver.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
 };
 
 enum netdev_queue_type {
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62e..7832abc5ca6e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -52,6 +52,8 @@ XDP_METADATA_KFUNC_xxx
 			xsk_features |= NETDEV_XSK_FLAGS_TX_TIMESTAMP;
 		if (netdev->xsk_tx_metadata_ops->tmo_request_checksum)
 			xsk_features |= NETDEV_XSK_FLAGS_TX_CHECKSUM;
+		if (netdev->xsk_tx_metadata_ops->tmo_request_launch_time)
+			xsk_features |= NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO;
 	}
 
 	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 89d2bef96469..41093ea63700 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -742,6 +742,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 						goto free_err;
 				}
 			}
+
+			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+				skb->skb_mstamp_ns = meta->request.launch_time;
 		}
 	}
 
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 42ec5ddaab8d..42869770776e 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -127,6 +127,12 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
 
+/* Request launch time hardware offload. The device will schedule the packet for
+ * transmission at a pre-determined time called launch time. The value of
+ * launch time is communicated via launch_time field of struct xsk_tx_metadata.
+ */
+#define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -142,6 +148,10 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+
+			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
+			/* Launch time in nanosecond against the PTP HW Clock */
+			__u64 launch_time;
 		} request;
 
 		struct {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad6..aac92afa917e 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -59,10 +59,13 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch Time HW offload is supported
+ *   by the driver.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
 };
 
 enum netdev_queue_type {
-- 
2.34.1


