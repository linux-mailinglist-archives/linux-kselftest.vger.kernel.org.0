Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF7748B98
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjGESTo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 14:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjGESTZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 14:19:25 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F932110
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Jul 2023 11:18:31 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5701e8f2b79so83125977b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jul 2023 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688581088; x=1691173088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXjTLxu2B7e4dyW+lN0huxaA/BFi7Q1RInvMd8D9U8Q=;
        b=Y4uvDUUmj1tqpQpeoS4VBbISmEjEEw2FeJkvjMnffeRwwFotLZhRWBkR20BrCW5vOD
         6RBRuOTR+D1TCyzCIxfsJ9CjMyetH+qamjiLPgzNyH1dDCY8MX87o9HKytyVT77KG9g/
         mN/zm8jZ3RDshUWsYdZxWDpxg2uX4P2A7we5ECVgpUs0XGGFxcu/S80zxLkq5/ddk6+N
         3knTatCdseF/ArrI64EZqrjdUu5U8zfGljeTaJiL4jYrFEqjK7iAd6P54XwXcw47pC9/
         tmmRJADmlMxYxQPUCZq8KWRustM5fmAN5NwJE08OYmMXOMS28qfqUqytwrTzExcFGxhL
         LTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581088; x=1691173088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXjTLxu2B7e4dyW+lN0huxaA/BFi7Q1RInvMd8D9U8Q=;
        b=jowDiPSRoU7DVZNjR1NVYcQRURb8AGiJZb9WaRCbbgv2LuQaMf2YFlZus7Ebs4ZDHf
         7OGVReWlWXXUyYHJWuZYOQA7dZmx8KKviVRc4em2z5G0N4pEbgR0EiZvuv4Tm/yojB2N
         Y2h8FVe3Mh/W7fSMYmccO8oFGkwko00iExTQP+iYeAQ/7wnhmh1ABFHX0skHlsyb+llT
         llOfofiv9U235uoHpWPfeJvioRuCMGpHD5xC8HjiH9y2MRScWFhJ2nXGduAguq6sF7TH
         I6xs9XBIg/X2KV+rsiSu0mKA5IsBIHA50HGTw8OZWzHkihSB3vBMvvZCInD7KjDnLNkW
         gAMA==
X-Gm-Message-State: ABy/qLYGfUkNlR+NkSHwd0YJkeFMrVMKgzSYk/JCRljN8xvMUL0aL0wH
        UNOoKMdIiO27QaMF7QDEsfy8cuIuIMO0Yzoh4bE9lA==
X-Google-Smtp-Source: APBJJlE8o8ok+HyhEdL07SV3x+bVUYGTUYlszF16zjpm0S88a76rzm58d9Xx8etlC6+6THbE+sA902RQXva03earTRQ=
X-Received: by 2002:a0d:d595:0:b0:577:189b:121f with SMTP id
 x143-20020a0dd595000000b00577189b121fmr15572848ywd.40.1688581088499; Wed, 05
 Jul 2023 11:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230629205040.665834-1-axelrasmussen@google.com>
In-Reply-To: <20230629205040.665834-1-axelrasmussen@google.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Wed, 5 Jul 2023 11:17:57 -0700
Message-ID: <CACw3F53p8szcxv7PSOSqN6ps3hHmRD4VQor3pLd0Cqrn-p2Ajw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm: userfaultfd: add new UFFDIO_POISON ioctl
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 29, 2023 at 1:50=E2=80=AFPM Axel Rasmussen <axelrasmussen@googl=
e.com> wrote:
>
> The basic idea here is to "simulate" memory poisoning for VMs. A VM
> running on some host might encounter a memory error, after which some
> page(s) are poisoned (i.e., future accesses SIGBUS). They expect that
> once poisoned, pages can never become "un-poisoned". So, when we live
> migrate the VM, we need to preserve the poisoned status of these pages.
>
> When live migrating, we try to get the guest running on its new host as
> quickly as possible. So, we start it running before all memory has been
> copied, and before we're certain which pages should be poisoned or not.
>
> So the basic way to use this new feature is:
>
> - On the new host, the guest's memory is registered with userfaultfd, in
>   either MISSING or MINOR mode (doesn't really matter for this purpose).
> - On any first access, we get a userfaultfd event. At this point we can
>   communicate with the old host to find out if the page was poisoned.
> - If so, we can respond with a UFFDIO_POISON - this places a swap marker
>   so any future accesses will SIGBUS. Because the pte is now "present",
>   future accesses won't generate more userfaultfd events, they'll just
>   SIGBUS directly.
>
> UFFDIO_POISON does not handle unmapping previously-present PTEs. This

A minor suggestion, would UFFDIO_HWPOISON be better? so that readers
won't be confused with CONFIG_PAGE_POISONING (a feature to fill the
pages with poison patterns after free).

> isn't needed, because during live migration we want to intercept
> all accesses with userfaultfd (not just writes, so WP mode isn't useful
> for this). So whether minor or missing mode is being used (or both), the
> PTE won't be present in any case, so handling that case isn't needed.
>
> Why return VM_FAULT_HWPOISON instead of VM_FAULT_SIGBUS when one of
> these markers is encountered? For "normal" userspace programs there
> isn't a big difference, both yield a SIGBUS. The difference for KVM is
> key though: VM_FAULT_HWPOISON will result in an MCE being injected into
> the guest (which is the behavior we want). With VM_FAULT_SIGBUS, the
> hypervisor would need to catch the SIGBUS and deal with the MCE
> injection itself.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c                 | 63 ++++++++++++++++++++++++++++++++
>  include/linux/swapops.h          |  3 +-
>  include/linux/userfaultfd_k.h    |  4 ++
>  include/uapi/linux/userfaultfd.h | 25 +++++++++++--
>  mm/memory.c                      |  4 ++
>  mm/userfaultfd.c                 | 62 ++++++++++++++++++++++++++++++-
>  6 files changed, 156 insertions(+), 5 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 7cecd49e078b..c26a883399c9 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1965,6 +1965,66 @@ static int userfaultfd_continue(struct userfaultfd=
_ctx *ctx, unsigned long arg)
>         return ret;
>  }
>
> +static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsign=
ed long arg)
> +{
> +       __s64 ret;
> +       struct uffdio_poison uffdio_poison;
> +       struct uffdio_poison __user *user_uffdio_poison;
> +       struct userfaultfd_wake_range range;
> +
> +       user_uffdio_poison =3D (struct uffdio_poison __user *)arg;
> +
> +       ret =3D -EAGAIN;
> +       if (atomic_read(&ctx->mmap_changing))
> +               goto out;
> +
> +       ret =3D -EFAULT;
> +       if (copy_from_user(&uffdio_poison, user_uffdio_poison,
> +                          /* don't copy the output fields */
> +                          sizeof(uffdio_poison) - (sizeof(__s64))))
> +               goto out;
> +
> +       ret =3D validate_range(ctx->mm, uffdio_poison.range.start,
> +                            uffdio_poison.range.len);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D -EINVAL;
> +       /* double check for wraparound just in case. */
> +       if (uffdio_poison.range.start + uffdio_poison.range.len <=3D
> +           uffdio_poison.range.start) {
> +               goto out;
> +       }
> +       if (uffdio_poison.mode & ~UFFDIO_POISON_MODE_DONTWAKE)
> +               goto out;
> +
> +       if (mmget_not_zero(ctx->mm)) {
> +               ret =3D mfill_atomic_poison(ctx->mm, uffdio_poison.range.=
start,
> +                                         uffdio_poison.range.len,
> +                                         &ctx->mmap_changing, 0);
> +               mmput(ctx->mm);
> +       } else {
> +               return -ESRCH;
> +       }
> +
> +       if (unlikely(put_user(ret, &user_uffdio_poison->updated)))
> +               return -EFAULT;
> +       if (ret < 0)
> +               goto out;
> +
> +       /* len =3D=3D 0 would wake all */
> +       BUG_ON(!ret);
> +       range.len =3D ret;
> +       if (!(uffdio_poison.mode & UFFDIO_POISON_MODE_DONTWAKE)) {
> +               range.start =3D uffdio_poison.range.start;
> +               wake_userfault(ctx, &range);
> +       }
> +       ret =3D range.len =3D=3D uffdio_poison.range.len ? 0 : -EAGAIN;
> +
> +out:
> +       return ret;
> +}
> +
>  static inline unsigned int uffd_ctx_features(__u64 user_features)
>  {
>         /*
> @@ -2066,6 +2126,9 @@ static long userfaultfd_ioctl(struct file *file, un=
signed cmd,
>         case UFFDIO_CONTINUE:
>                 ret =3D userfaultfd_continue(ctx, arg);
>                 break;
> +       case UFFDIO_POISON:
> +               ret =3D userfaultfd_poison(ctx, arg);
> +               break;
>         }
>         return ret;
>  }
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 4c932cb45e0b..8259fee32421 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -394,7 +394,8 @@ typedef unsigned long pte_marker;
>
>  #define  PTE_MARKER_UFFD_WP                    BIT(0)
>  #define  PTE_MARKER_SWAPIN_ERROR               BIT(1)
> -#define  PTE_MARKER_MASK                       (BIT(2) - 1)
> +#define  PTE_MARKER_UFFD_POISON                        BIT(2)
> +#define  PTE_MARKER_MASK                       (BIT(3) - 1)
>
>  static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
>  {
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.=
h
> index ac7b0c96d351..ac8c6854097c 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -46,6 +46,7 @@ enum mfill_atomic_mode {
>         MFILL_ATOMIC_COPY,
>         MFILL_ATOMIC_ZEROPAGE,
>         MFILL_ATOMIC_CONTINUE,
> +       MFILL_ATOMIC_POISON,
>         NR_MFILL_ATOMIC_MODES,
>  };
>
> @@ -83,6 +84,9 @@ extern ssize_t mfill_atomic_zeropage(struct mm_struct *=
dst_mm,
>  extern ssize_t mfill_atomic_continue(struct mm_struct *dst_mm, unsigned =
long dst_start,
>                                      unsigned long len, atomic_t *mmap_ch=
anging,
>                                      uffd_flags_t flags);
> +extern ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned lo=
ng start,
> +                                  unsigned long len, atomic_t *mmap_chan=
ging,
> +                                  uffd_flags_t flags);
>  extern int mwriteprotect_range(struct mm_struct *dst_mm,
>                                unsigned long start, unsigned long len,
>                                bool enable_wp, atomic_t *mmap_changing);
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfa=
ultfd.h
> index 66dd4cd277bd..62151706c5a3 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -39,7 +39,8 @@
>                            UFFD_FEATURE_MINOR_SHMEM |           \
>                            UFFD_FEATURE_EXACT_ADDRESS |         \
>                            UFFD_FEATURE_WP_HUGETLBFS_SHMEM |    \
> -                          UFFD_FEATURE_WP_UNPOPULATED)
> +                          UFFD_FEATURE_WP_UNPOPULATED |        \
> +                          UFFD_FEATURE_POISON)
>  #define UFFD_API_IOCTLS                                \
>         ((__u64)1 << _UFFDIO_REGISTER |         \
>          (__u64)1 << _UFFDIO_UNREGISTER |       \
> @@ -49,12 +50,14 @@
>          (__u64)1 << _UFFDIO_COPY |             \
>          (__u64)1 << _UFFDIO_ZEROPAGE |         \
>          (__u64)1 << _UFFDIO_WRITEPROTECT |     \
> -        (__u64)1 << _UFFDIO_CONTINUE)
> +        (__u64)1 << _UFFDIO_CONTINUE |         \
> +        (__u64)1 << _UFFDIO_POISON)
>  #define UFFD_API_RANGE_IOCTLS_BASIC            \
>         ((__u64)1 << _UFFDIO_WAKE |             \
>          (__u64)1 << _UFFDIO_COPY |             \
> +        (__u64)1 << _UFFDIO_WRITEPROTECT |     \
>          (__u64)1 << _UFFDIO_CONTINUE |         \
> -        (__u64)1 << _UFFDIO_WRITEPROTECT)
> +        (__u64)1 << _UFFDIO_POISON)
>
>  /*
>   * Valid ioctl command number range with this API is from 0x00 to
> @@ -71,6 +74,7 @@
>  #define _UFFDIO_ZEROPAGE               (0x04)
>  #define _UFFDIO_WRITEPROTECT           (0x06)
>  #define _UFFDIO_CONTINUE               (0x07)
> +#define _UFFDIO_POISON                 (0x08)
>  #define _UFFDIO_API                    (0x3F)
>
>  /* userfaultfd ioctl ids */
> @@ -91,6 +95,8 @@
>                                       struct uffdio_writeprotect)
>  #define UFFDIO_CONTINUE                _IOWR(UFFDIO, _UFFDIO_CONTINUE, \
>                                       struct uffdio_continue)
> +#define UFFDIO_POISON          _IOWR(UFFDIO, _UFFDIO_POISON, \
> +                                     struct uffdio_poison)
>
>  /* read() structure */
>  struct uffd_msg {
> @@ -225,6 +231,7 @@ struct uffdio_api {
>  #define UFFD_FEATURE_EXACT_ADDRESS             (1<<11)
>  #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM                (1<<12)
>  #define UFFD_FEATURE_WP_UNPOPULATED            (1<<13)
> +#define UFFD_FEATURE_POISON                    (1<<14)
>         __u64 features;
>
>         __u64 ioctls;
> @@ -321,6 +328,18 @@ struct uffdio_continue {
>         __s64 mapped;
>  };
>
> +struct uffdio_poison {
> +       struct uffdio_range range;
> +#define UFFDIO_POISON_MODE_DONTWAKE            ((__u64)1<<0)
> +       __u64 mode;
> +
> +       /*
> +        * Fields below here are written by the ioctl and must be at the =
end:
> +        * the copy_from_user will not read past here.
> +        */
> +       __s64 updated;
> +};
> +
>  /*
>   * Flags for the userfaultfd(2) system call itself.
>   */
> diff --git a/mm/memory.c b/mm/memory.c
> index d8a9a770b1f1..7fbda39e060d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3692,6 +3692,10 @@ static vm_fault_t handle_pte_marker(struct vm_faul=
t *vmf)
>         if (WARN_ON_ONCE(!marker))
>                 return VM_FAULT_SIGBUS;
>
> +       /* Poison emulation explicitly requested for this PTE. */
> +       if (marker & PTE_MARKER_UFFD_POISON)
> +               return VM_FAULT_HWPOISON;
> +
>         /* Higher priority than uffd-wp when data corrupted */
>         if (marker & PTE_MARKER_SWAPIN_ERROR)
>                 return VM_FAULT_SIGBUS;
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index a2bf37ee276d..87b62ca1e09e 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -286,6 +286,51 @@ static int mfill_atomic_pte_continue(pmd_t *dst_pmd,
>         goto out;
>  }
>
> +/* Handles UFFDIO_POISON for all non-hugetlb VMAs. */
> +static int mfill_atomic_pte_poison(pmd_t *dst_pmd,
> +                                  struct vm_area_struct *dst_vma,
> +                                  unsigned long dst_addr,
> +                                  uffd_flags_t flags)
> +{
> +       int ret;
> +       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> +       pte_t _dst_pte, *dst_pte;
> +       spinlock_t *ptl;
> +
> +       _dst_pte =3D make_pte_marker(PTE_MARKER_UFFD_POISON);
> +       dst_pte =3D pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
> +
> +       if (vma_is_shmem(dst_vma)) {
> +               struct inode *inode;
> +               pgoff_t offset, max_off;
> +
> +               /* serialize against truncate with the page table lock */
> +               inode =3D dst_vma->vm_file->f_inode;
> +               offset =3D linear_page_index(dst_vma, dst_addr);
> +               max_off =3D DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +               ret =3D -EFAULT;
> +               if (unlikely(offset >=3D max_off))
> +                       goto out_unlock;
> +       }
> +
> +       ret =3D -EEXIST;
> +       /*
> +        * For now, we don't handle unmapping pages, so only support fill=
ing in
> +        * none PTEs, or replacing PTE markers.
> +        */
> +       if (!pte_none_mostly(*dst_pte))
> +               goto out_unlock;
> +
> +       set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> +
> +       /* No need to invalidate - it was non-present before */
> +       update_mmu_cache(dst_vma, dst_addr, dst_pte);
> +       ret =3D 0;
> +out_unlock:
> +       pte_unmap_unlock(dst_pte, ptl);
> +       return ret;
> +}
> +
>  static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
>  {
>         pgd_t *pgd;
> @@ -336,8 +381,12 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>          * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
>          * by THP.  Since we can not reliably insert a zero page, this
>          * feature is not supported.
> +        *
> +        * PTE marker handling for hugetlb is a bit special, so for now
> +        * UFFDIO_POISON is not supported.
>          */
> -       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> +       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
> +           uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
>                 mmap_read_unlock(dst_mm);
>                 return -EINVAL;
>         }
> @@ -481,6 +530,9 @@ static __always_inline ssize_t mfill_atomic_pte(pmd_t=
 *dst_pmd,
>         if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE)) {
>                 return mfill_atomic_pte_continue(dst_pmd, dst_vma,
>                                                  dst_addr, flags);
> +       } else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
> +               return mfill_atomic_pte_poison(dst_pmd, dst_vma,
> +                                              dst_addr, flags);
>         }
>
>         /*
> @@ -702,6 +754,14 @@ ssize_t mfill_atomic_continue(struct mm_struct *dst_=
mm, unsigned long start,
>                             uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTI=
NUE));
>  }
>
> +ssize_t mfill_atomic_poison(struct mm_struct *dst_mm, unsigned long star=
t,
> +                           unsigned long len, atomic_t *mmap_changing,
> +                           uffd_flags_t flags)
> +{
> +       return mfill_atomic(dst_mm, start, 0, len, mmap_changing,
> +                           uffd_flags_set_mode(flags, MFILL_ATOMIC_POISO=
N));
> +}
> +
>  long uffd_wp_range(struct vm_area_struct *dst_vma,
>                    unsigned long start, unsigned long len, bool enable_wp=
)
>  {
> --
> 2.41.0.255.g8b1d071c50-goog
>
