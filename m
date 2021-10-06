Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06699423F78
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbhJFNi1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Oct 2021 09:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238764AbhJFNiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Oct 2021 09:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633527391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u/piGMVcmtfQU410RPWuDNLfDkB4Ox9Tyhdds4zXiGs=;
        b=e9SqbkpKbs7uqZNOWcO3eXFxlML1RH9pkkmSrTstf7EXfp1jbTvVAsWTtLrh1xFRkO6BhI
        lDs3u5OjFmFW7D1s2hDq0b33Rn9JMJpPhXRzt+aSnQEqCEQVAIPLB0Zzy7XFWUlJF7mjKP
        B6GvIbk1wj4At//X5ONfuGCnF9WNS5I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-SSeEHp-RPFelRriN_Y7vdQ-1; Wed, 06 Oct 2021 09:36:20 -0400
X-MC-Unique: SSeEHp-RPFelRriN_Y7vdQ-1
Received: by mail-ed1-f72.google.com with SMTP id v9-20020a50d849000000b003db459aa3f5so86063edj.15
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 06:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=u/piGMVcmtfQU410RPWuDNLfDkB4Ox9Tyhdds4zXiGs=;
        b=TWKvSyP865wwMSZtnFlmk+51hiuKXjotVRREyFKNYyB6VJ6aRzfHI4HG2mljaX6gCR
         MZqDDGd53k2CAlVAotUZkYqsJzYuvPj/rlMlKXiYyWWDQHTBAamG+Pl/rHzQZRuqACZW
         z4RVnx3KdzvRQ9IeGmgLuJNmKJk3Jm6T1LGhlbJKjVTOJmytNt/4iqUn67yGj8QhfIzv
         c2Ge3iAOJKgT2KEzjp6kOP7oW6u4d10GI51zK5QFV4oRmZWZH+QFuws87OsubDePgaKj
         2Rh71cFSOM/5j0N84frSC0J1L7HRKaWWaiLmRGH0XHjZMSDK0eDfv7CZ4/LqgZ0V9o70
         D+eQ==
X-Gm-Message-State: AOAM5319B5/2G2X9Mu8/xs5eMOttCfN5ztbq6pWmN1Gj7tVDbCsfFwCj
        JJ4yJgXA/DsJ0uCmsPT8YndsmsyhCNbbSUzBUjwVQJBC8meBx5P0xb5dzlpSBh6tQNot9aRUluS
        CUJRfY7zz7P8eST9c1cP0RA20UC1j
X-Received: by 2002:aa7:d5cd:: with SMTP id d13mr30216043eds.232.1633527379435;
        Wed, 06 Oct 2021 06:36:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHZgwmbw5yaPBNCqM31MvnEW6sUbXSRH0z3uAhPPHeOJiVcbVeK/3vI44F2LwrPoIKi3mW8A==
X-Received: by 2002:aa7:d5cd:: with SMTP id d13mr30216018eds.232.1633527379258;
        Wed, 06 Oct 2021 06:36:19 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id j3sm4693182ejy.65.2021.10.06.06.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 06:36:18 -0700 (PDT)
Message-ID: <61759137-0182-8eed-6413-80a8fc82c6e8@redhat.com>
Date:   Wed, 6 Oct 2021 15:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.14 1/9] selftests: KVM: Align SMCCC call with
 the spec in steal_time
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>, shuah@kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20211006133021.271905-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211006133021.271905-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/10/21 15:30, Sasha Levin wrote:
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
> index ecec30865a74..aafaa8e38b7c 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -118,12 +118,12 @@ struct st_time {
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

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

