Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAFD6D0473
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 14:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjC3MO6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 08:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjC3MO5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 08:14:57 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF9C5240;
        Thu, 30 Mar 2023 05:14:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 47AA6604F5;
        Thu, 30 Mar 2023 14:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680178493; bh=ayb2pw3hYDC8jjRZeWBH2bOVAIBgOuzroltwMc1VMjM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mj/0XOpY7sVZQil6CUxe+KCSXpX1n7uKC5blLGN6geabRYzoz52iKs+MK8vXKqB92
         AYX2Mt3bpzyFNYky4P3qgmq27Wyr03V2INb+HiC/IS6BvACeax1e+gO3WIuMiUKlWe
         iiKxn4C0K9GW8xbZWRIHKnv/TFXkVbI7lSLEqEr94DH10SdS39o6omlGzzDBEGOgFh
         UTI3k/lbadEITbzuRD+sicffJzuKaKYwNHGRryvIEIMROvscw8q4bBJ+Jkv59OO9Sv
         o/Ousf6I2hRy0f7rkKPGQ2eSGFOQ0uXfTgG/9XDlTUsLQYhZjUbPQtxXBFiNkZzyPL
         3ZZeEfNIqqV+w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iELGCEV9WoEr; Thu, 30 Mar 2023 14:14:51 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id DE5AC604F0;
        Thu, 30 Mar 2023 14:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680178491; bh=ayb2pw3hYDC8jjRZeWBH2bOVAIBgOuzroltwMc1VMjM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qeX8d+NyOObPJrSDDgx9T9KgoivY84PcB8mgRGFBU/zI1v077ptC2JMlbQGsAWA/Z
         Mny1KPEoeOYgYrlox4cwrGP7N4H/lmmxlvdLg+biNxQGkDqi2dz/vLJzFPn2cXMLnQ
         Ucx8HoIG7WA1/t/xfnaydpkwjc4wPF/4GySQoxH05pm7myFLT2T4sSFLnK04PpknNM
         1h1GDx+N0b++foxqI5gMLI8yORQRzuIHSDVBWSsElylomhBi+tNsyoH1R4Xs35r93Q
         L3FOe3FXZVGbGpSRIf8qEmYRnFZJ0ws5KroB0D0agROvA9U+D29tSrQN0XzezKrDGH
         VruvG7O5RH34g==
Message-ID: <4280de3f-0866-a904-78bc-5eb759dae248@alu.unizg.hr>
Date:   Thu, 30 Mar 2023 14:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] [PATCH RFC v1] selftests/firmware: copious kernel memory
 leaks in test_fw_run_batch_request()
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
> 
> There is no security implications.  This is root only.  Also if the
> user could load firmware then that would be the headline.  Once someone
> is can already load firmware then who cares if they leak 100MB per day?
> 
> It looks like if you call trigger_batched_requests_store() twice in a
> row then it will leak memory.  Definitely test_fw_config->reqs is leaked.
> That's different from what the bug report is complaining about, but the
> point is that there are some obvious leaks.  It looks like you're
> supposed to call trigger_batched_requests_store() in between runs?
> 
> There are other races like config_num_requests_store() should hold the
> mutex over the call to test_dev_config_update_u8() instead of dropping
> and retaking it.

Hi Dan,

Following your insight and advice, I tried to mend this racing condition
like this:

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 05ed84c2fc4c..6723c234ccbb 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -402,6 +402,8 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
         return snprintf(buf, PAGE_SIZE, "%d\n", val);
  }

+static DEFINE_MUTEX(test_fw_mutex_update);
+
  static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
  {
         u8 val;
@@ -411,9 +413,9 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
         if (ret)
                 return ret;

-       mutex_lock(&test_fw_mutex);
+       mutex_lock(&test_fw_mutex_update);
         *(u8 *)cfg = val;
-       mutex_unlock(&test_fw_mutex);
+       mutex_unlock(&test_fw_mutex_update);

         /* Always return full write size even if we didn't consume all */
         return size;
@@ -471,10 +473,10 @@ static ssize_t config_num_requests_store(struct device *dev,
                 mutex_unlock(&test_fw_mutex);
                 goto out;
         }
-       mutex_unlock(&test_fw_mutex);

         rc = test_dev_config_update_u8(buf, count,
                                        &test_fw_config->num_requests);
+       mutex_unlock(&test_fw_mutex);

  out:
         return rc;

For the second trigger_batched_requests_store(), probably the desired behaviour
would be to extend the list of test_fw_config->reqs, rather than destroying them
and allocating the new ones?

I am not certain about the desired semantics and where is it documented.

Thank you.

Best regards,

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

"What’s this thing suddenly coming towards me very fast? Very very fast.
... I wonder if it will be friends with me?"
