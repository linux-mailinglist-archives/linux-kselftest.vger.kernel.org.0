Return-Path: <linux-kselftest+bounces-6163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2E6877619
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 11:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7068C1F21A40
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1416FF29;
	Sun, 10 Mar 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvQ1tdgq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671219BDC;
	Sun, 10 Mar 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710066849; cv=none; b=VRij5VlCEw5FAjsRe9zOKrEN6mJfiL+HiVdFjMrLNXiXPCwhvKmFle/bhN1YOfvUp4iEttj80pmS8GMzZ7JTxm3K4a6sPFuhJLdQXVJWXmjMjrRxqCVPEEY2lhSPhp7YM6vIXEY1QDRjxB2JI4hymxDvaBRvxq5SxBu/ZXS5etI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710066849; c=relaxed/simple;
	bh=wFP5SnRdAlTYrtaQsMeuYAzoSBLP5KDO3ydiK/WFhDI=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FE+sKAYaqEeRO5F733MOVLd479+6M7pfj2DhL2qqCsxAwYi9OYJTxHhOftXSn+Wvktat/rBc/XBbFlCnKY1GkeTVgS8Csq10qB6KbB9agCbRDcfDfKNWxSnVBTnYdSNiUoqzy81M7/cmvoEEsXLri8Zu55dnT/mxr68w1rw0ISY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvQ1tdgq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7882e94d408so297458885a.0;
        Sun, 10 Mar 2024 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710066847; x=1710671647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQXfYhSSj+U5lwLm5VRHdYF0sy5VxGpEKaFhMn2Srhs=;
        b=gvQ1tdgq/XehUehUbBXZyutFqZ+W5kmMv6kw/G5pka1WuWBtFPn8Qb7PT98oXFo6FW
         x1szY0emsPKx4reYWpbushj73/4fVCby0eaGhRBA6ccunUilXzZaxGJrQjhxX8YMiztU
         oNgR29Vzf8U/WppZVFnR4BDxYoV8r6rAJdZjXFVSN2qFJz5J3ep4SliLrf1EZn4evjsz
         v32xhUlkeMB32QVDWKFOBvYa4Nbf9JewIKvMsX3iZqOq+otKvdZTSE5Fx/jDz3YRXCPG
         4kaiHNMM7P3yQsdH6WDlBxdXc4jghV1lKAEVXm0v/Dbqtq2kmzq2afHaq8ckcRVfg3Lg
         90jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710066847; x=1710671647;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQXfYhSSj+U5lwLm5VRHdYF0sy5VxGpEKaFhMn2Srhs=;
        b=mVCI8+uemztWFR2PWm4QfThRRIGN2xeAWCb00W4qG4a/fwvJ6tfhBK7sie5ELwu9ON
         6qePQggWjTVHnaXPMEuQ+6+fi1HXWnCtFNEbnaTE25xL5ibZfd+mKJosYM3EykZ6wSCv
         3Z7ruPiyRMcOBnanVFRRYBQT3L2DtuINrDUZTVS4cgu19WM/OHeZlB1QOSn8ENP7SK7T
         u2nX+nBH1GETPlxBflOcW0XEtj42+ZH8wips4sqA1VxfZDscR0858g1q+02NEZmeInLW
         zc2WzNnMy4K/2Ys7kTXd4zkQwT5Dg8DR6I2Tkgw93FaFOkoigqcDNSlyuOR7BPp//efJ
         uORg==
X-Forwarded-Encrypted: i=1; AJvYcCUVvQ+7VOdjXGlKK9GCp3jvf0xffa44JgdBW1Bj7lD9odYUUXP69rZK2W+XFDkBMhD3fH8uy1lcGIlug9Cyc06CptpNA3Tmb5FTZAItnoUW0/8huV+ZHXlGfLNxS4KUYwYx6np3JyoQUUMHvKR3AqKIvUSZUge0epMwxEnZqdOOmAh8kiC4
X-Gm-Message-State: AOJu0YxUwgd/8EcmRuELT+fWOe/a+J1yuu/5UCwj+yLMKDVAbI2UHu2g
	0StJcKQbMtdrQ97O7w4ZJ4H/+U1TBBP4uWOJiy4LrhV67G77/ZVT
X-Google-Smtp-Source: AGHT+IFbCBpNRgqZo+j6zeF9zOKNyhkuBx8fIzO8pR5aME+Fs0REMNDZ+JR+kDa986Ot0EHmXMc4eA==
X-Received: by 2002:a05:620a:100b:b0:788:2d92:af16 with SMTP id z11-20020a05620a100b00b007882d92af16mr4320951qkj.70.1710066846864;
        Sun, 10 Mar 2024 03:34:06 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id wh24-20020a05620a56d800b007883c9be0a9sm1717344qkn.80.2024.03.10.03.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 03:34:06 -0700 (PDT)
Date: Sun, 10 Mar 2024 06:34:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, 
 xeb@mail.ru, 
 shuah@kernel.org, 
 idosch@nvidia.com, 
 razor@blackwall.org, 
 amcohen@nvidia.com, 
 petrm@nvidia.com, 
 jbenc@redhat.com, 
 bpoirier@nvidia.com, 
 b.galvani@gmail.com, 
 gavinl@nvidia.com, 
 liujian56@huawei.com, 
 horms@kernel.org, 
 linyunsheng@huawei.com, 
 therbert@google.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <65ed8c9d8dc5a_193375294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
References: <f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com>
 <88831c36-a589-429f-8e8b-2ecb66a30263@gmail.com>
Subject: Re: [PATCH net-next v3 4/4] net: gro: move L3 flush checks to
 tcp_gro_receive
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are
> relevant only to tcp flows, and as such they're used to determine whether
> the packets can be merged later in tcp_gro_receive.
> 
> These checks are not relevant to UDP packets.

These are network protocol coalescing invariants. Why would they be
limited to certain transport protocols only?

> Furthermore, they need to be
> done only once in tcp_gro_receive and only against the found p skb, since
> they only affect flush and not same_flow.
> 
> Levaraging the previous commit in the series, in which correct network
> header offsets are saved for both outer and inner network headers -
> allowing these checks to be done only once, in tcp_gro_receive. As a
> result, NAPI_GRO_CB(p)->flush is not used at all. In addition - flush_id
> checks are more declerative and contained in inet_gro_flush, thus removing

declarative

> the need for flush_id in napi_gro_cb.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
> +static int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
> +			  struct sk_buff *p, u32 outer)
> +{
> +	const u32 id = ntohl(*(__be32 *)&iph->id);
> +	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
> +	const int flush_id = ntohs(id >> 16) - ntohs(id2 >> 16);
> +	const u16 count = NAPI_GRO_CB(p)->count;
> +	const u32 df = id & IP_DF;
> +	u32 is_atomic;
> +	int flush;
> +
> +	/* All fields must match except length and checksum. */
> +	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
> +
> +	/* When we receive our second frame we can make a decision on if we
> +	 * continue this flow as an atomic flow with a fixed ID or if we use
> +	 * an incremdfenting ID.
> +	 */

Comment became garbled on move: incrementing

> +	if (count == 1) {
> +		is_atomic = df && flush_id == 0;
> +		NAPI_GRO_CB(p)->is_atomic = is_atomic;
> +	} else {
> +		is_atomic = df && NAPI_GRO_CB(p)->is_atomic;
> +	}
> +
> +	/* Ignore outer IP ID value if based on atomic datagram. */
> +	outer = (outer && df) - 1;
> +	is_atomic--;
> +
> +	return flush | ((flush_id ^ (count & is_atomic)) & outer);
> +}

