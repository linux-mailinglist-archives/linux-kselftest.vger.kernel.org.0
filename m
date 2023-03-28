Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E56CBA63
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 11:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjC1JXK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 05:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjC1JXK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 05:23:10 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660C3C11;
        Tue, 28 Mar 2023 02:23:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B1876604FC;
        Tue, 28 Mar 2023 11:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679995385; bh=+4Uv1oeXch0E8QEw2r4NGzYsJRfZ0wnJQWh8JRcI2ZQ=;
        h=Date:To:From:Subject:Cc:From;
        b=t4hv8wsK9Ha+Yb4rAI4xaJSbQNNURyJcKgD85vHGwNmKi38vfBniwFhSLuon5B44r
         qySnV3qwvf5rahwXOBA+Pogw3BmOMEpT7e5yoKTzIV9TjXS7qfmVrhotTMf4KrE8Yp
         XKkPxyilfC0/TUJlIVRbSbRH+BB+FksXUlyhfPkUygDIkRQbal6NeJQVuitrX283dY
         cmAC5J05J1VxHQvKz0Sa76RLWr7QeNH+AQISIhUYjj2NMxYGlOMvTSiYN5KYxR5uXV
         ODxlTtXTeNHhAYRq4j+jHvGBxD8lry+5sUyZPLTUB8IapTuKiSIvwtq+ys0+WAt7Ti
         /6tSL3GI9yuHg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gGNKuCLOuQQi; Tue, 28 Mar 2023 11:23:02 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id D5557604F9;
        Tue, 28 Mar 2023 11:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679995382; bh=+4Uv1oeXch0E8QEw2r4NGzYsJRfZ0wnJQWh8JRcI2ZQ=;
        h=Date:To:From:Subject:Cc:From;
        b=O4eC5/D+8E+IZ7vgeH4tmRyjF5+6efj9baJ4vVydspX08tvFRPCHPApRF91xrYlJ0
         bAAoCtpUBJiCDH0zYw+erL33Eg7+CkiQ2ePEdqMN/HeYYATtrxtADml3ITiQgjjhTN
         TbWiTVutaaXPsKTgx/jIolHSualWQVImGoX1TZCHKmStOCv8XCIvCn6A80wBtwEiU3
         uSYhwM5nzEfk5hhld5FLRBsYpM9VrqJTHbgUDrSmGDMhS9m+6S/vGITwhEieDFQudM
         QtQxWfPqhGzsRTJCjphTCJ8JZiTPTu6WEDGCx1QZM5pTC5AoLkIUtpivKQ1EoYqiTj
         p0CryaOYS9A/A==
Message-ID: <97e284be-5018-9d18-feb2-7ec4b08c06fd@alu.unizg.hr>
Date:   Tue, 28 Mar 2023 11:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, hr
To:     linux-kselftest@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [BUG] selftests/firmware: copious kernel memory leaks in
 test_fw_run_batch_request()
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

Platform is AlmaLinux 8.7 (CentOS fork), Lenovo desktop
LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB with the BIOS M22KT49A dated
11/10/2022.

Running Torvalds vanilla kernel 6.3-rc3 commit 6981739a967c with
CONFIG_DEBUG_KMEMLEAK and CONFIG_DEBUG_{KOBJECT,KOBJECT_RELEASE} enabled.

The leak is cummulative, it can be reproduced with
tools/testing/selftests/firmware/*.sh scripts.

The leaks are in chunks of 1024 bytes (+ overhead), but so far I could not
reproduce w/o root privileges, as tests refuse to run as unprivileged user.
(This is not the proof of non-existence of an unprivileged automated exploit
that would exhaust the kernel memory at approx. rate 4 MB/hour on our setup.

This would mean about 96 MB / day or 3 GB / month (of kernel memory).

TEST RESULTS (showing the number of kmemleaks per test):

root@pc-mtodorov marvin]# grep -c 'comm "test_' linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw*.log
linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_fallback.sh.log:0
linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_filesystem.sh.log:60
linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_lib.sh.log:9
linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_run_tests.sh.log:196
linux/kernel_bugs/memleaks-6.3-rc3/kmemleak-fw_upload.sh.log:0
[root@pc-mtodorov marvin]#

Leaks look like this:

unreferenced object 0xffff943c390f8400 (size 1024):
   comm "test_firmware-0", pid 449178, jiffies 4381453603 (age 824.844s)
   hex dump (first 32 bytes):
     45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
     [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
     [<ffffffff907d6dcf>] kthread+0x10f/0x140
     [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff943a902f6400 (size 1024):
   comm "test_firmware-1", pid 449179, jiffies 4381453603 (age 824.844s)
   hex dump (first 32 bytes):
     45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
     [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
     [<ffffffff907d6dcf>] kthread+0x10f/0x140
     [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff943a902f0400 (size 1024):
   comm "test_firmware-2", pid 449180, jiffies 4381453603 (age 824.844s)
   hex dump (first 32 bytes):
     45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
     [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
     [<ffffffff907d6dcf>] kthread+0x10f/0x140
     [<ffffffff90602fa9>] ret_from_fork+0x29/0x50
unreferenced object 0xffff943a902f4000 (size 1024):
   comm "test_firmware-3", pid 449181, jiffies 4381453603 (age 824.844s)
   hex dump (first 32 bytes):
     45 46 47 48 34 35 36 37 0a 00 00 00 00 00 00 00  EFGH4567........
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<ffffffff90aed68c>] slab_post_alloc_hook+0x8c/0x3e0
     [<ffffffff90af4f69>] __kmem_cache_alloc_node+0x1d9/0x2a0
     [<ffffffff90a6a6ae>] kmalloc_trace+0x2e/0xc0
     [<ffffffff90eb2350>] test_fw_run_batch_request+0x90/0x170
     [<ffffffff907d6dcf>] kthread+0x10f/0x140
     [<ffffffff90602fa9>] ret_from_fork+0x29/0x50

Please find the build config, lshw output and the output of
/sys/kernel/debug/kmemleak in the following directory:

https://domac.alu.hr/~mtodorov/linux/bugreports/kmemleak-firmware/

NOTE: sent to the maintainers listed for selftest/firmware and those
listed for lib/test_firmware.c .

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
