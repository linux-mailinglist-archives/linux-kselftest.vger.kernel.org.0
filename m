Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968EE6112EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ1Nfq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ1Nfk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 09:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A8917407
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 06:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666964078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFqYz8MMVuDJ4sSoQ0v9rsso2qX+yaIQ4KXzcvg1mhc=;
        b=UzfhsK/nK3ouN0E9bM6pmqsGEn4SK5yNxsBV86O30di+SUV5d3Iu+CyH0ugjLtMn8CbmjP
        UKGtokEOVuznoYDioGJXxnfFmpaiknUWtOgHddb5YhXsuOBnkIsXblrXiufKTTZjyYMpAG
        W0gIuHPBTE28nzA5i4puRFPREL/fcMU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-449-MDrYd5gfPoSXDlF1Dbtx-w-1; Fri, 28 Oct 2022 09:34:36 -0400
X-MC-Unique: MDrYd5gfPoSXDlF1Dbtx-w-1
Received: by mail-wm1-f72.google.com with SMTP id i128-20020a1c3b86000000b003cf4ff1b917so2316532wma.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 06:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFqYz8MMVuDJ4sSoQ0v9rsso2qX+yaIQ4KXzcvg1mhc=;
        b=2xoucroVaIGA8ut/UWbA6CKWi0gMTB2e/bjdgMM+wYTe4Jujz1h4iOM5fzfxT/dRTU
         slqWYRoHmmLX6Hhw+GJSHldLZrQPFVT3g0hWqJixNE0+Vr3sM5YzLnM7VJA0FbbCtX+r
         ETlT5VANhgSGkhbETukxlW+bdchms1dSS0EhqgqsTAMHKYjPpQ+BrI3CokSFL4/zhDxk
         x55yG45KphMjg1tl+zX+ozyP+XMjoLLwJmB6yRa/9H37h1tcHA1Rskff66kLBj8nFRgV
         tRr5vC/jgrwN98sIlcUl61VnAP1TCFR0VtI7/TX+ZAj+Kuez2z3cSFgpCtuuci8ce485
         Blew==
X-Gm-Message-State: ACrzQf2rxzjEaU/AN6yAT+9k/japtlYgntK0Gnh0RTdwSADF37utCeN7
        sqDMp7sqRmqsLbsy9ZJWzSzeZg3kgh5y9SJLeB5cqQoBFx/tuMhHda5I2BvzXHgzCRnJoBIoBS3
        ZhTDFqMm/4buB7qbpEJgwimHanJx5
X-Received: by 2002:a5d:5142:0:b0:236:5d8d:6254 with SMTP id u2-20020a5d5142000000b002365d8d6254mr22326932wrt.514.1666964075457;
        Fri, 28 Oct 2022 06:34:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4qPWmRdmYeva1c0+81ekf4TqzWM8LrMLcjdZN9VgV4/YuhTz4wVkJR4JMmkiMCMKDREkRZhQ==
X-Received: by 2002:a5d:5142:0:b0:236:5d8d:6254 with SMTP id u2-20020a5d5142000000b002365d8d6254mr22326919wrt.514.1666964075238;
        Fri, 28 Oct 2022 06:34:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id m64-20020a1ca343000000b003b49ab8ff53sm4266963wme.8.2022.10.28.06.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:34:34 -0700 (PDT)
Message-ID: <c0e342ac-32a3-4f92-65c1-e4c990af7698@redhat.com>
Date:   Fri, 28 Oct 2022 15:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND v4 16/23] KVM: x86: smm: add structs for KVM's
 smram layout
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Shuah Khan <shuah@kernel.org>,
        Guang Zeng <guang.zeng@intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Wei Wang <wei.w.wang@intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <20221025124741.228045-1-mlevitsk@redhat.com>
 <20221025124741.228045-17-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221025124741.228045-17-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/25/22 14:47, Maxim Levitsky wrote:
> +	u32 cr4; /* CR4 is not present in Intel/AMD SMRAM image */
> +	u32 reserved3[5];
> +
> +	/*
> +	 * Segment state is not present/documented in the Intel/AMD SMRAM image
> +	 * Instead this area on Intel/AMD contains IO/HLT restart flags.
> +	 */

Both of these are based on the Intel P6 layout at 
https://www.sandpile.org/x86/smm.htm.

Paolo

