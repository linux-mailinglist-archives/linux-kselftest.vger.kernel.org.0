Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D074547A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 14:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbhKQNnv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 08:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhKQNnv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 08:43:51 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F017C061764
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 05:40:52 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m9so3252817iop.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 05:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qCt6qy0PLygDsEBj5XoN0OOqfk99vPiJYd4EvtFANg8=;
        b=hxxK5JTld7JGHh+Z6IgyJwNqh6UaX6abKtiTviykUAMxpOMTP21JfV4nPu1r7QSpnO
         O5ftsigrBFXmO66ZW2TYuPQE3le/uafjx1B44pBpLdyK/hOgxRZq/1UFUQ8D6I1OcXK1
         rsnWsFSG88BBsccd9KQE9SZHtbrXFASbBXBDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qCt6qy0PLygDsEBj5XoN0OOqfk99vPiJYd4EvtFANg8=;
        b=aDr3qEDXgJhGfbSA9tJT3541HhdE0hvvXAOzcLA5ric79K3r/5/fGHICyBJoyCrUt6
         NfU8UwE8CRZIzugUNR9uNu3+HYiO2qXNIfarFJvzaWeZeqplG4tJ63iSp0U9Ybxl5o6p
         LXrC+1xeOSuQl3MBxE4dkuQcPKPEZJVN5rX1FCw4wukcqXbh3hDauavwRYTs3MT98Nrz
         +kY5EeesGdFaOSCKG0e4DGiqOdU3RPsDQR6QzwfB+Il+/z8ii5042EFV6HC0PtagWOx7
         d3LlXsohVHlXtdW+VYooNIS1lniOsB8MzYsYmKx86UDQtx7rbf314KRFrwFiFho8bptK
         u9xQ==
X-Gm-Message-State: AOAM532hPpF+Nxx3lBjENdAXq/GNPUkk1LGF56ZpyVndfOaM3sxoYXRo
        4W5L+PfBQUOaER0cFbtSOxf/SQ==
X-Google-Smtp-Source: ABdhPJxqUdEDKL9+ldECLPBvDJjXluvjeI3mADSewcs06k6UnnqCV06klM3i8SDXUPMKvrlCY5VNqA==
X-Received: by 2002:a05:6638:32aa:: with SMTP id f42mr12837237jav.115.1637156451841;
        Wed, 17 Nov 2021 05:40:51 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id ay13sm7541196iob.37.2021.11.17.05.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 05:40:51 -0800 (PST)
Subject: Re: [PATCHv2] selftests: kselftest.h: mark functions with 'noreturn'
To:     Anders Roxell <anders.roxell@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211103094752.1263442-1-anders.roxell@linaro.org>
 <CAKwvOdkq9k7ceyvnDWNN6m-vYOx41a6BBZwHy_0eDRfx5B4KnQ@mail.gmail.com>
 <CADYN=9+_UU9qZX56uahGXxz00iayqJLRAaQrRXh1CMXTvwSbAg@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e00fb2ce-b931-c725-7506-027bab0a6c47@linuxfoundation.org>
Date:   Wed, 17 Nov 2021 06:40:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CADYN=9+_UU9qZX56uahGXxz00iayqJLRAaQrRXh1CMXTvwSbAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/17/21 4:01 AM, Anders Roxell wrote:
> On Wed, 3 Nov 2021 at 19:38, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> On Wed, Nov 3, 2021 at 2:47 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>>>
>>> When building kselftests/capabilities the following warning shows up:
>>>
>>> clang -O2 -g -std=gnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o test_execve
>>> test_execve.c:121:13: warning: variable 'have_outer_privilege' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>>>          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
>>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> test_execve.c:136:9: note: uninitialized use occurs here
>>>          return have_outer_privilege;
>>>                 ^~~~~~~~~~~~~~~~~~~~
>>> test_execve.c:121:9: note: remove the 'if' if its condition is always true
>>>          } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
>>>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> test_execve.c:94:27: note: initialize the variable 'have_outer_privilege' to silence this warning
>>>          bool have_outer_privilege;
>>>                                   ^
>>>                                    = false
>>>
>>> Rework so all the ksft_exit_*() functions have attribue
>>> '__attribute__((noreturn))' so the compiler knows that there wont be
>>> any return from the function. That said, without
>>> '__attribute__((noreturn))' the compiler warns about the above issue
>>> since it thinks that it will get back from the ksft_exit_skip()
>>> function, which it wont.
>>> Cleaning up the callers that rely on ksft_exit_*() return code, since
>>> the functions ksft_exit_*() have never returned anything.
>>>
>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>> ---
>>>   tools/testing/selftests/clone3/clone3.c              |  4 +++-
>>>   .../testing/selftests/clone3/clone3_clear_sighand.c  |  2 +-
>>>   tools/testing/selftests/clone3/clone3_set_tid.c      |  4 +++-
>>>   tools/testing/selftests/ipc/msgque.c                 | 10 +++++-----
>>>   tools/testing/selftests/kcmp/kcmp_test.c             |  2 +-
>>>   tools/testing/selftests/kselftest.h                  | 12 ++++++------
>>>   .../membarrier/membarrier_test_multi_thread.c        |  2 +-
>>>   .../membarrier/membarrier_test_single_thread.c       |  2 +-
>>>   tools/testing/selftests/pidfd/pidfd_fdinfo_test.c    |  2 +-
>>>   tools/testing/selftests/pidfd/pidfd_open_test.c      |  4 +++-
>>>   tools/testing/selftests/pidfd/pidfd_poll_test.c      |  2 +-
>>>   tools/testing/selftests/pidfd/pidfd_test.c           |  2 +-
>>>   tools/testing/selftests/resctrl/resctrl_tests.c      |  6 +++---
>>>   tools/testing/selftests/sync/sync_test.c             |  2 +-
>>>   tools/testing/selftests/timers/adjtick.c             |  4 ++--
>>>   tools/testing/selftests/timers/alarmtimer-suspend.c  |  4 ++--
>>>   tools/testing/selftests/timers/change_skew.c         |  4 ++--
>>>   tools/testing/selftests/timers/clocksource-switch.c  |  4 ++--
>>>   tools/testing/selftests/timers/freq-step.c           |  4 ++--
>>>   tools/testing/selftests/timers/inconsistency-check.c |  4 ++--
>>>   tools/testing/selftests/timers/leap-a-day.c          | 10 +++++-----
>>>   tools/testing/selftests/timers/leapcrash.c           |  4 ++--
>>>   tools/testing/selftests/timers/mqueue-lat.c          |  4 ++--
>>>   tools/testing/selftests/timers/nanosleep.c           |  4 ++--
>>>   tools/testing/selftests/timers/nsleep-lat.c          |  4 ++--
>>>   tools/testing/selftests/timers/posix_timers.c        | 12 ++++++------
>>>   tools/testing/selftests/timers/raw_skew.c            |  6 +++---
>>>   tools/testing/selftests/timers/set-2038.c            |  4 ++--
>>>   tools/testing/selftests/timers/set-tai.c             |  4 ++--
>>>   tools/testing/selftests/timers/set-timer-lat.c       |  4 ++--
>>>   tools/testing/selftests/timers/set-tz.c              |  4 ++--
>>>   tools/testing/selftests/timers/skew_consistency.c    |  4 ++--
>>>   tools/testing/selftests/timers/threadtest.c          |  2 +-
>>>   tools/testing/selftests/timers/valid-adjtimex.c      |  6 +++---
>>>   tools/testing/selftests/vm/madv_populate.c           |  2 +-
>>>   35 files changed, 80 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
>>> index 42be3b925830..ede5da0c67b4 100644
>>> --- a/tools/testing/selftests/clone3/clone3.c
>>> +++ b/tools/testing/selftests/clone3/clone3.c
>>> @@ -191,5 +191,7 @@ int main(int argc, char *argv[])
>>>          test_clone3(CLONE_NEWPID, getpagesize() + 8, -E2BIG,
>>>                          CLONE3_ARGS_NO_TEST);
>>>
>>> -       return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
>>> +       if (ksft_get_fail_cnt())
>>> +               ksft_exit_fail();
>>> +       ksft_exit_pass();
>>>   }
>>> diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
>>> index 47a8c0fc3676..dcd9448eaeec 100644
>>> --- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
>>> +++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
>>> @@ -124,5 +124,5 @@ int main(int argc, char **argv)
>>>
>>>          test_clone3_clear_sighand();
>>>
>>> -       return ksft_exit_pass();
>>> +       ksft_exit_pass();
>>>   }
>>> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
>>> index 0229e9ebb995..a755fcd3af89 100644
>>> --- a/tools/testing/selftests/clone3/clone3_set_tid.c
>>> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
>>> @@ -393,5 +393,7 @@ int main(int argc, char *argv[])
>>>   out:
>>>          ret = 0;
>>>
>>> -       return !ret ? ksft_exit_pass() : ksft_exit_fail();
>>> +       if (ret)
>>> +               ksft_exit_fail();
>>> +       ksft_exit_pass();
>>
>> This case is weird (pre-existing-ly) and looks broken.  The assignment
>> to ret should probably occur _before_ the out: label.  Honestly, I'd
>> remove the use of goto from this function and just call either
>> ksft_exit_pass() or ksft_exit_fail().
> 
> I can do that in a followup patch.
> 

Let's fold this change in. Please send me v3 with.

thanks,
-- Shuah
