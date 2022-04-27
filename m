Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08C511D09
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbiD0Qao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 12:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbiD0Q3q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 12:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3404941614
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651076736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpdTKSdO+rieFpHnkUAZpM/6Dw8rA4JkcSTNkjZ8rq0=;
        b=eBhHC4zoeb5yREbyJZ3KJ6Jn84tSibnSGPJ4bYz2OTmQv1fma/6keWPy5zesBypEKHKlR5
        B0P3dITKOft112NdcRRXO2ckLTRAxBjneFFx66tPypSkQ6Ih/AXVQbA7eQYfvrJ7g0vZeB
        P2eUn6eP9VL+/NqQAKm+Rt/ZOAEXvsA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-lVM2X5WEPZ2kL7EknadJoQ-1; Wed, 27 Apr 2022 12:19:29 -0400
X-MC-Unique: lVM2X5WEPZ2kL7EknadJoQ-1
Received: by mail-ed1-f70.google.com with SMTP id cz24-20020a0564021cb800b00425dfdd7768so1277645edb.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 09:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cpdTKSdO+rieFpHnkUAZpM/6Dw8rA4JkcSTNkjZ8rq0=;
        b=3tJ9mLdT0kw4QX3d897m479TETyDX9z8DyYhXwIJYB0Y5V0GmByTK1Hw7m2Iete5DL
         LXlxSvaj6ObqXIWglmbKuBY3rH7fnejJBFvedE1XKu3l+n9gAcQ4gYaUwhjMMi6iab1Y
         gdLjcvfpJ4sPtdbSlEG0WfBawbrE3fWoVWuKH+RApsdc31+8cd0CH6+ZQ8J5JcVW8Opz
         J2QAvukF7HR/Kc4K88+vh2QqUPBZnmFL7mi57iCPbC4tAn5p5SRlrQSsOFV03QIMF1Vm
         KkttfwbE/gNUGbmGpn3Nxshzn0YgsbbZFO6KmqFRaVQ/pfT8jmaVon3CK7aspok6h9xi
         JaIA==
X-Gm-Message-State: AOAM531haaNiGVZWYxs7rBOBcnl34lj40Pq2fvRyio7zTpX2JqspMn6T
        xAEeIs1iu1yjgttHdTYXJKS2aHqyv70ZgXV+p4QZSeVqAFvrGw7SnGpZ0Bv1s9qdaN3mH0bZ9A1
        OnZ0qoVVrUT+j6J2GyZrGXZElmRqR
X-Received: by 2002:a05:6402:4004:b0:426:1a0a:a2b8 with SMTP id d4-20020a056402400400b004261a0aa2b8mr2943530eda.241.1651076367941;
        Wed, 27 Apr 2022 09:19:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRi274/0pJFnefUE34/+I0M2mwYpfNL1VVyniwojXwdGQHhToi5cq0Vivpg5gmlGbu04FBdw==
X-Received: by 2002:a05:6402:4004:b0:426:1a0a:a2b8 with SMTP id d4-20020a056402400400b004261a0aa2b8mr2943517eda.241.1651076367773;
        Wed, 27 Apr 2022 09:19:27 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id t27-20020a1709063e5b00b006f3a94f5194sm3347586eji.77.2022.04.27.09.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:19:27 -0700 (PDT)
Message-ID: <032e22bd-4faa-7a0c-da78-8bf7ee3df31f@redhat.com>
Date:   Wed, 27 Apr 2022 18:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH MANUALSEL 5.15 2/7] KVM: selftests: Silence compiler
 warning in the kvm_page_table_test
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, shuah@kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20220427155431.19458-1-sashal@kernel.org>
 <20220427155431.19458-2-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220427155431.19458-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/27/22 17:54, Sasha Levin wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> [ Upstream commit 266a19a0bc4fbfab4d981a47640ca98972a01865 ]
> 
> When compiling kvm_page_table_test.c, I get this compiler warning
> with gcc 11.2:
> 
> kvm_page_table_test.c: In function 'pre_init_before_test':
> ../../../../tools/include/linux/kernel.h:44:24: warning: comparison of
>   distinct pointer types lacks a cast
>     44 |         (void) (&_max1 == &_max2);              \
>        |                        ^~
> kvm_page_table_test.c:281:21: note: in expansion of macro 'max'
>    281 |         alignment = max(0x100000, alignment);
>        |                     ^~~
> 
> Fix it by adjusting the type of the absolute value.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Message-Id: <20220414103031.565037-1-thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/testing/selftests/kvm/kvm_page_table_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
> index 36407cb0ec85..f1ddfe4c4a03 100644
> --- a/tools/testing/selftests/kvm/kvm_page_table_test.c
> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
> @@ -278,7 +278,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
>   	else
>   		guest_test_phys_mem = p->phys_offset;
>   #ifdef __s390x__
> -	alignment = max(0x100000, alignment);
> +	alignment = max(0x100000UL, alignment);
>   #endif
>   	guest_test_phys_mem &= ~(alignment - 1);
>   

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

