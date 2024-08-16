Return-Path: <linux-kselftest+bounces-15553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D2955062
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17EC1F21D71
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AED1C7B66;
	Fri, 16 Aug 2024 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW7ZmdZ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DFC1C68BC;
	Fri, 16 Aug 2024 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830977; cv=none; b=f7cqhT/EPO/O8X+unFi+MUS3eR9wfZzLGqnAJIu+jWRk34d9JTvbV7zUIB0Pl3rVTwefI4AmrlUzqiecJuFLOntplstSM0DsCJ5SktOxUS/FipV08twM/FnW16i5ZQp1/1L2xdlEVs6Verh5RV+ZmJpL2oW8+fmsxcEKJQac2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830977; c=relaxed/simple;
	bh=1nTnm/+BPLU9cVwWoXDMCuedVYe8mzXtHdP/ivu98UA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jl7sBSW3FEtdquinvqXY6MqGZsU4i3D4omv52TYkX5jf19mn1BI/f4hsqoti+/coryCxPLNRoypoW9dPgtpuqXh0elWCVftieTBoJyzFqDKtQsQ4YrU7GxANVj54zJHNix1ssIld/RdD+/VwE4Hbj8ueAEnbyW9KXenhCnbiCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW7ZmdZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7494AC32782;
	Fri, 16 Aug 2024 17:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723830977;
	bh=1nTnm/+BPLU9cVwWoXDMCuedVYe8mzXtHdP/ivu98UA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TW7ZmdZ74Qv2yYxlLEFJVTNsrLAcml2w+pZUFPw9eJhk+1el7+H1Vb6u4cPW/ZRb0
	 N+w3mYxSDp6r9E0PPGNCp9Wa4XpiZLmdsR6isWgtdWX+VjIXM/9T8CYF+fZubUGElQ
	 GJ8T8I5b4CjWNUbjSKOKy6K0SyrlxQSjzula6RIfuLvS95RfMVyb1wuXQzVEcOWxRd
	 bkxAdXsG/FnP/shnE06DgmNvT3kg31NpRkc7A3yzZu4DmB2DPDYmCcPoAdmQgT0ZP9
	 hA0cMexKlETeTsEPFfbZc5SkLPAOhzj2+ZCVwtlhvoF6oGXY6ZAHV+HN6px+tI8E2R
	 G8c+yzYhqLNjA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 16 Aug 2024 19:55:53 +0200
Subject: [PATCH bpf-next 2/2] selftests: bpf: remove duplicated UAPI if_xdp
 headers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240816-ups-bpf-next-selftests-use-khdr-v1-2-1e19f3d5b17a@kernel.org>
References: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
In-Reply-To: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
To: mptcp@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7279; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1nTnm/+BPLU9cVwWoXDMCuedVYe8mzXtHdP/ivu98UA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmv5KyWvPWfAKfgQov1oKBL4O5YXVEuXa/x49q/
 lX0K61rFOWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr+SsgAKCRD2t4JPQmmg
 c36TEAC8lekkD1MbsUYRYRgb/DHI0sb8IMEjaj0UMlLgXQD3ku2Hpklqu9VujgxDK+iEJ6JAJQ6
 aambDfVSOvG+C1lad1qbPGb+wK4U48+h5HN5QrjOtYRy0M80eiB0Hl0oj1Em7NTZqmUDa7Fj0d2
 z4RNYIVPqYQcpOQDZtADHqnYQCsDQGADl1RVudLs7cbw974Y6DUD/D1eBvwuxH0BfffnYM5wefE
 1Bp1bdhSi6xRXryz5ra5rLKcwmoQPbuF3JG6YQe4tiaqf+ZmiZ9AnQMZoaz+mMA3ApslkaDoi0r
 s57Qcx0/zmx4hxRkIqhycNJ7Th2LXIqGgpO5JwLGJ7ez8dvyDf1Sk0hXR7j9XTfx250XP4zuX/o
 DnE7L7+CSd+p7QNpUnJbtOk+5qrJdYQjSmcRxQgPNqLra1thmTDkf+fvxslnpcpxarTtJITIOrE
 8PNfMPt6hHgf/DAxcz2mdeDrHOkTGr9nv+II4YXJqEKB1bULB63/nnk35xaCO0fgo/PLIG9AB+X
 hvj8x4CkEBkoY1hBvP6wfUvrT9lJj4mNcoLDGsJOVFZYpe11w6uA/kl0LxrhGCmnHLokkOdkPOv
 DK3bDHl1kil5gj0nyUxoGkrG90m+wzvMd1EmhtbbBvXtRxnkOwf+sAOuFF241DFNwe3wcM8OfOr
 1W+NdxOu8TByfKA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Thanks to the previous commit, this file is no longer needed, because
the BPF selftests will take the UAPI headers from the kernel source.

Note that this file was an old copy of the UAPI one, which was causing a
warning at compilation time:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/include/uapi/linux/if_xdp.h | 173 --------------------------------------
 tools/lib/bpf/Makefile            |   3 -
 2 files changed, 176 deletions(-)

diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
deleted file mode 100644
index 2f082b01ff22..000000000000
--- a/tools/include/uapi/linux/if_xdp.h
+++ /dev/null
@@ -1,173 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * if_xdp: XDP socket user-space interface
- * Copyright(c) 2018 Intel Corporation.
- *
- * Author(s): Björn Töpel <bjorn.topel@intel.com>
- *	      Magnus Karlsson <magnus.karlsson@intel.com>
- */
-
-#ifndef _LINUX_IF_XDP_H
-#define _LINUX_IF_XDP_H
-
-#include <linux/types.h>
-
-/* Options for the sxdp_flags field */
-#define XDP_SHARED_UMEM	(1 << 0)
-#define XDP_COPY	(1 << 1) /* Force copy-mode */
-#define XDP_ZEROCOPY	(1 << 2) /* Force zero-copy mode */
-/* If this option is set, the driver might go sleep and in that case
- * the XDP_RING_NEED_WAKEUP flag in the fill and/or Tx rings will be
- * set. If it is set, the application need to explicitly wake up the
- * driver with a poll() (Rx and Tx) or sendto() (Tx only). If you are
- * running the driver and the application on the same core, you should
- * use this option so that the kernel will yield to the user space
- * application.
- */
-#define XDP_USE_NEED_WAKEUP (1 << 3)
-/* By setting this option, userspace application indicates that it can
- * handle multiple descriptors per packet thus enabling AF_XDP to split
- * multi-buffer XDP frames into multiple Rx descriptors. Without this set
- * such frames will be dropped.
- */
-#define XDP_USE_SG	(1 << 4)
-
-/* Flags for xsk_umem_config flags */
-#define XDP_UMEM_UNALIGNED_CHUNK_FLAG	(1 << 0)
-
-/* Force checksum calculation in software. Can be used for testing or
- * working around potential HW issues. This option causes performance
- * degradation and only works in XDP_COPY mode.
- */
-#define XDP_UMEM_TX_SW_CSUM		(1 << 1)
-
-/* Request to reserve tx_metadata_len bytes of per-chunk metadata.
- */
-#define XDP_UMEM_TX_METADATA_LEN	(1 << 2)
-
-struct sockaddr_xdp {
-	__u16 sxdp_family;
-	__u16 sxdp_flags;
-	__u32 sxdp_ifindex;
-	__u32 sxdp_queue_id;
-	__u32 sxdp_shared_umem_fd;
-};
-
-/* XDP_RING flags */
-#define XDP_RING_NEED_WAKEUP (1 << 0)
-
-struct xdp_ring_offset {
-	__u64 producer;
-	__u64 consumer;
-	__u64 desc;
-	__u64 flags;
-};
-
-struct xdp_mmap_offsets {
-	struct xdp_ring_offset rx;
-	struct xdp_ring_offset tx;
-	struct xdp_ring_offset fr; /* Fill */
-	struct xdp_ring_offset cr; /* Completion */
-};
-
-/* XDP socket options */
-#define XDP_MMAP_OFFSETS		1
-#define XDP_RX_RING			2
-#define XDP_TX_RING			3
-#define XDP_UMEM_REG			4
-#define XDP_UMEM_FILL_RING		5
-#define XDP_UMEM_COMPLETION_RING	6
-#define XDP_STATISTICS			7
-#define XDP_OPTIONS			8
-
-struct xdp_umem_reg {
-	__u64 addr; /* Start of packet data area */
-	__u64 len; /* Length of packet data area */
-	__u32 chunk_size;
-	__u32 headroom;
-	__u32 flags;
-	__u32 tx_metadata_len;
-};
-
-struct xdp_statistics {
-	__u64 rx_dropped; /* Dropped for other reasons */
-	__u64 rx_invalid_descs; /* Dropped due to invalid descriptor */
-	__u64 tx_invalid_descs; /* Dropped due to invalid descriptor */
-	__u64 rx_ring_full; /* Dropped due to rx ring being full */
-	__u64 rx_fill_ring_empty_descs; /* Failed to retrieve item from fill ring */
-	__u64 tx_ring_empty_descs; /* Failed to retrieve item from tx ring */
-};
-
-struct xdp_options {
-	__u32 flags;
-};
-
-/* Flags for the flags field of struct xdp_options */
-#define XDP_OPTIONS_ZEROCOPY (1 << 0)
-
-/* Pgoff for mmaping the rings */
-#define XDP_PGOFF_RX_RING			  0
-#define XDP_PGOFF_TX_RING		 0x80000000
-#define XDP_UMEM_PGOFF_FILL_RING	0x100000000ULL
-#define XDP_UMEM_PGOFF_COMPLETION_RING	0x180000000ULL
-
-/* Masks for unaligned chunks mode */
-#define XSK_UNALIGNED_BUF_OFFSET_SHIFT 48
-#define XSK_UNALIGNED_BUF_ADDR_MASK \
-	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
-
-/* Request transmit timestamp. Upon completion, put it into tx_timestamp
- * field of union xsk_tx_metadata.
- */
-#define XDP_TXMD_FLAGS_TIMESTAMP		(1 << 0)
-
-/* Request transmit checksum offload. Checksum start position and offset
- * are communicated via csum_start and csum_offset fields of union
- * xsk_tx_metadata.
- */
-#define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
-
-/* AF_XDP offloads request. 'request' union member is consumed by the driver
- * when the packet is being transmitted. 'completion' union member is
- * filled by the driver when the transmit completion arrives.
- */
-struct xsk_tx_metadata {
-	__u64 flags;
-
-	union {
-		struct {
-			/* XDP_TXMD_FLAGS_CHECKSUM */
-
-			/* Offset from desc->addr where checksumming should start. */
-			__u16 csum_start;
-			/* Offset from csum_start where checksum should be stored. */
-			__u16 csum_offset;
-		} request;
-
-		struct {
-			/* XDP_TXMD_FLAGS_TIMESTAMP */
-			__u64 tx_timestamp;
-		} completion;
-	};
-};
-
-/* Rx/Tx descriptor */
-struct xdp_desc {
-	__u64 addr;
-	__u32 len;
-	__u32 options;
-};
-
-/* UMEM descriptor is __u64 */
-
-/* Flag indicating that the packet continues with the buffer pointed out by the
- * next frame in the ring. The end of the packet is signalled by setting this
- * bit to zero. For single buffer packets, every descriptor has 'options' set
- * to 0 and this maintains backward compatibility.
- */
-#define XDP_PKT_CONTD (1 << 0)
-
-/* TX packet carries valid metadata. */
-#define XDP_TX_METADATA (1 << 1)
-
-#endif /* _LINUX_IF_XDP_H */
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 2cf892774346..977dba26ba87 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -148,9 +148,6 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
 	@(test -f ../../include/uapi/linux/bpf_common.h -a -f ../../../include/uapi/linux/bpf_common.h && ( \
 	(diff -B ../../include/uapi/linux/bpf_common.h ../../../include/uapi/linux/bpf_common.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf_common.h' differs from latest version at 'include/uapi/linux/bpf_common.h'" >&2 )) || true
-	@(test -f ../../include/uapi/linux/if_xdp.h -a -f ../../../include/uapi/linux/if_xdp.h && ( \
-	(diff -B ../../include/uapi/linux/if_xdp.h ../../../include/uapi/linux/if_xdp.h >/dev/null) || \
-	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
 
 $(BPF_IN_STATIC): force $(BPF_GENERATED)

-- 
2.45.2


