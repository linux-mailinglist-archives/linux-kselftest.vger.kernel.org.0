Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF349834F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 16:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbiAXPOP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 10:14:15 -0500
Received: from mail-dm6nam08on2085.outbound.protection.outlook.com ([40.107.102.85]:52000
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240659AbiAXPOO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 10:14:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiHN8wDN1eiYrMZh0ynEOyhboAegrBjAbNEVoIV8zV1vO6ZwUxy3H1KAQuMHmC19ksIlx6exTWmOXqAgYbcGvaO2/2bw+JI1n6MBuco3xHoNDGQuX0yEC5oJIa53F6w0YHbvcD3rSt7OasLArGchDhPQiSROvgMLMPZx7O9yMVzIy248iVtDyMbZcfYEUs79Wb0BYm9EUcFXCHZewHKyn8zx2bbxVOhsjXV3gp5IdlSBtSwSMTBUAgdbxdWuNmbl/b45FyicpE7UL+D02dQ2AtheJcPBUMegyHhZ/G38Q63i/Y+kdUzGMTpnjxp6moNsOOojQUpa+EzBWGLww/0XGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5W+EFl2s9hWc7QxFpFR6lebwedFxZ0h1QUnblnWt9I=;
 b=lvZG+wIF8uP647QEW8rj7wS7yP9QvEGyPXDKos6WsaM6eprr/9SujXJ7he+Pp4ac8rcdaY12UunFwyrfm5rFS1DlUZEHi46QIt5Luke4rhgTDrwA7EGlX8HbWY0UIWPeHKQn6T9h8PRh16cqoVdzOuuodMUEfDJm6xuZmnc/dipMTy792Gq2NsmInKWQFJquWHR6mFGwGCQLIHtCMMSl5irdRNxKaWKPqGpdYejahNMEQbjlcUbMhIFF5MavKTu+TBjxVJ6ErzGM2xL//Vw83ZcBw+PmPxIE8W+VBjN2DXcRpvheN7jUz0bsrPOTx9vByAZLTcr+76z2pOQQNOMyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5W+EFl2s9hWc7QxFpFR6lebwedFxZ0h1QUnblnWt9I=;
 b=tMvIPsf4Gvr/iKK6KLlOcLsPdbUh2zUqdI7HsdQy0pS3kDhkem89wCOEKRyq+HPc8MlpENQHNjwBj5JvdOJr+8Ybd11z8JOvbx7sv4uGQQ1TZyGBIzDLqaVZYjA6xKuScjNtiMu1IExgHbOfLPUI6GZSoKFwhFpyIpE/gST71Rrb6oUQNFrK8AN3A2iSElmO8AchKo8Kr/6aIsB3Y+4zKtqe+M4Dx7KCHSKqgl/TDFeYLu39BRYVskMZ4iAKZUkb1IoUeooQeRJFAC2MlFSJbw8RgmIaFP6598/eLlX9+Obbn3V4d9FnzZPUwqULZeI9HE4SWshFJNFdkgdKzjlYCw==
Received: from BN6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:405:70::20)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 15:14:11 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::2b) by BN6PR12CA0034.outlook.office365.com
 (2603:10b6:405:70::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 15:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 15:14:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Mon, 24 Jan 2022 15:14:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Mon, 24 Jan 2022 07:14:09 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 24 Jan 2022 07:14:03 -0800
From:   Maxim Mikityanskiy <maximmi@nvidia.com>
To:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, <netdev@vger.kernel.org>
CC:     Tariq Toukan <tariqt@nvidia.com>, Martin KaFai Lau <kafai@fb.com>,
        "Song Liu" <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "David Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Joe Stringer <joe@cilium.io>,
        "Florent Revest" <revest@chromium.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        "Maxim Mikityanskiy" <maximmi@nvidia.com>
Subject: [PATCH bpf-next v2 3/3] bpf: Add selftests for raw syncookie helpers
Date:   Mon, 24 Jan 2022 17:13:40 +0200
Message-ID: <20220124151340.376807-4-maximmi@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124151340.376807-1-maximmi@nvidia.com>
References: <20220124151340.376807-1-maximmi@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a3237b2-b899-4187-dfac-08d9df4c2ca5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53611E53B58A2D594E3FC878DC5E9@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ATe3UI9lrj46Kze8aKN77RQdeBID3fNoqi10bCMdxriuyBsKpUrUQUwkBy6sL2KvSS/UkED7AG+hFr96NXrzh1C3Wf0NjocDdACbgpFPifc4H4wT2ABs5j7gZ9xpKuA11gRCLpDV81Ie12eSMzhTuTI963cjkpLrIQVEdZYL8ypmjhUjBPszRaLttiUpffnbdX/ilDC5KnyWNxvkfAeogyYmpHm9DHCmraZspHpZq5ofg6b1ZsNBr5sWNHYqyXHHYepLKXUvl12oyl0O2EiVV09VngAYH8mFlxSH9nXbpwfJM9oBNntD8VG4Rq/kQtY5bEWse5OiRn91Dnna7tNjJVXjLQr4VNjuOr8Q9ToPYpQDSNBGdAz76sRxsQtwmTD6ctg6c59hECWUvQqHuAWuhxax3DQXwW0X98qyR3Ri9Fe8BuWjMVPZ6yvbH5ZWelx1MJEGTC4Btha/Mu2xSbPF3RJse3AG1gPxGppFn9hlcNngX0i7aFk/YfvvICHCvN/8KBgkT2TE6biAI+ZThF50aW5MZnI6B0DHF1Zmt9HS9+xZMpGVnAix6j4iHseoPojnwKsCFge71YCbMBw/evR25YFaFuDydIFhdPJpRGLxLtcS47Tn0xLg++eCQS0GcfI17wAlvlQ8BdANhNvM+cPWT+N2Hu2LVH+SISIVWT+dJyqd2SnN0B0vec46u3djh8UnClzGBd0QyWTS7P3/fQ3DCKk365IlTjOX0oGzn0Xqvzjsf9eGj4Is12DTfIMiiLeXPy+u7mTs0etYQ/LAmBP80ppoQYgoL+V4cwR6kljljXAr9JOwjFHPGDINy0UTniS
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700004)(86362001)(5660300002)(30864003)(6666004)(336012)(2616005)(4326008)(426003)(508600001)(36860700001)(70586007)(107886003)(83380400001)(40460700003)(26005)(1076003)(186003)(82310400004)(70206006)(356005)(8676002)(7696005)(110136005)(54906003)(81166007)(2906002)(7416002)(47076005)(36756003)(316002)(8936002)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 15:14:10.6712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3237b2-b899-4187-dfac-08d9df4c2ca5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit adds selftests for the new BPF helpers:
bpf_tcp_raw_gen_syncookie and bpf_tcp_raw_check_syncookie.

xdp_synproxy_kern.c is a BPF program that generates SYN cookies on
allowed TCP ports and sends SYNACKs to clients, accelerating synproxy
iptables module.

xdp_synproxy.c is a userspace control application that allows to
configure the following options in runtime: list of allowed ports, MSS,
window scale, TTL.

test_xdp_synproxy.sh is a script that demonstrates the setup of synproxy
with XDP acceleration and serves as a selftest for the new feature.

Signed-off-by: Maxim Mikityanskiy <maximmi@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   5 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c   | 743 ++++++++++++++++++
 .../selftests/bpf/test_xdp_synproxy.sh        |  71 ++
 tools/testing/selftests/bpf/xdp_synproxy.c    | 418 ++++++++++
 5 files changed, 1236 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
 create mode 100755 tools/testing/selftests/bpf/test_xdp_synproxy.sh
 create mode 100644 tools/testing/selftests/bpf/xdp_synproxy.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 1dad8d617da8..1bcffd73632e 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -41,3 +41,4 @@ test_cpp
 *.tmp
 xdpxceiver
 xdp_redirect_multi
+xdp_synproxy
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 945f92d71db3..8b9bcb2226da 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -72,7 +72,8 @@ TEST_PROGS := test_kmod.sh \
 	test_bpftool.sh \
 	test_bpftool_metadata.sh \
 	test_doc_build.sh \
-	test_xsk.sh
+	test_xsk.sh \
+	test_xdp_synproxy.sh
 
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh \
@@ -82,7 +83,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
-	xdpxceiver xdp_redirect_multi
+	xdpxceiver xdp_redirect_multi xdp_synproxy
 
 TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 
diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
new file mode 100644
index 000000000000..a45d517e07ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -0,0 +1,743 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include <asm/errno.h>
+
+#define NSEC_PER_SEC 1000000000L
+
+#define ETH_ALEN 6
+#define ETH_P_IP 0x0800
+#define ETH_P_IPV6 0x86DD
+
+#define tcp_flag_word(tp) (((union tcp_word_hdr *)(tp))->words[3])
+
+#define IP_DF 0x4000
+#define IP_MF 0x2000
+#define IP_OFFSET 0x1fff
+
+#define NEXTHDR_TCP 6
+
+#define TCPOPT_NOP 1
+#define TCPOPT_EOL 0
+#define TCPOPT_MSS 2
+#define TCPOPT_WINDOW 3
+#define TCPOPT_SACK_PERM 4
+#define TCPOPT_TIMESTAMP 8
+
+#define TCPOLEN_MSS 4
+#define TCPOLEN_WINDOW 3
+#define TCPOLEN_SACK_PERM 2
+#define TCPOLEN_TIMESTAMP 10
+
+#define TCP_TS_HZ 1000
+#define TS_OPT_WSCALE_MASK 0xf
+#define TS_OPT_SACK (1 << 4)
+#define TS_OPT_ECN (1 << 5)
+#define TSBITS 6
+#define TSMASK (((__u32)1 << TSBITS) - 1)
+#define TCP_MAX_WSCALE 14U
+
+#define IPV4_MAXLEN 60
+#define TCP_MAXLEN 60
+
+#define DEFAULT_MSS4 1460
+#define DEFAULT_MSS6 1440
+#define DEFAULT_WSCALE 7
+#define DEFAULT_TTL 64
+#define MAX_ALLOWED_PORTS 8
+
+#define swap(a, b) \
+	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __attribute__((__packed__)) *__pptr = (typeof(__pptr))(ptr); \
+	__pptr->x;								\
+})
+
+#define get_unaligned(ptr) __get_unaligned_t(typeof(*(ptr)), (ptr))
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u64);
+	__uint(max_entries, 2);
+} values SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__type(key, __u32);
+	__type(value, __u16);
+	__uint(max_entries, MAX_ALLOWED_PORTS);
+} allowed_ports SEC(".maps");
+
+extern struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx,
+					 struct bpf_sock_tuple *bpf_tuple,
+					 __u32 len_tuple,
+					 struct bpf_ct_opts *opts,
+					 __u32 len_opts) __ksym;
+
+extern void bpf_ct_release(struct nf_conn *ct) __ksym;
+
+static __always_inline void swap_eth_addr(__u8 *a, __u8 *b)
+{
+	__u8 tmp[ETH_ALEN];
+
+	__builtin_memcpy(tmp, a, ETH_ALEN);
+	__builtin_memcpy(a, b, ETH_ALEN);
+	__builtin_memcpy(b, tmp, ETH_ALEN);
+}
+
+static __always_inline __u16 csum_fold(__u32 csum)
+{
+	csum = (csum & 0xffff) + (csum >> 16);
+	csum = (csum & 0xffff) + (csum >> 16);
+	return (__u16)~csum;
+}
+
+static __always_inline __u16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
+					       __u32 len, __u8 proto,
+					       __u32 csum)
+{
+	__u64 s = csum;
+
+	s += (__u32)saddr;
+	s += (__u32)daddr;
+#if defined(__BIG_ENDIAN__)
+	s += proto + len;
+#elif defined(__LITTLE_ENDIAN__)
+	s += (proto + len) << 8;
+#else
+#error Unknown endian
+#endif
+	s = (s & 0xffffffff) + (s >> 32);
+	s = (s & 0xffffffff) + (s >> 32);
+
+	return csum_fold((__u32)s);
+}
+
+static __always_inline __u16 csum_ipv6_magic(const struct in6_addr *saddr,
+					     const struct in6_addr *daddr,
+					     __u32 len, __u8 proto, __u32 csum)
+{
+	__u64 sum = csum;
+	int i;
+
+#pragma unroll
+	for (i = 0; i < 4; i++)
+		sum += (__u32)saddr->in6_u.u6_addr32[i];
+
+#pragma unroll
+	for (i = 0; i < 4; i++)
+		sum += (__u32)daddr->in6_u.u6_addr32[i];
+
+	// Don't combine additions to avoid 32-bit overflow.
+	sum += bpf_htonl(len);
+	sum += bpf_htonl(proto);
+
+	sum = (sum & 0xffffffff) + (sum >> 32);
+	sum = (sum & 0xffffffff) + (sum >> 32);
+
+	return csum_fold((__u32)sum);
+}
+
+static __always_inline __u64 tcp_clock_ns(void)
+{
+	return bpf_ktime_get_ns();
+}
+
+static __always_inline __u32 tcp_ns_to_ts(__u64 ns)
+{
+	return ns / (NSEC_PER_SEC / TCP_TS_HZ);
+}
+
+static __always_inline __u32 tcp_time_stamp_raw(void)
+{
+	return tcp_ns_to_ts(tcp_clock_ns());
+}
+
+struct tcpopt_context {
+	__u8 *ptr;
+	__u8 *end;
+	void *data_end;
+	__be32 *tsecr;
+	__u8 wscale;
+	bool option_timestamp;
+	bool option_sack;
+};
+
+static int tscookie_tcpopt_parse(struct tcpopt_context *ctx)
+{
+	__u8 opcode, opsize;
+
+	if (ctx->ptr >= ctx->end)
+		return 1;
+	if (ctx->ptr >= ctx->data_end)
+		return 1;
+
+	opcode = ctx->ptr[0];
+
+	if (opcode == TCPOPT_EOL)
+		return 1;
+	if (opcode == TCPOPT_NOP) {
+		++ctx->ptr;
+		return 0;
+	}
+
+	if (ctx->ptr + 1 >= ctx->end)
+		return 1;
+	if (ctx->ptr + 1 >= ctx->data_end)
+		return 1;
+	opsize = ctx->ptr[1];
+	if (opsize < 2)
+		return 1;
+
+	if (ctx->ptr + opsize > ctx->end)
+		return 1;
+
+	switch (opcode) {
+	case TCPOPT_WINDOW:
+		if (opsize == TCPOLEN_WINDOW && ctx->ptr + TCPOLEN_WINDOW <= ctx->data_end)
+			ctx->wscale = ctx->ptr[2] < TCP_MAX_WSCALE ? ctx->ptr[2] : TCP_MAX_WSCALE;
+		break;
+	case TCPOPT_TIMESTAMP:
+		if (opsize == TCPOLEN_TIMESTAMP && ctx->ptr + TCPOLEN_TIMESTAMP <= ctx->data_end) {
+			ctx->option_timestamp = true;
+			/* Client's tsval becomes our tsecr. */
+			*ctx->tsecr = get_unaligned((__be32 *)(ctx->ptr + 2));
+		}
+		break;
+	case TCPOPT_SACK_PERM:
+		if (opsize == TCPOLEN_SACK_PERM)
+			ctx->option_sack = true;
+		break;
+	}
+
+	ctx->ptr += opsize;
+
+	return 0;
+}
+
+static int tscookie_tcpopt_parse_batch(__u32 index, void *context)
+{
+	int i;
+
+	for (i = 0; i < 7; i++)
+		if (tscookie_tcpopt_parse(context))
+			return 1;
+	return 0;
+}
+
+static __always_inline bool tscookie_init(struct tcphdr *tcp_header,
+					  __u16 tcp_len, __be32 *tsval,
+					  __be32 *tsecr, void *data_end)
+{
+	struct tcpopt_context loop_ctx = {
+		.ptr = (__u8 *)(tcp_header + 1),
+		.end = (__u8 *)tcp_header + tcp_len,
+		.data_end = data_end,
+		.tsecr = tsecr,
+		.wscale = TS_OPT_WSCALE_MASK,
+		.option_timestamp = false,
+		.option_sack = false,
+	};
+	u32 cookie;
+
+	bpf_loop(6, tscookie_tcpopt_parse_batch, &loop_ctx, 0);
+
+	if (!loop_ctx.option_timestamp)
+		return false;
+
+	cookie = tcp_time_stamp_raw() & ~TSMASK;
+	cookie |= loop_ctx.wscale & TS_OPT_WSCALE_MASK;
+	if (loop_ctx.option_sack)
+		cookie |= TS_OPT_SACK;
+	if (tcp_header->ece && tcp_header->cwr)
+		cookie |= TS_OPT_ECN;
+	*tsval = bpf_htonl(cookie);
+
+	return true;
+}
+
+static __always_inline void values_get_tcpipopts(__u16 *mss, __u8 *wscale,
+						 __u8 *ttl, bool ipv6)
+{
+	__u32 key = 0;
+	__u64 *value;
+
+	value = bpf_map_lookup_elem(&values, &key);
+	if (value && *value != 0) {
+		if (ipv6)
+			*mss = (*value >> 32) & 0xffff;
+		else
+			*mss = *value & 0xffff;
+		*wscale = (*value >> 16) & 0xf;
+		*ttl = (*value >> 24) & 0xff;
+		return;
+	}
+
+	*mss = ipv6 ? DEFAULT_MSS6 : DEFAULT_MSS4;
+	*wscale = DEFAULT_WSCALE;
+	*ttl = DEFAULT_TTL;
+}
+
+static __always_inline void values_inc_synacks(void)
+{
+	__u32 key = 1;
+	__u32 *value;
+
+	value = bpf_map_lookup_elem(&values, &key);
+	if (value)
+		__sync_fetch_and_add(value, 1);
+}
+
+static __always_inline bool check_port_allowed(__u16 port)
+{
+	__u32 i;
+
+	for (i = 0; i < MAX_ALLOWED_PORTS; i++) {
+		__u32 key = i;
+		__u16 *value;
+
+		value = bpf_map_lookup_elem(&allowed_ports, &key);
+
+		if (!value)
+			break;
+		// 0 is a terminator value. Check it first to avoid matching on
+		// a forbidden port == 0 and returning true.
+		if (*value == 0)
+			break;
+
+		if (*value == port)
+			return true;
+	}
+
+	return false;
+}
+
+struct header_pointers {
+	struct ethhdr *eth;
+	struct iphdr *ipv4;
+	struct ipv6hdr *ipv6;
+	struct tcphdr *tcp;
+	__u16 tcp_len;
+};
+
+static __always_inline int tcp_dissect(void *data, void *data_end,
+				       struct header_pointers *hdr)
+{
+	hdr->eth = data;
+	if (hdr->eth + 1 > data_end)
+		return XDP_DROP;
+
+	switch (bpf_ntohs(hdr->eth->h_proto)) {
+	case ETH_P_IP:
+		hdr->ipv6 = NULL;
+
+		hdr->ipv4 = (void *)hdr->eth + sizeof(*hdr->eth);
+		if (hdr->ipv4 + 1 > data_end)
+			return XDP_DROP;
+		if (hdr->ipv4->ihl * 4 < sizeof(*hdr->ipv4))
+			return XDP_DROP;
+		if (hdr->ipv4->version != 4)
+			return XDP_DROP;
+
+		if (hdr->ipv4->protocol != IPPROTO_TCP)
+			return XDP_PASS;
+
+		hdr->tcp = (void *)hdr->ipv4 + hdr->ipv4->ihl * 4;
+		break;
+	case ETH_P_IPV6:
+		hdr->ipv4 = NULL;
+
+		hdr->ipv6 = (void *)hdr->eth + sizeof(*hdr->eth);
+		if (hdr->ipv6 + 1 > data_end)
+			return XDP_DROP;
+		if (hdr->ipv6->version != 6)
+			return XDP_DROP;
+
+		// XXX: Extension headers are not supported and could circumvent
+		// XDP SYN flood protection.
+		if (hdr->ipv6->nexthdr != NEXTHDR_TCP)
+			return XDP_PASS;
+
+		hdr->tcp = (void *)hdr->ipv6 + sizeof(*hdr->ipv6);
+		break;
+	default:
+		// XXX: VLANs will circumvent XDP SYN flood protection.
+		return XDP_PASS;
+	}
+
+	if (hdr->tcp + 1 > data_end)
+		return XDP_DROP;
+	hdr->tcp_len = hdr->tcp->doff * 4;
+	if (hdr->tcp_len < sizeof(*hdr->tcp))
+		return XDP_DROP;
+
+	return XDP_TX;
+}
+
+static __always_inline int tcp_lookup(struct xdp_md *ctx, struct header_pointers *hdr)
+{
+	struct bpf_ct_opts ct_lookup_opts = {
+		.netns_id = BPF_F_CURRENT_NETNS,
+		.l4proto = IPPROTO_TCP,
+	};
+	struct bpf_sock_tuple tup = {};
+	struct nf_conn *ct;
+	__u32 tup_size;
+
+	if (hdr->ipv4) {
+		// TCP doesn't normally use fragments, and XDP can't reassemble them.
+		if ((hdr->ipv4->frag_off & bpf_htons(IP_DF | IP_MF | IP_OFFSET)) != bpf_htons(IP_DF))
+			return XDP_DROP;
+
+		tup.ipv4.saddr = hdr->ipv4->saddr;
+		tup.ipv4.daddr = hdr->ipv4->daddr;
+		tup.ipv4.sport = hdr->tcp->source;
+		tup.ipv4.dport = hdr->tcp->dest;
+		tup_size = sizeof(tup.ipv4);
+	} else if (hdr->ipv6) {
+		__builtin_memcpy(tup.ipv6.saddr, &hdr->ipv6->saddr, sizeof(tup.ipv6.saddr));
+		__builtin_memcpy(tup.ipv6.daddr, &hdr->ipv6->daddr, sizeof(tup.ipv6.daddr));
+		tup.ipv6.sport = hdr->tcp->source;
+		tup.ipv6.dport = hdr->tcp->dest;
+		tup_size = sizeof(tup.ipv6);
+	} else {
+		// The verifier can't track that either ipv4 or ipv6 is not NULL.
+		return XDP_ABORTED;
+	}
+	ct = bpf_xdp_ct_lookup(ctx, &tup, tup_size, &ct_lookup_opts, sizeof(ct_lookup_opts));
+	if (ct) {
+		unsigned long status = ct->status;
+
+		bpf_ct_release(ct);
+		if (status & IPS_CONFIRMED_BIT)
+			return XDP_PASS;
+	} else if (ct_lookup_opts.error != -ENOENT) {
+		return XDP_ABORTED;
+	}
+
+	// error == -ENOENT || !(status & IPS_CONFIRMED_BIT)
+	return XDP_TX;
+}
+
+static __always_inline __u8 tcp_mkoptions(__be32 *buf, __be32 *tsopt, __u16 mss,
+					  __u8 wscale)
+{
+	__be32 *start = buf;
+
+	*buf++ = bpf_htonl((TCPOPT_MSS << 24) | (TCPOLEN_MSS << 16) | mss);
+
+	if (!tsopt)
+		return buf - start;
+
+	if (tsopt[0] & bpf_htonl(1 << 4))
+		*buf++ = bpf_htonl((TCPOPT_SACK_PERM << 24) |
+				   (TCPOLEN_SACK_PERM << 16) |
+				   (TCPOPT_TIMESTAMP << 8) |
+				   TCPOLEN_TIMESTAMP);
+	else
+		*buf++ = bpf_htonl((TCPOPT_NOP << 24) |
+				   (TCPOPT_NOP << 16) |
+				   (TCPOPT_TIMESTAMP << 8) |
+				   TCPOLEN_TIMESTAMP);
+	*buf++ = tsopt[0];
+	*buf++ = tsopt[1];
+
+	if ((tsopt[0] & bpf_htonl(0xf)) != bpf_htonl(0xf))
+		*buf++ = bpf_htonl((TCPOPT_NOP << 24) |
+				   (TCPOPT_WINDOW << 16) |
+				   (TCPOLEN_WINDOW << 8) |
+				   wscale);
+
+	return buf - start;
+}
+
+static __always_inline void tcp_gen_synack(struct tcphdr *tcp_header,
+					   __u32 cookie, __be32 *tsopt,
+					   __u16 mss, __u8 wscale)
+{
+	void *tcp_options;
+
+	tcp_flag_word(tcp_header) = TCP_FLAG_SYN | TCP_FLAG_ACK;
+	if (tsopt && (tsopt[0] & bpf_htonl(1 << 5)))
+		tcp_flag_word(tcp_header) |= TCP_FLAG_ECE;
+	tcp_header->doff = 5; // doff is part of tcp_flag_word.
+	swap(tcp_header->source, tcp_header->dest);
+	tcp_header->ack_seq = bpf_htonl(bpf_ntohl(tcp_header->seq) + 1);
+	tcp_header->seq = bpf_htonl(cookie);
+	tcp_header->window = 0;
+	tcp_header->urg_ptr = 0;
+	tcp_header->check = 0; // Rely on hardware checksum offload.
+
+	tcp_options = (void *)(tcp_header + 1);
+	tcp_header->doff += tcp_mkoptions(tcp_options, tsopt, mss, wscale);
+}
+
+static __always_inline void tcpv4_gen_synack(struct header_pointers *hdr,
+					     __u32 cookie, __be32 *tsopt)
+{
+	__u8 wscale;
+	__u16 mss;
+	__u8 ttl;
+
+	values_get_tcpipopts(&mss, &wscale, &ttl, false);
+
+	swap_eth_addr(hdr->eth->h_source, hdr->eth->h_dest);
+
+	swap(hdr->ipv4->saddr, hdr->ipv4->daddr);
+	hdr->ipv4->check = 0; // Rely on hardware checksum offload.
+	hdr->ipv4->tos = 0;
+	hdr->ipv4->id = 0;
+	hdr->ipv4->ttl = ttl;
+
+	tcp_gen_synack(hdr->tcp, cookie, tsopt, mss, wscale);
+
+	hdr->tcp_len = hdr->tcp->doff * 4;
+	hdr->ipv4->tot_len = bpf_htons(sizeof(*hdr->ipv4) + hdr->tcp_len);
+}
+
+static __always_inline void tcpv6_gen_synack(struct header_pointers *hdr,
+					     __u32 cookie, __be32 *tsopt)
+{
+	__u8 wscale;
+	__u16 mss;
+	__u8 ttl;
+
+	values_get_tcpipopts(&mss, &wscale, &ttl, true);
+
+	swap_eth_addr(hdr->eth->h_source, hdr->eth->h_dest);
+
+	swap(hdr->ipv6->saddr, hdr->ipv6->daddr);
+	*(__be32 *)hdr->ipv6 = bpf_htonl(0x60000000);
+	hdr->ipv6->hop_limit = ttl;
+
+	tcp_gen_synack(hdr->tcp, cookie, tsopt, mss, wscale);
+
+	hdr->tcp_len = hdr->tcp->doff * 4;
+	hdr->ipv6->payload_len = bpf_htons(hdr->tcp_len);
+}
+
+static __always_inline int syncookie_handle_syn(struct header_pointers *hdr,
+						struct xdp_md *ctx,
+						void *data, void *data_end)
+{
+	__u32 old_pkt_size, new_pkt_size;
+	// Unlike clang 10, clang 11 and 12 generate code that doesn't pass the
+	// BPF verifier if tsopt is not volatile. Volatile forces it to store
+	// the pointer value and use it directly, otherwise tcp_mkoptions is
+	// (mis)compiled like this:
+	//   if (!tsopt)
+	//       return buf - start;
+	//   reg = stored_return_value_of_bpf_tcp_raw_gen_tscookie;
+	//   if (reg == 0)
+	//       tsopt = tsopt_buf;
+	//   else
+	//       tsopt = NULL;
+	//   ...
+	//   *buf++ = tsopt[1];
+	// It creates a dead branch where tsopt is assigned NULL, but the
+	// verifier can't prove it's dead and blocks the program.
+	__be32 * volatile tsopt = NULL;
+	__be32 tsopt_buf[2] = {};
+	void *ip_header;
+	__u16 ip_len;
+	__u32 cookie;
+	__s64 value;
+
+	if (hdr->ipv4) {
+		// Check the IPv4 and TCP checksums before creating a SYNACK.
+		value = bpf_csum_diff(0, 0, (void *)hdr->ipv4, hdr->ipv4->ihl * 4, 0);
+		if (value < 0)
+			return XDP_ABORTED;
+		if (csum_fold(value) != 0)
+			return XDP_DROP; // Bad IPv4 checksum.
+
+		value = bpf_csum_diff(0, 0, (void *)hdr->tcp, hdr->tcp_len, 0);
+		if (value < 0)
+			return XDP_ABORTED;
+		if (csum_tcpudp_magic(hdr->ipv4->saddr, hdr->ipv4->daddr,
+				      hdr->tcp_len, IPPROTO_TCP, value) != 0)
+			return XDP_DROP; // Bad TCP checksum.
+
+		ip_header = hdr->ipv4;
+		ip_len = sizeof(*hdr->ipv4);
+	} else if (hdr->ipv6) {
+		// Check the TCP checksum before creating a SYNACK.
+		value = bpf_csum_diff(0, 0, (void *)hdr->tcp, hdr->tcp_len, 0);
+		if (value < 0)
+			return XDP_ABORTED;
+		if (csum_ipv6_magic(&hdr->ipv6->saddr, &hdr->ipv6->daddr,
+				    hdr->tcp_len, IPPROTO_TCP, value) != 0)
+			return XDP_DROP; // Bad TCP checksum.
+
+		ip_header = hdr->ipv6;
+		ip_len = sizeof(*hdr->ipv6);
+	} else {
+		return XDP_ABORTED;
+	}
+
+	// Issue SYN cookies on allowed ports, drop SYN packets on
+	// blocked ports.
+	if (!check_port_allowed(bpf_ntohs(hdr->tcp->dest)))
+		return XDP_DROP;
+
+	value = bpf_tcp_raw_gen_syncookie(ip_header, ip_len,
+					  (void *)hdr->tcp, hdr->tcp_len);
+	if (value < 0)
+		return XDP_ABORTED;
+	cookie = (__u32)value;
+
+	if (tscookie_init((void *)hdr->tcp, hdr->tcp_len,
+			  &tsopt_buf[0], &tsopt_buf[1], data_end))
+		tsopt = tsopt_buf;
+
+	// Check that there is enough space for a SYNACK. It also covers
+	// the check that the destination of the __builtin_memmove below
+	// doesn't overflow.
+	if (data + sizeof(*hdr->eth) + ip_len + TCP_MAXLEN > data_end)
+		return XDP_ABORTED;
+
+	if (hdr->ipv4) {
+		if (hdr->ipv4->ihl * 4 > sizeof(*hdr->ipv4)) {
+			struct tcphdr *new_tcp_header;
+
+			new_tcp_header = data + sizeof(*hdr->eth) + sizeof(*hdr->ipv4);
+			__builtin_memmove(new_tcp_header, hdr->tcp, sizeof(*hdr->tcp));
+			hdr->tcp = new_tcp_header;
+
+			hdr->ipv4->ihl = sizeof(*hdr->ipv4) / 4;
+		}
+
+		tcpv4_gen_synack(hdr, cookie, tsopt);
+	} else if (hdr->ipv6) {
+		tcpv6_gen_synack(hdr, cookie, tsopt);
+	} else {
+		return XDP_ABORTED;
+	}
+
+	// Recalculate checksums.
+	hdr->tcp->check = 0;
+	value = bpf_csum_diff(0, 0, (void *)hdr->tcp, hdr->tcp_len, 0);
+	if (value < 0)
+		return XDP_ABORTED;
+	if (hdr->ipv4) {
+		hdr->tcp->check = csum_tcpudp_magic(hdr->ipv4->saddr,
+						    hdr->ipv4->daddr,
+						    hdr->tcp_len,
+						    IPPROTO_TCP,
+						    value);
+
+		hdr->ipv4->check = 0;
+		value = bpf_csum_diff(0, 0, (void *)hdr->ipv4, sizeof(*hdr->ipv4), 0);
+		if (value < 0)
+			return XDP_ABORTED;
+		hdr->ipv4->check = csum_fold(value);
+	} else if (hdr->ipv6) {
+		hdr->tcp->check = csum_ipv6_magic(&hdr->ipv6->saddr,
+						  &hdr->ipv6->daddr,
+						  hdr->tcp_len,
+						  IPPROTO_TCP,
+						  value);
+	} else {
+		return XDP_ABORTED;
+	}
+
+	// Set the new packet size.
+	old_pkt_size = data_end - data;
+	new_pkt_size = sizeof(*hdr->eth) + ip_len + hdr->tcp->doff * 4;
+	if (bpf_xdp_adjust_tail(ctx, new_pkt_size - old_pkt_size))
+		return XDP_ABORTED;
+
+	values_inc_synacks();
+
+	return XDP_TX;
+}
+
+static __always_inline int syncookie_handle_ack(struct header_pointers *hdr)
+{
+	int err;
+
+	if (hdr->ipv4)
+		err = bpf_tcp_raw_check_syncookie(hdr->ipv4, sizeof(*hdr->ipv4),
+						  (void *)hdr->tcp, hdr->tcp_len);
+	else if (hdr->ipv6)
+		err = bpf_tcp_raw_check_syncookie(hdr->ipv6, sizeof(*hdr->ipv6),
+						  (void *)hdr->tcp, hdr->tcp_len);
+	else
+		return XDP_ABORTED;
+	if (err)
+		return XDP_DROP;
+
+	return XDP_PASS;
+}
+
+SEC("xdp/syncookie")
+int syncookie_xdp(struct xdp_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct header_pointers hdr;
+	__s64 value;
+	int ret;
+
+	struct bpf_ct_opts ct_lookup_opts = {
+		.netns_id = BPF_F_CURRENT_NETNS,
+		.l4proto = IPPROTO_TCP,
+	};
+
+	ret = tcp_dissect(data, data_end, &hdr);
+	if (ret != XDP_TX)
+		return ret;
+
+	ret = tcp_lookup(ctx, &hdr);
+	if (ret != XDP_TX)
+		return ret;
+
+	// Packet is TCP and doesn't belong to an established connection.
+
+	if ((hdr.tcp->syn ^ hdr.tcp->ack) != 1)
+		return XDP_DROP;
+
+	// Grow the TCP header to TCP_MAXLEN to be able to pass any hdr.tcp_len
+	// to bpf_tcp_raw_gen_syncookie and pass the verifier.
+	if (bpf_xdp_adjust_tail(ctx, TCP_MAXLEN - hdr.tcp_len))
+		return XDP_ABORTED;
+
+	data_end = (void *)(long)ctx->data_end;
+	data = (void *)(long)ctx->data;
+
+	if (hdr.ipv4) {
+		hdr.eth = data;
+		hdr.ipv4 = (void *)hdr.eth + sizeof(*hdr.eth);
+		// IPV4_MAXLEN is needed when calculating checksum.
+		// At least sizeof(struct iphdr) is needed here to access ihl.
+		if ((void *)hdr.ipv4 + IPV4_MAXLEN > data_end)
+			return XDP_ABORTED;
+		hdr.tcp = (void *)hdr.ipv4 + hdr.ipv4->ihl * 4;
+	} else if (hdr.ipv6) {
+		hdr.eth = data;
+		hdr.ipv6 = (void *)hdr.eth + sizeof(*hdr.eth);
+		hdr.tcp = (void *)hdr.ipv6 + sizeof(*hdr.ipv6);
+	} else {
+		return XDP_ABORTED;
+	}
+
+	if ((void *)hdr.tcp + TCP_MAXLEN > data_end)
+		return XDP_ABORTED;
+
+	// We run out of registers, tcp_len gets spilled to the stack, and the
+	// verifier forgets its min and max values checked above in tcp_dissect.
+	hdr.tcp_len = hdr.tcp->doff * 4;
+	if (hdr.tcp_len < sizeof(*hdr.tcp))
+		return XDP_ABORTED;
+
+	return hdr.tcp->syn ? syncookie_handle_syn(&hdr, ctx, data, data_end) :
+			      syncookie_handle_ack(&hdr);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_xdp_synproxy.sh b/tools/testing/selftests/bpf/test_xdp_synproxy.sh
new file mode 100755
index 000000000000..8f2811983212
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_xdp_synproxy.sh
@@ -0,0 +1,71 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+# Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+set -e
+
+PORT=8080
+
+DIR="$(dirname "$0")"
+SERVER_PID=
+
+fail() {
+	echo 'test_xdp_synproxy: [FAIL]'
+	exit 1
+}
+
+cleanup() {
+	set +e
+
+	ip link del tmp0
+	ip netns del synproxy
+
+	# Kill background jobs, if any.
+	kill "$(jobs -p)"
+}
+
+trap cleanup SIGINT SIGTERM EXIT
+
+modprobe nf_conntrack
+ip netns add synproxy
+ip netns exec synproxy ip link set lo up
+ip link add tmp0 type veth peer name tmp1
+sleep 1 # Wait, otherwise the IP address is not applied to tmp0.
+ip link set tmp1 netns synproxy
+ip link set tmp0 up
+ip addr replace 198.18.0.1/24 dev tmp0
+ip netns exec synproxy ip link set tmp1 up
+ip netns exec synproxy ip addr replace 198.18.0.2/24 dev tmp1
+ip netns exec synproxy sysctl -w net.ipv4.tcp_syncookies=2
+ip netns exec synproxy sysctl -w net.ipv4.tcp_timestamps=1
+ip netns exec synproxy sysctl -w net.netfilter.nf_conntrack_tcp_loose=0
+ip netns exec synproxy iptables -t raw -I PREROUTING \
+	-i tmp1 -p tcp -m tcp --syn --dport "$PORT" -j CT --notrack
+ip netns exec synproxy iptables -t filter -A INPUT \
+	-i tmp1 -p tcp -m tcp --dport "$PORT" -m state --state INVALID,UNTRACKED \
+	-j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460
+ip netns exec synproxy iptables -t filter -A INPUT \
+	-i tmp1 -m state --state INVALID -j DROP
+# When checksum offload is enabled, the XDP program sees wrong checksums and
+# drops packets.
+ethtool -K tmp0 tx off
+# Workaround required for veth.
+ip link set tmp0 xdp object "$DIR/xdp_dummy.o" section xdp 2> /dev/null
+
+SYNACKS="$(ip netns exec synproxy "$DIR/xdp_synproxy" --iface tmp1 \
+	--ports "$PORT" --mss4 1460 --mss6 1440 --wscale 7 --ttl 64 --single | \
+	cut -d: -f2)"
+[ "$SYNACKS" -eq 0 ] || fail
+
+# Different nc implementations accept different parameters.
+{ ip netns exec synproxy nc -l -p "$PORT" || ip netns exec synproxy nc -l "$PORT"; } &
+SERVER_PID="$!"
+sleep 1 # Wait for the server to start.
+
+echo -n > /dev/tcp/198.18.0.2/"$PORT"
+
+SYNACKS="$(ip netns exec synproxy "$DIR/xdp_synproxy" --iface tmp1 --single | \
+	cut -d: -f2)"
+[ "$SYNACKS" -eq 1 ] || fail
+
+echo 'test_xdp_synproxy: ok'
diff --git a/tools/testing/selftests/bpf/xdp_synproxy.c b/tools/testing/selftests/bpf/xdp_synproxy.c
new file mode 100644
index 000000000000..e27e86a82a4f
--- /dev/null
+++ b/tools/testing/selftests/bpf/xdp_synproxy.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <stdnoreturn.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <net/if.h>
+#include <linux/if_link.h>
+#include <linux/limits.h>
+
+static unsigned int ifindex;
+static __u32 attached_prog_id;
+
+static void noreturn cleanup(int sig)
+{
+	DECLARE_LIBBPF_OPTS(bpf_xdp_set_link_opts, opts);
+	int prog_fd;
+	int err;
+
+	if (attached_prog_id == 0)
+		exit(0);
+
+	prog_fd = bpf_prog_get_fd_by_id(attached_prog_id);
+	if (prog_fd < 0) {
+		fprintf(stderr, "Error: bpf_prog_get_fd_by_id: %s\n", strerror(-prog_fd));
+		err = bpf_set_link_xdp_fd(ifindex, -1, 0);
+		if (err < 0) {
+			fprintf(stderr, "Error: bpf_set_link_xdp_fd: %s\n", strerror(-err));
+			fprintf(stderr, "Failed to detach XDP program\n");
+			exit(1);
+		}
+	} else {
+		opts.old_fd = prog_fd;
+		err = bpf_set_link_xdp_fd_opts(ifindex, -1, XDP_FLAGS_REPLACE, &opts);
+		close(prog_fd);
+		if (err < 0) {
+			fprintf(stderr, "Error: bpf_set_link_xdp_fd_opts: %s\n", strerror(-err));
+			// Not an error if already replaced by someone else.
+			if (err != -EEXIST) {
+				fprintf(stderr, "Failed to detach XDP program\n");
+				exit(1);
+			}
+		}
+	}
+	exit(0);
+}
+
+static noreturn void usage(const char *progname)
+{
+	fprintf(stderr, "Usage: %s [--iface <iface>|--prog <prog_id>] [--mss4 <mss ipv4> --mss6 <mss ipv6> --wscale <wscale> --ttl <ttl>] [--ports <port1>,<port2>,...] [--single]\n",
+		progname);
+	exit(1);
+}
+
+static unsigned long parse_arg_ul(const char *progname, const char *arg, unsigned long limit)
+{
+	unsigned long res;
+	char *endptr;
+
+	errno = 0;
+	res = strtoul(arg, &endptr, 10);
+	if (errno != 0 || *endptr != '\0' || arg[0] == '\0' || res > limit)
+		usage(progname);
+
+	return res;
+}
+
+static void parse_options(int argc, char *argv[], unsigned int *ifindex, __u32 *prog_id,
+			  __u64 *tcpipopts, char **ports, bool *single)
+{
+	static struct option long_options[] = {
+		{ "help", no_argument, NULL, 'h' },
+		{ "iface", required_argument, NULL, 'i' },
+		{ "prog", required_argument, NULL, 'x' },
+		{ "mss4", required_argument, NULL, 4 },
+		{ "mss6", required_argument, NULL, 6 },
+		{ "wscale", required_argument, NULL, 'w' },
+		{ "ttl", required_argument, NULL, 't' },
+		{ "ports", required_argument, NULL, 'p' },
+		{ "single", no_argument, NULL, 's' },
+		{ NULL, 0, NULL, 0 },
+	};
+	unsigned long mss4, mss6, wscale, ttl;
+	unsigned int tcpipopts_mask = 0;
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	*ifindex = 0;
+	*prog_id = 0;
+	*tcpipopts = 0;
+	*ports = NULL;
+	*single = false;
+
+	while (true) {
+		int opt;
+
+		opt = getopt_long(argc, argv, "", long_options, NULL);
+		if (opt == -1)
+			break;
+
+		switch (opt) {
+		case 'h':
+			usage(argv[0]);
+			break;
+		case 'i':
+			*ifindex = if_nametoindex(optarg);
+			if (*ifindex == 0)
+				usage(argv[0]);
+			break;
+		case 'x':
+			*prog_id = parse_arg_ul(argv[0], optarg, UINT32_MAX);
+			if (*prog_id == 0)
+				usage(argv[0]);
+			break;
+		case 4:
+			mss4 = parse_arg_ul(argv[0], optarg, UINT16_MAX);
+			tcpipopts_mask |= 1 << 0;
+			break;
+		case 6:
+			mss6 = parse_arg_ul(argv[0], optarg, UINT16_MAX);
+			tcpipopts_mask |= 1 << 1;
+			break;
+		case 'w':
+			wscale = parse_arg_ul(argv[0], optarg, 14);
+			tcpipopts_mask |= 1 << 2;
+			break;
+		case 't':
+			ttl = parse_arg_ul(argv[0], optarg, UINT8_MAX);
+			tcpipopts_mask |= 1 << 3;
+			break;
+		case 'p':
+			*ports = optarg;
+			break;
+		case 's':
+			*single = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+	if (optind < argc)
+		usage(argv[0]);
+
+	if (tcpipopts_mask == 0xf) {
+		if (mss4 == 0 || mss6 == 0 || wscale == 0 || ttl == 0)
+			usage(argv[0]);
+		*tcpipopts = (mss6 << 32) | (ttl << 24) | (wscale << 16) | mss4;
+	} else if (tcpipopts_mask != 0) {
+		usage(argv[0]);
+	}
+
+	if (*ifindex != 0 && *prog_id != 0)
+		usage(argv[0]);
+	if (*ifindex == 0 && *prog_id == 0)
+		usage(argv[0]);
+}
+
+static int syncookie_attach(const char *argv0, unsigned int ifindex)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	char xdp_filename[PATH_MAX];
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	int prog_fd;
+	int err;
+
+	snprintf(xdp_filename, sizeof(xdp_filename), "%s_kern.o", argv0);
+	obj = bpf_object__open_file(xdp_filename, NULL);
+	err = libbpf_get_error(obj);
+	if (err < 0) {
+		fprintf(stderr, "Error: bpf_object__open_file: %s\n", strerror(-err));
+		return err;
+	}
+
+	err = bpf_object__load(obj);
+	if (err < 0) {
+		fprintf(stderr, "Error: bpf_object__open_file: %s\n", strerror(-err));
+		return err;
+	}
+
+	prog = bpf_object__find_program_by_name(obj, "syncookie_xdp");
+	if (!prog) {
+		fprintf(stderr, "Error: bpf_object__find_program_by_name: program syncookie_xdp was not found\n");
+		return -ENOENT;
+	}
+
+	prog_fd = bpf_program__fd(prog);
+
+	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	if (err < 0) {
+		fprintf(stderr, "Error: bpf_obj_get_info_by_fd: %s\n", strerror(-err));
+		goto out;
+	}
+	attached_prog_id = info.id;
+	signal(SIGINT, cleanup);
+	signal(SIGTERM, cleanup);
+	err = bpf_set_link_xdp_fd(ifindex, prog_fd, XDP_FLAGS_UPDATE_IF_NOEXIST);
+	if (err < 0) {
+		fprintf(stderr, "Error: bpf_set_link_xdp_fd: %s\n", strerror(-err));
+		signal(SIGINT, SIG_DFL);
+		signal(SIGTERM, SIG_DFL);
+		attached_prog_id = 0;
+		goto out;
+	}
+	err = 0;
+out:
+	bpf_object__close(obj);
+	return err;
+}
+
+static int syncookie_open_bpf_maps(__u32 prog_id, int *values_map_fd, int *ports_map_fd)
+{
+	struct bpf_prog_info prog_info;
+	__u32 map_ids[8];
+	__u32 info_len;
+	int prog_fd;
+	int err;
+	int i;
+
+	*values_map_fd = -1;
+	*ports_map_fd = -1;
+
+	prog_fd = bpf_prog_get_fd_by_id(prog_id);
+	if (prog_fd < 0) {
+		fprintf(stderr, "Error: bpf_prog_get_fd_by_id: %s\n", strerror(-prog_fd));
+		return prog_fd;
+	}
+
+	prog_info = (struct bpf_prog_info) {
+		.nr_map_ids = 8,
+		.map_ids = (__u64)map_ids,
+	};
+	info_len = sizeof(prog_info);
+
+	err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
+	if (err != 0) {
+		fprintf(stderr, "Error: bpf_obj_get_info_by_fd: %s\n", strerror(-err));
+		goto out;
+	}
+
+	if (prog_info.type != BPF_PROG_TYPE_XDP) {
+		fprintf(stderr, "Error: BPF prog type is not BPF_PROG_TYPE_XDP\n");
+		err = -ENOENT;
+		goto out;
+	}
+	if (prog_info.nr_map_ids < 2) {
+		fprintf(stderr, "Error: Found %u BPF maps, expected at least 2\n",
+			prog_info.nr_map_ids);
+		err = -ENOENT;
+		goto out;
+	}
+
+	for (i = 0; i < prog_info.nr_map_ids; i++) {
+		struct bpf_map_info map_info = {};
+		int map_fd;
+
+		err = bpf_map_get_fd_by_id(map_ids[i]);
+		if (err < 0) {
+			fprintf(stderr, "Error: bpf_map_get_fd_by_id: %s\n", strerror(-err));
+			goto err_close_map_fds;
+		}
+		map_fd = err;
+
+		info_len = sizeof(map_info);
+		err = bpf_obj_get_info_by_fd(map_fd, &map_info, &info_len);
+		if (err != 0) {
+			fprintf(stderr, "Error: bpf_obj_get_info_by_fd: %s\n", strerror(-err));
+			close(map_fd);
+			goto err_close_map_fds;
+		}
+		if (strcmp(map_info.name, "values") == 0) {
+			*values_map_fd = map_fd;
+			continue;
+		}
+		if (strcmp(map_info.name, "allowed_ports") == 0) {
+			*ports_map_fd = map_fd;
+			continue;
+		}
+		close(map_fd);
+	}
+
+	if (*values_map_fd != -1 && *ports_map_fd != -1) {
+		err = 0;
+		goto out;
+	}
+
+	err = -ENOENT;
+
+err_close_map_fds:
+	if (*values_map_fd != -1)
+		close(*values_map_fd);
+	if (*ports_map_fd != -1)
+		close(*ports_map_fd);
+	*values_map_fd = -1;
+	*ports_map_fd = -1;
+
+out:
+	close(prog_fd);
+	return err;
+}
+
+int main(int argc, char *argv[])
+{
+	int values_map_fd, ports_map_fd;
+	__u64 tcpipopts;
+	bool firstiter;
+	__u64 prevcnt;
+	__u32 prog_id;
+	char *ports;
+	bool single;
+	int err = 0;
+
+	parse_options(argc, argv, &ifindex, &prog_id, &tcpipopts, &ports, &single);
+
+	if (prog_id == 0) {
+		err = bpf_get_link_xdp_id(ifindex, &prog_id, 0);
+		if (err < 0) {
+			fprintf(stderr, "Error: bpf_get_link_xdp_id: %s\n", strerror(-err));
+			goto out;
+		}
+		if (prog_id == 0) {
+			err = syncookie_attach(argv[0], ifindex);
+			if (err < 0)
+				goto out;
+			prog_id = attached_prog_id;
+		}
+	}
+
+	err = syncookie_open_bpf_maps(prog_id, &values_map_fd, &ports_map_fd);
+	if (err < 0)
+		goto out;
+
+	if (ports) {
+		__u16 port_last = 0;
+		__u32 port_idx = 0;
+		char *p = ports;
+
+		fprintf(stderr, "Replacing allowed ports\n");
+
+		while (p && *p != '\0') {
+			char *token = strsep(&p, ",");
+			__u16 port;
+
+			port = parse_arg_ul(argv[0], token, UINT16_MAX);
+			err = bpf_map_update_elem(ports_map_fd, &port_idx, &port, BPF_ANY);
+			if (err != 0) {
+				fprintf(stderr, "Error: bpf_map_update_elem: %s\n", strerror(-err));
+				fprintf(stderr, "Failed to add port %u (index %u)\n",
+					port, port_idx);
+				goto out_close_maps;
+			}
+			fprintf(stderr, "Added port %u\n", port);
+			port_idx++;
+		}
+		err = bpf_map_update_elem(ports_map_fd, &port_idx, &port_last, BPF_ANY);
+		if (err != 0) {
+			fprintf(stderr, "Error: bpf_map_update_elem: %s\n", strerror(-err));
+			fprintf(stderr, "Failed to add the terminator value 0 (index %u)\n",
+				port_idx);
+			goto out_close_maps;
+		}
+	}
+
+	if (tcpipopts) {
+		__u32 key = 0;
+
+		fprintf(stderr, "Replacing TCP/IP options\n");
+
+		err = bpf_map_update_elem(values_map_fd, &key, &tcpipopts, BPF_ANY);
+		if (err != 0) {
+			fprintf(stderr, "Error: bpf_map_update_elem: %s\n", strerror(-err));
+			goto out_close_maps;
+		}
+	}
+
+	if ((ports || tcpipopts) && attached_prog_id == 0 && !single)
+		goto out_close_maps;
+
+	prevcnt = 0;
+	firstiter = true;
+	while (true) {
+		__u32 key = 1;
+		__u64 value;
+
+		err = bpf_map_lookup_elem(values_map_fd, &key, &value);
+		if (err != 0) {
+			fprintf(stderr, "Error: bpf_map_lookup_elem: %s\n", strerror(-err));
+			goto out_close_maps;
+		}
+		if (firstiter) {
+			prevcnt = value;
+			firstiter = false;
+		}
+		if (single) {
+			printf("Total SYNACKs generated: %llu\n", value);
+			break;
+		}
+		printf("SYNACKs generated: %llu (total %llu)\n", value - prevcnt, value);
+		prevcnt = value;
+		sleep(1);
+	}
+
+out_close_maps:
+	close(values_map_fd);
+	close(ports_map_fd);
+out:
+	return err == 0 ? 0 : 1;
+}
-- 
2.30.2

