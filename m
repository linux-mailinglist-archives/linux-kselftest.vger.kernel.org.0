Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 402681859C2
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Mar 2020 04:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgCODkL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 14 Mar 2020 23:40:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726643AbgCODkL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 14 Mar 2020 23:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584243610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mUmgqOIFOdKgmbkoQ0zespckuiZdF8ycwVxiswURFM=;
        b=cuhKXD2JoWMcCLwfw5DqmA6ZZvk1QBAp0wZrhs4q2gkrPjV/ObUMLEjeWEiY+LaHsQ0v84
        RlgxXKYrIS8Rp0nkg+BcsCO+2YLdRhwJJEQJvyQ69gclcHE1Rgftfk4jnvNIr2xB4se6kN
        jXSfQBliixw0AcywWJmRCYXAkUqqCaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-IOxwBe9HMq2E6M43ooHDxA-1; Sat, 14 Mar 2020 07:37:44 -0400
X-MC-Unique: IOxwBe9HMq2E6M43ooHDxA-1
Received: by mail-wr1-f72.google.com with SMTP id w11so5819392wrp.20
        for <linux-kselftest@vger.kernel.org>; Sat, 14 Mar 2020 04:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7mUmgqOIFOdKgmbkoQ0zespckuiZdF8ycwVxiswURFM=;
        b=taV1yTy0vMO984WiRHUI3TM9XBL2YOfoI2KU3EiqKDC8UBV/TgmhRcdZ451KGgWLEc
         O+XIkXJtUbMuRhfZy82Kk3QZjg/sK/zMMyQw3q4l1XS2Y78aJBn51gM6oaZw7Ecu2jb8
         sb6gNvv48HJDBz7bRV8twU7Yco2pyW0jsIMC31mfv0FLQEiCIdT1PrNKk/8BitG2Cddb
         qASTlSEbOPoK6e9qOA1mqrY5wWI6P3BtN6HFZMzusnLBnyVDmhC6okypQF7s59X4J/tn
         unhcY5qsu6Rnr6DJFXmdnfGVuvTVHZItZayQXyewAXvAYmcG1+AfAPTG9Rt//pFuUEQp
         R2ZA==
X-Gm-Message-State: ANhLgQ24T/ejRirvm2OeVL0L+e8EN82GMs5wR0iswoxvsSAMCDnCaA2R
        WSYip/q2vFlYZbReVIkpMW59zOGtO5WOL9jEprytdC47iZQ/ltFry6eTcmohxTi80oYybkZBqeL
        tbZHy0GDlAWuBxWLomoqsYZJjeJ9k
X-Received: by 2002:a5d:6a0e:: with SMTP id m14mr24146633wru.202.1584185863206;
        Sat, 14 Mar 2020 04:37:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtNGoRby/wRfjauVrobYr5jBC5s8q6oSM+F2dujPpEvIkjrwFi5vDmCl73ddSAQ4SsdWa43Zw==
X-Received: by 2002:a5d:6a0e:: with SMTP id m14mr24146612wru.202.1584185862992;
        Sat, 14 Mar 2020 04:37:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac? ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
        by smtp.gmail.com with ESMTPSA id f17sm76798128wrj.28.2020.03.14.04.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 04:37:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] kvm: selftests: Introduce TEST_FAIL and convert
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sean.j.christopherson@intel.com, shuah@kernel.org,
        tglx@linutronix.de, thuth@redhat.com
References: <20200310025059.9301-1-wainersm@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61b30d46-316c-5ef6-179f-fc394d352766@redhat.com>
Date:   Sat, 14 Mar 2020 12:37:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310025059.9301-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/03/20 03:50, Wainer dos Santos Moschetta wrote:
> Introduce the TEST_FAIL macro and change the tests/utilities
> to use it.
> 
> v1 -> v2:
> - Completed the conversion to TEST_FAIL.
> 
> v1:
> - [RFC PATCH 0/1] kvm: selftests: Add TEST_FAIL macro
>   https://lore.kernel.org/kvm/20200305172532.9360-1-wainersm@redhat.com/
> 
> Wainer dos Santos Moschetta (2):
>   selftests: kvm: Introduce the TEST_FAIL macro
>   selftests: kvm: Uses TEST_FAIL in tests/utilities
> 
>  tools/testing/selftests/kvm/dirty_log_test.c  |  7 +++----
>  .../testing/selftests/kvm/include/test_util.h |  3 +++
>  .../selftests/kvm/lib/aarch64/processor.c     | 17 +++++++--------
>  .../testing/selftests/kvm/lib/aarch64/ucall.c |  2 +-
>  tools/testing/selftests/kvm/lib/io.c          | 12 +++++------
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 21 ++++++++-----------
>  .../selftests/kvm/lib/x86_64/processor.c      |  5 ++---
>  .../kvm/x86_64/cr4_cpuid_sync_test.c          |  4 ++--
>  .../testing/selftests/kvm/x86_64/evmcs_test.c |  6 +++---
>  .../testing/selftests/kvm/x86_64/state_test.c |  6 +++---
>  .../selftests/kvm/x86_64/svm_vmcall_test.c    |  6 ++----
>  .../kvm/x86_64/vmx_close_while_nested_test.c  |  4 ++--
>  .../selftests/kvm/x86_64/vmx_dirty_log_test.c |  6 +++---
>  .../kvm/x86_64/vmx_tsc_adjust_test.c          |  4 ++--
>  14 files changed, 49 insertions(+), 54 deletions(-)
> 

Queued, thanks.

Paolo

