Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2986E201AA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 20:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbgFSSrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 14:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgFSSrb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 14:47:31 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C37C06174E;
        Fri, 19 Jun 2020 11:47:31 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id i16so7965080qtr.7;
        Fri, 19 Jun 2020 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m0BuFLVukL33YBK8VGa8ymOVVw9eyFfRyEXP/K7B/g4=;
        b=j7SViOXYXMM0PpPmcH8PZP2AoKNzj/q4ABtk6vTzD6m0XCF+YRvTqx07DM26SXH7oW
         Ggh1N6PNojjS5xy0ag7XO51UMp4TQRPX11wGfP75S9Pk1lvsE2G5TONDCVIGQ5/GrtE0
         m8kzlbuARBBe9xn2+hLEjd/DmvdJfzhdZawSBVEXr02ds3HMlUrwdo3rdbrnEYdZnkSx
         N/qiHZw9nL0TBzglhdmCcIHEeYLrCzuqhoudSnC/IM/Fl6gWLiipCXVcmmi3ZXIdZ4CS
         FtEhMTvoD3unMqYyv7m5WVikwu6YJbyvjn9mSXyFn9vUBh91aecNJG1q3kz/8zQ1QNrW
         0CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m0BuFLVukL33YBK8VGa8ymOVVw9eyFfRyEXP/K7B/g4=;
        b=mx5B33y//uwSyWx4EDwD0blwzHUNDXN7tiSZcDUz1oeRhpAGe2buIZKgOOvqCPX9oD
         VvFRf5igXvCpbDoP3q759zHhjDFuvV8kxu+bpCkkdGsBmbEIqGt8dE8RZpsH4h1FH5gt
         2pV+CgcSwj3bscMoyQSgpQ7/pJUX0tP4ALHbaetfLyTYwwxmp+Dlu3AirfzK/aOGi7KT
         3gK93igfwytkVtxAamtGZdVmoyY+7gYbXDyx0olNDWmMYTJxewNo76eMpBhiuFW3KoOW
         mIt2UFwpcl2n7EClxG0D8W0Zo6IHXNGDYmFevW5e1VVMyhZXK/gjbxVXR6vxYuc9wsr7
         YMbA==
X-Gm-Message-State: AOAM532vAls+fN/3UPellwSEBXpb/h9Dq0TYynhgFNZPN3txGRS341Id
        W0tYUn997KYSFRAr+erQHTk=
X-Google-Smtp-Source: ABdhPJwPG2oejNt4OSEKhhXW/OVESl5rn7E/ndkuDOxgstagGv5DrXSSiU8RaRBkV7u4y+ct3UY0iw==
X-Received: by 2002:ac8:794c:: with SMTP id r12mr4733460qtt.201.1592592450923;
        Fri, 19 Jun 2020 11:47:30 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id p7sm2110818qki.61.2020.06.19.11.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:47:30 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
 <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g454n4ZPgCdWaAxezFueG47TztqBx4L7x4oYwgPAR3BZNA@mail.gmail.com>
 <202006161653.15C278A5@keescook>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <398200b2-f8bc-894d-6d6f-366ff98a490e@gmail.com>
Date:   Fri, 19 Jun 2020 13:47:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202006161653.15C278A5@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-16 18:58, Kees Cook wrote:
> On Tue, Jun 16, 2020 at 12:44:28PM -0700, Brendan Higgins wrote:
>> On Tue, Jun 16, 2020 at 9:42 AM Bird, Tim <Tim.Bird@sony.com> wrote:
>>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>>
>>>> On 15/06/20 21:07, Bird, Tim wrote:
>>>>>> Note: making the plan line required differs from TAP13 and TAP14. I
>>>>>> think it's the right choice, but we should be clear.
>>>>
>>>> As an aside, where is TAP14?
>>> By TAP14, I was referring to the current, undocumented, KUnit
>>> conventions.
>>
>> Not so. TAP14 is the proposed next version of TAP13:
>>
>> https://github.com/TestAnything/testanything.github.io/pull/36
>> https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md
> 
> I was reading this (I haven't compared to the blob above):
> 
> https://github.com/TestAnything/Specification/blob/tap-14-specification/specification.md
> 
>> Based on the discussion, it seems like most of the things we wanted
>> from TAP14 would probably make it in if TAP ever accepts another pull
>> request.
> 
> Were our leading diagnostic lines part of their latest spec? I thought
> we were pretty far off in left field for that particular bit.
> 
>>> My personal preference is to have the dash.  I think it's more human readable.
>>> I note that the TAP spec has examples of result lines both with and without
>>> the dash, so even the spec is ambiguous on this.   I think not mandating it
>>> either way is probably best.  For regex parsers, it's easy to ignore with '[-]?'
>>> outside the pattern groups that grab the number and description.
>>
>> I don't think we care, because we don't use it.
> 
> Yeah, I'm in the same place. I don't care -- I would just like a
> determination. (The "implied" nature of it in TAP14 bothers me.)
> 
>>>> XFAIL/XPASS are different from SKIP.  I personally don't have a need for
>>>> them, but kselftests includes XFAIL/XPASS exit codes and they aren't
>>>> reflected into selftests/kselftest/runner.sh.
>>>>
>>>> Likewise, kselftest.h has ksft_inc_xfail_cnt but not
>>>> ksft_test_result_xfail/ksft_test_result_xpass.
> 
> I proposed fixing that recently[1]. seccomp uses XFAIL for "I have
> detected you lack the config to test this, so I can't say it's working
> or not, because it only looks like a failure without the config."

Based on that description, the case sounds like it should be a skip.

Or if the entire test depends on the missing config then Bail out might
be appropriate.

> 
> [1] https://lore.kernel.org/lkml/20200611224028.3275174-7-keescook@chromium.org/
> 

