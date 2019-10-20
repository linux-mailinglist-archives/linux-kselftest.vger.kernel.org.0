Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA0DDE27
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2019 12:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfJTKxO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Oct 2019 06:53:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36174 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfJTKxN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Oct 2019 06:53:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so6527447pfr.3
        for <linux-kselftest@vger.kernel.org>; Sun, 20 Oct 2019 03:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bKM5y0FSlBDTRr4/tWOB4YlFlxcPulNfGqtH/1E2b/0=;
        b=ZzgoWVszIhuWBfbzlPnhpcMCcDkdDAsDGP2KB7us4QGZiADkIBYH8ySql5++8OZ25i
         0eCCHpjBgDv6vKEoMCSuZO99Dj6S7O7iyEoqXmzE6FbGe+bxvt5p9MOwe21MSp8aZrXL
         C82XBL2woLEQL2MCpuyUPA9Se/73iJwrFtuCRS8aqu7S/ZGUbW0olXB6RdJG7wmxrEd5
         TcileZwqVgl6j/Ia7qQGpCMk/kAG2I7F515EHB72JVxL+XdVLUIqj8y9E0K3W6/A55to
         vDsnKWzUHZyrAlCBb6yvKrUbKcU9lSm55mXskpw4lOsvPiUKsTxe4/IfsL90OTnQ3ugp
         mjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bKM5y0FSlBDTRr4/tWOB4YlFlxcPulNfGqtH/1E2b/0=;
        b=V2heSJaYTGqfEKeBkXPZl1pPu09nDKe/cVPlS8cNjKuhFQeyJmTX4pw+F5OIZ5+dvW
         uQ178wbAztO6uu32tFZ2AbgSpXKNrgJUvoE1zyCTwDV4nOEjV1NZMXEpCwkOdkesgrc4
         aXEVmZ+Ws/T0nG1X2M8Z96IbC2TXiaaE/NrhWCjrrf36cmlO62b6XDo+mBduJy3TpYGW
         1WF0CMMBCZqRB/cfdGpGX7bsCJZID/y5+e1SHbWeK+CRs3a5pIwpgU5Cuv6E07q0Hxl3
         5ug5+kxxiXISyFMoJ/yhNLoWrx5Slz3Atf3u+umOFjekGpf1j0rzvVqxkvEXDMoEGn4E
         ZJQg==
X-Gm-Message-State: APjAAAWkKFUGUYKxgkT/QcPr+jpeaPPHLxdvy/7TFoSxUlI6JuDloNnJ
        3EOd4wyYGGC60wCofyPyQVAOgBkQ
X-Google-Smtp-Source: APXvYqzeqj8J1aVqsDqvyxspCwRYpaBM7WLbBr4KKeh2hXWzp+DYUbrD3/geReaMqhd16K5hjQVquQ==
X-Received: by 2002:a63:5909:: with SMTP id n9mr20276062pgb.101.1571568792510;
        Sun, 20 Oct 2019 03:53:12 -0700 (PDT)
Received: from [192.168.43.140] ([157.45.233.6])
        by smtp.gmail.com with ESMTPSA id m34sm10344390pgb.91.2019.10.20.03.53.10
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 03:53:12 -0700 (PDT)
To:     linux-kselftest@vger.kernel.org
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Subject: Linux-5.4-rc3+: bpf: progs/test_core_reloc_ints.c:32:6: error: using
 builtin_preserve_access_index() without -g
Message-ID: <ba21e159-5560-73c1-ce66-b224b3a3300a@gmail.com>
Date:   Sun, 20 Oct 2019 16:23:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi All,

I am trying to build kselftest on Linux-5.4-rc3+ on ubuntu 18.04. I 
installed LLVM-9.0.0 and Clang-9.0.0 from below links after following 
steps from [1] because of discussion [2]

  https://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz
  https://releases.llvm.org/9.0.0/clang-tools-extra-9.0.0.src.tar.xz
  https://releases.llvm.org/9.0.0/cfe-9.0.0.src.tar.xz


After that I started this error.
make[2]: Leaving directory '/usr/src/tovards/linux/tools/lib/bpf'
(clang -I. -I./include/uapi -I../../../include/uapi 
-I/usr/src/tovards/linux/tools/testing/selftests/bpf/../usr/include 
-D__TARGET_ARCH_arm64 -idirafter /usr/local/include -idirafter 
/usr/local/lib/clang/9.0.0/include -idirafter 
/usr/include/aarch64-linux-gnu -idirafter /usr/include 
-Wno-compare-distinct-pointer-types -O2 -target bpf -emit-llvm \
	-c progs/test_core_reloc_ints.c -o - || echo "clang failed") | \
llc -march=arm64 -mcpu=generic  -filetype=obj -o 
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_ints.o
progs/test_core_reloc_ints.c:32:6: error: using 
builtin_preserve_access_index() without -g
         if (BPF_CORE_READ(&out->u8_field, &in->u8_field) ||
             ^
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^
progs/test_core_reloc_ints.c:33:6: error: using 
builtin_preserve_access_index() without -g
             BPF_CORE_READ(&out->s8_field, &in->s8_field) ||
             ^
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^
progs/test_core_reloc_ints.c:34:6: error: using 
builtin_preserve_access_index() without -g
             BPF_CORE_READ(&out->u16_field, &in->u16_field) ||
             ^
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^
progs/test_core_reloc_ints.c:35:6: error: using 
builtin_preserve_access_index() without -g
             BPF_CORE_READ(&out->s16_field, &in->s16_field) ||
             ^
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^
progs/test_core_reloc_ints.c:36:6: error: using 
builtin_preserve_access_index() without -g
             BPF_CORE_READ(&out->u32_field, &in->u32_field) ||
             ^
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^
progs/test_core_reloc_ints.c:37:6: error: using 
builtin_preserve_access_index() without -g
             BPF_CORE_READ(&out->s32_field, &in->s32_field) ||
             ^
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^
progs/test_core_reloc_ints.c:38:6: error: using 
builtin_preserve_access_index() without -g
             BPF_CORE_READ(&out->u64_field, &in->u64_field) ||
             ^
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^
progs/test_core_reloc_ints.c:39:6: error: using 
builtin_preserve_access_index() without -g
             BPF_CORE_READ(&out->s64_field, &in->s64_field))
             ^
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^
8 errors generated.
llc: error: llc: <stdin>:1:1: error: expected top-level entity
clang failed


In order to solve this error, I modifed bpf/Makefile as
  CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
-              -Wno-compare-distinct-pointer-types
+              -Wno-compare-distinct-pointer-types -g


Now I am getting this error

(clang -I. -I./include/uapi -I../../../include/uapi 
-I/usr/src/tovards/linux/tools/testing/selftests/bpf/../usr/include 
-D__TARGET_ARCH_arm64 -idirafter /usr/local/include -idirafter 
/usr/local/lib/clang/9.0.0/include -idirafter 
/usr/include/aarch64-linux-gnu -idirafter /usr/include 
-Wno-compare-distinct-pointer-types -g -O2 -target bpf -emit-llvm \
	-c progs/test_core_reloc_ints.c -o - || echo "clang failed") | \
llc -march=arm64 -mcpu=generic  -filetype=obj -o 
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_ints.o
LLVM ERROR: Cannot select: intrinsic %llvm.preserve.struct.access.index
Makefile:267: recipe for target 
'/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_ints.o' 
failed
make[1]: *** 
[/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_ints.o] 
Error 1


Please suggest!!


--prabhakar(pk)

[1] 
https://stackoverflow.com/questions/47255526/how-to-build-the-latest-clang-tidy

[2] https://www.mail-archive.com/netdev@vger.kernel.org/msg315096.html


Linux top-commit
----------------
commit bc88f85c6c09306bd21917e1ae28205e9cd775a7 (HEAD -> master, 
origin/master, origin/HEAD)
Author: Ben Dooks <ben.dooks@codethink.co.uk>
Date:   Wed Oct 16 12:24:58 2019 +0100

     kthread: make __kthread_queue_delayed_work static

     The __kthread_queue_delayed_work is not exported so
     make it static, to avoid the following sparse warning:

       kernel/kthread.c:869:6: warning: symbol 
'__kthread_queue_delayed_work' was not declared. Should it be static?

     Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
