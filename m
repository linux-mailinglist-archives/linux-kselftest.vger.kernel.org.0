Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52720BCBCB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390547AbfIXPsh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Sep 2019 11:48:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44798 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389839AbfIXPsh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Sep 2019 11:48:37 -0400
Received: by mail-io1-f65.google.com with SMTP id j4so5574037iog.11
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2019 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sDYzvV0W071U3u50oUnN1wJFiJYibfk2VvG8KWdulNo=;
        b=AzBNMPLi3pY0pVkOyFZu0GXJfXGkKHyxAmlRG3KC0H567lWYQMTWgROJks9hyQgBS8
         mUR+1pEcE5LmsWNrPxYYEbmFWrimyDWAP40CxNFFT8SuPz8BNUAWRbqU+POjyzLHHL10
         WiftNWnECVQtVNbQi8RzvkpkjhMdFtYJqws20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDYzvV0W071U3u50oUnN1wJFiJYibfk2VvG8KWdulNo=;
        b=BfZ0je1sE1phE1g0bF5mMlprgu7cxciXXepJQwmA3LOfOPmSc1nfmCGdu14PDcx6w7
         9a+ZJoE+yjhxqzKt4slPJTWbFg/30n5HVebwyROlVQC4mC8ak+RAybH/umnZfktum54K
         Tq2nlBCKi80ZwED6BkJ9S7WU8KCRorf0I1pFnPRG2TG/bOHrBVGTcVH56oI2XLYNhYFe
         xe1zkqT6rft4R0sUKfxh7vPDLAT5lNK/L037CPACtDIqZry9VHNObygftCV4qrLsT0If
         bg2Iidb3BU1g7JekuKvM6DSbSdJEvzXCehAkGWXDrE9PN+/NP7/dfKhg6edKAln2Boj5
         1I5Q==
X-Gm-Message-State: APjAAAWP8mu7eM3aLUNvG6VFRq86nO1Ql8kxJHmbs0RUsVRqEGs/6ozE
        UeTrLClmHWgaxCBgP4PuxT6S7w==
X-Google-Smtp-Source: APXvYqw17sJ9rR3xgZewWkEtBIUvt5oZy4433d8pg9IcSwvHVncow1VyHGQd5+pwEWsNdoFa0gLFGQ==
X-Received: by 2002:a6b:6514:: with SMTP id z20mr2573139iob.50.1569340116858;
        Tue, 24 Sep 2019 08:48:36 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r138sm2375156iod.59.2019.09.24.08.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:48:36 -0700 (PDT)
Subject: Re: Linux 5.4 - bpf test build fails
To:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <742ecabe-45ce-cf6e-2540-25d6dc23c45f@linuxfoundation.org>
 <0a5bf608-bb15-c116-8e58-7224b6c3b62f@fb.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <05b7830c-1fa8-b613-0535-1f5f5a40a25a@linuxfoundation.org>
Date:   Tue, 24 Sep 2019 09:48:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0a5bf608-bb15-c116-8e58-7224b6c3b62f@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/24/19 9:43 AM, Yonghong Song wrote:
> 
> 
> On 9/24/19 8:26 AM, Shuah Khan wrote:
>> Hi Alexei and Daniel,
>>
>> bpf test doesn't build on Linux 5.4 mainline. Do you know what's
>> happening here.
>>
>>
>> make -C tools/testing/selftests/bpf/
>>
>> -c progs/test_core_reloc_ptr_as_arr.c -o - || echo "clang failed") | \
>> llc -march=bpf -mcpu=generic  -filetype=obj -o
>> /mnt/data/lkml/linux_5.4/tools/testing/selftests/bpf/test_core_reloc_ptr_as_arr.o
>>
>> progs/test_core_reloc_ptr_as_arr.c:25:6: error: use of unknown builtin
>>         '__builtin_preserve_access_index' [-Wimplicit-function-declaration]
>>           if (BPF_CORE_READ(&out->a, &in[2].a))
>>               ^
>> ./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
>>                          __builtin_preserve_access_index(src))
>>                          ^
>> progs/test_core_reloc_ptr_as_arr.c:25:6: warning: incompatible integer to
>>         pointer conversion passing 'int' to parameter of type 'const void *'
>>         [-Wint-conversion]
>>           if (BPF_CORE_READ(&out->a, &in[2].a))
>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
>>                          __builtin_preserve_access_index(src))
>>                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 1 warning and 1 error generated.
>> llc: error: llc: <stdin>:1:1: error: expected top-level entity
>> clang failed
>>
>> Also
>>
>> make TARGETS=bpf kselftest fails as well. Dependency between
>> tools/lib/bpf and the test. How can we avoid this type of
>> dependency or resolve it in a way it doesn't result in build
>> failures?
> 
> Thanks, Shuah.
> 
> The clang __builtin_preserve_access_index() intrinsic is
> introduced in LLVM9 (which just released last week) and
> the builtin and other CO-RE features are only supported
> in LLVM10 (current development branch) with more bug fixes
> and added features.
> 
> I think we should do a feature test for llvm version and only
> enable these tests when llvm version >= 10.

Yes. If new tests depend on a particular llvm revision, the failing
the build is a regression. I would like to see older tests that don't
have dependency build and run.

thanks,
-- Shuah
