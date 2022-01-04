Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A50F4847E8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jan 2022 19:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiADScw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Jan 2022 13:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiADScw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Jan 2022 13:32:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDE9C061761;
        Tue,  4 Jan 2022 10:32:51 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bm14so151941344edb.5;
        Tue, 04 Jan 2022 10:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H++mvP7xNJ7DkJfGLUkbXM0jLfOJX76p9y1OOLe38IQ=;
        b=dLv9eyr7RYbaApqHcWxnR9DQAJNKH4nos5iEGJ3nd6j3GTVjJCUhVYOm25z6oP90RG
         b2yubaWsMfweUUKfS9xpTnAlTYD4H1XpBymwiT2OH23jydLTRZPSj9oY8UIS/p7U920F
         OlnzMQ9yVz48DjOOVgSVyFHYqRxjzqIABZZRQ3gEkp3RXQ/xmSeOOHURA8hEI5NCRMgr
         1GnQUIVVw+NW8hJFt5+8ilgKCCCQ7S213z3ze+/G8PFQuau+ni9+QWnZPetM/pAY7dT+
         cmMJ6OMqqr4q83W4AH95Orz/BUJIQQ1NWgGjfnjPuiEMZ6UrP/6X/5AkUCXyjrhzriAh
         Axmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H++mvP7xNJ7DkJfGLUkbXM0jLfOJX76p9y1OOLe38IQ=;
        b=5f+sQl3M/XeDZTPyKT1541pNSOi5UkAksKmoHmyNSj6q3+EGKr0f7OJ0pr6cowkjHY
         Nlb7oCc7kbdz3g6de9KdSY3PGpx/NR6tOezwbv3IH+sWMcChx0PInVK4Rn4efbELZV7N
         8/u6o/nA2PXm/lnF+BI+GDKKfeklV5rCtITwsWgnBkcO5vQvYlCvzPOxrAPVsN/Ph1aW
         wbAkOA5810fIAn0HJiLJpCiTuANz2w1FWxqIz0eppdVC7kBM5zRsOMbbuoYGM4Cwv7Xa
         Wyuh4PdNfGT5GP17ANvpvk+j4TsIC1cH88ar7yBhZMFiQ8a//WjPkrlMsOgHR1H9GbfT
         vwPQ==
X-Gm-Message-State: AOAM531fZKEzNjnUiYB5sL/P77LNgA9lo22LpCtfjkOfWS/IcinIeImb
        tX3F+7/CyEoQQxijTsxLvd8=
X-Google-Smtp-Source: ABdhPJz1wuD9CF9yh60mz6/O58ZsWK4Aqh+WsdA/rHGDuVs+hncGhVqnjRjWWBMzBt/wD2wJWq2Llg==
X-Received: by 2002:aa7:c655:: with SMTP id z21mr43537910edr.352.1641321170423;
        Tue, 04 Jan 2022 10:32:50 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id jg34sm11710859ejc.74.2022.01.04.10.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:32:50 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <ff29b36a-ffe4-8ba9-2856-cf96fcf33c0d@redhat.com>
Date:   Tue, 4 Jan 2022 19:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Jing Liu <jing2.liu@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net, shuah@kernel.org,
        jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, guang.zeng@intel.com,
        wei.w.wang@intel.com, yang.zhong@intel.com
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-23-jing2.liu@intel.com> <Ycu0KVq9PfuygKKx@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ycu0KVq9PfuygKKx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/29/21 02:04, Sean Christopherson wrote:
> 
> Speaking of nested, interception of #NM in vmx_update_exception_bitmap() is wrong
> with respect to nested guests.  Until XFD is supported for L2, which I didn't see
> in this series, #NM should not be intercepted while L2 is running.

Why wouldn't L2 support XFD, since there are no new VMCS bits?  As long 
as L0 knows what to do with XFD and XFD_ERR, it will do the right thing 
no matter if L1 or L2 is running.

Paolo
