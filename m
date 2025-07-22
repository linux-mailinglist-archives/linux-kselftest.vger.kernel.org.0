Return-Path: <linux-kselftest+bounces-37838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE6FB0DFFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DE66C71C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A72EBDC3;
	Tue, 22 Jul 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBxlzKLy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460882EBBBA
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196627; cv=none; b=U9d9fSCfXvDUyILkxW6B/col7QZIhwhaRzC6r0qyUCQ0/JT3AiWtMVYQAMNc6RKYVAwnQ9GhVkYSCe1p5eNkR496DLq/zKda8EjPNMNdrPxkN424N3og/uABZ4yjQkhuINuDcF/k2wP+EEuVaTk1VKWVKjNRW6vXlu2MnfzWo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196627; c=relaxed/simple;
	bh=z2gj5V7u4WprQQoCZFJO+IylNg/HsgVNMYcaqhQgwVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwNrsdJeW/wTYcF9n6EmRHONlAVsKmgl1NNsuBpN+yTXAZziBhxA4xegbZoxhovrmXl/9L+zRw3OLSWw8lOcnggAcdXPODca0MFjpDup/gpcKwDLsBdJUgA9wuWLe2PhX2Ad5VtAe+o3awn4hmGLxdqA1HiykusFz8S+UaXtRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBxlzKLy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753196625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yLoXN0zviuhjRHlOKL2rQE3hdCG3gOLWxmD1fwrgVH8=;
	b=LBxlzKLy9dYTeEy+ICMEiqecJB21m+gJAL3lGt8KXNw39b3xaQjpNSxydNXdIbVH+4wffp
	SFEDjcfKrXWlV1isE5KJFW1d+JpFXCtxDnMrLddCNXVXlMiv0xohgMIPkfbAm8cdRpvIfA
	LIl2VO6SAp+yoVyAFLYKrDlv+HNHFdU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-sncVjx1ANqSHp9lEIRuSJg-1; Tue, 22 Jul 2025 11:03:38 -0400
X-MC-Unique: sncVjx1ANqSHp9lEIRuSJg-1
X-Mimecast-MFC-AGG-ID: sncVjx1ANqSHp9lEIRuSJg_1753196617
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ac1b43c4so35137895e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 08:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196616; x=1753801416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLoXN0zviuhjRHlOKL2rQE3hdCG3gOLWxmD1fwrgVH8=;
        b=kt5wwEdc/P2FZ0tKHqhbLL3t0vh0VNe8ryasek8yMaeLIfEO3htk1vmQTS41IluvBm
         hm/g2muLsyBxWNUAXzuSCHN05OiQDeVv0yshLnmUBKfWfYn9XXPAgiD4TM0SOHGFcs6E
         YfUhIOppexdVIzDC6xZDVvXHsUwOUzGYssDy2T0/oLkNc7GNC5ytEswHdt9IRk7Gbo3v
         HqZuPOc1SoXL6PQub37r536UX2U0PWNfzdsBG//RIo//fjZgwlYN98Npw6FdNFPpHmq0
         DCX8O2xdmJ2Kv/0L37Y8tpSGw4Aj3y6itDhxFem0oQ2xZJM8XeZUAaJdRYYavsND/3F/
         sqSg==
X-Forwarded-Encrypted: i=1; AJvYcCU33MnKnogzzHJ5b2xBa6HU5FZyPN/25n3BBtCzW33E3jdyBBw8kUcl76TumEwqhaOpxq7rRxMJ+MSuv87LHMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyRb1RUvtLX0szfYdX2WJ3ZNJgx1NLMRNPmcsTC0ABjn4G8jz
	vfjNVo61UMCsXC3JEFRi1TKQNXnHTpEnqaQwSh/q+ubD8I43fCBkPD7hkejxlRQG/R5YM3MNQ3c
	qdBlMVjyKB5wwOFrbVPto8rnP5reGSKllKpQxAlcR1UU6OvsDV4zViDXLk8WIDTVBP1laFQ==
X-Gm-Gg: ASbGncvOaTKSOzUshKNR3BUNvgda2/HHX3K/JkYv7tqz/d4m0F0K18SOVFn5o1HI9qU
	lDZNv8dyWAuc9tdV8a92eQi2Ehy1MvFcDUfyw2hs3/4ZCK0ReX6SiaOTpwdUTSeNnT2z6YVJopy
	849asuYduRM+ntetugKcFkMx1Watd1UpxaAVUEBt/7yd7044LKZNB/MlCuMdVXuk1fSbiDznzBb
	UlxAQpqN8xOYKe+N3aYqlk3VZ2XyV7ePdY9nowU1/gXrMDLRSi2TJmuWDPjvGIdmrPpfJ7qk4fo
	Y8Z39BcpTOXK9dSPx9Q2Yb4yymLQQPbFNYbvniXCSVY83J+lSi1qlcIwA/v62VqJtWE1TnExyCG
	pKWK8IA+sGF4=
X-Received: by 2002:a05:600c:8588:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-4563bf262e3mr103369885e9.26.1753196615963;
        Tue, 22 Jul 2025 08:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXBjtom7DfrBS3RzSHHM2jEi5VfD/84zxgrNdm4BqqX7Z5GS1hjLJJaVsZOKAqO1uS8F1VCg==
X-Received: by 2002:a05:600c:8588:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-4563bf262e3mr103368725e9.26.1753196614818;
        Tue, 22 Jul 2025 08:03:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b73fa43sm131621725e9.21.2025.07.22.08.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 08:03:34 -0700 (PDT)
Message-ID: <eea3a104-1cb9-4606-9664-a8beda93e018@redhat.com>
Date: Tue, 22 Jul 2025 17:03:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
To: Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Nimrod Oren <noren@nvidia.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com, cjubran@nvidia.com,
 mbloch@nvidia.com, jdamato@fastly.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, tariqt@nvidia.com,
 thoiland@redhat.com
References: <20250719083059.3209169-1-mohsin.bashr@gmail.com>
 <20250719083059.3209169-3-mohsin.bashr@gmail.com>
 <ab65545f-c79c-492b-a699-39f7afa984ea@nvidia.com>
 <20250721084046.5659971c@kernel.org>
 <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <eaca90db-897c-45a0-8eed-92c36dbec825@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 8:34 PM, Gal Pressman wrote:
> On 21/07/2025 18:40, Jakub Kicinski wrote:
>> On Mon, 21 Jul 2025 14:43:15 +0300 Nimrod Oren wrote:
>>>> +static struct udphdr *filter_udphdr(struct xdp_md *ctx, __u16 port)
>>>> +{
>>>> +	void *data_end = (void *)(long)ctx->data_end;
>>>> +	void *data = (void *)(long)ctx->data;
>>>> +	struct udphdr *udph = NULL;
>>>> +	struct ethhdr *eth = data;
>>>> +
>>>> +	if (data + sizeof(*eth) > data_end)
>>>> +		return NULL;
>>>> +  
>>>
>>> This check assumes that the packet headers reside in the linear part of
>>> the xdp_buff. However, this assumption does not hold across all drivers.
>>> For example, in mlx5, the linear part is empty when using multi-buffer
>>> mode with striding rq configuration. This causes all multi-buffer test
>>> cases to fail over mlx5.
>>>
>>> To ensure correctness across all drivers, all direct accesses to packet
>>> data should use these safer helper functions instead:
>>> bpf_xdp_load_bytes() and bpf_xdp_store_bytes().
>>>
>>> Related discussion and context can be found here:
>>> https://github.com/xdp-project/xdp-tools/pull/409
>>
>> That's a reasonable way to modify the test. But I'm not sure it's
>> something that should be blocking merging the patches.
>> Or for that matter whether it's Mohsin's responsibility to make the
>> test cater to quirks of mlx5, 
> 
> Definitely not a quirk, you cannot assume the headers are in the linear
> part, especially if you're going to put this program as reference in the
> kernel tree.
> 
> This issue has nothing to do with mlx5, but a buggy XDP program.

Note that with the self-tests we have a slightly different premise WRT
the actual kernel code. We prefer on-boarding tests cases that work for
some/most of the possible setup vs perfect ones, and eventually improve
incrementally as needed: the goal is to increase the code coverage _and_
encourage people to contribute new tests upstream.

We try to avoid breaking existing tests (at least the ones actually
reporting into the infrastructure), but for new ones the barriers are
intentionally different than VS kernel code.

Cheers,

Paolo


