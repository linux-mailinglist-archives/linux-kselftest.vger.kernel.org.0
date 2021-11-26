Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD345EBAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 11:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376722AbhKZKgl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 05:36:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377124AbhKZKel (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 05:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637922688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfDWgoSwBK/MbRVa0hEi5B9pRdTSSilaYnNnpfFZZdo=;
        b=RFJ+KsXjXt0SclGaHzoDCIa0VfFA7vk7B3ranDCJNHNfbL0+Ee8r7BJrOWYtMTiM+76DSP
        mNnFn3qvhR2Cq3JlBw4r8XKtxHq3rZQddcK3KPsZpPL1iNH23dOm9w2kXrz6xVva9dPNkV
        UKOb2qyfy+iCwvNfFT/dUuZpX2cabzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-atf-egpfOHGIpfERul5uyg-1; Fri, 26 Nov 2021 05:31:25 -0500
X-MC-Unique: atf-egpfOHGIpfERul5uyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D68BC2F22;
        Fri, 26 Nov 2021 10:31:23 +0000 (UTC)
Received: from [10.39.195.16] (unknown [10.39.195.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DCD25D740;
        Fri, 26 Nov 2021 10:31:18 +0000 (UTC)
Message-ID: <48dc971d-e5ee-0024-e539-89a050e7cf5e@redhat.com>
Date:   Fri, 26 Nov 2021 11:31:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] KVM: selftests: use ARRAY_SIZE
Content-Language: en-US
To:     Greg KH <greg@kroah.com>, cgel.zte@gmail.com
Cc:     shuah@kernel.org, deng.changcheng@zte.com.cn, mlevitsk@redhat.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
References: <20211124092256.37966-1-deng.changcheng@zte.com.cn>
 <YZ4J23oFTTDpjSa8@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YZ4J23oFTTDpjSa8@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/24/21 10:46, Greg KH wrote:
>> From: Changcheng Deng<deng.changcheng@zte.com.cn>
>>
>> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
>>
>> Reported-by: Zeal Robot<zealci@zte.com.cn>
>> Signed-off-by: Changcheng Deng<deng.changcheng@zte.com.cn>
> Your email address does not match these here, you need to provide a
> signed-off-by as well.
> 
> And are you_SURE_  that you can use kernel #defines in userspace testing
> code?

Dpeends on which, but ARRAY_SIZE is among those that can be used:

$ git grep '#define ARRAY_SIZE' 'tools/*.h'
tools/gpio/gpio-utils.h:#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
tools/iio/iio_utils.h:#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
tools/include/linux/kernel.h:#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
tools/testing/selftests/bpf/progs/profiler.inc.h:#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
tools/testing/selftests/cgroup/cgroup_util.h:#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
tools/testing/selftests/kselftest_harness.h:#define ARRAY_SIZE(a)	(sizeof(a) / sizeof(a[0]))
tools/testing/selftests/landlock/common.h:#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
tools/testing/selftests/vm/pkey-helpers.h:#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
tools/virtio/linux/kernel.h:#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))

In particular, most KVM tests already include linux/kernel.h
indirectly via linux/list.h.

Paolo

