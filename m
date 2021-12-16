Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B71477DB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 21:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbhLPUgM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 15:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbhLPUgL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 15:36:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21443C06173F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 12:36:11 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b40so291039lfv.10
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M04MzVjJKltzPFjYlcKr+aCv8LyvnVZLNhrEVYvVsXs=;
        b=KmavA07zjpBn7jz4HPev/l7AHuuJZ8sB/8jpqaExr4eT3GMXWfEGOlwnYoNuf2eT27
         /vfP8TZ6ljNhXCycuO1jFYM2SdXIMfoUzNNV/l43ar/z/VA0w34M8g2qQnPs17/iB8Ss
         vkEPpFuFERUZjwVdwrHnAhDVzJkITkcrshRsu/0dnTYNWyIs5RxXH44OpzcC5DPenbRr
         /EOZCGqhd83/LsthH/uocJSssgBkOtemWV286vIYYQNcGL0rYC8/xeKkx7v17ssBFnSo
         rayH7auP1f0atK/5h4oX5onhUbIh570iKJ+cnLGSr1GegBjDgkNFBaCyGGE6GJC7CzWY
         TdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M04MzVjJKltzPFjYlcKr+aCv8LyvnVZLNhrEVYvVsXs=;
        b=LuqDNzMSvjVdJozEB4qejGG9xWib5s2Bl4GC8WZVXhJb8V5mh804Cb8R+A9PBrDcN7
         jUkJPOeXyQUGJP4+4tSOnXApt1BKRnoS41QZNJ6dVg9EHeXQKdR1uRbHwlRnwkpbLy5f
         X+aAdkz7rwHTnO66O1c9QXNXVTTtoSslXqXHxt3U17412YgzpRULziKPOvLeD1Cnvp9d
         UkH7Qia+diHxxOke5h2eCGA+H3o6wGxIL5JeIXfcauWryM/O4gW9YhMjpbWYLpeMK5pa
         EwxoruPcTmjQKODH0xwqdiNjoL7ev7srQyi+K+TBora5ArpLN00ZoI4P8WQZzZhbji9Z
         IPvw==
X-Gm-Message-State: AOAM533iX6BAH//WAzcdRCjY78KuwrI9JdHMLzo3u9VpzJ8mFnbzQZJ0
        JZnvLfjZkBiWyK5/Od9CO2gg1wQqs1SCUyMaVs2PSw==
X-Google-Smtp-Source: ABdhPJyZfVddV0LYejD/7176SwhLZbRqPIDIWRLkKcs099bmia4Hs5iTxAznRIzhjSq7xC2G2pG91t2sxJAvV5TBYAs=
X-Received: by 2002:a05:6512:1148:: with SMTP id m8mr16273209lfg.456.1639686968824;
 Thu, 16 Dec 2021 12:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20211216171358.61140-1-michael.roth@amd.com> <20211216171358.61140-8-michael.roth@amd.com>
In-Reply-To: <20211216171358.61140-8-michael.roth@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 16 Dec 2021 13:35:57 -0700
Message-ID: <CAMkAt6pPpWzazBJAM0N1s115k9on7mC46BKzwk6oYHBOoGyohA@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] KVM: selftests: add library for
 creating/interacting with SEV guests
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

)


On Thu, Dec 16, 2021 at 10:18 AM Michael Roth <michael.roth@amd.com> wrote:
>
> Add interfaces to allow tests to create/manage SEV guests. The
> additional state associated with these guests is encapsulated in a new
> struct sev_vm, which is a light wrapper around struct kvm_vm. These
> VMs will use vm_set_memory_encryption() and vm_get_encrypted_phy_pages()
> under the covers to configure and sync up with the core kvm_util
> library on what should/shouldn't be treated as encrypted memory.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   9 +-
>  .../selftests/kvm/include/x86_64/sev.h        |  44 ++++
>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 245 ++++++++++++++++++
>  3 files changed, 297 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 412de8093e6c..ccc382a827f1 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -33,8 +33,14 @@ ifeq ($(ARCH),s390)
>         UNAME_M := s390x
>  endif
>
> +# On some systems the SEV device path may not be present in the standard
> +# location, so allow it to be configured via, e.g.:
> +#   make TARGETS=kvm SEV_PATH=/path/to/sev_device ...
> +SEV_PATH=/dev/sev
> +
>  LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c lib/ucall_common.c
>  LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
> +LIBKVM_x86_64 += lib/x86_64/sev.c
>  LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
>  LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>
> @@ -134,7 +140,8 @@ endif
>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>         -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>         -I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
> -       -I$(<D) -Iinclude/$(UNAME_M) -I..
> +       -I$(<D) -Iinclude/$(UNAME_M) -I.. \
> +       -DSEV_DEV_PATH=\"$(SEV_PATH)\"
>
>  no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
>          $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
> diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
> new file mode 100644
> index 000000000000..2f7f7c741b12
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Helpers used for SEV guests
> + *
> + * Copyright (C) 2021 Advanced Micro Devices
> + */
> +#ifndef SELFTEST_KVM_SEV_H
> +#define SELFTEST_KVM_SEV_H
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include "kvm_util.h"
> +
> +/* Makefile might set this separately for user-overrides */
> +#ifndef SEV_DEV_PATH
> +#define SEV_DEV_PATH           "/dev/sev"
> +#endif

Similar logic is already in open_sev_dev_path_or_exit() should we move
that function here?

> +
> +#define SEV_FW_REQ_VER_MAJOR   0
> +#define SEV_FW_REQ_VER_MINOR   17
> +
> +#define SEV_POLICY_NO_DBG      (1UL << 0)
> +#define SEV_POLICY_ES          (1UL << 2)
> +
> +enum {
> +       SEV_GSTATE_UNINIT = 0,
> +       SEV_GSTATE_LUPDATE,
> +       SEV_GSTATE_LSECRET,
> +       SEV_GSTATE_RUNNING,
> +};
> +
> +struct sev_vm;
> +
> +void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data);
> +struct kvm_vm *sev_get_vm(struct sev_vm *sev);
> +uint8_t sev_get_enc_bit(struct sev_vm *sev);
> +
> +struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages);
> +void sev_vm_free(struct sev_vm *sev);
> +void sev_vm_launch(struct sev_vm *sev);
> +void sev_vm_launch_measure(struct sev_vm *sev, uint8_t *measurement);
> +void sev_vm_launch_finish(struct sev_vm *sev);
> +
> +#endif /* SELFTEST_KVM_SEV_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> new file mode 100644
> index 000000000000..4a99862d62e6
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Helpers used for SEV guests
> + *
> + * Copyright (C) 2021 Advanced Micro Devices
> + */
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include "kvm_util.h"
> +#include "linux/psp-sev.h"
> +#include "processor.h"
> +#include "sev.h"
> +
> +#define PAGE_SHIFT             12
> +#define PAGE_SIZE              (1UL << PAGE_SHIFT)
> +
> +struct sev_vm {
> +       struct kvm_vm *vm;
> +       int fd;
> +       int enc_bit;
> +       uint32_t sev_policy;
> +};
> +
> +/* Common SEV helpers/accessors. */
> +
> +struct kvm_vm *sev_get_vm(struct sev_vm *sev)
> +{
> +       return sev->vm;
> +}
> +
> +uint8_t sev_get_enc_bit(struct sev_vm *sev)
> +{
> +       return sev->enc_bit;
> +}
> +
> +void sev_ioctl(int sev_fd, int cmd, void *data)
> +{
> +       int ret;
> +       struct sev_issue_cmd arg;
> +
> +       arg.cmd = cmd;
> +       arg.data = (unsigned long)data;
> +       ret = ioctl(sev_fd, SEV_ISSUE_CMD, &arg);
> +       TEST_ASSERT(ret == 0,
> +                   "SEV ioctl %d failed, error: %d, fw_error: %d",
> +                   cmd, ret, arg.error);
> +}
> +
> +void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data)
> +{
> +       struct kvm_sev_cmd arg = {0};
> +       int ret;
> +
> +       arg.id = cmd;
> +       arg.sev_fd = sev->fd;
> +       arg.data = (__u64)data;
> +
> +       ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_OP, &arg);

If the helper vm_get_fd() exists why not add another which takes a
struct sev_vm. So you can do __vm_get_fd(sev) here?

> +       TEST_ASSERT(ret == 0,
> +                   "SEV KVM ioctl %d failed, rc: %i errno: %i (%s), fw_error: %d",
> +                   cmd, ret, errno, strerror(errno), arg.error);
> +}

Can you dedup this from  sev_ioctl() in sev_migrate_tests.c? That
function already correctly asserts the fw_error.

> +
> +/* Local helpers. */
> +
> +static void
> +sev_register_user_region(struct sev_vm *sev, void *hva, uint64_t size)
> +{
> +       struct kvm_enc_region range = {0};
> +       int ret;
> +
> +       pr_debug("%s: hva: %p, size: %lu\n", __func__, hva, size);
> +
> +       range.addr = (__u64)hva;
> +       range.size = size;
> +
> +       ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_REG_REGION, &range);
> +       TEST_ASSERT(ret == 0, "failed to register user range, errno: %i\n", errno);
> +}
> +
> +static void
> +sev_encrypt_phy_range(struct sev_vm *sev, vm_paddr_t gpa, uint64_t size)
> +{
> +       struct kvm_sev_launch_update_data ksev_update_data = {0};
> +
> +       pr_debug("%s: addr: 0x%lx, size: %lu\n", __func__, gpa, size);
> +
> +       ksev_update_data.uaddr = (__u64)addr_gpa2hva(sev->vm, gpa);
> +       ksev_update_data.len = size;
> +
> +       kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_UPDATE_DATA, &ksev_update_data);
> +}
> +
> +static void sev_encrypt(struct sev_vm *sev)
> +{
> +       const struct sparsebit *enc_phy_pages;
> +       struct kvm_vm *vm = sev->vm;
> +       sparsebit_idx_t pg = 0;
> +       vm_paddr_t gpa_start;
> +       uint64_t memory_size;
> +
> +       /* Only memslot 0 supported for now. */
> +       enc_phy_pages = vm_get_encrypted_phy_pages(sev->vm, 0, &gpa_start, &memory_size);
> +       TEST_ASSERT(enc_phy_pages, "Unable to retrieve encrypted pages bitmap");
> +       while (pg < (memory_size / vm_get_page_size(vm))) {

For readability could we save have a new variable:

const uint64_t page_size = vm_get_page_size(vm);

> +               sparsebit_idx_t pg_cnt;
> +
> +               if (sparsebit_is_clear(enc_phy_pages, pg)) {
> +                       pg = sparsebit_next_set(enc_phy_pages, pg);
> +                       if (!pg)
> +                               break;
> +               }
> +
> +               pg_cnt = sparsebit_next_clear(enc_phy_pages, pg) - pg;
> +               if (pg_cnt <= 0)
> +                       pg_cnt = 1;
> +
> +               sev_encrypt_phy_range(sev,
> +                                     gpa_start + pg * vm_get_page_size(vm),
> +                                     pg_cnt * vm_get_page_size(vm));
> +               pg += pg_cnt;
> +       }
> +}
> +
> +/* SEV VM implementation. */
> +
> +static struct sev_vm *sev_vm_alloc(struct kvm_vm *vm)
> +{
> +       struct sev_user_data_status sev_status = {0};
> +       uint32_t eax, ebx, ecx, edx;
> +       struct sev_vm *sev;
> +       int sev_fd;
> +
> +       sev_fd = open(SEV_DEV_PATH, O_RDWR);

As noted above please use open_sev_dev_path_or_exit()

> +       if (sev_fd < 0) {
> +               pr_info("Failed to open SEV device, path: %s, error: %d, skipping test.\n",
> +                       SEV_DEV_PATH, sev_fd);
> +               return NULL;
> +       }
> +
> +       sev_ioctl(sev_fd, SEV_PLATFORM_STATUS, &sev_status);
> +
> +       if (!(sev_status.api_major > SEV_FW_REQ_VER_MAJOR ||
> +             (sev_status.api_major == SEV_FW_REQ_VER_MAJOR &&
> +              sev_status.api_minor >= SEV_FW_REQ_VER_MINOR))) {
> +               pr_info("SEV FW version too old. Have API %d.%d (build: %d), need %d.%d, skipping test.\n",
> +                       sev_status.api_major, sev_status.api_minor, sev_status.build,
> +                       SEV_FW_REQ_VER_MAJOR, SEV_FW_REQ_VER_MINOR);

Technically we are returning NULL not skipping the test.

> +               return NULL;
> +       }
> +
> +       sev = calloc(1, sizeof(*sev));
> +       sev->fd = sev_fd;
> +       sev->vm = vm;
> +
> +       /* Get encryption bit via CPUID. */
> +       eax = 0x8000001f;
> +       ecx = 0;
> +       cpuid(&eax, &ebx, &ecx, &edx);
> +       sev->enc_bit = ebx & 0x3F;

Can we get macros for these magics?

> +
> +       return sev;
> +}
> +
> +void sev_vm_free(struct sev_vm *sev)
> +{
> +       kvm_vm_free(sev->vm);
> +       close(sev->fd);
> +       free(sev);
> +}
> +
> +struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages)
> +{
> +       struct sev_vm *sev;
> +       struct kvm_vm *vm;
> +
> +       /* Need to handle memslots after init, and after setting memcrypt. */
> +       vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
> +       sev = sev_vm_alloc(vm);
> +       if (!sev)
> +               return NULL;
> +       sev->sev_policy = policy;
> +
> +       kvm_sev_ioctl(sev, KVM_SEV_INIT, NULL);
> +
> +       vm_set_memory_encryption(vm, true, true, sev->enc_bit);
> +       vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages, 0);
> +       sev_register_user_region(sev, addr_gpa2hva(vm, 0),
> +                                npages * vm_get_page_size(vm));
> +
> +       pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n",
> +               sev->sev_policy, npages * vm_get_page_size(vm) / 1024);
> +
> +       return sev;
> +}
> +
> +void sev_vm_launch(struct sev_vm *sev)
> +{
> +       struct kvm_sev_launch_start ksev_launch_start = {0};
> +       struct kvm_sev_guest_status ksev_status = {0};
> +
> +       /* Need to use ucall_shared for synchronization. */
> +       ucall_init_ops(sev_get_vm(sev), NULL, &ucall_ops_halt);
> +
> +       ksev_launch_start.policy = sev->sev_policy;
> +       kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_START, &ksev_launch_start);
> +       kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
> +       TEST_ASSERT(ksev_status.policy == sev->sev_policy, "Incorrect guest policy.");
> +       TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE,
> +                   "Unexpected guest state: %d", ksev_status.state);

In this file we've done this a lot. Thoughts about a helper like this?

+ void assert_guest_state(uint32_t expected_state, struct sev_vm *sev)
+ {
+       struct kvm_sev_guest_status ksev_status = {0};
+
+       TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE,
+                   "Unexpected guest state: %d", ksev_status.state);
+ }


> +
> +       sev_encrypt(sev);
> +}
> +
> +void sev_vm_launch_measure(struct sev_vm *sev, uint8_t *measurement)
> +{
> +       struct kvm_sev_launch_measure ksev_launch_measure = {0};
> +       struct kvm_sev_guest_status ksev_guest_status = {0};
> +
> +       ksev_launch_measure.len = 256;
> +       ksev_launch_measure.uaddr = (__u64)measurement;

Can we document that this measure pointer must be backed by at least a
given amount of memory?

Also should this be 48 as the length required (256bits for MEASURE and
128 for MNONCE?

> +       kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_MEASURE, &ksev_launch_measure);
> +
> +       /* Measurement causes a state transition, check that. */
> +       kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_guest_status);
> +       TEST_ASSERT(ksev_guest_status.state == SEV_GSTATE_LSECRET,
> +                   "Unexpected guest state: %d", ksev_guest_status.state);
> +}
> +
> +void sev_vm_launch_finish(struct sev_vm *sev)
> +{
> +       struct kvm_sev_guest_status ksev_status = {0};
> +
> +       kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
> +       TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE ||
> +                   ksev_status.state == SEV_GSTATE_LSECRET,
> +                   "Unexpected guest state: %d", ksev_status.state);

We don't pre check the state in any other calls, should we? Or why are we here?


> +
> +       kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_FINISH, NULL);
> +
> +       kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
> +       TEST_ASSERT(ksev_status.state == SEV_GSTATE_RUNNING,
> +                   "Unexpected guest state: %d", ksev_status.state);
> +}
> --
> 2.25.1
>
