Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2839A38E762
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 May 2021 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhEXN1A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 May 2021 09:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232774AbhEXN07 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 May 2021 09:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621862730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0kainRH42RdsY8Y3urUJhWHPRUuUeVjYP8+Uj0Uo0c=;
        b=GQxTa4wdHIyIEOSlQVSrOk6Kz406qieYtj62Wy+gUeclwGQjr1OkRyTSbxxOw0LEyi5F5G
        vo1HsKRvrJ/4h2ypd6M/giyBs2CM6r1WXpzIYp5VFzPKfzbK7ywkZE+klXWXXkv7n6KGQp
        md69XqUAIu6lbjJkaajhiPB31d7ESCI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-c_gcBjh0MbWw9ahLCys2LA-1; Mon, 24 May 2021 09:25:29 -0400
X-MC-Unique: c_gcBjh0MbWw9ahLCys2LA-1
Received: by mail-ed1-f70.google.com with SMTP id s20-20020a0564025214b029038752a2d8f3so15549387edd.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 May 2021 06:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M0kainRH42RdsY8Y3urUJhWHPRUuUeVjYP8+Uj0Uo0c=;
        b=GI4X1F/mC3iQyJjZIBfYFMJmnf0YONKNUnkqe6NID0ExhhNNA9NosLKuPd8rxNwYfT
         XZGXiyCtye0YIqH/ad6dwU20uvhLqQLUkDusXsN5sAJPdJpHzMjT56fD0v5PPs4Ua6+/
         E4de6xDkLf1xsL55G6xPZlgkJ5E3NRCNcMNIS6uXoYB9gom9Op7dhT4fa5eG3wVPKnGB
         UXz7CHKLC0DR9bnzK2PvZ3WaUqde9pZyKnmTs4BzPpCotr1fEoHk7VaV8KikiWlzi1YW
         t13hCBDCEI7bf0SmAqmLeWJ0nEoUBuWlCSrd54PeV4vMFZvyIYjdamSnt7xypkybyYba
         GThg==
X-Gm-Message-State: AOAM530oHHIy4Wbwg/lFsRTD6Sddb0dk2HsGw6DNRi5HenNqRGOoL4tu
        6xvhazKF9LY1J2t7rzWmUlAuNs2P0IP0Pvre/ibSiKYMzEaZ4XLAXAuR3VfQtdbORhD9z5FJupS
        Oms1gGfAKPGR3G4WkY2653mDePd5NLLo2vQ+QuCPekosRMvVpoPqGY9uH+qNsSnC7WjOZggaKd6
        WLcggG
X-Received: by 2002:a17:906:eb0d:: with SMTP id mb13mr23097563ejb.261.1621862727802;
        Mon, 24 May 2021 06:25:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9QnvMOCLEMOMhpBAki5iXpY5iZp70ilUI2Tl1uFieprXzXpBLESyZxxJnCJHzmTQqktCk2A==
X-Received: by 2002:a17:906:eb0d:: with SMTP id mb13mr23097529ejb.261.1621862727542;
        Mon, 24 May 2021 06:25:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r17sm9231641edt.33.2021.05.24.06.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 06:25:26 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] KVM: selftests: simplify setup_demand_paging
 error handling
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20210519200339.829146-1-axelrasmussen@google.com>
 <20210519200339.829146-3-axelrasmussen@google.com>
 <CANgfPd-dF+vWafBC5DsNhf5C0M12+LxRQLhsBM=CzOKTsep+og@mail.gmail.com>
 <CAJHvVcizVoAs+-wOXeO7bc=8c2G3oEC4KSVyPm5E9Z6YMCsvaw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <824fe2de-a087-d2b4-406a-e8c6c040b37a@redhat.com>
Date:   Mon, 24 May 2021 15:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJHvVcizVoAs+-wOXeO7bc=8c2G3oEC4KSVyPm5E9Z6YMCsvaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 20/05/21 00:14, Axel Rasmussen wrote:
> On Wed, May 19, 2021 at 2:45 PM Ben Gardon <bgardon@google.com> wrote:
>>
>> On Wed, May 19, 2021 at 1:03 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>>>
>>> A small cleanup. Our caller writes:
>>>
>>>    r = setup_demand_paging(...);
>>>    if (r < 0) exit(-r);
>>>
>>> Since we're just going to exit anyway, instead of returning an error we
>>> can just re-use TEST_ASSERT. This makes the caller simpler, as well as
>>> the function itself - no need to write our branches, etc.
>>>
>>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>>> ---
>>>   .../selftests/kvm/demand_paging_test.c        | 51 +++++++------------
>>>   1 file changed, 19 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
>>> index 9398ba6ef023..601a1df24dd2 100644
>>> --- a/tools/testing/selftests/kvm/demand_paging_test.c
>>> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
>>> @@ -9,6 +9,8 @@
>>>
>>>   #define _GNU_SOURCE /* for pipe2 */
>>>
>>> +#include <inttypes.h>
>>> +#include <stdint.h>
>>
>> Why do the includes need to change in this commit? Is it for the PRIu64 below?
> 
> Right, I didn't actually try compiling without these, but inttypes.h
> defines PRIu64 and stdint.h defines uint64_t. In general I tend to
> prefer including things like this because we're using their
> definitions directly, even if we might be picking them up transiently
> some other way.

inttypes.h is defined to include stdint.h (stdint.h is mostly useful in 
freestanding environments and is usually provided by the C compiler, 
while inttypes.h is provided by libc).

Paolo

