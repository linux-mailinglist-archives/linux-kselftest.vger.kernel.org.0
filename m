Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC56040D2C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 07:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhIPFHf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 01:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234246AbhIPFHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 01:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631768771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKN8XQ4WQkJPsTlSjGiV3oiFQPmnO4fijF4pI7KTQvg=;
        b=CsPw98ckRgMgn5I919qDzq8/g4Nq4m6DUtok34TQaSVsu2BRB56Vc5wKiEHWLconPUiM/o
        +CA7VltsBZ+O+1IwKar7eJfEylrnPUeFpv15bE/wGYkq5IHIDmr78U67l6bkYWFGezEA1t
        QNx/Dbgy2f4tPehffam/KbuRcaAcXU0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-uswPuSSHO5anGoYMAI_VfQ-1; Thu, 16 Sep 2021 01:06:07 -0400
X-MC-Unique: uswPuSSHO5anGoYMAI_VfQ-1
Received: by mail-ed1-f71.google.com with SMTP id c7-20020a05640227c700b003d27f41f1d4so4006521ede.16
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 22:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKN8XQ4WQkJPsTlSjGiV3oiFQPmnO4fijF4pI7KTQvg=;
        b=3mcpdtlt2vPHMyGLImfkhM0P2JO+POi/Df9KF0m24WG3+WOhZ0t0Mo+7g/MheAOuo5
         t5gTo2QNo/mhnc7XOYD7WVZuslQNxtsqixsEY8yLmX3rYPLD28HdJBhMlCVnt66ENuBO
         KT2+zrXkJEBwwir2nFAG2IPChK2oYktdOMrdCn7cTKhXvo1iACrW+UN0qD68E6OVTqZG
         IeEaGH12PtCTcRKoyC3NfaBTuO2Y2GCSh54fjRHXRphhF6p8M57YGkqi6h8GhcDRermC
         c1+nWBkasHU4429nQUDZzE8GnKlD0vb3BUfzFgJI9sTkmXcuTV/hkBtALRT3OFr4vcId
         4Xsw==
X-Gm-Message-State: AOAM533jbcL+YSSI/pQX7h9aqrnU6FeSMGDbvmu0I1gm4gYAQtnf8+Uo
        rsON9MtTh1HVij5LEu7g8OrjCUswzd3zmT7JojoVUmjpweNsb/5FX4MDIFNQeCt/2YYOtCIKeG/
        f959opWwxfIYnm0zPBXxUH3x/2dA7
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr4302150edc.14.1631768766387;
        Wed, 15 Sep 2021 22:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1bdIwbG7TUmxAk3tSV06VOIwCk8kiZfGgssZZPwl5DDnRixxI9jEnMirROatK9dy9eF1wuA==
X-Received: by 2002:a05:6402:42d5:: with SMTP id i21mr4302128edc.14.1631768766157;
        Wed, 15 Sep 2021 22:06:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id u4sm740910ejc.19.2021.09.15.22.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 22:06:05 -0700 (PDT)
Subject: Re: [PATCH 0/4] selftests: kvm: fscanf warn fixes and cleanups
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1631737524.git.skhan@linuxfoundation.org>
 <56178039-ab72-fca3-38fa-a1d422e4d3ef@redhat.com>
 <aca932b9-5864-be95-c9f6-f745b6a6b7f3@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9da3a33-6ecc-3d52-8f9a-f465692ecb93@redhat.com>
Date:   Thu, 16 Sep 2021 07:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <aca932b9-5864-be95-c9f6-f745b6a6b7f3@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16/09/21 02:02, Shuah Khan wrote:
> On 9/15/21 4:34 PM, Paolo Bonzini wrote:
>> On 15/09/21 23:28, Shuah Khan wrote:
>>> This patch series fixes fscanf() ignoring return value warnings.
>>> Consolidates get_run_delay() duplicate defines moving it to
>>> common library.
>>>
>>> Shuah Khan (4):
>>>    selftests:kvm: fix get_warnings_count() ignoring fscanf() return warn
>>>    selftests:kvm: fix get_trans_hugepagesz() ignoring fscanf() return
>>>      warn
>>>    selftests: kvm: move get_run_delay() into lib/test_util
>>>    selftests: kvm: fix get_run_delay() ignoring fscanf() return warn
>>>
>>>   .../testing/selftests/kvm/include/test_util.h |  3 +++
>>>   tools/testing/selftests/kvm/lib/test_util.c   | 22 ++++++++++++++++++-
>>>   tools/testing/selftests/kvm/steal_time.c      | 16 --------------
>>>   .../selftests/kvm/x86_64/mmio_warning_test.c  |  3 ++-
>>>   .../selftests/kvm/x86_64/xen_shinfo_test.c    | 15 -------------
>>>   5 files changed, 26 insertions(+), 33 deletions(-)
>>>
>>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Thanks Shuah!
>>
> 
> Thank you. I can take these through linux-kselftest - let me know
> if that causes issues for kvm tree.

Go ahead if it's for 5.15-rc, I don't have any selftests patches pending.

Paolo

