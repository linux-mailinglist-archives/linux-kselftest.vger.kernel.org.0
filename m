Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75A201AC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 20:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbgFSSw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 14:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbgFSSw5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 14:52:57 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B1C06174E;
        Fri, 19 Jun 2020 11:52:57 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id di13so4939631qvb.12;
        Fri, 19 Jun 2020 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hJpxaO8wecs1gNV5FgZjVozSJfwwAkVOxq5pqOxymAM=;
        b=cUhSM1PztUEgyiNZaYEdtH4fvMAu1DLukX02awRYoK34br2QzEKEmrdkGZZtbdJ3AL
         9ccFpK0x831zJf5osXFDvzZGWKtc7Tqy+jlLDEGsU+8RjJHDByGs/NZq0NEfUhdpGzZB
         tX6QQCOManOu7LK1HF+CwpTePa1G9BjG4f+4vciiqQNviH7u9tljlXvEHVfURHG9kg6t
         LWy7lnL6k3waDz3anm1oGF6IVEny/5jtRDEpNtWGTWI5Tel4YGLSe0WEt+U/m4+L2obh
         0X8wt6/qnNSFzftwzBeyioSFBEvUBBnmTOXa+kqJGhOkPqAW1SGw6tNKuVdtK6IBVMFW
         a7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hJpxaO8wecs1gNV5FgZjVozSJfwwAkVOxq5pqOxymAM=;
        b=dwmdop4qAGeSxEcmUeCZeM+TgGgPwImV9Tcc3CZWOAqGDGi0fxKIggDQCf9y/LDGgx
         5nEVBtolwR/z7vScWP1YSpD3UAUGdPbZocAW08FDz8INGIxlCRwM14Nm8QVCCvmgrLti
         paFh7aKho1yb5xPi8eY3COtOgnky2b8keR5FYmRDT3o1muItgY7jL14Rf1KUDUS1YTAo
         QDsvaMX33LbeZvT3mlPZxOBhthWYNkWJCnwiTmQDjDj0tBUfaikBknlSEbCyR3YY/GHL
         GGh1RSVsC3wOy22QPhoAseMnTHq6PqhoWA6t0iTmSzV3YZHN7dG5cvhFb1TujI6yCm6h
         wvBw==
X-Gm-Message-State: AOAM530WlBc75yEKAAXKVV5q9MqFaA+lZJk1OtVTVBTaFGO21VqAY7jb
        909pRrG8sJdNypH0QiXS1u0=
X-Google-Smtp-Source: ABdhPJxKMajxQem/Kij7mKkifvxhM6NLm7pnMBGYr2xu+ZwSgceGTfmvc8rsKifEZ3/7vXhSwKyoBg==
X-Received: by 2002:ad4:4962:: with SMTP id p2mr10184688qvy.55.1592592776609;
        Fri, 19 Jun 2020 11:52:56 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id g132sm6589963qkb.78.2020.06.19.11.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:52:56 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Kees Cook <keescook@chromium.org>, "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006161642.A5F50ED07@keescook>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <19617b29-0298-5caf-39f2-ab08a7fddb82@gmail.com>
Date:   Fri, 19 Jun 2020 13:52:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202006161642.A5F50ED07@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-16 18:52, Kees Cook wrote:
> On Mon, Jun 15, 2020 at 07:07:34PM +0000, Bird, Tim wrote:
>> From: Kees Cook <keescook@chromium.org>
>>> Note: making the plan line required differs from TAP13 and TAP14. I
>>> think it's the right choice, but we should be clear.
>>
>> [...]
>> With regards to making it optional or not, I don't have a strong
>> preference.  The extra info seems helpful in some circumstances.
>> I don't know if it's too onerous to make it a requirement or not.
>> I'd prefer if it was always there (either at the beginning or the end),
>> but if there is some situation where it's quite difficult to calculate,
>> then it would be best not to mandate it. I can't think of any impossible
>> situations at the moment.
> 
> I think we should require one of:
> 
> - starting plan line
> - ending plan line

> - ending with something that indicates "I'm done, but I have no idea how
>   many tests actually ran" (Maybe "1..?")

I understand the desire to be able to say "I don't know how many tests
actually ran", but the use of it should be discouraged, even if available.

-Frank

> 
> To me, the point of the plan line is to be able to say "this test did,
> in fact, finish". So even if some test can't even count how many tests
> it _ran_, it can at least say "I am now finished".
> 
>>> TAP13/14 makes description optional, are we making it required (I think
>>> we should). There seems to be a TAP13/14 "convention" of starting
>>> <description> with "- ", which I'm on the fence about it. It does make
>>> parsing maybe a little easier.
>>
>> I would like the description to be required.
>> I don't have a strong opinion on the dash.  I'm OK with either one (dash
>> or no dash), but we should make kselftest and KUnit consistent.
> 
> I find the dash to be distracting -- it doesn't help me scan it, and it
> doesn't help a parser (which only needs to find "#").
> 
>>>> Differences between kernel test result format and TAP13:
>>>>  - in KTAP the "# SKIP" directive is placed after the description on
>>>>    the test result line
> 
> I sent a bunch of clean-ups for kselftest.h recently[1], but it looks
> like we'll need more for adding "description" to skip (right now it only
> prints the SKIP reason).
> 
> [1] https://lore.kernel.org/lkml/20200611224028.3275174-1-keescook@chromium.org/
> 
>>> Yes Documentation/*.rst Not sure on name yet, but where do kselftest
>>> docs live? :)
>> Documentation/dev-tools/kselftest.rst
>>
>> I'll put this at: Documentation/dev-tools/test-results-format.rst
> 
> Sounds good!
> 

