Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5099737267E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 May 2021 09:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhEDHXl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 May 2021 03:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229806AbhEDHXl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 May 2021 03:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620112966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mhr4vtYbIV3+gcbn8jvNDanz77HnPGouREoZC9BXQoM=;
        b=SNwuBqbg7bnevrYr9RX7os7BHJjsvVu6ygpCl4U2VGy+yf8w7mHnubxyXEOL5gOFHojf0/
        m0vOW84WsC6Kuds0YA17KBwFKte4K70NdGnT/KmBf0vY+CbaROsNBOin1QWkLE4ZQORw5n
        fDuELjyszUpi54AzH2tTQi1dQXuSG3I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-K9J0mhN4OWiU78KcmE-JaQ-1; Tue, 04 May 2021 03:22:45 -0400
X-MC-Unique: K9J0mhN4OWiU78KcmE-JaQ-1
Received: by mail-ej1-f72.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso2758709ejn.10
        for <linux-kselftest@vger.kernel.org>; Tue, 04 May 2021 00:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mhr4vtYbIV3+gcbn8jvNDanz77HnPGouREoZC9BXQoM=;
        b=dBQS0Kui8d2lr8Wzf136x8n26Enc4CGK2fFstLgyqrfpq038YK/ItAbrm9XtZ8RpRz
         73P1zhV6Nixao8AAQR667JoaBLvupz8Zqhbmge9pNJnPqfVH83II6bEo0DFFHKZsULmU
         1jECLkX/QTbm5hAvivO7skucGErxqHl9WxELFkycdVzRCT5ak9AtVYay6VzUvXtYa94W
         nawCdJjsNHB5PobsR249MLwnQVCwaiVfmjYtKnoKsG3PwPxZYtdwmfs/EIV4aJZ1R67x
         Rbmg06zUw2kqb+uO4TjQ7TU3mCwIIwVsVgXrkdAJyrtcyXS1ihlzhlP5qnjx/jSLuOkv
         N8+g==
X-Gm-Message-State: AOAM530HM4VYk+3uzP7b5duOLf78b9hs3+hErJqkW/dKw3lxTsa7L47i
        J9LZW36ezafzoOUPfAfwq/QnAqbfuAHDgNm5djVI1B21HEAsRtxmEOC0SoDX/f4SLlkv83roCbL
        5fweyzmFlRE/j5JxUwJyBxaHGFtTm
X-Received: by 2002:aa7:d146:: with SMTP id r6mr20887983edo.344.1620112964220;
        Tue, 04 May 2021 00:22:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwg6GUPMEJ8U43lXv68gNhg8URZDrfW8WNW3qQKYNn5OC+cqrppm05kGj9FncYwc8cQ70hywA==
X-Received: by 2002:aa7:d146:: with SMTP id r6mr20887973edo.344.1620112964071;
        Tue, 04 May 2021 00:22:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q16sm14022935edv.61.2021.05.04.00.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 00:22:43 -0700 (PDT)
Subject: Re: [PATCH v2] selftests: kvm: remove reassignment of non-absolute
 variables
To:     Jim Mattson <jmattson@google.com>, Bill Wendling <morbo@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Shuah Khan <shuah@kernel.org>, Jian Cai <caij2003@gmail.com>
References: <X9LJE6ElVfKECnno@google.com>
 <20201211012317.3722214-1-morbo@google.com>
 <CALMp9eSvMtaXndor9=h40utaefQs9BPKknV7nbWFQi0phr_TvA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <01ac0ff6-f35b-5bab-a355-edcb499cd2d2@redhat.com>
Date:   Tue, 4 May 2021 09:22:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eSvMtaXndor9=h40utaefQs9BPKknV7nbWFQi0phr_TvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/05/21 20:37, Jim Mattson wrote:
> On Thu, Dec 10, 2020 at 7:58 PM Bill Wendling <morbo@google.com> wrote:
>>
>> Clang's integrated assembler does not allow symbols with non-absolute
>> values to be reassigned. Modify the interrupt entry loop macro to be
>> compatible with IAS by using a label and an offset.
>>
>> Cc: Jian Cai <caij2003@gmail.com>
>> Signed-off-by: Bill Wendling <morbo@google.com>
>> References: https://lore.kernel.org/lkml/20200714233024.1789985-1-caij2003@gmail.com/
> Reviewed-by: Jim Mattson <jmattson@google.com>
> 

Queued, thanks.

Paolo

