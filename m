Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE25F6CBBCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjC1KEq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 06:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjC1KEc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 06:04:32 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CCB210D;
        Tue, 28 Mar 2023 03:04:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 35DC0604FC;
        Tue, 28 Mar 2023 12:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679997869; bh=nNjj4eFTnRdcNvlbuD+nUzVzXcCxtvyyONYAI5iFXDc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=VB0rl8JVtNFYF+3kBX+8ggM2yu61QHQD2IGaNMGQLa+1RqlbqM9QkeabTlPBJQHX2
         Sixkmn97/iiOSeMuhuSCQAWcWHRGpRXb3fmOCK+F+I9sUQcRWtLMzg3dTWNy42sI0k
         ZqnebybUKpoREmIMV1pz02fspmghqd2JCGiw4ZYbOxaimBFqcvg1Pjuf1JgSX3J+Dy
         1H9/RtdZdgQQtmQmyCA8h6JPq63+EN6lg4IkrfC23Rc2gBQolPkIRyHZf4En7vW3Hx
         rVdhfHzpAiDT9xztbeEJI08VqZpc3A2QR8ZsgbLxB3lnqeKfngq86fbnXLbod7xgnu
         AVEu3ftYjmsRg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qGf-pZ_xmGhp; Tue, 28 Mar 2023 12:04:25 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 47D7C604F9;
        Tue, 28 Mar 2023 12:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679997865; bh=nNjj4eFTnRdcNvlbuD+nUzVzXcCxtvyyONYAI5iFXDc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=AVks5sz+WrYowF4TEA/9ZTlsRMSt3fo8jy5dWRmwZsXUOAOvI1Z4tQoPEKDNsUPko
         9OzUc6wh7DevGq4NBdgs+CePpzCgY6+qF5Sxklnz43IXPO+pj8uVxpqV8GjD/mCjJi
         t9ssQ2XE0MZFLjqrslFEcR0b/mHFB6G/W63RUbkh5nGgv80yTOuqJXZm+yhlbsx0VM
         nKQxe9y1JqpHaePM9EbU9xemLo1kqaAizzgrXswO73cfSEOeru4w1t1m3K/TxR8Gc1
         cXPNAYF6n7FU9DHEHj0tm23+7xkP328KBmFvdjQMNKYB/6+BgyT4LGTC+mz44F7yyt
         CPnN08rPwEDjA==
Message-ID: <71451bd9-b6e0-de00-a637-bc5a0da7966e@alu.unizg.hr>
Date:   Tue, 28 Mar 2023 12:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] selftests/firmware: copious kernel memory leaks in
 test_fw_run_batch_request()
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
Content-Language: en-US, hr
In-Reply-To: <97e284be-5018-9d18-feb2-7ec4b08c06fd@alu.unizg.hr>
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

On 3/28/23 11:23, Mirsad Todorovac wrote:
> Hi all,
> 
> Platform is AlmaLinux 8.7 (CentOS fork), Lenovo desktop
> LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB with the BIOS M22KT49A dated
> 11/10/2022.
> 
> Running Torvalds vanilla kernel 6.3-rc3 commit 6981739a967c with
> CONFIG_DEBUG_KMEMLEAK and CONFIG_DEBUG_{KOBJECT,KOBJECT_RELEASE} enabled.
> 
> The leak is cummulative, it can be reproduced with
> tools/testing/selftests/firmware/*.sh scripts.
> 
> The leaks are in chunks of 1024 bytes (+ overhead), but so far I could not
> reproduce w/o root privileges, as tests refuse to run as unprivileged user.
> (This is not the proof of non-existence of an unprivileged automated exploit
> that would exhaust the kernel memory at approx. rate 4 MB/hour on our setup.
> 
> This would mean about 96 MB / day or 3 GB / month (of kernel memory).
> 
> TEST RESULTS (showing the number of kmemleaks per test):
> 
> root@pc-mtodorov marvin]# grep -c 'comm "test_' linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw*.log
> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_fallback.sh.log:0
> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_filesystem.sh.log:60
> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_lib.sh.log:9
> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_run_tests.sh.log:196
> linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_upload.sh.log:0
> [root@pc-mtodorov marvin]#
> 
> Leaks look like this:
> 
> unreferenced object 0xffff943c390f8400 (size 1024):
>    comm "test_firmware-0", pid 449178, jiffies 4381453603 (age 824.844s)
>    hex dump (first 32 bytes):
>      45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
>      [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
>      [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
>      [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
>      [<ffffffff907d6dcf>] kthread+0x10f/0x140
>      [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
> unreferenced object 0xffff943a902f6400 (size 1024):
>    comm "test_firmware-1", pid 449179, jiffies 4381453603 (age 824.844s)
>    hex dump (first 32 bytes):
>      45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
>      [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
>      [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
>      [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
>      [<ffffffff907d6dcf>] kthread+0x10f/0x140
>      [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
> unreferenced object 0xffff943a902f0400 (size 1024):
>    comm "test_firmware-2", pid 449180, jiffies 4381453603 (age 824.844s)
>    hex dump (first 32 bytes):
>      45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
>      [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
>      [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
>      [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
>      [<ffffffff907d6dcf>] kthread+0x10f/0x140
>      [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
> unreferenced object 0xffff943a902f4000 (size 1024):
>    comm "test_firmware-3", pid 449181, jiffies 4381453603 (age 824.844s)
>    hex dump (first 32 bytes):
>      45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
>      [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
>      [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
>      [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
>      [<ffffffff907d6dcf>] kthread+0x10f/0x140
>      [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
> 
> Please find the build config, lshw output and the output of
> /sys/kernel/debug/kmemleak in the following directory:
> 
> https://domac.alu.hr/~mtodorov/linux/bugreports/kmemleak-firmware/
> 
> NOTE: sent to the maintainers listed for selftest/firmware and those
> listed for lib/test_firmware.c .

Hi, again!

The problem seems to be here:

lib/test_firmware.c:
-----------------------------------------------------------------------------------
  826 static int test_fw_run_batch_request(void *data)
  827 {
  828         struct test_batched_req *req = data;
  829
  830         if (!req) {
  831                 test_fw_config->test_result = -EINVAL;
  832                 return -EINVAL;
  833         }
  834
  835         if (test_fw_config->into_buf) {
  836                 void *test_buf;
  837
  838                 test_buf = kzalloc(TEST_FIRMWARE_BUF_SIZE, GFP_KERNEL);
  839                 if (!test_buf)
  840                         return -ENOSPC;
  841
  842                 if (test_fw_config->partial)
  843                         req->rc = request_partial_firmware_into_buf
  844                                                 (&req->fw,
  845                                                  req->name,
  846                                                  req->dev,
  847                                                  test_buf,
  848                                                  test_fw_config->buf_size,
  849                                                  test_fw_config->file_offset);
  850                 else
  851                         req->rc = request_firmware_into_buf
  852                                                 (&req->fw,
  853                                                  req->name,
  854                                                  req->dev,
  855                                                  test_buf,
  856                                                  test_fw_config->buf_size);
  857                 if (!req->fw)
  858                         kfree(test_buf);
  859         } else {
  860                 req->rc = test_fw_config->req_firmware(&req->fw,
  861                                                        req->name,
  862                                                        req->dev);
  863         }
  864
  865         if (req->rc) {
  866                 pr_info("#%u: batched sync load failed: %d\n",
  867                         req->idx, req->rc);
  868                 if (!test_fw_config->test_result)
  869                         test_fw_config->test_result = req->rc;
  870         } else if (req->fw) {
  871                 req->sent = true;
  872                 pr_info("#%u: batched sync loaded %zu\n",
  873                         req->idx, req->fw->size);
  874         }
  875         complete(&req->completion);
  876
  877         req->task = NULL;
  878
  879         return 0;
  880 }

The scope of test_buf is from its definition in line 836 to its end in line 859,
so in case req->fw != NULL the execution line loses track of the memory
kzalloc()'d in line 838.

Unless it is somewhere non-transparently referenced, it appears that the kernel
loses track of this allocated block.

Hope this helps.

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
