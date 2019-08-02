Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C67FB63
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2019 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406579AbfHBNnk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Aug 2019 09:43:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43182 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfHBNnk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Aug 2019 09:43:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so2684556wru.10
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Aug 2019 06:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3i+v6PWLAFY4pLYnR68bLFCR3VGy3PuSRw0b9/MCRls=;
        b=Sak7td9MzVZyJZ/AhtPjgghg9h6vCcChxMPpyEKfFOgEecNeWc8Vo2DqiChvIrsmhm
         y8Yu1BV9fMsJo5sFYnfbo/NHFzHzYeXYTNoVstJT+dnjh3rv8TxGWkJsXMWeJ6UCgeBN
         NCJ5adFkI552TOneemaGT4sy7x2JNeCMzZGUdy85fDDJp83UaITqbrTso8lgGbDT5bGw
         ZLahQcXQXDOtmqYlee8K0Gd2UCQXkZyDHgbXxLqUjAG+jN4FvszRprJd73quVYMP7dEN
         mulcBZsGTDzwvrSeIKQPkSqM3dNNT+ZW6pkWsCxXg1/Jgf0iXdkqt9vGjJdxvEA2XJE/
         Kjog==
X-Gm-Message-State: APjAAAXGvd/5u6ddiNX5JHfBx9ogjgG9UWNM1TIRuiyAdhD3sCLAwoKh
        0QVUUEzRGhfREsv2BvQcESp0mg==
X-Google-Smtp-Source: APXvYqwlWPI9epVJFEWNOTqzS7ZJ4IYVa0FZTw8meKi5eAb8tedQqtVhMZGqG3X7gTxs2cm6xqIjrA==
X-Received: by 2002:adf:df8b:: with SMTP id z11mr89917522wrl.62.1564753418003;
        Fri, 02 Aug 2019 06:43:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id r123sm70327253wme.7.2019.08.02.06.43.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 06:43:37 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] KVM: selftests: Enable ucall and dirty_log_test on
 s390x
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>
References: <20190731151525.17156-1-thuth@redhat.com>
 <551b42ae-78a1-e55a-e4b8-bb5cc3a8eb8b@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9684b15d-39a4-2c1b-3269-466ceb37ef90@redhat.com>
Date:   Fri, 2 Aug 2019 15:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <551b42ae-78a1-e55a-e4b8-bb5cc3a8eb8b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/08/19 15:39, Christian Borntraeger wrote:
> On 31.07.19 17:15, Thomas Huth wrote:
>> Implement the ucall() interface on s390x to be able to use the
>> dirty_log_test KVM selftest on s390x, too.
>>
>> v3:
>>  - Fix compilation issue on aarch64 (thanks to Andrew for testing it!)
>>  - Added Reviewed-bys
>>
>> v2:
>>  - Split up ucall.c into architecture specific files
>>  - Removed some #ifdef __s390x__  in the dirty_log patch
>>
>> Thomas Huth (3):
>>   KVM: selftests: Split ucall.c into architecture specific files
>>   KVM: selftests: Implement ucall() for s390x
>>   KVM: selftests: Enable dirty_log_test on s390x
>>
>>  tools/testing/selftests/kvm/Makefile          |   9 +-
>>  tools/testing/selftests/kvm/dirty_log_test.c  |  61 ++++++-
>>  .../testing/selftests/kvm/include/kvm_util.h  |   8 +-
>>  .../testing/selftests/kvm/lib/aarch64/ucall.c | 112 +++++++++++++
>>  tools/testing/selftests/kvm/lib/s390x/ucall.c |  56 +++++++
>>  tools/testing/selftests/kvm/lib/ucall.c       | 157 ------------------
>>  .../testing/selftests/kvm/lib/x86_64/ucall.c  |  56 +++++++
>>  .../selftests/kvm/s390x/sync_regs_test.c      |   6 +-
>>  8 files changed, 287 insertions(+), 178 deletions(-)
>>  create mode 100644 tools/testing/selftests/kvm/lib/aarch64/ucall.c
>>  create mode 100644 tools/testing/selftests/kvm/lib/s390x/ucall.c
>>  delete mode 100644 tools/testing/selftests/kvm/lib/ucall.c
>>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/ucall.c
>>
> 
> Paolo, I guess you do not mind if I carry patch 1 also via the s390x tree?

Sure,

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
