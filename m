Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E66DB9E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 00:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441619AbfJQWvb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 18:51:31 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37577 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438612AbfJQWva (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 18:51:30 -0400
Received: by mail-il1-f196.google.com with SMTP id l12so3746688ilq.4
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/eF/L3m73e+e1oQsDpVEkuWHj3baK6hMXuTSH0BtWMA=;
        b=VOnh4QxHOkSB/aw6xuc4s2CW/EmlVg6shi8Vepao5j5TUeNZ/0Q6MBunp97DOYuO8Z
         lqRSovVOI8nWSlUE2Xcc+jOs8iCqdhc7QQwhAVGO92Bywg8YWmUJNfgeMbQ4TZalYuHZ
         H1ZrclA8HFOcApR60QFv7rgaOjdHkJ7JvGw1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/eF/L3m73e+e1oQsDpVEkuWHj3baK6hMXuTSH0BtWMA=;
        b=QfuXCSQ47YjF3dq+Rut1cXj6d1SZ54OmNZo1lOqb9JTEaQmnfZKfBq805b2MvqVHS8
         bgPuKcxMMBQH/MXf8Wp9fPjZI3n3Mcv6XsPXj5/rxHGRbjAXyjSKBJPB6+5nvHjRxRBs
         uJKvBCAPXOo4WxVn9hE1b0KRLjVhgsRE6t7NcObtpOUbdVF67I5b3YwAwWqi0axOaBhF
         TAI+PSiinxSIGD8sWAwtjlzk+XwLWXUHXQuxYxEMLIH/Xq5OqO6TghMW2ZiIfzWl4wFC
         hDPRJRpJjWyZLnLW/1fZ0dccIUaioZ5jUs6G6CmI4AQWYtbbv3GS7DVtt8ssnFmm1vsN
         y6uA==
X-Gm-Message-State: APjAAAW1/xOXKC2IXXfI+9hfA4Xt7fnA8Gs1mE2N+2eKB+d/NoiIFJAq
        OUvWdmiO02c+H+JgCzuM5pVckw==
X-Google-Smtp-Source: APXvYqwg26CF9upmlevG8JNy+vFcQXWOUpGE5JAzgz0/XPmngcr3LqkRmJOakfbKR22lkLCFEB48ww==
X-Received: by 2002:a92:1d5c:: with SMTP id d89mr6407901ild.94.1571352689406;
        Thu, 17 Oct 2019 15:51:29 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m9sm1677403ilc.44.2019.10.17.15.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 15:51:28 -0700 (PDT)
Subject: Re: [PATCH v2] selftests: Add kselftest-all and kselftest-install
 targets
To:     Michael Ellerman <mpe@ellerman.id.au>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190926224014.28910-1-skhan@linuxfoundation.org>
 <87sgnttpoq.fsf@mpe.ellerman.id.au>
 <adcfcda4-c36e-c222-4964-f83b5f3d0097@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7d8056fe-ddb3-1831-d18f-deed4e0d3a76@linuxfoundation.org>
Date:   Thu, 17 Oct 2019 16:51:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <adcfcda4-c36e-c222-4964-f83b5f3d0097@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/16/19 10:08 AM, Shuah Khan wrote:
> On 10/15/19 8:00 PM, Michael Ellerman wrote:
>> Hi Shuah,
>>
>> I know this has been merged already, so this is just FYI and in case it
>> helps anyone else who's tracking down build failures.
>>
> 
> Thanks for letting me know. I have been sending updates about
> breakages. Will send an update with this info.
> 
>> Sorry I didn't reply before you merged it, I was on leave.
>>
>> Shuah Khan <skhan@linuxfoundation.org> writes:
>>> Add kselftest-all target to build tests from the top level
>>> Makefile. This is to simplify kselftest use-cases for CI and
>>> distributions where build and test systems are different.
>>>
>>> Current kselftest target builds and runs tests on a development
>>> system which is a developer use-case.
>>>
>>> Add kselftest-install target to install tests from the top level
>>> Makefile. This is to simplify kselftest use-cases for CI and
>>> distributions where build and test systems are different.
>>>
>>> This change addresses requests from developers and testers to add
>>> support for installing kselftest from the main Makefile.
>>>
>>> In addition, make the install directory the same when install is
>>> run using "make kselftest-install" or by running kselftest_install.sh.
>>> Also fix the INSTALL_PATH variable conflict between main Makefile and
>>> selftests Makefile.
>> ...
>>> diff --git a/tools/testing/selftests/Makefile 
>>> b/tools/testing/selftests/Makefile
>>> index c3feccb99ff5..bad18145ed1a 100644
>>> --- a/tools/testing/selftests/Makefile
>>> +++ b/tools/testing/selftests/Makefile
>>> @@ -171,9 +171,12 @@ run_pstore_crash:
>>>   # 1. output_dir=kernel_src
>>>   # 2. a separate output directory is specified using O= KBUILD_OUTPUT
>>>   # 3. a separate output directory is specified using KBUILD_OUTPUT
>>> +# Avoid conflict with INSTALL_PATH set by the main Makefile
>>>   #
>>> -INSTALL_PATH ?= $(BUILD)/install
>>> -INSTALL_PATH := $(abspath $(INSTALL_PATH))
>>> +KSFT_INSTALL_PATH ?= $(BUILD)/kselftest_install
>>
>> This change broke all my CI, because the tests no longer install in the
>> place it's expecting them :/
>>
> 
> Sorry about that.
> 
>> I can fix it by explicitly specifying the install path in my CI scripts.
>>
>>> +KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
>>> +# Avoid changing the rest of the logic here and lib.mk.
>>> +INSTALL_PATH := $(KSFT_INSTALL_PATH)
>>
> 
> 
> I searched all the selftests Makefiles for it and convinced myself that,
> the above would take care of it for these cases. I searched powerpc
> Makefiles so this doesn't break it. Didn't think about the CI.
> 
> android/Makefile:    mkdir -p $(INSTALL_PATH)
> android/Makefile:    install -t $(INSTALL_PATH) $(TEST_PROGS) 
> $(TEST_PROGS_EXTENDED) $(TEST_FILES)
> android/Makefile:        $(MAKE) OUTPUT=$$BUILD_TARGET -C $$SUBDIR 
> INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR install; \
> futex/Makefile:    mkdir -p $(INSTALL_PATH)
> futex/Makefile:    install -t $(INSTALL_PATH) $(TEST_PROGS) 
> $(TEST_PROGS_EXTENDED) $(TEST_FILES)
> futex/Makefile:        $(MAKE) OUTPUT=$$BUILD_TARGET -C $$SUBDIR 
> INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR install; \
> sparc64/Makefile:    mkdir -p $(INSTALL_PATH)
> sparc64/Makefile:    install -t $(INSTALL_PATH) $(TEST_PROGS) 
> $(TEST_PROGS_EXTENDED) $(TEST_FILES)
> sparc64/Makefile:        $(MAKE) OUTPUT=$$BUILD_TARGET -C $$SUBDIR 
> INSTALL_PATH=$(INSTALL_PATH)/$$SUBDIR install; \
> 
> 
>> But because the over-rideable variable changed from INSTALL_PATH to
>> KSFT_INSTALL_PATH I will need to export both of them in order for my CI
>> to work with old and new kernels.
> 
> My mistake. I overlooked that this could be overridden and could
> be in used in CI scripts.
> 
>>

Can you send me your CI script for testing my changes? I also want
to make sure I don't break your CI again.

thanks,
-- Shuah
