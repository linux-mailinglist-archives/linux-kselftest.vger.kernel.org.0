Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 257CEDE2CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 05:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfJUDvD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Oct 2019 23:51:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42990 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfJUDvD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Oct 2019 23:51:03 -0400
Received: by mail-io1-f66.google.com with SMTP id i26so4860069iog.9
        for <linux-kselftest@vger.kernel.org>; Sun, 20 Oct 2019 20:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IiUoOVJjKHbJD/fuh8Nl/k9b7cpxV26h2CVO8WKqmSQ=;
        b=UN1RQAjgBWWs5o1YbEmQtPns9UZDof/5CDCz8oOq/Sj4XFaaNGa/pUwfooS6gHjMN+
         W3VW7D9jHXozF8txyckwo8z7/D5l0WxzIft4lCiu5Bf+LSR12HS+15zLc6ZGVdylTEse
         sO4oqErZXZL/RhOYmKW9a1fvx747fZ88OgmjGhxhNiKd7SxTLW1CuFxRyf330uMV9E+f
         2lWvkWp4j4h07GDBBT0e0u6Y3O/cEisNAtJ3pfNlt11Xe+t8cdBBp+i4A6AfEbreZjej
         aTH9Txz+OoxZ/BEicuwCsofBODCcy1rPykDijdOE+P+e8pA0jAeIzl/YBmTnQbVI6UKd
         nijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IiUoOVJjKHbJD/fuh8Nl/k9b7cpxV26h2CVO8WKqmSQ=;
        b=K6nlXjBB5UerdR0xcf0sxWB4RV3DuO9RB97MM5/G7MXh8n7Tftj3OP6zL8/vkTlON+
         uNUNoKbVjEIaWGNTgg+fsixH9Sg8woWZhRNAX9h23yN0Zb8rIQ+BldmOFR2XkfLwk/0H
         NxEXs43n/8XDLjLn2B6YFngd30OWysHvrncazv+UkTUzgZU6m6D/h6VsQ5WScofm1boI
         NyQE/y3+EBwIZJou0tDKwpxbfkg6gCx+IXVuIoibXOcz612AQK7iDqVh1LjYaPFhKVAC
         hTY0F3DCmdyWiWWrauTFTKW9rf9p0MZMB+J4YZ0n+FzS2dDST1dyNyfvnpQ3Prmxs6cp
         LJwA==
X-Gm-Message-State: APjAAAV1+LOjosHumFupxg27WHYxLqCr/M7uC2/5S2cdiGhu5SAC99Kg
        FruCLRGb8vNHKnoNbix6aAE5x1nz1aNuhgkMdkpFcdTc
X-Google-Smtp-Source: APXvYqyR9fDww7mc0yCztHUGkMqj7xx2LzU3uXp3qb/EyP4JsQE3ys4X+drUPX49MMDd8vF6XQmiWaq48LK20hwtRms=
X-Received: by 2002:a6b:9245:: with SMTP id u66mr5868540iod.98.1571629862182;
 Sun, 20 Oct 2019 20:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <aed8eda7-df20-069b-ea14-f06628984566@gmail.com>
In-Reply-To: <aed8eda7-df20-069b-ea14-f06628984566@gmail.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Mon, 21 Oct 2019 09:20:51 +0530
Message-ID: <CAJ2QiJK9R7EQsWOw1ugegURPZ0bBx7N1fSu_VzUjK5gxRW8A0g@mail.gmail.com>
Subject: Re: Linux-5.4: bpf: test_core_reloc_arrays.o: Segmentation fault with
 llc -march=bpf
To:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 20, 2019 at 7:18 PM Prabhakar Kushwaha
<prabhakar.pkin@gmail.com> wrote:
>
>
> Hi All,
>
> I am trying to build kselftest on Linux-5.4 on ubuntu 18.04. I installed
> LLVM-9.0.0 and Clang-9.0.0 from below links after following steps from
> [1] because of discussion [2]
>
>  https://releases.llvm.org/9.0.0/llvm-9.0.0.src.tar.xz
>  https://releases.llvm.org/9.0.0/clang-tools-extra-9.0.0.src.tar.xz
>  https://releases.llvm.org/9.0.0/cfe-9.0.0.src.tar.xz
>
>
> Now, i am trying with llc -march=bpf, with this segmentation fault is
> coming as below:
>
>
> gcc -g -Wall -O2 -I../../../include/uapi -I../../../lib
> -I../../../lib/bpf -I../../../../include/generated -DHAVE_GENHDR
> -I../../../include -Dbpf_prog_load=bpf_prog_test_load
> -Dbpf_load_program=bpf_test_load_program    test_flow_dissector.c
> /usr/src/tovards/linux/tools/testing/selftests/bpf/test_stub.o
> /usr/src/tovards/linux/tools/testing/selftests/bpf/libbpf.a -lcap -lelf
> -lrt -lpthread -o
> /usr/src/tovards/linux/tools/testing/selftests/bpf/test_flow_dissector
> gcc -g -Wall -O2 -I../../../include/uapi -I../../../lib
> -I../../../lib/bpf -I../../../../include/generated -DHAVE_GENHDR
> -I../../../include -Dbpf_prog_load=bpf_prog_test_load
> -Dbpf_load_program=bpf_test_load_program
> test_tcp_check_syncookie_user.c
> /usr/src/tovards/linux/tools/testing/selftests/bpf/test_stub.o
> /usr/src/tovards/linux/tools/testing/selftests/bpf/libbpf.a -lcap -lelf
> -lrt -lpthread -o
> /usr/src/tovards/linux/tools/testing/selftests/bpf/test_tcp_check_syncookie_user
> gcc -g -Wall -O2 -I../../../include/uapi -I../../../lib
> -I../../../lib/bpf -I../../../../include/generated -DHAVE_GENHDR
> -I../../../include -Dbpf_prog_load=bpf_prog_test_load
> -Dbpf_load_program=bpf_test_load_program    test_lirc_mode2_user.c
> /usr/src/tovards/linux/tools/testing/selftests/bpf/test_stub.o
> /usr/src/tovards/linux/tools/testing/selftests/bpf/libbpf.a -lcap -lelf
> -lrt -lpthread -o
> /usr/src/tovards/linux/tools/testing/selftests/bpf/test_lirc_mode2_user
> (clang -I. -I./include/uapi -I../../../include/uapi
> -I/usr/src/tovards/linux/tools/testing/selftests/bpf/../usr/include
> -D__TARGET_ARCH_arm64 -g -idirafter /usr/local/include -idirafter
> /usr/local/lib/clang/9.0.0/include -idirafter
> /usr/include/aarch64-linux-gnu -idirafter /usr/include
> -Wno-compare-distinct-pointer-types -O2 -target bpf -emit-llvm \
>         -c progs/test_core_reloc_arrays.c -o - || echo "clang failed") | \
> llc -march=bpf -mcpu=probe  -filetype=obj -o
> /usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o
> Stack dump:
> 0.      Program arguments: llc -march=bpf -mcpu=probe -filetype=obj -o
> /usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o
> 1.      Running pass 'Function Pass Manager' on module '<stdin>'.
> 2.      Running pass 'BPF Assembly Printer' on function '@test_core_arrays'
> #0 0x0000aaaac618db08 llvm::sys::PrintStackTrace(llvm::raw_ostream&)
> (/usr/local/bin/llc+0x152eb08)
> Segmentation fault
> Makefile:260: recipe for target
> '/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o'
> failed
> make[1]: ***
> [/usr/src/tovards/linux/tools/testing/selftests/bpf/test_core_reloc_arrays.o]
> Error 139
>

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

--prabhakar (pk)
