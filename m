Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA82340BEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 18:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhCRReH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 13:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232126AbhCRRdm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 13:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616088821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DN+8K3rKTpznELYcmJSaxwcdANuiNnp4BTO6V95gyn8=;
        b=TpxNL90W7oD8DFt9eBTuAdkXmeZMGuULJClTciYvOlzuFm0lo+NZc7WYcJ7Bjy+imeoqOq
        kaQabTcch2Eg8XlRCUHcM/99iTlWQ2eg4gXZLPYA0FyJXDhLhgWy7kqFrVmteoCcHzM1RD
        Wj/ajvUHwgwzxtsfOVORbvShp9OHNCs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-lq_pcOWlOmqMHhXnEm8DEw-1; Thu, 18 Mar 2021 13:33:37 -0400
X-MC-Unique: lq_pcOWlOmqMHhXnEm8DEw-1
Received: by mail-wr1-f70.google.com with SMTP id 75so20286805wrl.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Mar 2021 10:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DN+8K3rKTpznELYcmJSaxwcdANuiNnp4BTO6V95gyn8=;
        b=Ffe85cKONB07wIm+nHc7ngBrkUVAp16wvs7IELsj+EDH1mxO9aRjNkzr5ZsMmHNOZ9
         4gAHGN0ZyNrK4qFhBE9MkWHxd4//QUvTgcswYRwbf6xMTlTSbe+1MPFInGve6NyrPUPV
         fYBpdXOluSS8DI1mIYkMkKiU6AaKMootPtXhXBdZrYYtqtLg/RfnzYa5oWGYZAU+24pV
         U9koQPcNuOK65JNfxGMTWptSkoNmrowKM6YWC3WMYRvb/AT6YCKNd4iQecwQOtrSurov
         vvsSZxQGtNcRacYN12wOMGTbGGZZs+RngcS37Kmz+9171g0bM3li309KjQrbMrciaglM
         DUxg==
X-Gm-Message-State: AOAM532WyR2UQutG1n3+IRZV4wslGOWZ4W2cegWmGJuZSXzetG1Hh1wb
        5caG+vZGhhuyUGXwQJZXE46FP6deKtZU/xmHFBz9NzoQ/QOhtYXdxADgOR1lbyqTyP0cbEBOwjE
        u6TuQfNCgOIfqKsrllOaqWELT6s0E
X-Received: by 2002:a05:600c:4305:: with SMTP id p5mr281777wme.58.1616088816582;
        Thu, 18 Mar 2021 10:33:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4C0nnNPJfbUUcYMXpaLCD02RMObFn+Jfj9qUjWFqoZRQpPHL++lmLqOJOwel0p38NoPaT0g==
X-Received: by 2002:a05:600c:4305:: with SMTP id p5mr281769wme.58.1616088816430;
        Thu, 18 Mar 2021 10:33:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n1sm4535975wro.36.2021.03.18.10.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 10:33:35 -0700 (PDT)
To:     Andrew Jones <drjones@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210318145629.486450-1-eesposit@redhat.com>
 <20210318170316.6vah7x2ws4bimmdf@kamzik.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] selftests/kvm: add get_msr_index_features
Message-ID: <c08773f1-4b84-bb19-cda8-c8ac6ffffdaf@redhat.com>
Date:   Thu, 18 Mar 2021 18:33:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210318170316.6vah7x2ws4bimmdf@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18/03/21 18:03, Andrew Jones wrote:
>>
>>  TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
> 
> Maybe we should give up trying to keep an alphabetic order.

FWIW I had fixed that but yeah maybe we should just give up.

>> +int main(int argc, char *argv[])
>> +{
>> +	if (kvm_check_cap(KVM_CAP_GET_MSR_FEATURES))
>> +		test_get_msr_feature();
>> +
>> +	test_get_msr_index();
> Missing return
> 
>> +}

"main" is special, it's okay not to have a return there.

Paolo

