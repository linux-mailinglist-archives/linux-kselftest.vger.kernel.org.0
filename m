Return-Path: <linux-kselftest+bounces-24134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3812FA078DD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 15:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A47A4470
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 14:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64CD219E9E;
	Thu,  9 Jan 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiSBNNlb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F27217658;
	Thu,  9 Jan 2025 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432017; cv=none; b=JfeA05p4RQ4XQ5+oq4d24RyuCGS19SQKqa5uhFteUHN4qw7I4DV43egdAU1LT7FytDJLJUYU6QNUTPO3dA89EHhD34hS8edt+JiZPauf8rK+BExMZm9FA3Io9ayfmx2TIf72Gf0C0D/6lLFRANyE6pHrueYXVs9hjjgAZvLCbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432017; c=relaxed/simple;
	bh=zyy3moZDkbBG+czu1d7X5YD5pi5vZzi9VgokJOCwylk=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Xj2FeSqkUS9dTn6uP1D8jxAm1NDWOIfjyoi7mHp+p5BYtRImK5wkgdVsyaIepTyEyIXSONjpYPUdrOLfVBHZZm7+iwEnVdEhFNYeOZbU/OuBe8RW53WDGIQF7uraOf1Bu1Ujoc7HJmTUs0EXMh8/cfB9Ei9R9aKV8PfHGE674hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiSBNNlb; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d92cd1e811so16470446d6.1;
        Thu, 09 Jan 2025 06:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736432015; x=1737036815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBEhWD1K9TGnwPZW+7/5J69P4pRtuGWs9a6RJnwPAas=;
        b=IiSBNNlbDMaxrQ5GfGfaBYxWhlYMYPFbZroXTqdt2pXhif7h+vW8yvZQZtpiUFujwc
         VBXI7kNHVTPK59gpssxAtaf0an+yKGmhn0YcpbC5V1mF0qjcTJRi+sWHqZUmECUSOK39
         0HG/5zwOsDw375R/q9cHG6GCfqSSNHeOz46jVLRz4doMa7hlrNi5yHIvZ59zhgvxTTZ6
         3TZYSGOOUjWyEbmGJUwm2paXWdar1obip+tWzNqd0GNQq3bSSFpOtD90gsuG1nZrzyvp
         OXvdOgOUFVWicMLw0YxpDZDj+OEnh6+odGx3SD/Ji8I5jDRX4AyRaCtp98c12qujvJBU
         ZKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736432015; x=1737036815;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBEhWD1K9TGnwPZW+7/5J69P4pRtuGWs9a6RJnwPAas=;
        b=uZILmL+fV2xuN+nJeKSqwijAcKhwPWIBiEMvk15voB/itut+IjNZ7fu2P0J1FgHE24
         1dX/rzTxinkkp+22I95Am3WCJGRTzSoDcSOv+VxEIwiDhYXv1HfN66opYjCvb/n+OxII
         WjBj1VSTr+Qx8G6TiJUyd+DWlgdoDwCr9jTSRhoSWmJbx1rqHoQH9XTas7OvdkmNfE3n
         mHrgr9kOuxyb14XKBvy5JRyYrqw3sB9QcNtsnUVET0r5RI80Ll//WPqhOXuc+nI1AdQ/
         BLDRMwIj1/NJUJg3Qn0lGU5d5ucKA+jvKWk02BXYayuonH31IyDTkCrVmo/J5mHHUAqu
         Y3HA==
X-Forwarded-Encrypted: i=1; AJvYcCV+SrpUtFPrTF4YAfgXP4lWDFTSLGY+7xam9v/8UUZ0yRG+WKuulRBtC7hiFNopq99pdD8atd3Oj9MI@vger.kernel.org, AJvYcCVTyaQOaoaI2hNpKAgUvX7T9ngwC11oalzW2Su/Z5rKuc0jNupt+w3SvQRGVm/9Df5L7iIs30Oy/++/ZpL6@vger.kernel.org, AJvYcCVyZ69HTXgPYLaQdNEOoQ65G+Qs3yJLFyd0YCBPJ45XEnkKFkI9+ydfqjAa9zWX5QLXjXp2+AuL5huuLUK2TK8D@vger.kernel.org, AJvYcCVzQqwtUMnl+oOGsQsDMFnLnhFbHbEzzaxSASjnulqvwEPYQMxoEv5iubxeugrh1JgHke6DOn1W@vger.kernel.org, AJvYcCXzeRus+F6fSZeHD7OwnIqjPxG4MKZOwNAXE/EuCmVXb35gHelc3iZN/lWp0smiKhUtdIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+7BhxVZscWnF9zelcjwoUtc99W8UtLZAA5/9DQoJC5BJ/n5p
	GI7+X+m0BhWT2V4pWomT7X0hpjwGuNAxxJPdI/KRexDnLqmrmdPI
X-Gm-Gg: ASbGncvtwS/2mWZLPrnBBHJtlGuSFsiiIaruHjC3lSMdwVRzE+J1J9qgijiiaT68ECw
	bgG0VVFuQKkQjacvuohreyKoM63vWWXkyrHFdEzCtn4QtFHUMkX+EROlLsfzFOzmCKqTNv//ZA8
	VqhAmKBLXzoqU17rLkVhgYk3d9AOiRFeYsYp1cMpXorOrCByEr5Dym6dF8/y81PzkUToe5ZXMjF
	Q31YCcMH+Vk42O1/nwHxjRFL+nyRHK2TxLJmwJFNY6wEqt+n7KdNVdW4pzz5hUdKpLoCIWwt5yk
	+GNv8a8fCvRlxr5sIGg0C4E+nOMo
X-Google-Smtp-Source: AGHT+IHIdNIzp5p1G8XahHluwZvKPdRIT1LWx03OX6jYqP63ZJjh8hSiwgfOtm/xBp8p/l0BBmw0eA==
X-Received: by 2002:ad4:5964:0:b0:6d8:94f4:d2a8 with SMTP id 6a1803df08f44-6dfa3a77ca6mr51443876d6.9.1736432015072;
        Thu, 09 Jan 2025 06:13:35 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd32b2be9esm179389276d6.34.2025.01.09.06.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:13:34 -0800 (PST)
Date: Thu, 09 Jan 2025 09:13:33 -0500
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
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <677fd98d89df1_362bc12942f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-rss-v6-1-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
 <20250109-rss-v6-1-b1c90ad708f6@daynix.com>
Subject: Re: [PATCH v6 1/6] virtio_net: Add functions for hashing
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

Toeplitz potentially has users beyond virtio. I wonder if we should
from the start implement this as net/core/rss.c.

 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 188 insertions(+)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d..3b25ca75710b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -9,6 +9,194 @@
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
> +	const u32 *key;
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
> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t len)
> +{
> +	while (len >= sizeof(*input)) {
> +		*input = be32_to_cpu((__force __be32)*input);
> +		input++;
> +		len -= sizeof(*input);
> +	}
> +}
> +
> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_state *state,
> +					    const __be32 *input, size_t len)
> +{
> +	while (len >= sizeof(*input)) {
> +		for (u32 map = be32_to_cpu(*input); map; map &= (map - 1)) {
> +			u32 i = ffs(map);
> +
> +			state->hash ^= state->key[0] << (32 - i) |
> +				       (u32)((u64)state->key[1] >> i);
> +		}
> +
> +		state->key++;
> +		input++;
> +		len -= sizeof(*input);
> +	}
> +}

Have you verified that this algorithm matches a known toeplitz
implementation. And computes the expected values for the test
inputs in

https://learn.microsoft.com/en-us/windows-hardware/drivers/network/verifying-the-rss-hash-calculation

We have a toeplitz implementation in
tools/testing/selftests/net/toeplitz.c that can also be used as
reference.

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
> +	return len + 4;

Avoid magic constants. Please use sizeof or something else to signal
what this 4 derives from.

