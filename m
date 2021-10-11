Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30D0428583
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 05:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJKDTM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 10 Oct 2021 23:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhJKDTL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 10 Oct 2021 23:19:11 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8955CC061570
        for <linux-kselftest@vger.kernel.org>; Sun, 10 Oct 2021 20:17:12 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so2119363ott.2
        for <linux-kselftest@vger.kernel.org>; Sun, 10 Oct 2021 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UPN17vUpLMk0dVpDuL6lQda+tt9UkgYM8vgekuuo8o=;
        b=qyUqjj0Ve6QPENIYAdsSBE1Qb39DOlEeKDhWv+5kKKXwJBLFzunVHxnMWXMuEa+XrK
         gMHot5hryYrvWyzqIYZ5KObp190y6vGNtcAfpAa8fgfLrtmpGWrvXoP/pXMO4q2zJcuT
         fsMPsHUHREBkZpyamUAD1x71rEI6CHFRp+yTkXIFcjgMAlpLH1T0xCI03vAQfiOKp+x/
         39qSBsiHe9lJg565pD5tDHbqVmjYN36jgfHhHtVgePRH5MbpA1No6h489Ri3kWtArIAf
         E1pjZKJKfg1O0EG3MEZStWox4euKMACyT1c2pzA6pJZ9XQDxe+/V9CjBCU6YUaegc1kh
         oNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UPN17vUpLMk0dVpDuL6lQda+tt9UkgYM8vgekuuo8o=;
        b=kTpi2n9ts2L769vO6RtAX25jrrv722oELmLRhE4oWbo7pQ2MMziNrEGFMiTD5R47QP
         clbYaPSjX3Ntl3TsFIz5VtK6psmYTkJiHCdWyyUdlif1EaupiJJAgXnRsBOqLMZI45DE
         6RLrmgjGAU1xi9RgYcAjNBE2qb3xGlQf0dCjqeYy+iKPbYDaYhOJrHkXq/jtxCv8Nqus
         /lBBrluH8pKWtVWhWRMBQn5DFjWcboDfUr/nsyYsLgnG9XAg9OtqTFVyahr5pvmEMQpa
         VL2wr3wkTHnePNIXDWYMVcDMPwf3BuPHaqjvpgcqhP6EXZY1Nh+V4e1YaC9IPNfHyqMA
         ogkw==
X-Gm-Message-State: AOAM530MMm/XDy8io22trnzXkgacOqwA58dcE8gJlG4BsSps6Gig43jk
        7J9ax7tP20592eK8cbJT8LmQNOiD8QM/QwJReeu9VQ==
X-Google-Smtp-Source: ABdhPJxHy125D88lNFuloawX5QHl+maKN0P4xSh0rth4Gf7QDHRrxU4+eUzCZjUslATBX3RF62BzY987yJkJ6z2C6cg=
X-Received: by 2002:a9d:7114:: with SMTP id n20mr10131610otj.25.1633922231427;
 Sun, 10 Oct 2021 20:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211005234459.430873-1-michael.roth@amd.com> <20211006203710.13326-1-michael.roth@amd.com>
In-Reply-To: <20211006203710.13326-1-michael.roth@amd.com>
From:   Marc Orr <marcorr@google.com>
Date:   Sun, 10 Oct 2021 20:17:00 -0700
Message-ID: <CAA03e5EmnbpKOwfNJUV7fog-7UpJJNpu7mQYmCODpk=tYfXxig@mail.gmail.com>
Subject: Re: [RFC 06/16] KVM: selftests: add library for creating/interacting
 with SEV guests
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
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
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 6, 2021 at 1:40 PM Michael Roth <michael.roth@amd.com> wrote:
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
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/include/x86_64/sev.h        |  62 ++++
>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 303 ++++++++++++++++++
>  3 files changed, 366 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 5832f510a16c..c7a5e1c69e0c 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -35,6 +35,7 @@ endif
>
>  LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
>  LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
> +LIBKVM_x86_64 += lib/x86_64/sev.c

Regarding RFC-level feedback: First off, I'm super jazzed with what
I'm seeing so far! (While this is my first review, I've been studying
the patches up through the SEV boot test, i.e., patch #7). One thing
I'm wondering is: the way this is structured is to essentially split
the test cases into non-SEV and SEV. I'm wondering how hard it would
be to add some flag or environment variable to set up pre-existing
tests to run under SEV. Or is this something you all thought about,
and decided that it does not make sense?

Looking at how the guest memory is handled, it seems like it's not far
off from handling SEV transparently across all test cases. I'd think
that we could just default all memory to use the encryption bit, and
then have test cases, such as the test case in patch #7, clear the
encryption bit for shared pages. However, I think the VM creation
would need a bit more refactoring to work with other test cases.

>  LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S
>  LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
> new file mode 100644
> index 000000000000..d2f41b131ecc
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
> @@ -0,0 +1,62 @@
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
> +#define SEV_DEV_PATH           "/dev/sev"

Not necessary for the initial patches, but eventually, it would be
nice to make this configurable. On the machine I was using to test
this, the sev device appears at `/mnt/devtmpfs/sev`

> +#define SEV_FW_REQ_VER_MAJOR   1
> +#define SEV_FW_REQ_VER_MINOR   30

Where does the requirement for this minimum version come from? Maybe
add a comment?

Edit: Is this for patches later on in the series that exercise SNP? If
so, I think it would be better to add a check like this in the test
itself, rather than globally. I happened to test this on a machine
with a very old PSP FW, 0.22, and the SEV test added in patch #7 seems
to work fine with this ancient PSP FW.

> +
> +#define SEV_POLICY_NO_DBG      (1UL << 0)
> +#define SEV_POLICY_ES          (1UL << 2)
> +
> +#define SEV_GUEST_ASSERT(sync, token, _cond) do {      \
> +       if (!(_cond))                                   \
> +               sev_guest_abort(sync, token, 0);        \
> +} while (0)
> +
> +enum {
> +       SEV_GSTATE_UNINIT = 0,
> +       SEV_GSTATE_LUPDATE,
> +       SEV_GSTATE_LSECRET,
> +       SEV_GSTATE_RUNNING,
> +};
> +
> +struct sev_sync_data {
> +       uint32_t token;
> +       bool pending;
> +       bool done;
> +       bool aborted;
> +       uint64_t info;
> +};

nit: This struct could use some comments. For example, `token` is not
totally self-explanatory. In general, a comment explaining how this
struct is intended to be used by test cases seems useful.

> +
> +struct sev_vm;
> +
> +void sev_guest_sync(struct sev_sync_data *sync, uint32_t token, uint64_t info);
> +void sev_guest_done(struct sev_sync_data *sync, uint32_t token, uint64_t info);
> +void sev_guest_abort(struct sev_sync_data *sync, uint32_t token, uint64_t info);
> +
> +void sev_check_guest_sync(struct kvm_run *run, struct sev_sync_data *sync,
> +                         uint32_t token);
> +void sev_check_guest_done(struct kvm_run *run, struct sev_sync_data *sync,
> +                         uint32_t token);
> +
> +void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data);
> +struct kvm_vm *sev_get_vm(struct sev_vm *sev);
> +uint8_t sev_get_enc_bit(struct sev_vm *sev);
> +
> +struct sev_vm *sev_vm_create(uint32_t policy, uint64_t npages);
> +void sev_vm_free(struct sev_vm *sev);
> +void sev_vm_launch(struct sev_vm *sev);
> +void sev_vm_measure(struct sev_vm *sev, uint8_t *measurement);
> +void sev_vm_launch_finish(struct sev_vm *sev);
> +
> +#endif /* SELFTEST_KVM_SEV_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> new file mode 100644
> index 000000000000..adda3b396566
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -0,0 +1,303 @@
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
> +/* Helpers for coordinating between guests and test harness. */
> +
> +void sev_guest_sync(struct sev_sync_data *sync, uint32_t token, uint64_t info)
> +{
> +       sync->token = token;
> +       sync->info = info;
> +       sync->pending = true;
> +
> +       asm volatile("hlt" : : : "memory");
> +}
> +
> +void sev_guest_done(struct sev_sync_data *sync, uint32_t token, uint64_t info)
> +{
> +       while (true) {
> +               sync->done = true;
> +               sev_guest_sync(sync, token, info);
> +       }
> +}
> +
> +void sev_guest_abort(struct sev_sync_data *sync, uint32_t token, uint64_t info)
> +{
> +       while (true) {
> +               sync->aborted = true;
> +               sev_guest_sync(sync, token, info);
> +       }
> +}

Maybe this should have some logic to make sure it only gets executed
once instead of a while loop. Something like:

void sev_guest_done(struct sev_sync_data *sync, uint32_t token, uint64_t info)
{
     static bool abort = false;

     SEV_GUEST_ASSERT(sync, 0xDEADBEEF, !abort);
     abort = true;

     sync->done = true;
     sev_guest_sync(sync, token, info);
}

> +
> +void sev_check_guest_sync(struct kvm_run *run, struct sev_sync_data *sync,
> +                         uint32_t token)
> +{
> +       TEST_ASSERT(run->exit_reason == KVM_EXIT_HLT,
> +                   "unexpected exit reason: %u (%s)",
> +                   run->exit_reason, exit_reason_str(run->exit_reason));
> +       TEST_ASSERT(sync->token == token,
> +                   "unexpected guest token, expected %d, got: %d", token,
> +                   sync->token);
> +       TEST_ASSERT(!sync->done, "unexpected guest state");
> +       TEST_ASSERT(!sync->aborted, "unexpected guest state");
> +       sync->pending = false;

Check that `pending` is `true` before setting to `false`?

> +}
> +
> +void sev_check_guest_done(struct kvm_run *run, struct sev_sync_data *sync,
> +                         uint32_t token)
> +{
> +       TEST_ASSERT(run->exit_reason == KVM_EXIT_HLT,
> +                   "unexpected exit reason: %u (%s)",
> +                   run->exit_reason, exit_reason_str(run->exit_reason));
> +       TEST_ASSERT(sync->token == token,
> +                   "unexpected guest token, expected %d, got: %d", token,
> +                   sync->token);
> +       TEST_ASSERT(sync->done, "unexpected guest state");
> +       TEST_ASSERT(!sync->aborted, "unexpected guest state");
> +       sync->pending = false;
> +}

nit: This function is nearly identical to `sev_check_guest_sync()`,
other than the ASSERT for `sync->done`. Might be worth splitting out a
common static helper or using a single function for both cases, and
distinguishing between them with a function parameter.

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

nit: Should the cast be `(__u64)`, rather than `(unsigned long)`? This
is how `data` is defined in `struct sev_issue_cmd`, and also how the
`data` field is cast in `sev_ioctl`, below.

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
> +       TEST_ASSERT(ret == 0,
> +                   "SEV KVM ioctl %d failed, rc: %i errno: %i (%s), fw_error: %d",
> +                   cmd, ret, errno, strerror(errno), arg.error);

nit: Technically, the `KVM_MEMORY_ENCRYPT_OP ` ioctl failed. The
failure message should reflect this. Maybe something like:

"SEV KVM_MEMORY_ENCRYPT_OP ioctl w/ cmd: %d failed, ..."

> +}
> +
> +/* Local helpers. */
> +
> +static void
> +sev_register_user_range(struct sev_vm *sev, void *hva, uint64_t size)
> +{
> +       struct kvm_enc_region range = {0};
> +       int ret;
> +
> +       pr_debug("register_user_range: hva: %p, size: %lu\n", hva, size);
> +
> +       range.addr = (__u64)hva;
> +       range.size = size;
> +
> +       ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_REG_REGION, &range);
> +       TEST_ASSERT(ret == 0, "failed to register user range, errno: %i\n", errno);
> +}

I don't see any code to call `KVM_MEMORY_ENCRYPT_UNREG_REGION` in this
code. Shouldn't we be calling it to unpin the memory when the test is
done?

> +
> +static void
> +sev_encrypt_phy_range(struct sev_vm *sev, vm_paddr_t gpa, uint64_t size)
> +{
> +       struct kvm_sev_launch_update_data ksev_update_data = {0};
> +
> +       pr_debug("encrypt_phy_range: addr: 0x%lx, size: %lu\n", gpa, size);
> +
> +       ksev_update_data.uaddr = (__u64)addr_gpa2hva(sev->vm, gpa);
> +       ksev_update_data.len = size;
> +
> +       kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_UPDATE_DATA, &ksev_update_data);
> +}
> +
> +static void sev_encrypt(struct sev_vm *sev)
> +{
> +       struct sparsebit *enc_phy_pages;
> +       struct kvm_vm *vm = sev->vm;
> +       sparsebit_idx_t pg = 0;
> +       vm_paddr_t gpa_start;
> +       uint64_t memory_size;
> +
> +       /* Only memslot 0 supported for now. */
> +       enc_phy_pages = vm_get_encrypted_phy_pages(sev->vm, 0, &gpa_start, &memory_size);
> +       TEST_ASSERT(enc_phy_pages, "Unable to retrieve encrypted pages bitmap");
> +       while (pg < (memory_size / vm_get_page_size(vm))) {
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

The `pg_cnt <= 0` case doesn't seem correct. First off, I'd just git
rid of the `<`, because `pg_cnt` is unsigned. Second, the comment
header for `sparsebit_next_clear()` says that a return value of `0`
indicates that no bits following `prev` are cleared. Thus, in this
case, I'd think that `pg_cnt` should be set to `memory_size - pg`. So
maybe something like:

end = sparsebit_next_clear(enc_phy_pages, pg);
if (end == 0)
     end = memory_size;
pg_cnt = end - pg;

> +
> +               sev_encrypt_phy_range(sev,
> +                                     gpa_start + pg * vm_get_page_size(vm),
> +                                     pg_cnt * vm_get_page_size(vm));
> +               pg += pg_cnt;
> +       }
> +
> +       sparsebit_free(&enc_phy_pages);
> +}
> +
> +/* SEV VM implementation. */
> +
> +static struct sev_vm *sev_common_create(struct kvm_vm *vm)
> +{
> +       struct sev_user_data_status sev_status = {0};
> +       uint32_t eax, ebx, ecx, edx;
> +       struct sev_vm *sev;
> +       int sev_fd;
> +
> +       sev_fd = open(SEV_DEV_PATH, O_RDWR);
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

nit: If we fail here, we leak `sev_fd`. Should we call `close(sev_fd)` here?

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
> +
> +       return sev;
> +}
> +
> +static void sev_common_free(struct sev_vm *sev)
> +{
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
> +       sev = sev_common_create(vm);
> +       if (!sev)
> +               return NULL;
> +       sev->sev_policy = policy;
> +
> +       kvm_sev_ioctl(sev, KVM_SEV_INIT, NULL);
> +
> +       vm_set_memory_encryption(vm, true, true, sev->enc_bit);
> +       vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, npages, 0);
> +       sev_register_user_range(sev, addr_gpa2hva(vm, 0), npages * vm_get_page_size(vm));
> +
> +       pr_info("SEV guest created, policy: 0x%x, size: %lu KB\n",
> +               sev->sev_policy, npages * vm_get_page_size(vm) / 1024);
> +
> +       return sev;
> +}
> +
> +void sev_vm_free(struct sev_vm *sev)
> +{
> +       kvm_vm_free(sev->vm);
> +       sev_common_free(sev);
> +}
> +
> +void sev_vm_launch(struct sev_vm *sev)
> +{
> +       struct kvm_sev_launch_start ksev_launch_start = {0};
> +       struct kvm_sev_guest_status ksev_status = {0};
> +
> +       ksev_launch_start.policy = sev->sev_policy;
> +       kvm_sev_ioctl(sev, KVM_SEV_LAUNCH_START, &ksev_launch_start);
> +       kvm_sev_ioctl(sev, KVM_SEV_GUEST_STATUS, &ksev_status);
> +       TEST_ASSERT(ksev_status.policy == sev->sev_policy, "Incorrect guest policy.");
> +       TEST_ASSERT(ksev_status.state == SEV_GSTATE_LUPDATE,
> +                   "Unexpected guest state: %d", ksev_status.state);
> +
> +       sev_encrypt(sev);
> +}
> +
> +void sev_vm_measure(struct sev_vm *sev, uint8_t *measurement)
> +{
> +       struct kvm_sev_launch_measure ksev_launch_measure = {0};
> +       struct kvm_sev_guest_status ksev_guest_status = {0};
> +
> +       ksev_launch_measure.len = 256;
> +       ksev_launch_measure.uaddr = (__u64)measurement;
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

This is phenomenal. I'll try to send feedback on the other patches in
the first batch of 7 sooner rather than later. I haven't looked past
patch #7 yet. Let me know what you think about my first comment, on
whether we can get all pre-existing tests to run under SEV, or that's
a bad idea. I probably haven't given it as much thought as you have.
