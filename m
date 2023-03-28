Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4097D6CC09A
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 15:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjC1NYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 09:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjC1NYI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 09:24:08 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1007293;
        Tue, 28 Mar 2023 06:24:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9398160505;
        Tue, 28 Mar 2023 15:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680009839; bh=DF9A1CW7RdeBA7TJpNjsGuitgauzJv9b+CiqF1Q4kGo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=hIZq1tWYhlnMIGRdLXb1LNovuVHn6kHlXGGLW82GLMknBoBOzyCqMe8CoQhL86lOy
         FY5raq+QsCv4w5dZ+1iwXPV7o39ahtoah3EwVXM19uxGWXj1le/nG6aFMKaIgUm1A7
         4As43xB/XArmH8bnTG82S735RLDpLH8cVaAE0ZNrfMGz7L2/hGaFR47KaACM3OiZoc
         1GX/t+D7wM1LEWXLI9ZqUIQv4EwdZdCM8oNM+5WEFp9BGjXSlc2XM6rS4InJsZ9t/T
         lvFAfpsqCbJwr7ZByOGpUO9I2uvSr3WuzTjRg4fRAV2KTpkfZWg6q1Ei9VlVeoefgp
         8R2pjOjOIwlKg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6PwEcbZzXeQJ; Tue, 28 Mar 2023 15:23:56 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 17CB560503;
        Tue, 28 Mar 2023 15:23:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680009836; bh=DF9A1CW7RdeBA7TJpNjsGuitgauzJv9b+CiqF1Q4kGo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=gWWDsOK/KBMUxlc2z5CCsFajRqGhMjGgckVPBAbUUXKMA5iRFzmJ6Avua45OM4TOV
         OQNeYdBQp5vNlHducyxl2voAMRAGsGwtkpEzbZ41IAxjl80Mn5lJBzyttOglhr6Ttn
         joD6xWEbs8Pgoq3NxAo7tP6KOpjPQ7sVbGNwan2BueMHFfmfSbxApH+p5dY617cxcp
         1L9YnaC+wJYh80IT8QcDswPAW+Z4b0VzOobfzjNzaP9KQdo52bvuqatrRAcm01kiGc
         TMYRUlLz3++vSrN4JOet4zBfnnjj8ziIjBtwKkO+EaTh0sfvOWas9bu/neT1sYMJfu
         az3SzPMYJV5/A==
Message-ID: <9ba5f3a0-8c4a-5344-1ecd-4d9690c28b5f@alu.unizg.hr>
Date:   Tue, 28 Mar 2023 15:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] selftests/firmware: copious kernel memory leaks in
 test_fw_run_batch_request()
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kselftest@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <97e284be-5018-9d18-feb2-7ec4b08c06fd@alu.unizg.hr>
 <71451bd9-b6e0-de00-a637-bc5a0da7966e@alu.unizg.hr>
In-Reply-To: <71451bd9-b6e0-de00-a637-bc5a0da7966e@alu.unizg.hr>
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

On 3/28/23 12:04, Mirsad Todorovac wrote:
> On 3/28/23 11:23, Mirsad Todorovac wrote:

>> Platform is AlmaLinux 8.7 (CentOS fork), Lenovo desktop
>> LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB with the BIOS M22KT49A dated
>> 11/10/2022.
>>
>> Running Torvalds vanilla kernel 6.3-rc3 commit 6981739a967c with
>> CONFIG_DEBUG_KMEMLEAK and CONFIG_DEBUG_{KOBJECT,KOBJECT_RELEASE} enabled.
>>
>> The leak is cummulative, it can be reproduced with
>> tools/testing/selftests/firmware/*.sh scripts.
>>
>> The leaks are in chunks of 1024 bytes (+ overhead), but so far I could not
>> reproduce w/o root privileges, as tests refuse to run as unprivileged user.
>> (This is not the proof of non-existence of an unprivileged automated exploit
>> that would exhaust the kernel memory at approx. rate 4 MB/hour on our setup.
>>
>> This would mean about 96 MB / day or 3 GB / month (of kernel memory).
>>
>> TEST RESULTS (showing the number of kmemleaks per test):
>>
>> root@pc-mtodorov marvin]# grep -c 'comm "test_' linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw*.log
>> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_fallback.sh.log:0
>> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_filesystem.sh.log:60
>> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_lib.sh.log:9
>> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_run_tests.sh.log:196
>> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_upload.sh.log:0
>> [root@pc-mtodorov marvin]#
>>
>> Leaks look like this:
>>
>> unreferenced object 0xffff943c390f8400 (size 1024):
>>    comm "test_firmware-0", pid 449178, jiffies 4381453603 (age 824.844s)
>>    hex dump (first 32 bytes):
>>      45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    backtrace:
>>      [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
>>      [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>      [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
>>      [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
>>      [<ffffffff907d6dcf>] kthread+0x10f/0x140
>>      [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
>> unreferenced object 0xffff943a902f6400 (size 1024):
>>    comm "test_firmware-1", pid 449179, jiffies 4381453603 (age 824.844s)
>>    hex dump (first 32 bytes):
>>      45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    backtrace:
>>      [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
>>      [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>      [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
>>      [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
>>      [<ffffffff907d6dcf>] kthread+0x10f/0x140
>>      [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
>> unreferenced object 0xffff943a902f0400 (size 1024):
>>    comm "test_firmware-2", pid 449180, jiffies 4381453603 (age 824.844s)
>>    hex dump (first 32 bytes):
>>      45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    backtrace:
>>      [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
>>      [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>      [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
>>      [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
>>      [<ffffffff907d6dcf>] kthread+0x10f/0x140
>>      [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
>> unreferenced object 0xffff943a902f4000 (size 1024):
>>    comm "test_firmware-3", pid 449181, jiffies 4381453603 (age 824.844s)
>>    hex dump (first 32 bytes):
>>      45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>    backtrace:
>>      [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
>>      [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>      [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
>>      [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
>>      [<ffffffff907d6dcf>] kthread+0x10f/0x140
>>      [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
>>
>> Please find the build config, lshw output and the output of
>> /sys/kernel/debug/kmemleak in the following directory:
>>
>> https://domac.alu.hr/~mtodorov/linux/bugreports/kmemleak-firmware/
>>
>> NOTE: sent to the maintainers listed for selftest/firmware and those
>> listed for lib/test_firmware.c .
> 
> Hi, again!
> 
> The problem seems to be here:
> 
> lib/test_firmware.c:
> -----------------------------------------------------------------------------------
>   826 static int test_fw_run_batch_request(void *data)
>   827 {
>   828         struct test_batched_req *req = data;
>   829
>   830         if (!req) {
>   831                 test_fw_config->test_result = -EINVAL;
>   832                 return -EINVAL;
>   833         }
>   834
>   835         if (test_fw_config->into_buf) {
>   836                 void *test_buf;
>   837
>   838                 test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
>   839                 if (!test_buf)
>   840                         return -ENOSPC;
>   841
>   842                 if (test_fw_config->partial)
>   843                         req->rc = request_partial_firmware_into_buf
>   844                                                 (&req->fw,
>   845                                                  req->name,
>   846                                                  req->dev,
>   847                                                  test_buf,
>   848                                                  test_fw_config->buf_size,
>   849                                                  test_fw_config->file_offset);
>   850                 else
>   851                         req->rc = request_firmware_into_buf
>   852                                                 (&req->fw,
>   853                                                  req->name,
>   854                                                  req->dev,
>   855                                                  test_buf,
>   856                                                  test_fw_config->buf_size);
>   857                 if (!req->fw)
>   858                         kfree(test_buf);
>   859         } else {
>   860                 req->rc = test_fw_config->req_firmware(&req->fw,
>   861                                                        req->name,
>   862                                                        req->dev);
>   863         }
>   864
>   865         if (req->rc) {
>   866                 pr_info("#%u: batched sync load failed: %d\n",
>   867                         req->idx, req->rc);
>   868                 if (!test_fw_config->test_result)
>   869                         test_fw_config->test_result = req->rc;
>   870         } else if (req->fw) {
>   871                 req->sent = true;
>   872                 pr_info("#%u: batched sync loaded %zu\n",
>   873                         req->idx, req->fw->size);
>   874         }
>   875         complete(&req->completion);
>   876
>   877         req->task = NULL;
>   878
>   879         return 0;
>   880 }
> 
> The scope of test_buf is from its definition in line 836 to its end in line 859,
> so in case req->fw != NULL the execution line loses track of the memory
> kzalloc()'d in line 838.
> 
> Unless it is somewhere non-transparently referenced, it appears that the kernel
> loses track of this allocated block.

CORRECTION: Withdrawn that!

After doing some homework, it appeared that something non-transparent is happening
in lib/test_firmware.c after all, and we cannot just kfree(test_buf), presumably
fixing the problem.

In line

  141         fw_priv->data = dbuf;

Allocated test_buf copied to some firmware data and is assigned to dbuf through 4
levels of function calls and assigned to fw_priv->data.

drivers/base/firmware_loader/main.c:141,
called from drivers/base/firmware_loader/main.c:189: alloc_lookup_fw_priv()
	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, offset, opt_flags);

called from drivers/base/firmware_loader/main.c:748: _request_firmware_prepare():
	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
				   offset, opt_flags);

called from ...:814 _request_firmware():
	ret = _request_firmware_prepare(&fw, name, device, buf, size,
					offset, opt_flags);

called from ...:1035 request_firmware_into_buf():
	ret = _request_firmware(firmware_p, name, device, buf, size, 0,
				FW_OPT_UEVENT | FW_OPT_NOCACHE);

called from lib/test_firmware.c:851 test_fw_run_batch_request()
(Which is where the leak appears to reside.)

drivers/base/firmware_loader/main.c:
  112 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
  113                                           struct firmware_cache *fwc,
  114                                           void *dbuf,
  115                                           size_t size,
  116                                           size_t offset,
  117                                           u32 opt_flags)
  118 {
  119         struct fw_priv *fw_priv;
  120
  121         /* For a partial read, the buffer must be preallocated. */
  122         if ((opt_flags & FW_OPT_PARTIAL) && !dbuf)
  123                 return NULL;
  124
  125         /* Only partial reads are allowed to use an offset. */
  126         if (offset != 0 && !(opt_flags & FW_OPT_PARTIAL))
  127                 return NULL;
  128
  129         fw_priv = kzalloc(sizeof(*fw_priv), GFP_ATOMIC);
  130         if (!fw_priv)
  131                 return NULL;
  132
  133         fw_priv->fw_name = kstrdup_const(fw_name, GFP_ATOMIC);
  134         if (!fw_priv->fw_name) {
  135                 kfree(fw_priv);
  136                 return NULL;
  137         }
  138
  139         kref_init(&fw_priv->ref);
  140         fw_priv->fwc = fwc;
  141         fw_priv->data = dbuf;
  142         fw_priv->allocated_size = size;
  143         fw_priv->offset = offset;
  144         fw_priv->opt_flags = opt_flags;
  145         fw_state_init(fw_priv);
  146 #ifdef CONFIG_FW_LOADER_USER_HELPER
  147         INIT_LIST_HEAD(&fw_priv->pending_list);
  148 #endif
  149
  150         pr_debug("%s: fw-%s fw_priv=%p\n", __func__, fw_name, fw_priv);
  151
  152         return fw_priv;
  153 }

So, the functions request_firmware_into_buf() and request_partial_firmware_into_buf()
have side-effect of actually assigning test_buf to the struct fw_priv's member
fw_priv->data.

But it seems a bit awkward semantically dubious to request firmware into something that
is immediately released and having only side effect four levels of fcalls deep add a
second reference to it.

Independently, besides that, the error code given in case of memory full and
failed kzalloc() is counterintuitive:

  837
  838                 test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
  839                 if (!test_buf)
  840                         return -ENOSPC;
  841

The rest of the driver code usually returns -ENOMEM on k*alloc() failures:

  837
  838                 test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
  839                 if (!test_buf)
  840                         return -ENOMEM;
  841

and this appears to be called only at one place:

  916		req->task = kthread_run(test_fw_run_batch_request, req,
  917					     "%s-%u", KBUILD_MODNAME, req->idx);

so the impact of the proposed change would be very low.

Who is actually consuming the error code in this case of kthread_run()?

(We are nowhere near to fixing the actual leak.)

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
