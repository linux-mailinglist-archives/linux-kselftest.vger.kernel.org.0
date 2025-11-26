Return-Path: <linux-kselftest+bounces-46531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB45C8B103
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 17:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C0934ECE3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA2D33F397;
	Wed, 26 Nov 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XYdMB9I6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6833F382;
	Wed, 26 Nov 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175812; cv=none; b=srMN3h3TW1WyYFoDX0qjvP9NFVmUsx03mD902onBTvo/rhcQhE2BF5poNKN1cDoGPy0cDULfrsu08ukOhddhsLNRyv6xXtqXz1mK5dlWkRQ3ya6ocMHlZHF10T5aycJbUvpD7XodeTBIe3rwebfLwACo+Ez5Oc16r1sWpQq2GXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175812; c=relaxed/simple;
	bh=LEZvO3SRrTgPGOIAt0BnLB1gssjBkcBbXqQpASF4fwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gbieDJjudPF93l5M3ZaD1QUc1rumPJ8Ykjz1iUaWxyT0zaWDty+/DgE4lghaztiBvDwad/pEEZnvCgoBOrHQPzGRnpbtdLQX3ym5j3AQdBCcVS5XqDViMDikKUuLO+uF6aGAz9lMq1eBkeacpIG1Ea6lRNDV5VzA3v3eAOsZ3j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XYdMB9I6; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764175810; x=1795711810;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=hOWpCuTZQXXu+UFDi92tkah8da8iWaYrZywVBBw9cnQ=;
  b=XYdMB9I61uQeaKROvWZTaPxhyl5Vm531YyJxtWsmOH+lVWqijbGJhh05
   6G//jl2CWpJz5i/+PI5ZVazaRH2awjh8RiE4AnwXQ5F5pPzH1OxCL22R0
   mc1NiqgIS+ZhElSxEbKSAsL3GRAYiJMuMwJjIRR3GLVcP+qW+/W8BA1B7
   Ykew3MlxMeuT6FdcMa4A94kgQcmjFsCRpLdL1ibHeZ+51GAoqi2W7aC8Z
   7W58/PhfflNU3YSeWMW2Msckhby9/UR44jfqy0p/lEffJTQM58dOnlrtp
   qIpHOqMWNg0OtZg1c9tVER2c7qo/DLHKBKIP6WIUHSnFNmAmFavvWT97T
   Q==;
X-CSE-ConnectionGUID: KZIjcG2CQ6ucnaRhPFfPyw==
X-CSE-MsgGUID: eHrl8mI8Tee2eBv0E8nJCw==
X-IronPort-AV: E=Sophos;i="6.20,228,1758585600"; 
   d="scan'208";a="5751043"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 16:49:50 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:17770]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.27.255:2525] with esmtp (Farcaster)
 id 2808e225-d96e-4595-94bf-b76a6f3bfa50; Wed, 26 Nov 2025 16:49:50 +0000 (UTC)
X-Farcaster-Flow-ID: 2808e225-d96e-4595-94bf-b76a6f3bfa50
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 26 Nov 2025 16:49:49 +0000
Received: from [192.168.8.204] (10.106.83.30) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 26 Nov 2025
 16:49:47 +0000
Message-ID: <18b4cddb-3e04-4272-9f04-6857cea70ff5@amazon.com>
Date: Wed, 26 Nov 2025 16:49:46 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v2 5/5] KVM: selftests: test userfaultfd minor for
 guest_memfd
To: Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC: Andrea Arcangeli <aarcange@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand
	<david@redhat.com>, Hugh Dickins <hughd@google.com>, James Houghton
	<jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, Michal Hocko
	<mhocko@suse.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Xu
	<peterx@redhat.com>, "Sean Christopherson" <seanjc@google.com>, Shuah Khan
	<shuah@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, Vlastimil Babka
	<vbabka@suse.cz>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-6-rppt@kernel.org>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <20251125183840.2368510-6-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D002EUC001.ant.amazon.com (10.252.51.219) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 25/11/2025 18:38, Mike Rapoport wrote:
> From: Nikita Kalyazin <kalyazin@amazon.com>
> 
> The test demonstrates that a minor userfaultfd event in guest_memfd can
> be resolved via a memcpy followed by a UFFDIO_CONTINUE ioctl.
> 
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   .../testing/selftests/kvm/guest_memfd_test.c  | 103 ++++++++++++++++++
>   1 file changed, 103 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index e7d9aeb418d3..a5d3ed21d7bb 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -10,13 +10,17 @@
>   #include <errno.h>
>   #include <stdio.h>
>   #include <fcntl.h>
> +#include <pthread.h>
> 
>   #include <linux/bitmap.h>
>   #include <linux/falloc.h>
>   #include <linux/sizes.h>
> +#include <linux/userfaultfd.h>
>   #include <sys/mman.h>
>   #include <sys/types.h>
>   #include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/ioctl.h>
> 
>   #include "kvm_util.h"
>   #include "test_util.h"
> @@ -254,6 +258,104 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
>          }
>   }
> 
> +struct fault_args {
> +       char *addr;
> +       volatile char value;
> +};
> +
> +static void *fault_thread_fn(void *arg)
> +{
> +       struct fault_args *args = arg;
> +
> +       /* Trigger page fault */
> +       args->value = *args->addr;
> +       return NULL;
> +}
> +
> +static void test_uffd_minor(int fd, size_t total_size)
> +{
> +       struct uffdio_api uffdio_api = {
> +               .api = UFFD_API,
> +               .features = UFFD_FEATURE_MINOR_GENERIC,

Should it be UFFD_FEATURE_MINOR_SHMEM instead? 
UFFD_FEATURE_MINOR_GENERIC was removed in the v1.

> +       };
> +       struct uffdio_register uffd_reg;
> +       struct uffdio_continue uffd_cont;
> +       struct uffd_msg msg;
> +       struct fault_args args;
> +       pthread_t fault_thread;
> +       void *mem, *mem_nofault, *buf = NULL;
> +       int uffd, ret;
> +       off_t offset = page_size;
> +       void *fault_addr;
> +
> +       ret = posix_memalign(&buf, page_size, total_size);
> +       TEST_ASSERT_EQ(ret, 0);
> +
> +       memset(buf, 0xaa, total_size);
> +
> +       uffd = syscall(__NR_userfaultfd, O_CLOEXEC);
> +       TEST_ASSERT(uffd != -1, "userfaultfd creation should succeed");
> +
> +       ret = ioctl(uffd, UFFDIO_API, &uffdio_api);
> +       TEST_ASSERT(ret != -1, "ioctl(UFFDIO_API) should succeed");
> +
> +       mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +       TEST_ASSERT(mem != MAP_FAILED, "mmap should succeed");
> +
> +       mem_nofault = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +       TEST_ASSERT(mem_nofault != MAP_FAILED, "mmap should succeed");
> +
> +       uffd_reg.range.start = (unsigned long)mem;
> +       uffd_reg.range.len = total_size;
> +       uffd_reg.mode = UFFDIO_REGISTER_MODE_MINOR;
> +       ret = ioctl(uffd, UFFDIO_REGISTER, &uffd_reg);
> +       TEST_ASSERT(ret != -1, "ioctl(UFFDIO_REGISTER) should succeed");
> +
> +       ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
> +                       offset, page_size);
> +       TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
> +
> +       fault_addr = mem + offset;
> +       args.addr = fault_addr;
> +
> +       ret = pthread_create(&fault_thread, NULL, fault_thread_fn, &args);
> +       TEST_ASSERT(ret == 0, "pthread_create should succeed");
> +
> +       ret = read(uffd, &msg, sizeof(msg));
> +       TEST_ASSERT(ret != -1, "read from userfaultfd should succeed");
> +       TEST_ASSERT(msg.event == UFFD_EVENT_PAGEFAULT, "event type should be pagefault");
> +       TEST_ASSERT((void *)(msg.arg.pagefault.address & ~(page_size - 1)) == fault_addr,
> +                   "pagefault should occur at expected address");
> +
> +       memcpy(mem_nofault + offset, buf + offset, page_size);
> +
> +       uffd_cont.range.start = (unsigned long)fault_addr;
> +       uffd_cont.range.len = page_size;
> +       uffd_cont.mode = 0;
> +       ret = ioctl(uffd, UFFDIO_CONTINUE, &uffd_cont);
> +       TEST_ASSERT(ret != -1, "ioctl(UFFDIO_CONTINUE) should succeed");
> +
> +       /*
> +        * wait for fault_thread to finish to make sure fault happened and was
> +        * resolved before we verify the values
> +        */
> +       ret = pthread_join(fault_thread, NULL);
> +       TEST_ASSERT(ret == 0, "pthread_join should succeed");
> +
> +       TEST_ASSERT(args.value == *(char *)(mem_nofault + offset),
> +                   "memory should contain the value that was copied");
> +       TEST_ASSERT(args.value == *(char *)(mem + offset),
> +                   "no further fault is expected");
> +
> +       ret = munmap(mem_nofault, total_size);
> +       TEST_ASSERT(!ret, "munmap should succeed");
> +
> +       ret = munmap(mem, total_size);
> +       TEST_ASSERT(!ret, "munmap should succeed");
> +       free(buf);
> +       close(uffd);
> +}
> +
>   #define gmem_test(__test, __vm, __flags)                               \
>   do {                                                                   \
>          int fd = vm_create_guest_memfd(__vm, page_size * 4, __flags);   \
> @@ -273,6 +375,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
>                  if (flags & GUEST_MEMFD_FLAG_INIT_SHARED) {
>                          gmem_test(mmap_supported, vm, flags);
>                          gmem_test(fault_overflow, vm, flags);
> +                       gmem_test(uffd_minor, vm, flags);
>                  } else {
>                          gmem_test(fault_private, vm, flags);
>                  }
> --
> 2.50.1
> 


