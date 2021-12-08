Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E04B46D4FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 15:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhLHOHx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 09:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbhLHOHx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 09:07:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57148C0617A1;
        Wed,  8 Dec 2021 06:04:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r25so8677021edq.7;
        Wed, 08 Dec 2021 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TBUtI121OAYubHou6K+iGseMAQxpxuvDIj0cwDzNJqI=;
        b=XDQoWKFfZPYKzdXWBFgZEyaaeck29w5cQxaeXX4rc0gfQs5YayoyqELY2PHCEdGmec
         2/nQEGtosBLPuTR6/3UhXDXfQ0nJlBJ4eOqKGAF9IBgw/yKAs3mvDd/MI/+QJm7+Juve
         Ag0GYsr/yQKjTjhlY4mYB/iXJ80Y8MzD+Vk3m7d/7BySn5F3KcZbHGhELfgdlwIc2LdQ
         xuJdNHtb6k5yOfCbrObR6FAnlsDSeTpsiKyBX8sQIjRUXaZcCsABt5+bSIrx90L4w452
         N4pprP86c8Z2FhkB7s2WQ6ot5TemC4zMgCPNCs6raJU2Wm2UOyVofvUqp2V0xCEFtkxq
         aZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TBUtI121OAYubHou6K+iGseMAQxpxuvDIj0cwDzNJqI=;
        b=VpBabHT7iv8pfJn3gdzXti4qgQyAQ+Mfx30555LFN1Xfwtdfyf+q2isHTB12mo2pPE
         EboMJ3sONdDIx7KoF8yza4zbXx+dnAwHBIOAD5ZZbRyBumkK72Dzp5gyPlQW1Ovhggtw
         GrzPE9dWqcodDfElGgBL7ITNi3XCEY8xUGZGqIrJnBtNtPFBbQVZuLlXgKdqnXZWp6j3
         bqCpyS+oq5jj4O5wc1+q7tzHiyyUk61qEB4hYW9kUJWiIKtUE6golpJ6UFhmGyRUAvuJ
         +fJURGr2FS5kjOcdPFUpH1J2Kkj8SbHAZLhV+gtLyfYEI8OKm9uzciOSfHYbjQD1/lmy
         +Uxg==
X-Gm-Message-State: AOAM532kfwfdCRZqz3wuSPODK8Wo6CfLIM6vaqGHT6S9WVXcphOuXJ1t
        77j6fEBjrqVI0WV3TwCfA8c=
X-Google-Smtp-Source: ABdhPJzxxlC2sYuxVCXO3ljUM6bUbtDlrhVV5jS4H2NT8K4TCYMvtjT595/ZiKCqpu1ImdiaJ1vN/w==
X-Received: by 2002:a17:907:9802:: with SMTP id ji2mr7921534ejc.418.1638972259854;
        Wed, 08 Dec 2021 06:04:19 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id jg32sm1817512ejc.43.2021.12.08.06.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 06:04:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <111d46ba-0a9b-fdb2-d8c4-fe8045edc092@redhat.com>
Date:   Wed, 8 Dec 2021 15:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] KVM: x86: selftests: svm_int_ctl_test: fix intercept
 calculation
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <49b9571d25588870db5380b0be1a41df4bbaaf93.1638486479.git.maciej.szmigiero@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <49b9571d25588870db5380b0be1a41df4bbaaf93.1638486479.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/3/21 00:10, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> INTERCEPT_x are bit positions, but the code was using the raw value of
> INTERCEPT_VINTR (4) instead of BIT(INTERCEPT_VINTR).
> This resulted in masking of bit 2 - that is, SMI instead of VINTR.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> index df04f56ce859..30a81038df46 100644
> --- a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> @@ -75,7 +75,7 @@ static void l1_guest_code(struct svm_test_data *svm)
>   	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
>   
>   	/* No intercepts for real and virtual interrupts */
> -	vmcb->control.intercept &= ~(1ULL << INTERCEPT_INTR | INTERCEPT_VINTR);
> +	vmcb->control.intercept &= ~(BIT(INTERCEPT_INTR) | BIT(INTERCEPT_VINTR));
>   
>   	/* Make a virtual interrupt VINTR_IRQ_NUMBER pending */
>   	vmcb->control.int_ctl |= V_IRQ_MASK | (0x1 << V_INTR_PRIO_SHIFT);
> 

Queued, thanks.

Paolo
