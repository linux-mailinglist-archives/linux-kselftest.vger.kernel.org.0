Return-Path: <linux-kselftest+bounces-18110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA3097BC7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB531C20A41
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4650189914;
	Wed, 18 Sep 2024 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT+sQUXY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AE4409;
	Wed, 18 Sep 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663851; cv=none; b=PZEgG0Gx3JSKKQnlLEqj5RBsqp3Wm7wZFEZ52V3r0qckVSLYHNIAKx7JykrShAphzRygh6HWXV/9t9RPOKEIpRNay2G/p8i2YfDjp+gNd1U/C18qR1DCwK8/gFGyjgfoM2PUalDa0Ze8vpHgLHSdHnOltKXfdAALeNYqNJmTEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663851; c=relaxed/simple;
	bh=uDlnTnvVvMyw7JX1Uoi6GaMOvz/MV/USqCOkq8mWwYk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hFQ4/2Ly3McxvI+jAcxpo3Y73sN7yoTKkoSWcj8cSMbvKq3KIwkB09tEm0/EWgQczxEzWmulut3OhlOQhL8o3gZ2AqiluIimUYDUNeKoLW+XeFkPdfLsgbInUJOLy0oy+T2HlZgcfUdwt1R0iDGOooaliz8wAafqsUwK7fzsu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT+sQUXY; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a99fd5beb6so64217785a.0;
        Wed, 18 Sep 2024 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663849; x=1727268649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35KF7hQs1kikuqDR+kQtANo84u9Pb+3OwPnZM9JJfy0=;
        b=mT+sQUXY9qcU/PBQwf7EB/AcUbdWRwy9bpWiKb6my/au4llF2jqXwfPQT6m5h1iGBv
         +BiCri9DQKcANeNVB740sq+vTlVUdUbnxvf+2gdJWcQKzqchuyY9Tqh3R3NWGp9GSIHp
         kqMrPis/YKNKNIKYRSQZ1JXD16OGiTRgI8EEnhHMx0R2NWi1G/EzOVxIXY9aMv1etjhm
         UW22LfWRRUv+jhiYoSYO10WVuQmL1uzwfjBjdJ8CpbsCq6M2J1tWQHjJ1OOb1ys1MHgj
         rp1RiO9RzrCsJMqpAd3iUki3QpEQER1+tZ0CrtkA7CM+Uyl3JdMazcqiX2yXMjzaLgJW
         NbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663849; x=1727268649;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35KF7hQs1kikuqDR+kQtANo84u9Pb+3OwPnZM9JJfy0=;
        b=RGdob1m6S/7uNVT0v90KLKmiTiJsaGIJ4fzGx3AMBL2XPxTxl5VKh/ABMVmH/WqtII
         qBHjUG49UBDgJ7S8HQgm+Qv/JbXo28peGnDWvYXecsc5XJbPxWSL5TLXW+C8f76zJGMc
         +Mn5cGuEAiyUmui6cztkaaH+21jh710qH5Mlz++55EOL4hqsRgExTTve1AMzje3pbRzZ
         2gRAyBY3Rwk+4/t+SqF2Y3b3ZK/q2NYOEXGoeuNk/w4Ie4bdrBd8ZqyWA2PCG4d7h1gW
         BTqA/3UfgNFsH8aJpDRWaoVsN83AHlD2D+10vNj0sEOPnQpGnJpFOgtZxzGhe/jXlCZi
         WEqg==
X-Forwarded-Encrypted: i=1; AJvYcCUA+mn3ZWCG6JfIw4x5rEHAKmXLLBrZjXKbyV/RTwjKLMEe0/VrYQ9i/ATyNd6Czf8BQYkv4O7H@vger.kernel.org, AJvYcCURV4t6760zrUzKNfETs1UJ/hwI1jlAd3jCKvIiYllOfAN9cvHUXFjvcSH88CKqDOoASNdL1aW/0pnbV9I1@vger.kernel.org, AJvYcCWBNcBYkjDejwwy/qR19R1mOiygCeZntP3ZNsqjovPvYakHcQ+5qBH4nnpjAjxwQOmLRXqCSfP/i5fn@vger.kernel.org, AJvYcCWyhNr8JtugayQcKCMwNjH8pw2giJ+6ZeQDy70HMSgvbEcVx4CrVl/88G8ycigEqmHsQE8GnYIr6fblkRvmDZsP@vger.kernel.org, AJvYcCXQRHHWvuSigvtIIUbZLSLbDcJnHEAnjuHdAqNPH6IxUMkr3sXwyW6rJn9J6wAKfx0V/GA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+xCtL/jQVRsvtpjIxeb0YYqmKVDKSAvPj/45EmOUcwmXT34l
	fzb1frl5H6Ul/L3NiGbGL8NurUIXan2bLEUbl1MFZApqLuo9TPPC
X-Google-Smtp-Source: AGHT+IFwuVhfNggEQ68X+zufvrQX/RDuAO82PihBbAXUSaRarLVHnusDTlqA2rOM/Q0xaUEj6O4NpQ==
X-Received: by 2002:a05:620a:370f:b0:7a9:baa5:f772 with SMTP id af79cd13be357-7a9bf97b89emr5041961085a.19.1726663848806;
        Wed, 18 Sep 2024 05:50:48 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac68742sm48366831cf.10.2024.09.18.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:50:48 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:50:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <66eacca7de803_29b986294ac@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240915-rss-v3-2-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915-rss-v3-2-c630015db082@daynix.com>
Subject: Re: [PATCH RFC v3 2/9] virtio_net: Add functions for hashing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> They are useful to implement VIRTIO_NET_F_RSS and
> VIRTIO_NET_F_HASH_REPORT.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/linux/virtio_net.h | 198 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 6c395a2600e8..7ee2e2f2625a 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -9,6 +9,183 @@
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
>  
> +struct virtio_net_hash {
> +	u32 value;
> +	u16 report;
> +};
> +
> +struct virtio_net_toeplitz_state {
> +	u32 hash;
> +	u32 key_buffer;
> +	const __be32 *key;
> +};
> +
> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
> +					 VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
> +
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
> +
> +static inline void virtio_net_toeplitz(struct virtio_net_toeplitz_state *state,
> +				       const __be32 *input, size_t len)
> +{
> +	u32 key;
> +
> +	while (len) {
> +		state->key++;
> +		key = be32_to_cpu(*state->key);
> +
> +		for (u32 bit = BIT(31); bit; bit >>= 1) {
> +			if (be32_to_cpu(*input) & bit)
> +				state->hash ^= state->key_buffer;
> +
> +			state->key_buffer =
> +				(state->key_buffer << 1) | !!(key & bit);
> +		}
> +
> +		input++;
> +		len--;
> +	}
> +}
> +
> +static inline u8 virtio_net_hash_key_length(u32 types)
> +{
> +	size_t len = 0;
> +
> +	if (types & VIRTIO_NET_HASH_REPORT_IPv4)
> +		len = max(len,
> +			  sizeof(struct flow_dissector_key_ipv4_addrs));
> +
> +	if (types &
> +	    (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4))
> +		len = max(len,
> +			  sizeof(struct flow_dissector_key_ipv4_addrs) +
> +			  sizeof(struct flow_dissector_key_ports));
> +
> +	if (types & VIRTIO_NET_HASH_REPORT_IPv6)
> +		len = max(len,
> +			  sizeof(struct flow_dissector_key_ipv6_addrs));
> +
> +	if (types &
> +	    (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6))
> +		len = max(len,
> +			  sizeof(struct flow_dissector_key_ipv6_addrs) +
> +			  sizeof(struct flow_dissector_key_ports));
> +
> +	return 4 + len;

Avoid raw constants like this 4. What field does it capture?

Instead of working from shortest to longest and using max, how about
the inverse and return as soon as a match is found.

> +}
> +
> +static inline u32 virtio_net_hash_report(u32 types,
> +					 struct flow_dissector_key_basic key)
> +{
> +	switch (key.n_proto) {
> +	case htons(ETH_P_IP):
> +		if (key.ip_proto == IPPROTO_TCP &&
> +		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
> +			return VIRTIO_NET_HASH_REPORT_TCPv4;
> +
> +		if (key.ip_proto == IPPROTO_UDP &&
> +		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
> +			return VIRTIO_NET_HASH_REPORT_UDPv4;
> +
> +		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> +			return VIRTIO_NET_HASH_REPORT_IPv4;
> +
> +		return VIRTIO_NET_HASH_REPORT_NONE;
> +
> +	case htons(ETH_P_IPV6):
> +		if (key.ip_proto == IPPROTO_TCP &&
> +		    (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
> +			return VIRTIO_NET_HASH_REPORT_TCPv6;
> +
> +		if (key.ip_proto == IPPROTO_UDP &&
> +		    (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
> +			return VIRTIO_NET_HASH_REPORT_UDPv6;
> +
> +		if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
> +			return VIRTIO_NET_HASH_REPORT_IPv6;
> +
> +		return VIRTIO_NET_HASH_REPORT_NONE;
> +
> +	default:
> +		return VIRTIO_NET_HASH_REPORT_NONE;
> +	}
> +}
> +
> +static inline bool virtio_net_hash_rss(const struct sk_buff *skb,
> +				       u32 types, const __be32 *key,
> +				       struct virtio_net_hash *hash)
> +{
> +	u16 report;

nit: move below the struct declarations.

> +	struct virtio_net_toeplitz_state toeplitz_state = {
> +		.key_buffer = be32_to_cpu(*key),
> +		.key = key
> +	};
> +	struct flow_keys flow;
> +
> +	if (!skb_flow_dissect_flow_keys(skb, &flow, 0))
> +		return false;
> +
> +	report = virtio_net_hash_report(types, flow.basic);
> +
> +	switch (report) {
> +	case VIRTIO_NET_HASH_REPORT_IPv4:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v4addrs,
> +				    sizeof(flow.addrs.v4addrs) / 4);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_TCPv4:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v4addrs,
> +				    sizeof(flow.addrs.v4addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_UDPv4:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v4addrs,
> +				    sizeof(flow.addrs.v4addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_IPv6:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v6addrs,
> +				    sizeof(flow.addrs.v6addrs) / 4);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_TCPv6:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v6addrs,
> +				    sizeof(flow.addrs.v6addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	case VIRTIO_NET_HASH_REPORT_UDPv6:
> +		virtio_net_toeplitz(&toeplitz_state,
> +				    (__be32 *)&flow.addrs.v6addrs,
> +				    sizeof(flow.addrs.v6addrs) / 4);
> +		virtio_net_toeplitz(&toeplitz_state, &flow.ports.ports,
> +				    1);
> +		break;
> +
> +	default:
> +		return false;
> +	}
> +
> +	hash->value = toeplitz_state.hash;
> +	hash->report = report;
> +
> +	return true;
> +}
> +
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_type)
>  {
>  	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> @@ -239,4 +416,25 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static inline int virtio_net_hdr_v1_hash_from_skb(const struct sk_buff *skb,
> +						  struct virtio_net_hdr_v1_hash *hdr,
> +						  bool has_data_valid,
> +						  int vlan_hlen,
> +						  const struct virtio_net_hash *hash)
> +{
> +	int ret;
> +
> +	memset(hdr, 0, sizeof(*hdr));
> +
> +	ret = virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)hdr,
> +				      true, has_data_valid, vlan_hlen);
> +	if (!ret) {
> +		hdr->hdr.num_buffers = cpu_to_le16(1);
> +		hdr->hash_value = cpu_to_le32(hash->value);
> +		hdr->hash_report = cpu_to_le16(hash->report);
> +	}
> +
> +	return ret;
> +}
> +

I don't think that this helper is very helpful, as all the information
it sets are first passed in. Just set the hdr fields directy in the
caller. It is easier to follow the control flow.


