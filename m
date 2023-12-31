Return-Path: <linux-kselftest+bounces-2535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3F8209EF
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 07:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388D62831B0
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE05F1844;
	Sun, 31 Dec 2023 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mht8gp7w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED117C3;
	Sun, 31 Dec 2023 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704004790;
	bh=Dw1fg8cA7zMvGsLzNfD+AeKwHxm10j1EX/O0IzVXkPk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mht8gp7wtAIP7zsdyleo8sWIQdXyFvEKMYj8oWpp3uXi8PK2NEVc2q58qTAS4IJdv
	 Obm3kwjmUk4wTyZl0PmKuU4TRYacvv1JAubgccVN/+Pj69QI18Vu1TWVHo5Hx4gzd9
	 P5H2iNb/fqByJlNz6GLl9oV9kFZUBqCKeCKAdF7PvOJmd+cc4smQ1NRqyqmffunuF3
	 97pYgdZzixyI93HyP2jcQPjCEPKpshuAGtPCuAIOPAmDVmfl6VYsT3ww+0Q/VEjOQ+
	 y/AWU+7ewoWQsDvnx8h63E/Skd5evvz5vQzdayWp2zytvBHiPkYpne4Y1P5uxBapoy
	 s/5OrcQCMb2VA==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 54E3F37813B6;
	Sun, 31 Dec 2023 06:39:43 +0000 (UTC)
Message-ID: <45cc343e-f727-4cd5-b688-9a60a87875c8@collabora.com>
Date: Sun, 31 Dec 2023 11:39:43 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, jeffxu@google.com,
 jorgelo@chromium.org, groeck@chromium.org, jannh@google.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, pedro.falcato@gmail.com,
 keescook@chromium.org, dave.hansen@intel.com, gregkh@linuxfoundation.org,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org,
 sroettger@google.com
Subject: Re: [RFC PATCH v3 10/11] selftest mm/mseal memory sealing
To: jeffxu@chromium.org
References: <20231212231706.2680890-1-jeffxu@chromium.org>
 <20231212231706.2680890-11-jeffxu@chromium.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231212231706.2680890-11-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I wasn't CC-ed on the patch even though I'd reviewed the earlier revision.


On 12/13/23 4:17 AM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> selftest for memory sealing change in mmap() and mseal().
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  tools/testing/selftests/mm/.gitignore   |    1 +
>  tools/testing/selftests/mm/Makefile     |    1 +
>  tools/testing/selftests/mm/config       |    1 +
>  tools/testing/selftests/mm/mseal_test.c | 2141 +++++++++++++++++++++++
>  4 files changed, 2144 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/mseal_test.c
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index cdc9ce4426b9..f0f22a649985 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -43,3 +43,4 @@ mdwe_test
>  gup_longterm
>  mkdirty
>  va_high_addr_switch
> +mseal_test
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 6a9fc5693145..0c086cecc093 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -59,6 +59,7 @@ TEST_GEN_FILES += mlock2-tests
>  TEST_GEN_FILES += mrelease_test
>  TEST_GEN_FILES += mremap_dontunmap
>  TEST_GEN_FILES += mremap_test
> +TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
> diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
> index be087c4bc396..cf2b8780e9b1 100644
> --- a/tools/testing/selftests/mm/config
> +++ b/tools/testing/selftests/mm/config
> @@ -6,3 +6,4 @@ CONFIG_TEST_HMM=m
>  CONFIG_GUP_TEST=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y
>  CONFIG_MEM_SOFT_DIRTY=y
> +CONFIG_MSEAL=y
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> new file mode 100644
> index 000000000000..0692485d8b3c
> --- /dev/null
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -0,0 +1,2141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <sys/mman.h>
> +#include <stdint.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +#include <stdbool.h>
> +#include "../kselftest.h"
> +#include <syscall.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <assert.h>
> +#include <fcntl.h>
> +#include <assert.h>
> +#include <sys/ioctl.h>
> +#include <sys/vfs.h>
> +#include <sys/stat.h>
> +
> +/*
> + * need those definition for manually build using gcc.
> + * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 mseal_test.c -o mseal_test
> + */
> +#ifndef MM_SEAL_SEAL
> +#define MM_SEAL_SEAL 0x1
> +#endif
> +
> +#ifndef MM_SEAL_BASE
> +#define MM_SEAL_BASE 0x2
> +#endif
> +
> +#ifndef MM_SEAL_PROT_PKEY
> +#define MM_SEAL_PROT_PKEY 0x4
> +#endif
> +
> +#ifndef MM_SEAL_DISCARD_RO_ANON
> +#define MM_SEAL_DISCARD_RO_ANON 0x8
> +#endif
> +
> +#ifndef MAP_SEALABLE
> +#define MAP_SEALABLE 0x8000000
> +#endif
> +
> +#ifndef PROT_SEAL_SEAL
> +#define PROT_SEAL_SEAL 0x04000000
> +#endif
> +
> +#ifndef PROT_SEAL_BASE
> +#define PROT_SEAL_BASE 0x08000000
> +#endif
> +
> +#ifndef PROT_SEAL_PROT_PKEY
> +#define PROT_SEAL_PROT_PKEY 0x10000000
> +#endif
> +
> +#ifndef PROT_SEAL_DISCARD_RO_ANON
> +#define PROT_SEAL_DISCARD_RO_ANON 0x20000000
> +#endif
> +
> +#ifndef PKEY_DISABLE_ACCESS
> +# define PKEY_DISABLE_ACCESS    0x1
> +#endif
> +
> +#ifndef PKEY_DISABLE_WRITE
> +# define PKEY_DISABLE_WRITE     0x2
> +#endif
> +
> +#ifndef PKEY_BITS_PER_KEY
> +#define PKEY_BITS_PER_PKEY      2
> +#endif
> +
> +#ifndef PKEY_MASK
> +#define PKEY_MASK       (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
> +#endif
> +
> +#ifndef DEBUG
> +#define LOG_TEST_ENTER()	{}
> +#else
> +#define LOG_TEST_ENTER()	{ksft_print_msg("%s\n", __func__); }
> +#endif
> +
> +#ifndef u64
> +#define u64 unsigned long long
> +#endif
> +
> +/*
> + * define sys_xyx to call syscall directly.
> + */
> +static int sys_mseal(void *start, size_t len, int types)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(__NR_mseal, start, len, types, 0);
> +	return sret;
> +}
> +
> +int sys_mprotect(void *ptr, size_t size, unsigned long prot)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(SYS_mprotect, ptr, size, prot);
> +	return sret;
> +}
> +
> +int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
> +		unsigned long pkey)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
> +	return sret;
> +}
> +
> +int sys_munmap(void *ptr, size_t size)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(SYS_munmap, ptr, size);
> +	return sret;
> +}
> +
> +static int sys_madvise(void *start, size_t len, int types)
> +{
> +	int sret;
> +
> +	errno = 0;
> +	sret = syscall(__NR_madvise, start, len, types);
> +	return sret;
> +}
> +
> +int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
> +{
> +	int ret = syscall(SYS_pkey_alloc, flags, init_val);
Add empty line here.

> +	return ret;
> +}
> +
> +static inline unsigned int __read_pkey_reg(void)
> +{
> +	unsigned int eax, edx;
> +	unsigned int ecx = 0;
> +	unsigned int pkey_reg;
> +
> +	asm volatile(".byte 0x0f,0x01,0xee\n\t"
> +			: "=a" (eax), "=d" (edx)
> +			: "c" (ecx));
> +	pkey_reg = eax;
> +	return pkey_reg;
> +}
> +
> +static inline void __write_pkey_reg(u64 pkey_reg)
> +{
> +	unsigned int eax = pkey_reg;
> +	unsigned int ecx = 0;
> +	unsigned int edx = 0;
> +
> +	asm volatile(".byte 0x0f,0x01,0xef\n\t"
> +			: : "a" (eax), "c" (ecx), "d" (edx));
> +	assert(pkey_reg == __read_pkey_reg());
> +}
> +
> +static inline unsigned long pkey_bit_position(int pkey)
> +{
> +	return pkey * PKEY_BITS_PER_PKEY;
> +}
> +
> +static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
> +{
> +	unsigned long shift = pkey_bit_position(pkey);
> +	/* mask out bits from pkey in old value */
> +	reg &= ~((u64)PKEY_MASK << shift);
> +	/* OR in new bits for pkey */
> +	reg |= (flags & PKEY_MASK) << shift;
> +	return reg;
> +}
> +
> +static inline void set_pkey(int pkey, unsigned long pkey_value)
> +{
> +	unsigned long mask = (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
> +	u64 new_pkey_reg;
> +
> +	assert(!(pkey_value & ~mask));
> +	new_pkey_reg = set_pkey_bits(__read_pkey_reg(), pkey, pkey_value);
> +	__write_pkey_reg(new_pkey_reg);
> +}
> +
> +void setup_single_address(int size, void **ptrOut)
> +{
> +	void *ptr;
> +
> +	ptr = mmap(NULL, size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_SEALABLE, -1, 0);
> +	assert(ptr != (void *)-1);
> +	*ptrOut = ptr;
> +}
> +
> +void setup_single_address_sealable(int size, void **ptrOut, bool sealable)
> +{
> +	void *ptr;
> +	unsigned long mapflags = MAP_ANONYMOUS | MAP_PRIVATE;
> +
> +	if (sealable)
> +		mapflags |= MAP_SEALABLE;
> +
> +	ptr = mmap(NULL, size, PROT_READ, mapflags, -1, 0);
> +	assert(ptr != (void *)-1);
> +	*ptrOut = ptr;
> +}
> +
> +void setup_single_address_rw_sealable(int size, void **ptrOut, bool sealable)
> +{
> +	void *ptr;
> +	unsigned long mapflags = MAP_ANONYMOUS | MAP_PRIVATE;
> +
> +	if (sealable)
> +		mapflags |= MAP_SEALABLE;
> +
> +	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, mapflags, -1, 0);
> +	assert(ptr != (void *)-1);
> +	*ptrOut = ptr;
> +}
> +
> +void clean_single_address(void *ptr, int size)
> +{
> +	int ret;
> +
> +	ret = munmap(ptr, size);
> +	assert(!ret);
> +}
> +
> +void seal_mprotect_single_address(void *ptr, int size)
> +{
> +	int ret;
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_PROT_PKEY);
> +	assert(!ret);
> +}
> +
> +void seal_discard_ro_anon_single_address(void *ptr, int size)
> +{
> +	int ret;
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_DISCARD_RO_ANON);
> +	assert(!ret);
> +}
> +
> +static void test_seal_addseals(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	/* adding seal one by one */
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_BASE);
> +	assert(!ret);
> +	ret = sys_mseal(ptr, size, MM_SEAL_PROT_PKEY);
> +	assert(!ret);
> +	ret = sys_mseal(ptr, size, MM_SEAL_SEAL);
> +	assert(!ret);
> +}
> +
> +static void test_seal_addseals_combined(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_PROT_PKEY);
> +	assert(!ret);
> +
> +	/* adding multiple seals */
> +	ret = sys_mseal(ptr, size,
> +			MM_SEAL_PROT_PKEY | MM_SEAL_BASE|
> +			MM_SEAL_SEAL);
> +	assert(!ret);
> +
> +	/* not adding more seal type, so ok. */
> +	ret = sys_mseal(ptr, size, MM_SEAL_BASE);
> +	assert(!ret);
> +
> +	/* not adding more seal type, so ok. */
> +	ret = sys_mseal(ptr, size, MM_SEAL_SEAL);
> +	assert(!ret);
> +}
> +
> +static void test_seal_addseals_reject(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	ret = sys_mseal(ptr, size, MM_SEAL_BASE | MM_SEAL_SEAL);
> +	assert(!ret);
> +
> +	/* MM_SEAL_SEAL is set, so not allow new seal type . */
> +	ret = sys_mseal(ptr, size,
> +			MM_SEAL_PROT_PKEY | MM_SEAL_BASE | MM_SEAL_SEAL);
> +	assert(ret < 0);
> +}
> +
> +static void test_seal_unmapped_start(void)
> +{
> +	LOG_TEST_ENTER();
> +	int ret;
> +	void *ptr;
> +	unsigned long page_size = getpagesize();
> +	unsigned long size = 4 * page_size;
> +
> +	setup_single_address(size, &ptr);
> +
> +	// munmap 2 pages from ptr.
Don't use different commenting styles in one file. Use /* */ for comments.

> +	ret = sys_munmap(ptr, 2 * page_size);
> +	assert(!ret);
> +
> +	// mprotect will fail because 2 pages from ptr are unmapped.
> +	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> +	assert(ret < 0);
> +
> +	// mseal will fail because 2 pages from ptr are unmapped.
> +	ret = sys_mseal(ptr, size, MM_SEAL_SEAL);
> +	assert(ret < 0);
> +
> +	ret = sys_mseal(ptr + 2 * page_size, 2 * page_size, MM_SEAL_SEAL);
> +	assert(!ret);
> +}
> +

