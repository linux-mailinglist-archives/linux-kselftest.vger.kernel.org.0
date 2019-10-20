Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE0DDEBB
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2019 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfJTNsJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Oct 2019 09:48:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45077 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfJTNsJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Oct 2019 09:48:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so5997997pgj.12
        for <linux-kselftest@vger.kernel.org>; Sun, 20 Oct 2019 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YbZJtbBn212YfofzuyIr+q6nNXooEsiDp3NOJmUzGgo=;
        b=Fd206ECqMc22daDNFciXCMJp76Ue1kqmK5GXbDBGwN4+qziPuN+iAQvnpkl6ps1Xzo
         fGBBP7GM6uYRof6SzeIvsyEIhCj7V7rarRu4M4MCnfrIXai5mvVCVA9hjwTp5YuvA0U9
         gCXVzw98+PQBxzg9YiD68MynxLx67smhVlNtsOMjpkNpU8/mQHDadwxRFw3nVzPKtXFK
         1HbDEQq38VEjkJp3mk+SBMGt5YLlk5PGrsnFDaFXGyKpWnhLX1Ui5i5hXNw3z9mM8Lpt
         TKvsHfup1T7K+dPOU/j5DMHqQV4XzTZMkV780dRtFNbRZuLmvZOQ2nbkrygehq99z3Tv
         pVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YbZJtbBn212YfofzuyIr+q6nNXooEsiDp3NOJmUzGgo=;
        b=j8sKbS/znsRg29XQzEzSb2qiK0cAyjpY4C9o1iZR6Lefv9e3m60pVwrkWxTBaUBmrX
         1qS+Wq1KpyKQ6PzOZtuB7B63O+8L5VOrOqEcU45ss5ZxT25jZ8UUb7IBHsvdi2cdkJwx
         xK2eXfAogllBZRPuPzf5zIT80nKmzLPNxG9nFUFm0EIuvJ9LyfUuLJygKfL+1yLHwR45
         9tYyIja3qykcFhB+V6y/12U4qrBv7ixj1LELOm57Wap+WbQ2RyeEjYRv1sxSmc8Fli4L
         zbcZphlIHhq3gb2t8CPV2uBdDoi8ND+ag0tBXT3TRJwjZQ7zNAFdPdee1SxZKBgAm7w/
         Lj0g==
X-Gm-Message-State: APjAAAV16amUsx8XJmdcWl1VD3a3ielx+YBi7udOYNOGdqq4xJoppgqf
        FA9YDqb+w0Cne3xdrKakHjQXhMrd
X-Google-Smtp-Source: APXvYqzW4a5tApHDuyaRmr5Iu4hwkshdAqgqapbjBKMzXOxqp/jbnUL/Q1sQBM3/x1dCdMadrXrN6g==
X-Received: by 2002:a17:90a:c406:: with SMTP id i6mr22394045pjt.98.1571579288419;
        Sun, 20 Oct 2019 06:48:08 -0700 (PDT)
Received: from [192.168.43.140] ([157.45.251.251])
        by smtp.gmail.com with ESMTPSA id x10sm11128453pgl.53.2019.10.20.06.48.06
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 06:48:08 -0700 (PDT)
To:     linux-kselftest@vger.kernel.org
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Subject: Linux-5.4: bpf: test_core_reloc_arrays.o: Segmentation fault with llc
 -march=bpf
Message-ID: <aed8eda7-df20-069b-ea14-f06628984566@gmail.com>
Date:   Sun, 20 Oct 2019 19:17:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hi All,

I am trying to build kselftest on Linux-5.4 on ubuntu 18.04. I installed
LLVM-9.0.0 and Clang-9.0.0 from below links after following steps from
[1] because of discussion [2]

 https://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz
 https://releases.llvm.org/9.0.0/clang-tools-extra-9.0.0.src.tar.xz
 https://releases.llvm.org/9.0.0/cfe-9.0.0.src.tar.xz


Now, i am trying with llc -march=bpf, with this segmentation fault is
coming as below:


gcc -g -Wall -O2 -I../../../include/uapi -I../../../lib
-I../../../lib/bpf -I../../../../include/generated -DHAVE_GENHDR
-I../../../include -Dbpf_prog_load=bpf_prog_test_load
-Dbpf_load_program=bpf_test_load_program    test_flow_dissector.c
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_stub.o
/usr/src/tovards/linux/tools/testing/selftests/bpf/libbpf.a -lcap -lelf
-lrt -lpthread -o
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_flow_dissector
gcc -g -Wall -O2 -I../../../include/uapi -I../../../lib
-I../../../lib/bpf -I../../../../include/generated -DHAVE_GENHDR
-I../../../include -Dbpf_prog_load=bpf_prog_test_load
-Dbpf_load_program=bpf_test_load_program
test_tcp_check_syncookie_user.c
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_stub.o
/usr/src/tovards/linux/tools/testing/selftests/bpf/libbpf.a -lcap -lelf
-lrt -lpthread -o
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_tcp_check_syncookie_user
gcc -g -Wall -O2 -I../../../include/uapi -I../../../lib
-I../../../lib/bpf -I../../../../include/generated -DHAVE_GENHDR
-I../../../include -Dbpf_prog_load=bpf_prog_test_load
-Dbpf_load_program=bpf_test_load_program    test_lirc_mode2_user.c
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_stub.o
/usr/src/tovards/linux/tools/testing/selftests/bpf/libbpf.a -lcap -lelf
-lrt -lpthread -o
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_lirc_mode2_user
(clang -I. -I./include/uapi -I../../../include/uapi
-I/usr/src/tovards/linux/tools/testing/selftests/bpf/../usr/include
-D__TARGET_ARCH_arm64 -g -idirafter /usr/local/include -idirafter
/usr/local/lib/clang/9.0.0/include -idirafter
/usr/include/aarch64-linux-gnu -idirafter /usr/include
-Wno-compare-distinct-pointer-types -O2 -target bpf -emit-llvm \
	-c progs/test_core_reloc_arrays.c -o - || echo "clang failed") | \
llc -march=bpf -mcpu=probe  -filetype=obj -o
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o
Stack dump:
0.	Program arguments: llc -march=bpf -mcpu=probe -filetype=obj -o
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o
1.	Running pass 'Function Pass Manager' on module '<stdin>'.
2.	Running pass 'BPF Assembly Printer' on function '@test_core_arrays'
#0 0x0000aaaac618db08 llvm::sys::PrintStackTrace(llvm::raw_ostream&)
(/usr/local/bin/llc+0x152eb08)
Segmentation fault
Makefile:260: recipe for target
'/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o'
failed
make[1]: ***
[/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o]
Error 139



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
