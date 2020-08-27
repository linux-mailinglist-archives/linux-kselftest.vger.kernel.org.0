Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F6253CD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Aug 2020 06:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgH0Er2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Aug 2020 00:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbgH0Er0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Aug 2020 00:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598503640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdBd8++faTYtrBQah8yoCdSw1xGU0927NtwGrpZaGYs=;
        b=fnE2SQv7Xptin945ek+tGOo7JmmBn66ASv9Z6hP/Qe5zKQF6X9Tb3f3DE2YYEB2E7epCiU
        tkDQ4WrMJDGbLEnMOT3sXQif2lkyQ1dFmCCJn6GDRbFkxRwIBE2zhitLH2UZLRS0LDg0vz
        Ko1u0jJD3kcLNY4WqX/xXY3K02ItQfM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-CKxdj3j7MbS4cxym5BJHNQ-1; Thu, 27 Aug 2020 00:47:18 -0400
X-MC-Unique: CKxdj3j7MbS4cxym5BJHNQ-1
Received: by mail-il1-f200.google.com with SMTP id o1so3296398ilk.6
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Aug 2020 21:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XdBd8++faTYtrBQah8yoCdSw1xGU0927NtwGrpZaGYs=;
        b=Z/GAUM8dmPlXdU/taB6SE6Ae0ifcoglsK8ZFQBRlLra4rBtz18OV+MkYXFw406+KZK
         cuZjS/PuTEboUEOWLZHIFqWTEUDoizOLAHW13dTxA8cRyB0LazJYp9ZSVo10f0/HgwOl
         sbjDC5LfvxOhGME2oK7AWy70FIQw85cfRYPAiMzqR9Vw7+RaOcFOYqpmN5NebMSf/P7c
         T4bJHxI2pl6EvWOZSe5vFAhxT+hb/biomyKCEezONSy98Yn1PJneBJoyR79ZXTKwXd88
         4Y//vpKB6tnmqXgY7x4Kk1Q8pJoTShsaDHw19f5oeOiDz7AFhi15YfaEvXdmovKvL4Ov
         UtRw==
X-Gm-Message-State: AOAM5304Ue7Qo5UTOAG1YTywo6CIh6N+jldzGFoOwuG8UxlglBO6Xvq4
        wzd6jKk/BWbH3MgWlfQr6vhaOxSqKkcpcitAYF1I3Mm6h0xgXmS01j1YehXBUNc9Ywd/V4ZOH9f
        8O9937vfe4siTKFJn/VtFpMD6GfCJHWjPdVgp3OdOs1M3
X-Received: by 2002:a6b:f608:: with SMTP id n8mr15765910ioh.148.1598503635585;
        Wed, 26 Aug 2020 21:47:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZI8aYE78Xl2qFxBiAEm9JlrugkgZhQgh5YwfkucnQQ1un2YWz3yaZjIkcpxvBea8kMUjTf6Qy9anF3nLPdzo=
X-Received: by 2002:a6b:f608:: with SMTP id n8mr15765887ioh.148.1598503634978;
 Wed, 26 Aug 2020 21:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200716135303.276442-1-jarkko.sakkinen@linux.intel.com> <20200716135303.276442-23-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20200716135303.276442-23-jarkko.sakkinen@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Thu, 27 Aug 2020 00:47:04 -0400
Message-ID: <CAOASepO-DuQW88hxtAJv5Ki4GNYnkGNz5qK_dTEK_y8roMdPkg@mail.gmail.com>
Subject: Re: [PATCH v36 22/24] selftests/x86: Add a selftest for SGX
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        "Xing, Cedric" <cedric.xing@intel.com>, chenalexchen@google.com,
        Conrad Parker <conradparker@google.com>, cyhanish@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Neil Horman <nhorman@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 9:58 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Add a selftest for SGX. It is a trivial test where a simple enclave
> copies one 64-bit word of memory between two memory locations.
>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/sgx/.gitignore        |   2 +
>  tools/testing/selftests/sgx/Makefile          |  53 +++
>  tools/testing/selftests/sgx/call.S            |  54 +++
>  tools/testing/selftests/sgx/defines.h         |  21 +
>  tools/testing/selftests/sgx/load.c            | 282 +++++++++++++
>  tools/testing/selftests/sgx/main.c            | 199 +++++++++
>  tools/testing/selftests/sgx/main.h            |  38 ++
>  tools/testing/selftests/sgx/sigstruct.c       | 395 ++++++++++++++++++
>  tools/testing/selftests/sgx/test_encl.c       |  20 +
>  tools/testing/selftests/sgx/test_encl.lds     |  40 ++
>  .../selftests/sgx/test_encl_bootstrap.S       |  89 ++++
>  12 files changed, 1194 insertions(+)
>  create mode 100644 tools/testing/selftests/sgx/.gitignore
>  create mode 100644 tools/testing/selftests/sgx/Makefile
>  create mode 100644 tools/testing/selftests/sgx/call.S
>  create mode 100644 tools/testing/selftests/sgx/defines.h
>  create mode 100644 tools/testing/selftests/sgx/load.c
>  create mode 100644 tools/testing/selftests/sgx/main.c
>  create mode 100644 tools/testing/selftests/sgx/main.h
>  create mode 100644 tools/testing/selftests/sgx/sigstruct.c
>  create mode 100644 tools/testing/selftests/sgx/test_encl.c
>  create mode 100644 tools/testing/selftests/sgx/test_encl.lds
>  create mode 100644 tools/testing/selftests/sgx/test_encl_bootstrap.S
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 1195bd85af38..ec7be6d5a10d 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -64,6 +64,7 @@ TARGETS +=3D user
>  TARGETS +=3D vm
>  TARGETS +=3D x86
>  TARGETS +=3D zram
> +TARGETS +=3D sgx
>  #Please keep the TARGETS list alphabetically sorted
>  # Run "make quicktest=3D1 run_tests" or
>  # "make quicktest=3D1 kselftest" from top level Makefile
> diff --git a/tools/testing/selftests/sgx/.gitignore b/tools/testing/selft=
ests/sgx/.gitignore
> new file mode 100644
> index 000000000000..fbaf0bda9a92
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/.gitignore
> @@ -0,0 +1,2 @@
> +test_sgx
> +test_encl.elf
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftes=
ts/sgx/Makefile
> new file mode 100644
> index 000000000000..95e5c4df8014
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -0,0 +1,53 @@
> +top_srcdir =3D ../../../..
> +
> +include ../lib.mk
> +
> +.PHONY: all clean
> +
> +CAN_BUILD_X86_64 :=3D $(shell ../x86/check_cc.sh $(CC) \
> +                           ../x86/trivial_64bit_program.c)
> +
> +ifndef OBJCOPY
> +OBJCOPY :=3D $(CROSS_COMPILE)objcopy
> +endif
> +
> +INCLUDES :=3D -I$(top_srcdir)/tools/include
> +HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
> +ENCL_CFLAGS :=3D -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
> +              -fno-stack-protector -mrdrnd $(INCLUDES)
> +
> +TEST_CUSTOM_PROGS :=3D $(OUTPUT)/test_sgx $(OUTPUT)/test_encl.elf
> +
> +ifeq ($(CAN_BUILD_X86_64), 1)
> +all: $(TEST_CUSTOM_PROGS)
> +endif
> +
> +$(OUTPUT)/test_sgx: $(OUTPUT)/main.o \
> +                   $(OUTPUT)/load.o \
> +                   $(OUTPUT)/sigstruct.o \
> +                   $(OUTPUT)/call.o
> +       $(CC) $(HOST_CFLAGS) -o $@ $^ -lcrypto
> +
> +$(OUTPUT)/main.o: main.c
> +       $(CC) $(HOST_CFLAGS) -c $< -o $@
> +
> +$(OUTPUT)/load.o: load.c
> +       $(CC) $(HOST_CFLAGS) -c $< -o $@
> +
> +$(OUTPUT)/sigstruct.o: sigstruct.c
> +       $(CC) $(HOST_CFLAGS) -c $< -o $@
> +
> +$(OUTPUT)/call.o: call.S
> +       $(CC) $(HOST_CFLAGS) -c $< -o $@
> +
> +$(OUTPUT)/test_encl.elf: test_encl.lds test_encl.c test_encl_bootstrap.S
> +       $(CC) $(ENCL_CFLAGS) -T $^ -o $@
> +
> +EXTRA_CLEAN :=3D \
> +       $(OUTPUT)/test_encl.elf \
> +       $(OUTPUT)/load.o \
> +       $(OUTPUT)/call.o \
> +       $(OUTPUT)/main.o \
> +       $(OUTPUT)/sigstruct.o \
> +       $(OUTPUT)/test_sgx \
> +       $(OUTPUT)/test_sgx.o \
> diff --git a/tools/testing/selftests/sgx/call.S b/tools/testing/selftests=
/sgx/call.S
> new file mode 100644
> index 000000000000..77131e83db42
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/call.S
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/**
> +* Copyright(c) 2016-18 Intel Corporation.
> +*/
> +
> +       .text
> +
> +       .macro ENCLU
> +       .byte 0x0f, 0x01, 0xd7
> +       .endm
> +
> +       .text
> +
> +       .global sgx_call_vdso
> +sgx_call_vdso:
> +       .cfi_startproc
> +       push    %r15
> +       .cfi_adjust_cfa_offset  8
> +       .cfi_rel_offset         %r15, 0
> +       push    %r14
> +       .cfi_adjust_cfa_offset  8
> +       .cfi_rel_offset         %r14, 0
> +       push    %r13
> +       .cfi_adjust_cfa_offset  8
> +       .cfi_rel_offset         %r13, 0
> +       push    %r12
> +       .cfi_adjust_cfa_offset  8
> +       .cfi_rel_offset         %r12, 0
> +       push    %rbx
> +       .cfi_adjust_cfa_offset  8
> +       .cfi_rel_offset         %rbx, 0
> +       push    $0
> +       .cfi_adjust_cfa_offset  8
> +       push    0x48(%rsp)
> +       .cfi_adjust_cfa_offset  8
> +       push    0x48(%rsp)
> +       .cfi_adjust_cfa_offset  8
> +       push    0x48(%rsp)
> +       .cfi_adjust_cfa_offset  8
> +       call    *eenter(%rip)
> +       add     $0x20, %rsp
> +       .cfi_adjust_cfa_offset  -0x20
> +       pop     %rbx
> +       .cfi_adjust_cfa_offset  -8
> +       pop     %r12
> +       .cfi_adjust_cfa_offset  -8
> +       pop     %r13
> +       .cfi_adjust_cfa_offset  -8
> +       pop     %r14
> +       .cfi_adjust_cfa_offset  -8
> +       pop     %r15
> +       .cfi_adjust_cfa_offset  -8
> +       ret
> +       .cfi_endproc
> diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selfte=
sts/sgx/defines.h
> new file mode 100644
> index 000000000000..be8969922804
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/defines.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright(c) 2016-19 Intel Corporation.
> + */
> +
> +#ifndef DEFINES_H
> +#define DEFINES_H
> +
> +#include <stdint.h>
> +
> +#define PAGE_SIZE 4096
> +#define PAGE_MASK (~(PAGE_SIZE - 1))
> +
> +#define __aligned(x) __attribute__((__aligned__(x)))
> +#define __packed __attribute__((packed))
> +
> +#include "../../../../arch/x86/kernel/cpu/sgx/arch.h"
> +#include "../../../../arch/x86/include/asm/enclu.h"
> +#include "../../../../arch/x86/include/uapi/asm/sgx.h"
> +
> +#endif /* DEFINES_H */
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests=
/sgx/load.c
> new file mode 100644
> index 000000000000..91407036541c
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +// Copyright(c) 2016-18 Intel Corporation.
> +
> +#include <assert.h>
> +#include <elf.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include "defines.h"
> +#include "main.h"
> +
> +void encl_delete(struct encl *encl)
> +{
> +       if (encl->encl_base)
> +               munmap((void *)encl->encl_base, encl->encl_size);
> +
> +       if (encl->bin)
> +               munmap(encl->bin, encl->bin_size);
> +
> +       if (encl->fd)
> +               close(encl->fd);
> +
> +       if (encl->segment_tbl)
> +               free(encl->segment_tbl);
> +
> +       memset(encl, 0, sizeof(*encl));
> +}
> +
> +static bool encl_map_bin(const char *path, struct encl *encl)
> +{
> +       struct stat sb;
> +       void *bin;
> +       int ret;
> +       int fd;
> +
> +       fd =3D open(path, O_RDONLY);
> +       if (fd =3D=3D -1)  {
> +               perror("open()");
> +               return false;
> +       }
> +
> +       ret =3D stat(path, &sb);
> +       if (ret) {
> +               perror("stat()");
> +               goto err;
> +       }
> +
> +       bin =3D mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +       if (bin =3D=3D MAP_FAILED) {
> +               perror("mmap()");
> +               goto err;
> +       }
> +
> +       encl->bin =3D bin;
> +       encl->bin_size =3D sb.st_size;
> +
> +       close(fd);
> +       return true;
> +
> +err:
> +       close(fd);
> +       return false;
> +}
> +
> +static bool encl_ioc_create(struct encl *encl)
> +{
> +       struct sgx_secs *secs =3D &encl->secs;
> +       struct sgx_enclave_create ioc;
> +       int rc;
> +
> +       assert(encl->encl_base !=3D 0);
> +
> +       memset(secs, 0, sizeof(*secs));
> +       secs->ssa_frame_size =3D 1;
> +       secs->attributes =3D SGX_ATTR_MODE64BIT;
> +       secs->xfrm =3D 3;
> +       secs->base =3D encl->encl_base;
> +       secs->size =3D encl->encl_size;
> +
> +       ioc.src =3D (unsigned long)secs;
> +       rc =3D ioctl(encl->fd, SGX_IOC_ENCLAVE_CREATE, &ioc);
> +       if (rc) {
> +               fprintf(stderr, "SGX_IOC_ENCLAVE_CREATE failed: errno=3D%=
d\n",
> +                       errno);
> +               munmap((void *)secs->base, encl->encl_size);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *s=
eg)
> +{
> +       struct sgx_enclave_add_pages ioc;
> +       struct sgx_secinfo secinfo;
> +       int rc;
> +
> +       memset(&secinfo, 0, sizeof(secinfo));
> +       secinfo.flags =3D seg->flags;
> +
> +       ioc.src =3D (uint64_t)encl->src + seg->offset;
> +       ioc.offset =3D seg->offset;
> +       ioc.length =3D seg->size;
> +       ioc.secinfo =3D (unsigned long)&secinfo;
> +       ioc.flags =3D SGX_PAGE_MEASURE;
> +
> +       rc =3D ioctl(encl->fd, SGX_IOC_ENCLAVE_ADD_PAGES, &ioc);
> +       if (rc) {
> +               fprintf(stderr, "SGX_IOC_ENCLAVE_ADD_PAGES failed: errno=
=3D%d.\n",
> +                       errno);
> +               return false;
> +       }
> +
> +       if (ioc.count !=3D ioc.length) {
> +               fprintf(stderr, "A segment not fully processed.\n");
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +bool encl_load(const char *path, struct encl *encl)
> +{
> +       Elf64_Phdr *phdr_tbl;
> +       off_t src_offset;
> +       Elf64_Ehdr *ehdr;
> +       int i, j;
> +       int ret;
> +
> +       memset(encl, 0, sizeof(*encl));
> +
> +       ret =3D open("/dev/sgx/enclave", O_RDWR);
> +       if (ret < 0) {
> +               fprintf(stderr, "Unable to open /dev/sgx\n");
> +               goto err;
> +       }
> +
> +       encl->fd =3D ret;
> +
> +       if (!encl_map_bin(path, encl))
> +               goto err;
> +
> +       ehdr =3D encl->bin;
> +       phdr_tbl =3D encl->bin + ehdr->e_phoff;
> +
> +       for (i =3D 0; i < ehdr->e_phnum; i++) {
> +               Elf64_Phdr *phdr =3D &phdr_tbl[i];
> +
> +               if (phdr->p_type =3D=3D PT_LOAD)
> +                       encl->nr_segments++;
> +       }
> +
> +       encl->segment_tbl =3D calloc(encl->nr_segments,
> +                                  sizeof(struct encl_segment));
> +       if (!encl->segment_tbl)
> +               goto err;
> +
> +       for (i =3D 0, j =3D 0; i < ehdr->e_phnum; i++) {
> +               Elf64_Phdr *phdr =3D &phdr_tbl[i];
> +               unsigned int flags =3D phdr->p_flags;
> +               struct encl_segment *seg;
> +
> +               if (phdr->p_type !=3D PT_LOAD)
> +                       continue;
> +
> +               seg =3D &encl->segment_tbl[j];
> +
> +               if (!!(flags & ~(PF_R | PF_W | PF_X))) {
> +                       fprintf(stderr,
> +                               "%d has invalid segment flags 0x%02x.\n",=
 i,
> +                               phdr->p_flags);
> +                       goto err;
> +               }
> +
> +               if (j =3D=3D 0 && flags !=3D (PF_R | PF_W)) {
> +                       fprintf(stderr,
> +                               "TCS has invalid segment flags 0x%02x.\n"=
,
> +                               phdr->p_flags);
> +                       goto err;
> +               }
> +
> +               if (j =3D=3D 0) {
> +                       src_offset =3D (phdr->p_offset & PAGE_MASK) - src=
_offset;
> +
> +                       seg->prot =3D PROT_READ | PROT_WRITE;
> +                       seg->flags =3D SGX_PAGE_TYPE_TCS << 8;
> +               } else  {
> +                       seg->prot =3D (phdr->p_flags & PF_R) ? PROT_READ =
: 0;
> +                       seg->prot |=3D (phdr->p_flags & PF_W) ? PROT_WRIT=
E : 0;
> +                       seg->prot |=3D (phdr->p_flags & PF_X) ? PROT_EXEC=
 : 0;
> +                       seg->flags =3D (SGX_PAGE_TYPE_REG << 8) | seg->pr=
ot;
> +               }
> +
> +               seg->offset =3D (phdr->p_offset & PAGE_MASK) - src_offset=
;
> +               seg->size =3D (phdr->p_filesz + PAGE_SIZE - 1) & PAGE_MAS=
K;
> +
> +               printf("0x%016lx 0x%016lx 0x%02x\n", seg->offset, seg->si=
ze,
> +                      seg->prot);
> +
> +               j++;
> +       }
> +
> +       assert(j =3D=3D encl->nr_segments);
> +
> +       encl->src =3D encl->bin + src_offset;
> +       encl->src_size =3D encl->segment_tbl[j - 1].offset +
> +                        encl->segment_tbl[j - 1].size;
> +
> +       for (encl->encl_size =3D 4096; encl->encl_size < encl->src_size; =
)
> +               encl->encl_size <<=3D 1;
> +
> +       return true;
> +
> +err:
> +       encl_delete(encl);
> +       return false;
> +}
> +
> +static bool encl_map_area(struct encl *encl)
> +{
> +       size_t encl_size =3D encl->encl_size;
> +       void *area;
> +
> +       area =3D mmap(NULL, encl_size * 2, PROT_NONE,
> +                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       if (area =3D=3D MAP_FAILED) {
> +               perror("mmap");
> +               return false;
> +       }
> +
> +       encl->encl_base =3D ((uint64_t)area + encl_size - 1) & ~(encl_siz=
e - 1);
> +
> +       munmap(area, encl->encl_base - (uint64_t)area);
> +       munmap((void *)(encl->encl_base + encl_size),
> +              (uint64_t)area + encl_size - encl->encl_base);
> +
> +       return true;
> +}
> +
> +bool encl_build(struct encl *encl)
> +{
> +       struct sgx_enclave_init ioc;
> +       int ret;
> +       int i;
> +
> +       if (!encl_map_area(encl))
> +               return false;
> +
> +       if (!encl_ioc_create(encl))
> +               return false;
> +
> +       /*
> +        * Pages must be added before mapping VMAs because their permissi=
ons
> +        * cap the VMA permissions.
> +        */
> +       for (i =3D 0; i < encl->nr_segments; i++) {
> +               struct encl_segment *seg =3D &encl->segment_tbl[i];
> +
> +               if (!encl_ioc_add_pages(encl, seg))
> +                       return false;
> +       }
> +
> +       ioc.sigstruct =3D (uint64_t)&encl->sigstruct;
> +       ret =3D ioctl(encl->fd, SGX_IOC_ENCLAVE_INIT, &ioc);
> +       if (ret) {
> +               fprintf(stderr, "SGX_IOC_ENCLAVE_INIT failed: errno=3D%d\=
n",
> +                       errno);
> +               return false;
> +       }
> +
> +       return true;
> +}
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests=
/sgx/main.c
> new file mode 100644
> index 000000000000..8d95569e7a66
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +// Copyright(c) 2016-18 Intel Corporation.
> +
> +#include <elf.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include "defines.h"
> +#include "main.h"
> +
> +static const uint64_t MAGIC =3D 0x1122334455667788ULL;
> +vdso_sgx_enter_enclave_t eenter;
> +
> +struct vdso_symtab {
> +       Elf64_Sym *elf_symtab;
> +       const char *elf_symstrtab;
> +       Elf64_Word *elf_hashtab;
> +};
> +
> +static void *vdso_get_base_addr(char *envp[])
> +{
> +       Elf64_auxv_t *auxv;
> +       int i;
> +
> +       for (i =3D 0; envp[i]; i++)
> +               ;
> +
> +       auxv =3D (Elf64_auxv_t *)&envp[i + 1];
> +
> +       for (i =3D 0; auxv[i].a_type !=3D AT_NULL; i++) {
> +               if (auxv[i].a_type =3D=3D AT_SYSINFO_EHDR)
> +                       return (void *)auxv[i].a_un.a_val;
> +       }
> +
> +       return NULL;
> +}
> +
> +static Elf64_Dyn *vdso_get_dyntab(void *addr)
> +{
> +       Elf64_Ehdr *ehdr =3D addr;
> +       Elf64_Phdr *phdrtab =3D addr + ehdr->e_phoff;
> +       int i;
> +
> +       for (i =3D 0; i < ehdr->e_phnum; i++)
> +               if (phdrtab[i].p_type =3D=3D PT_DYNAMIC)
> +                       return addr + phdrtab[i].p_offset;
> +
> +       return NULL;
> +}
> +
> +static void *vdso_get_dyn(void *addr, Elf64_Dyn *dyntab, Elf64_Sxword ta=
g)
> +{
> +       int i;
> +
> +       for (i =3D 0; dyntab[i].d_tag !=3D DT_NULL; i++)
> +               if (dyntab[i].d_tag =3D=3D tag)
> +                       return addr + dyntab[i].d_un.d_ptr;
> +
> +       return NULL;
> +}
> +
> +static bool vdso_get_symtab(void *addr, struct vdso_symtab *symtab)
> +{
> +       Elf64_Dyn *dyntab =3D vdso_get_dyntab(addr);
> +
> +       symtab->elf_symtab =3D vdso_get_dyn(addr, dyntab, DT_SYMTAB);
> +       if (!symtab->elf_symtab)
> +               return false;
> +
> +       symtab->elf_symstrtab =3D vdso_get_dyn(addr, dyntab, DT_STRTAB);
> +       if (!symtab->elf_symstrtab)
> +               return false;
> +
> +       symtab->elf_hashtab =3D vdso_get_dyn(addr, dyntab, DT_HASH);
> +       if (!symtab->elf_hashtab)
> +               return false;
> +
> +       return true;
> +}
> +
> +static unsigned long elf_sym_hash(const char *name)
> +{
> +       unsigned long h =3D 0, high;
> +
> +       while (*name) {
> +               h =3D (h << 4) + *name++;
> +               high =3D h & 0xf0000000;
> +
> +               if (high)
> +                       h ^=3D high >> 24;
> +
> +               h &=3D ~high;
> +       }
> +
> +       return h;
> +}
> +
> +static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char=
 *name)
> +{
> +       Elf64_Word bucketnum =3D symtab->elf_hashtab[0];
> +       Elf64_Word *buckettab =3D &symtab->elf_hashtab[2];
> +       Elf64_Word *chaintab =3D &symtab->elf_hashtab[2 + bucketnum];
> +       Elf64_Sym *sym;
> +       Elf64_Word i;
> +
> +       for (i =3D buckettab[elf_sym_hash(name) % bucketnum]; i !=3D STN_=
UNDEF;
> +            i =3D chaintab[i]) {
> +               sym =3D &symtab->elf_symtab[i];
> +               if (!strcmp(name, &symtab->elf_symstrtab[sym->st_name]))
> +                       return sym;
> +       }
> +
> +       return NULL;
> +}
> +
> +int main(int argc, char *argv[], char *envp[])
> +{
> +       struct sgx_enclave_exception exception;
> +       struct vdso_symtab symtab;
> +       Elf64_Sym *eenter_sym;
> +       uint64_t result =3D 0;
> +       struct encl encl;
> +       unsigned int i;
> +       void *addr;
> +
> +       if (!encl_load("test_encl.elf", &encl))
> +               goto err;
> +
> +       if (!encl_measure(&encl))
> +               goto err;
> +
> +       if (!encl_build(&encl))
> +               goto err;
> +
> +       /*
> +        * An enclave consumer only must do this.
> +        */
> +       for (i =3D 0; i < encl.nr_segments; i++) {
> +               struct encl_segment *seg =3D &encl.segment_tbl[i];
> +
> +               addr =3D mmap((void *)encl.encl_base + seg->offset, seg->=
size,
> +                           seg->prot, MAP_SHARED | MAP_FIXED, encl.fd, 0=
);

My patch version is a bit behind (v32), but I suspect this still
applies. I discovered the following by accident.

In the Enarx code base, this invocation succeeds:
mmap(0x200000000000, 0x1000, PROT_READ | PROT_WRITE, MAP_SHARED |
MAP_FIXED, sgxfd, 0)

However, this one fails with -EINVAL:
mmap(0x200000000000, 0x1000, PROT_READ | PROT_WRITE,
MAP_SHARED_VALIDATE | MAP_FIXED, sgxfd, 0)

From man mmap:

       MAP_SHARED_VALIDATE (since Linux 4.15)
              This flag provides the same behavior as MAP_SHARED
except that MAP_SHARED mappings ignore unknown
              flags in flags.  By contrast, when creating a mapping
using MAP_SHARED_VALIDATE, the kernel veri=E2=80=90
              fies  all  passed  flags  are  known  and fails the
mapping with the error EOPNOTSUPP for unknown
              flags.  This mapping type is also required to be able to
use some mapping flags (e.g., MAP_SYNC).

I can try again on a newer patch set tomorrow if need be. But the
documentation of mmap() doesn't match the behavior I'm seeing. A brief
look through the patch set didn't turn up anything obvious that could
be causing this.

> +               if (addr =3D=3D MAP_FAILED) {
> +                       fprintf(stderr, "mmap() failed, errno=3D%d.\n", e=
rrno);
> +                       exit(1);
> +               }
> +       }
> +
> +       memset(&exception, 0, sizeof(exception));
> +
> +       addr =3D vdso_get_base_addr(envp);
> +       if (!addr)
> +               goto err;
> +
> +       if (!vdso_get_symtab(addr, &symtab))
> +               goto err;
> +
> +       eenter_sym =3D vdso_symtab_get(&symtab, "__vdso_sgx_enter_enclave=
");
> +       if (!eenter_sym)
> +               goto err;
> +
> +       eenter =3D addr + eenter_sym->st_value;
> +
> +       sgx_call_vdso((void *)&MAGIC, &result, 0, EENTER, NULL, NULL,
> +                     (void *)encl.encl_base, &exception, NULL);
> +       if (result !=3D MAGIC) {
> +               printf("FAIL: sgx_call_vdso(), expected: 0x%lx, got: 0x%l=
x\n",
> +                      MAGIC, result);
> +               goto err;
> +       }
> +
> +       /* Invoke the vDSO directly. */
> +       result =3D 0;
> +       eenter((unsigned long)&MAGIC, (unsigned long)&result, 0, EENTER, =
0, 0,
> +              (void *)encl.encl_base, &exception, NULL);
> +       if (result !=3D MAGIC) {
> +               printf("FAIL: eenter(), expected: 0x%lx, got: 0x%lx\n",
> +                      MAGIC, result);
> +               goto err;
> +       }
> +
> +       printf("SUCCESS\n");
> +       encl_delete(&encl);
> +       exit(0);
> +
> +err:
> +       encl_delete(&encl);
> +       exit(1);
> +}
> diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests=
/sgx/main.h
> new file mode 100644
> index 000000000000..999422cc7343
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/main.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright(c) 2016-19 Intel Corporation.
> + */
> +
> +#ifndef MAIN_H
> +#define MAIN_H
> +
> +struct encl_segment {
> +       off_t offset;
> +       size_t size;
> +       unsigned int prot;
> +       unsigned int flags;
> +};
> +
> +struct encl {
> +       int fd;
> +       void *bin;
> +       off_t bin_size;
> +       void *src;
> +       size_t src_size;
> +       size_t encl_size;
> +       off_t encl_base;
> +       unsigned int nr_segments;
> +       struct encl_segment *segment_tbl;
> +       struct sgx_secs secs;
> +       struct sgx_sigstruct sigstruct;
> +};
> +
> +void encl_delete(struct encl *ctx);
> +bool encl_load(const char *path, struct encl *encl);
> +bool encl_measure(struct encl *encl);
> +bool encl_build(struct encl *encl);
> +
> +int sgx_call_vdso(void *rdi, void *rsi, long rdx, u32 leaf, void *r8, vo=
id *r9,
> +                 void *tcs, struct sgx_enclave_exception *ei, void *cb);
> +
> +#endif /* MAIN_H */
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/self=
tests/sgx/sigstruct.c
> new file mode 100644
> index 000000000000..ceddad478672
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -0,0 +1,395 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +// Copyright(c) 2016-18 Intel Corporation.
> +
> +#define _GNU_SOURCE
> +#include <assert.h>
> +#include <getopt.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <openssl/err.h>
> +#include <openssl/pem.h>
> +#include "defines.h"
> +#include "main.h"
> +
> +struct q1q2_ctx {
> +       BN_CTX *bn_ctx;
> +       BIGNUM *m;
> +       BIGNUM *s;
> +       BIGNUM *q1;
> +       BIGNUM *qr;
> +       BIGNUM *q2;
> +};
> +
> +static void free_q1q2_ctx(struct q1q2_ctx *ctx)
> +{
> +       BN_CTX_free(ctx->bn_ctx);
> +       BN_free(ctx->m);
> +       BN_free(ctx->s);
> +       BN_free(ctx->q1);
> +       BN_free(ctx->qr);
> +       BN_free(ctx->q2);
> +}
> +
> +static bool alloc_q1q2_ctx(const uint8_t *s, const uint8_t *m,
> +                          struct q1q2_ctx *ctx)
> +{
> +       ctx->bn_ctx =3D BN_CTX_new();
> +       ctx->s =3D BN_bin2bn(s, SGX_MODULUS_SIZE, NULL);
> +       ctx->m =3D BN_bin2bn(m, SGX_MODULUS_SIZE, NULL);
> +       ctx->q1 =3D BN_new();
> +       ctx->qr =3D BN_new();
> +       ctx->q2 =3D BN_new();
> +
> +       if (!ctx->bn_ctx || !ctx->s || !ctx->m || !ctx->q1 || !ctx->qr ||
> +           !ctx->q2) {
> +               free_q1q2_ctx(ctx);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool calc_q1q2(const uint8_t *s, const uint8_t *m, uint8_t *q1,
> +                     uint8_t *q2)
> +{
> +       struct q1q2_ctx ctx;
> +
> +       if (!alloc_q1q2_ctx(s, m, &ctx)) {
> +               fprintf(stderr, "Not enough memory for Q1Q2 calculation\n=
");
> +               return false;
> +       }
> +
> +       if (!BN_mul(ctx.q1, ctx.s, ctx.s, ctx.bn_ctx))
> +               goto out;
> +
> +       if (!BN_div(ctx.q1, ctx.qr, ctx.q1, ctx.m, ctx.bn_ctx))
> +               goto out;
> +
> +       if (BN_num_bytes(ctx.q1) > SGX_MODULUS_SIZE) {
> +               fprintf(stderr, "Too large Q1 %d bytes\n",
> +                       BN_num_bytes(ctx.q1));
> +               goto out;
> +       }
> +
> +       if (!BN_mul(ctx.q2, ctx.s, ctx.qr, ctx.bn_ctx))
> +               goto out;
> +
> +       if (!BN_div(ctx.q2, NULL, ctx.q2, ctx.m, ctx.bn_ctx))
> +               goto out;
> +
> +       if (BN_num_bytes(ctx.q2) > SGX_MODULUS_SIZE) {
> +               fprintf(stderr, "Too large Q2 %d bytes\n",
> +                       BN_num_bytes(ctx.q2));
> +               goto out;
> +       }
> +
> +       BN_bn2bin(ctx.q1, q1);
> +       BN_bn2bin(ctx.q2, q2);
> +
> +       free_q1q2_ctx(&ctx);
> +       return true;
> +out:
> +       free_q1q2_ctx(&ctx);
> +       return false;
> +}
> +
> +struct sgx_sigstruct_payload {
> +       struct sgx_sigstruct_header header;
> +       struct sgx_sigstruct_body body;
> +};
> +
> +static bool check_crypto_errors(void)
> +{
> +       int err;
> +       bool had_errors =3D false;
> +       const char *filename;
> +       int line;
> +       char str[256];
> +
> +       for ( ; ; ) {
> +               if (ERR_peek_error() =3D=3D 0)
> +                       break;
> +
> +               had_errors =3D true;
> +               err =3D ERR_get_error_line(&filename, &line);
> +               ERR_error_string_n(err, str, sizeof(str));
> +               fprintf(stderr, "crypto: %s: %s:%d\n", str, filename, lin=
e);
> +       }
> +
> +       return had_errors;
> +}
> +
> +static inline const BIGNUM *get_modulus(RSA *key)
> +{
> +#if OPENSSL_VERSION_NUMBER < 0x10100000L
> +       return key->n;
> +#else
> +       const BIGNUM *n;
> +
> +       RSA_get0_key(key, &n, NULL, NULL);
> +       return n;
> +#endif
> +}
> +
> +static RSA *gen_sign_key(void)
> +{
> +       BIGNUM *e;
> +       RSA *key;
> +       int ret;
> +
> +       e =3D BN_new();
> +       key =3D RSA_new();
> +
> +       if (!e || !key)
> +               goto err;
> +
> +       ret =3D BN_set_word(e, RSA_3);
> +       if (ret !=3D 1)
> +               goto err;
> +
> +       ret =3D RSA_generate_key_ex(key, 3072, e, NULL);
> +       if (ret !=3D 1)
> +               goto err;
> +
> +       BN_free(e);
> +
> +       return key;
> +
> +err:
> +       RSA_free(key);
> +       BN_free(e);
> +
> +       return NULL;
> +}
> +
> +static void reverse_bytes(void *data, int length)
> +{
> +       int i =3D 0;
> +       int j =3D length - 1;
> +       uint8_t temp;
> +       uint8_t *ptr =3D data;
> +
> +       while (i < j) {
> +               temp =3D ptr[i];
> +               ptr[i] =3D ptr[j];
> +               ptr[j] =3D temp;
> +               i++;
> +               j--;
> +       }
> +}
> +
> +enum mrtags {
> +       MRECREATE =3D 0x0045544145524345,
> +       MREADD =3D 0x0000000044444145,
> +       MREEXTEND =3D 0x00444E4554584545,
> +};
> +
> +static bool mrenclave_update(EVP_MD_CTX *ctx, const void *data)
> +{
> +       if (!EVP_DigestUpdate(ctx, data, 64)) {
> +               fprintf(stderr, "digest update failed\n");
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool mrenclave_commit(EVP_MD_CTX *ctx, uint8_t *mrenclave)
> +{
> +       unsigned int size;
> +
> +       if (!EVP_DigestFinal_ex(ctx, (unsigned char *)mrenclave, &size)) =
{
> +               fprintf(stderr, "digest commit failed\n");
> +               return false;
> +       }
> +
> +       if (size !=3D 32) {
> +               fprintf(stderr, "invalid digest size =3D %u\n", size);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +struct mrecreate {
> +       uint64_t tag;
> +       uint32_t ssaframesize;
> +       uint64_t size;
> +       uint8_t reserved[44];
> +} __attribute__((__packed__));
> +
> +
> +static bool mrenclave_ecreate(EVP_MD_CTX *ctx, uint64_t blob_size)
> +{
> +       struct mrecreate mrecreate;
> +       uint64_t encl_size;
> +
> +       for (encl_size =3D 0x1000; encl_size < blob_size; )
> +               encl_size <<=3D 1;
> +
> +       memset(&mrecreate, 0, sizeof(mrecreate));
> +       mrecreate.tag =3D MRECREATE;
> +       mrecreate.ssaframesize =3D 1;
> +       mrecreate.size =3D encl_size;
> +
> +       if (!EVP_DigestInit_ex(ctx, EVP_sha256(), NULL))
> +               return false;
> +
> +       return mrenclave_update(ctx, &mrecreate);
> +}
> +
> +struct mreadd {
> +       uint64_t tag;
> +       uint64_t offset;
> +       uint64_t flags; /* SECINFO flags */
> +       uint8_t reserved[40];
> +} __attribute__((__packed__));
> +
> +static bool mrenclave_eadd(EVP_MD_CTX *ctx, uint64_t offset, uint64_t fl=
ags)
> +{
> +       struct mreadd mreadd;
> +
> +       memset(&mreadd, 0, sizeof(mreadd));
> +       mreadd.tag =3D MREADD;
> +       mreadd.offset =3D offset;
> +       mreadd.flags =3D flags;
> +
> +       return mrenclave_update(ctx, &mreadd);
> +}
> +
> +struct mreextend {
> +       uint64_t tag;
> +       uint64_t offset;
> +       uint8_t reserved[48];
> +} __attribute__((__packed__));
> +
> +static bool mrenclave_eextend(EVP_MD_CTX *ctx, uint64_t offset,
> +                             const uint8_t *data)
> +{
> +       struct mreextend mreextend;
> +       int i;
> +
> +       for (i =3D 0; i < 0x1000; i +=3D 0x100) {
> +               memset(&mreextend, 0, sizeof(mreextend));
> +               mreextend.tag =3D MREEXTEND;
> +               mreextend.offset =3D offset + i;
> +
> +               if (!mrenclave_update(ctx, &mreextend))
> +                       return false;
> +
> +               if (!mrenclave_update(ctx, &data[i + 0x00]))
> +                       return false;
> +
> +               if (!mrenclave_update(ctx, &data[i + 0x40]))
> +                       return false;
> +
> +               if (!mrenclave_update(ctx, &data[i + 0x80]))
> +                       return false;
> +
> +               if (!mrenclave_update(ctx, &data[i + 0xC0]))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static bool mrenclave_segment(EVP_MD_CTX *ctx, struct encl *encl,
> +                             struct encl_segment *seg)
> +{
> +       uint64_t end =3D seg->offset + seg->size;
> +       uint64_t offset;
> +
> +       for (offset =3D seg->offset; offset < end; offset +=3D PAGE_SIZE)=
 {
> +               if (!mrenclave_eadd(ctx, offset, seg->flags))
> +                       return false;
> +
> +               if (!mrenclave_eextend(ctx, offset, encl->src + offset))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +bool encl_measure(struct encl *encl)
> +{
> +       uint64_t header1[2] =3D {0x000000E100000006, 0x0000000000010000};
> +       uint64_t header2[2] =3D {0x0000006000000101, 0x0000000100000060};
> +       struct sgx_sigstruct *sigstruct =3D &encl->sigstruct;
> +       struct sgx_sigstruct_payload payload;
> +       uint8_t digest[SHA256_DIGEST_LENGTH];
> +       unsigned int siglen;
> +       RSA *key =3D NULL;
> +       EVP_MD_CTX *ctx;
> +       int i;
> +
> +       memset(sigstruct, 0, sizeof(*sigstruct));
> +
> +       sigstruct->header.header1[0] =3D header1[0];
> +       sigstruct->header.header1[1] =3D header1[1];
> +       sigstruct->header.header2[0] =3D header2[0];
> +       sigstruct->header.header2[1] =3D header2[1];
> +       sigstruct->exponent =3D 3;
> +       sigstruct->body.attributes =3D SGX_ATTR_MODE64BIT;
> +       sigstruct->body.xfrm =3D 3;
> +
> +       /* sanity check */
> +       if (check_crypto_errors())
> +               goto err;
> +
> +       key =3D gen_sign_key();
> +       if (!key)
> +               goto err;
> +
> +       BN_bn2bin(get_modulus(key), sigstruct->modulus);
> +
> +       ctx =3D EVP_MD_CTX_create();
> +       if (!ctx)
> +               goto err;
> +
> +       if (!mrenclave_ecreate(ctx, encl->src_size))
> +               goto err;
> +
> +       for (i =3D 0; i < encl->nr_segments; i++) {
> +               struct encl_segment *seg =3D &encl->segment_tbl[i];
> +
> +               if (!mrenclave_segment(ctx, encl, seg))
> +                       goto err;
> +       }
> +
> +       if (!mrenclave_commit(ctx, sigstruct->body.mrenclave))
> +               goto err;
> +
> +       memcpy(&payload.header, &sigstruct->header, sizeof(sigstruct->hea=
der));
> +       memcpy(&payload.body, &sigstruct->body, sizeof(sigstruct->body));
> +
> +       SHA256((unsigned char *)&payload, sizeof(payload), digest);
> +
> +       if (!RSA_sign(NID_sha256, digest, SHA256_DIGEST_LENGTH,
> +                     sigstruct->signature, &siglen, key))
> +               goto err;
> +
> +       if (!calc_q1q2(sigstruct->signature, sigstruct->modulus, sigstruc=
t->q1,
> +                      sigstruct->q2))
> +               goto err;
> +
> +       /* BE -> LE */
> +       reverse_bytes(sigstruct->signature, SGX_MODULUS_SIZE);
> +       reverse_bytes(sigstruct->modulus, SGX_MODULUS_SIZE);
> +       reverse_bytes(sigstruct->q1, SGX_MODULUS_SIZE);
> +       reverse_bytes(sigstruct->q2, SGX_MODULUS_SIZE);
> +
> +       EVP_MD_CTX_destroy(ctx);
> +       RSA_free(key);
> +       return true;
> +
> +err:
> +       EVP_MD_CTX_destroy(ctx);
> +       RSA_free(key);
> +       return false;
> +}
> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/self=
tests/sgx/test_encl.c
> new file mode 100644
> index 000000000000..ede915399742
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/test_encl.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +// Copyright(c) 2016-18 Intel Corporation.
> +
> +#include <stddef.h>
> +#include "defines.h"
> +
> +static void *memcpy(void *dest, const void *src, size_t n)
> +{
> +       size_t i;
> +
> +       for (i =3D 0; i < n; i++)
> +               ((char *)dest)[i] =3D ((char *)src)[i];
> +
> +       return dest;
> +}
> +
> +void encl_body(void *rdi, void *rsi)
> +{
> +       memcpy(rsi, rdi, 8);
> +}
> diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/se=
lftests/sgx/test_encl.lds
> new file mode 100644
> index 000000000000..0fbbda7e665e
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/test_encl.lds
> @@ -0,0 +1,40 @@
> +OUTPUT_FORMAT(elf64-x86-64)
> +
> +PHDRS
> +{
> +       tcs PT_LOAD;
> +       text PT_LOAD;
> +       data PT_LOAD;
> +}
> +
> +SECTIONS
> +{
> +       . =3D 0;
> +       .tcs : {
> +               *(.tcs*)
> +       } : tcs
> +
> +       . =3D ALIGN(4096);
> +       .text : {
> +               *(.text*)
> +               *(.rodata*)
> +       } : text
> +
> +       . =3D ALIGN(4096);
> +       .data : {
> +               *(.data*)
> +       } : data
> +
> +       /DISCARD/ : {
> +               *(.comment*)
> +               *(.note*)
> +               *(.debug*)
> +               *(.eh_frame*)
> +       }
> +}
> +
> +ASSERT(!DEFINED(.altinstructions), "ALTERNATIVES are not supported in en=
claves")
> +ASSERT(!DEFINED(.altinstr_replacement), "ALTERNATIVES are not supported =
in enclaves")
> +ASSERT(!DEFINED(.discard.retpoline_safe), "RETPOLINE ALTERNATIVES are no=
t supported in enclaves")
> +ASSERT(!DEFINED(.discard.nospec), "RETPOLINE ALTERNATIVES are not suppor=
ted in enclaves")
> +ASSERT(!DEFINED(.got.plt), "Libcalls are not supported in enclaves")
> diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/te=
sting/selftests/sgx/test_encl_bootstrap.S
> new file mode 100644
> index 000000000000..6836ea86126e
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/*
> + * Copyright(c) 2016-18 Intel Corporation.
> + */
> +
> +       .macro ENCLU
> +       .byte 0x0f, 0x01, 0xd7
> +       .endm
> +
> +       .section ".tcs", "aw"
> +       .balign 4096
> +
> +       .fill   1, 8, 0                 # STATE (set by CPU)
> +       .fill   1, 8, 0                 # FLAGS
> +       .quad   encl_ssa                # OSSA
> +       .fill   1, 4, 0                 # CSSA (set by CPU)
> +       .fill   1, 4, 1                 # NSSA
> +       .quad   encl_entry              # OENTRY
> +       .fill   1, 8, 0                 # AEP (set by EENTER and ERESUME)
> +       .fill   1, 8, 0                 # OFSBASE
> +       .fill   1, 8, 0                 # OGSBASE
> +       .fill   1, 4, 0xFFFFFFFF        # FSLIMIT
> +       .fill   1, 4, 0xFFFFFFFF        # GSLIMIT
> +       .fill   4024, 1, 0              # Reserved
> +
> +       # Identical to the previous TCS.
> +       .fill   1, 8, 0                 # STATE (set by CPU)
> +       .fill   1, 8, 0                 # FLAGS
> +       .quad   encl_ssa                # OSSA
> +       .fill   1, 4, 0                 # CSSA (set by CPU)
> +       .fill   1, 4, 1                 # NSSA
> +       .quad   encl_entry              # OENTRY
> +       .fill   1, 8, 0                 # AEP (set by EENTER and ERESUME)
> +       .fill   1, 8, 0                 # OFSBASE
> +       .fill   1, 8, 0                 # OGSBASE
> +       .fill   1, 4, 0xFFFFFFFF        # FSLIMIT
> +       .fill   1, 4, 0xFFFFFFFF        # GSLIMIT
> +       .fill   4024, 1, 0              # Reserved
> +
> +       .text
> +
> +encl_entry:
> +       # RBX contains the base address for TCS, which is also the first =
address
> +       # inside the enclave. By adding the value of le_stack_end to it, =
we get
> +       # the absolute address for the stack.
> +       lea     (encl_stack)(%rbx), %rax
> +       xchg    %rsp, %rax
> +       push    %rax
> +
> +       push    %rcx # push the address after EENTER
> +       push    %rbx # push the enclave base address
> +
> +       call    encl_body
> +
> +       pop     %rbx # pop the enclave base address
> +
> +       /* Clear volatile GPRs, except RAX (EEXIT leaf). */
> +       xor     %rcx, %rcx
> +       xor     %rdx, %rdx
> +       xor     %rdi, %rdi
> +       xor     %rsi, %rsi
> +       xor     %r8, %r8
> +       xor     %r9, %r9
> +       xor     %r10, %r10
> +       xor     %r11, %r11
> +
> +       # Reset status flags.
> +       add     %rdx, %rdx # OF =3D SF =3D AF =3D CF =3D 0; ZF =3D PF =3D=
 1
> +
> +       # Prepare EEXIT target by popping the address of the instruction =
after
> +       # EENTER to RBX.
> +       pop     %rbx
> +
> +       # Restore the caller stack.
> +       pop     %rax
> +       mov     %rax, %rsp
> +
> +       # EEXIT
> +       mov     $4, %rax
> +       enclu
> +
> +       .section ".data", "aw"
> +
> +encl_ssa:
> +       .space 4096
> +
> +       .balign 4096
> +       .space 8192
> +encl_stack:
> --
> 2.25.1
>

