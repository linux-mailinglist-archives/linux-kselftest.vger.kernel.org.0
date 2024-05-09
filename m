Return-Path: <linux-kselftest+bounces-9787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69598C1128
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 16:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9AC1F2359A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC6315E5C9;
	Thu,  9 May 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfP6Tliv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78414B95C;
	Thu,  9 May 2024 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264698; cv=none; b=YfjULLv1UeyO8OEcNMdYBnhpCRumZDrCxYmjheGhVbrHQOaz0DigFLNJg4C5DFhlxfzXpmsmO0D7tE8wwsxswvf4CnwrY6ArZ/3iF0TbVHR+VmE/0VClzsRpAX9XTfE0yg/Id7yalTSPOJhNISoe+VqaLWNdlqpoKhjjvE3kSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264698; c=relaxed/simple;
	bh=ApIc6TXPNOl7QssVveAqbBpF15Kts83ge8Y5RpmDh1I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lJUX2v5qV1HsawLdPy1vX1GVfE8N7v3giAlRqQTNB1ZOGDknvq7NOf5EkmEemdfrZI6EP1CoxNoChPs0J3X0PRNzHe05KFHn6CUMjfnuP8jEUMtzEubMVPcCB/hG299sSqg+PkA4DLJyM1wqZ7Dbl4cUng358ZYmr2CCiNcqLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfP6Tliv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-43abc28f73fso2628331cf.1;
        Thu, 09 May 2024 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715264696; x=1715869496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zs16QG8OBEhYviVc8HMUKq/xgwrRdNsgy9DJTA2Hlk=;
        b=dfP6Tliv8t4ARwzP6lHCuMN2psEulQzvQgC7bo6UDOh4wH2+6Np/fOL/585NGMW1Mp
         AFeqtLpOPr3kuK/g6s/BCviRXXl2JBhpCQbyGxhu5Z+M3F7SRvFu9FYrrSCllQ3UJ++Y
         0Ji4OSDIayxLUAjCMUqYzNdOqPtZ3DvmJ9eYPtyWbE++ZGbEYrqCq0z89bXSLVduwYJb
         bQ5uJ765YhvVYIBR7WpKzQvww2MPoTieTpHMSxdkT2vojmFZ/A4ioCzOPpmBx9k34Bcw
         R5iM+mc9czkaUhjh71bPwbIQEZyH0zJAuf86rAJ/T627GyeYkJznD6+eiIpi/B0BuNJV
         m90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264696; x=1715869496;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3zs16QG8OBEhYviVc8HMUKq/xgwrRdNsgy9DJTA2Hlk=;
        b=e6MDVj5STNWkE1H4/Xqqd1IE9qpA6g3XjSAFED+9nZk52R/LyT8a2JsfUqvsAEMEVr
         1BS/p8GrEIxyAeTuIuGmT7Mo2+pN0BIYswcXtLFy/MFcwVtu9+Zujy+VsRqzHnzJ8d8I
         vvxkqh6XdAh1hLGMN8UuPWHBzFDrkBt3dU3YLyNlb46760uGnjigHLpQ+C5tBzXTFDZy
         2TpP1W7voRni0uzdT725HWNsB7rJzTV7v2/mUvz7TtIPxCUrCflwn2NOaIjkCyXUbIex
         MkTyUyYHxR4WuQX3jEwdZsRkkj6VdeEo7sBiC1JiJkqrs7wglReHDo2AZ/AUdpUmnTWo
         KHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTbYpyZF6H58ArzUsaOja7fNeIbcWA6E3G45hUol6KtgJ/Rr7N0FwCiZMvxodcU/Whw+b4KcXtN3fZGQhA2HRWlcTtUDUxA28wX8IXxlnGIvp14k25AWxGzfhsp4yiP1K216yNjNjtOg6tiJhZT/OO0RMM0HJpC1HP8iiCbmCtNx7F6b+7
X-Gm-Message-State: AOJu0Yxsmxg0tQ2B9NZgzSNWXAm8T08g2LaKxCYWaWTMmVib3SIw3jJA
	80A82JWgRGnEj5qEe4rl4MTO8H9BuR+FHDBVB70C2Z87fWPSuMOS
X-Google-Smtp-Source: AGHT+IErNF5o1AhRplGAtweo9Eb0uwDNJjg9rqHt+RUHvGW8d8hxL8YBlgOk/OurMBVSmOBGgAbuaA==
X-Received: by 2002:ac8:5f09:0:b0:43a:a8ad:7954 with SMTP id d75a77b69052e-43dbf4e74d7mr70501511cf.28.1715264695997;
        Thu, 09 May 2024 07:24:55 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54d922esm8730591cf.22.2024.05.09.07.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:24:55 -0700 (PDT)
Date: Thu, 09 May 2024 10:24:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 richardbgobert@gmail.com
Cc: alexander.duyck@gmail.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <663cdcb73953_126914294b5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240507163021.130466-1-richardbgobert@gmail.com>
References: <20240507162349.130277-1-richardbgobert@gmail.com>
 <20240507163021.130466-1-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v9 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
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
> iph->id, ...) against all packets in a loop. These flush checks are used in
> all merging UDP and TCP flows.
> 
> These checks need to be done only once and only against the found p skb,
> since they only affect flush and not same_flow.
> 
> This patch leverages correct network header offsets from the cb for both
> outer and inner network headers - allowing these checks to be done only
> once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
> NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks are
> more declarative and contained in inet_gro_flush, thus removing the need
> for flush_id in napi_gro_cb.
> 
> This results in less parsing code for non-loop flush tests for TCP and UDP
> flows.
> 
> To make sure results are not within noise range - I've made netfilter drop
> all TCP packets, and measured CPU performance in GRO (in this case GRO is
> responsible for about 50% of the CPU utilization).
> 
> perf top while replaying 64 parallel IP/TCP streams merging in GRO:
> (gro_receive_network_flush is compiled inline to tcp_gro_receive)
> net-next:
>         6.94% [kernel] [k] inet_gro_receive
>         3.02% [kernel] [k] tcp_gro_receive
> 
> patch applied:
>         4.27% [kernel] [k] tcp_gro_receive
>         4.22% [kernel] [k] inet_gro_receive
> 
> perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (same
> results for any encapsulation, in this case inet_gro_receive is top
> offender in net-next)
> net-next:
>         10.09% [kernel] [k] inet_gro_receive
>         2.08% [kernel] [k] tcp_gro_receive
> 
> patch applied:
>         6.97% [kernel] [k] inet_gro_receive
>         3.68% [kernel] [k] tcp_gro_receive
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

> +static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *iph2,
> +				 struct sk_buff *p, bool outer)
> +{
> +	const u32 id = ntohl(*(__be32 *)&iph->id);
> +	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
> +	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
> +	const u16 count = NAPI_GRO_CB(p)->count;
> +	const u32 df = id & IP_DF;
> +	int flush;
> +
> +	/* All fields must match except length and checksum. */
> +	flush = (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF));
> +
> +	if (outer && df)
> +		return flush;

    if (flush)
            return 1;

To be able to avoid the two flush | below?
Or to avoid adding a branch

    if (flush | (outer && df))
            return 1;

> +
> +	/* When we receive our second frame we can make a decision on if we
> +	 * continue this flow as an atomic flow with a fixed ID or if we use
> +	 * an incrementing ID.
> +	 */
> +	if (count == 1 && df && !ipid_offset)
> +		NAPI_GRO_CB(p)->ip_fixedid = true;
> +
> +	if (NAPI_GRO_CB(p)->ip_fixedid && df)
> +		return flush | ipid_offset;
> +
> +	return flush | (ipid_offset ^ count);

And then simply

    if (NAPI_GRO_CB(p)->ip_fixedid)
            return ipid_offset;
    else
            return ipid_offset ^ count;

Since NAPI_GRO_CB(p)->ip_fixedid is only set if DF is set on the first
two segments, and df ^ id2 & IP_DF is tested above, no need to test
that again.

> +}

