Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B7C76AAD3
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjHAIYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 04:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHAIYP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 04:24:15 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14DE0;
        Tue,  1 Aug 2023 01:24:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 825E56017C;
        Tue,  1 Aug 2023 10:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690878251; bh=4TQh0BeNhMTySjhS+vXT+kiphvu7OUm8Va1VzI9Vi0c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Cxiha4L6MTPGyCWn9lgVLdGtEfGKKW/SJNeREhP3LvVyCXdh5M06DXg8wnNpXhyTX
         xGZqzDg70SHRtn7yuF7AbN9xmjhIC4QhbG+GrFngvHUjeulB3ZiGdApeuX7QfP5HBM
         LjsUKBZw05L2XUj++oK1l3U23s0y/1Y4ZkkBUu7Ty+yYKLZgmCeoO6316bAEraw5e4
         c8mNhZjUnQFoVkKidAXn86Wbpc/k26PwZycVtmzjoa+7L8TDyq/d252BMvRZhN4948
         um+BQTG7FIPNKHsxQC4L1V0Q36TWqyawKvXmbI8U8ClvOhb9uw+BOa+flyNGWVnBH/
         rmijcKlk9IEmQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DyhEUB5vQsbH; Tue,  1 Aug 2023 10:24:09 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id DD1996015F;
        Tue,  1 Aug 2023 10:24:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690878249; bh=4TQh0BeNhMTySjhS+vXT+kiphvu7OUm8Va1VzI9Vi0c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N9Ej0N1unLq6eAPqz2QO+pTANMbVaGVH9yQAl2MYlCBAiQPiVnmhofE57m0N2nCic
         zOs/y9MqWZ2weBUfe0OlZFQWL40+8eT1lsbFyVoSyjHqAByKOD6Gjpt1mq1nbuK/im
         WBlJIkaH0QHmMfUnT7DRTBfLD6MGu/11tDVt1/ECF2sn2Aj9ku66ycTDHaFhL/pNTF
         CmzW3hhS6EhxYOAXRYeQlNe2AkZJ4GSRbSLsGceVYC1CbYlpa4Wu/rx9uUTndmNzpl
         kR0uU/UIJR/MKqLl/KObMG4xqWxuuR7Ds9+xNVY8e4KwnmKT9t6da2MJ4ETofLuhVR
         MPQeHPSeRAjxQ==
Message-ID: <0e3a740f-60dd-e657-8a5c-79b155fa62b3@alu.unizg.hr>
Date:   Tue, 1 Aug 2023 10:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v1 1/1] test_firmware: prevent race conditions by a
 correct implementation of locking
Content-Language: en-US
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
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMfvAhOfSP5UXN6l@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/31/23 19:27, Luis Chamberlain wrote:
> On Mon, Jul 31, 2023 at 06:50:19PM +0200, Mirsad Todorovac wrote:
>> NOTE: This patch is tested against 5.4 stable
>>
>> NOTE: This is a patch for the 5.4 stable branch, not for the torvalds tree.
>>
>>        The torvalds tree, and stable tree 5.10, 5.15, 6.1 and 6.4 branches
>>        were fixed in the separate
>>        commit ID 4acfe3dfde68 ("test_firmware: prevent race conditions by a correct implementation of locking")
>>        which was incompatible with 5.4
>>
> 
> The above part is not part of the original commit, you also forgot to
> mention the upstream commit:
> 
> [ Upstream commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 ]

Will fix. Actually, I wasn't sure if it was required, because this backported patch
isn't verbatim equal to commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 .

Though they are cousins, addressing the same issue.

There is a race to be fixed, despite not all racy functions present in the original commit c92316bf8e948.

>> Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Russ Weight <russell.h.weight@intel.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Colin Ian King <colin.i.king@gmail.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: stable@vger.kernel.org # v5.4
>> Suggested-by: Dan Carpenter <error27@gmail.com>
> 
> Here you can add the above note in brackets:
> 
> [ explain your changes here from the original commit ]
> 
> Then, I see two commits upstream on Linus tree which are also fixes
> but not merged on v5.4, did you want those applied too?

These seem merged in the stable 5.4?

commit 75d9e00f65cd2e0f2ce9ceeb395f821976773489 test_firmware: fix a memory leak with reqs buffer
commit 94f3bc7e84af2f17dbfbc7afe93991c2a6f2f25e test_firmware: fix the memory leak of the allocated firmware buffer

Maybe this commit should be backported instead:

test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation
[ Upstream commit 7dae593cd226a0bca61201cf85ceb9335cf63682 ]

It was also merged into 6.4, 6.1, 5.15 and 5.10 stable, but not on 5.4

I might also check whether the 4.19 and 4.14 are vulnerable to these memory leaks and this race
(Yes, they are, so it might be prudent that we backport this fix.)

Mirsad

> 
>    Luis
