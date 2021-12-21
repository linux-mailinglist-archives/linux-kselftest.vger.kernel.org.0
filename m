Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9066347C4EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 18:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhLURXN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 12:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232583AbhLURXN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 12:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640107392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgNFiSHVPmozrMAwLoLE4jQsVCvOy69kXUCzJ2IDG40=;
        b=Avb0SFPLk6j5Eg4yv023KlpIFagfk0rQfEKLxny+B3f/9KHowndQupaaI0J3bbOFl5yEaZ
        67kVqufGur2Qm7caJ2FElzbHrqe5lHJWKENoXe7pPervfV9+HPKRshPR1mv2rFitNFZyYE
        TW2sVJubKi/NcuoV1n0Jm2EU6+sGik0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-zLIlwlS0NH2ql7saAx1WvQ-1; Tue, 21 Dec 2021 12:23:11 -0500
X-MC-Unique: zLIlwlS0NH2ql7saAx1WvQ-1
Received: by mail-wm1-f69.google.com with SMTP id az35-20020a05600c602300b00345812649ddso1278306wmb.8
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 09:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cgNFiSHVPmozrMAwLoLE4jQsVCvOy69kXUCzJ2IDG40=;
        b=CY/I2EXlLxbsP7x5siHtrw+9vgsBqAquJBPATNv7wezrFL8B1GK4G577HeOTkpZs9T
         jMQI32pBvmhhxyBqVfJ2IoQEJoiy1w3vtk3s5QlPRvMoooDGIMhVzinXLtBdZGQZHe16
         oT6Tb82A+FSWCX/9iwhzH+CoDKXfrbzr6nguAFDYj7yCeljbJNeH56mNHTMvbO4M/EOD
         mJXx8P/3TUpAWsSe2tbdYRfhnIXfpeL8toN0xL7x8J6o+MPOP7Xakq4oxaohBHFAdJKr
         HakUZiYNUzqmCyiAlkItR0ZXdjI4jF5WAKoAV6OH3Qn1/gXuYsZwlV/I5MPIOz2OrOU9
         Ia2Q==
X-Gm-Message-State: AOAM531FSDBEhQ7AMP5NkqDgXAl5ZRPdNIaeuG9jAzifdyoY3vQjaTOD
        T0xg0LFfVl2slaeHox2iHif92bf+IGAnqMUYrKAOCXiHYw3kjrvVkYJi1ZDd2C0BeTjiaC9XMTN
        xoeSSop87WucxQnMzGkQZRIOqd7d9
X-Received: by 2002:a05:6000:18ae:: with SMTP id b14mr2939925wri.358.1640107389834;
        Tue, 21 Dec 2021 09:23:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyI+sgOMHf0YSbgDUY4Hz0bbMnBZ39bzuZPfnty8IjP5PgtILbNjQUHQYlB5n/1B8EGxd5qNw==
X-Received: by 2002:a05:6000:18ae:: with SMTP id b14mr2939904wri.358.1640107389571;
        Tue, 21 Dec 2021 09:23:09 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id c8sm10962302wrp.40.2021.12.21.09.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:23:09 -0800 (PST)
Message-ID: <4d739c28-e07d-f921-8a8d-a5343139e234@redhat.com>
Date:   Tue, 21 Dec 2021 18:23:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] KVM: selftests: Fix compile error for non-x86
 vm_compute_max_gfn()
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Anup Patel <anup.patel@wdc.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20211221125617.932371-1-anup.patel@wdc.com>
 <3e3b5295-f6fb-1ff9-acfe-1a4c47c6ba20@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <3e3b5295-f6fb-1ff9-acfe-1a4c47c6ba20@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/21/21 18:22, Shuah Khan wrote:
> On 12/21/21 5:56 AM, Anup Patel wrote:
>> The inline version of vm_compute_max_gfn() in kvm_util.h directly
>> access members of "struct kvm_vm" which causes compile errors for
>> non-x86 architectures because lib/elf.c includes "kvm_util.h" before
>> "kvm_util_internal.h".
>>
>> This patch fixes above described compile error by converting inline
>> version of vm_compute_max_gfn() into a macro.
> 
> Thank you for the patch. Please include the actual compile error in the
> change log and send v2,

Hi, a similar patch is already queued and should get to Linus today or 
tomorrow.

Paolo

