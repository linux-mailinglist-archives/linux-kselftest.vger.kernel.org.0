Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32676B018
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjHAJ7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 05:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjHAJ6A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 05:58:00 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C47E7C;
        Tue,  1 Aug 2023 02:57:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 49B1B6015F;
        Tue,  1 Aug 2023 11:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690883846; bh=HvFuOQ+AD9vAeGv0bVGl9kIg9XMWNofn3eX/sGBr77Y=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=IKPUJQJYCCJAkPzbTaVmpITL7DojUgTrFvVl1qtS9um44B4zklEEaqyKKBWSqfmk4
         yfoeFHALqkEVpaWY+2V6ZO42W9uCHD7goKeX5m3pB/0lQf8fdTZL/FZbUeZ26pH9Jq
         LrKCozI9LaY7+otVV2Dy7vLyqOZiFmBiBLMaGpBPRFyrobrFOM0uZzyMWCuF1drL9K
         vQMWjEjcAsQNYRM0igKjI+4/xAjga9EzGq58GP3K3PrWST1vRSugtZZiGqQ97bJOJy
         tuSWlmcVV13Y766sHbT9BeDsham5GvI2298OdkrtgvOrlYGSeYrXPLuHAem6WCQnQT
         K1z5ywMP5wsVQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5I306fRjD5hA; Tue,  1 Aug 2023 11:57:23 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id BF3EF6017C;
        Tue,  1 Aug 2023 11:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690883843; bh=HvFuOQ+AD9vAeGv0bVGl9kIg9XMWNofn3eX/sGBr77Y=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=G0gmK1J1sicJCKLGWrDPHzkP00i6il/3BeFgrnArBclfkcN5ltJjqCO31TYzXIbaS
         dXY5qEfdnWSV7vRhQB8cQ9SXqG2Z1fkRyhBMt6C5Y+JSHxODo4vtPBe922PRJul6Fh
         QR0+ucG2hmo/4wFPTjy+Gu4z+2FapEBoLbwM/XHvL510WRHnnSYMGGeG7zY28r0vP4
         i36yy/6UpGLaJm9TSzRf5xJPTIQmVkQYLMdU4E5BFpYINgnB3E/HRaFyuCqkV4Wiht
         2qlxa7SfjwCGsC9rROKIe+fzERAPd2EOrrjG5e1yuFXPnVfsi/GsJtl8aVQ4zY4UkK
         pb40ysdJQMOXA==
Message-ID: <24d27380-544e-66d1-1cb2-14eb87ce89ac@alu.unizg.hr>
Date:   Tue, 1 Aug 2023 11:57:19 +0200
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
Content-Language: en-US, hr
In-Reply-To: <0e3a740f-60dd-e657-8a5c-79b155fa62b3@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/1/23 10:24, Mirsad Todorovac wrote:
> On 7/31/23 19:27, Luis Chamberlain wrote:
>> On Mon, Jul 31, 2023 at 06:50:19PM +0200, Mirsad Todorovac wrote:
>>> NOTE: This patch is tested against 5.4 stable
>>>
>>> NOTE: This is a patch for the 5.4 stable branch, not for the torvalds tree.
>>>
>>>        The torvalds tree, and stable tree 5.10, 5.15, 6.1 and 6.4 branches
>>>        were fixed in the separate
>>>        commit ID 4acfe3dfde68 ("test_firmware: prevent race conditions by a correct implementation of locking")
>>>        which was incompatible with 5.4
>>>
>>
>> The above part is not part of the original commit, you also forgot to
>> mention the upstream commit:
>>
>> [ Upstream commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 ]
> 
> Will fix. Actually, I wasn't sure if it was required, because this backported patch
> isn't verbatim equal to commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 .
> 
> Though they are cousins, addressing the same issue.
> 
> There is a race to be fixed, despite not all racy functions present in the original commit c92316bf8e948.
> 
>>> Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
>>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Russ Weight <russell.h.weight@intel.com>
>>> Cc: Takashi Iwai <tiwai@suse.de>
>>> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
>>> Cc: Shuah Khan <shuah@kernel.org>
>>> Cc: Colin Ian King <colin.i.king@gmail.com>
>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: linux-kselftest@vger.kernel.org
>>> Cc: stable@vger.kernel.org # v5.4
>>> Suggested-by: Dan Carpenter <error27@gmail.com>
>>
>> Here you can add the above note in brackets:
>>
>> [ explain your changes here from the original commit ]
>>
>> Then, I see two commits upstream on Linus tree which are also fixes
>> but not merged on v5.4, did you want those applied too?
> 
> These seem merged in the stable 5.4?
> 
> commit 75d9e00f65cd2e0f2ce9ceeb395f821976773489 test_firmware: fix a memory leak with reqs buffer
> commit 94f3bc7e84af2f17dbfbc7afe93991c2a6f2f25e test_firmware: fix the memory leak of the allocated firmware buffer
> 
> Maybe this commit should be backported instead:
> 
> test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation
> [ Upstream commit 7dae593cd226a0bca61201cf85ceb9335cf63682 ]
> 
> It was also merged into 6.4, 6.1, 5.15 and 5.10 stable, but not on 5.4
> 
> I might also check whether the 4.19 and 4.14 are vulnerable to these memory leaks and this race
> (Yes, they are, so it might be prudent that we backport this fix.)

FYI, just checked, the patch applied w/o modifications to 4.19 and 4.14 LTS stable branches.

Mirsad

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
