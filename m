Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF74C6D0E04
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjC3SnN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 14:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjC3SnE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 14:43:04 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72402FF12;
        Thu, 30 Mar 2023 11:43:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id DC8C0604F5;
        Thu, 30 Mar 2023 20:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680201779; bh=OGjehXW0tLGg+twlguEY6jqdgc6IMiPs6y4SgDUgv38=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pq7VG2APrR+8V5JeNK/lg6mF+fiv+sf5qRk0xTCRJQjxY9kP13eXgn8qE7FktA/py
         KdKVJK82tHIRxfpzwdxKeEgMZzKFIyMKYbHD2Rz75mPvFAUL/9PqWlSn1YFxXy0S4P
         bhqRDifIKCUlW06rkBuRvFM3hxzaN2QqR5ABjacJjEkMuG+PeC0cD3amNWuDI7/UaB
         d0PG91cPSISnceqtqwco1NeQGj6oGzJSkzOSpMNFEpJs47a/X3dNjfSMZDjM0VzORW
         w481I0HJQtnoM1U91/iCL1vyTZ9JmcEe9A+G1wMNg4FHVj6wqHHkSGkZraTejF/Rab
         K3+IMw+NvjEHQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xoEdwq1QnuJO; Thu, 30 Mar 2023 20:42:57 +0200 (CEST)
Received: from [192.168.1.4] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id A252F604F0;
        Thu, 30 Mar 2023 20:42:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680201777; bh=OGjehXW0tLGg+twlguEY6jqdgc6IMiPs6y4SgDUgv38=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qdnwgRkIh6yiHAoADC75ia964sCT+lXtViWtEgFsv+unle25nABnjVs3T8QA20WA4
         xEV2WrbpsajvHV8XoFUbeOCA1HhaEQw/srwJgUfG2J9KgXBzxLazoHZ4H74StV2Bno
         ca+PbzDL7mRhvmh5n0RfpISwOeeupZ4fOb/MjmwceeZ8gslOeC2uZ8Gz607W5Ji9eT
         XkXLRNqB3qdEx3amwGTEMa45Zlt7SCXyVsnHMkdahkiXMBCNxb7VUZwRdkuniWb7tO
         Em9iMt4gI9teOtHrE3T/Af7VhnT1qybWgcAWKQiLW/TMoNyHZsLZxf88US6nC5vLlC
         Irf1mICy4GsiQ==
Message-ID: <5e1d56b9-5cf6-75f4-76ab-7c84679cad6a@alu.unizg.hr>
Date:   Thu, 30 Mar 2023 20:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] [PATCH RFC v2] selftests/firmware: copious kernel memory
 leaks in test_fw_run_batch_request()
To:     Takashi Iwai <tiwai@suse.de>, Dan Carpenter <error27@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <97e284be-5018-9d18-feb2-7ec4b08c06fd@alu.unizg.hr>
 <26fd581a-1b9f-4960-8457-61d725511cee@kili.mountain>
 <dce6ffbe-7580-db1a-dd24-798be27b3a26@alu.unizg.hr>
 <5b103196-68d0-4d42-aa66-779af4d78532@kili.mountain>
 <878rfekz2l.wl-tiwai@suse.de>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <878rfekz2l.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30. 03. 2023. 18:01, Takashi Iwai wrote:
> On Thu, 30 Mar 2023 17:44:42 +0200,
> Dan Carpenter wrote:
>>
>> I admire your enthusiam.  :)  What about if we just did this?  Does it
>> help with the leaks?
>>
>> regards,
>> dan carpenter
>>
>> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
>> index 05ed84c2fc4c..626b836895f4 100644
>> --- a/lib/test_firmware.c
>> +++ b/lib/test_firmware.c
>> @@ -895,6 +895,9 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
>>  
>>  	mutex_lock(&test_fw_mutex);
>>  
>> +	if (test_fw_config->reqs)
>> +		return -EBUSY;
>> +
> 
> This leaves the mutex locked.
> It should be the following instead, I suppose?
> 
> 	if (test_fw_config->reqs) {
> 		rc = -EBUSY;
> 		goto out_unlock;
> 	}
> 
> 
> Takashi

Hi, Dan, Takashi,

Unfortunately, it did not suffice.

What I was building with was
commit 8bb95a1662f8:Merge tag 'sound-6.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
with the following patch for lib/test_firmware.c:


---
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 05ed84c2fc4c..4daa38bd2cac 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -353,6 +353,19 @@ static ssize_t config_test_show_str(char *dst,
        return len;
 }
 
+static inline int test_dev_config_update_bool_unlocked(const char *buf, size_t size,
+                                      bool *cfg)
+{
+       int ret;
+
+       if (kstrtobool(buf, cfg) < 0)
+               ret = -EINVAL;
+       else
+               ret = size;
+
+       return ret;
+}
+
 static int test_dev_config_update_bool(const char *buf, size_t size,
                                       bool *cfg)
 {
@@ -373,6 +386,24 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
        return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
+static int test_dev_config_update_size_t_unlocked(
+                                        const char *buf,
+                                        size_t size,
+                                        size_t *cfg)
+{
+       int ret;
+       long new;
+
+       ret = kstrtol(buf, 10, &new);
+       if (ret)
+               return ret;
+
+       *(size_t *)cfg = new;
+
+       /* Always return full write size even if we didn't consume all */
+       return size;
+}
+
 static int test_dev_config_update_size_t(const char *buf,
                                         size_t size,
                                         size_t *cfg)
@@ -402,6 +433,21 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
        return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
+static int test_dev_config_update_u8_unlocked(const char *buf, size_t size, u8 *cfg)
+{
+       u8 val;
+       int ret;
+
+       ret = kstrtou8(buf, 10, &val);
+       if (ret)
+               return ret;
+
+       *(u8 *)cfg = val;
+
+       /* Always return full write size even if we didn't consume all */
+       return size;
+}
+
 static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
        u8 val;
@@ -471,10 +517,10 @@ static ssize_t config_num_requests_store(struct device *dev,
                mutex_unlock(&test_fw_mutex);
                goto out;
        }
-       mutex_unlock(&test_fw_mutex);
 
-       rc = test_dev_config_update_u8(buf, count,
-                                      &test_fw_config->num_requests);
+       rc = test_dev_config_update_u8_unlocked(buf, count,
+                                               &test_fw_config->num_requests);
+       mutex_unlock(&test_fw_mutex);
 
 out:
        return rc;
@@ -518,10 +564,10 @@ static ssize_t config_buf_size_store(struct device *dev,
                mutex_unlock(&test_fw_mutex);
                goto out;
        }
-       mutex_unlock(&test_fw_mutex);
 
-       rc = test_dev_config_update_size_t(buf, count,
-                                          &test_fw_config->buf_size);
+       rc = test_dev_config_update_size_t_unlocked(buf, count,
+                                                   &test_fw_config->buf_size);
+       mutex_unlock(&test_fw_mutex);
 
 out:
        return rc;
@@ -548,10 +594,10 @@ static ssize_t config_file_offset_store(struct device *dev,
                mutex_unlock(&test_fw_mutex);
                goto out;
        }
-       mutex_unlock(&test_fw_mutex);
 
-       rc = test_dev_config_update_size_t(buf, count,
-                                          &test_fw_config->file_offset);
+       rc = test_dev_config_update_size_t_unlocked(buf, count,
+                                                   &test_fw_config->file_offset);
+       mutex_unlock(&test_fw_mutex);
 
 out:
        return rc;
@@ -895,6 +941,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
        mutex_lock(&test_fw_mutex);
 
+       if (test_fw_config->reqs) {
+               rc = -EBUSY;
+               goto out_unlock;
+       }
+
        test_fw_config->reqs =
                vzalloc(array3_size(sizeof(struct test_batched_req),
                                    test_fw_config->num_requests, 2));
@@ -993,6 +1044,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
        mutex_lock(&test_fw_mutex);
 
+       if (test_fw_config->reqs) {
+               rc = -EBUSY;
+               goto out;
+       }
+
        test_fw_config->reqs =
                vzalloc(array3_size(sizeof(struct test_batched_req),
                                    test_fw_config->num_requests, 2));

The leaks are the same:

unreferenced object 0xffff96deccc99c00 (size 1024):
  comm "test_firmware-2", pid 3093, jiffies 4294945062 (age 605.444s)
  hex dump (first 32 bytes):
    45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb58fb26c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffffb5902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffffb587696e>] kmalloc_trace+0x2e/0xc0
    [<ffffffffb5cc00c0>] test_fw_run_batch_request+0x90/0x170
    [<ffffffffb55d6dff>] kthread+0x10f/0x140
    [<ffffffffb5402fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff96ded72be400 (size 1024):
  comm "test_firmware-3", pid 3094, jiffies 4294945062 (age 605.444s)
  hex dump (first 32 bytes):
    45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb58fb26c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffffb5902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffffb587696e>] kmalloc_trace+0x2e/0xc0
    [<ffffffffb5cc00c0>] test_fw_run_batch_request+0x90/0x170
    [<ffffffffb55d6dff>] kthread+0x10f/0x140
    [<ffffffffb5402fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff96dec9e32800 (size 1024):
  comm "test_firmware-0", pid 3101, jiffies 4294945072 (age 605.404s)
  hex dump (first 32 bytes):
    45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb58fb26c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffffb5902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffffb587696e>] kmalloc_trace+0x2e/0xc0
    [<ffffffffb5cc00c0>] test_fw_run_batch_request+0x90/0x170
    [<ffffffffb55d6dff>] kthread+0x10f/0x140
    [<ffffffffb5402fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff96df0ab17000 (size 1024):
  comm "test_firmware-1", pid 3102, jiffies 4294945073 (age 605.432s)
  hex dump (first 32 bytes):
    45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb58fb26c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffffb5902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffffb587696e>] kmalloc_trace+0x2e/0xc0
    [<ffffffffb5cc00c0>] test_fw_run_batch_request+0x90/0x170
    [<ffffffffb55d6dff>] kthread+0x10f/0x140
    [<ffffffffb5402fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff96decd6f6400 (size 1024):
  comm "test_firmware-2", pid 3103, jiffies 4294945073 (age 605.432s)
  hex dump (first 32 bytes):
    45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb58fb26c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffffb5902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffffb587696e>] kmalloc_trace+0x2e/0xc0
    [<ffffffffb5cc00c0>] test_fw_run_batch_request+0x90/0x170
    [<ffffffffb55d6dff>] kthread+0x10f/0x140
    [<ffffffffb5402fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff96df0dc69c00 (size 1024):
  comm "test_firmware-3", pid 3104, jiffies 4294945073 (age 605.432s)
  hex dump (first 32 bytes):
    45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb58fb26c>] slab_post_alloc_hook+0x8c/0x3e0
    [<ffffffffb5902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
    [<ffffffffb587696e>] kmalloc_trace+0x2e/0xc0
    [<ffffffffb5cc00c0>] test_fw_run_batch_request+0x90/0x170
    [<ffffffffb55d6dff>] kthread+0x10f/0x140
    [<ffffffffb5402fa9>] ret_from_fork+0x29/0x50
[root@pc-mtodorov linux_torvalds]# uname -rms
Linux 6.3.0-rc4mt+20230330-00051-g8bb95a1662f8-dirty x86_64
[root@pc-mtodorov linux_torvalds]# 

My gut feeling tells me that it is not test_fw_config->reqs because
there are 75 instances leaked.

Regards,
Mirsad

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

