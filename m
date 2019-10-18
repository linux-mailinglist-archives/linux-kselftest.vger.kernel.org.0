Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2BEDC7FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 17:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634269AbfJRPCB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 11:02:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40875 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392463AbfJRPCB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 11:02:01 -0400
Received: by mail-io1-f66.google.com with SMTP id h144so7803232iof.7
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rf1k4aH6pGXHyw4Vf7G+DEOsQsspC5wAfrN8l4/WXa8=;
        b=QsE45iLwbEbjm9alKUoHQ5KiBWFNeKHvGC7MZoo5QK6TF5RZrm7qDugjwK+QBXEP9f
         SYPTiOkbl2geZsidXbZ+EBLPBxevhnIO5BYDJ5mTmgRTMze5xlTrJZuh68wk5zjQv7Qj
         feeLhcjEvxhNe/SyZT0iDD5fZck38SR6YvxnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rf1k4aH6pGXHyw4Vf7G+DEOsQsspC5wAfrN8l4/WXa8=;
        b=f1CEEIw62ux8WT/riNheIyEojeUAZsTrelFIneJwAfR8Q9vwe8KH1uE3d+90TZbBBS
         UQbt5y1XqiJ9maOwa6APQ24Mazkwj+y6hLvztBt7zQd8ZmLSoDMGkzmBXku0yLJcEl/Z
         zWO2f8C8ThJMKHp2vpaPlHcvOjQkSgNvoKGJnuPI436vinMRtBH/2UM00eXHMPEDgcXa
         3odDNQX0AENa23k+4z41IWpu3e3KrW6nZB4BCDW/0VHqXkJXXBXcEI8K9bSU80xFN3ly
         yCdQZ9+y7wf438hSRV8wO8CKN3YBTPd5B2irduFNd6MtjG6bHfIfeZyg3gw8I1Wz6ZLr
         E27w==
X-Gm-Message-State: APjAAAWL8Aqae0xqbQHCVsZRuWM3LBd3jiHxHfwejKAr6MhsiIncgDuf
        hJ2EOMFAIy0A2FKbRhYiUAKmpg==
X-Google-Smtp-Source: APXvYqyVggSKLFN0a9z2oDMfhpqptfLGN/5xX+9itsUizTIAYkCHFppAOyZ+3kDUaSs1/6sfbdH70Q==
X-Received: by 2002:a5d:8d8f:: with SMTP id b15mr6827219ioj.296.1571410919279;
        Fri, 18 Oct 2019 08:01:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a26sm1857968iot.46.2019.10.18.08.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 08:01:58 -0700 (PDT)
Subject: Re: [Bug report] "make run_tests -C bpf" hanging forever
To:     Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, Philip Li <philip.li@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <d08b43ee-6a21-c9aa-ea7b-9465ecbad772@cn.fujitsu.com>
 <05dbae1d-05de-8360-5f3c-a698d4dc3226@cn.fujitsu.com>
 <CAJ2QiJKvUXjC+Ejad3eGiaY8F-UVSnWUPyvbZ46LkE7k0kaZZQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5a1ffb6f-7c1e-42d9-5927-f46f9b41bc4f@linuxfoundation.org>
Date:   Fri, 18 Oct 2019 09:01:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJ2QiJKvUXjC+Ejad3eGiaY8F-UVSnWUPyvbZ46LkE7k0kaZZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/18/19 12:56 AM, Prabhakar Kushwaha wrote:
> On Fri, Oct 18, 2019 at 12:12 PM Liu Yiding <liuyd.fnst@cn.fujitsu.com> wrote:
>>
>> CC LKP mainter
>>
>>
>> On 10/18/19 2:32 PM, Liu Yiding wrote:
>>> Hi All.
>>>
>>> The patch 5c069b6dedef "selftests: Move test output to diagnostic
>>> lines" from Apr 24, 2019,
>>>
>>> leads to `make run_tests -C bpf` hanging forever.
>>>
>>>
>>> Bpf includes many subtest, when cmd `make run_tests -C bpf` runs to
>>> test_lwt_seg6local.sh, task will hang and runner.sh never run next
>>> task. I checked ps aux, prefix.pl will never exit.
>>>
>>> ```
>>>
>>> 91058 [  811.451584] # [25] VAR __license type_id=24 linkage=1
>>> 91059 [  811.451586]-
>>> 91060 [  811.455365] # [26] DATASEC license size=0 vlen=1 size == 0
>>> 91061 [  811.455367]-
>>> 91062 [  811.457424] #-
>>> 91063 [  811.457425]-
>>> 91064 [  811.460912] # selftests: test_lwt_seg6local [PASS]
>>> 91065 [  811.460914]-
>>> 91066 [ 3620.461986] Thu Oct 17 14:54:05 CST 2019 detected soft_timeout
>>>
>>> ```
>>>
>>> Ignore test_lwt_seg6local and run `make run_tests -C bpf` again, task
>>> will hang on test_tc_tunnel.sh.
>>>
>>>
>>> Kushwaha also meet this issue, `make run_tests -C bpf` hang on
>>> test_lwt_ip_encap.sh (This test failed on my localhost).
>>>
> 
> Yes, i also faced this issue on Linux-5.3. if i kill prefix.pl or add
> timeout in prefix.pl, test move ahead.
> 
> somehow this issue is not present on Linux 5.4-rc3+. It could be by
> chance and may show on any other version.
> 

Kees added timeout in this commit and this went into 5.4-rc3, if recall
correctly.

commit 852c8cbf34d3b3130a05c38064dd98614f97d3a8
Author: Kees Cook <keescook@chromium.org>

     selftests/kselftest/runner.sh: Add 45 second timeout per test

Do you see a timed out message from this test though. The test needs
to fixed probably, but this timeout helps bail out.

thanks,
-- Shuah
