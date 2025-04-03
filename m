Return-Path: <linux-kselftest+bounces-30075-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE1A7A85F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 19:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B67416E61E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9742505DC;
	Thu,  3 Apr 2025 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TNbtjHjz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D3D19ABD4;
	Thu,  3 Apr 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699771; cv=none; b=sa4/hcjZFm/k2bx+p5pg4NY+iAjuKM9E3BX/EBhA8tve3NBDC+8Y5zNixNpZw6UzKfTw+HbdleqZ96dWE/8svulU6Ch+rm6xz9tvGlE5V9tNAm8d7tYFLikoFewLzoJA0GOfOsNZGk2ojHrP/z+Jba5LRuaLc03tvQX/hTXF4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699771; c=relaxed/simple;
	bh=kFT6oxDCykTTfkfLTYfDgqn37UR0XWhepmm8AHbLFBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HsxxCu8X3gPwY1ZlKefMNj1DK5t+R2Y5XZysRkNkqiAM1+gNmXIcbnsEO6XH8ugY1ocy+zXem48+5fvA9Vt62J248ahOCvF/kiJBt/ca9rQ6lOr+eXP59kTU6TD/kLI1ZG/GHuRoFwb4NMU19DfLdWBBPXO59dx2NtSoGQaEabQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TNbtjHjz; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743699767; x=1775235767;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=Vrt8HAH7HRkAvVDOOCvogEGI+tUnOxBHeVj88MXjLY4=;
  b=TNbtjHjzXToCY00p+2aRCdnVdvlhIkACn+HFS739aD3rTPYa+mOwP3nD
   TkZ71xxfblk2i+PnYhWMeWKopcw1xThBC83yDNvFOR+I+UHHdZ/4v6yoe
   VyNEZDkMPK/qFAD85UF0wFeq9Y/dYPCCjV8zxWSkbeDEoK/Jvdi7yKnaz
   g=;
X-IronPort-AV: E=Sophos;i="6.15,184,1739836800"; 
   d="scan'208";a="732644750"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 17:02:39 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:54330]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.201:2525] with esmtp (Farcaster)
 id 80ec3721-3f59-4f72-add9-63b260817a4d; Thu, 3 Apr 2025 17:02:38 +0000 (UTC)
X-Farcaster-Flow-ID: 80ec3721-3f59-4f72-add9-63b260817a4d
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 17:02:38 +0000
Received: from [192.168.28.77] (10.106.82.23) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Thu, 3 Apr 2025
 17:02:37 +0000
Message-ID: <3a54adea-98d0-4af3-a121-6574b0c18f80@amazon.com>
Date: Thu, 3 Apr 2025 18:02:36 +0100
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
To: James Houghton <jthoughton@google.com>
CC: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <peterx@redhat.com>, <graf@amazon.de>,
	<jgowans@amazon.com>, <roypat@amazon.co.uk>, <derekmn@amazon.com>,
	<nsaenz@amazon.es>, <xmarcalx@amazon.com>
References: <20250402160721.97596-1-kalyazin@amazon.com>
 <20250402160721.97596-6-kalyazin@amazon.com>
 <CADrL8HXm_UDKvrsNe6Guvo_pPvCN9ZJBKe=p0HM-iYZWufbEfA@mail.gmail.com>
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
In-Reply-To: <CADrL8HXm_UDKvrsNe6Guvo_pPvCN9ZJBKe=p0HM-iYZWufbEfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D009EUA003.ant.amazon.com (10.252.50.105) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 02/04/2025 22:10, James Houghton wrote:
> On Wed, Apr 2, 2025 at 9:08 AM Nikita Kalyazin <kalyazin@amazon.com> wrote:
>>
>> The test demonstrates that a minor userfaultfd event in guest_memfd can
>> be resolved via a memcpy followed by a UFFDIO_CONTINUE ioctl.
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   .../testing/selftests/kvm/guest_memfd_test.c  | 94 +++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
>> index 38c501e49e0e..9b47b796f3aa 100644
>> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
>> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
>> @@ -10,12 +10,16 @@
>>   #include <errno.h>
>>   #include <stdio.h>
>>   #include <fcntl.h>
>> +#include <pthread.h>
>>
>>   #include <linux/bitmap.h>
>>   #include <linux/falloc.h>
>> +#include <linux/userfaultfd.h>
>>   #include <sys/mman.h>
>>   #include <sys/types.h>
>>   #include <sys/stat.h>
>> +#include <sys/syscall.h>
>> +#include <sys/ioctl.h>
>>
>>   #include "kvm_util.h"
>>   #include "test_util.h"
>> @@ -206,6 +210,93 @@ static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
>>          close(fd1);
>>   }
>>
>> +struct fault_args {
>> +       char *addr;
>> +       volatile char value;
> 
> I think you should/must put volatile on `addr` and not on `value`.

This was to prevent the compiler from omitting the write to the value, 
because it's never read later on.

> 
>> +};
>> +
>> +static void *fault_thread_fn(void *arg)
>> +{
>> +       struct fault_args *args = arg;
>> +
>> +       /* Trigger page fault */
>> +       args->value = *args->addr;
>> +       return NULL;
>> +}
>> +
>> +static void test_uffd_missing(int fd, size_t page_size, size_t total_size)
> 
> test_uffd_minor? :)
> 
>> +{
>> +       struct uffdio_register uffd_reg;
>> +       struct uffdio_continue uffd_cont;
>> +       struct uffd_msg msg;
>> +       struct fault_args args;
>> +       pthread_t fault_thread;
>> +       void *mem, *mem_nofault, *buf = NULL;
>> +       int uffd, ret;
>> +       off_t offset = page_size;
>> +       void *fault_addr;
>> +
>> +       ret = posix_memalign(&buf, page_size, total_size);
>> +       TEST_ASSERT_EQ(ret, 0);
>> +
>> +       uffd = syscall(__NR_userfaultfd, O_CLOEXEC);
>> +       TEST_ASSERT(uffd != -1, "userfaultfd creation should succeed");
>> +
>> +       struct uffdio_api uffdio_api = {
>> +               .api = UFFD_API,
>> +               .features = UFFD_FEATURE_MISSING_SHMEM,
> 
> I think you mean UFFD_FEATURE_MINOR_SHMEM...?
> 
> And I'm trying to think through what feature we should expose for
> guest_memfd; UFFD_FEATURE_MINOR_SHMEM already indicates support for
> shmem.
> 
> We could have UFFD_FEATURE_MINOR_GUESTMEMFD, perhaps that's enough.

Yes, I will introduce UFFD_FEATURE_MINOR_GUEST_MEMFD in the next version.

> 
> Or we could have UFFD_FEATURE_MINOR_GENERIC (or nothing at all!). Some
> VMAs might not support the minor mode, and the user will figure that
> out when UFFDIO_REGISTER fails.

My concern is the exact reason of the failure may not be apparent to the 
caller in that case.

> 
>> +       };
>> +       ret = ioctl(uffd, UFFDIO_API, &uffdio_api);
>> +       TEST_ASSERT(ret != -1, "ioctl(UFFDIO_API) should succeed");
>> +
>> +       mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> +       TEST_ASSERT(mem != MAP_FAILED, "mmap should succeed");
>> +
>> +       mem_nofault = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>> +       TEST_ASSERT(mem_nofault != MAP_FAILED, "mmap should succeed");
>> +
>> +       uffd_reg.range.start = (unsigned long)mem;
>> +       uffd_reg.range.len = total_size;
>> +       uffd_reg.mode = UFFDIO_REGISTER_MODE_MINOR;
>> +       ret = ioctl(uffd, UFFDIO_REGISTER, &uffd_reg);
>> +       TEST_ASSERT(ret != -1, "ioctl(UFFDIO_REGISTER) should succeed");
>> +
>> +       ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
>> +                       offset, page_size);
>> +       TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");
>> +
>> +       fault_addr = mem + offset;
>> +       args.addr = fault_addr;
>> +
>> +       ret = pthread_create(&fault_thread, NULL, fault_thread_fn, &args);
>> +       TEST_ASSERT(ret == 0, "pthread_create should succeed");
>> +
>> +       ret = read(uffd, &msg, sizeof(msg));
>> +       TEST_ASSERT(ret != -1, "read from userfaultfd should succeed");
>> +       TEST_ASSERT(msg.event == UFFD_EVENT_PAGEFAULT, "event type should be pagefault");
>> +       TEST_ASSERT((void *)(msg.arg.pagefault.address & ~(page_size - 1)) == fault_addr,
>> +                   "pagefault should occur at expected address");
>> +
>> +       memcpy(mem_nofault + offset, buf + offset, page_size);
>> +
>> +       uffd_cont.range.start = (unsigned long)fault_addr;
>> +       uffd_cont.range.len = page_size;
>> +       uffd_cont.mode = 0;
>> +       ret = ioctl(uffd, UFFDIO_CONTINUE, &uffd_cont);
>> +       TEST_ASSERT(ret != -1, "ioctl(UFFDIO_CONTINUE) should succeed");
>> +
>> +       ret = pthread_join(fault_thread, NULL);
>> +       TEST_ASSERT(ret == 0, "pthread_join should succeed");
> 
> And maybe also:
> 
> /* Right value? */
> TEST_ASSERT(args.value == *(char *)mem_nofault));
> /* No second fault? */
> TEST_ASSERT(args.value == *(char *)mem);

Good idea, thanks.  I don't need the volatile anymore :)

> 
>> +
>> +       ret = munmap(mem_nofault, total_size);
>> +       TEST_ASSERT(!ret, "munmap should succeed");
>> +
>> +       ret = munmap(mem, total_size);
>> +       TEST_ASSERT(!ret, "munmap should succeed");
>> +       free(buf);
>> +       close(uffd);
>> +}
>> +
>>   unsigned long get_shared_type(void)
>>   {
>>   #ifdef __x86_64__
>> @@ -244,6 +335,9 @@ void test_vm_type(unsigned long type, bool is_shared)
>>          test_fallocate(fd, page_size, total_size);
>>          test_invalid_punch_hole(fd, page_size, total_size);
>>
>> +       if (is_shared)
>> +               test_uffd_missing(fd, page_size, total_size);
>> +
>>          close(fd);
>>          kvm_vm_release(vm);
>>   }
>> --
>> 2.47.1
>>


