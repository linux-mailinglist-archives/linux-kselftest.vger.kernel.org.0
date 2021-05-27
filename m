Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE03932EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhE0P4E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 May 2021 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbhE0P4E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 May 2021 11:56:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08549C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 08:54:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a5so904942lfm.0
        for <linux-kselftest@vger.kernel.org>; Thu, 27 May 2021 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=si4bZGT6UWZDcxNapGYxNQN+Ga6Xu5y16MozxfyXdx8=;
        b=ftSLp/bnXXqjvZwQkcI38JOab6H3xJHrUczkyOfrknEOOSz0G7idUJorPnhzIYSURh
         dF1dWBULgxU5icnNJrQV+VH4+m10hKsefr9yaEV3tTbr7DDutdPEvxAV21C8jbSEfWqU
         0OPHFnaQag7dLirQdivMvnqRTu0+5MnERsIfLNwZoEBvRjXpFKNSlUJsuh28J3VErx6F
         N6Wr8moHeW7Fw1sZ+ffvpaXsjdmPnOwTmGjvlsCeOta+BLf9MDJ4aps5sekNG3XcXVxL
         jtv6UFjB928EQi1yevKa7Ld9wV3bBv9qvfG5B4tK1XjEO12KdvV0QdhvuUukUSMrEo0S
         WM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=si4bZGT6UWZDcxNapGYxNQN+Ga6Xu5y16MozxfyXdx8=;
        b=AA2zBWL0pM0mk2AkrQpzjFRFH6JSN5QZ9WO4pYmZzp20xkAoCb0dOQvd0gSOnie/Eo
         eZ7ZzijZ5rCA29ncfqq3GRfPGnINhPaKJynRbZawHJO/VHmyRcPSlJo08oQ3RKvcPgnb
         IlpvqGYnqdrz3S5zwVEmpFxuyyj3hXaiDqvLmnLayMck/sO/OL+m9mVNxnIGNGOBMfkU
         1ZqxIoibrByt7p/nYFN/BGOATXvWqFiRB0mVGWBY+084aiWZdJOi+gWQ4sBsZL5spFdV
         +Dci6XnPdvtbHO/GIEzhG/qxtvJoLquSxEDMwDiVRoVTYnBzeZyrho/lcmHIog4nHpOo
         zlmA==
X-Gm-Message-State: AOAM530izjGektPIxcBH/PiM6gk64wkps1LLdszra2UcgKXRByFJMyAi
        uiGtHif7CEvTXCfRdgVqikc4n1tvEmJPqi67dan++A==
X-Google-Smtp-Source: ABdhPJzmOJcg8wZZMDTZWT33t97iXrEeo69CAvEHEEPARmsHZgmi6jy/VSYVgDsBAc6TGwCnRbkC3CT+kTQUgW7rJgI=
X-Received: by 2002:a05:6512:3d8a:: with SMTP id k10mr2781848lfv.473.1622130868033;
 Thu, 27 May 2021 08:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210524151828.4113777-1-jingzhangos@google.com>
 <20210524151828.4113777-5-jingzhangos@google.com> <bad9e2cb-0e23-f2ea-054f-23556dbfd7e1@oracle.com>
In-Reply-To: <bad9e2cb-0e23-f2ea-054f-23556dbfd7e1@oracle.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 27 May 2021 10:54:17 -0500
Message-ID: <CAAdAUtjoSUVDeZs4VzBPYVEt87JrQN4RCGhViqrW67unn8zRJA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] KVM: selftests: Add selftest for KVM statistics
 data binary interface
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Krish,

On Wed, May 26, 2021 at 5:34 PM Krish Sadhukhan
<krish.sadhukhan@oracle.com> wrote:
>
>
> On 5/24/21 8:18 AM, Jing Zhang wrote:
> > Add selftest to check KVM stats descriptors validity.
> >
> > Reviewed-by: David Matlack <dmatlack@google.com>
> > Reviewed-by: Ricardo Koller <ricarkol@google.com>
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >   tools/testing/selftests/kvm/.gitignore        |   1 +
> >   tools/testing/selftests/kvm/Makefile          |   3 +
> >   .../testing/selftests/kvm/include/kvm_util.h  |   3 +
> >   .../selftests/kvm/kvm_bin_form_stats.c        | 216 ++++++++++++++++++
> >   tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
> >   5 files changed, 235 insertions(+)
> >   create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c
>
>
> We should probably follow the naming convention for the majority of the
> files in the kvm directory and name it kvm_stats_read_test.c or
> kvm_stats_test.c or something like that.
>
Sure. Will change the name.
> >
> > diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> > index bd83158e0e0b..35796667c944 100644
> > --- a/tools/testing/selftests/kvm/.gitignore
> > +++ b/tools/testing/selftests/kvm/.gitignore
> > @@ -43,3 +43,4 @@
> >   /memslot_modification_stress_test
> >   /set_memory_region_test
> >   /steal_time
> > +/kvm_bin_form_stats
> > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> > index e439d027939d..2984c86c848a 100644
> > --- a/tools/testing/selftests/kvm/Makefile
> > +++ b/tools/testing/selftests/kvm/Makefile
> > @@ -76,6 +76,7 @@ TEST_GEN_PROGS_x86_64 += kvm_page_table_test
> >   TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
> >   TEST_GEN_PROGS_x86_64 += set_memory_region_test
> >   TEST_GEN_PROGS_x86_64 += steal_time
> > +TEST_GEN_PROGS_x86_64 += kvm_bin_form_stats
> >
> >   TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
> >   TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
> > @@ -87,6 +88,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
> >   TEST_GEN_PROGS_aarch64 += kvm_page_table_test
> >   TEST_GEN_PROGS_aarch64 += set_memory_region_test
> >   TEST_GEN_PROGS_aarch64 += steal_time
> > +TEST_GEN_PROGS_aarch64 += kvm_bin_form_stats
> >
> >   TEST_GEN_PROGS_s390x = s390x/memop
> >   TEST_GEN_PROGS_s390x += s390x/resets
> > @@ -96,6 +98,7 @@ TEST_GEN_PROGS_s390x += dirty_log_test
> >   TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
> >   TEST_GEN_PROGS_s390x += kvm_page_table_test
> >   TEST_GEN_PROGS_s390x += set_memory_region_test
> > +TEST_GEN_PROGS_s390x += kvm_bin_form_stats
> >
> >   TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
> >   LIBKVM += $(LIBKVM_$(UNAME_M))
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index a8f022794ce3..ee01a67022d9 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -387,4 +387,7 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
> >   #define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
> >       __GUEST_ASSERT((_condition), 4, (arg1), (arg2), (arg3), (arg4))
> >
> > +int vm_get_statsfd(struct kvm_vm *vm);
> > +int vcpu_get_statsfd(struct kvm_vm *vm, uint32_t vcpuid);
> > +
> >   #endif /* SELFTEST_KVM_UTIL_H */
> > diff --git a/tools/testing/selftests/kvm/kvm_bin_form_stats.c b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
> > new file mode 100644
> > index 000000000000..09e12c5838af
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/kvm_bin_form_stats.c
> > @@ -0,0 +1,216 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * kvm_bin_form_stats
> > + *
> > + * Copyright (C) 2021, Google LLC.
> > + *
> > + * Test the fd-based interface for KVM statistics.
> > + */
> > +
> > +#define _GNU_SOURCE /* for program_invocation_short_name */
> > +#include <fcntl.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +
> > +#include "test_util.h"
> > +
> > +#include "kvm_util.h"
> > +#include "asm/kvm.h"
> > +#include "linux/kvm.h"
> > +
> > +int stats_test(int stats_fd, int size_stat)
>
>
> The return value is not used by the caller. Perhaps make it a void ?
>
Will do.
> > +{
> > +     ssize_t ret;
> > +     int i;
> > +     size_t size_desc, size_data = 0;
> > +     struct kvm_stats_header header;
> > +     struct kvm_stats_desc *stats_desc, *pdesc;
> > +     void *stats_data;
> > +
> > +     /* Read kvm stats header */
> > +     ret = read(stats_fd, &header, sizeof(header));
> > +     TEST_ASSERT(ret == sizeof(header), "Read stats header");
> > +     size_desc = sizeof(*stats_desc) + header.name_size;
> > +
> > +     /* Check id string in header, that should start with "kvm" */
> > +     TEST_ASSERT(!strncmp(header.id, "kvm", 3) &&
> > +                     strlen(header.id) < KVM_STATS_ID_MAXLEN,
> > +                     "Invalid KVM stats type");
> > +
> > +     /* Sanity check for other fields in header */
> > +     if (header.count == 0)
>
>
> Does this need a message as to why count is zero ?
>
Will add a warning message here.
> > +             return 0;
> > +     /* Check overlap */
> > +     TEST_ASSERT(header.desc_offset > 0 && header.data_offset > 0
> > +                     && header.desc_offset >= sizeof(header)
> > +                     && header.data_offset >= sizeof(header),
> > +                     "Invalid offset fields in header");
> > +     TEST_ASSERT(header.desc_offset > header.data_offset
> > +                     || (header.desc_offset + size_desc * header.count <=
> > +                             header.data_offset),
> > +                     "Descriptor block is overlapped with data block");
> > +
> > +     /* Allocate memory for stats descriptors */
> > +     stats_desc = calloc(header.count, size_desc);
> > +     TEST_ASSERT(stats_desc, "Allocate memory for stats descriptors");
> > +     /* Read kvm stats descriptors */
> > +     ret = pread(stats_fd, stats_desc,
> > +                     size_desc * header.count, header.desc_offset);
> > +     TEST_ASSERT(ret == size_desc * header.count,
> > +                     "Read KVM stats descriptors");
> > +
> > +     /* Sanity check for fields in descriptors */
> > +     for (i = 0; i < header.count; ++i) {
> > +             pdesc = (void *)stats_desc + i * size_desc;
> > +             /* Check type,unit,base boundaries */
> > +             TEST_ASSERT((pdesc->flags & KVM_STATS_TYPE_MASK)
> > +                             <= KVM_STATS_TYPE_MAX, "Unknown KVM stats type");
> > +             TEST_ASSERT((pdesc->flags & KVM_STATS_UNIT_MASK)
> > +                             <= KVM_STATS_UNIT_MAX, "Unknown KVM stats unit");
> > +             TEST_ASSERT((pdesc->flags & KVM_STATS_BASE_MASK)
> > +                             <= KVM_STATS_BASE_MAX, "Unknown KVM stats base");
> > +             /* Check exponent for stats unit
> > +              * Exponent for counter should be greater than or equal to 0
> > +              * Exponent for unit bytes should be greater than or equal to 0
> > +              * Exponent for unit seconds should be less than or equal to 0
> > +              * Exponent for unit clock cycles should be greater than or
> > +              * equal to 0
> > +              */
> > +             switch (pdesc->flags & KVM_STATS_UNIT_MASK) {
> > +             case KVM_STATS_UNIT_NONE:
> > +             case KVM_STATS_UNIT_BYTES:
> > +             case KVM_STATS_UNIT_CYCLES:
> > +                     TEST_ASSERT(pdesc->exponent >= 0,
> > +                                     "Unsupported KVM stats unit");
> > +                     break;
> > +             case KVM_STATS_UNIT_SECONDS:
> > +                     TEST_ASSERT(pdesc->exponent <= 0,
> > +                                     "Unsupported KVM stats unit");
> > +                     break;
> > +             }
> > +             /* Check name string */
> > +             TEST_ASSERT(strlen(pdesc->name) < header.name_size,
> > +                             "KVM stats name(%s) too long", pdesc->name);
> > +             /* Check size field, which should not be zero */
> > +             TEST_ASSERT(pdesc->size, "KVM descriptor(%s) with size of 0",
> > +                             pdesc->name);
> > +             size_data += pdesc->size * size_stat;
> > +     }
> > +     /* Check overlap */
> > +     TEST_ASSERT(header.data_offset >= header.desc_offset
> > +                     || header.data_offset + size_data <= header.desc_offset,
> > +                     "Data block is overlapped with Descriptor block");
> > +     /* Check validity of all stats data size */
> > +     TEST_ASSERT(size_data >= header.count * size_stat,
> > +                     "Data size is not correct");
> > +
> > +     /* Allocate memory for stats data */
> > +     stats_data = malloc(size_data);
> > +     TEST_ASSERT(stats_data, "Allocate memory for stats data");
> > +     /* Read kvm stats data as a bulk */
> > +     ret = pread(stats_fd, stats_data, size_data, header.data_offset);
> > +     TEST_ASSERT(ret == size_data, "Read KVM stats data");
> > +     /* Read kvm stats data one by one */
> > +     size_data = 0;
> > +     for (i = 0; i < header.count; ++i) {
> > +             pdesc = (void *)stats_desc + i * size_desc;
> > +             ret = pread(stats_fd, stats_data, pdesc->size * size_stat,
> > +                             header.data_offset + size_data);
> > +             TEST_ASSERT(ret == pdesc->size * size_stat,
> > +                             "Read data of KVM stats: %s", pdesc->name);
> > +             size_data += pdesc->size * size_stat;
> > +     }
> > +
> > +     free(stats_data);
> > +     free(stats_desc);
> > +     return 0;
> > +}
> > +
> > +
> > +int vm_stats_test(struct kvm_vm *vm)
> > +{
> > +     int stats_fd;
> > +     struct kvm_vm_stats_data *stats_data;
> > +
> > +     /* Get fd for VM stats */
> > +     stats_fd = vm_get_statsfd(vm);
> > +     TEST_ASSERT(stats_fd >= 0, "Get VM stats fd");
> > +
> > +     stats_test(stats_fd, sizeof(stats_data->value[0]));
> > +     close(stats_fd);
> > +
> > +     return 0;
> > +}
> > +
> > +int vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
> > +{
> > +     int stats_fd;
> > +     struct kvm_vcpu_stats_data *stats_data;
> > +
> > +     /* Get fd for VCPU stats */
> > +     stats_fd = vcpu_get_statsfd(vm, vcpu_id);
> > +     TEST_ASSERT(stats_fd >= 0, "Get VCPU stats fd");
> > +
> > +     stats_test(stats_fd, sizeof(stats_data->value[0]));
> > +     close(stats_fd);
> > +
> > +     return 0;
> > +}
> > +
> > +#define DEFAULT_NUM_VM               4
> > +#define DEFAULT_NUM_VCPU     4
> > +
> > +/*
> > + * Usage: kvm_bin_form_stats [#vm] [#vcpu]
> > + * The first parameter #vm set the number of VMs being created.
> > + * The second parameter #vcpu set the number of VCPUs being created.
> > + * By default, DEFAULT_NUM_VM VM and DEFAULT_NUM_VCPU VCPU for the VM would be
> > + * created for testing.
> > + */
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     int max_vm = DEFAULT_NUM_VM, max_vcpu = DEFAULT_NUM_VCPU, ret, i, j;
> > +     struct kvm_vm **vms;
> > +
> > +     /* Get the number of VMs and VCPUs that would be created for testing. */
> > +     if (argc > 1) {
> > +             max_vm = strtol(argv[1], NULL, 0);
> > +             if (max_vm <= 0)
> > +                     max_vm = DEFAULT_NUM_VM;
> > +     }
> > +     if (argc > 2) {
> > +             max_vcpu = strtol(argv[2], NULL, 0);
> > +             if (max_vcpu <= 0)
> > +                     max_vcpu = DEFAULT_NUM_VCPU;
> > +     }
> > +
> > +     /* Check the extension for binary stats */
> > +     ret = kvm_check_cap(KVM_CAP_STATS_BINARY_FD);
> > +     TEST_ASSERT(ret >= 0,
> > +                     "Binary form statistics interface is not supported");
> > +
> > +     /* Create VMs and VCPUs */
> > +     vms = malloc(sizeof(vms[0]) * max_vm);
> > +     TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
> > +     for (i = 0; i < max_vm; ++i) {
> > +             vms[i] = vm_create(VM_MODE_DEFAULT,
> > +                             DEFAULT_GUEST_PHY_PAGES, O_RDWR);
> > +             for (j = 0; j < max_vcpu; ++j)
> > +                     vm_vcpu_add(vms[i], j);
> > +     }
> > +
> > +     /* Check stats read for every VM and VCPU */
> > +     for (i = 0; i < max_vm; ++i) {
> > +             vm_stats_test(vms[i]);
> > +             for (j = 0; j < max_vcpu; ++j)
> > +                     vcpu_stats_test(vms[i], j);
> > +     }
> > +
>
>
> Does it make sense to add one more test case here to test this fd
> interface on a VM or on a VCPU that has been deleted ? For example, how
> does this fd interface behave if we delete the 4th VM and the 4th VCPU
> in the 3rd VM ?
>
If you meant to test the behavior when we are trying to access a
invalid fd which belongs
to a VM or VCPU that doesn't exist, that's a good idea. I will add a
test for that. thanks.
> > +     for (i = 0; i < max_vm; ++i)
> > +             kvm_vm_free(vms[i]);
> > +     free(vms);
> > +     return 0;
> > +}
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index fc83f6c5902d..d9e0b2c8b906 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -2090,3 +2090,15 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
> >       n = DIV_ROUND_UP(size, vm_guest_mode_params[mode].page_size);
> >       return vm_adjust_num_guest_pages(mode, n);
> >   }
> > +
> > +int vm_get_statsfd(struct kvm_vm *vm)
> > +{
> > +     return ioctl(vm->fd, KVM_STATS_GETFD, NULL);
> > +}
> > +
> > +int vcpu_get_statsfd(struct kvm_vm *vm, uint32_t vcpuid)
> > +{
> > +     struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> > +
> > +     return ioctl(vcpu->fd, KVM_STATS_GETFD, NULL);
> > +}
>
>
> Do we need separate functions if they are called just once ?  Or perhaps
> have a single function for the ioctl call, like ?
>
>       int get_stats_fd(int fd, int type)
>
>       {
>
>              return ioctl(fd, type, NULL);
>
>       }
>
I guess two separate functions are more clear, one function does one thing.

Thanks,
Jing
