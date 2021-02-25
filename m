Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106F8325A5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Feb 2021 00:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhBYXp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Feb 2021 18:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhBYXpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Feb 2021 18:45:20 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ECFC06174A
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Feb 2021 15:44:40 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id q9so6548282ilo.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Feb 2021 15:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLG1p58PGnMeY59AWuFvydGWLoGBCF7NOPt6FH+DeFY=;
        b=heegkJvkrTBZirIS56mT/RBkWAmZwf/NMGW4/ZI0wY4XFSepwTMXcfEs8vlEQ3UpWE
         AsizNPevw//YyLeJciOVLFdlcHc/6i6y3vlcDpzOPRamaF0e/QUGSsgHRcEa+y8xgO7y
         1ohxFWP38vpxKlsbj2JxS2iqbASH1qqlDg6X3+kFob0vqlUARsPG8lJpEtoyt0B77HrR
         9XmvSFzxvyPBwJg7ixL61/vwx0YOoL+M2+wXz/DrkI86wjOqRfX54hhiA5OHGV+Y41RN
         aZK+HJcWADj1E4IKNABpA2CeEhklAGH3SXV5ykkjeiYkekW42pQmjGTf3EfZUXVL2CgX
         ul9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLG1p58PGnMeY59AWuFvydGWLoGBCF7NOPt6FH+DeFY=;
        b=MO3p22TS30m6MyIn7s3vjBrwq9rv57tnSweQGRb9Fy1oL5ivrx0nRfbjAQcOr4R0iD
         nhX2FtLUUmeqakkx/oj+OKg2Vv47KOZyPoNHH5V5l7cK+3hyQxTMzjllUXwcGsYy9KtL
         wp1oRF4LqOtB8kSYCgiZ/3ecx4yWgOtPhzYfZoMYX8GoCJ3AZG0iexOfyEAYCZwGe1Cn
         swcWRPixQtBU7LW6WYq5/k+LqILO37OBLnou+qxtF9yAbHCWzll++fTVACEr2U0wDrLw
         IoV/HdLtiCyNT2piyFPgk2D7tQTrvGgcTawNmWwm8AIG+uG3wQB6NLWN+0vIkg+TqT+L
         jqPA==
X-Gm-Message-State: AOAM532D18JfHVxbmTE6xQiRGxZfU/7L/K+26yX2F+9j/huw6aB5iewR
        kSaQ8q5khJIp5LAtzVcP2nQLJDQyFiBiI2WX8L2UTg==
X-Google-Smtp-Source: ABdhPJzqvt2pkVZczh1txxMCAeHftiBFSQXbJ1LIWZAsfWb9xX+u9eYQttwySMwGKTNFi/j9LIs2a1vFB9RCZv1p9GQ=
X-Received: by 2002:a05:6e02:1888:: with SMTP id o8mr151577ilu.154.1614296679963;
 Thu, 25 Feb 2021 15:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20210225055940.18748-1-wangyanan55@huawei.com> <20210225055940.18748-7-wangyanan55@huawei.com>
In-Reply-To: <20210225055940.18748-7-wangyanan55@huawei.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 25 Feb 2021 15:44:28 -0800
Message-ID: <CANgfPd9EF6Yc_SAR9sRY7oXMx3um+6phb71yNL=AsHDV4+tCRA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] KVM: selftests: Adapt vm_userspace_mem_region_add
 to new helpers
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm <kvm@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 24, 2021 at 10:03 PM Yanan Wang <wangyanan55@huawei.com> wrote:
>
> With VM_MEM_SRC_ANONYMOUS_THP specified in vm_userspace_mem_region_add(),
> we have to get the transparent hugepage size for HVA alignment. With the
> new helpers, we can use get_backing_src_pagesz() to check whether THP is
> configured and then get the exact configured hugepage size.
>
> As different architectures may have different THP page sizes configured,
> this can get the accurate THP page sizes on any platform.
>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 27 +++++++---------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index b91c8e3a7ee1..0105fbfed036 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -18,7 +18,6 @@
>  #include <unistd.h>
>  #include <linux/kernel.h>
>
> -#define KVM_UTIL_PGS_PER_HUGEPG 512
>  #define KVM_UTIL_MIN_PFN       2
>
>  /* Aligns x up to the next multiple of size. Size must be a power of 2. */
> @@ -686,7 +685,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>  {
>         int ret;
>         struct userspace_mem_region *region;
> -       size_t huge_page_size = KVM_UTIL_PGS_PER_HUGEPG * vm->page_size;
> +       size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
>         size_t alignment;
>
>         TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
> @@ -748,7 +747,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>  #endif
>
>         if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
> -               alignment = max(huge_page_size, alignment);
> +               alignment = max(backing_src_pagesz, alignment);
>
>         /* Add enough memory to align up if necessary */
>         if (alignment > 1)
> @@ -767,22 +766,12 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>         region->host_mem = align(region->mmap_start, alignment);
>
>         /* As needed perform madvise */
> -       if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
> -               struct stat statbuf;
> -
> -               ret = stat("/sys/kernel/mm/transparent_hugepage", &statbuf);
> -               TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
> -                           "stat /sys/kernel/mm/transparent_hugepage");
> -
> -               TEST_ASSERT(ret == 0 || src_type != VM_MEM_SRC_ANONYMOUS_THP,
> -                           "VM_MEM_SRC_ANONYMOUS_THP requires THP to be configured in the host kernel");
> -
> -               if (ret == 0) {
> -                       ret = madvise(region->host_mem, npages * vm->page_size,
> -                                     src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
> -                       TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %x",
> -                                   region->host_mem, npages * vm->page_size, src_type);
> -               }
> +       if (src_type <= VM_MEM_SRC_ANONYMOUS_THP && thp_configured()) {

This check relies on an unstated property of the backing src type
enums where VM_MEM_SRC_ANONYMOUS and VM_MEM_SRC_ANONYMOUS_THP are
declared first.
It would probably be more readable for folks if the check was explicit:
if ((src_type == VM_MEM_SRC_ANONYMOUS || src_type ==
VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {


> +               ret = madvise(region->host_mem, npages * vm->page_size,
> +                             src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
> +               TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
> +                           region->host_mem, npages * vm->page_size,
> +                           vm_mem_backing_src_alias(src_type)->name);
>         }
>
>         region->unused_phy_pages = sparsebit_alloc();
> --
> 2.19.1
>
