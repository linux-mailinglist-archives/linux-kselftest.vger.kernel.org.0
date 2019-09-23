Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C71BBCD8
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2019 22:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502589AbfIWU30 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 16:29:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42366 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387470AbfIWU30 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 16:29:26 -0400
Received: by mail-io1-f65.google.com with SMTP id n197so36763310iod.9
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2019 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dvIwrEHo3XVBscwBga+E/4rR8hn4WyaWuLrNeRVb0wE=;
        b=ZMhIhfVMdxnCLLyLQB2v98nxgcjinY/NResoC9iqgWUfooRpQW1nbUwHE96zxsePXH
         l3rEKQZYUXzCxanIwE5tuN6puoumVuYVgbNgS5Tt8rwfRXP9ajRVZaQF/i25XPt0hWR2
         v/MRC5BAxTXMV0oxftl3S9t1AySFhNcZL0XZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dvIwrEHo3XVBscwBga+E/4rR8hn4WyaWuLrNeRVb0wE=;
        b=NBanOV5bAqzlG2tSRE99ZElELQaRQ+ysRCmq2OSAeQtWf/DhoFcASuQ1QwzmbWqgjk
         gaJ+Bldrsl87i5kPDHYyCW/htdfrX5GXfBf9M20J3AVVkKxUHqArEIX1JSyG2DN9HGKR
         RVeR27Sbjl/4GUlzrx5Q16RtC81qAhPfXaVtx9lVYP6XpDxMwnsq6jjGh5jSgPWe0Y4S
         26EeW3BmZfDdbaomolkGcpMWwMsUmg+w13abUKdu5G8k/n2HdRC+Zd0c/ziZpuJsZAsI
         ERaE0WCwfdqd5rYZ3cSDChUAvMAr+v6CPc3eEf8MdEA2k5kKvqUaV00Cq2RAjKSZ7LSG
         uvyg==
X-Gm-Message-State: APjAAAXE/Fxbzn2Aptt3IKyBDPbVUjN81HcPOrGqiRyLWiT/SHYPW3dV
        TrfyGpkvegyhWPraL93VrKRhbg==
X-Google-Smtp-Source: APXvYqzTEkrazddggyqMZ8imGJAbPuGKQKs/RDmi0jIUwnS+DiX8lI9KQi3LPALztbXhBjtOOR5s9w==
X-Received: by 2002:a6b:6514:: with SMTP id z20mr1401383iob.50.1569270565407;
        Mon, 23 Sep 2019 13:29:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z10sm2267650iog.41.2019.09.23.13.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:29:24 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com>
 <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
 <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
 <20190922112555.GB122003@gmail.com> <20190922115247.GA2679387@kroah.com>
 <0ab5da69-e4f2-8990-20f9-354461235581@linuxfoundation.org>
 <20190923194322.GA55255@gmail.com>
 <32d0e94d-bf9a-01e9-2548-1fc976c7f17b@infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f4c21702-f7b5-e6f9-b31d-8fc9e4d1c67d@linuxfoundation.org>
Date:   Mon, 23 Sep 2019 14:29:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <32d0e94d-bf9a-01e9-2548-1fc976c7f17b@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/23/19 1:52 PM, Randy Dunlap wrote:
> On 9/23/19 12:43 PM, Ingo Molnar wrote:
>>
>> * Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>> I am exploring the possibility to move selftests to a better location
>>> or add a git alias so it can be found easily. With the addition of
>>> KUnit and future work that is planned to connect kselftest and KUnit,
>>> it would make sense have selftests to be in a location that is better
>>> suited than where it currently resides.
>>>
>>> I have been getting feedback from some developers that they would like
>>> to see selftests more visible and easier to find.
>>>
>>> There are some dependencies (unintended, shouldn't exist) between some
>>> tests and content under tools that might pose some logistical problems,
>>> in addition to the churn of backporting.
>>>
>>> I haven't explored "git alias" yet though. Since this topic of moving
>>> came up, I would liek to get feedback on selftests location in general
>>> and where would be a good place for it.
>>
>> I'm not sure about the Git alias thing - but I do agree that
>> tools/testing/selftests is a pretty obscure location given the importance
>> of kernel unit tests - and I think it could be moved one level higher, to
>> tools/selftests? The "selftest" name already implies the "test" aspect
>> after all.
> 
Right. Obscure location given the importance is the problem.

> 
> Without trying to use too much paint, I would move testing/ to a top-level
> dir, outside of tools/, and leave selftest/ under testing/.
> 

Right. What you suggesting is very similar to and more complete than
what I have been thinking about and proposed at the KS kselftest track.


i.e move tools/testing/selftests to kselftest at the root level. I like
your idea of moving tools/testing up to root and keep selftests under
it.

If we are good with this kind of change, I would like to get this done
sooner than later. There is some back-porting churn to worry about.

thanks,
-- Shuah
