Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81413663356
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 22:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjAIVmJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 16:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbjAIVl0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 16:41:26 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3786101E3;
        Mon,  9 Jan 2023 13:41:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3DB74604F3;
        Mon,  9 Jan 2023 22:41:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673300466; bh=sZ9lvcw9WnbCHVTEn1DuNrgMVYIkO/y7/LxiD8iYtOc=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=l/19ZRS6IYKIzN6yPQWrFm7qmvwq5T4hw2gt0UmS0jmySWJsoOT4T4DRglU/rDqw7
         jzD+37rDjtGHKYfCCl9657YFPeS5vypmKgPX/Qvvta/Jty9SfpuujiQ8pH//Vzg8sO
         g0pBhKPLRIKH9Fe/kp0nFLyRcniysk9F0mD/tDOBgefeSsAs/hjdJJAIF8yknxIf6k
         yt55XS5l12oxs5QqgxmL/C+M5tNSK7UsF43yuwpchBTwbehDGreaKiAK3NuM1D9YQp
         MptubijLKZwDcc4KhJVRNEJOt6VPxBjl8dWKVTCEXHLcUogUwjgc0vb6j34It4T9tM
         AGtqUOT1njQlg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HlvCOym_hQs3; Mon,  9 Jan 2023 22:41:03 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.254])
        by domac.alu.hr (Postfix) with ESMTPSA id 68681604F1;
        Mon,  9 Jan 2023 22:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673300463; bh=sZ9lvcw9WnbCHVTEn1DuNrgMVYIkO/y7/LxiD8iYtOc=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ypB+EeJwvbUN/qt35A0+SYVmjPeA47V9qFh+GGFcoPc4uWMcW6GBvlw/YFoN+dLDm
         YRh8uNIBh74BvRZ3f2ekVIDL+n44/Lf390cOXVfce3YF8dn1Nfvrt24FMASocez/57
         VW0yuOJZpQH/uc4CDXqdiaL/e6VaBEDupSeH17dGck5SWF2mFXUh1tNUit80uyfwIm
         m6H47vks9E8ACIIzlzC1FLZI9Cse4PwBAcv9J0aCeFVPE+rjwfZCLTtqgB3yZ4VP3T
         gMSSBoPgflkjIjBdB9kOyRY0845WLvy/4B2Q4Q3OwjHEkVVT7fCckV883okSKicAU/
         TRmMPj7P4HJJg==
Message-ID: <0e692e52-0a4f-3892-ed25-f3fa12892b6f@alu.unizg.hr>
Date:   Mon, 9 Jan 2023 22:41:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <0f117203-3227-cd16-61c2-2dd3de75ecc7@alu.unizg.hr>
 <0ee389dc-5e47-5b7e-4db5-637eb2b3fbc9@redhat.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Organization: Academy of Fine Arts, University of Zagreb
Subject: =?UTF-8?Q?Re=3a_PROBLEM=3a_selftest/vm/cow=2ec_failed_to_compile_?=
 =?UTF-8?B?KOKAmE1BRFZfUEFHRU9VVOKAmSB1bmRlY2xhcmVkKQ==?=
In-Reply-To: <0ee389dc-5e47-5b7e-4db5-637eb2b3fbc9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/9/2023 5:42 PM, David Hildenbrand wrote:

Hi, thank you for your reply.

>> I hope this is enough information for you to debug the issue.
>>
>> I am standing by for any additional diagnostics needed.
> 
> Won't userfaultfd.c fail in a similar way?
> 
> Anyhow, khugepaged.c jas
> 
> #ifndef MADV_PAGEOUT
> #define MADV_PAGEOUT 21
> #endif
> 
> So most probably we should do the same.

Actually, David, it turned out that userfaultfd.c compiled 
out-of-the-box, and side-by-side comparison showed that it also included 
"/home/marvin/linux/kernel/linux_torvalds/usr/include/asm-generic/mman-common.h"

The only remaining difference was including <linux/mman.h>, which fixed 
the issue w/o #ifdef ... #endif

Hope this helps.

Please find the following diff.

Regards,
Mirsad

------------------------------------------------------------------------------
diff --git a/tools/testing/selftests/vm/cow.c 
b/tools/testing/selftests/vm/cow.c
index 26f6ea3079e2..dd8cf12c6776 100644
--- a/tools/testing/selftests/vm/cow.c
+++ b/tools/testing/selftests/vm/cow.c
@@ -16,6 +16,7 @@
  #include <fcntl.h>
  #include <dirent.h>
  #include <assert.h>
+#include <linux/mman.h>
  #include <sys/mman.h>
  #include <sys/ioctl.h>
  #include <sys/wait.h>




--
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355
