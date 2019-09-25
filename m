Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03991BE2CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2019 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfIYQrs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Sep 2019 12:47:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43988 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392113AbfIYQrp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Sep 2019 12:47:45 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so433995iob.10
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2019 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NkXsROJEqHRyKdQlVbGyAe4U+SjsHNVLF9ZqIX8Inqc=;
        b=cvIb5jN5ZNe3gcMhopMVIXvHGnL0ia+pw5VgYZdzsGtBj2PWdLn+6/6Xk9jV6bzT9o
         h1LVnt9n0pL1jIZHv576RNKWXcxrLcUvyr2BwcIJic2f8GCwC3zB44tI4JW8yP/3Mpu3
         gud32+/+nqFYxOuwA86a4BFK5VZcMfTsermAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NkXsROJEqHRyKdQlVbGyAe4U+SjsHNVLF9ZqIX8Inqc=;
        b=X6F8jHEmYQhp4v0it92oqqIQaXOR036y4zfPR0qVPLfc86k0s89aGmj8qO4KvSXYOH
         oMn/p1z668ztqIrlFetre0mFjLSW1OmQz1VBMDCv8/btiSWVmaturp0S/wiNcecObr/w
         GTK3rC6FFTA/Oz+rY1zCCscdKeeA0A1U02ZCNVa26s8PN6lt2L4DQf72HbM4eI/8sE+b
         Wc9XX+Jsk2aNvpYWFU9GLJWN7F2KMgAmfZvFT2sLaiGmzujP+h5W174e4J/RcnQaqlnY
         UiJKLYxb4pwQeZsjNpnGXq91kAQ+cRG60e8gob61Z6hjn/CiXR35Ap8nMgWMEKq0hpVB
         KaGA==
X-Gm-Message-State: APjAAAUwNiNHlh+3vjfDd6DVVxdX6E3UrgSGrYOl0VRMbv9iwWsJvFQw
        PU55wcunjyAQSin0z5yb78wSVw==
X-Google-Smtp-Source: APXvYqzdSzByx/7StFCVjxm7mpWRvxuckLEoPCZv+n1Qfdo3taMQ72Ag4Z6qoA4O/vT1bqCJUSjskw==
X-Received: by 2002:a5d:8911:: with SMTP id b17mr267767ion.287.1569430063967;
        Wed, 25 Sep 2019 09:47:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s24sm75616iog.26.2019.09.25.09.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 09:47:43 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: Fix libkvm build error
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190924201451.31977-1-skhan@linuxfoundation.org>
 <dbfb9d46-488a-b940-c86f-79ad750a324a@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5fecb8a8-8a6a-1e2b-78e3-5660597a02e4@linuxfoundation.org>
Date:   Wed, 25 Sep 2019 10:47:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dbfb9d46-488a-b940-c86f-79ad750a324a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/25/19 1:48 AM, Paolo Bonzini wrote:
> On 24/09/19 22:14, Shuah Khan wrote:
>> Fix the following build error:
>>
>> libkvm.a(assert.o): relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIC
>>
>> Add -fPIC to CFLAGS to fix it.
> 
> This is wrong, these testcases cannot be position-independent
> executables.  Can you include the failing command line from "V=1"
> output?
> 

You are right. This isn't correct.

> The problem seems to be that these definitions are not working properly:
> 
> no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
>          $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
> 
> LDFLAGS += -pthread $(no-pie-option)
> 

Yup. That is what is happening, when I build using

"make TARGETS=kvm kselftest"

You can see this below:

gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 
-fno-stack-protector -fno-PIE -I../../../../tools/include 
-I../../../../usr/include/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I.. 
-pthread    x86_64/cr4_cpuid_sync_test.c


vs.

Running make in kvm directory:

gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 
-fno-stack-protector -fPIC -fno-PIE -I../../../../tools/include 
-I../../../../usr/include/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I.. 
-pthread  -no-pie   x86_64/cr4_cpuid_sync_test.c

I was playing with both options yesterday and totally confused myself
thinking that adding fPIC helps. It doesn't.

I am looking into this to see how we can make "make kselftest" work.
Once I figure it out, will send v2. I think for some reason in the
failing case, no-pie-option and pgste-option are null strings.

thanks,
-- Shuah
