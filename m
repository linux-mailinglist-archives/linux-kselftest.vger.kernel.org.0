Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9824E6CBC90
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 12:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjC1Kdj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 06:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjC1Kdh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 06:33:37 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA1E95;
        Tue, 28 Mar 2023 03:33:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 696CE604FF;
        Tue, 28 Mar 2023 12:33:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679999613; bh=ISc5UrYNIsjj3V2cg/yKaSxQ/8CIikplimUZX2Ben+o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m7voJDS6iam9caCvklnd9K1SUP988Pk7i3pxARY6zB/+Qv3qw0J88eOD1mLJGW5Ox
         LhUJ6c5X0tpDZ7MYOWl9TeBZRm1ZAq6wj38T2PzP2GaCssEI2hjD75/LpoXNUyvRfB
         bJ6NKHHqoCUDZfTfOiKP0ViCSsiG3EiPS4Ytx2K6Ho/zMHM/b4KCK9sx84ViJ3gZP/
         NiPIR1IdKFKNMjeWbyiO9Zdsvs+jH5PN7nYvGxL5VNq3y0ceyD200mjX2e4Ex/gXZi
         du2Q6a0q5jUfyBHC81rUdKOgi/HA+ZS+ssW14UEo583DfXnfMrY7JIidx4Xe23+PLh
         KG+8coxns30Tg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EHf0-TFIbBiz; Tue, 28 Mar 2023 12:33:31 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 81D7E604FE;
        Tue, 28 Mar 2023 12:33:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679999611; bh=ISc5UrYNIsjj3V2cg/yKaSxQ/8CIikplimUZX2Ben+o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BAa1zR6wEWABATrrYbVdZ1KyyZhdf9Wryiq86CH/TlgEKjBAI/16zkefCsLdLIJ03
         YhsMTZ8/dPY9cV/EPVaC8TAdHLOyfPIP0978G6mMPRVvMZw0Di/iJIlySZJ7HJPlBu
         8usGFGSIcKC4PO9JKfSQ+4HgzwW6YHrN2Ff5iEkFAKbgAnsa6CaLsIGkAv+RzFyUTB
         azy8yh7kMhTORmav3TK9wNMfF3mH+7GMKkCC0JRh/QT8SWJDZ2wtmcHbfdjCYxPnkF
         WCM7+P1T+n+47SI7mur/E6/n1Z91tXKp5kj/HLQMONY0SoWvKJ4wNEgif0qULoibjH
         PUbYM+unWi9yw==
Message-ID: <fa82b641-365c-c1ca-1fec-1826df63db64@alu.unizg.hr>
Date:   Tue, 28 Mar 2023 12:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] selftests/firmware: copious kernel memory leaks in
 test_fw_run_batch_request()
Content-Language: en-US, hr
To:     Dan Carpenter <error27@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <97e284be-5018-9d18-feb2-7ec4b08c06fd@alu.unizg.hr>
 <26fd581a-1b9f-4960-8457-61d725511cee@kili.mountain>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <26fd581a-1b9f-4960-8457-61d725511cee@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Dan,

On 3/28/23 12:06, Dan Carpenter wrote:
> On Tue, Mar 28, 2023 at 11:23:00AM +0200, Mirsad Todorovac wrote:
>> The leaks are in chunks of 1024 bytes (+ overhead), but so far I could not
>> reproduce w/o root privileges, as tests refuse to run as unprivileged user.
>> (This is not the proof of non-existence of an unprivileged automated exploit
>> that would exhaust the kernel memory at approx. rate 4 MB/hour on our setup.
>>
>> This would mean about 96 MB / day or 3 GB / month (of kernel memory).
> 
> This is firmware testing stuff.  In the real world people aren't going
> to run their test scripts in a loop for days.

Thank you for making that clear.

> There is no security implications.  This is root only.  Also if the
> user could load firmware then that would be the headline.  Once someone
> is can already load firmware then who cares if they leak 100MB per day?

Yes, this is correct, but I just don't like leaks even in the userland programs.
But that might be just me ...

IMHO the purpose of the tests is to find and fix bugs. There are probably
more critical issues, but pick seemed manageable.

> It looks like if you call trigger_batched_requests_store() twice in a
> row then it will leak memory.  Definitely test_fw_config->reqs is leaked.
> That's different from what the bug report is complaining about, but the
> point is that there are some obvious leaks.  It looks like you're
> supposed to call trigger_batched_requests_store() in between runs?
> 
> There are other races like config_num_requests_store() should hold the
> mutex over the call to test_dev_config_update_u8() instead of dropping
> and retaking it.

Please consider the scope of the void *test_buf in lines 836-859 and whether the
fact that test_buf is not kfree()-ed on (req->fw != NULL) and its going out of the
scope affects this issue.

I saw there is an additional race condition involved since the exact count of leaks
is not always the same (not deterministic), but I could not figure that out by myself.

Thank you again very much for your quick reply.

BTW, I can confirm that the leak still exists in 6.3.0-rc4-00025-g3a93e40326c8
build.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

"Something is quickly approaching ... Will it be friends with me?"
