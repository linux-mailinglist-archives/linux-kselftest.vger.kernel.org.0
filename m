Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223795120D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbiD0QUi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbiD0QT5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 12:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 292DA81EDC
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651076175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BCGVOVE4BrBvRI9oAvbvlUF+mh0gl7wV1cgEkAFf8b8=;
        b=GnzhPJteNWxfgMvYksOgAQm7qzYw+U8C8F0VMwUL39PAGZEJzEtHY320fsAh415hvdD8/p
        hpKOr2F46I5A5a0Ub88JUNeAbvMNb/KVkXy2poZRcu8tTfIFKsTnB/weqC4cubKBdc+bG3
        t2N4QlG2pKi2aQofei9D3IhDcpyGtPU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-boa1WR88P5yV7v8QcyJ9aw-1; Wed, 27 Apr 2022 12:16:13 -0400
X-MC-Unique: boa1WR88P5yV7v8QcyJ9aw-1
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso1245303edt.20
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Apr 2022 09:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BCGVOVE4BrBvRI9oAvbvlUF+mh0gl7wV1cgEkAFf8b8=;
        b=5LcETZ25Mfxwx1fBZDNTRQo7H1u0Tm02doqZe9WBXcxmEgTBEV7u+p+dSlOUMs178f
         ogSV1tluod/fU7quhRSzqSoP40xS3eWS2gHtjuuMWCSluo/6I/Z1yFfI5Fq6N2/nAxGo
         2kh/8USAbJvFe7CTgvrlZo6bth8YrQYRWYvCfBX7OPaXYy241n0w6l4uhEwlCX0cRsW5
         3RTfi+28dkb4xsVtfKmARVesBA8mUWDNjHDaXxuxLYkMLOq23stYIcYccScS77XBYw5E
         eXi91Uda5d6LykCURUYEOdOWGn5f53JYkZ3+qZkTHephPYp0MEqr68p1xS0FwJffML+e
         JdxA==
X-Gm-Message-State: AOAM531SvJ6PsQa59WBhlBoREzSsVpQQHaEeZdeJrxEQRJ6Cit2T6aou
        M+0ZTq9HWmPM1wK3AUAvFqKrVWubRvv0o7viSEmtwbSghRvCKaGIaaExPV+gE6nacqE9iPOp+2s
        ujB7GyQWo4BBQ3y4aZsPI/Hm6Mkw0
X-Received: by 2002:a05:6402:3492:b0:426:19be:bf36 with SMTP id v18-20020a056402349200b0042619bebf36mr3018991edc.36.1651076172334;
        Wed, 27 Apr 2022 09:16:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLa/rdbgmbtTMS/S1RZQTjMkWaulDwEf9N3m0yQT932Jol6NqeU6tzU+mhIGEND/MurrsNGA==
X-Received: by 2002:a05:6402:3492:b0:426:19be:bf36 with SMTP id v18-20020a056402349200b0042619bebf36mr3018968edc.36.1651076172105;
        Wed, 27 Apr 2022 09:16:12 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id ot2-20020a170906ccc200b006ef9bb0d19bsm6995811ejb.71.2022.04.27.09.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:16:11 -0700 (PDT)
Message-ID: <e4ab4f93-bd2e-64e4-11f4-31ed0e9c8ebb@redhat.com>
Date:   Wed, 27 Apr 2022 18:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH MANUALSEL 5.17 2/7] KVM: selftests: Silence compiler
 warning in the kvm_page_table_test
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, shuah@kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20220427155408.19352-1-sashal@kernel.org>
 <20220427155408.19352-2-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220427155408.19352-2-sashal@kernel.org>
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

On 4/27/22 17:53, Sasha Levin wrote:
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
> index ba1fdc3dcf4a..2c4a7563a4f8 100644
> --- a/tools/testing/selftests/kvm/kvm_page_table_test.c
> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
> @@ -278,7 +278,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
>   	else
>   		guest_test_phys_mem = p->phys_offset;
>   #ifdef __s390x__
> -	alignment = max(0x100000, alignment);
> +	alignment = max(0x100000UL, alignment);
>   #endif
>   	guest_test_phys_mem = align_down(guest_test_phys_mem, alignment);
>   

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

