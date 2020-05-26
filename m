Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A781E2374
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 15:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgEZN6x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 09:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgEZN6w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 09:58:52 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7884AC03E96D
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 06:58:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g25so16279574otp.13
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XWqm20ortSoNX+nbX7a42upA+Vp64e+AVN09KF9Ad8M=;
        b=dH/zxctH3oJeLyU5L+BqkAe7IuarlhEZvNhoE61BAaOVZQYyWBIx6XMKPEj9Q2xMWP
         ZsEFnhvFyiLx3H8BBdfGDHVnBXtNyuTxECLTFxOv9e6JXEKggaRuPijgIy8jOBVnTLmg
         810kGA3cnWAe5bxBSO7qekFipcvZXgBSCLPGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XWqm20ortSoNX+nbX7a42upA+Vp64e+AVN09KF9Ad8M=;
        b=iRRNPhZLuZggQjtbFLfHbu6GKCGAvO+mVzQ829ig/17FCcMANA/2zDFl/B9X4DYWAb
         Rez3UYeAEDevJQMLeeiV5JbTBeHEQsJv/aP3ZfD+mFDJLAsmvpH15YtRsdtRq70lkhS5
         9nFDkgjkVvMnA5kcJEvfPQxq6A3I03ugVBobWV+4uLykDM7PNhcZ5o2BD0+3nDnscrT0
         yJX6YGa4cPXqmPA3f1RQ6dytDZ3G7DF71rqc8aVFXRRp3k7Jd2yXGL4XeCKsyL0TBeeR
         9ri8DwNHLdr518LDLggkPdXeJw6m1MA9+/oO5YnkH66ekKDMqIc2qng51B0PciXLeLaK
         nNCg==
X-Gm-Message-State: AOAM531s5RG9BmgY1/+Rkky9/tSEQktK4Z4hrIa6032arsa0K87kATi8
        z/PdB0+ip0+KntKRMyF06JpWzg==
X-Google-Smtp-Source: ABdhPJz+/zK5moeWMtUn69a8IIKjkkhGLNDtnmG2OwfD8yave3Ngp7r9TvkVF/HxgAP9kKH0Uj/a2A==
X-Received: by 2002:a9d:2da8:: with SMTP id g37mr932324otb.293.1590501531610;
        Tue, 26 May 2020 06:58:51 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d19sm10979ooa.48.2020.05.26.06.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 06:58:50 -0700 (PDT)
Subject: Re: [RESEND] kunit: use --build_dir=.kunit as default
To:     Vitor Massaru Iha <vitor@massaru.org>, shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200414230950.83665-1-vitor@massaru.org>
 <CAFd5g47CaeEBiJsiSUtihHQF+OGpfCg76dS2ys2mwy2qn_L5-w@mail.gmail.com>
 <c035d65b-7e93-f948-22f9-73a56193ec36@kernel.org>
 <b04934ab91fd57e6df35279ad8a2619afb00b452.camel@massaru.org>
 <6403abc0c60fcb5069e1cdea0bb7f25b6dc8070f.camel@massaru.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5599cbd7-2c2d-7035-deea-25e6e0da407e@linuxfoundation.org>
Date:   Tue, 26 May 2020 07:58:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6403abc0c60fcb5069e1cdea0bb7f25b6dc8070f.camel@massaru.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/25/20 8:27 PM, Vitor Massaru Iha wrote:
> On Mon, 2020-05-25 at 22:52 -0300, Vitor Massaru Iha wrote:
>> Hi Shuah,
>>
>> On Fri, 2020-05-22 at 16:40 -0600, shuah wrote:
>>> On 4/16/20 5:11 PM, Brendan Higgins wrote:
>>>> On Tue, Apr 14, 2020 at 4:09 PM Vitor Massaru Iha <
>>>> vitor@massaru.org> wrote:
>>>>> To make KUnit easier to use, and to avoid overwriting object
>>>>> and
>>>>> .config files, the default KUnit build directory is set to
>>>>> .kunit
>>>>>
>>>>>    * Related bug:
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=205221
>>>>>
>>>>> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
>>>>
>>>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>>>>
>>>
>>> Applied the patch to kselftest/kunit on top of
>>>
>>> 45ba7a893ad89114e773b3dc32f6431354c465d6
>>> kunit: kunit_tool: Separate out config/build/exec/parse
>>>
>>> from David's work resolving merge conflicts. Please check if it is
>>> sane.
>>>
>>> thanks,
>>> -- Shuah
>>
>> The kunit branch had some problems related to identation. KUnit's
>> code
>> has mixed identation, and with that, in conflict correction, it ended
>> up breaking python.
>>

Thanks for sanity checking my merge.

>> In addition I found a bug: related to the creation of the
>> .kunitconfig
>> file inside the default build directory.
> 
> This is actually related to the other patch "kunit: use KUnit defconfig
> by default"
> 
> 
>>   Should I send the patch again?
>> Or do I make a bugfix patch?
>>

Please send the fix.

thanks,
-- Shuah

