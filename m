Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFEB774A27
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 22:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjHHUU7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 16:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjHHUUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 16:20:50 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDA6AB0;
        Tue,  8 Aug 2023 12:26:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 752E76016E;
        Tue,  8 Aug 2023 21:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691522799; bh=42Ov8jrdWSouqXJnDzfdWxBesTTZMngT6wAy2edAW/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E9hNIjarZwig6adv0rcta4RJ24zoCbOYC/g7Gf4o1c4zg2Kr4JpxkCEPhBkbit9UE
         ZkJnHdyKGMqapeAqMoaZrlncClCAAG+h4Ime3ZfV9VTZrmvmxICm8uKKHTHAG8I4Cf
         OksjKB/F/ZFoAJOH2XQNujeIDSLjjDNm2qcSCQlotRRqr4dHnugtFmSxgSfr7m/Kq0
         rQdiE+Kbz/QQWnPTOiSdrnfBXUjU6praYDZphGoZ4optoejIZwIli70nnPaYMttbCD
         NcGeU+Qq+qkCKEfg2/LBp+ZY73kFjI6/zmH79DI1O/04zPu2qUpERhhT+w1/hCAaRQ
         TsovLiRX9dtug==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e3CtfOAwfMdD; Tue,  8 Aug 2023 21:26:36 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 6CAD46015F;
        Tue,  8 Aug 2023 21:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691522796; bh=42Ov8jrdWSouqXJnDzfdWxBesTTZMngT6wAy2edAW/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pGaNmvMEH4k+VJqZzWBluvDX2OkmL7ZytZAuuKwGVMDdOlnGV7PZA29V0IAVsA6xr
         /JlrKKECBLrY7m3fiY4lWYeU+Ucpr7uK2q/aa2tj8zB0fIX+IpdHGzjcXsfMaDTQoC
         8rPGqsoldTV3dRsDY//Oi5+QH0iKWOX4yQhIZDXLhhZlwi4KC5plobP+CE9TMBLHR8
         AphrCDIWKrI5ZQdOU6cK3YBRbhMRXqixizNXvNCYQo1Q+JXebzHsSFPrrrlOFNeTFa
         XrgKPguPHnDd7f/A/y7YTWnshbB4TJnYLvkAUYk/v9NFdOb+ZytpkU1PhSN7lTP4sN
         wd6jl2PAPokcw==
Message-ID: <dc641c92-38c2-4aa6-71d7-b30064c38d55@alu.unizg.hr>
Date:   Tue, 8 Aug 2023 21:26:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4.14 1/1] test_firmware: fix the memory leaks with the
 reqs buffer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
References: <20230804170017.92671-1-mirsad.todorovac@alu.unizg.hr>
 <2023080705-poet-nickname-5e08@gregkh>
 <a9e443c7-c7b5-63ce-08d9-5604ac545bf6@alu.unizg.hr>
 <2023080802-moonrise-cascade-a4c0@gregkh>
 <1269af66-bd86-0fab-e4ec-968f14371279@alu.unizg.hr>
 <2023080817-why-shawl-8ac1@gregkh>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023080817-why-shawl-8ac1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/8/23 09:35, Greg Kroah-Hartman wrote:
> On Tue, Aug 08, 2023 at 08:24:43AM +0200, Mirsad Todorovac wrote:
>> On 8/8/23 06:28, Greg Kroah-Hartman wrote:
>>> On Mon, Aug 07, 2023 at 08:28:04PM +0200, Mirsad Todorovac wrote:
>>>> On 8/7/23 11:15, Greg Kroah-Hartman wrote:
>>>>> On Fri, Aug 04, 2023 at 07:00:18PM +0200, Mirsad Todorovac wrote:
>>>>>> [ commit be37bed754ed90b2655382f93f9724b3c1aae847 upstream ]
>>>>>>
>>>>>> Dan Carpenter spotted that test_fw_config->reqs will be leaked if
>>>>>> trigger_batched_requests_store() is called two or more times.
>>>>>> The same appears with trigger_batched_requests_async_store().
>>>>>>
>>>>>> This bug wasn't triggered by the tests, but observed by Dan's visual
>>>>>> inspection of the code.
>>>>>>
>>>>>> The recommended workaround was to return -EBUSY if test_fw_config->reqs
>>>>>> is already allocated.
>>>>>>
>>>>>> Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
>>>>>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>> Cc: Russ Weight <russell.h.weight@intel.com>
>>>>>> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>> Cc: Colin Ian King <colin.i.king@gmail.com>
>>>>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>>>>> Cc: linux-kselftest@vger.kernel.org
>>>>>> Cc: stable@vger.kernel.org # v4.14
>>>>>> Suggested-by: Dan Carpenter <error27@gmail.com>
>>>>>> Suggested-by: Takashi Iwai <tiwai@suse.de>
>>>>>> Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
>>>>>> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>>>>
>>>>>> [ This fix is applied against the 4.14 stable branch. There are no changes to the ]
>>>>>> [ fix in code when compared to the upstread, only the reformatting for backport.  ]
>>>>>
>>>>> Thanks for all of these, now queued up.
>>>>
>>>> No problem, I should have done it right the first time to reduce your load.
>>>>
>>>> I really believe that backporting bug fix patches is important because many systems
>>>> cannot upgrade because of the legacy apps and hardware, to state the obvious.
>>>
>>> What "legacy apps" rely on a specific kernel version?
>>
>> Hi, Mr. Greg,
>>
>> Actually, in our particular case, it was the Eprints that required old mysql on Debian stretch
>> rather than MariaDB that came with Buster. So, the release required particular kernel version (4.9).
> 
> So what happens when this kernel becomes end-of-life?

I guess by now I could maintain the 4.19 line, with the bug fixes and the security fixes,
but it would impose significant overhead to already overwhelmed IT department.

I could use the same config and produce the same kernel, but w/o the testing as it would
happen w the distro kernels.

>> Of course, we can upgrade to any mainline kernel, but that is no longer a tested distro kernel,
>> and faults would be blamed on me entirely. Plus the overhead of regular patching ...
> 
> You should be doing regular patching for any LTS kernel as well, right?
> Same for testing, there should not be any difference in testing any
> kernel update be it on a LTS branch, or between major versions.

Sure, but apt-get dist-upgrade is easier than rebuilding the kernel. I say, we'd have to
get the necessary "blessings" to make this routine or procedure. Now we have the machines
that could build a recent kernel in less than an hour, but it wasn't always so :-)

We still do not have a twin test server for each single one of our production releases.

> anyway, good luck!

Thanks, I think we'll need it.

Kind regards,
Mirsad Todorovac
