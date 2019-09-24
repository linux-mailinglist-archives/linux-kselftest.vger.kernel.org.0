Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C480DBCC94
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfIXQjZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Sep 2019 12:39:25 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45885 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbfIXQjZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Sep 2019 12:39:25 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so5986475iot.12
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2019 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQXjcttbLiJ66376wUArCGw4+fMYjer27LHa16Xc6r0=;
        b=U7w52Z0Fp8BOUxTOn/qWC98gNV4cup4wa+YgUKx5VVMQVMnJj8wSE6W0dbRjCKKm2H
         pviOHtF2QyPwud9ic8nsDjDwD7azHH5eETtdUlmx56xv/AbX4fpGaO9UyjWZdYBui+yg
         uJO8cqDV6t+pjPvBHAnKgUEV8VxziirI1kPVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQXjcttbLiJ66376wUArCGw4+fMYjer27LHa16Xc6r0=;
        b=ho9YLShvRseoK5hkrLT1jbdljdWZPSGKXGNx6+mTSWN7N9mCsV32GMA/ekJrERdeE7
         p+gSiJLIQuX7sciqXYXhaaCvKYxikqKa3cKEkvOSvbaH9CYkPbhhte55KM9q3ds+QX2k
         Kzk2SANkjx40d0YmxALg2D3JhLs4ee0eMuLnnetBXrqA8oAl73tNIn5LqxEKfD/Yc2Ze
         8DuqjIOvNqfbF8BrWZW/1ztT6/wCtb9tTtWsqnbWxh8TRjAp+uGME00jrahWJIgFfDL/
         OSVYL49i8a94dAHaASUAgRjDwaEQLcNSJxLnWh+gwXr+luQIXmD/tdtI46KzipWwjGgr
         lvxQ==
X-Gm-Message-State: APjAAAVjLfqdZoksQddO29V+bi2yQoSnrRLkrdF/eV0M1zYxeBSvNFmt
        +y6O2jjYlByIsQTVk0wk01Ihng==
X-Google-Smtp-Source: APXvYqzBLrOYjDVzR8fRyI2p2F4LP7qEI6zo8Yubh6Ub7ZXmgn7T702iWitKfSKlU8c7GRrUZGZWYw==
X-Received: by 2002:a6b:c895:: with SMTP id y143mr4301975iof.271.1569343164692;
        Tue, 24 Sep 2019 09:39:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id m5sm1755446ioh.69.2019.09.24.09.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 09:39:23 -0700 (PDT)
Subject: Re: Linux 5.4 - bpf test build fails
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <742ecabe-45ce-cf6e-2540-25d6dc23c45f@linuxfoundation.org>
 <1d1bbc01-5cf4-72e6-76b3-754d23366c8f@arm.com>
 <34a9bd63-a251-0b4f-73b6-06b9bbf9d3fa@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <a603ee8e-b0af-6506-0667-77269b0951b2@linuxfoundation.org>
Date:   Tue, 24 Sep 2019 10:39:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <34a9bd63-a251-0b4f-73b6-06b9bbf9d3fa@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/24/19 10:03 AM, Shuah Khan wrote:
> On 9/24/19 9:52 AM, Cristian Marussi wrote:
>> Hi Shuah
>>
>> On 24/09/2019 16:26, Shuah Khan wrote:
>>> Hi Alexei and Daniel,
>>>
>>> bpf test doesn't build on Linux 5.4 mainline. Do you know what's
>>> happening here.
>>>
>>>
>>> make -C tools/testing/selftests/bpf/
>>
>> side question, since I'm writing arm64/ tests.
>>
>> my "build-testcases" following the KSFT docs are:
>>
>> make kselftest
>> make TARGETS=arm64 kselftest
>> make -C tools/testing/selftests/
>> make -C tools/testing/selftests/ INSTALL_PATH=<install-path> install
>> make TARGETS=arm64 -C tools/testing/selftests/
>> make TARGETS=arm64 -C tools/testing/selftests/ 
>> INSTALL_PATH=<install-path> install
>> ./kselftest_install.sh <install-path>

Cristian,

That being said, I definitely want to see this list limited to
a few options.

One problem is that if somebody wants to do just a build, there
is no option from the main makefile. I have sent support for that
a few months ago and the patch didn't got lost it appears. I am
working on resending those patches. The same is true for install.
I sent in a patch for that a while back and I am going to resend.
These will make it easier for users.

I would really want to get to supporting only these options:

These are supported now:

make kselftest
make TARGETS=arm64 kselftest (one or more targets)

Replace the following:

make -C tools/testing/selftests/ with

make kselftes_build option from main makefile

Replace this:
make -C tools/testing/selftests/ INSTALL_PATH=<install-path> install

with
make kselftest_install

That way we can support all the use-cases from the main Makefile

thanks,
-- Shuah


