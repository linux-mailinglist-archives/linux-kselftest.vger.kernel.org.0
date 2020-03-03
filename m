Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041781773B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 11:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgCCKOk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 05:14:40 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55204 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728521AbgCCKOj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 05:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583230478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/0qud24Lc83ZsK+kraVeDJxpPhKrBM9LgPi+wDoazM=;
        b=OpxdIM2tfKLVijc7FwH79kfsiX3xdpbX7L51xnfZcqUQBqYWb6z8u3VlzyOiyTW+AGzaJf
        i+d5E9lZFhuT/JCdoW9im4IXMS6vsTZhyMxlO6wVfltlxYaFSKPnqI5gSoLN/HAT9luFLQ
        q9FMvMim/Pw/a1mEJuGeX8T34xDllWM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-6ymh7AyJMfOw6ZZpJb1VfA-1; Tue, 03 Mar 2020 05:14:37 -0500
X-MC-Unique: 6ymh7AyJMfOw6ZZpJb1VfA-1
Received: by mail-wm1-f71.google.com with SMTP id g26so455200wmk.6
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Mar 2020 02:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w/0qud24Lc83ZsK+kraVeDJxpPhKrBM9LgPi+wDoazM=;
        b=TuOIWzukyFqu4ZAgqsAmH+EnSVjNUpS78sYroZlhI33CqetZZaE9YHbK5nojspwecq
         mzI8Lef4TrYHrYj0v9sSLTdlEVo+5D8Eqt02Lqka6zc2+jSkV0VspefiIIjCUhdAlFV9
         cdGEUN/LYAwgwlzVrHb7ujDqki330+986Y4e+W/VpbYNihpODgsj4KFmnrB5h6UVPUqe
         huFdKOwcpN/VfKXIIcBNhT2WeLv6h0MHHVSXvLFdQBasJctM2V+ipc03+XJMkLSCNUkB
         7O8edyyJmTNEaaLtMkidW31AtAMIJkcrTnlEA4ng/AFXpbNXKPBPPCoR85nUdno8UzJy
         Q8gA==
X-Gm-Message-State: ANhLgQ33oFy3Ypij+OYhuNKpug3XdtBNu7wUYpzOVs/6VZOwlFIsjKK5
        vSubgbmH6+QOb6C1o6dXyrLrs4VcwOq8mtxbpUMMC+nBN0ftOkGi5a+nYH5VekWFcqkx5EKYo6a
        AYAjYfLeiI3O9N4qMbRDFat6IRaf/
X-Received: by 2002:adf:b60f:: with SMTP id f15mr5029155wre.372.1583230476241;
        Tue, 03 Mar 2020 02:14:36 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuLxMYQILq06MORiKyONazb9g5WpGvFOg06QFQY+MMaKouSE6HlNhP78dp7DMPohLvHcz6D9A==
X-Received: by 2002:adf:b60f:: with SMTP id f15mr5029137wre.372.1583230476016;
        Tue, 03 Mar 2020 02:14:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id 61sm33196852wrf.65.2020.03.03.02.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 02:14:35 -0800 (PST)
Subject: Re: [PATCH] kvm: selftests: Support dirty log initial-all-set test
To:     "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "peterx@redhat.com" <peterx@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wangxin (U)" <wangxinxin.wang@huawei.com>,
        "Huangweidong (C)" <weidong.huang@huawei.com>,
        "Liujinsong (Paul)" <liu.jinsong@huawei.com>
References: <20200303080710.1672-1-jianjay.zhou@huawei.com>
 <f0c2dcb8-4415-eec9-d181-fb29d206c55c@redhat.com>
 <B2D15215269B544CADD246097EACE7474BB4E091@DGGEMM528-MBX.china.huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8c4cc9f-6c9e-6d02-9eb3-32824dcc0c4c@redhat.com>
Date:   Tue, 3 Mar 2020 11:14:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7474BB4E091@DGGEMM528-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/03/20 11:00, Zhoujian (jay) wrote:
> 
> 
>> -----Original Message-----
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> Sent: Tuesday, March 3, 2020 4:54 PM
>> To: Zhoujian (jay) <jianjay.zhou@huawei.com>; kvm@vger.kernel.org
>> Cc: peterx@redhat.com; shuah@kernel.org; linux-kselftest@vger.kernel.org;
>> linux-kernel@vger.kernel.org; wangxin (U) <wangxinxin.wang@huawei.com>;
>> Huangweidong (C) <weidong.huang@huawei.com>; Liujinsong (Paul)
>> <liu.jinsong@huawei.com>
>> Subject: Re: [PATCH] kvm: selftests: Support dirty log initial-all-set test
>>
>> On 03/03/20 09:07, Jay Zhou wrote:
>>>  #ifdef USE_CLEAR_DIRTY_LOG
>>> -	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2)) {
>>> -		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping
>> tests\n");
>>> +	dirty_log_manual_caps =
>>> +		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
>>> +	if (!dirty_log_manual_caps) {
>>> +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, "
>>> +				"skipping tests\n");
>>> +		exit(KSFT_SKIP);
>>> +	}
>>> +	if (dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_CAPS &&
>>> +		dirty_log_manual_caps !=
>> KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE) {
>>> +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not valid caps "
>>> +				"%"PRIu64", skipping tests\n",
>>> +				dirty_log_manual_caps);
>>>  		exit(KSFT_SKIP);
>>>  	}
>>>  #endif
>>>
>>
>> Thanks, instead of this final "if" it should be enough to do
>>
>> 	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE
>> |
>> 				  KVM_DIRTY_LOG_INITIALLY_SET);
>>
>>
>> Otherwise looks good, I'll test it and eventually apply both patches.
> 
> Do I need to resubmit this patch with this modification?

No, thanks.

Paolo

