Return-Path: <linux-kselftest+bounces-2516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B2A81FE0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 09:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D703284F0E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107163D4;
	Fri, 29 Dec 2023 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrxYgknz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA488C0B;
	Fri, 29 Dec 2023 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f68.google.com with SMTP id ca18e2360f4ac-7b7a9f90f34so356809439f.2;
        Fri, 29 Dec 2023 00:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703837742; x=1704442542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRKpjjF2wASf7zuvz4OLlsLBW9kYE9UYNr5ZMf7ZVP4=;
        b=SrxYgknzeg030XPbHGiXMD0OCwxESwMb6rabjMMz0keJejlajSCy2gnfdPgyMK3AgL
         IHwJ0pCJoOsYVpBALdPsCqYBZHqCkdas5s/29Zc+wZeqBPxJ2LsxS255FeTguoP54syW
         J8s/jQym4Ogu6w6bl+1bXVvBolcXZxj0MLsX8PKBChQVidYto8xLjSKagfRuvcFmdyix
         dr+JmzOo/otQyn1bZirb9L0VgbYCaDvKYoReer0yimcFWvXdaKJ//2JktdZaaHDHwCd+
         6bKqZl+U7F+Mvp5tOhCuiA0yRaM3+uKr4eJcrfZyYHjAyIf034Xkll/gtUULK7vUr9zY
         tsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703837742; x=1704442542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRKpjjF2wASf7zuvz4OLlsLBW9kYE9UYNr5ZMf7ZVP4=;
        b=ORbtF5RFAznFNWBRR10A2yKlG4J3brdh2ufp6CUrA/pJr0P/TD046sd2SddFhRczuj
         OUMcGw2Ku05Chxt2tpj/e9RJPBpnwmkmC0q3DTflsivZgspQbQ6H0QaZi9LH10861IsL
         0hQPDGPPUe/6LAKU8S27ehhUB/MmrEngDqGhgS4hgiLax+jBWNXG4UFznO41MoxqnUVx
         f1LV5x2z+/qYl7MXJLD2Ro6bQg6vxHUUUEkqSZ2cf+2xf5/qT+fMKlokpYm6s6G1OfBz
         E5qCj+GmX/PDb+infFjY/CuKyZKhwVIQJLbXaK5IePB88q9OI6pFlYdoCOdXa+VjVSfi
         cg+w==
X-Gm-Message-State: AOJu0Yy8Y2GS6GsUei6ED+fwn/J1P4W9hDiO+PN4l6QsfBeQR5e+oQS/
	QBbitImFQUddRgC78NYPOR0=
X-Google-Smtp-Source: AGHT+IGSOQt2GEO0teot2bcXxAwjwl0XPY/nwKOUrXKic73AZJ/oZxtEOjD1qv7N5CN4l9HmBYPtGw==
X-Received: by 2002:a05:6e02:338f:b0:35d:5550:76ba with SMTP id bn15-20020a056e02338f00b0035d555076bamr10868888ilb.14.1703837741995;
        Fri, 29 Dec 2023 00:15:41 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id h12-20020a63df4c000000b005bd2b3a03eesm14339412pgj.6.2023.12.29.00.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 00:15:41 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	horms@kernel.org,
	dhowells@redhat.com,
	linyunsheng@huawei.com,
	aleksander.lobakin@intel.com,
	joannelkoong@gmail.com,
	laoar.shao@gmail.com,
	kuifeng@meta.com,
	menglong8.dong@gmail.com,
	bjorn@rivosinc.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: add csum/ip_summed fields to __sk_buff
Date: Fri, 29 Dec 2023 16:14:08 +0800
Message-Id: <20231229081409.1276386-2-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231229081409.1276386-1-menglong8.dong@gmail.com>
References: <20231229081409.1276386-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we have to call some helpers when we need to update the csum,
such as bpf_l4_csum_replace, bpf_l3_csum_replace, etc. These helpers are
not inlined, which causes poor performance.

In fact, we can define our own csum update functions in BPF program
instead of bpf_l3_csum_replace, which is totally inlined and efficient.
However, we can't do this for bpf_l4_csum_replace for now, as we can't
update skb->csum, which can make skb->csum invalid in the rx path with
CHECKSUM_COMPLETE mode.

What's more, we can't use the direct data access and have to use
skb_store_bytes() with the BPF_F_RECOMPUTE_CSUM flag in some case, such
as modifing the vni in the vxlan header and the underlay udp header has
no checksum.

With the read/write accessing to skb->csum and read accessing to
skb->ip_summed, now we can define the inlined csum update functions in
libbpf, which are much more efficient.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
 include/linux/skbuff.h         |  2 ++
 include/uapi/linux/bpf.h       |  2 ++
 net/core/filter.c              | 22 ++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ea5c8ab3ed00..a0ec404c7009 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1077,8 +1077,10 @@ struct sk_buff {
 /* if you move pkt_type around you also must adapt those constants */
 #ifdef __BIG_ENDIAN_BITFIELD
 #define PKT_TYPE_MAX	(7 << 5)
+#define IP_SUMMED_RSH	1
 #else
 #define PKT_TYPE_MAX	7
+#define IP_SUMMED_RSH	5
 #endif
 #define PKT_TYPE_OFFSET		offsetof(struct sk_buff, __pkt_type_offset)
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 754e68ca8744..b450e27f5a8d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6148,6 +6148,8 @@ struct __sk_buff {
 	__u8  tstamp_type;
 	__u32 :24;		/* Padding, future use. */
 	__u64 hwtstamp;
+	__u32 csum;
+	__u32 ip_summed;
 };
 
 struct bpf_tunnel_key {
diff --git a/net/core/filter.c b/net/core/filter.c
index 24061f29c9dd..23c22d88da1b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8858,6 +8858,7 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 		case bpf_ctx_range_till(struct __sk_buff, cb[0], cb[4]):
 		case bpf_ctx_range(struct __sk_buff, tstamp):
 		case bpf_ctx_range(struct __sk_buff, queue_mapping):
+		case bpf_ctx_range(struct __sk_buff, csum):
 			break;
 		default:
 			return false;
@@ -8885,6 +8886,8 @@ static bool tc_cls_act_is_valid_access(int off, int size,
 		 */
 		((struct bpf_prog *)prog)->tstamp_type_access = 1;
 		return size == sizeof(__u8);
+	case bpf_ctx_range_till(struct __sk_buff, csum, ip_summed):
+		return size == sizeof(__u32);
 	}
 
 	return bpf_skb_is_valid_access(off, size, type, prog, info);
@@ -9513,6 +9516,25 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 #endif
 		break;
 
+	case offsetof(struct __sk_buff, ip_summed):
+		*target_size = 1;
+		*insn++ = BPF_LDX_MEM(BPF_B, si->dst_reg, si->src_reg,
+				      PKT_TYPE_OFFSET);
+		*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, IP_SUMMED_RSH);
+		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, 3);
+		break;
+
+	case offsetof(struct __sk_buff, csum):
+		if (type == BPF_WRITE)
+			*insn++ = BPF_EMIT_STORE(BPF_W, si,
+						 bpf_target_off(struct sk_buff, csum, 4,
+								target_size));
+		else
+			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
+					      bpf_target_off(struct sk_buff, csum, 4,
+							     target_size));
+		break;
+
 	case offsetof(struct __sk_buff, queue_mapping):
 		if (type == BPF_WRITE) {
 			u32 off = bpf_target_off(struct sk_buff, queue_mapping, 2, target_size);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f24d898efbb..31fd5ee40864 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6148,6 +6148,8 @@ struct __sk_buff {
 	__u8  tstamp_type;
 	__u32 :24;		/* Padding, future use. */
 	__u64 hwtstamp;
+	__u32 csum;
+	__u32 ip_summed;
 };
 
 struct bpf_tunnel_key {
-- 
2.39.2


