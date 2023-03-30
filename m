Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51A6D0937
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 17:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjC3PPB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 11:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjC3PPA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 11:15:00 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C3D314;
        Thu, 30 Mar 2023 08:13:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 8E9D0604F5;
        Thu, 30 Mar 2023 17:12:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680189138; bh=shGwIupjSJQsuWpYYdpBmXkymR9GYlLQyNnU5Tla32o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mqUJQosuZcgTKuqatETxiao7zsDPoOyBuoiyZIC6CasXw/pYjAsDgRO6BGai0K6Aq
         X5M12nSwkg7wNRf272SZCbh9S60XZZmP4/Dvkc4BRvoz6Q3H7tchyi2S4XUgkCwp6d
         00yxReP1IwY5Zjmu7Xl0luqAaeUIaAyn6RdKNOdbCbFOYjpitD/EDZouwAv7B+EpbL
         TOzHdRVhEMzw2K53KVJ3OgpSEVuNl070vmKi3+/MH7HV1d/0tbRCZQDFbON2aM1A3p
         EG18Q5V9AoPEa0909W3C1ZOU9+VFYXPPqsyteUfwHDjjX80IKqw8I6gGzdiqy8e4Ds
         o/FaNvvJyfckw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rriEOJylei56; Thu, 30 Mar 2023 17:12:15 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 65C0F604F0;
        Thu, 30 Mar 2023 17:12:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680189135; bh=shGwIupjSJQsuWpYYdpBmXkymR9GYlLQyNnU5Tla32o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bdqj8UGbXsCLfH6WZZjs6e6YqF1erDT1qBburWs2FagBNYmt4+IXMttLVzJr3dia9
         zepVpyjZgqOGdIcWr23+4GN1ZGe5DxbunM+0uLHQ8Jdjoc2ofFPtL46n5LLuYmuaAV
         w7UryKGXW+W9KDsI0PHvF6A+/unRSQfEiwK9KwauLLPcM3wYhKX2CAEmA0w8Mx0Vn5
         kc2082eGaG7zwkwVtSA5TZjyA67IXMKR9RDeeVxXoln6DTssMqJVmrtOV1EzfNgT7/
         /2PyLRai2R8UAKlRK3kRur+pe+/49PEfA7NEIRn28BTy12ogz5cWRLQCfaYD2M2jll
         Xo8Qe0MgTz0lQ==
Message-ID: <dce6ffbe-7580-db1a-dd24-798be27b3a26@alu.unizg.hr>
Date:   Thu, 30 Mar 2023 17:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] [PATCH RFC v2] selftests/firmware: copious kernel memory
 leaks in test_fw_run_batch_request()
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
Content-Language: en-US, hr
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

Hi, all,

This is not a formal patch, but please see if you think the way the
locking and race are solved correctly this time.

(Having two mutexes over the same set of resources is obviously a hazard.)

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

COMMENT: Like in libc putc() family of functions, there is also
putc_unlocked() The similar approach is applied here.

As the functions are callable from within both locked and non-locked
environment, we have to either:

1. have two or more locks, which is dubious in terms of concurrency
2. have locked and unlocked version of each function, for we cannot
    lock the same lock twice.

NOTE: Memory leaks are not solved with this patch, only a couple of
racing conditions.

---
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 05ed84c2fc4c..d6ed20bd1eb0 100644
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

"What’s this thing suddenly coming towards me very fast? Very very fast.
... I wonder if it will be friends with me?"
