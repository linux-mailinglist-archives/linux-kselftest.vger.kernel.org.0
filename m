Return-Path: <linux-kselftest+bounces-17993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC504979404
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 03:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15D91C2187B
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341481B85FD;
	Sun, 15 Sep 2024 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="lfN7P43s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DD1B85F6
	for <linux-kselftest@vger.kernel.org>; Sun, 15 Sep 2024 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726363118; cv=none; b=ZN1Cq19QGWQ4qeZFqb5kfjlHawbykf+vhzQvI+Hp8XRV92tYbJUNh6JdhJ8Kz/Q99jN4BvEvy9NasJmm3E3vr1AHYlp+rH/4Q4BPCjfQJRtBAPpL/d+9h705eeO01dToGa4jEquU2oCeuIQoXi8xLc3fWbVlPoZlHGFx8O/JVZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726363118; c=relaxed/simple;
	bh=kdVV3nDNT5v+ptxE3cRwUYyMsKrhhxcLbh1wXZFYmsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Df4lK1JdAJgvzpyCOfKwvGBBf6wCyN3Trp4/R0Ln+XKrK7eIjZ7l1Aevxogo+8AJspWKuOmhPVwAoDKOnTo0GDtDt/nJje7TdO/bqvezg+PLrd8Svgs8pKKw61YVXVW+NFz5Fbs304CjaUUdeNTym5EzPHr1YwkXzSwtIfT4EuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=lfN7P43s; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so3155626a91.1
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Sep 2024 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363116; x=1726967916; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9RDpJor6M9oo/9F2GZqBqcJrSNYhytOgFsyeiDb1NE=;
        b=lfN7P43s0uykahKYJB8m9eRjRO4IIuewpdKRRLT4eHMXHr2XAvmu8BB6KaJMPOTjn1
         wNsgTjJ1Fc4xVRDcEptsg1+hF2DGaZvternn9Wi0W+lC2k3zmGJXUb57SLvyIrlnBLAJ
         sujQB5z3d9+vbXR8wWOBTIisIfwp8ifzSuKQI4CBKMHBK4YYFVCPB/w3GHKRSjPePHmw
         AC7e4l2ce5TA3QVtK0tPJKLoMymVKuYCDMCKdTTOe/wYkGV9oeAAcRlwW2QVVCl2+4XA
         mxINEu69jb8c3pDuQOQ1QjPv+hjCcpyZ6qdLwbTPdjSgbJpbA6DjorWQXISj9aTwr7DK
         9k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726363116; x=1726967916;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9RDpJor6M9oo/9F2GZqBqcJrSNYhytOgFsyeiDb1NE=;
        b=iebzhCUaM+/AKICu7khOwUMEr74N3pioCG5PJZzuyXRFcIKFLQ+sMAVAvbbTJOsG+c
         ysqwtLKJP79ySjvVKvTp7szr4d7oZfhEIR6oU6q2gqJ6Gh9NdFmQDRqT1DSIkbkuA+P9
         ZjQa86Sgh75OOYl2jFHw9o5VkBtZPvW7VzeQiPpF0yBFIz2TRqoIvXB4erOxx/xDpcqj
         fd5eok0bjwlnXwVjOh/usuHNP6tZLxliQHuM6L9zd5Py52LiYdw2L7hifxaHsl23GiRi
         olSmNoxkaVwVoAZp3z+TxWIr/8mClR3UmH7nKXJDEQDMO68/oOvVLeBCTBGdfOq35NBv
         QPng==
X-Forwarded-Encrypted: i=1; AJvYcCVirV143BnvvJKm1yyPNScw6GrGj4m+Mv+qtXa5WZYzoXMjPe3EMsmcb07v+Y7PNybHzdsijl1zw9l9Jwne3Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJK5GIN4Ff/0vLSeK4bxXOXSRwDYgofQNxXjGa0pJI6lmBJFj
	cyUmu1v64luaP6DNTc82kSyBEPNR1wUXvwKNhvRjEQDOCyRCKi7hwn6OvZR2CtA=
X-Google-Smtp-Source: AGHT+IGgXau1gQB1kNbl5uh5JvAFFOilnxwwQRJvrOxybRStwe4qO1aFoNnRjyIm2xo1LYEsGJGWPQ==
X-Received: by 2002:a17:90b:88f:b0:2d8:73ba:9444 with SMTP id 98e67ed59e1d1-2db9fc54271mr17194832a91.5.1726363116022;
        Sat, 14 Sep 2024 18:18:36 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2dbcfcfd015sm2244144a91.17.2024.09.14.18.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 18:18:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:17:41 +0900
Subject: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-rss-v3-2-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

They are useful to implement VIRTIO_NET_F_RSS and
VIRTIO_NET_F_HASH_REPORT.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/virtio_net.h | 198 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 6c395a2600e8..7ee2e2f2625a 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -9,6 +9,183 @@
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
+struct virtio_net_hash {
+	u32 value;
+	u16 report;
+};
+
+struct virtio_net_toeplitz_state {
+	u32 hash;
+	u32 key_buffer;
+	const __be32 *key;
+};
+
+#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
+					 VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
+
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
+
+static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
+				       const __be32 *input, size_t len)
+{
+	u32 key;
+
+	while (len) {
+		state->key++;
+		key = be32_to_cpu(*state->key);
+
+		for (u32 bit = BIT(31); bit; bit >>= 1) {
+			if (be32_to_cpu(*input) & bit)
+				state->hash ^= state->key_buffer;
+
+			state->key_buffer =
+				(state->key_buffer << 1) | !!(key & bit);
+		}
+
+		input++;
+		len--;
+	}
+}
+
+static inline u8 virtio_net_hash_key_length(u32 types)
+{
+	size_t len = 0;
+
+	if (types & VIRTIO_NET_HASH_REPORT_IPv4)
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv4_addrs));
+
+	if (types &
+	    (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv4_addrs) +
+			  sizeof(struct flow_dissector_key_ports));
+
+	if (types & VIRTIO_NET_HASH_REPORT_IPv6)
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv6_addrs));
+
+	if (types &
+	    (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
+		len = max(len,
+			  sizeof(struct flow_dissector_key_ipv6_addrs) +
+			  sizeof(struct flow_dissector_key_ports));
+
+	return 4 + len;
+}
+
+static inline u32 virtio_net_hash_report(u32 types,
+					 struct flow_dissector_key_basic key)
+{
+	switch (key.n_proto) {
+	case htons(ETH_P_IP):
+		if (key.ip_proto == IPPROTO_TCP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
+			return VIRTIO_NET_HASH_REPORT_TCPv4;
+
+		if (key.ip_proto == IPPROTO_UDP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
+			return VIRTIO_NET_HASH_REPORT_UDPv4;
+
+		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
+			return VIRTIO_NET_HASH_REPORT_IPv4;
+
+		return VIRTIO_NET_HASH_REPORT_NONE;
+
+	case htons(ETH_P_IPV6):
+		if (key.ip_proto == IPPROTO_TCP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
+			return VIRTIO_NET_HASH_REPORT_TCPv6;
+
+		if (key.ip_proto == IPPROTO_UDP &&
+		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
+			return VIRTIO_NET_HASH_REPORT_UDPv6;
+
+		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
+			return VIRTIO_NET_HASH_REPORT_IPv6;
+
+		return VIRTIO_NET_HASH_REPORT_NONE;
+
+	default:
+		return VIRTIO_NET_HASH_REPORT_NONE;
+	}
+}
+
+static inline bool virtio_net_hash_rss(const struct sk_buff *skb,
+				       u32 types, const __be32 *key,
+				       struct virtio_net_hash *hash)
+{
+	u16 report;
+	struct virtio_net_toeplitz_state toeplitz_state = {
+		.key_buffer = be32_to_cpu(*key),
+		.key = key
+	};
+	struct flow_keys flow;
+
+	if (!skb_flow_dissect_flow_keys(skb, &flow, 0))
+		return false;
+
+	report = virtio_net_hash_report(types, flow.basic);
+
+	switch (report) {
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v4addrs,
+				    sizeof(flow.addrs.v4addrs) / 4);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v4addrs,
+				    sizeof(flow.addrs.v4addrs) / 4);
+		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+				    1);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v4addrs,
+				    sizeof(flow.addrs.v4addrs) / 4);
+		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+				    1);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v6addrs,
+				    sizeof(flow.addrs.v6addrs) / 4);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v6addrs,
+				    sizeof(flow.addrs.v6addrs) / 4);
+		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+				    1);
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+		virtio_net_toeplitz(&toeplitz_state,
+				    (__be32 *)&flow.addrs.v6addrs,
+				    sizeof(flow.addrs.v6addrs) / 4);
+		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
+				    1);
+		break;
+
+	default:
+		return false;
+	}
+
+	hash->value = toeplitz_state.hash;
+	hash->report = report;
+
+	return true;
+}
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -239,4 +416,25 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	return 0;
 }
 
+static inline int virtio_net_hdr_v1_hash_from_skb(const struct sk_buff *skb,
+						  struct virtio_net_hdr_v1_hash *hdr,
+						  bool has_data_valid,
+						  int vlan_hlen,
+						  const struct virtio_net_hash *hash)
+{
+	int ret;
+
+	memset(hdr, 0, sizeof(*hdr));
+
+	ret = virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
+				      true, has_data_valid, vlan_hlen);
+	if (!ret) {
+		hdr->hdr.num_buffers = cpu_to_le16(1);
+		hdr->hash_value = cpu_to_le32(hash->value);
+		hdr->hash_report = cpu_to_le16(hash->report);
+	}
+
+	return ret;
+}
+
 #endif /* _LINUX_VIRTIO_NET_H */

-- 
2.46.0


