Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79A60FD65
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 18:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiJ0QtP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiJ0QtO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 12:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4484618F932
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666889353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBR+zNlTAG21dDioM5sgF6nCCLjPvKzLkAHg4n7ta1Q=;
        b=WiQ+eTb8304LY2NZvSgNH2D1Pmh5r/Xd6NT487D8g9aRe54/6fKnqh6XHxfP8C/7DBo+PC
        yvnV4PIdkhVAN44wqfEYyCbA30mBIPgt5kHsIwFw26fv6MGF9Gg2W4yKEfYwUVz1/3qgfs
        N8X6eTujuBM8pf4OVmN5TbXHj1q6fgM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-yBAdHjc1OtSn0TuB-zKSMg-1; Thu, 27 Oct 2022 12:49:11 -0400
X-MC-Unique: yBAdHjc1OtSn0TuB-zKSMg-1
Received: by mail-wm1-f69.google.com with SMTP id v23-20020a1cf717000000b003bff630f31aso748859wmh.5
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 09:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBR+zNlTAG21dDioM5sgF6nCCLjPvKzLkAHg4n7ta1Q=;
        b=CplwqMP/DrP438u81U4zW4eJ/EF9i7r0Dc5Lz8X2cRsg4pL0mY61rVGxME32/Y+zAZ
         wga26pr0tpLc4h6jG22azmjwyGnEGvb/A+rTDyVk6b3z6/etZihKX95pavpxOpbDTZDh
         2FZf78rDcQYZ0v59bN+7rnsfweKg5VtROLdWXXF8+OSkIwOjgFg6Q/QcR5M0WGvsH8RN
         MIWjWTVJgHr9GXfYAfTD7LBzOkLTCvCrLOQoGxu+i+rbYSZuUgJeVYea+Yy2p7DAlpBR
         URjGtrn5nDJP/COHBB3EJHb/ZIBek238XB3OH0slA1nStDwMoCTKVD7AnRREOXklLjGP
         OSqw==
X-Gm-Message-State: ACrzQf0khXbdRs10swjlCS7yLH9MykeaZZaqvhVhTt0wcCgGNEXGGokR
        MPQNQh8jWyVg6Q0Bk6acnxKkhi8n8qk2O/sDvf63V0Y6JHWcXIT/Zka/Isn4jkNd+dh7+B9zm01
        btfoHPPAMOrKmXzlhJ6uoNeiv+m0d
X-Received: by 2002:a05:6000:10a:b0:236:6a79:f5cf with SMTP id o10-20020a056000010a00b002366a79f5cfmr15965899wrx.470.1666889350573;
        Thu, 27 Oct 2022 09:49:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Y6At6prTJyixBcdRFchUGzanWYZ2mDWqXwbRXFsEFagdyFpLO8S2LxyUFFO7cp89cHZAQDw==
X-Received: by 2002:a05:6000:10a:b0:236:6a79:f5cf with SMTP id o10-20020a056000010a00b002366a79f5cfmr15965875wrx.470.1666889350283;
        Thu, 27 Oct 2022 09:49:10 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id z17-20020a1c4c11000000b003b3365b38f9sm1937795wmf.10.2022.10.27.09.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 09:49:09 -0700 (PDT)
Message-ID: <0e3a0cab-1093-3e83-9e9c-f8639ebe5da0@redhat.com>
Date:   Thu, 27 Oct 2022 18:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RESEND v4 00/23] SMM emulation and interrupt shadow fixes
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
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20221025124741.228045-1-mlevitsk@redhat.com>
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
> This patch series is a result of long debug work to find out why
> sometimes guests with win11 secure boot
> were failing during boot.
> 
> During writing a unit test I found another bug, turns out
> that on rsm emulation, if the rsm instruction was done in real
> or 32 bit mode, KVM would truncate the restored RIP to 32 bit.
> 
> I also refactored the way we write SMRAM so it is easier
> now to understand what is going on.
> 
> The main bug in this series which I fixed is that we
> allowed #SMI to happen during the STI interrupt shadow,
> and we did nothing to both reset it on #SMI handler
> entry and restore it on RSM.

I have now sent out the final/new version of the first 8 patches and 
will review these tomorrow.  Thanks for your patience. :)

Paolo

