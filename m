Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D9D6614A3
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 11:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjAHK6l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 05:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjAHK6b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 05:58:31 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CD5140FE;
        Sun,  8 Jan 2023 02:58:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 727F7604F1;
        Sun,  8 Jan 2023 11:58:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673175507; bh=BK4P9TtBcpuP0t8yI6jHQVr62Hdz62l7nDkfHkz4Wc8=;
        h=Date:From:Cc:To:Subject:From;
        b=WZ3EV3hPIumGiGK/VDDaRg0NNCqCJY8m3MauDYe6jKPzjxR97uS1S1LjZKrk6DSDO
         DWLGZwCESiu/O1ES+v8q34S3Tswu8W9ycRrHLBsfD3kB+mnzo33ouZoBmucC3foKS9
         HfM540AimwssKtEpBriMvW9/rkW7iMoX6BC7q8yiYVFH5kwEJaxIiwmrMxhIa1xyv+
         +iIta4m/xKtcQtPUVBpxsgM387QfpXNc6W/sEpc+THyXiHbr1fRvpkOmxWyHBWgihW
         5xd1qdAfe1jP+QFCkzuJU85X9v9N5cNow6136ILn4C1S42wySzXwNPDYC5IUB7NjQz
         3/BngngGClzWw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VQjWIArKGhAK; Sun,  8 Jan 2023 11:58:25 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id 8F8D2604F0;
        Sun,  8 Jan 2023 11:58:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673175504; bh=BK4P9TtBcpuP0t8yI6jHQVr62Hdz62l7nDkfHkz4Wc8=;
        h=Date:From:Cc:To:Subject:From;
        b=kZvfCgDW747C2GEyzGb0iKUsmSg5BTk4FYHeSZ58sgF3Znb2tGVidIlEBD6jWKnEl
         HaZL81cOT4alsRmBNGd8XmfJXdkHL7maH2odYIVHDx2iO6qmqiL5IIB80l7rGGyVO/
         uwdUiV6foONsZ85AMRHQoeXGL7FS4MCtBmA0HTdOiMaRq9Mfg6QXsgfhU7jW4g/mfu
         8gopqM9tPcB9fhC9QlilASBwnXakZ8VVIi20ffFEBLsEa/+LDEI5OqVA0vZ3iWv61s
         gh3pqxYFOIVllMBDulZGt7MboFQjXJb4VQvdXGU9//medZOAjoZVTelDvVIkhM3mqP
         9oILajFa6vKvQ==
Message-ID: <0f117203-3227-cd16-61c2-2dd3de75ecc7@alu.unizg.hr>
Date:   Sun, 8 Jan 2023 11:58:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     linux-mm@kvack.org
Subject: =?UTF-8?Q?PROBLEM=3a_selftest/vm/cow=2ec_failed_to_compile_=28?=
 =?UTF-8?B?4oCYTUFEVl9QQUdFT1VU4oCZIHVuZGVjbGFyZWQp?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

During "make kselftest" there is an error in selftest/vm/cow.c compilation on
platform:

- Lenovo desktop 10TX000VCR (LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
- AlmaLinux 8.7 (CentOS fork)
- gcc 8.5.0 20210514 (Red Hat 8.5.0-15)
- vanilla kernel 6.2-rc2 from the torvalds mainline tree.

Compilation fails to find "#define MADV_PAGEOUT":

[root@pc-mtodorov vm]# make
gcc -Wall -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../.. -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include  -isystem /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include -no-pie     cow.c vm_util.c -lrt -lpthread  -o /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm/cow
cow.c: In function ‘do_run_with_base_page’:
cow.c:755:26: error: ‘MADV_PAGEOUT’ undeclared (first use in this function); did you mean ‘MADV_RANDOM’?
   madvise(mem, pagesize, MADV_PAGEOUT);
                          ^~~~~~~~~~~~
                          MADV_RANDOM
cow.c:755:26: note: each undeclared identifier is reported only once for each function it appears in
cow.c: In function ‘do_run_with_thp’:
cow.c:914:22: error: ‘MADV_PAGEOUT’ undeclared (first use in this function); did you mean ‘MADV_RANDOM’?
   madvise(mem, size, MADV_PAGEOUT);
                      ^~~~~~~~~~~~
                      MADV_RANDOM
make: *** [../lib.mk:145: /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm/cow] Error 1
[root@pc-mtodorov vm]# 

MADV_PAGEOUT is defined in #include <asm-generic/mman-common.h> :

[root@pc-mtodorov vm]# grep MADV_PAGEOUT -r /usr/include
/usr/include/asm-generic/mman-common.h:#define MADV_PAGEOUT     21              /* reclaim these pages */
[root@pc-mtodorov vm]# grep MADV_PAGEOUT -r ../../../../usr/include
../../../../usr/include/asm-generic/mman-common.h:#define MADV_PAGEOUT  21              /* reclaim these pages */
[root@pc-mtodorov vm]# 

However, gcc -E shows that asm-generic/mman-common.h is somehow never included:

---------------------------------------------------------------------------------------------
[root@pc-mtodorov vm]# gcc -Wall -E -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../.. -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include  -isystem /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include -no-pie     cow.c | cat -s | less
# 1 "/usr/include/sys/mman.h" 1 3 4
# 25 "/usr/include/sys/mman.h" 3 4
# 1 "/usr/lib/gcc/x86_64-redhat-linux/8/include/stddef.h" 1 3 4
# 26 "/usr/include/sys/mman.h" 2 3 4
# 41 "/usr/include/sys/mman.h" 3 4
# 1 "/usr/include/bits/mman.h" 1 3 4
# 49 "/usr/include/bits/mman.h" 3 4
# 1 "/usr/include/bits/mman-linux.h" 1 3 4
# 117 "/usr/include/bits/mman-linux.h" 3 4
# 1 "/usr/include/bits/mman-shared.h" 1 3 4
# 42 "/usr/include/bits/mman-shared.h" 3 4

int memfd_create (const char *__name, unsigned int __flags) __attribute__ ((__nothrow__ , __leaf__));
int mlock2 (const void *__addr, size_t __length, unsigned int __flags) __attribute__ ((__nothrow__ , __leaf__));
int pkey_alloc (unsigned int __flags, unsigned int __access_rights) __attribute__ ((__nothrow__ , __leaf__));
int pkey_set (int __key, unsigned int __access_rights) __attribute__ ((__nothrow__ , __leaf__));
int pkey_get (int __key) __attribute__ ((__nothrow__ , __leaf__));
int pkey_free (int __key) __attribute__ ((__nothrow__ , __leaf__));
int pkey_mprotect (void *__addr, size_t __len, int __prot, int __pkey) __attribute__ ((__nothrow__ , __leaf__));

# 117 "/usr/include/bits/mman-linux.h" 2 3 4
# 49 "/usr/include/bits/mman.h" 2 3 4
# 42 "/usr/include/sys/mman.h" 2 3 4

# 57 "/usr/include/sys/mman.h" 3 4
extern void *mmap (void *__addr, size_t __len, int __prot,
     int __flags, int __fd, __off_t __offset) __attribute__ ((__nothrow__ , __leaf__));
# 70 "/usr/include/sys/mman.h" 3 4
extern void *mmap64 (void *__addr, size_t __len, int __prot,
       int __flags, int __fd, __off64_t __offset) __attribute__ ((__nothrow__ , __leaf__));

extern int munmap (void *__addr, size_t __len) __attribute__ ((__nothrow__ , __leaf__));
extern int mprotect (void *__addr, size_t __len, int __prot) __attribute__ ((__nothrow__ , __leaf__));
extern int msync (void *__addr, size_t __len, int __flags);
extern int madvise (void *__addr, size_t __len, int __advice) __attribute__ ((__nothrow__ , __leaf__));
extern int posix_madvise (void *__addr, size_t __len, int __advice) __attribute__ ((__nothrow__ , __leaf__));
extern int mlock (const void *__addr, size_t __len) __attribute__ ((__nothrow__ , __leaf__));
extern int munlock (const void *__addr, size_t __len) __attribute__ ((__nothrow__ , __leaf__));
extern int mlockall (int __flags) __attribute__ ((__nothrow__ , __leaf__));
extern int munlockall (void) __attribute__ ((__nothrow__ , __leaf__));
extern int mincore (void *__start, size_t __len, unsigned char *__vec)
     __attribute__ ((__nothrow__ , __leaf__));

# 133 "/usr/include/sys/mman.h" 3 4

extern void *mremap (void *__addr, size_t __old_len, size_t __new_len,
       int __flags, ...) __attribute__ ((__nothrow__ , __leaf__));
extern int remap_file_pages (void *__start, size_t __size, int __prot,
        size_t __pgoff, int __flags) __attribute__ ((__nothrow__ , __leaf__));
extern int shm_open (const char *__name, int __oflag, mode_t __mode);
extern int shm_unlink (const char *__name);
-------------------------------------------------------------------------------------------------------

FYI:

On the platform:

- Ubuntu 22.10 kinetic kudu
- gcc 12.2.0
- same 6.2-rc2

, MADV_PAGEOUT is also defined in bits/mmap-linux.h, so the compile passes.

root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# grep MADV_PAGEOUT -r /usr/include
/usr/include/asm-generic/mman-common.h:#define MADV_PAGEOUT	21		/* reclaim these pages */
/usr/include/x86_64-linux-gnu/bits/mman-linux.h:# define MADV_PAGEOUT     21	/* Reclaim these pages.  */
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# grep MADV_PAGEOUT -r ../../../../usr/include
../../../../usr/include/asm-generic/mman-common.h:#define MADV_PAGEOUT	21		/* reclaim these pages */
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# 

However, mman-common.h from ../../../../usr/include/asm-generic/mman-common.h is also not included,
as of "gcc -E", but only bits/mman-linux.h:

root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# gcc -Wall -E -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../.. -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include  -isystem /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include -no-pie     cow.c | grep mman-common.h
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# gcc -Wall -E -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../.. -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include  -isystem /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include -no-pie     cow.c | grep mman-linux.h
# 1 "/usr/include/x86_64-linux-gnu/bits/mman-linux.h" 1 3 4
# 119 "/usr/include/x86_64-linux-gnu/bits/mman-linux.h" 3 4
# 120 "/usr/include/x86_64-linux-gnu/bits/mman-linux.h" 2 3 4
root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# 

I hope this is enough information for you to debug the issue.

I am standing by for any additional diagnostics needed.

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
