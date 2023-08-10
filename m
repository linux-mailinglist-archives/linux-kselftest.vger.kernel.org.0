Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB916777A17
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 16:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjHJOEU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjHJOET (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 10:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678F2127
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691676213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlAONK5WQTaqTvjs/IJt1TfwjeXJy9baGm//on5NsDU=;
        b=S1FSu+KaxEbovEd9w28DEybPbOkUHMW7Hhvoi6GrMRo4tZbhpym/osnRhd08Kp+hMJ0SxI
        535veCBJGdUWVElz92EfHQzBB1A+DXgUwJM62k4v440X5SfMUlv7bmJ4VYlxqHOQj4idaZ
        axoI05BB2MRO9hKNExLKLvKjSRh2b7Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-nst3ukmCOvKVmxuAWJr7lA-1; Thu, 10 Aug 2023 10:03:31 -0400
X-MC-Unique: nst3ukmCOvKVmxuAWJr7lA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fe517ca810so5611635e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 07:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676201; x=1692281001;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlAONK5WQTaqTvjs/IJt1TfwjeXJy9baGm//on5NsDU=;
        b=kpjB1LMRw3kNWHmQgAtg4hYG2XRxV9beD5ASpOQhXyKqHuItbo5C8DxkHZOERr7eG/
         UcXpjQ7sUCgDjvF2k8RJswGicP0+nPk5UJvwGRPefDp+Lfq3hoDLZVnmgcX6vaSNwgil
         /8qmQBTvbyjuN9sWsjf3GEP9Hjz9JnvR8pUzujyTJaPZoONm3p2BigI2oC0yowQA5/dy
         faVMyT5rqlZ5AyLX0miMdvqFGKrWACPm9eDVA4UyDWyHMJx2ZJlp64Y5KpYmLwqFvi1F
         tSME/CEeFEMezV8FFWT6xoe6QZvXfpbb94T+ZRh427AdxzyDWIJRy6n3Xg7Oj2Xwl+vJ
         cPlw==
X-Gm-Message-State: AOJu0Yx5A+LviJcwscFGl9z3gspBAtYKFkJojCoL97XGVlnhZwPEb3hw
        DnqkKssVDcmdcZuvcGNG5kll35sHSDi+HWPlqfYqO9HEjUwLb+XHoC3fmacOMtsOHk6Z0J/hI1h
        zVoVVpuwFLv/xF2ncseidCvf4YHwT0xRetV5S
X-Received: by 2002:a05:600c:4685:b0:3fe:b78:f4b1 with SMTP id p5-20020a05600c468500b003fe0b78f4b1mr1898369wmo.2.1691676201675;
        Thu, 10 Aug 2023 07:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwH4c+ibBCE7JaCGWrshMbWFduUcHCjQpgp+Gizgr2r1PQ5mWl8LEmTu1VHsDdW6O4HOwjdg==
X-Received: by 2002:a05:600c:4685:b0:3fe:b78:f4b1 with SMTP id p5-20020a05600c468500b003fe0b78f4b1mr1898337wmo.2.1691676201343;
        Thu, 10 Aug 2023 07:03:21 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id v1-20020adff681000000b00313e2abfb8dsm2279337wrp.92.2023.08.10.07.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:03:20 -0700 (PDT)
Message-ID: <d6858d5c-7db6-6e4c-7f07-92ff3340e02b@redhat.com>
Date:   Thu, 10 Aug 2023 16:03:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Ackerley Tng <ackerleytng@google.com>, seanjc@google.com,
        tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, erdemaktas@google.com,
        mail@maciej.szmigiero.name, vbabka@suse.cz, david@redhat.com,
        qperret@google.com, michael.roth@amd.com, wei.w.wang@intel.com,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        kirill.shutemov@linux.intel.com
References: <cover.1691446946.git.ackerleytng@google.com>
 <196a2130f155cbc0201cce06579f122352c8b236.1691446946.git.ackerleytng@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 08/11] KVM: x86: Let moving encryption context be
 configurable
In-Reply-To: <196a2130f155cbc0201cce06579f122352c8b236.1691446946.git.ackerleytng@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/23 01:01, Ackerley Tng wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 75d48379d94d..a1a28dd77b94 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6351,7 +6351,14 @@ static int kvm_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
>   	if (r)
>   		goto out_mark_migration_done;
>   
> -	r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, source_kvm);
> +	/*
> +	 * Different types of VMs will allow userspace to define if moving
> +	 * encryption context should be supported.
> +	 */
> +	if (kvm->arch.vm_move_enc_ctxt_supported &&
> +	    kvm_x86_ops.vm_move_enc_context_from) {
> +		r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, source_kvm);
> +	}

Rather than "supported" this is more "required".  So  perhaps 
kvm->arch.use_vm_enc_ctxt_op?

Paolo

