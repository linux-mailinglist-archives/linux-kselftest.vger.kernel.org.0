Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5527CBDF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 10:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjJQInI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjJQInF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 04:43:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F924FE
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 01:43:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4195fe5cf73so181521cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 01:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697532181; x=1698136981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj0DKpetIFs2NXw10zDj+arVKcD/5Fnd7FSI00kIvR0=;
        b=sK+CeBKSpqD/EwH5zH3seYLBPkWqU9gl3Jqc6FMs/tyjbrv+mVwfNfkHn2HGqFS5/1
         zSPk5rzk+wv0Cj6YCyhxpvFu3Zomdqi1yGI2fy3Pud4WhGyQULmUK/XBqPSkpok6FMev
         dtXwUoV1nQ5suzbUu6ZSgWieQ/I+NRmr7zMEmKFuQ0GTE7gy6LLM52V1cNnkWmOj8t24
         1rfjc/YIl9VUFyaD/K2skUqRcfMGqOMI0GzlfdEcZSl5FwQxnAEGJCX7DGx1ZvK34wxD
         Yv3Q1JCV5HXd8E4Xu7RfVJN8J8zVoQXN+R41E8tOfQLM37zyZPyj9/OuqKlF3vC/82f+
         yTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532181; x=1698136981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jj0DKpetIFs2NXw10zDj+arVKcD/5Fnd7FSI00kIvR0=;
        b=LuKPa/YQUY5amBunSpybLFRAykjRYD9LnviwlH/inoQhJ/p+jvd73wG92A/yzMorgp
         OzQTLi2RHCdbYa97VwqgYEpD4lOZvqMGYOr58DGpupZhwRUOeabUZ36zLQMtTUCPCXNi
         15xp0/DqFlw3aEbmW1RAtzryLIP3svQkfDUpxWCJXs38/K4n56Y6LF3lD5qn2NQb8+hp
         1N7mSdyjdX5UX3qseVjlFH7Dg/rhCVkmWFywXlp2K2BCcIvu3L/eL/pEP5qgOX75Czwb
         AaxcsUiWUC+jF74++WoFruz9MLZSP/O+fQB7sy11pP/8st6bs2yIOr/853bI+TYh8Amk
         8lyg==
X-Gm-Message-State: AOJu0YxnMncFm3lsozb4yNZhCf3ERYJnavF6HMOSTp/auAiK9Mr/GGrW
        Guo36vNWiw+zijXiWkfL1/1toxFw4T5f/u5rE/C/Yw==
X-Google-Smtp-Source: AGHT+IF2/3CZJZDisBAvWrXopyYAYuvD2eAshnDCDCPMpo53VGYfpARowntq9xVWP0eqmrvL3+rae94Mo+NlR74+fxc=
X-Received: by 2002:a05:622a:740c:b0:41b:8287:dc2d with SMTP id
 jj12-20020a05622a740c00b0041b8287dc2dmr150272qtb.16.1697532181080; Tue, 17
 Oct 2023 01:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com>
In-Reply-To: <CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426FkcgnfUGLvA@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 17 Oct 2023 01:42:23 -0700
Message-ID: <CALmYWFthkJbQyWxig6Hb-zNzwN1Wqr63jaSuMeCeJVq63C5ovg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Jann Horn <jannh@google.com>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jann,

Thank you for reviewing the patch and comments.

On Mon, Oct 16, 2023 at 10:35=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> On Mon, Oct 16, 2023 at 4:38=E2=80=AFPM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@google.com>
> >
> > This patchset proposes a new mseal() syscall for the Linux kernel.
> >
> > Modern CPUs support memory permissions such as RW and NX bits. Linux ha=
s
> > supported NX since the release of kernel version 2.6.8 in August 2004 [=
1].
> > The memory permission feature improves security stance on memory
> > corruption bugs, i.e. the attacker can=E2=80=99t just write to arbitrar=
y memory
> > and point the code to it, the memory has to be marked with X bit, or
> > else an exception will happen.
> >
> > Memory sealing additionally protects the mapping itself against
> > modifications. This is useful to mitigate memory corruption issues wher=
e
> > a corrupted pointer is passed to a memory management syscall. For examp=
le,
> > such an attacker primitive can break control-flow integrity guarantees
> > since read-only memory that is supposed to be trusted can become writab=
le
> > or .text pages can get remapped. Memory sealing can automatically be
> > applied by the runtime loader to seal .text and .rodata pages and
> > applications can additionally seal security critical data at runtime.
> > A similar feature already exists in the XNU kernel with the
> > VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the mimmutable syscall =
[4].
> > Also, Chrome wants to adopt this feature for their CFI work [2] and thi=
s
> > patchset has been designed to be compatible with the Chrome use case.
> >
> > The new mseal() is an architecture independent syscall, and with
> > following signature:
> >
> > mseal(void addr, size_t len, unsigned int types, unsigned int flags)
>
> Is the plan that the VMAs you need to protect would be created and
> mseal()'ed while you expect that attacker code can not (yet) be
> running concurrently?
>
Yes.

> Do you expect to be using sealed memory for shadow stacks (in x86 CET
> / arm64 GCS) to prevent an attacker from mixing those up by moving
> pages inside a shadow stack or between different shadow stacks or
> such? (If that's even possible, I think it is but I haven't tried.)
>
I will defer the question to Stephen.
(I also think that is possible, if the application know where the
shadow stack is at runtime)

> > addr/len: memory range.  Must be continuous/allocated memory, or else
> > mseal() will fail and no VMA is updated. For details on acceptable
> > arguments, please refer to comments in mseal.c. Those are also fully
> > covered by the selftest.
> > types: bit mask to specify which syscall to seal, currently they are:
> > MM_SEAL_MSEAL 0x1
> > MM_SEAL_MPROTECT 0x2
> > MM_SEAL_MUNMAP 0x4
> > MM_SEAL_MMAP 0x8
> > MM_SEAL_MREMAP 0x10
>
> You'd probably also want to block destructive madvise() operations
> that can effectively alter region contents by discarding pages and
> such, in particular MADV_FREE, MADV_DONTNEED, MADV_DONTNEED_LOCKED;
> probably also MADV_REMOVE, MADV_DONTFORK, MADV_WIPEONFORK. Maybe you'd
> want to just block all madvise() for sealed VMAs? Or rename
> process_madvise_behavior_valid() to something like
> "madvise_is_nondestructive()" and use that.
>
Thanks for the suggestion. I can add madvise() later, maybe in another seri=
es.
For now, the goal of this patchset covers 4 syscalls, as wished for by
Chrome initially.

> The following comments probably mostly don't matter in practice if
> this feature is used in a context that is heavily seccomp-sandboxed
> (like Desktop Linux Chrome), but should maybe be addressed to make
> this feature more usable for other users. (Including Android Chrome,
> which has a weaker sandbox...)
>
> FWIW, it is also possible to write to read-only memory through the
> /proc/self/mem interface (or through ptrace commands like
> PTRACE_POKETEXT) because of FOLL_FORCE, depending on kernel
> configuration, seccomp policy, and what the LSMs do. (I think Android
> Chrome would allow /proc/self/mem writes, but would block
> PTRACE_POKETEXT with RestrictPtrace() in the sandbox code?)
>
> I had a related ancient patch series in 2016 with an attempt to allow
> SELinux to prevent bypassing W^X protections with this, but I never
> followed through with getting that landed...
> (https://lore.kernel.org/linux-mm/1475103281-7989-1-git-send-email-jann@t=
hejh.net/)
>
> I guess the question there is what the right semantics for this kind
> of protected memory are when a debugger is active. The simple solution
> that might break some debugging would be "just deny all FOLL_FORCE
> write access for this memory" (which would prevent debuggers from
> being able to place breakpoints, which would maybe not be great). But
> maybe it makes more sense to consider this to be an independent
> concern and solve it with a new SELinux feature or something like that
> instead, and then document that mseal() requires some complement to
> prevent forced writes to read-only private memory? (For which the
> simplest solution would be "don't grant filesystem access or ptrace()
> access to the sandboxed code".)
>
> What is the intended interaction with userfaultfd, which I believe by
> design permits arbitrary data into unpopulated areas of anonymous
> VMAs? If the intention is that the process should otherwise be
> sandboxed to not have access to userfaultfd, that should maybe be
> documented. (Alternatively I guess you could theoretically remove the
> VM_MAYWRITE bit from marked VMAs, but that might be more strict than
> we want, since it'd also block all FOLL_FORCE writes.)
>
>
> There are also some interfaces like AIO or the X86 Shadow Stacks
> interface that indirectly unmap memory through the kernel and look
> like they could perhaps be tricked into racily unmapping a
> just-created sealed VMA. You'd probably have to make sure that they
> can't do that and essentially treat their unmap operations as if they
> came from userspace, I guess? What Linus just wrote.
>
>
> I think either way this feature needs some documentation on what kind
> of context it's supposed to run in.
>
Thanks for listing all the cases. As you pointed out, Chrome is
heavily sandboxed, with syscalls and file access. I will work with Stephan
to check if some of these applied to Chrome.

It is probably worth to mention, with the current approach of mseal(),
i.e. by bitmask,  it is possible to implement those above incrementally.

Thanks
-Jeff



-Jeff


>
> > Each bit represents sealing for one specific syscall type, e.g.
> > MM_SEAL_MPROTECT will deny mprotect syscall. The consideration of bitma=
sk
> > is that the API is extendable, i.e. when needed, the sealing can be
> > extended to madvise, mlock, etc. Backward compatibility is also easy.
> >
> > The kernel will remember which seal types are applied, and the applicat=
ion
> > doesn=E2=80=99t need to repeat all existing seal types in the next msea=
l().  Once
> > a seal type is applied, it can=E2=80=99t be unsealed. Call mseal() on a=
n existing
> > seal type is a no-action, not a failure.
> >
> > MM_SEAL_MSEAL will deny mseal() calls that try to add a new seal type.
> >
> > Internally, vm_area_struct adds a new field vm_seals, to store the bit
> > masks.
> >
> > For the affected syscalls, such as mprotect, a check(can_modify_mm) for
> > sealing is added, this usually happens at the early point of the syscal=
l,
> > before any update is made to VMAs. The effect of that is: if any of the
> > VMAs in the given address range fails the sealing check, none of the VM=
A
> > will be updated. It might be worth noting that this is different from t=
he
> > rest of mprotect(), where some updates can happen even when mprotect
> > returns fail. Consider can_modify_mm only checks vm_seals in
> > vm_area_struct, and it is not going deeper in the page table or updatin=
g
> > any HW, success or none behavior might fit better here. I would like to
> > listen to the community's feedback on this.
> >
> > The idea that inspired this patch comes from Stephen R=C3=B6ttger=E2=80=
=99s work in
> > V8 CFI [5],  Chrome browser in ChromeOS will be the first user of this =
API.
> >
> > In addition, Stephen is working on glibc change to add sealing support
> > into the dynamic linker to seal all non-writable segments at startup. W=
hen
> > that work is completed, all applications can automatically benefit from
> > these new protections.
> >
> > [1] https://kernelnewbies.org/Linux_2_6_8
> > [2] https://v8.dev/blog/control-flow-integrity
> > [3] https://github.com/apple-oss-distributions/xnu/blob/1031c584a5e37af=
f177559b9f69dbd3c8c3fd30a/osfmk/mach/vm_statistics.h#L274
> > [4] https://man.openbsd.org/mimmutable.2
> > [5] https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwd=
vxQMyXgeaRHo/edit#heading=3Dh.bvaojj9fu6hc
> >
> > Jeff Xu (8):
> >   Add mseal syscall
> >   Wire up mseal syscall
> >   mseal: add can_modify_mm and can_modify_vma
> >   mseal: seal mprotect
> >   mseal munmap
> >   mseal mremap
> >   mseal mmap
> >   selftest mm/mseal mprotect/munmap/mremap/mmap
> >
> >  arch/alpha/kernel/syscalls/syscall.tbl      |    1 +
> >  arch/arm/tools/syscall.tbl                  |    1 +
> >  arch/arm64/include/asm/unistd.h             |    2 +-
> >  arch/arm64/include/asm/unistd32.h           |    2 +
> >  arch/ia64/kernel/syscalls/syscall.tbl       |    1 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |    1 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |    1 +
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 +
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 +
> >  arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |    1 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |    1 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |    1 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |    1 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |    1 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |    1 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |    1 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |    1 +
> >  fs/aio.c                                    |    5 +-
> >  include/linux/mm.h                          |   55 +-
> >  include/linux/mm_types.h                    |    7 +
> >  include/linux/syscalls.h                    |    2 +
> >  include/uapi/asm-generic/unistd.h           |    5 +-
> >  include/uapi/linux/mman.h                   |    6 +
> >  ipc/shm.c                                   |    3 +-
> >  kernel/sys_ni.c                             |    1 +
> >  mm/Kconfig                                  |    8 +
> >  mm/Makefile                                 |    1 +
> >  mm/internal.h                               |    4 +-
> >  mm/mmap.c                                   |   49 +-
> >  mm/mprotect.c                               |    6 +
> >  mm/mremap.c                                 |   19 +-
> >  mm/mseal.c                                  |  328 +++++
> >  mm/nommu.c                                  |    6 +-
> >  mm/util.c                                   |    8 +-
> >  tools/testing/selftests/mm/Makefile         |    1 +
> >  tools/testing/selftests/mm/mseal_test.c     | 1428 +++++++++++++++++++
> >  37 files changed, 1934 insertions(+), 28 deletions(-)
> >  create mode 100644 mm/mseal.c
> >  create mode 100644 tools/testing/selftests/mm/mseal_test.c
> >
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
