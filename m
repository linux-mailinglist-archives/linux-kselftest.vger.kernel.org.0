Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C6E67C48D
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 07:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjAZGte (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 01:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjAZGtd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 01:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C5E3C29
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 22:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674715733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmaQytAd5teTparcEG1b1oyi2EiAKphXrn+FZrXb+Qo=;
        b=IiipaUj2gmTNVi6mNaCWfkA34xEPki2kbGnVYbpNkmNXpdUXWDNcceFxzsfPSa7rj3xKa9
        uPX0DNFaIdB9xdq82zMtxb4ggq3qQ3fAnqkWPJ/eDYwzfD9nlCaAysfL1ylVi33ScjGcFQ
        9e2wFcYKpdpl94kRNKJcw1chHFe++rQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-4nu_a46CPbCFcyc7U72iEw-1; Thu, 26 Jan 2023 01:48:52 -0500
X-MC-Unique: 4nu_a46CPbCFcyc7U72iEw-1
Received: by mail-qk1-f197.google.com with SMTP id a3-20020a05620a438300b007069b068069so542491qkp.2
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 22:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmaQytAd5teTparcEG1b1oyi2EiAKphXrn+FZrXb+Qo=;
        b=6T41Kwja+8Xsk8qOJdwRS6Vm6jA0hXe/y010RvaoWjwLJ7pYYhQwn4OY/tRfCPHumy
         lGZg4LRPuJZgYvZuzR8pwLhbWwMQ1VojiP8lfO2BhNMHvxM1y3HpeayMJnPqP9lST0V1
         dw6nHMZCwlMxGo02kTPEns2NPT1N0D33wnlOIT3P9+e6xQD65cp7En27lmSFrP6lGOMd
         fvtlJJPyDn/buXzKSzhYeKuzREcOLqaKUdB4q677GLNIePkTklwI4GF37LR1zQG92dH8
         dq6jog/oSld1kAX3fHrIPqz+LGdABlwnstbkzFpQ/eieZ6vl+vmGdr7/Am352R0bWP2f
         ouEg==
X-Gm-Message-State: AO0yUKXFqROpMy8dW98fiNz5Jvghh73yajTmeB/lhU+x6eUeOkaNf29m
        dP3KE2OPPQxBTEGIogZ7fopQw0LsGLxULxjhAA/BYti7XLZGEEo7mSqrG4ei1vE5MoyPT5J2uH8
        zad166Dh3wUGTvGlGhajaju/mNPew
X-Received: by 2002:ac8:7dd5:0:b0:3b0:d422:1cbe with SMTP id c21-20020ac87dd5000000b003b0d4221cbemr2751023qte.10.1674715731570;
        Wed, 25 Jan 2023 22:48:51 -0800 (PST)
X-Google-Smtp-Source: AK7set90BkmPDKwMD/1Qt0FIfZGx66CPV1T0quAs3f1ZGGwe1yW0KU3JJXf3B7GHqjaXgkSzLHxxOw==
X-Received: by 2002:ac8:7dd5:0:b0:3b0:d422:1cbe with SMTP id c21-20020ac87dd5000000b003b0d4221cbemr2751000qte.10.1674715731308;
        Wed, 25 Jan 2023 22:48:51 -0800 (PST)
Received: from [192.168.8.105] (tmo-064-101.customers.d1-online.com. [80.187.64.101])
        by smtp.gmail.com with ESMTPSA id fb23-20020a05622a481700b003b62cd6e60esm253556qtb.43.2023.01.25.22.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 22:48:50 -0800 (PST)
Message-ID: <a1141cf5-8c44-5e9e-688c-c9dab3ebe8d4@redhat.com>
Date:   Thu, 26 Jan 2023 07:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
 <20230125212608.1860251-9-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 08/14] KVM: s390: Move common code of mem_op functions
 into functions
In-Reply-To: <20230125212608.1860251-9-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/01/2023 22.26, Janis Schoetterl-Glausch wrote:
> The vcpu and vm mem_op ioctl implementations share some functionality.
> Move argument checking and buffer allocation into functions and call
> them from both implementations.
> This allows code reuse in case of additional future mem_op operations.
> 
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 80 +++++++++++++++++++++-------------------
>   1 file changed, 42 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e4890e04b210..e0dfaa195949 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2764,24 +2764,44 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>   	return r;
>   }
>   
> -static bool access_key_invalid(u8 access_key)
> +static int mem_op_validate_common(struct kvm_s390_mem_op *mop, u64 supported_flags)
>   {
> -	return access_key > 0xf;
> +	if (mop->flags & ~supported_flags || !mop->size)
> +		return -EINVAL;
> +	if (mop->size > MEM_OP_MAX_SIZE)
> +		return -E2BIG;
> +	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
> +		if (mop->key > 0xf)
> +			return -EINVAL;
> +	} else {
> +		mop->key = 0;
> +	}
> +	return 0;
> +}
> +
> +static void *mem_op_alloc_buf(struct kvm_s390_mem_op *mop)
> +{
> +	void *buf;
> +
> +	if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)
> +		return NULL;
> +	buf = vmalloc(mop->size);
> +	if (!buf)
> +		return ERR_PTR(-ENOMEM);
> +	return buf;
>   }
>   
>   static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
> -	u64 supported_flags;
>   	void *tmpbuf = NULL;

You likely can now remove the "= NULL" here, I guess?

>   	int r, srcu_idx;
>   
> -	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
> -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
> -	if (mop->flags & ~supported_flags || !mop->size)
> -		return -EINVAL;
> -	if (mop->size > MEM_OP_MAX_SIZE)
> -		return -E2BIG;
> +	r = mem_op_validate_common(mop, KVM_S390_MEMOP_F_SKEY_PROTECTION |
> +					KVM_S390_MEMOP_F_CHECK_ONLY);
> +	if (r)
> +		return r;
> +
>   	/*
>   	 * This is technically a heuristic only, if the kvm->lock is not
>   	 * taken, it is not guaranteed that the vm is/remains non-protected.
> @@ -2793,17 +2813,9 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	 */
>   	if (kvm_s390_pv_get_handle(kvm))
>   		return -EINVAL;
> -	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
> -		if (access_key_invalid(mop->key))
> -			return -EINVAL;
> -	} else {
> -		mop->key = 0;
> -	}
> -	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
> -		tmpbuf = vmalloc(mop->size);
> -		if (!tmpbuf)
> -			return -ENOMEM;
> -	}
> +	tmpbuf = mem_op_alloc_buf(mop);
> +	if (IS_ERR(tmpbuf))
> +		return PTR_ERR(tmpbuf);
>   
>   	srcu_idx = srcu_read_lock(&kvm->srcu);
>   
> @@ -5250,28 +5262,20 @@ static long kvm_s390_vcpu_mem_op(struct kvm_vcpu *vcpu,
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
>   	void *tmpbuf = NULL;

... and here, too.

But I have to admit that I'm also not sure whether I like the 
mem_op_alloc_buf() part or not (the mem_op_validate_common() part looks fine 
to me) : mem_op_alloc_buf() is a new function with 11 lines of code, and the 
old spots that allocate memory were only 5 lines of code each, so you now 
increased the LoC count and additionally have to fiddly with IS_ERR and 
PTR_ERR which is always a little bit ugly in my eyes ... IMHO I'd rather 
keep the old code here. But that's just my 0.02 €, if you think it's nicer 
with mem_op_alloc_buf(), I won't insist on keeping the old code.

  Thomas


> -	int r = 0;
> -	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
> -				    | KVM_S390_MEMOP_F_CHECK_ONLY
> -				    | KVM_S390_MEMOP_F_SKEY_PROTECTION;
> +	int r;
>   
> -	if (mop->flags & ~supported_flags || mop->ar >= NUM_ACRS || !mop->size)
> +	r = mem_op_validate_common(mop, KVM_S390_MEMOP_F_INJECT_EXCEPTION |
> +					KVM_S390_MEMOP_F_CHECK_ONLY |
> +					KVM_S390_MEMOP_F_SKEY_PROTECTION);
> +	if (r)
> +		return r;
> +	if (mop->ar >= NUM_ACRS)
>   		return -EINVAL;
> -	if (mop->size > MEM_OP_MAX_SIZE)
> -		return -E2BIG;
>   	if (kvm_s390_pv_cpu_is_protected(vcpu))
>   		return -EINVAL;
> -	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
> -		if (access_key_invalid(mop->key))
> -			return -EINVAL;
> -	} else {
> -		mop->key = 0;
> -	}
> -	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
> -		tmpbuf = vmalloc(mop->size);
> -		if (!tmpbuf)
> -			return -ENOMEM;
> -	}
> +	tmpbuf = mem_op_alloc_buf(mop);
> +	if (IS_ERR(tmpbuf))
> +		return PTR_ERR(tmpbuf);
>   
>   	switch (mop->op) {
>   	case KVM_S390_MEMOP_LOGICAL_READ:

