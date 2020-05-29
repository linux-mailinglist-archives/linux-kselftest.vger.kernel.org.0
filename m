Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315391E7232
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 May 2020 03:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390837AbgE2Bsk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 21:48:40 -0400
Received: from ozlabs.org ([203.11.71.1]:58381 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390018AbgE2Bsh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 21:48:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Y6sr6jS6z9sSm;
        Fri, 29 May 2020 11:48:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590716913;
        bh=GvLOqoYxRe3z6IJbZ2Jxym8kLV9SKZXH/FLcGA1jgjE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D9c8PMzPWn1PfV3Ehc93cLi6a9k2Uxlealn3RWCJoeE+6QPyD9oTfzJFD/TbogtCX
         Ku+n5e7cF4BmDqsIO1lA/eqIJpeGDbCHGk2S/CbGwM3/84rwFT7UosWRtL5vDwMK/L
         zm8FX+/axA+uN9J3rr7TD0k6ww7O8BhCwA8Fj7xhZW4yu3KkVBOuXIajNYTmxwEabv
         nMyme5WOC46yfQRBqh7JTIB51BkVzRFUU3lmab5magR5lPB2Kh64+ZTOjMIQOX7ZPv
         /ol9CeZv5i6mRnamVhGIcz+kECl8CUcXhqwJVoietmZJrUZ7EdqAgRlGa0lVxV91rx
         I7BUDNQjp//6w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sandipan Das <sandipan@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linuxram@us.ibm.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        fweimer@redhat.com, ruscur@russell.cc
Subject: Re: [PATCH v2] selftests: powerpc: Add test for execute-disabled pkeys
In-Reply-To: <20200527030342.13712-1-sandipan@linux.ibm.com>
References: <20200527030342.13712-1-sandipan@linux.ibm.com>
Date:   Fri, 29 May 2020 11:48:53 +1000
Message-ID: <87tuzzik8q.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sandipan,

A few comments below ...

Sandipan Das <sandipan@linux.ibm.com> writes:
> Apart from read and write access, memory protection keys can
> also be used for restricting execute permission of pages on
> powerpc. This adds a test to verify if the feature works as
> expected.
>
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>
> Previous versions can be found at
> v1: https://lore.kernel.org/linuxppc-dev/20200508162332.65316-1-sandipan@linux.ibm.com/
>
> Changes in v2:
> - Added .gitignore entry for test binary.
> - Fixed builds for older distros where siginfo_t might not have si_pkey as
>   a formal member based on discussion with Michael.
>
> ---
>  tools/testing/selftests/powerpc/mm/.gitignore |   1 +
>  tools/testing/selftests/powerpc/mm/Makefile   |   3 +-
>  .../selftests/powerpc/mm/pkey_exec_prot.c     | 336 ++++++++++++++++++
>  3 files changed, 339 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
>
> diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
> index 2ca523255b1b..8f841f925baa 100644
> --- a/tools/testing/selftests/powerpc/mm/.gitignore
> +++ b/tools/testing/selftests/powerpc/mm/.gitignore
> @@ -8,3 +8,4 @@ wild_bctr
>  large_vm_fork_separation
>  bad_accesses
>  tlbie_test
> +pkey_exec_prot
> diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
> index b9103c4bb414..2816229f648b 100644
> --- a/tools/testing/selftests/powerpc/mm/Makefile
> +++ b/tools/testing/selftests/powerpc/mm/Makefile
> @@ -3,7 +3,7 @@ noarg:
>  	$(MAKE) -C ../
>  
>  TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr \
> -		  large_vm_fork_separation bad_accesses
> +		  large_vm_fork_separation bad_accesses pkey_exec_prot
>  TEST_GEN_PROGS_EXTENDED := tlbie_test
>  TEST_GEN_FILES := tempfile
>  
> @@ -17,6 +17,7 @@ $(OUTPUT)/prot_sao: ../utils.c
>  $(OUTPUT)/wild_bctr: CFLAGS += -m64
>  $(OUTPUT)/large_vm_fork_separation: CFLAGS += -m64
>  $(OUTPUT)/bad_accesses: CFLAGS += -m64
> +$(OUTPUT)/pkey_exec_prot: CFLAGS += -m64
>  
>  $(OUTPUT)/tempfile:
>  	dd if=/dev/zero of=$@ bs=64k count=1
> diff --git a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> new file mode 100644
> index 000000000000..147fb9ed47d5
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Copyright 2020, Sandipan Das, IBM Corp.
> + *
> + * Test if applying execute protection on pages using memory
> + * protection keys works as expected.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <signal.h>
> +
> +#include <time.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +
> +#include "utils.h"
> +
> +/* Override definitions as they might be inconsistent */

Can you please expand the comment to say why/where you've seen problems,
so one day we can drop these once those old libcs are no longer around.

> +#undef PKEY_DISABLE_ACCESS
> +#define PKEY_DISABLE_ACCESS	0x3
> +
> +#undef PKEY_DISABLE_WRITE
> +#define PKEY_DISABLE_WRITE	0x2
> +
> +#undef PKEY_DISABLE_EXECUTE
> +#define PKEY_DISABLE_EXECUTE	0x4
> +
> +/* Older distros might not define this */
> +#ifndef SEGV_PKUERR
> +#define SEGV_PKUERR	4
> +#endif
> +
> +#define SI_PKEY_OFFSET	0x20
> +
> +#define SYS_pkey_mprotect	386
> +#define SYS_pkey_alloc		384
> +#define SYS_pkey_free		385
> +
> +#define PKEY_BITS_PER_PKEY	2
> +#define NR_PKEYS		32
> +
> +#define PKEY_BITS_MASK		((1UL << PKEY_BITS_PER_PKEY) - 1)

If you include "reg.h" then there's a mfspr()/mtspr() macro you can use.

> +static unsigned long pkeyreg_get(void)
> +{
> +	unsigned long uamr;

The SPR is AMR not uamr?

> +	asm volatile("mfspr	%0, 0xd" : "=r"(uamr));
> +	return uamr;
> +}
> +
> +static void pkeyreg_set(unsigned long uamr)
> +{
> +	asm volatile("isync; mtspr	0xd, %0; isync;" : : "r"(uamr));
> +}

You can use mtspr() there, but you'll need to add the isync's yourself.

> +static void pkey_set_rights(int pkey, unsigned long rights)
> +{
> +	unsigned long uamr, shift;
> +
> +	shift = (NR_PKEYS - pkey - 1) * PKEY_BITS_PER_PKEY;
> +	uamr = pkeyreg_get();
> +	uamr &= ~(PKEY_BITS_MASK << shift);
> +	uamr |= (rights & PKEY_BITS_MASK) << shift;
> +	pkeyreg_set(uamr);
> +}
> +
> +static int sys_pkey_mprotect(void *addr, size_t len, int prot, int pkey)
> +{
> +	return syscall(SYS_pkey_mprotect, addr, len, prot, pkey);
> +}
> +
> +static int sys_pkey_alloc(unsigned long flags, unsigned long rights)
> +{
> +	return syscall(SYS_pkey_alloc, flags, rights);
> +}
> +
> +static int sys_pkey_free(int pkey)
> +{
> +	return syscall(SYS_pkey_free, pkey);
> +}
> +
> +static volatile int fpkey, fcode, ftype, faults;

The "proper" type to use for things accessed in signal handlers is
volatile sig_atomic_t, which should work here AFACIS.


> +static unsigned long pgsize, numinsns;
> +static volatile unsigned int *faddr;
> +static unsigned int *insns;
> +
> +static void segv_handler(int signum, siginfo_t *sinfo, void *ctx)
> +{
> +	int pkey;
> +
> +#ifdef si_pkey
> +	pkey = sinfo->si_pkey;
> +#else
> +	pkey = *((int *)(((char *) sinfo) + SI_PKEY_OFFSET));
> +#endif
> +
> +	/* Check if this fault originated because of the expected reasons */
> +	if (sinfo->si_code != SEGV_ACCERR && sinfo->si_code != SEGV_PKUERR) {
> +		printf("got an unexpected fault, code = %d\n",
> +		       sinfo->si_code);

printf() isn't signal safe, so this is a bit dicey. You can call
write(2) if you really want to.

If this is an unexpected condition you might better to just call
_exit(1) to bail out.

> +		goto fail;
> +	}
> +
> +	/* Check if this fault originated from the expected address */
> +	if (sinfo->si_addr != (void *) faddr) {
> +		printf("got an unexpected fault, addr = %p\n",
> +		       sinfo->si_addr);
> +		goto fail;
> +	}
> +
> +	/* Check if the expected number of faults has been exceeded */
> +	if (faults == 0)
> +		goto fail;
> +
> +	fcode = sinfo->si_code;
> +
> +	/* Restore permissions in order to continue */
> +	switch (fcode) {
> +	case SEGV_ACCERR:
> +		if (mprotect(insns, pgsize, PROT_READ | PROT_WRITE)) {

mprotect() also isn't listed as being signal safe, though I don't see
why not. So that's probably fine for test code. We could always call the
syscall directly if necessary.

> +			perror("mprotect");
> +			goto fail;
> +		}
> +		break;
> +	case SEGV_PKUERR:
> +		if (pkey != fpkey)
> +			goto fail;
> +
> +		if (ftype == PKEY_DISABLE_ACCESS) {
> +			pkey_set_rights(fpkey, 0);
> +		} else if (ftype == PKEY_DISABLE_EXECUTE) {
> +			/*
> +			 * Reassociate the exec-only pkey with the region
> +			 * to be able to continue. Unlike AMR, we cannot
> +			 * set IAMR directly from userspace to restore the
> +			 * permissions.
> +			 */
> +			if (mprotect(insns, pgsize, PROT_EXEC)) {
> +				perror("mprotect");
> +				goto fail;
> +			}
> +		} else {
> +			goto fail;
> +		}
> +		break;
> +	}
> +
> +	faults--;
> +	return;
> +
> +fail:
> +	/* Restore all page permissions to avoid repetitive faults */
> +	if (mprotect(insns, pgsize, PROT_READ | PROT_WRITE | PROT_EXEC))
> +		perror("mprotect");
> +	if (sinfo->si_code == SEGV_PKUERR)
> +		pkey_set_rights(pkey, 0);
> +	faults = -1;	/* Something unexpected happened */
> +}
> +
> +static int pkeys_unsupported(void)
> +{
> +	bool using_hash = false;
> +	char line[128];
> +	int pkey;
> +	FILE *f;
> +
> +	f = fopen("/proc/cpuinfo", "r");
> +	FAIL_IF(!f);
> +
> +	/* Protection keys are currently supported on Hash MMU only */
> +	while (fgets(line, sizeof(line), f)) {
> +		if (strcmp(line, "MMU		: Hash\n") == 0) {
> +			using_hash = true;
> +			break;
> +		}
> +	}

We already have using_hash_mmu() in the bad_accesses.c test.

Can you move using_hash_mmu() into
tools/testing/selftests/powerpc/utils.c, and declare it in
tools/testing/selftests/powerpc/include/utils.h and then use it in your
test.

> +	fclose(f);
> +	SKIP_IF(!using_hash);
> +
> +	/* Check if the system call is supported */
> +	pkey = sys_pkey_alloc(0, 0);
> +	SKIP_IF(pkey < 0);
> +	sys_pkey_free(pkey);
> +
> +	return 0;
> +}
> +
> +static int test(void)
> +{
> +	struct sigaction act;
> +	int pkey, ret, i;
> +
> +	ret = pkeys_unsupported();
> +	if (ret)
> +		return ret;
> +
> +	/* Setup signal handler */
> +	act.sa_handler = 0;
> +	act.sa_sigaction = segv_handler;
> +	FAIL_IF(sigprocmask(SIG_SETMASK, 0, &act.sa_mask) != 0);
> +	act.sa_flags = SA_SIGINFO;
> +	act.sa_restorer = 0;
> +	FAIL_IF(sigaction(SIGSEGV, &act, NULL) != 0);
> +
> +	/* Setup executable region */
> +	pgsize = sysconf(_SC_PAGESIZE);

getpagesize() is cleaner.

> +	numinsns = pgsize / sizeof(unsigned int);
> +	insns = (unsigned int *) mmap(NULL, pgsize, PROT_READ | PROT_WRITE,
> +				      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	FAIL_IF(insns == MAP_FAILED);
> +
> +	/* Write the instruction words */
> +	for (i = 0; i < numinsns - 1; i++)
> +		insns[i] = 0x60000000;		/* nop */
> +
> +	/*
> +	 * Later, to jump to the executable region, we use a linked
> +	 * branch which sets the return address automatically in LR.
            
"linked branch" is usually called "branch and link".

> +	 * Use that to return back.
> +	 */
> +	insns[numinsns - 1] = 0x4e800020;	/* blr */
> +
> +	/* Allocate a pkey that restricts execution */
> +	pkey = sys_pkey_alloc(0, PKEY_DISABLE_EXECUTE);
> +	FAIL_IF(pkey < 0);
> +
> +	/*
> +	 * Pick a random instruction address from the executable
> +	 * region.
> +	 */
> +	srand(time(NULL));
> +	faddr = &insns[rand() % (numinsns - 1)];

I'm not really sure the randomisation adds much, given it's only
randomised within the page and the protections only operate at page
granularity.

> +
> +	/* The following two cases will avoid SEGV_PKUERR */
> +	ftype = -1;
> +	fpkey = -1;
> +
> +	/*
> +	 * Read an instruction word from the address when AMR bits
> +	 * are not set.

You should explain for people who aren't familiar with the ISA that "AMR
bits not set" means "read/write access allowed".

> +	 *
> +	 * This should not generate a fault as having PROT_EXEC
> +	 * implicitly allows reads. The pkey currently restricts

Whether PROT_EXEC implies read is not well defined (see the man page).
If you want to test this case I think you'd be better off specifying
PROT_EXEC | PROT_READ explicitly.

> +	 * execution only based on the IAMR bits. The AMR bits are
> +	 * cleared.
> +	 */
> +	faults = 0;
> +	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
> +	printf("read from %p, pkey is execute-disabled\n", (void *) faddr);
> +	i = *faddr;
> +	FAIL_IF(faults != 0);
> +
> +	/*
> +	 * Write an instruction word to the address when AMR bits
> +	 * are not set.
> +	 *
> +	 * This should generate an access fault as having just
> +	 * PROT_EXEC also restricts writes. The pkey currently

OK that one is correct, PROT_EXEC without PROT_WRITE must prevent writes.

> +	 * restricts execution only based on the IAMR bits. The
> +	 * AMR bits are cleared.
> +	 */
> +	faults = 1;
> +	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
> +	printf("write to %p, pkey is execute-disabled\n", (void *) faddr);
> +	*faddr = 0x60000000;	/* nop */

faddr is already == nop because you set the entire page to nops previously.

It would be a more convincing test if you set faddr to a trap at the
beginning, that way later when you execute it you can test that the
write of the nop succeeded.

> +	FAIL_IF(faults != 0 || fcode != SEGV_ACCERR);
> +
> +	/* The following three cases will generate SEGV_PKUERR */
> +	ftype = PKEY_DISABLE_ACCESS;
> +	fpkey = pkey;
> +
> +	/*
> +	 * Read an instruction word from the address when AMR bits
> +	 * are set.
> +	 *
> +	 * This should generate a pkey fault based on AMR bits only
> +	 * as having PROT_EXEC implicitly allows reads.

Again would be better to specify PROT_READ IMHO.

> +	 */
> +	faults = 1;
> +	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
> +	printf("read from %p, pkey is execute-disabled, access-disabled\n",
> +	       (void *) faddr);
> +	pkey_set_rights(pkey, PKEY_DISABLE_ACCESS);
> +	i = *faddr;
> +	FAIL_IF(faults != 0 || fcode != SEGV_PKUERR);
> +
> +	/*
> +	 * Write an instruction word to the address when AMR bits
> +	 * are set.
> +	 *
> +	 * This should generate two faults. First, a pkey fault based
> +	 * on AMR bits and then an access fault based on PROT_EXEC.
> +	 */
> +	faults = 2;

Setting faults to the expected value and decrementing it in the fault
handler is kind of weird.

I think it would be clearer if faults was just a zero-based counter of
how many faults we've taken, and then you test that it's == 2 below.

> +	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
> +	printf("write to %p, pkey is execute-disabled, access-disabled\n",
> +	       (void *) faddr);
> +	pkey_set_rights(pkey, PKEY_DISABLE_ACCESS);
> +	*faddr = 0x60000000;	/* nop */
> +	FAIL_IF(faults != 0 || fcode != SEGV_ACCERR);

ie. FAIL_IF(faults != 2 || ... )

> +	/*
> +	 * Jump to the executable region. This should generate a pkey
> +	 * fault based on IAMR bits. AMR bits will not affect execution.
> +	 */
> +	faddr = insns;
> +	ftype = PKEY_DISABLE_EXECUTE;
> +	fpkey = pkey;
> +	faults = 1;
> +	FAIL_IF(sys_pkey_mprotect(insns, pgsize, PROT_EXEC, pkey) != 0);
> +	pkey_set_rights(pkey, PKEY_DISABLE_ACCESS);
> +	printf("execute at %p, ", (void *) faddr);
> +	printf("pkey is execute-disabled, access-disabled\n");
> +
> +	/* Branch into the executable region */
> +	asm volatile("mtctr	%0" : : "r"((unsigned long) insns));
> +	asm volatile("bctrl");

I'm not sure that's safe, they should be part of a single asm block.

> +	FAIL_IF(faults != 0 || fcode != SEGV_PKUERR);

I think as a final test you should remove the protections and confirm
you can successfully execute from the insns page.

> +	/* Cleanup */
> +	munmap((void *) insns, pgsize);
> +	sys_pkey_free(pkey);
> +
> +	return 0;
> +}

cheers
