Return-Path: <linux-kselftest+bounces-22112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210849CF0BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 16:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83D328C227
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1111CEE91;
	Fri, 15 Nov 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG/5zjYK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC541CDA26;
	Fri, 15 Nov 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686048; cv=none; b=Tjs/NRZDSMPqIBJdLnFhBrKrovYEAGHkpQV9VTHXm27WztFko3uCXqytMir44qmStQzesziDfFvAhs/NmtfTunsws2bsBQxH2fohW2PGxH/ri7V5bwZMEVURetKLBRA1MvpbarcHCVdrbZR8st+JM5zow/5evOhub/IfsLZvsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686048; c=relaxed/simple;
	bh=c1l4GXR1ccW/xD+32IV2+ugVHn5Gyxka4/K2klNuZJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG/8dpUl9LskFCeuBPcGSyJByMwbXbZ8moFspx8AY3yoeDJgo4sv6MM4fr9Pw3hS3y1nO1C1Zv9rDOS0GP9SFcPObFL0A+IGXv8zc9ENoyk4uFZMr+SuVYVpEj+yhuP7YbHnWOz8pZblr59HCj4Enx7MY5VKJRFZjjicBKUs7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG/5zjYK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f8095a200eso1544344a12.1;
        Fri, 15 Nov 2024 07:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686046; x=1732290846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fWIBrIMxKYuT2qQy0v4XlTOCuAe13toBzYEPCk6nTWY=;
        b=PG/5zjYK3CgrOJoW4Txfns7wfSwA951Av89PkpjktpnoPfAOkBvg0PGkuIBvizC1rP
         Cxyi+i46A+P1/hC2qUevC6Wr2XAwTl+Vj0h/Ps8SKHydzaJinZj/Cb9//3MnK/63Yxm2
         50yKdDv81dtkHQQbSg0HMJYZf79dwcAWfwLpG2UjdBZZGHR3u/xuDZ1ySDkbQJtVIc3j
         Rm2WXjHM5aGtdZGpWDi7suwUMU8XaKmgdMf+kKp6fjkZ7NKJpKoMSMjfqbw4UrqNwa2P
         KL46VSZUkvM/k3MHDdjE/ukJVG7sZiWnE/jEPZVZahX0B5GlhKugzhTN8HxfLID7XPNx
         bmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686046; x=1732290846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWIBrIMxKYuT2qQy0v4XlTOCuAe13toBzYEPCk6nTWY=;
        b=sS81yE9jmGElhbt3n1uUHxQqIvi7tkAGkEiwjjJZE3AyhaKPMsRvfTNzm2ivZNNcTE
         0bmagYYNR+oOSXvwFZe4UMSMqD1XFvTaY1hgpXzfRZhq5wJADtdg2/4MILZOcidllJeW
         pQU5WyUNXU4IHqM1uzhgteDx/nwsgja0uM7cz5lEvVIuc9sHONBT8RwlffrsEG7OeQP5
         FztrKFSI2MdWw+cAS09LQJXmUZZeTvrABz1BrFLHBdtUf59KsyTPNdARWPqpx29uxtNV
         jXxV5qjtqvQ8b7iquUA8p11rbZ6PW5Yc3JqR6r6uSg9D9I+aUD9vpt6IcztheQjRp5kV
         EVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8uhC74a2h7e7jIezID7PnkV5+/2/RII/kJqBQ3RITqg0yJ4hCwFFalNZSbhQHgh++vW/MZIsKKrfM1Wk@vger.kernel.org, AJvYcCVXdxYu9ftPg5zA3p3TjvZsdwyFdTg83uv2dg2U7HBoDixE2WWncV2g7gvlSLo5qfxnB7E=@vger.kernel.org, AJvYcCWq+Cwl1eQuSvbVSoqzRZUXyVYvWm9N/7dUoOiKU/8DIx7Rhj9sb4gyCqnOt3BFqIa+SCUAnB8q@vger.kernel.org, AJvYcCWro4oK/qxZX6iPCZiMd81L9GC9SSx/vq2L9IJavUKdYmoHVwlAadSpU4tpkPmOitgQMFqREyUS6NkqyHeKCoRV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/X11PcuKcATz8DJr1h/YPt6gEgkDd+fLT90393y8nSc5P2N9l
	WbmnoOLyIv+eTSE7QiT5V+AY2KEejyfoPQxzmIolk/GzqH+AH2U=
X-Google-Smtp-Source: AGHT+IHGe4+uNNOZ3ukuyHDnNclxsbVkbJuiLiZd35z/0yWQm/2bZPe0ujlu4zVAWrkwWhOIYZdUOQ==
X-Received: by 2002:a05:6a20:258d:b0:1d9:281f:2f27 with SMTP id adf61e73a8af0-1dc8fe85070mr5085175637.19.1731686046375;
        Fri, 15 Nov 2024 07:54:06 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dada40sm1426549a12.61.2024.11.15.07.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:54:05 -0800 (PST)
Date: Fri, 15 Nov 2024 07:54:05 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 11/13] selftests/bpf: add network helpers to
 generate udp checksums
Message-ID: <ZzdunVLMaX1iy85i@mini-arch>
References: <20241114-flow_dissector-v2-0-ee4a3be3de65@bootlin.com>
 <20241114-flow_dissector-v2-11-ee4a3be3de65@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114-flow_dissector-v2-11-ee4a3be3de65@bootlin.com>

On 11/14, Alexis Lothoré (eBPF Foundation) wrote:
> network_helpers.c provides some helpers to generate ip checksums or ip
> pseudo-header checksums, but not for upper layers (eg: udp checksums)
> 
> Add helpers for udp checksum to allow manually building udp packets.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - new patch
> ---
>  tools/testing/selftests/bpf/network_helpers.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
> index 6d1ae56080c56a65c437899c32566f0e4c496c33..fa82269f7a169a518ba210fa8641eba02f262333 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -161,6 +161,33 @@ build_ipv6_pseudo_header_csum(const struct in6_addr *saddr,
>  	return csum_fold((__u32)s);
>  }
>  
> +static inline __sum16 build_udp_v4_csum(const struct iphdr *iph, __u8 l4_proto,
> +					__u16 l4_len, const void *l4_start,
> +					int num_words)
> +{
> +	unsigned long pseudo_sum;
> +	int num_u16 = sizeof(iph->saddr); /* halfwords: twice byte len */
> +
> +	pseudo_sum = add_csum_hword((void *)&iph->saddr, num_u16);
> +	pseudo_sum += htons(l4_proto);
> +	pseudo_sum += l4_len;
> +	pseudo_sum += add_csum_hword(l4_start, num_words);
> +	return csum_fold(pseudo_sum);

I was expecting to see a call to csum_tcpudp_magic here. And csum_ipv6_magic
down below. These build pseudo header csum, so no need to manually do it
again.

> +}
> +
> +static inline __sum16 build_udp_v6_csum(const struct ipv6hdr *ip6h,
> +					const void *l4_start, int num_words)
> +{
> +	unsigned long pseudo_sum;
> +	int num_u16 = sizeof(ip6h->saddr); /* halfwords: twice byte len */
> +
> +	pseudo_sum = add_csum_hword((void *)&ip6h->saddr, num_u16);
> +	pseudo_sum += htons(ip6h->nexthdr);
> +	pseudo_sum += ip6h->payload_len;
> +	pseudo_sum += add_csum_hword(l4_start, num_words);
> +	return csum_fold(pseudo_sum);
> +}
> +
>  struct tmonitor_ctx;
>  
>  #ifdef TRAFFIC_MONITOR
> 
> -- 
> 2.47.0
> 

