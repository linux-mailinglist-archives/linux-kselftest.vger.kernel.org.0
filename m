Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C264D14A7C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 17:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgA0QFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 11:05:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33215 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0QFT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 11:05:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so12031817wrq.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2020 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6H46utUXqWdcEAdVv2FVcUX2Nzt6oOZWEwm5mopEtQ=;
        b=lSrHYImJgrXOI9Xb9HdwFOlIhHOT7WlPCAHlGon94ANIEMufexCuQtRYNTeJQq6hWK
         s9U7i+AvdS+wc7zSyt5W7VUxd/xD/Dn/aeVhcB2724gCMmkx0x/STt+zS71QDnLPfrO8
         o0Vqb3iOw8/E7E4x8DYjqJTtTQhCYOLoA5uupr7ew2KNOrlNzkCOQfZe/Nha+VlXwxIB
         LaN41dV3GyfgAWf2o8hNMTaZOU2oGe7UWOcTgWvgMsih1y7Awd/OM/XhzmyhcKI4pMrv
         2otBaIHeLbmWPw1yiRKoJUXjjDBk5hLbuLiTDu9palf6il16C854zU9SD9VoMaJTJFjU
         TImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6H46utUXqWdcEAdVv2FVcUX2Nzt6oOZWEwm5mopEtQ=;
        b=q70J56nEUnLs1CysRHNe5Yt0KwJJlMFKtKvy7CanfsbF9NZVLPGhH3uWxwu4QfdNpR
         xHl4f2nwhSz+wwdYk0tMf7US3x9U1aAyHjrwBFKWMXj0HuxoonbMWRJXKkt3bbEhgBh9
         R/V5aKN+CSC7L7gakAXz3jVQfyo8D9Qc1N/JOVMn7bK7kUpad+7sL38mL9pubqOeOgY5
         zj/g3U67tsJGFxyQabu6gjDmq78QdfoyNoWVkHtVo+nGFL4slV7z7g6VQpZLFQwBPXl6
         CO3d3v4a/qUjKFoEpNJISi2W3uNgHxm/ll+kf/OdN2nntM8NH9QaPTvgBTfcwt+9E2BF
         Pllg==
X-Gm-Message-State: APjAAAXbQ5rWG2Ic8MYQpD0O5Vt95mZiwEUdXi54Fhflb+zi2NBpZHrd
        Qp8TzWinb0cW3ZnUkDf+o+U7Vg==
X-Google-Smtp-Source: APXvYqwpYQz0VV1m6hgiBAcj+79gFn95NBwTzxj50XN2aw3gaqLikpXVbctrQJK2nyss4LiIc0hpFA==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr24177891wrh.371.1580141117057;
        Mon, 27 Jan 2020 08:05:17 -0800 (PST)
Received: from tsr-lap-08.nix.tessares.net (hag0-main.tessares.net. [87.98.252.165])
        by smtp.gmail.com with ESMTPSA id 16sm18938279wmi.0.2020.01.27.08.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 08:05:16 -0800 (PST)
Subject: Re: [PATCH] selftests: settings: tests can be in subsubdirs
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        mptcp <mptcp@lists.01.org>
References: <20191022171223.27934-1-matthieu.baerts@tessares.net>
 <c9ce5016-9e83-67c0-ae22-2d3c46427b25@tessares.net>
 <201911211018.D6CD68AC5@keescook>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <602ab319-dcb9-4ac7-b2b8-f7b6072ddc03@tessares.net>
Date:   Mon, 27 Jan 2020 17:05:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <201911211018.D6CD68AC5@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah, Kees,

On 21/11/2019 19:52, Kees Cook wrote:
> On Thu, Nov 21, 2019 at 05:32:42PM +0100, Matthieu Baerts wrote:
>> Hi Shuah,
>>
>> First, thank you for maintaining the Kernel Selftest framework!
>>
>> On 22/10/2019 19:12, Matthieu Baerts wrote:
>>> Commit 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second
>>> timeout per test) adds support for a new per-test-directory "settings"
>>> file. But this only works for tests not in a sub-subdirectories, e.g.
>>>
>>>    - tools/testing/selftests/rtc (rtc) is OK,
>>>    - tools/testing/selftests/net/mptcp (net/mptcp) is not.
>>>
>>> We have to increase the timeout for net/mptcp tests which are not
>>> upstreamed yet but this fix is valid for other tests if they need to add
>>> a "settings" file, see the full list with:
>>>
>>>     tools/testing/selftests/*/*/**/Makefile
>>>
>>> Note that this patch changes the text header message printed at the end
>>> of the execution but this text is modified only for the tests that are
>>> in sub-subdirectories, e.g.
>>>
>>>     ok 1 selftests: net/mptcp: mptcp_connect.sh
>>>
>>> Before we had:
>>>
>>>     ok 1 selftests: mptcp: mptcp_connect.sh
>>>
>>> But showing the full target name is probably better, just in case a
>>> subsubdir has the same name as another one in another subdirectory.
>>>
>>> Fixes: 852c8cbf34d3 (selftests/kselftest/runner.sh: Add 45 second timeout per test)
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Sorry to bother you again with this but by chance, did you have a look at
>> the patch below? :)
>>
>> It doesn't only fix an issue with MPTCP, not in the kernel yet. But it also
>> fixes the issue of taking the right "settings" file (if available) for any
>> other tests in a sub-directory, e.g.:
>>
>>    drivers/dma-buf
>>    filesystems/binderfs
>>    net/forwarding
>>    networking/timestamping
>>
>> But I guess all tests in powerpc/* dirs and others.
> 
> Thanks for the ping! I missed this patch when you originally sent it.
> Yes, this make sense to me:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Kees, Thank you for this review!

Shuah, I am sorry to send you this new request. It is just to inform you 
that the first selftests for MPTCP are now in "net-next" repo, ready for 
the future Linux 5.6.
We would then be very happy to see this patch here below for the 
kselftest framework accepted to avoid timeouts. Locally we apply this 
patch before running the selftests but we cannot ask everybody running 
MPTCP' selftests to do the same :)

> As an improvement on this, I wonder if we need to walk all directories
> between $BASEDIR and $DIR? Actually, let me write this and send it...

Thank you, Kees, for this improvement!

Cheers,
Matt

> 
> -Kees
> 
>>
>> Cheers,
>> Matt
>>
>>> ---
>>>    tools/testing/selftests/kselftest/runner.sh | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
>>> index 84de7bc74f2c..0d7a89901ef7 100644
>>> --- a/tools/testing/selftests/kselftest/runner.sh
>>> +++ b/tools/testing/selftests/kselftest/runner.sh
>>> @@ -90,7 +90,7 @@ run_one()
>>>    run_many()
>>>    {
>>>    	echo "TAP version 13"
>>> -	DIR=$(basename "$PWD")
>>> +	DIR="${PWD#${BASE_DIR}/}"
>>>    	test_num=0
>>>    	total=$(echo "$@" | wc -w)
>>>    	echo "1..$total"
>>> -- 
Matthieu Baerts | R&D Engineer
matthieu.baerts@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
