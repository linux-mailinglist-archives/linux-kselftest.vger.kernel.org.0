Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F14C76FA54
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 08:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjHDGpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjHDGpS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 02:45:18 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8614BE53;
        Thu,  3 Aug 2023 23:45:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id CF4E66015F;
        Fri,  4 Aug 2023 08:45:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691131513; bh=pg8OxTOJmcrRiDterXwr1dvrgpNBoZlh/o4umNGkx4g=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=rK2gL0J17UZlFRl6BOG2mVK68B1JJ1edrOe8fBT+ihHHm588SOlZBfzUnq/We6jQm
         kvbbCVaOe1hbm9UB02L0sNqxecTNlrudRqGb5lAWJUZpBVT4pSOZtYZ1qpxSZipeMj
         1bBIOXMxx9kYJMqeMqNGSRpXloZT0Te/kmMtdSIciz7FOTKk5x3hYCJ+CJlkSosm7I
         vKvrl4sG6EBZOx4vHUEawM+bN3tOASb607sRJQryJVv5aotFssRnvifBMkLGPP9anG
         FrmtVNqQ1oVpkv1GaThgqKCM7ozJs4knU8L/j5sg0yOH7eo1ndarJ8mJrnrIi9+v+O
         odbzX2FKnJ3xQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T_GVxCmGnqIc; Fri,  4 Aug 2023 08:45:11 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 8B7676015E;
        Fri,  4 Aug 2023 08:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691131511; bh=pg8OxTOJmcrRiDterXwr1dvrgpNBoZlh/o4umNGkx4g=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=WHuvQMUrjNO/aZOGdKwxOHbJSRJrG+ZClRAIJaZAJOfRo9n2F5yugbIMt7f2mZyro
         cJo8iTcj+PC5+Y8SV/xhNBV32KDrmHnPeHhR8p/hvKeil8SPGIS6/Sry/W7Cg9uC/V
         OZbwjqhnuM4zDth3NMM+ev6ArIa7QUUqym8uCKQTHdjS0vrpOF6y0VWb9QdJsnYEsy
         kNP0Y2bj2uLUJoX4hkHZ9pbOgVLq6zbnEYllIHIkumitJn2npNblRajy3MI78tDTky
         uDsMWw2AFMVI4FPFWjg4Dgx5LPtzFL6oPzFNBwa+h1MXmW3w0Id911fVUTvO1btzFk
         t5zEF9DglZyQw==
Message-ID: <6b2740b7-8337-88dc-b709-8ebc660b9e7c@alu.unizg.hr>
Date:   Fri, 4 Aug 2023 08:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] test_firmware: prevent race conditions by a
 correct implementation of locking
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
References: <20230731165018.8233-1-mirsad.todorovac@alu.unizg.hr>
 <ZMfvAhOfSP5UXN6l@bombadil.infradead.org>
 <0e3a740f-60dd-e657-8a5c-79b155fa62b3@alu.unizg.hr>
 <24d27380-544e-66d1-1cb2-14eb87ce89ac@alu.unizg.hr>
Content-Language: en-US, hr
In-Reply-To: <24d27380-544e-66d1-1cb2-14eb87ce89ac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 01. 08. 2023. 11:57, Mirsad Todorovac wrote:
> On 8/1/23 10:24, Mirsad Todorovac wrote:
>> On 7/31/23 19:27, Luis Chamberlain wrote:
>>> On Mon, Jul 31, 2023 at 06:50:19PM +0200, Mirsad Todorovac wrote:
>>>> NOTE: This patch is tested against 5.4 stable
>>>>
>>>> NOTE: This is a patch for the 5.4 stable branch, not for the torvalds tree.
>>>>
>>>>        The torvalds tree, and stable tree 5.10, 5.15, 6.1 and 6.4 branches
>>>>        were fixed in the separate
>>>>        commit ID 4acfe3dfde68 ("test_firmware: prevent race conditions by a correct implementation of locking")
>>>>        which was incompatible with 5.4
>>>>
>>>
>>> The above part is not part of the original commit, you also forgot to
>>> mention the upstream commit:
>>>
>>> [ Upstream commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 ]
>>
>> Will fix. Actually, I wasn't sure if it was required, because this backported patch
>> isn't verbatim equal to commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 .
>>
>> Though they are cousins, addressing the same issue.
>>
>> There is a race to be fixed, despite not all racy functions present in the original commit c92316bf8e948.
>>
>>>> Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
>>>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Russ Weight <russell.h.weight@intel.com>
>>>> Cc: Takashi Iwai <tiwai@suse.de>
>>>> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>> Cc: Colin Ian King <colin.i.king@gmail.com>
>>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Cc: stable@vger.kernel.org # v5.4
>>>> Suggested-by: Dan Carpenter <error27@gmail.com>
>>>
>>> Here you can add the above note in brackets:
>>>
>>> [ explain your changes here from the original commit ]
>>>
>>> Then, I see two commits upstream on Linus tree which are also fixes
>>> but not merged on v5.4, did you want those applied too?
>>
>> These seem merged in the stable 5.4?
>>
>> commit 75d9e00f65cd2e0f2ce9ceeb395f821976773489 test_firmware: fix a memory leak with reqs buffer
>> commit 94f3bc7e84af2f17dbfbc7afe93991c2a6f2f25e test_firmware: fix the memory leak of the allocated firmware buffer
>>
>> Maybe this commit should be backported instead:
>>
>> test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation
>> [ Upstream commit 7dae593cd226a0bca61201cf85ceb9335cf63682 ]
>>
>> It was also merged into 6.4, 6.1, 5.15 and 5.10 stable, but not on 5.4
>>
>> I might also check whether the 4.19 and 4.14 are vulnerable to these memory leaks and this race
>> (Yes, they are, so it might be prudent that we backport this fix.)
> 
> FYI, just checked, the patch applied w/o modifications to 4.19 and 4.14 LTS stable branches.

Hi, Mr. Luis,

I tried to guess the best way how to backport these four patches:

48e156023059 test_firmware: fix the memory leak of the allocated firmware buffer
	5.4		[ALREADY IN THE TREE]
	4.1[49]		N/A
be37bed754ed test_firmware: fix a memory leak with reqs buffer
	5.4		[ALREADY IN THE TREE]
	4.19		https://lore.kernel.org/lkml/20230801170746.191505-1-mirsad.todorovac@alu.unizg.hr/
	4.14		https://lore.kernel.org/lkml/20230802053253.667634-1-mirsad.todorovac@alu.unizg.hr/
4acfe3dfde68 test_firmware: prevent race conditions by a correct implementation of locking
	5.4,4.19,4.14	https://lore.kernel.org/lkml/20230803165304.9200-1-mirsad.todorovac@alu.unizg.hr/
7dae593cd226 test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation
	5.4		https://lore.kernel.org/lkml/20230803165304.9200-2-mirsad.todorovac@alu.unizg.hr/
	4.1[49]		https://lore.kernel.org/lkml/20230801185324.197544-1-mirsad.todorovac@alu.unizg.hr/

I have tested the 5.4 and 4.19 builds, but 4.14 still won't boot at my hw (black screen,
no msgs at all to diagnose).

I hope you will manage between the patches that have the same name and version, but
address the backport to a different stable LTS branch. They differ by the patch proper,
naturally, to state the obvious, or the upstream would apply of course.

I don't know the exact formatting procedure for the backports, so I improvised, but I feel that backporting
bug fixes is very important, even if they are not security fixes.

I found no new weaknesses in the firmware driver after reviewing the code again. The buffer for name can be
released twice, though, but kfree(NULL) is permissible:

        kfree_const(test_fw_config->name);
        test_fw_config->name = NULL;

This about ends this chapter, and I am waiting for a review and an ACK.

Kind regards,
Mirsad Todorovac

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

