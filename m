Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0899B38006A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 May 2021 00:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbhEMWfk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 May 2021 18:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhEMWf0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 May 2021 18:35:26 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6CFC06138C
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 15:34:09 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id o9so19178141ilh.6
        for <linux-kselftest@vger.kernel.org>; Thu, 13 May 2021 15:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8bhFuOKPloIYByahwHFPWgdmRy0Ur+KOze97z1EzA0=;
        b=iQT7fUSjjkfA0Y/arLSkMA8VtoCxAmrQNAbRo05lrk8GrcQ4uFWjZgG8YdpwKq0ET8
         wpthMbxKqa4X10x2vA+MQoydIYL1lkvxj1WzZ97mamD1dhde8dR9QQSpwqPWuLwGjY4R
         fZM8lMwSNcNG3RIqhnOKM7gElhOgslMaKQ9cO0QcXgatiOiK6txOfI02+ziSFMT6rhP5
         qqhhbxr8PoJ9dcX+mvpQsZvOxRqzuvPJX/KU7RUFAZD/l8VV2QNHOGFe3Zi1eXZH/NRv
         F90HXjtqSQYfBHcS46F+HBJlugCcRcewa9hjd3I0RZoKj5P+TXZGSmIfZ8MEkquFUu4x
         ypmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8bhFuOKPloIYByahwHFPWgdmRy0Ur+KOze97z1EzA0=;
        b=gXb20PYT9uZqkY//VnI1D7VDaPazY+tlieEUpRJpvEs26Wcum1dwozTYqMIuCurbFU
         Wqjo+UbNTk4STyBQpu5Z74eYEVxbjXjQsEkq4MF/xWwNnI/lm6mARGF57j7OWUSDyrxp
         lJ7cr6zR0tcs7nFZ6BK1VtENWIF5A013rXcsLPx0kugHfVETWpNv6I/DwjhKLHNBYEc/
         cqSvOC5mv0fTTMQUXEJpOkBg88sTk8YT461NPjh2yNGUYsw7JhoO4y2U2IEg+ndoLDR8
         wWl/LXUckolTwCwy1161H5KZaWbf8Mvqi4HP6ctOYsxXwv88h4Z8HcrsZL5AN58IfdcP
         D0UA==
X-Gm-Message-State: AOAM531plfKaAT3xtyHFE1uKNHGoUfMA25dgO2SEJvbL9UWAtB/vhHxZ
        2R93cQ43jI+uouDc26oizkz94WGuBz0Jdw4nk9gGug==
X-Google-Smtp-Source: ABdhPJwavDpIShEpPQaY3KOf9GpUa8lYR73uNHBcU0Gl+rAsejweOnelYA5pihcsuee289UCspem5+8RWG0EU1BR3k4=
X-Received: by 2002:a05:6e02:1a49:: with SMTP id u9mr40315598ilv.306.1620945248421;
 Thu, 13 May 2021 15:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com> <20210512214502.2047008-4-axelrasmussen@google.com>
In-Reply-To: <20210512214502.2047008-4-axelrasmussen@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 13 May 2021 15:33:57 -0700
Message-ID: <CANgfPd915=4=dYmxh=qn6Cu75S4uHL753h_x3JHG-mFyO0dggg@mail.gmail.com>
Subject: Re: [PATCH 3/5] KVM: selftests: create alias mappings when using
 shared memory
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 12, 2021 at 2:45 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> When a memory region is added with a src_type specifying that it should
> use some kind of shared memory, also create an alias mapping to the same
> underlying physical pages.
>
> And, add an API so tests can get access to these alias addresses.
> Basically, for a guest physical address, let us look up the analogous
> host *alias* address.
>
> In a future commit, we'll modify the demand paging test to take
> advantage of this to exercise UFFD minor faults. The idea is, we
> pre-fault the underlying pages *via the alias*. When the *guest*
> faults, it gets a "minor" fault (PTEs don't exist yet, but a page is
> already in the page cache). Then, the userfaultfd theads can handle the
> fault: they could potentially modify the underlying memory *via the
> alias* if they wanted to, and then they install the PTEs and let the
> guest carry on via a UFFDIO_CONTINUE ioctl.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 50 +++++++++++++++++++
>  .../selftests/kvm/lib/kvm_util_internal.h     |  2 +
>  3 files changed, 53 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index a8f022794ce3..0624f25a6803 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -146,6 +146,7 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
>  void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
>  void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
>  vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
> +void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
>
>  /*
>   * Address Guest Virtual to Guest Physical
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 6fbe124e0e16..838d58633f7e 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -809,6 +809,19 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>
>         /* Add to linked-list of memory regions. */
>         list_add(&region->list, &vm->userspace_mem_regions);
> +
> +       /* If shared memory, create an alias. */
> +       if (region->fd >= 0) {
> +               region->mmap_alias = mmap(NULL, region->mmap_size,
> +                                         PROT_READ | PROT_WRITE,
> +                                         vm_mem_backing_src_alias(src_type)->flag,
> +                                         region->fd, 0);
> +               TEST_ASSERT(region->mmap_alias != MAP_FAILED,
> +                           "mmap of alias failed, errno: %i", errno);
> +
> +               /* Align host alias address */
> +               region->host_alias = align(region->mmap_alias, alignment);
> +       }
>  }
>
>  /*
> @@ -1237,6 +1250,43 @@ vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva)
>         return -1;
>  }
>
> +/*
> + * Address VM physical to Host Virtual *alias*.
> + *
> + * Input Args:
> + *   vm - Virtual Machine
> + *   gpa - VM physical address
> + *
> + * Output Args: None
> + *
> + * Return:
> + *   Equivalent address within the host virtual *alias* area, or NULL
> + *   (without failing the test) if the guest memory is not shared (so
> + *   no alias exists).
> + *
> + * When vm_create() and related functions are called with a shared memory
> + * src_type, we also create a writable, shared alias mapping of the
> + * underlying guest memory. This allows the host to manipulate guest memory,
> + * e.g. to implement demand paging.

I would amend this to: "This allows the host to manipulate guest
memory without mapping that memory in the guest's address space," or
something to that effect.

> + */
> +void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
> +{
> +       struct userspace_mem_region *region;
> +
> +       list_for_each_entry(region, &vm->userspace_mem_regions, list) {
> +               if (!region->host_alias)
> +                       continue;
> +
> +               if ((gpa >= region->region.guest_phys_addr)
> +                       && (gpa <= (region->region.guest_phys_addr
> +                               + region->region.memory_size - 1)))
> +                       return (void *) ((uintptr_t) region->host_alias
> +                               + (gpa - region->region.guest_phys_addr));
> +       }
> +
> +       return NULL;
> +}
> +
>  /*
>   * VM Create IRQ Chip
>   *
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> index 91ce1b5d480b..a25af33d4a9c 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> +++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
> @@ -16,7 +16,9 @@ struct userspace_mem_region {
>         int fd;
>         off_t offset;
>         void *host_mem;
> +       void *host_alias;
>         void *mmap_start;
> +       void *mmap_alias;
>         size_t mmap_size;
>         struct list_head list;
>  };
> --
> 2.31.1.607.g51e8a6a459-goog
>
