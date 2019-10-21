Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED7DE1CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 03:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfJUBms (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Oct 2019 21:42:48 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51466 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726696AbfJUBms (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Oct 2019 21:42:48 -0400
X-IronPort-AV: E=Sophos;i="5.67,321,1566835200"; 
   d="scan'208";a="77247406"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Oct 2019 09:42:41 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 0203C4CE03C1;
        Mon, 21 Oct 2019 09:42:12 +0800 (CST)
Received: from localhost.localdomain (10.167.226.81) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 21 Oct 2019 09:42:43 +0800
Subject: Re: [Bug report] "make run_tests -C bpf" hanging forever
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Kees Cook <keescook@chromium.org>
CC:     <linux-kselftest@vger.kernel.org>, Philip Li <philip.li@intel.com>
References: <d08b43ee-6a21-c9aa-ea7b-9465ecbad772@cn.fujitsu.com>
 <05dbae1d-05de-8360-5f3c-a698d4dc3226@cn.fujitsu.com>
 <CAJ2QiJKvUXjC+Ejad3eGiaY8F-UVSnWUPyvbZ46LkE7k0kaZZQ@mail.gmail.com>
 <5a1ffb6f-7c1e-42d9-5927-f46f9b41bc4f@linuxfoundation.org>
From:   Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Message-ID: <2727059f-32b7-7e7a-4d6d-6a017c6b699f@cn.fujitsu.com>
Date:   Mon, 21 Oct 2019 09:42:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5a1ffb6f-7c1e-42d9-5927-f46f9b41bc4f@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-yoursite-MailScanner-ID: 0203C4CE03C1.AFB9A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: liuyd.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, i test it on v5.3-rc4, also meet this issue.


On 10/18/19 11:01 PM, Shuah Khan wrote:
> On 10/18/19 12:56 AM, Prabhakar Kushwaha wrote:
>> On Fri, Oct 18, 2019 at 12:12 PM Liu Yiding 
>> <liuyd.fnst@cn.fujitsu.com> wrote:
>>>
>>> CC LKP mainter
>>>
>>>
>>> On 10/18/19 2:32 PM, Liu Yiding wrote:
>>>> Hi All.
>>>>
>>>> The patch 5c069b6dedef "selftests: Move test output to diagnostic
>>>> lines" from Apr 24, 2019,
>>>>
>>>> leads to `make run_tests -C bpf` hanging forever.
>>>>
>>>>
>>>> Bpf includes many subtest, when cmd `make run_tests -C bpf` runs to
>>>> test_lwt_seg6local.sh, task will hang and runner.sh never run next
>>>> task. I checked ps aux, prefix.pl will never exit.
>>>>
>>>> ```
>>>>
>>>> 91058 [  811.451584] # [25] VAR __license type_id=24 linkage=1
>>>> 91059 [  811.451586]-
>>>> 91060 [  811.455365] # [26] DATASEC license size=0 vlen=1 size == 0
>>>> 91061 [  811.455367]-
>>>> 91062 [  811.457424] #-
>>>> 91063 [  811.457425]-
>>>> 91064 [  811.460912] # selftests: test_lwt_seg6local [PASS]
>>>> 91065 [  811.460914]-
>>>> 91066 [ 3620.461986] Thu Oct 17 14:54:05 CST 2019 detected 
>>>> soft_timeout
>>>>
>>>> ```
>>>>
>>>> Ignore test_lwt_seg6local and run `make run_tests -C bpf` again, task
>>>> will hang on test_tc_tunnel.sh.
>>>>
>>>>
>>>> Kushwaha also meet this issue, `make run_tests -C bpf` hang on
>>>> test_lwt_ip_encap.sh (This test failed on my localhost).
>>>>
>>
>> Yes, i also faced this issue on Linux-5.3. if i kill prefix.pl or add
>> timeout in prefix.pl, test move ahead.
>>
>> somehow this issue is not present on Linux 5.4-rc3+. It could be by
>> chance and may show on any other version.
>>
>
> Kees added timeout in this commit and this went into 5.4-rc3, if recall
> correctly.
>
> commit 852c8cbf34d3b3130a05c38064dd98614f97d3a8
> Author: Kees Cook <keescook@chromium.org>
>
>     selftests/kselftest/runner.sh: Add 45 second timeout per test
>
> Do you see a timed out message from this test though. The test needs
> to fixed probably, but this timeout helps bail out.


I got TIMEOUT message for some tests, e.g. test_tunnel.sh, timeout works.

```

88418 user  :notice: [ 1258.787439] not ok 36 selftests: bpf: 
test_tunnel.sh # TIMEOUT

```


But test_lwt_seg6local still hang, it seems that this timeout is working 
for testscript and seg6local hang on tap_prefix (prefix.pl).

```

89008 user  :notice: [ 1259.886374] # [25] VAR __license type_id=24 
linkage=1
89009
89010 user  :notice: [ 1259.890166] # [26] DATASEC license size=0 vlen=1 
size == 0
89011
89012 user  :notice: [ 1259.893272] #-
89013
89014 user  :notice: [ 1259.897190] # selftests: test_lwt_seg6local [PASS]
89015
89016 user  :notice: [ 3623.763707] Fri Oct 18 16:12:56 CST 2019 
detected soft_timeout

```


>
>
> thanks,
> -- Shuah
>
>
-- 
Best regards.
Liu Yiding



