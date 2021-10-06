Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3958E423C92
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbhJFLYe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 07:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238303AbhJFLY2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 07:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633519355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fx4Z8OxDc6y4nOhB3/4DQOKWbbq0SahK6U+FBeZeNy4=;
        b=bje4Zci6+iaxScMyqxn3g97Zfz6wWBKKXwS8dy7snAO4VXLQMTHkBazUSAPkJHGaRZt1Cq
        M5Bzf2KzGZuSntccp5luz5yIKAlZ6DtQQhGonDAWBwMdOoJl83DXyixEc1rnDm1pmCuQuZ
        kU9ouxXpSjieAWPjVjUTbhfSi/581Og=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-km4wpnjPMr6MwuBRpzvtkA-1; Wed, 06 Oct 2021 07:22:34 -0400
X-MC-Unique: km4wpnjPMr6MwuBRpzvtkA-1
Received: by mail-ed1-f70.google.com with SMTP id 2-20020a508e02000000b003d871759f5dso2317682edw.10
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 04:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fx4Z8OxDc6y4nOhB3/4DQOKWbbq0SahK6U+FBeZeNy4=;
        b=IzNRR245OZKy2uB12K62mlIoL0fgdARPR3f+vEdKozRs5mObKV9ZGSgIRenT8uyLIH
         HEt9OJz1iRTkxfgNhfTXFOG7gfHfChp4DLAPoIZ+ItuO+OW20I3vqGak/+6QvW3BtGum
         rI0j6oGjiTGuFKmhMDh7zTCikAJ+XKGRvDbodkei5yljrQNiXm/HvxBOrBpcXvV+heS3
         ndGxH39UMZuBE7GZlfxANngPA2OX87uvBWLoWolDh1CK+MfBnqJsKR79HWK3DZlMTSSs
         AG8dCxii84E3vCOdpFv8D5BA9d6UmxHFFDXX370806viEl4Qd6OjjfiprX1QUnal7Sn0
         8Jsg==
X-Gm-Message-State: AOAM532fs2pqc/g4UqApNE6DzwqC9d1Njg5ZNR7lsWNhR2wcf31UCkwu
        KFg7ir7sT0hH+vF8obK+zpD4ioOUK1MpenwuYXXHtMhdgBQ8ExuSSyWl6zSU0fAmLRWdbCMPA7z
        7UhM6bsPr+kb+3iqqiLHa/BIDEfsT
X-Received: by 2002:a05:6402:5191:: with SMTP id q17mr34076195edd.332.1633519353335;
        Wed, 06 Oct 2021 04:22:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc9xsgpKBa5tYi+Dtzc1zGfxzP3PbWYYvZbMl/GUREDM91cNffO9dMey+CseImnT9LwumvHQ==
X-Received: by 2002:a05:6402:5191:: with SMTP id q17mr34076167edd.332.1633519353148;
        Wed, 06 Oct 2021 04:22:33 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id bw25sm8912058ejb.20.2021.10.06.04.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 04:22:32 -0700 (PDT)
Message-ID: <1a05eaed-a725-f8fb-efb4-4e20a80fdef3@redhat.com>
Date:   Wed, 6 Oct 2021 13:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.10 1/7] selftests: KVM: Align SMCCC call with
 the spec in steal_time
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>, shuah@kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20211006111234.264020-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211006111234.264020-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/10/21 13:12, Sasha Levin wrote:
> From: Oliver Upton <oupton@google.com>
> 
> [ Upstream commit 01f91acb55be7aac3950b89c458bcea9ef6e4f49 ]
> 
> The SMC64 calling convention passes a function identifier in w0 and its
> parameters in x1-x17. Given this, there are two deviations in the
> SMC64 call performed by the steal_time test: the function identifier is
> assigned to a 64 bit register and the parameter is only 32 bits wide.
> 
> Align the call with the SMCCC by using a 32 bit register to handle the
> function identifier and increasing the parameter width to 64 bits.
> 
> Suggested-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Oliver Upton <oupton@google.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Message-Id: <20210921171121.2148982-3-oupton@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/testing/selftests/kvm/steal_time.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index fcc840088c91..7daedee3e7ee 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -120,12 +120,12 @@ struct st_time {
>   	uint64_t st_time;
>   };
>   
> -static int64_t smccc(uint32_t func, uint32_t arg)
> +static int64_t smccc(uint32_t func, uint64_t arg)
>   {
>   	unsigned long ret;
>   
>   	asm volatile(
> -		"mov	x0, %1\n"
> +		"mov	w0, %w1\n"
>   		"mov	x1, %2\n"
>   		"hvc	#0\n"
>   		"mov	%0, x0\n"
> 

Just fixing tests, but anyway:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

