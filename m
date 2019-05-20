Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDA2230DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2019 12:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfETKAs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 May 2019 06:00:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56303 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbfETKAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 May 2019 06:00:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so12588384wmb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2019 03:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cggXkXw7KMDRmClqjubkrp+u9dEPf8Y4XlImClCNB9M=;
        b=RAOU/deunhPmQXp6KZFtQqQwM88tZppVmKDkHHwEDerpgPHtCI77Kjn1H4Opd+0ds6
         pCux+6DM57dnxK0+i/EpkoW3MeZxEJ6RuirtLnZz1qLclhyTFpwajUjXtFZ8Bf3AjecA
         x9+eobcAMWivlGwo47z+MtoqXBpu4tAMrQr7qix3PC1tPODA0kyAkbhKYoN/vnMUfSSm
         WZpa0MmBr5Zp0cufuTtP+Fl4hLMOi1xZMnt77I11JgoI2AfdOfd+4Ehh0htEEWV9jv47
         Ad47ScOjU0n3gstxzb+PVS73N9mCqOuz/Nkhob9qxeVCCCQuu8PjKQSn7jMizT5pgSSh
         f+nA==
X-Gm-Message-State: APjAAAVg1h4AgdMD7+cLKDlXLYziXCeN8ctmyuceZQjzgcRW0C4h4A5c
        9Q0V2SReF/BF8bm280hogAYFuw==
X-Google-Smtp-Source: APXvYqwJSh8pgNUluibV031iwlxskI3nkF4L+TZgKSMcM4ttcWA9XnyT5FF+LnqIc27hKgoLwSjwUw==
X-Received: by 2002:a1c:7dcf:: with SMTP id y198mr10603176wmc.94.1558346446594;
        Mon, 20 May 2019 03:00:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id b206sm17195897wmd.28.2019.05.20.03.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:00:45 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: selftests: Compile code with warnings enabled
To:     Thomas Huth <thuth@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
References: <20190517090445.4502-1-thuth@redhat.com>
 <20190517093000.GO16681@xz-x1> <8736ldquyw.fsf@vitty.brq.redhat.com>
 <1834df0f-b377-2231-0e5c-c5acd3298973@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <505274ec-e73f-f362-8130-5f70673bfc80@redhat.com>
Date:   Mon, 20 May 2019 12:00:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1834df0f-b377-2231-0e5c-c5acd3298973@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/05/19 12:07, Thomas Huth wrote:
> 
> lib/ucall.c: In function ‘get_ucall’:
> lib/ucall.c:145:3: warning: dereferencing type-punned pointer will break
> strict-aliasing rules [-Wstrict-aliasing]
>    gva = *(vm_vaddr_t *)run->mmio.data;
> 
> x86_64/vmx_set_nested_state_test.c: In function
> ‘set_revision_id_for_vmcs12’:
> x86_64/vmx_set_nested_state_test.c:78:2: warning: dereferencing
> type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
>   *(u32 *)(state->data) = vmcs12_revision;
> 
> ... how do we want to handle such spots in the kvm selftest code?
> Compile with -fno-strict-aliasing? Or fix it with type-punning through
> unions?

I would use memcpy.  I'll send a patch shortly.

Paolo
