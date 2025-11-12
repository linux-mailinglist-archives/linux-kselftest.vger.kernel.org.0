Return-Path: <linux-kselftest+bounces-45421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7092C53633
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 17:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0842D4A65CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8698533F8D7;
	Wed, 12 Nov 2025 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zd24x4i/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuJAD5LN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7533BBD8
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959062; cv=none; b=o9xC+fTEVknpmjJY95oRyVatRUsF4Qws7G1uqzokDfqyey2+cuXZKAEzpXBqyrfYzvDKR8/7ZhTGCeLTlV0Cr7CIUaO2F18w0Auu+kWgXH4MVE8VkPjK9OQjgt/R0o714lsHKrBvSNnRvDT2PH7Z543s6oE4glKF3TPICExLNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959062; c=relaxed/simple;
	bh=zMRRdX2owS8FdV/BiqPTU+IIEcG54+CqIM+8HoD1Ms0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AheA5AFKaH8b9d05qPLdppZdgRQyLRvOI+A0y9oGYt6j0SmIOSC4vLTsyYYLI7sPpHiQ7WADF1NzNz5Vky1uQJDM0V6xPI/mth5FRo/6Gaj27WL3/4AI+Ex4apf4vv3l43ql8Mxo3Jflm/MPdBT0SzcffksVmxbNeKuIHSR0jU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zd24x4i/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VuJAD5LN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762959059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ/SnVy0i2WVmKdjO+8lXLUclnaJKnVKKCK+Fx4B9So=;
	b=Zd24x4i/42wtsLFLm9KHkVdfJ5BY4AHDMgiLTyiTSeY/1upqEwXFFLaxZSqlT69We7k045
	rdxO3+MhWKTFK5Un8f6k09qOF+5NXbChArVOjJ/vthZWsuvDVVxOeaqGZLcbVmSZ8DGgfM
	Ja2Ut9B3vs6yzoRtgRSs8w6Ug6eEvAg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-6E2nQoMCOOGcl3tXB2bgCQ-1; Wed, 12 Nov 2025 09:50:58 -0500
X-MC-Unique: 6E2nQoMCOOGcl3tXB2bgCQ-1
X-Mimecast-MFC-AGG-ID: 6E2nQoMCOOGcl3tXB2bgCQ_1762959055
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso389785f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762959054; x=1763563854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJ/SnVy0i2WVmKdjO+8lXLUclnaJKnVKKCK+Fx4B9So=;
        b=VuJAD5LNRfTxWTKfLAa7aDsbHtoC/EchRMf+Q/NPebSfR5nnxJWsqZTxN2jGWKgpnm
         ONxKy7Qeb/NPfR//2ycVJjkI2qZEWFdOdiPqwvCm50n4bF3F149AyzI/bMKLawetjqpa
         KknIgVswgVn1Uu7G28tjQ/mXI0QqVRrzFhXk2HKvCdxPVS3+OfBZIb3GkZ0bgD9bicyv
         TgK/QoZvK2WPp6UHYnph8NCyrkEmpp4tgex/1YzhReW1fmFG/ZwcavXQ+kLyYTOaAPj4
         ULqTCdsbnN6OEQ4tOgoteTzRnTcFxJZZYjGc2TW20UHBsZDX/jPDuWvTYrDIzd1F9Ua2
         w6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959054; x=1763563854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJ/SnVy0i2WVmKdjO+8lXLUclnaJKnVKKCK+Fx4B9So=;
        b=CXZUxJJ7cwlMY4Mk0RKdoliumySOTlRZvZ7JuMWqI0QPtMy3GbMxZZH+2AVpjHzG/i
         7gTpxtjwNWRoSiovNaVJ/6CpbOwIH0N0+3iiKL/hZ0PFn+87hnbMtSqtecTPIJWq9VAy
         +y/cb9klAXa3fS5cwJ+H6lXw3YpmL+1KjwJINmFe2RWa9j1KkSjaFwjHIhecVEafYswO
         /k7EMWWG16LQ0tllw1gcOlyfsoSf+xCAwtbaxeloS00B+TvoUb6VMz5rNA8WGhsMuC4s
         o/MKyENGeBqApRdRZfWoV84nFxxuq/lAY2C7Lxvr3eMJNvsMCSH2MK/8nxAuizn4qKpR
         R51w==
X-Forwarded-Encrypted: i=1; AJvYcCU9aG7W8VzaW2DaTz6ygg+vNxWgu0cAvM/rA30p/TP14Jxc/vmDNQ2L+2d7fpoNRQE1e+m5FIQTtfLSOARnUuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvbELg+ZQM6Hfx8MhffAVj+KP3m0WmUxRRDVrDMpb4/gcUc1w
	DM4MhLWQKa0alrUDAdPhPivWltEWPy8kBl/AJuUdNN0QbcF5rhNAZfH/34Me1AxdNAFl1XX0+0P
	0aIryAyxhTYEYVJOFc3BuBB80m7G2U29DEuvdRGCvLjH/nMKugEsgR7yDQ7DbuMzEx/PsTw==
X-Gm-Gg: ASbGnctcId1mPC5aQwkOnC6KV2gy0DaioZpCnMcJFdwlC6YqgPx1ZuYOcybFAtHkq7V
	YuTo9iTz+kKJjzd28zoQMA9AlRTlJaUxy2xIO0os0YuexF5DHczS7wTS2RXFfvWdTGBWhIFvool
	ZlUDvJS4RcmkqW3Um9zOCGUpulX5Tzu/qbLeyE3xBEpILp7jZc3zELgajF5mD1e2JB4sNr5ogVN
	prJewra7cA//sUwSoTzxeXh1UXgRjbztL485XIDDxEs+NMUqjyBSu4O/G76ZYQnnpaeOmoZ2GQA
	TS6hyqLCwX3QlX6ae8fewuNcYRPdJ8ZgEulPF29pMSa8uT9OJVcVDdjLkAlKZLhm2SH9XbW1kUm
	2Hw==
X-Received: by 2002:a05:6000:2891:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-42b4ba75470mr3031635f8f.18.1762959054587;
        Wed, 12 Nov 2025 06:50:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERB5IOiGOtuJUGWUEr7UkS6m3ACPJ8/nI92NfUrVDc35tes2Rnj+8LlolGWnYHhDlrIMnvBQ==
X-Received: by 2002:a05:6000:2891:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-42b4ba75470mr3031587f8f.18.1762959054156;
        Wed, 12 Nov 2025 06:50:54 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33392697f8f.35.2025.11.12.06.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 06:50:53 -0800 (PST)
Message-ID: <0944325d-158d-45a4-a1d4-d61e645b07ea@redhat.com>
Date: Wed, 12 Nov 2025 15:50:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 05/14] tcp: L4S ECT(1) identifier and
 NEEDS_ACCECN for CC modules
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "parav@nvidia.com" <parav@nvidia.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 cheshire <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
 Vidhi Goel <vidhi_goel@apple.com>
Cc: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-6-chia-yu.chang@nokia-bell-labs.com>
 <bc1ebcd0-c42c-4b59-a37a-13ee214e90a6@redhat.com>
 <PAXPR07MB7984498C0F152D504B2AEC98A3CFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984498C0F152D504B2AEC98A3CFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 12:02 PM, Chia-Yu Chang (Nokia) wrote:
> This bit will be set by congestion control (TCP Prague, which will be submitted after AccECN patch series).
> 
> It is intended to use ECT-1 rather than ECT-0, and we were thinking this flag can be irrespective to AccECN negotiation.
> 
> Shall I put in the Prague patch series?

Yes, please!

/P


