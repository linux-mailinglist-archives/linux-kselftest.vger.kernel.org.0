Return-Path: <linux-kselftest+bounces-27834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E1A4929C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C79B3B7C98
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD8A1DE3AC;
	Fri, 28 Feb 2025 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="LLGd/1b4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1251D618A
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729548; cv=none; b=hx0tBRQfh/6R8a3AkzbXSv8dBwUn/sfOCK5SAnN5rjtdrlTSrvT09h4SN/MG3oYXDyNz0YuYWQckEYVyT6hRY4nL4eXbIP4QrSkgzSF4Mi1er0PcundYUc+uTAomVYi+CmuP3x/sN9P0nk8JRUHvQ3txBXhXAoQAsSZHSqc9VsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729548; c=relaxed/simple;
	bh=9YjLGgOgxjd7KI1w2ki+88OGAWpCNcVzyGfWquchPGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=Aom/GRxoWfDpXw0NXvZhSATs+81eEIzMHTFKaEGbcFaFQ/xPIlX9CueLquTHamHAHABQpoUPRZLRgyhSTeKE5arNUEyO82ZGLToruQbcn87FGlg91FWWoY90drDhq6IrlSaJnxSKj6HggtlqcDhzBtOvK+da6gmRcdxdnF/ZAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=LLGd/1b4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2211cd4463cso34899035ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2025 23:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740729546; x=1741334346; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/qC0mfXfemQxtgPVvB5yWxcCoCf7wtW10EiI7eK4rY=;
        b=LLGd/1b4J9e4rManhKFvZWbYz35lmXm5B8/zJ0dap34sVWV74mA0vWpm3JEIBssRyF
         2DE66JUdaglylRMcVPJxpB/sOkSFwXx8YY9DFshINZ2SUeG/RJEBpIs/5ZEiwcEqmaFW
         epN0oFbsDMmppAdnnQCoKFS6dYo4HGcAubgEdNGpyov1sNL61TWjapPXex1zEGdF7RH9
         fIrqRp04UbTT7Bfv/3vyPkspHi6nUnUYvXm39JB28NP++FqUSVk4OPJf/HPJysGkigvf
         sjQn1YXWynuttmjcCgtefvnORzcowYg0jZKE92jAyjQPBq7chezZj67ab+ZHX5XanuLU
         ZZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729546; x=1741334346;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/qC0mfXfemQxtgPVvB5yWxcCoCf7wtW10EiI7eK4rY=;
        b=sKLy0Y0t+Ep1VoyVhB8+5JbeVqHR8InSXQRpOnoDU15HAZjw/SwG7yspBHGzM5TngL
         uvbcS7Z9CFCYFxxI+knG0dgpRZUnfCs5YpnlcdpwyxNAsSVHcR7wdrl+a00bgvnxWNqM
         knFm/XeVMkVWAcHEmjt6SuanJ8kUHHrZQz2TuvI50AjNjFnWPny/h3hiijHJ/++8K/xv
         bzcpZ2tUPwcxXMrtMAKOoCwkMo0SXzIx3XcUaw77uVbEgMti0CHQiolxewItbvfxeo0K
         VJYmPCVruC8Sb1D7ci4CBzMSyuonEfCT4XW+f/rP6DlN4bwitEPtzJXs8w4ffUpDHXqk
         W29w==
X-Forwarded-Encrypted: i=1; AJvYcCXP+QaP6Q9Ngyiporm1LSz5bZt7UZ6w01JJ/2ZgQ3hSjv5bvHlSz5GvjfM+97TeYbAikJOeIETOkPnKwYxNDJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeopQUJN4A9MdRHjt3SXM2Tj1PmIBwonduG5w7IerAyuj9xjBP
	8FOczVMnR1qzVVZxexShqa9SKEpYqDVDJvVS4kM789qIQl3z7t2MzIK28rSUqoQ=
X-Gm-Gg: ASbGncsKZcvv7RADt5hZ7iID3hfo4v+JepjicuHVM10qZQADDuXFLtX8penR0XmmZAn
	353SXjCO5feMJMXstjk4f5SAl+6cM2tL2hloRa3GNovJinvqeNx4M28QPYnCIF2O+wZKB+6XcCv
	SBgi2WOfRbk64tX1HzeFW5FPojiECZOyMtyFRXxtMSG+VAOwZaqXqlGHuPRpTeUKjRktthWqpYK
	6+zznd5IXja63BqS2Y+siDvsi/wxxd75UK4npsso8cgivJJsWAUnc+lc6Urr22po2VRlOTCtp5k
	11OtLC6j8TZ8svfu8s+BhQpu5QM5ag==
X-Google-Smtp-Source: AGHT+IF1Xg+68dSCJKnZOpLjf5U8ezLtmxq9887nRnMHK8BWszc4/AKMNeey5X8hDppZM/bzXADEWQ==
X-Received: by 2002:a05:6a21:3289:b0:1f0:e736:a92f with SMTP id adf61e73a8af0-1f2f4e17c94mr4095422637.31.1740729546642;
        Thu, 27 Feb 2025 23:59:06 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7349fe2a65asm3108342b3a.28.2025.02.27.23.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 23:59:06 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 28 Feb 2025 16:58:47 +0900
Subject: [PATCH net-next v7 1/6] virtio_net: Add functions for hashing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-rss-v7-1-844205cbbdd6@daynix.com>
References: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
In-Reply-To: <20250228-rss-v7-0-844205cbbdd6@daynix.com>
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
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 Lei Yang <leiyang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

They are useful to implement VIRTIO_NET_F_RSS and
VIRTIO_NET_F_HASH_REPORT.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 02a9f4dc594d02372a6c1850cd600eff9d000d8d..426f33b4b82440d61b2af9fdc4c0b0d4c571b2c5 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -9,6 +9,194 @@
 #include <uapi/linux/tcp.h>
 #include <uapi/linux/virtio_net.h>
 
+struct virtio_net_hash {
+	u32 value;
+	u16 report;
+};
+
+struct virtio_net_toeplitz_state {
+	u32 hash;
+	const u32 *key;
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
+static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
+{
+	while (len >= sizeof(*input)) {
+		*input = be32_to_cpu((__force __be32)*input);
+		input++;
+		len -= sizeof(*input);
+	}
+}
+
+static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
+					    const __be32 *input, size_t len)
+{
+	while (len >= sizeof(*input)) {
+		for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
+			u32 i = ffs(map);
+
+			state->hash ^= state->key[0] << (32 - i) |
+				       (u32)((u64)state->key[1] >> i);
+		}
+
+		state->key++;
+		input++;
+		len -= sizeof(*input);
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
+	return len + sizeof(u32);
+}
+
+static inline u32 virtio_net_hash_report(u32 types,
+					 const struct flow_keys_basic *keys)
+{
+	switch (keys->basic.n_proto) {
+	case cpu_to_be16(ETH_P_IP):
+		if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
+			if (keys->basic.ip_proto == IPPROTO_TCP &&
+			    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
+				return VIRTIO_NET_HASH_REPORT_TCPv4;
+
+			if (keys->basic.ip_proto == IPPROTO_UDP &&
+			    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
+				return VIRTIO_NET_HASH_REPORT_UDPv4;
+		}
+
+		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
+			return VIRTIO_NET_HASH_REPORT_IPv4;
+
+		return VIRTIO_NET_HASH_REPORT_NONE;
+
+	case cpu_to_be16(ETH_P_IPV6):
+		if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
+			if (keys->basic.ip_proto == IPPROTO_TCP &&
+			    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
+				return VIRTIO_NET_HASH_REPORT_TCPv6;
+
+			if (keys->basic.ip_proto == IPPROTO_UDP &&
+			    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
+				return VIRTIO_NET_HASH_REPORT_UDPv6;
+		}
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
+static inline void virtio_net_hash_rss(const struct sk_buff *skb,
+				       u32 types, const u32 *key,
+				       struct virtio_net_hash *hash)
+{
+	struct virtio_net_toeplitz_state toeplitz_state = { .key = key };
+	struct flow_keys flow;
+	struct flow_keys_basic flow_basic;
+	u16 report;
+
+	if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
+		hash->report = VIRTIO_NET_HASH_REPORT_NONE;
+		return;
+	}
+
+	flow_basic = (struct flow_keys_basic) {
+		.control = flow.control,
+		.basic = flow.basic
+	};
+
+	report = virtio_net_hash_report(types, &flow_basic);
+
+	switch (report) {
+	case VIRTIO_NET_HASH_REPORT_IPv4:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v4addrs,
+					 sizeof(flow.addrs.v4addrs));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv4:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v4addrs,
+					 sizeof(flow.addrs.v4addrs));
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
+					 sizeof(flow.ports.ports));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv4:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v4addrs,
+					 sizeof(flow.addrs.v4addrs));
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
+					 sizeof(flow.ports.ports));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_IPv6:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v6addrs,
+					 sizeof(flow.addrs.v6addrs));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_TCPv6:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v6addrs,
+					 sizeof(flow.addrs.v6addrs));
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
+					 sizeof(flow.ports.ports));
+		break;
+
+	case VIRTIO_NET_HASH_REPORT_UDPv6:
+		virtio_net_toeplitz_calc(&toeplitz_state,
+					 (__be32 *)&flow.addrs.v6addrs,
+					 sizeof(flow.addrs.v6addrs));
+		virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.ports,
+					 sizeof(flow.ports.ports));
+		break;
+
+	default:
+		hash->report = VIRTIO_NET_HASH_REPORT_NONE;
+		return;
+	}
+
+	hash->value = toeplitz_state.hash;
+	hash->report = report;
+}
+
 static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
 {
 	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {

-- 
2.48.1


