Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024097CB16A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjJPRfR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 13:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPRfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 13:35:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2189F
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 10:35:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9c496c114so19025ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 10:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697477713; x=1698082513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IE7ste/9K+MPz1i72hcvVlvzxuJt/UnGYdWTniw0P0=;
        b=pbg3q/DTfSMo00CJe4tDhXCU+XNbURrWCmshNZ9V2CBp64Eo7SY/dBB6VCzNsYtcfF
         VWjZV9MXVmxewx3QXk1RuyC2NewXCj7ONTmBK7fkLUD8NnQuB/ss87xF+K8N1jmYR1he
         8pTPaKz5T6BDMLAQEWFPDOfmP/hnRFouH1cy9bcbAMik+fNuBxhZdRuaNulkEsdwT5f7
         LNqVM21FkQ4Nzb5nxzNVAGRP8QVrV+vwKjRSEEJF5qt7is27i3NnkI9dgV9p2+ELubs2
         br2NcanM23XYiEyzWC1oou0tvBJHevDKzqrovku2+JEg0DJLLyFhaHQ+zqSUzDu/m24G
         gV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477713; x=1698082513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IE7ste/9K+MPz1i72hcvVlvzxuJt/UnGYdWTniw0P0=;
        b=oaP5RrE/36M2VZIvPekIPMkTJDHUs3cFwxwGn9sMKPHgsur19odufQKe3xH5tFq74Z
         gqwSzDp4N6QnqgkuT2B7yvJNF8r1XknTb3QW4HqIBG+AC0sC6rCbjOQ1/Cwropz1FgFV
         PpemX1JBtg5exh+c8qle4qx/+8V65C0Jdq55bX3hdTD4qbF0iOujH3zDkmalvw3dY8TL
         MAX+VBnhTwo/8F3os6BxQ5KZ+jzHI6EqIMylBOlSDIJ7xumxArWqjQoW0eL6hNrh4rQe
         tySBgvDTBMYZbYPAw6tAer35xRJ/T37zefgHfuFZvebexJdMRbjA+0xjG4HUMJarkPbv
         cuKw==
X-Gm-Message-State: AOJu0YzWQmUTwKDtpGG2WaXfFoJRb7tGP92EH0PDX0PlIK2p2bZXVH+S
        AZ+pujjNgCM9VOAg4wZM+GreikL2suHyQd7em8DHxw==
X-Google-Smtp-Source: AGHT+IHpLOQh8gGngPY81BrIpOn4V6KnmdVdaoL70Npuo2h09JrCSwDur1o0CQrQETq8n/zCk+qOPTnzOoAPcHQBU44=
X-Received: by 2002:a17:902:f60e:b0:1b8:b564:b528 with SMTP id
 n14-20020a170902f60e00b001b8b564b528mr321729plg.7.1697477713183; Mon, 16 Oct
 2023 10:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org>
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Oct 2023 19:34:37 +0200
Message-ID: <CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        surenb@google.com, alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 4:38=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> This patchset proposes a new mseal() syscall for the Linux kernel.
>
> Modern CPUs support memory permissions such as RW and NX bits. Linux has
> supported NX since the release of kernel version 2.6.8 in August 2004 [1]=
.
> The memory permission feature improves security stance on memory
> corruption bugs, i.e. the attacker can=E2=80=99t just write to arbitrary =
memory
> and point the code to it, the memory has to be marked with X bit, or
> else an exception will happen.
>
> Memory sealing additionally protects the mapping itself against
> modifications. This is useful to mitigate memory corruption issues where
> a corrupted pointer is passed to a memory management syscall. For example=
,
> such an attacker primitive can break control-flow integrity guarantees
> since read-only memory that is supposed to be trusted can become writable
> or .text pages can get remapped. Memory sealing can automatically be
> applied by the runtime loader to seal .text and .rodata pages and
> applications can additionally seal security critical data at runtime.
> A similar feature already exists in the XNU kernel with the
> VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the mimmutable syscall [4=
].
> Also, Chrome wants to adopt this feature for their CFI work [2] and this
> patchset has been designed to be compatible with the Chrome use case.
>
> The new mseal() is an architecture independent syscall, and with
> following signature:
>
> mseal(void addr, size_t len, unsigned int types, unsigned int flags)

Is the plan that the VMAs you need to protect would be created and
mseal()'ed while you expect that attacker code can not (yet) be
running concurrently?

Do you expect to be using sealed memory for shadow stacks (in x86 CET
/ arm64 GCS) to prevent an attacker from mixing those up by moving
pages inside a shadow stack or between different shadow stacks or
such? (If that's even possible, I think it is but I haven't tried.)

> addr/len: memory range.  Must be continuous/allocated memory, or else
> mseal() will fail and no VMA is updated. For details on acceptable
> arguments, please refer to comments in mseal.c. Those are also fully
> covered by the selftest.
> types: bit mask to specify which syscall to seal, currently they are:
> MM_SEAL_MSEAL 0x1
> MM_SEAL_MPROTECT 0x2
> MM_SEAL_MUNMAP 0x4
> MM_SEAL_MMAP 0x8
> MM_SEAL_MREMAP 0x10

You'd probably also want to block destructive madvise() operations
that can effectively alter region contents by discarding pages and
such, in particular MADV_FREE, MADV_DONTNEED, MADV_DONTNEED_LOCKED;
probably also MADV_REMOVE, MADV_DONTFORK, MADV_WIPEONFORK. Maybe you'd
want to just block all madvise() for sealed VMAs? Or rename
process_madvise_behavior_valid() to something like
"madvise_is_nondestructive()" and use that.

The following comments probably mostly don't matter in practice if
this feature is used in a context that is heavily seccomp-sandboxed
(like Desktop Linux Chrome), but should maybe be addressed to make
this feature more usable for other users. (Including Android Chrome,
which has a weaker sandbox...)

FWIW, it is also possible to write to read-only memory through the
/proc/self/mem interface (or through ptrace commands like
PTRACE_POKETEXT) because of FOLL_FORCE, depending on kernel
configuration, seccomp policy, and what the LSMs do. (I think Android
Chrome would allow /proc/self/mem writes, but would block
PTRACE_POKETEXT with RestrictPtrace() in the sandbox code?)

I had a related ancient patch series in 2016 with an attempt to allow
SELinux to prevent bypassing W^X protections with this, but I never
followed through with getting that landed...
(https://lore.kernel.org/linux-mm/1475103281-7989-1-git-send-email-jann@the=
jh.net/)

I guess the question there is what the right semantics for this kind
of protected memory are when a debugger is active. The simple solution
that might break some debugging would be "just deny all FOLL_FORCE
write access for this memory" (which would prevent debuggers from
being able to place breakpoints, which would maybe not be great). But
maybe it makes more sense to consider this to be an independent
concern and solve it with a new SELinux feature or something like that
instead, and then document that mseal() requires some complement to
prevent forced writes to read-only private memory? (For which the
simplest solution would be "don't grant filesystem access or ptrace()
access to the sandboxed code".)


What is the intended interaction with userfaultfd, which I believe by
design permits arbitrary data into unpopulated areas of anonymous
VMAs? If the intention is that the process should otherwise be
sandboxed to not have access to userfaultfd, that should maybe be
documented. (Alternatively I guess you could theoretically remove the
VM_MAYWRITE bit from marked VMAs, but that might be more strict than
we want, since it'd also block all FOLL_FORCE writes.)


There are also some interfaces like AIO or the X86 Shadow Stacks
interface that indirectly unmap memory through the kernel and look
like they could perhaps be tricked into racily unmapping a
just-created sealed VMA. You'd probably have to make sure that they
can't do that and essentially treat their unmap operations as if they
came from userspace, I guess? What Linus just wrote.


I think either way this feature needs some documentation on what kind
of context it's supposed to run in.


> Each bit represents sealing for one specific syscall type, e.g.
> MM_SEAL_MPROTECT will deny mprotect syscall. The consideration of bitmask
> is that the API is extendable, i.e. when needed, the sealing can be
> extended to madvise, mlock, etc. Backward compatibility is also easy.
>
> The kernel will remember which seal types are applied, and the applicatio=
n
> doesn=E2=80=99t need to repeat all existing seal types in the next mseal(=
).  Once
> a seal type is applied, it can=E2=80=99t be unsealed. Call mseal() on an =
existing
> seal type is a no-action, not a failure.
>
> MM_SEAL_MSEAL will deny mseal() calls that try to add a new seal type.
>
> Internally, vm_area_struct adds a new field vm_seals, to store the bit
> masks.
>
> For the affected syscalls, such as mprotect, a check(can_modify_mm) for
> sealing is added, this usually happens at the early point of the syscall,
> before any update is made to VMAs. The effect of that is: if any of the
> VMAs in the given address range fails the sealing check, none of the VMA
> will be updated. It might be worth noting that this is different from the
> rest of mprotect(), where some updates can happen even when mprotect
> returns fail. Consider can_modify_mm only checks vm_seals in
> vm_area_struct, and it is not going deeper in the page table or updating
> any HW, success or none behavior might fit better here. I would like to
> listen to the community's feedback on this.
>
> The idea that inspired this patch comes from Stephen R=C3=B6ttger=E2=80=
=99s work in
> V8 CFI [5],  Chrome browser in ChromeOS will be the first user of this AP=
I.
>
> In addition, Stephen is working on glibc change to add sealing support
> into the dynamic linker to seal all non-writable segments at startup. Whe=
n
> that work is completed, all applications can automatically benefit from
> these new protections.
>
> [1] https://kernelnewbies.org/Linux_2_6_8
> [2] https://v8.dev/blog/control-flow-integrity
> [3] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37aff1=
77559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> [4] https://man.openbsd.org/mimmutable.2
> [5] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvx=
QMyXgeaRHo/edit#heading=3Dh.bvaojj9fu6hc
>
> Jeff Xu (8):
>   Add mseal syscall
>   Wire up mseal syscall
>   mseal: add can_modify_mm and can_modify_vma
>   mseal: seal mprotect
>   mseal munmap
>   mseal mremap
>   mseal mmap
>   selftest mm/mseal mprotect/munmap/mremap/mmap
>
>  arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
>  arch/arm/tools/syscall.tbl                  |    1 +
>  arch/arm64/include/asm/unistd.h             |    2 +-
>  arch/arm64/include/asm/unistd32.h           |    2 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |    1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |    1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |    1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |    1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |    1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |    1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |    1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
>  fs/aio.c                                    |    5 +-
>  include/linux/mm.h                          |   55 +-
>  include/linux/mm_types.h                    |    7 +
>  include/linux/syscalls.h                    |    2 +
>  include/uapi/asm-generic/unistd.h           |    5 +-
>  include/uapi/linux/mman.h                   |    6 +
>  ipc/shm.c                                   |    3 +-
>  kernel/sys_ni.c                             |    1 +
>  mm/Kconfig                                  |    8 +
>  mm/Makefile                                 |    1 +
>  mm/internal.h                               |    4 +-
>  mm/mmap.c                                   |   49 +-
>  mm/mprotect.c                               |    6 +
>  mm/mremap.c                                 |   19 +-
>  mm/mseal.c                                  |  328 +++++
>  mm/nommu.c                                  |    6 +-
>  mm/util.c                                   |    8 +-
>  tools/testing/selftests/mm/Makefile         |    1 +
>  tools/testing/selftests/mm/mseal_test.c     | 1428 +++++++++++++++++++
>  37 files changed, 1934 insertions(+), 28 deletions(-)
>  create mode 100644 mm/mseal.c
>  create mode 100644 tools/testing/selftests/mm/mseal_test.c
>
> --
> 2.42.0.609.gbb76f46606-goog
>
