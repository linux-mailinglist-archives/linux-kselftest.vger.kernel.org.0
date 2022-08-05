Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9775458AA47
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Aug 2022 13:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiHELmr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Aug 2022 07:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbiHELmq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Aug 2022 07:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB9EA2C109
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Aug 2022 04:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659699764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YULnOCGvgRdgsuI4kIdPgoqcS1vxVsdQD9rykb/ZF+A=;
        b=WMaf6u9a4blHsgbOYWxR8N98FzHqgGdCOt5cFQl+++WjihmsFniazitTEO3sbiq5ik/oKX
        lSO3ob995z+25TR+WmL97I+y8fpbNGYBeoVe8S3NhXUssREpuhLupmUiYVsKg0U8Uye2Kt
        mIB+Mhj7jkz0A01/uoTDHMNQiQ4VGWE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-D4Lp8SwRMLmN8xiRurmGXg-1; Fri, 05 Aug 2022 07:42:43 -0400
X-MC-Unique: D4Lp8SwRMLmN8xiRurmGXg-1
Received: by mail-ed1-f69.google.com with SMTP id b13-20020a056402350d00b0043dfc84c533so1451177edd.5
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Aug 2022 04:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YULnOCGvgRdgsuI4kIdPgoqcS1vxVsdQD9rykb/ZF+A=;
        b=1WLpfjDw4ix3xWGX8bXkjZP7NscT3LcboRGdC7Ww4Pm2PdVG60KyK8x3g/tSCMJ9+b
         EViM0T2lH7t1AbuGEtbzTICz4lg+LdBZY16fENK2lHwK9cAg35qpFluDD7pb66eDI2mY
         Gw/rnOV/oGcOidb9oNB7sRCKEEaJi9y90iJZfwMiFZ7Cjm7270hMOfKu+trtcdWI11Uj
         iLFKrkKqdEMMh+XpMmlCHklQGQA7kLHRtP6Jpdd593WIqr9n15Wq554nKHYGKBDxM179
         kjUzU1leAWpYcyCXu1fBti+5uP1Ui4iXmyO3kluZ8UuSi78yb6LYdZPF5CHI2eDPPkT0
         StLw==
X-Gm-Message-State: ACgBeo2ntEwdX3pwDWhytMiS94ILB6q+vOxLGstFnkGF2nNqXU5DR/6s
        oVJIP88ZQDnh/ArkBaIm3joBdgk9sPA9hL9LNeWizViikWxcIztp64Re/u5dVzyMrDAcoBT/i2M
        JIpDjZqzsh0Kwcn84QPCLDT0RMSsg
X-Received: by 2002:a17:907:2848:b0:730:cab8:3ce5 with SMTP id el8-20020a170907284800b00730cab83ce5mr5037958ejc.718.1659699761908;
        Fri, 05 Aug 2022 04:42:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5HxMkRlLw6inVe2Nj6HJM817DYecrkEFv6oGLkdtosgwkO1ubuip5wVqyzC5bFkkcud/Rczw==
X-Received: by 2002:a17:907:2848:b0:730:cab8:3ce5 with SMTP id el8-20020a170907284800b00730cab83ce5mr5037937ejc.718.1659699761664;
        Fri, 05 Aug 2022 04:42:41 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id f17-20020a056402005100b0043ceb444515sm1979801edu.5.2022.08.05.04.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 04:42:41 -0700 (PDT)
Message-ID: <ae0a0049-8db0-501b-79e4-cd32758156fb@redhat.com>
Date:   Fri, 5 Aug 2022 13:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [kvm-unit-tests PATCH 2/4] x86: emulator.c cleanup: Use ASM_TRY
 for the UD_VECTOR cases
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Michal Luczaj <mhal@rbox.co>
Cc:     kvm@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
References: <Yum2LpZS9vtCaCBm@google.com> <20220803172508.1215-1-mhal@rbox.co>
 <20220803172508.1215-2-mhal@rbox.co> <Yuq8mumnrww9rlnz@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yuq8mumnrww9rlnz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/3/22 20:21, Sean Christopherson wrote:
>> I've noticed test_illegal_movbe() does not execute with KVM_FEP.
>> Just making sure: is it intentional?
> It's intentional.  FEP isn't needed because KVM emulates MOVBE on #UD when it's
> not supported by the host, e.g. to allow migrating to an older host.
> 
> 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f0),
> 	GP(EmulateOnUD | ModRM, &three_byte_0f_38_f1),
> 

*puts historian hat on*

The original reason was to test Linux using MOVBE even on non-Atom 
machines, when MOVBE was only on Atoms. :)

Paolo

