Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB671FE88
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjFBKHD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235030AbjFBKHC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20518D
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685700377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/4o5KVI77BlVl/SsXnA6hmV+WNss5tGdkSJs/FZiKs=;
        b=MkD7ZNNzSMbQ8uic4VmQbPDEoyipuaccDCJ8924rfMb8DJi7UMt1isCsOAG8ppCcOgDQww
        51q+6c3uBruQsxcvERFjmICcaoC2qnQMQX/yVjBnnbJyybAtrE9RN1GhAZHtOpB8fgTNEB
        o9gzsvDNX/K09blLryYctgywRWM3W+I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-92QT5K_mPAmDJ4Qv-TPrdQ-1; Fri, 02 Jun 2023 06:06:16 -0400
X-MC-Unique: 92QT5K_mPAmDJ4Qv-TPrdQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f60f085cd2so9778395e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 03:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700375; x=1688292375;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/4o5KVI77BlVl/SsXnA6hmV+WNss5tGdkSJs/FZiKs=;
        b=WeftTkf4wV1t946/MgDb2IFa50CN6B3F9OUh8RibuW4rgbsOf+Awz0c0ejdIVjYjt4
         QhE0XMAvU8BlUQnjWMuKwgoXzyAJNUvI37UHbX0her/pOu9RxAsBOS4XmcyE6q0Nm2Kg
         7cJg77QYFCs9Kc8CDYO1cGkglgcT2uG/4uNxAuhRL1sckiXBBhaU1zDvrHbDAo/Jd0vr
         zUWbKpM8DTq6M9ix6/o3dmUY9lYh2VY7GXCeOvtL1X9bHaCJ/bIwjlTByylFuAhAsSgc
         LkN3mG3Qi/I1pLxq2dPWbXV9kfvPScVkE1Myh4NSJGt6mfWZnYND5Nr+4uLGVeTl0DrH
         /Ccw==
X-Gm-Message-State: AC+VfDwpDHr9Malg4Nn2VZhaLlexNbVhb+ekapcTp2odokgBwBOJQNvk
        oBNGuiSt0WfRCSkL111BFg8Cxc9YMEZh1sCW+VLg0bBKYw5L0eON/gobPS66LbMrMJK6JkiH7uN
        dJUrtbvQp0L8dTqQpA6DBinsNKMqBzanWq4xZ
X-Received: by 2002:a7b:ca58:0:b0:3f4:2973:b8d0 with SMTP id m24-20020a7bca58000000b003f42973b8d0mr1546149wml.2.1685700375116;
        Fri, 02 Jun 2023 03:06:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70FZ+1GT9gQVRWpomb8FGIk0jAkglIxhP3xzmEEN3RtzdUITiglHxETsVNm5DsVkjfBZnOjA==
X-Received: by 2002:a7b:ca58:0:b0:3f4:2973:b8d0 with SMTP id m24-20020a7bca58000000b003f42973b8d0mr1546130wml.2.1685700374759;
        Fri, 02 Jun 2023 03:06:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id l22-20020a1c7916000000b003f6f6a6e760sm5026819wme.32.2023.06.02.03.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:06:14 -0700 (PDT)
Message-ID: <3a873bee-1a1e-36fb-889d-d27346c28a33@redhat.com>
Date:   Fri, 2 Jun 2023 12:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/12] selftests/mm: .gitignore: add mkdirty,
 va_high_addr_switch
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-7-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-7-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> These new build products were left out of .gitignore, so add them now.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/.gitignore | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 8917455f4f51..ab215303d8e9 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -39,3 +39,5 @@ local_config.h
>   local_config.mk
>   ksm_functional_tests
>   mdwe_test
> +mkdirty
> +va_high_addr_switch
> \ No newline at end of file

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

