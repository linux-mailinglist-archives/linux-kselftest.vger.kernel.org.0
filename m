Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4563662B71
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 17:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjAIQnQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 11:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbjAIQnP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 11:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B122603
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 08:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673282549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9uCN3VQ3btzl2FPuIbtk5ZKyJr6zz6N2a76k393fHs=;
        b=Hzm0IO3cddwlHlEL5NKmApwpD9BVLyNvcdF2HtY35XoNCaE9xMnzjsW8Cnq5gVoh+MSW+g
        n1i0ZMEByk0tv0kDJqwg7V8E0xcSPAKXhX+4L5VlrUPt8YFH+BiCVtNQba4Y6YMxSMJTek
        pK84i/n8CdqKf2n9/4ghrDnaEMLnWEI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653--BJm8HP_MlGuo3riRRGaAg-1; Mon, 09 Jan 2023 11:42:27 -0500
X-MC-Unique: -BJm8HP_MlGuo3riRRGaAg-1
Received: by mail-wr1-f69.google.com with SMTP id d27-20020adfa35b000000b002bc813ba677so288412wrb.6
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Jan 2023 08:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9uCN3VQ3btzl2FPuIbtk5ZKyJr6zz6N2a76k393fHs=;
        b=2OXdima7yjYbdts1bK9Hcsmim8sQAk+t7DMhTpI/L9NAJXRih7L2wwt1Xgw4S2osg9
         ZCzLQbuL5+Dl+1q/ZUobEHt0D58hrYyLBMDAKyPLO1smcbpzQB05sKlDxOMzyn6koPag
         2KeLJte/96SycSVgpADdfgPaE3z6kQ9CdqW4bQDoQ8BrOiwBOqvJhqHOk+hIt6EeBStY
         wQFXQODr5iPD9YmdhfChkYolcqVYMTI8zaU3TYFhU1MgeZIWfCq9EWmEEMifXiJJIJ4s
         SFrwE7xPqAPGl6OVxAvKNo2K4dtE5RDrko+fNv7UDudXZzv+H+yfj0zPiP48FfBWmSfg
         mGNQ==
X-Gm-Message-State: AFqh2kqWsvH4yKxg1BK4f+KT0ABcRl+uYTfTIeoNnO0fFs2wll4hVj2e
        2RRmgICsvUE2nG1g/oBTVrwFRInpasDdcedpLvVCX3dTz7xXBn+B2yqYoeTW0/Y04qtQbv91Ies
        P8fsYFE+vAg5FspSn53DWwoNC4X2R
X-Received: by 2002:adf:f402:0:b0:270:c07e:56 with SMTP id g2-20020adff402000000b00270c07e0056mr35801396wro.53.1673282546793;
        Mon, 09 Jan 2023 08:42:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuDdRq6l4D7tqj25ezhGwOEQPszZc1qC6Ax7Wv4ZPTyTh7QWw6hCI6gshgkwfk7zWzwDrx/Jg==
X-Received: by 2002:adf:f402:0:b0:270:c07e:56 with SMTP id g2-20020adff402000000b00270c07e0056mr35801381wro.53.1673282546464;
        Mon, 09 Jan 2023 08:42:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:8f00:ba3:7d27:204f:8e29? (p200300cbc7038f000ba37d27204f8e29.dip0.t-ipconnect.de. [2003:cb:c703:8f00:ba3:7d27:204f:8e29])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6402000000b00297dcfdc90fsm8954756wru.24.2023.01.09.08.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 08:42:26 -0800 (PST)
Message-ID: <0ee389dc-5e47-5b7e-4db5-637eb2b3fbc9@redhat.com>
Date:   Mon, 9 Jan 2023 17:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: =?UTF-8?Q?Re=3a_PROBLEM=3a_selftest/vm/cow=2ec_failed_to_compile_?=
 =?UTF-8?B?KOKAmE1BRFZfUEFHRU9VVOKAmSB1bmRlY2xhcmVkKQ==?=
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0f117203-3227-cd16-61c2-2dd3de75ecc7@alu.unizg.hr>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0f117203-3227-cd16-61c2-2dd3de75ecc7@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08.01.23 11:58, Mirsad Goran Todorovac wrote:
> Hi all,
> 
> During "make kselftest" there is an error in selftest/vm/cow.c compilation on
> platform:
> 
> - Lenovo desktop 10TX000VCR (LENOVO_MT_10TX_BU_Lenovo_FM_V530S-07ICB)
> - AlmaLinux 8.7 (CentOS fork)
> - gcc 8.5.0 20210514 (Red Hat 8.5.0-15)
> - vanilla kernel 6.2-rc2 from the torvalds mainline tree.
> 
> Compilation fails to find "#define MADV_PAGEOUT":
> 
> [root@pc-mtodorov vm]# make
> gcc -Wall -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../.. -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include  -isystem /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include -no-pie     cow.c vm_util.c -lrt -lpthread  -o /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm/cow
> cow.c: In function ‘do_run_with_base_page’:
> cow.c:755:26: error: ‘MADV_PAGEOUT’ undeclared (first use in this function); did you mean ‘MADV_RANDOM’?
>     madvise(mem, pagesize, MADV_PAGEOUT);
>                            ^~~~~~~~~~~~
>                            MADV_RANDOM
> cow.c:755:26: note: each undeclared identifier is reported only once for each function it appears in
> cow.c: In function ‘do_run_with_thp’:
> cow.c:914:22: error: ‘MADV_PAGEOUT’ undeclared (first use in this function); did you mean ‘MADV_RANDOM’?
>     madvise(mem, size, MADV_PAGEOUT);
>                        ^~~~~~~~~~~~
>                        MADV_RANDOM
> make: *** [../lib.mk:145: /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm/cow] Error 1
> [root@pc-mtodorov vm]#
> 
> MADV_PAGEOUT is defined in #include <asm-generic/mman-common.h> :
> 
> [root@pc-mtodorov vm]# grep MADV_PAGEOUT -r /usr/include
> /usr/include/asm-generic/mman-common.h:#define MADV_PAGEOUT     21              /* reclaim these pages */
> [root@pc-mtodorov vm]# grep MADV_PAGEOUT -r ../../../../usr/include
> ../../../../usr/include/asm-generic/mman-common.h:#define MADV_PAGEOUT  21              /* reclaim these pages */
> [root@pc-mtodorov vm]#
> 
> However, gcc -E shows that asm-generic/mman-common.h is somehow never included:
> 
> ---------------------------------------------------------------------------------------------
> [root@pc-mtodorov vm]# gcc -Wall -E -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../.. -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include  -isystem /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include -no-pie     cow.c | cat -s | less
> # 1 "/usr/include/sys/mman.h" 1 3 4
> # 25 "/usr/include/sys/mman.h" 3 4
> # 1 "/usr/lib/gcc/x86_64-redhat-linux/8/include/stddef.h" 1 3 4
> # 26 "/usr/include/sys/mman.h" 2 3 4
> # 41 "/usr/include/sys/mman.h" 3 4
> # 1 "/usr/include/bits/mman.h" 1 3 4
> # 49 "/usr/include/bits/mman.h" 3 4
> # 1 "/usr/include/bits/mman-linux.h" 1 3 4
> # 117 "/usr/include/bits/mman-linux.h" 3 4
> # 1 "/usr/include/bits/mman-shared.h" 1 3 4
> # 42 "/usr/include/bits/mman-shared.h" 3 4
> 
> int memfd_create (const char *__name, unsigned int __flags) __attribute__ ((__nothrow__ , __leaf__));
> int mlock2 (const void *__addr, size_t __length, unsigned int __flags) __attribute__ ((__nothrow__ , __leaf__));
> int pkey_alloc (unsigned int __flags, unsigned int __access_rights) __attribute__ ((__nothrow__ , __leaf__));
> int pkey_set (int __key, unsigned int __access_rights) __attribute__ ((__nothrow__ , __leaf__));
> int pkey_get (int __key) __attribute__ ((__nothrow__ , __leaf__));
> int pkey_free (int __key) __attribute__ ((__nothrow__ , __leaf__));
> int pkey_mprotect (void *__addr, size_t __len, int __prot, int __pkey) __attribute__ ((__nothrow__ , __leaf__));
> 
> # 117 "/usr/include/bits/mman-linux.h" 2 3 4
> # 49 "/usr/include/bits/mman.h" 2 3 4
> # 42 "/usr/include/sys/mman.h" 2 3 4
> 
> # 57 "/usr/include/sys/mman.h" 3 4
> extern void *mmap (void *__addr, size_t __len, int __prot,
>       int __flags, int __fd, __off_t __offset) __attribute__ ((__nothrow__ , __leaf__));
> # 70 "/usr/include/sys/mman.h" 3 4
> extern void *mmap64 (void *__addr, size_t __len, int __prot,
>         int __flags, int __fd, __off64_t __offset) __attribute__ ((__nothrow__ , __leaf__));
> 
> extern int munmap (void *__addr, size_t __len) __attribute__ ((__nothrow__ , __leaf__));
> extern int mprotect (void *__addr, size_t __len, int __prot) __attribute__ ((__nothrow__ , __leaf__));
> extern int msync (void *__addr, size_t __len, int __flags);
> extern int madvise (void *__addr, size_t __len, int __advice) __attribute__ ((__nothrow__ , __leaf__));
> extern int posix_madvise (void *__addr, size_t __len, int __advice) __attribute__ ((__nothrow__ , __leaf__));
> extern int mlock (const void *__addr, size_t __len) __attribute__ ((__nothrow__ , __leaf__));
> extern int munlock (const void *__addr, size_t __len) __attribute__ ((__nothrow__ , __leaf__));
> extern int mlockall (int __flags) __attribute__ ((__nothrow__ , __leaf__));
> extern int munlockall (void) __attribute__ ((__nothrow__ , __leaf__));
> extern int mincore (void *__start, size_t __len, unsigned char *__vec)
>       __attribute__ ((__nothrow__ , __leaf__));
> 
> # 133 "/usr/include/sys/mman.h" 3 4
> 
> extern void *mremap (void *__addr, size_t __old_len, size_t __new_len,
>         int __flags, ...) __attribute__ ((__nothrow__ , __leaf__));
> extern int remap_file_pages (void *__start, size_t __size, int __prot,
>          size_t __pgoff, int __flags) __attribute__ ((__nothrow__ , __leaf__));
> extern int shm_open (const char *__name, int __oflag, mode_t __mode);
> extern int shm_unlink (const char *__name);
> -------------------------------------------------------------------------------------------------------
> 
> FYI:
> 
> On the platform:
> 
> - Ubuntu 22.10 kinetic kudu
> - gcc 12.2.0
> - same 6.2-rc2
> 
> , MADV_PAGEOUT is also defined in bits/mmap-linux.h, so the compile passes.
> 
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# grep MADV_PAGEOUT -r /usr/include
> /usr/include/asm-generic/mman-common.h:#define MADV_PAGEOUT	21		/* reclaim these pages */
> /usr/include/x86_64-linux-gnu/bits/mman-linux.h:# define MADV_PAGEOUT     21	/* Reclaim these pages.  */
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# grep MADV_PAGEOUT -r ../../../../usr/include
> ../../../../usr/include/asm-generic/mman-common.h:#define MADV_PAGEOUT	21		/* reclaim these pages */
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm#
> 
> However, mman-common.h from ../../../../usr/include/asm-generic/mman-common.h is also not included,
> as of "gcc -E", but only bits/mman-linux.h:
> 
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# gcc -Wall -E -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../.. -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include  -isystem /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include -no-pie     cow.c | grep mman-common.h
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm# gcc -Wall -E -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../.. -I /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include  -isystem /home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/../../../usr/include -no-pie     cow.c | grep mman-linux.h
> # 1 "/usr/include/x86_64-linux-gnu/bits/mman-linux.h" 1 3 4
> # 119 "/usr/include/x86_64-linux-gnu/bits/mman-linux.h" 3 4
> # 120 "/usr/include/x86_64-linux-gnu/bits/mman-linux.h" 2 3 4
> root@marvin-IdeaPad-3-15ITL6:/home/marvin/linux/kernel/linux_torvalds/tools/testing/selftests/vm#
> 
> I hope this is enough information for you to debug the issue.
> 
> I am standing by for any additional diagnostics needed.

Won't userfaultfd.c fail in a similar way?

Anyhow, khugepaged.c jas

#ifndef MADV_PAGEOUT
#define MADV_PAGEOUT 21
#endif

So most probably we should do the same.

-- 
Thanks,

David / dhildenb

