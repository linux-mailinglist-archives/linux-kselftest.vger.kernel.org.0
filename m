Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6631551C0DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 May 2022 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379800AbiEENgt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 May 2022 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379794AbiEENga (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 May 2022 09:36:30 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 907975710F
        for <linux-kselftest@vger.kernel.org>; Thu,  5 May 2022 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651757546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+kiADHH0OTUEekRfTTqboMY0mUFLqzmSHiGBuu3QXQA=;
        b=UTMoBhW4SoONg1+zanmHNFXftfBWlFuobTeaCDOz/J1CgZJR2zF9qJaN5cLiGxwnojQ09P
        XJCUMKnZdNWW8JuXQZU5P1R6o/GKodqunViH10vBltMaQCShVIWjlv+huAXO/OsE6yVxqw
        PWjwak1p/BB4gtaqWRM+pTLoxFIQ3ME=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-FpL9IBxmPcmL1qN8ag_OjQ-1; Thu, 05 May 2022 09:32:25 -0400
X-MC-Unique: FpL9IBxmPcmL1qN8ag_OjQ-1
Received: by mail-ed1-f72.google.com with SMTP id cf16-20020a0564020b9000b00425d543c75dso2330217edb.11
        for <linux-kselftest@vger.kernel.org>; Thu, 05 May 2022 06:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+kiADHH0OTUEekRfTTqboMY0mUFLqzmSHiGBuu3QXQA=;
        b=WOkHR6MHmqmJVkjCiy+vkGIHAS16K2LjTzUSjmGBFd8QhAgddfAoeVtdqryzMNhWmo
         cu1NN8/U5dMt4MFpH+BV39pvYqi3GmeaCqdszZsFAlXM0i7ct3mU0tznfpqXpEV7RpQX
         wHz9fo8vhLRTNJLgaa39tz6ZMP05Ief+9SMcOx0lgWbW61j19TKSvU5GSOcL5FhNNSIq
         VTOf3uDHKY1dvmhfProZAT4VoYMu4MN3gcEkPa7+f+iwKy6HJUjy4naa1pHBE74QI7tt
         OUk4fmrUbSCAHGKP7MNyx4wi0KrQtdKQLxyi2of8UtLRJ5WIaLGgj7zZavVOSN/jbkuK
         KauA==
X-Gm-Message-State: AOAM532SFB+ALzo9/cdmL1DKWQHnpRq8nWyAuPnY1jqOSwi8sHhbqrIx
        itWnX/wb9aQUd2ms69RIzLvOYC16L1SuQ6IG3SGexhLPJ5Ex9WjK2xIPq7tMln7H+oo5PPnCjwD
        71cNO3t6xvZhUcw5lP5R24duC4Q27
X-Received: by 2002:a17:907:9053:b0:6f3:9f7e:5325 with SMTP id az19-20020a170907905300b006f39f7e5325mr26644997ejc.455.1651757544345;
        Thu, 05 May 2022 06:32:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy52UhctkwW9yt5QGwSz6n+bp/2FcbovNN8FC8hnhQ4d8qEEUMnISxAnpY/IrKzXNsv5I+1WQ==
X-Received: by 2002:a17:907:9053:b0:6f3:9f7e:5325 with SMTP id az19-20020a170907905300b006f39f7e5325mr26644966ejc.455.1651757544125;
        Thu, 05 May 2022 06:32:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id bc20-20020a056402205400b0042617ba63cesm812545edb.88.2022.05.05.06.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 06:32:23 -0700 (PDT)
Message-ID: <688a817f-b2e2-4620-ef4b-f3c5f73ae34d@redhat.com>
Date:   Thu, 5 May 2022 15:32:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] selftests: KVM: aarch64: Let hypercalls use UAPI
 *_BIT_COUNT
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@google.com>
Cc:     Raghavendra Rao Ananta <rananta@google.com>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20220504184415.1905224-1-rananta@google.com>
 <YnLa8uH55/epyjlS@google.com> <87zgjw6v9k.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87zgjw6v9k.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/5/22 14:04, Marc Zyngier wrote:
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index e523bb6eac67..3cde9f958eee 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -342,6 +342,10 @@ struct kvm_arm_copy_mte_tags {
>   
>   enum {
>   	KVM_REG_ARM_STD_BIT_TRNG_V1_0	= 0,
> +	/*
> +	 * KVM_REG_ARM_STD_BMAP_BIT_COUNT will vary as new services
> +	 * are added, and is explicitely not part of the ABI.
> +	 */
>   	KVM_REG_ARM_STD_BMAP_BIT_COUNT,
>   };

That seems like a bad idea.  Perhaps you can wrap it in #ifdef 
__KERNEL_OR_SELFTESTS__?  I can't find any prior art.

Paolo

