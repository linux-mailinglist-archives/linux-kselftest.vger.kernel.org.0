Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB2E061F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfJVOMg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 10:12:36 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38527 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJVOMg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 10:12:36 -0400
Received: by mail-il1-f193.google.com with SMTP id y5so15556084ilb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2019 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=O7dZCTWOrq2+UdA1TYOaK7RbJt7TwU/MLybnInxFeec=;
        b=RTcbVbxJo07kvI176WXetcHehyeSE9Z0zD1h5T2pM7COApXZ8sPHjhXpkySa8oYC3L
         ca3eDg20qAb750YoRlOd8mKDL5tdI4WUxyZEyRBqSnMhgOg2XZNzCb4pjaqFDstoys+H
         ROGf7jFRPKzETE+ft7aEWvoBzoLXWHkIetORUF1uOJs5P6RRrc7i6KBrAz1r/u9taSM2
         5TWrBSezOAa5iSoSFnDCrbEwMqk9rwxZrou2NXSjGENkL2/xDB4SSHYJjmzIYed1Boyj
         lebDZb1d6v/Ye0UPtSsmSJrPB5+BeWURtFgCVgo2F1/y7+8MntM1vrhT7pK6Cq1IPBc5
         KxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O7dZCTWOrq2+UdA1TYOaK7RbJt7TwU/MLybnInxFeec=;
        b=l6MsNN9fCs3hdWoToJZqm+7sWkX1O1TBUx/CuMJoO7+Jo8VEwlvKXS63mUZOCWxmML
         nIGqp0vv1cjDl9KXkj3JZOnrflaE6STvNL32hDjS1rqyJZdSqPzgkZnGWsA+ZMSvHrLO
         Ad2vsYo6OwaUnjbFkez2gILY0lgyMBzR/T5N55RP9A//Ht4rFHdwq6ZjdU6p9C6pi7RJ
         /BBJONM5D8xCtBo2nVmLcOeG9JD5awSs/Rgmj/eY6NCbyAVJD/HVMMymIZnZMbbaGAKi
         in0OLqU63J/kq1yKVxTdXyvL+/eFxr+noqxrQFr1NMXvZltBPDHulGGxeZRnabyg8+iT
         QjxQ==
X-Gm-Message-State: APjAAAWNueyAgxt4AA8ZGiu1jtrrvSqTbAjKaOUTygR69YU2ICLHDtsx
        4cNWmgGKUOKf/2ztJrQ6q9M8Skah5feGTW3kTUPs2KVg
X-Google-Smtp-Source: APXvYqzAKcEPkBLF/zxyI/wk96huL15+3RdAUc9uWPv9zaq2tLDTcwxXxmeCVxalQZrr3OLGvd2UgVq1EuS5AYEPj8w=
X-Received: by 2002:a92:c608:: with SMTP id p8mr31332444ilm.10.1571753554485;
 Tue, 22 Oct 2019 07:12:34 -0700 (PDT)
MIME-Version: 1.0
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Tue, 22 Oct 2019 19:42:23 +0530
Message-ID: <CAJ2QiJLsHNw+K3AphnL5S9vmo+uW=N4AxURwCeMobMdftdP-qw@mail.gmail.com>
Subject: Linux-5.4: bpf: test_core_reloc_arrays.o: Segmentation fault with llc -march=bpf
To:     linux-kselftest@vger.kernel.org, llvm-bugs@lists.llvm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 Adding llvm-bugs@lists.llvm.org mailing list...

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
0. Program arguments: llc -march=bpf -mcpu=probe -filetype=obj -o
/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o
1. Running pass 'Function Pass Manager' on module '<stdin>'.
2. Running pass 'BPF Assembly Printer' on function '@test_core_arrays'
#0 0x0000aaaac618db08 llvm::sys::PrintStackTrace(llvm::raw_ostream&)
(/usr/local/bin/llc+0x152eb08)
Segmentation fault
Makefile:260: recipe for target
'/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o'
failed
make[1]: ***
[/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o]
Error 139

To add more details,
Commenting following lines in bpf/progs/test_core_reloc_arrays.c
removes the segmentation fault.

--- a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
@@ -41,15 +41,14 @@ int test_core_arrays(void *ctx)
        if (BPF_CORE_READ(&out->a2, &in->a[2]))
                return 1;
        /* in->b[1][2][3] */
-       if (BPF_CORE_READ(&out->b123, &in->b[1][2][3]))
-               return 1;
+//     if (BPF_CORE_READ(&out->b123, &in->b[1][2][3]))
+//             return 1;
        /* in->c[1].c */
        if (BPF_CORE_READ(&out->c1c, &in->c[1].c))
                return 1;
        /* in->d[0][0].d */
-       if (BPF_CORE_READ(&out->d00d, &in->d[0][0].d))
-               return 1;
-
+//     if (BPF_CORE_READ(&out->d00d, &in->d[0][0].d))
+//             return 1;
        return 0;
 }

It looks to be something related llc and more than 1 dimension array.
has anyone faced such error.

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
