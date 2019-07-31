Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA797C279
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfGaM60 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 08:58:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33154 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfGaM60 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 08:58:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so69676682wru.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2019 05:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5fP2qCBEwihSuFPG1uN/AQ6+YLyq3LrKayldIArWOpA=;
        b=AQlkfhyqHV5hpruhFUDQqiAj65X8/bj4c1QQXnK3HR/ftLCOM+0nnB/EFeXBBxhuEl
         atqit++9FDRkkrZFgX0veQ9MatEqNIRGoZLGeD4lcw1EX+x7L7gVaLEcyd+Vbt+VO1qc
         kzTu0D9fKgpggZCGOqDYDhi7bqkBHEkAxBLrWbpXF3JNVWBxkmOujiY2KkaOqsEyI0WE
         hCHJPaPGoMz3Hv4xEc7rdQOowW5UMxPSh9nDB0YPo8fDR2cQb28AKCqfrv718FitO9/j
         +rFXrvPNl+xT4vu28P9XPiXGpAVU9XB9ne8GZmZ61/lTIUfb0xo/pyNKHWSMQn/T7A9u
         c44Q==
X-Gm-Message-State: APjAAAXn4i8xeonQxd4oIOMg/lbz/no0BqhJ6c/LboEn1IoyPZrfoFYo
        5b4yWj6adCvmELywj0dwvCzsdQ==
X-Google-Smtp-Source: APXvYqw1s7YQ7Musw4tNdkwIb4qMQbr7VmKUKXvia/n7SbLvxes86b9xZXW+ODrBjEijk/QTUhcq2w==
X-Received: by 2002:adf:de90:: with SMTP id w16mr37579726wrl.217.1564577905024;
        Wed, 31 Jul 2019 05:58:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3? ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
        by smtp.gmail.com with ESMTPSA id g12sm100117916wrv.9.2019.07.31.05.58.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 05:58:24 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
To:     Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <20190730105721.z4zsul7uxl2igoue@kamzik.brq.redhat.com>
 <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <afdf2b18-47fd-aa48-41b7-130122590068@redhat.com>
Date:   Wed, 31 Jul 2019 14:58:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 31/07/19 10:19, Thomas Huth wrote:
>>> @@ -293,6 +341,10 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
>>>  	 * case where the size is not aligned to 64 pages.
>>>  	 */
>>>  	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
>>> +#ifdef __s390x__
>>> +	/* Round up to multiple of 1M (segment size) */
>>> +	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
>> We could maybe do this for all architectures as well.
> It's really only needed on s390x, so I think we should keep the #ifdef here.

Yes, on non-s390 we should keep covering the case where the size is not
a multiple of BITS_PER_LONG.

Paolo
