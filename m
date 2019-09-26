Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3C4BFB3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 00:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfIZWLj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 18:11:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38223 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfIZWLj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 18:11:39 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so10740889iom.5
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2019 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e5GWt3lztsgnfc3sldD8RB9/EhbtgxcMAZ8pv6IBv0o=;
        b=DNPR0aGdrz0Z8MxoYfs7keH6LEZ15NGlhg7uvwGt/utwm1UUTEfsyN4gUyHMfg37WS
         NFX+lvIQClaCK9QlECR98ZRoQp9yYwjccp/1ZmtZFBlQhRUY0eEkOBXYudCmgsjE3CMT
         UPWq9nbhTGUrx7AcnsfCUxCnNo8ucyLXg6Ivo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5GWt3lztsgnfc3sldD8RB9/EhbtgxcMAZ8pv6IBv0o=;
        b=WGPDSb5zTFjlNT7av8O+ZGu4qf+AK38V7+UBtEsKe3F9ya+3Edz2mwpIWjR5AT78Lo
         pSsdXNcB6TgleXrVeAXFMYHJwyR6naHMm07/rlTZQ4eQkUfjR+T3c+x4MyqdAfh4IvPy
         GUwatC3ITJD8Scj4dlE/gq3SWuRsDT5Ze3H2Pzf5vEGo4utCyAbVvcFg6gAhD5WA0AOc
         +T++WxhkhBkNVjQ7Smr13re7wkcQG3rFeLw3wQaBS09ONJbf5+bVf2tYgLZyFAYABUfV
         vZSpT73t3FdWzb/xJBBoNJtYfrfwtKC66wkpSDUr9m5Cx/U4nQHVdSalb0Iavnfm0MI6
         i/Zw==
X-Gm-Message-State: APjAAAWBLuW5W4OmpD3Fo3IUKLCc9acw0DooHFHogw9UjxqReCzl2Gtf
        y1raW9zh4/+KghzzY3B0sK1FZA==
X-Google-Smtp-Source: APXvYqzEIS99foCZIJEt/mjEPQI28ZkWb2KVeBSzeuCd5zi5J2t81jLUt+IwTIWsCPnNn1bbmfgnQg==
X-Received: by 2002:a92:c00d:: with SMTP id q13mr1102096ild.169.1569535898607;
        Thu, 26 Sep 2019 15:11:38 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a17sm320403ilf.22.2019.09.26.15.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 15:11:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] selftests: Add kselftest_install target to main
 Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        "Cc: Shuah Khan" <shuah@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <cover.1569452305.git.skhan@linuxfoundation.org>
 <b3c50f4c726df521039f57295b53349227f629d9.1569452305.git.skhan@linuxfoundation.org>
 <CAK7LNATCFF9ERTwtPnnbMLGv++NJ_5zXxB0=NWHdSGrYADj3ug@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <43a7962e-4fae-78e4-1db2-b75c7ff802b1@linuxfoundation.org>
Date:   Thu, 26 Sep 2019 16:11:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATCFF9ERTwtPnnbMLGv++NJ_5zXxB0=NWHdSGrYADj3ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/25/19 9:24 PM, Masahiro Yamada wrote:
> Hi Shuah,
> 
> 
> 
> On Thu, Sep 26, 2019 at 8:05 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Add kselftest_install target to install tests from the top level
>> Makefile. This is to simplify kselftest use-cases for CI and
>> distributions where build and test systems are different.
>>
>> This change addresses requests from developers and testers to add
>> support for installing kselftest from the main Makefile.
>>
>> In addition, make the install directory the same when install is
>> run using "make kselftest_install" or by running kselftest_install.sh.
>> Also fix the INSTALL_PATH variable conflict between main Makefile.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> So, if these two patches were applied, we would see the following:
> 
> 
> PHONY += kselftest_build
> kselftest_build:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests all
> 
> PHONY += kselftest
> kselftest:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> 
> PHONY += kselftest_install
> kselftest_install:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests install
> 
> PHONY += kselftest-clean
> kselftest-clean:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests clean
> 
> 
> I do not want to see this endless crap addition just for
> changing the working directory to $(srctree)/tools/testing/selftests
> 
> 
> 
> Why don't you use pattern rule?
> Those will be reduced into the two rules.
> 

I just didn't think about simplifying it. Thanks for
being direct.

> 
> 
> PHONY += kselftest
> kselftest:
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> 
> kselftest-%: FORCE
>          $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> 
> 
> 
> This also avoids your inconsistency about
> "kselftest-" vs "kselftest_".
> 
> 
> Given the existing "kselftest-clean" and "kselftest-merge",
> "kselftest_build" and "kselftest_install"
> (using an underscore instead of n hyphen)
> would add needless confusion.
> 
> 

Done. Sending v2 with two patches collapsed into one.

thanks,
-- Shuah
