Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D647D403
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 15:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbhLVO4h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 09:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbhLVO4g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 09:56:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8310FC061574;
        Wed, 22 Dec 2021 06:56:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so1636362wme.4;
        Wed, 22 Dec 2021 06:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sh9539P06l7XfONUhLa5AqK9wy1IglWuxqgYOheM7+c=;
        b=nK9e9PtR+SMepjeExdMMBWbkn7v6FYva3qNBkzHASjkNgQYY5VirUfErTz0fOxBIlO
         na3f8iWQZIAopi2wjPn54KgzDimlH3LC9lQe+jK9DSOT09VBO+p6m58X5PoK9ej15uXn
         ub6/8Oijg/cpoxLLmDkSrxqXtRj8UP0beuVOJ0cgahrfjZ5N4Pi4hz67zmhFr3XwlVWs
         sV9WcchI+LBGUOGYsGKnV0WslCPhyuVvUJlsIe2/k8DJF7zK7raFKg5mpHfY5gMnNcDA
         r5eAbYWcDvFaI3LfDeTLDOU3P/3HxyTjzcjZnwSgAFmbkUMVmK61yLCjUs4d3IRAu4g4
         8ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sh9539P06l7XfONUhLa5AqK9wy1IglWuxqgYOheM7+c=;
        b=ppCqAWUgBiy2y8KsN9AGL/rlLNuax3EirjTl6ypTeJhKXQRsZiugY3WWT3Px+QldDT
         30LMHEWeZJb5dYWstEr1SjipBOtSI7tLP4ZgqY/RvH4XaKAYn8S18smEEO3t1VVSQ6bD
         E1hyVgTR2o0QTAKqkjMQ6MwRDCkE/GJGEVttxF7sAFm7BVkt91uGqh3Cae++3e9pbo/S
         AKHy7M5bYlCiaGFI1Pv5LWrH7H6bt3BPhHI4GqIgJq8QrxRjLaPvTg2VveYexkCeYNmz
         s2GemsDTEdGBlnaar8xLK2iHZI/ZbpLosJ8R682CW2ZJsfrruYx54jnTEqYdPlrIXXgM
         OQ/Q==
X-Gm-Message-State: AOAM5335UWtGyLpDBgPZX3Y45MzGr0VeU4C05ly0ghJCkU2SAku9KD7H
        i7oeC+miI/Rkxu6beVPPC9Y=
X-Google-Smtp-Source: ABdhPJwzvdksAs2D82GhoTo13dgnuab1mbKENu8WjkLEJAF/GN3/BB97+dtTEw6SMIyZ96i27SHfWg==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr1204568wmi.188.1640184995156;
        Wed, 22 Dec 2021 06:56:35 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312::4fa? ([2001:b07:6468:f312::4fa])
        by smtp.googlemail.com with ESMTPSA id z6sm2468781wmp.9.2021.12.22.06.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 06:56:34 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <56689a97-79bf-9669-3c78-1704a98ec445@redhat.com>
Date:   Wed, 22 Dec 2021 15:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 08/13] KVM: selftests: add SEV boot tests
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        Mingwei Zhang <mizhang@google.com>
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Peter Gonda <pgonda@google.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
 <20211216171358.61140-9-michael.roth@amd.com> <Yb/hGzeiRi0AwfV6@google.com>
 <20211221154036.ivef7wuoblavlmsf@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211221154036.ivef7wuoblavlmsf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/21/21 16:40, Michael Roth wrote:
>> Probably, you want to use macros to represent those states which should
>> make it more clear. Otherwise, it is quite cumbersome for readers to
>> remember the meaning (or state) of 100/101/102.
> I agree with that approach in general, but in this case it's a bit
> awkward since, these aren't necessarily similarly grouped tests where each
> test falls under a certain category of TEST_GROUP_x where a macro would
> provide additional information about the nature of the tests related to a
> particular SYNC() call, in some cases it's an aggregate of multiple
> things, for instance...

Indeed, these are just numbers that match between guest_test_common and 
test_common.  It's not too hard to follow if you look at the two 
functions side-by-side.

Paolo
