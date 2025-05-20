Return-Path: <linux-kselftest+bounces-33387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47C8ABD3E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5186617C92E
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC394267F73;
	Tue, 20 May 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O81hku0v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873121C9F5
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734599; cv=none; b=PbaLDZoDUJvxNYVze6ocvvkm179PAZ5TIOe2JmQo/CmzQyyLWbHl5UCncfy82vT1Lu1LceJXDnrxwQHSs/ypcrGhoBf1oXV/sgZGnodCRaEARuR/Rw0coDtJOjQ1OlkL99GJNvtVaJFbSdT80+TspX3GoOqaWh+AFqS3pf6cb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734599; c=relaxed/simple;
	bh=zmMeJiDDZWaauBVCwiIbfO5yDwZo3DooABBxbFXHDdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yh591z5kFo/nmekMkiZdkAw9pvew99hOpyTExVKYPy4RhSj5gzaZ3UqfkLm0WIrktxwm4XHzPy8EKw5Alsz/VbfP3huBNhM2sx91BYrgk/1xMtr3MxXyIw3H/CYrEWqWeYPSgpHeaqErAyvpUx4qCpNUxlOZ5BVL4LvshsPtf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O81hku0v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747734597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKVK+uAlT4VzaC9oAx0YIHTOnxhoJDuCN0nhLSXNB60=;
	b=O81hku0vozDSd0vx5MrGGGu4I9sBNeLDddnul+OCTTTQZemvHGvQI9LD+6XRCBoNz/MjwN
	AUNtL+bUx6DxqKbBmR5kVmYOOWGg4HsKd+S12s091OKOLFYGYVXJO2oyBXp73j+j07SnEt
	RfkHfPQSGcRH3NX9fk9K2+eKz3FUp+c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-o2aTJ0lNNbKZWubAdpmy4w-1; Tue, 20 May 2025 05:49:55 -0400
X-MC-Unique: o2aTJ0lNNbKZWubAdpmy4w-1
X-Mimecast-MFC-AGG-ID: o2aTJ0lNNbKZWubAdpmy4w_1747734595
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a367b3bc13so1148051f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 02:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747734595; x=1748339395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKVK+uAlT4VzaC9oAx0YIHTOnxhoJDuCN0nhLSXNB60=;
        b=qTKOadyEpUq5HSsrmkY+D2czosmHvgj3oR3Fry2lGTvBCIodGHOy/bz2nNz/m2hJQp
         L8X64f9lfeJf+raaySLmno8Q7efp+HcYn0gICLtAvYbcxLt85hb/gkADGTWAocmxwuyS
         WczZ+plAwML95UYzA0Qd4LejewIi86a3F3xxQ1vi/q9GGgxsWa7lfBCZNWNXejZihSOb
         QZQ2+l6ccVoaILNR+dyihwQgrI6BgKVR24e5J4DsnY2UUtn9fI1LzIeYq7J6i4VH4W8X
         Pp7vzl2H5P99AHf4oM6HjnM6Aj9sY3vfDFGNMl7n46lxrnycS3YdBQaFAar6aVbBm3+b
         s0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4RIzqV4AoBONu8WSEPgojTA63kDDmuV8PJ6pI9taq8bpJJnJo3gildKdp4ByufERVQoPM2g108EHy/N6leSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7Bk/imHrw98redY+PZIORjDWtD4lUCUqm8Vx5CoAJjg4VXHv
	6eo4fuBLOKvszmO231PLS7rHhgPEuU6D6gIqszNpyHskiJAWxYmzdZPbTOCKiZI8gNo8ABbYB4e
	em16N3fdQZVoFaaeUs9QJ+kc9dwmE4bijt6RMhN+vouqh6ZyT+2HMbTkCuHHrA5/kFL8vzA==
X-Gm-Gg: ASbGncuAHPztFLCj8jv+/JzseRM/BO3/X1M2XHe1Vow0T5TYjg9Ey0e2AVM0rBEydya
	ZYmt4Ib3m8eEr2LJWFvT9Tko56LSTpO2Oun30VDDHH2kQNU1PbIDC2OBFVkKbvyDvAB66YNPeSR
	bKsPXNzCC+/U+Sr2Bj1gbL2LyJEos7EO6GbkPveYrE9xdPUY3X5mzPXhlS094m3vC7LXntwOac8
	jAoLO4eszs3pG80XRFWiwwmvkHIRsPyYc2vQ5cxDobuKsnvbbKXlLbqd7aS2VX1ZLNEltAMG6bK
	0GFX2BGfIzdvPWAL1HRIarvDxhwBhmYEO0zbNgGqse6Pngsm9NkwgRU6su4=
X-Received: by 2002:a5d:6a49:0:b0:3a3:5cca:a56a with SMTP id ffacd0b85a97d-3a35ccaa7ccmr9873010f8f.32.1747734594726;
        Tue, 20 May 2025 02:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERZPLs4JlsuZmumP5YHPtj9qIckLqLuPz2NZ0FOXcdTy6ANbEKQ9dbQymmsaS/IsilI+AwLw==
X-Received: by 2002:a5d:6a49:0:b0:3a3:5cca:a56a with SMTP id ffacd0b85a97d-3a35ccaa7ccmr9872974f8f.32.1747734594291;
        Tue, 20 May 2025 02:49:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88a13sm15601908f8f.74.2025.05.20.02.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:49:53 -0700 (PDT)
Message-ID: <6ce5f200-aacc-4b01-b3b6-b2dbe543248d@redhat.com>
Date: Tue, 20 May 2025 11:49:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 10/15] tcp: accecn: AccECN option send control
To: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-11-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-11-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -6450,8 +6480,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
>  	 * RFC 5961 4.2 : Send a challenge ack
>  	 */
>  	if (th->syn) {
> -		if (tcp_ecn_mode_accecn(tp))
> +		if (tcp_ecn_mode_accecn(tp)) {
> +			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
> +
>  			accecn_reflector = true;
> +			tp->accecn_opt_demand = opt_demand;

There is similar code to update accecn_opt_demand above, possibly worth
an helper.

> @@ -1237,12 +1253,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	}
>  
>  	if (tcp_ecn_mode_accecn(tp) &&
> -	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> +	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
> +	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
> +	     tp->accecn_opt_demand ||
> +	     tcp_accecn_option_beacon_check(sk))) {
>  		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
>  		int remaining = MAX_TCP_OPTION_SPACE - size;
>  
>  		opts->ecn_bytes = tp->received_ecn_bytes;
> -		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
> +		size += tcp_options_fit_accecn(opts,
> +					       tp->accecn_minlen,
>  					       remaining,
>  					       saving);

Please avoid unneeded white-space only changes.

/P



