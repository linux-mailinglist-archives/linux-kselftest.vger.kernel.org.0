Return-Path: <linux-kselftest+bounces-892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B8C7FF4B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60929B20D13
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6614C54F8E;
	Thu, 30 Nov 2023 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NS5o4hfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEEED48;
	Thu, 30 Nov 2023 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701361315; x=1732897315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=puG5I5OrZPDXCyrotNZN8b3x7i/QjnG8+glmX/QOPCU=;
  b=NS5o4hfH26hbG77hVFb4OF258Z+wwLY8f98KPA7e/WeIcAUP1//07Bsh
   rHCp+oXM35gj9TXMH9qZWbVck9325Md5UqmeBAlCprcU1Vv6YmlHzxSCF
   JhQ5QrHsrndJKUQnwj9hs5sO94gfpvKNFhvU9nzxHqPecdl7DXr5Mqv5v
   PnFYttEcj4S2Ed5sp6acZ8feG0yOJmdphUp2D2XTubg78iOWr3v+LGH84
   eU/A4LonMA8s10ZLignXxat+PPS8kkYGGAeJPuWJFiAySBKjYgA6UoFku
   yjtzgb98YhYnCGTcBPGFM4hDjApQx0m73JfVGfe2ASmhIbWl6qWqMzVtt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="383744513"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="383744513"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:21:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803758338"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="803758338"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2023 08:21:25 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	xdp-hints@xdp-project.net,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Song Yoong Siang <yoong.siang.song@intel.com>
Subject: [PATCH bpf-next 1/3] xsk: add launch time support to XDP Tx metadata
Date: Fri,  1 Dec 2023 00:20:26 +0800
Message-Id: <20231130162028.852006-2-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130162028.852006-1-yoong.siang.song@intel.com>
References: <20231130162028.852006-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch extends the XDP Tx metadata framework to include Time-Based
Scheduling (TBS) support where the NIC will schedule a packet for
transmission at a pre-determined time called launch time. The value of
launch time is communicated from user space to Ethernet driver via
launch_time field of struct xsk_tx_metadata.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 Documentation/netlink/specs/netdev.yaml      |  4 ++++
 Documentation/networking/xsk-tx-metadata.rst |  5 +++++
 include/net/xdp_sock.h                       | 10 ++++++++++
 include/net/xdp_sock_drv.h                   |  1 +
 include/uapi/linux/if_xdp.h                  |  9 +++++++++
 include/uapi/linux/netdev.h                  |  3 +++
 net/core/netdev-genl.c                       |  2 ++
 net/xdp/xsk.c                                |  3 +++
 tools/include/uapi/linux/if_xdp.h            |  9 +++++++++
 tools/include/uapi/linux/netdev.h            |  3 +++
 tools/net/ynl/generated/netdev-user.c        |  1 +
 11 files changed, 50 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 00439bcbd2e3..a602776bbfb4 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -66,6 +66,10 @@ definitions:
         name: tx-checksum
         doc:
           L3 checksum HW offload is supported by the driver.
+      -
+        name: launch-time
+        doc:
+          HW Time-Based Scheduling (TBS) is supported by the driver.
 
 attribute-sets:
   -
diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index 97ecfa480d00..e3a7486f47e2 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -44,6 +44,10 @@ The flags field enables the particular offload:
   checksum. ``csum_start`` specifies byte offset of where the checksumming
   should start and ``csum_offset`` specifies byte offset where the
   device should store the computed checksum.
+- ``XDP_TXMD_FLAGS_LAUNCH_TIME``: requests HW Time-Based Scheduling (TBS)
+  offload to launch the packet at a pre-determined time. ``launch_time``
+  indicates the time which the NIC should schedule the packet for
+  transmission.
 
 Besides the flags above, in order to trigger the offloads, the first
 packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
@@ -68,6 +72,7 @@ Refer to ``xsk-flags`` features bitmask in
 
 - ``tx-timestamp``: device supports ``XDP_TXMD_FLAGS_TIMESTAMP``
 - ``tx-checksum``: device supports ``XDP_TXMD_FLAGS_CHECKSUM``
+- ``launch-time``: device supports ``XDP_TXMD_FLAGS_LAUNCH_TIME``
 
 See ``tools/net/ynl/samples/netdev.c`` on how to query this information.
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 3cb4dc9bd70e..f3e274830816 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -110,11 +110,16 @@ struct xdp_sock {
  *     indicates position where checksumming should start.
  *     csum_offset indicates position where checksum should be stored.
  *
+ * void (*tmo_request_launch_time)(u64 launch_time, void *priv)
+ *     Called when AF_XDP frame requested HW Time-Based Scheduling (TBS) offload
+ *     support. launch_time indicates the time which the NIC should schedule the
+ *     packet for transmission.
  */
 struct xsk_tx_metadata_ops {
 	void	(*tmo_request_timestamp)(void *priv);
 	u64	(*tmo_fill_timestamp)(void *priv);
 	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
+	void	(*tmo_request_launch_time)(u64 launch_time, void *priv);
 };
 
 #ifdef CONFIG_XDP_SOCKETS
@@ -170,6 +175,11 @@ static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
 		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
 			ops->tmo_request_checksum(meta->request.csum_start,
 						  meta->request.csum_offset, priv);
+
+	if (ops->tmo_request_launch_time)
+		if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+			ops->tmo_request_launch_time(meta->request.launch_time,
+						     priv);
 }
 
 /**
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 81e02de3f453..5b88559e956b 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -168,6 +168,7 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 #define XDP_TXMD_FLAGS_VALID ( \
 		XDP_TXMD_FLAGS_TIMESTAMP | \
 		XDP_TXMD_FLAGS_CHECKSUM | \
+		XDP_TXMD_FLAGS_LAUNCH_TIME | \
 	0)
 
 static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index d31698410410..623d34e03981 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -123,6 +123,12 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
 
+/* Request HW Time-Based Scheduling (TBS) offload to launch the packet at a
+ * pre-determined time. The time which the NIC should schedule the packet for
+ * transmission is communicated via launch_time field of struct xsk_tx_metadata.
+ */
+#define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -138,6 +144,9 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+
+			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
+			__u64 launch_time;
 		} request;
 
 		struct {
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 48d5477a668c..db8b8618b29a 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -59,10 +59,13 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME: HW Time-Based Scheduling is supported by
+ *   the driver.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME = 3,
 
 	/* private: */
 	NETDEV_XSK_FLAGS_MASK = 3,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 10f2124e9e23..d001323b1d72 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -33,6 +33,8 @@ XDP_METADATA_KFUNC_xxx
 			xsk_features |= NETDEV_XSK_FLAGS_TX_TIMESTAMP;
 		if (netdev->xsk_tx_metadata_ops->tmo_request_checksum)
 			xsk_features |= NETDEV_XSK_FLAGS_TX_CHECKSUM;
+		if (netdev->xsk_tx_metadata_ops->tmo_request_launch_time)
+			xsk_features |= NETDEV_XSK_FLAGS_TX_LAUNCH_TIME;
 	}
 
 	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 281d49b4fca4..ad98ac6adb43 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -751,6 +751,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 						goto free_err;
 				}
 			}
+
+			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+				skb->skb_mstamp_ns = meta->request.launch_time;
 		}
 	}
 
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 638c606dfa74..80462125c5c3 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -123,6 +123,12 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
 
+/* Request HW Time-Based Scheduling (TBS) offload to launch the packet at a
+ * pre-determined time. The time which the NIC should schedule the packet for
+ * transmission is communicated via launch_time field of struct xsk_tx_metadata.
+ */
+#define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -138,6 +144,9 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+
+			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
+			__u64 launch_time;
 		} request;
 
 		struct {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48d5477a668c..db8b8618b29a 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -59,10 +59,13 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME: HW Time-Based Scheduling is supported by
+ *   the driver.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME = 3,
 
 	/* private: */
 	NETDEV_XSK_FLAGS_MASK = 3,
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 6283d87dad37..bb4136d64f57 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -61,6 +61,7 @@ const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value)
 static const char * const netdev_xsk_flags_strmap[] = {
 	[0] = "tx-timestamp",
 	[1] = "tx-checksum",
+	[2] = "launch-time"
 };
 
 const char *netdev_xsk_flags_str(enum netdev_xsk_flags value)
-- 
2.34.1


