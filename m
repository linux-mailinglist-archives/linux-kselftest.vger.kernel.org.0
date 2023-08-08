Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E403773E56
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjHHQ3c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjHHQ2G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:28:06 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A222B11F44;
        Tue,  8 Aug 2023 08:50:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 154DC6016E;
        Tue,  8 Aug 2023 08:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691475900; bh=rdkWAy74MmPIPfmSWwye6pBDQ406/q2KSxXyYpG4R9Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pgNyyx5oLmIYMKJTAWksgcEEpnM827k30wzBo4uOeL3zl3yI27e/Xi5RX03G9jJV3
         5YdAv6TGDLl4yvcRFE8FAXhbQrZ8DFkTqcrfjUAOb1E7NErT9/nI20/MmsbxzE+DDu
         XevniqjE227/Q3YTIPt+yYIvFe/+/2n7w5ayNVWNAGl3bFgi8NSlmKlckWBEtxjy5V
         1iNYod3KFxZkvxVTsuz2hBlqKBj8juZXIcBXw5KDwOmT4ob2LTAwYf8Ni660qXABTI
         xuc+GDWvoM2d+RyQoQ4cEDoRt7QGJMU+PLIpYg+fJe6jIjR3MSesYoueUYEiDdqn8/
         IsKRZIdeQfZvg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oqWFrB4_ikyt; Tue,  8 Aug 2023 08:24:57 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id AA3076015F;
        Tue,  8 Aug 2023 08:24:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691475897; bh=rdkWAy74MmPIPfmSWwye6pBDQ406/q2KSxXyYpG4R9Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IT3+Zmmo6uKBwamBs+nX0kOHHPMMCfbKBxKPlGaFbUEsTEQ/vUuAngC5+J+F6xf+p
         kwGrFIPckiy/TwVGxSY3xmOgBqEkAkx7yLBJXlTO8fLrYPEB7iOb+4DPi1WUC/MpRt
         AxyyXK+dMdi4pGxPTUjr5CCQkKwfftzkCzoVQ22YKloOlqAMB2SebOwYeulyqBBnWy
         QmAadHUXgfcFXr8DRuZxU+tAZ8mmraH91EnwKfIg1F0VrTm1zMyfhFzs1AFDYoXDl/
         s1qJZftAemVhn7h5ptdANwu/LHSeG/dITbp8F+1qoigulv/WU66QBdfQlmw7t3voUl
         IiOevszC17NXg==
Message-ID: <1269af66-bd86-0fab-e4ec-968f14371279@alu.unizg.hr>
Date:   Tue, 8 Aug 2023 08:24:43 +0200
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
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023080802-moonrise-cascade-a4c0@gregkh>
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

On 8/8/23 06:28, Greg Kroah-Hartman wrote:
> On Mon, Aug 07, 2023 at 08:28:04PM +0200, Mirsad Todorovac wrote:
>> On 8/7/23 11:15, Greg Kroah-Hartman wrote:
>>> On Fri, Aug 04, 2023 at 07:00:18PM +0200, Mirsad Todorovac wrote:
>>>> [ commit be37bed754ed90b2655382f93f9724b3c1aae847 upstream ]
>>>>
>>>> Dan Carpenter spotted that test_fw_config->reqs will be leaked if
>>>> trigger_batched_requests_store() is called two or more times.
>>>> The same appears with trigger_batched_requests_async_store().
>>>>
>>>> This bug wasn't triggered by the tests, but observed by Dan's visual
>>>> inspection of the code.
>>>>
>>>> The recommended workaround was to return -EBUSY if test_fw_config->reqs
>>>> is already allocated.
>>>>
>>>> Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
>>>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Russ Weight <russell.h.weight@intel.com>
>>>> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>> Cc: Colin Ian King <colin.i.king@gmail.com>
>>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Cc: stable@vger.kernel.org # v4.14
>>>> Suggested-by: Dan Carpenter <error27@gmail.com>
>>>> Suggested-by: Takashi Iwai <tiwai@suse.de>
>>>> Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
>>>> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>>
>>>> [ This fix is applied against the 4.14 stable branch. There are no changes to the ]
>>>> [ fix in code when compared to the upstread, only the reformatting for backport.  ]
>>>
>>> Thanks for all of these, now queued up.
>>
>> No problem, I should have done it right the first time to reduce your load.
>>
>> I really believe that backporting bug fix patches is important because many systems
>> cannot upgrade because of the legacy apps and hardware, to state the obvious.
> 
> What "legacy apps" rely on a specific kernel version?

Hi, Mr. Greg,

Actually, in our particular case, it was the Eprints that required old mysql on Debian stretch
rather than MariaDB that came with Buster. So, the release required particular kernel version (4.9).

Of course, we can upgrade to any mainline kernel, but that is no longer a tested distro kernel,
and faults would be blamed on me entirely. Plus the overhead of regular patching ...

This is what I now do, but the old hardware at work still requires 60 minutes to build a decent
vanilla tree kernel ...

> As for hardware, just get the needed drivers merged into Linus's tree
> and then you can upgrade to newer kernels.  What is preventing that from
> happening?

As I said, the problem is with reliability and testing. We used to have only the production virtual
servers w/o the testing ones, so the environment would be difficult to reproduce w/o interrupting
the services we run because of.

The Croatian universities are traditionally scarce in equipment. :-(

Kind regards,
Mirsad

> thanks,
> 
> greg k-h
