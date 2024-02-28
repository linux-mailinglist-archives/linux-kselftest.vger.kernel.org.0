Return-Path: <linux-kselftest+bounces-5526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B13F86ADF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 12:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E90728ACA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 11:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F397350E;
	Wed, 28 Feb 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C+aeAf4X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6537350A;
	Wed, 28 Feb 2024 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120816; cv=none; b=WO0acI9eGRmZDcUzgyrZDOcaFHDyh1X21hnxdrh8f7H1Kohhcjtoy5N8pQ3euN0jn7AGze2EfQZusOjpA0c1+YTJ1EyAnCF0TYbUDV9VRnSmegnZX3Xpz1n4sjPxR+tvztRobTLkNqBzo6ggHAxQABjglnf5epj8GAQQIT7TeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120816; c=relaxed/simple;
	bh=4ccIL/FewxN6zCtG9J2D1E6ShludSoiWh2jd8qI46LE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CAm+/t8XS6JwpebZ8I8GKyQ367z3nr7okLZHtW22FZHnrr1BqicRA5Bt0Q8YgrZLJVLooV3d3A/s7ADSyfey9yqSUPGsY9gUBaF7IgFMS0sBKrpQM9d5S8TD0E6tJL2fpDcpRjlA9QcAXHC7cm0FSlWDoD7wC6B86xsrPBAQx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C+aeAf4X; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709120811;
	bh=4ccIL/FewxN6zCtG9J2D1E6ShludSoiWh2jd8qI46LE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=C+aeAf4XT/lqHD3vImaQUNYq486ua6dauLwFwQNoFAgHixTFivPYA4oEPHUP3kphx
	 CcL//Y21dL+3cfN4HhoCzLtxn99/zvDOOUlM+Lt7jx7rwG0uAluuUDakObMrGza2yG
	 H/cpDUnaiO44ln2ofM+zLRzCULIh76ZQLNteWxzFwRHgkR5h5Zl8SmO1JWbboYGUXm
	 TpaMof8+1gdQjkC47gsD30PE/OYAKnitPAJX0XNZSc+b4ygCw11ORHYUGzwRjAa75d
	 2vEjqOVwhwy3J999noSgsvW2PthEoUqwilui9oV0ln5HtS116WBDQckAWkXi0Nty2z
	 Zh8pUCTsg7Spg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 35CAF37820D2;
	Wed, 28 Feb 2024 11:46:49 +0000 (UTC)
Message-ID: <a90a91bd-6182-412f-bfd9-fa3e3f9cc93e@collabora.com>
Date: Wed, 28 Feb 2024 16:47:14 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/dmabuf-heap: conform test to TAP format
 output
Content-Language: en-US
To: "T.J. Mercier" <tjmercier@google.com>
References: <20240227121920.1905095-1-usama.anjum@collabora.com>
 <CABdmKX3_+G20TB5HJLLLMQQ1-i9g=RV1QU_A00Knd08pyiJWgw@mail.gmail.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABdmKX3_+G20TB5HJLLLMQQ1-i9g=RV1QU_A00Knd08pyiJWgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/24 10:18 PM, T.J. Mercier wrote:
> On Tue, Feb 27, 2024 at 4:21 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Update some more error handling code
>> ---
>>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 217 +++++++-----------
>>  1 file changed, 81 insertions(+), 136 deletions(-)
>>
>> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>> index 890a8236a8ba7..41a8485cad5d0 100644
>> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/dma-buf.h>
>>  #include <linux/dma-heap.h>
>>  #include <drm/drm.h>
>> +#include "../kselftest.h"
>>
>>  #define DEVPATH "/dev/dma_heap"
>>
>> @@ -90,14 +91,13 @@ static int dmabuf_heap_open(char *name)
>>         char buf[256];
>>
>>         ret = snprintf(buf, 256, "%s/%s", DEVPATH, name);
>> -       if (ret < 0) {
>> -               printf("snprintf failed!\n");
>> -               return ret;
>> -       }
>> +       if (ret < 0)
>> +               ksft_exit_fail_msg("snprintf failed!\n");
>>
>>         fd = open(buf, O_RDWR);
>>         if (fd < 0)
>> -               printf("open %s failed!\n", buf);
>> +               ksft_exit_fail_msg("open %s failed: %s\n", buf, strerror(errno));
>> +
>>         return fd;
>>  }
>>
>> @@ -140,7 +140,7 @@ static int dmabuf_sync(int fd, int start_stop)
>>
>>  #define ONE_MEG (1024 * 1024)
>>
>> -static int test_alloc_and_import(char *heap_name)
>> +static void test_alloc_and_import(char *heap_name)
>>  {
>>         int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
>>         uint32_t handle = 0;
>> @@ -148,16 +148,12 @@ static int test_alloc_and_import(char *heap_name)
>>         int ret;
>>
>>         heap_fd = dmabuf_heap_open(heap_name);
>> -       if (heap_fd < 0)
>> -               return -1;
>>
>> -       printf("  Testing allocation and importing:  ");
>> +       ksft_print_msg("Testing allocation and importing:\n");
>>         ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
>> -       if (ret) {
>> -               printf("FAIL (Allocation Failed!)\n");
>> -               ret = -1;
>> -               goto out;
>> -       }
>> +       if (ret)
>> +               ksft_exit_fail_msg("FAIL (Allocation Failed!)\n");
>> +
>>         /* mmap and write a simple pattern */
>>         p = mmap(NULL,
>>                  ONE_MEG,
>> @@ -165,11 +161,8 @@ static int test_alloc_and_import(char *heap_name)
>>                  MAP_SHARED,
>>                  dmabuf_fd,
>>                  0);
>> -       if (p == MAP_FAILED) {
>> -               printf("FAIL (mmap() failed)\n");
>> -               ret = -1;
>> -               goto out;
>> -       }
>> +       if (p == MAP_FAILED)
>> +               ksft_exit_fail_msg("FAIL (mmap() failed)\n");
>>
>>         dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
>>         memset(p, 1, ONE_MEG / 2);
>> @@ -179,31 +172,28 @@ static int test_alloc_and_import(char *heap_name)
>>         importer_fd = open_vgem();
>>         if (importer_fd < 0) {
>>                 ret = importer_fd;
>> -               printf("(Could not open vgem - skipping):  ");
>> +               ksft_test_result_skip("Could not open vgem\n");
>>         } else {
>>                 ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
>> -               if (ret < 0) {
>> -                       printf("FAIL (Failed to import buffer)\n");
>> -                       goto out;
>> -               }
>> +               ksft_test_result(ret >= 0, "Import buffer\n");
>>         }
>>
>>         ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
>>         if (ret < 0) {
>> -               printf("FAIL (DMA_BUF_SYNC_START failed!)\n");
>> +               ksft_print_msg("FAIL (DMA_BUF_SYNC_START failed!)\n");
>>                 goto out;
>>         }
>>
>>         memset(p, 0xff, ONE_MEG);
>>         ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
>>         if (ret < 0) {
>> -               printf("FAIL (DMA_BUF_SYNC_END failed!)\n");
>> +               ksft_print_msg("FAIL (DMA_BUF_SYNC_END failed!)\n");
>>                 goto out;
>>         }
>>
>>         close_handle(importer_fd, handle);
>> -       ret = 0;
>> -       printf(" OK\n");
>> +       ksft_test_result_pass("%s\n", __func__);
>> +       return;
>>  out:
>>         if (p)
>>                 munmap(p, ONE_MEG);
>> @@ -214,35 +204,30 @@ static int test_alloc_and_import(char *heap_name)
>>         if (heap_fd >= 0)
>>                 close(heap_fd);
>>
>> -       return ret;
>> +       ksft_test_result_fail("%s\n", __func__);
>>  }
>>
>> -static int test_alloc_zeroed(char *heap_name, size_t size)
>> +static void test_alloc_zeroed(char *heap_name, size_t size)
>>  {
>>         int heap_fd = -1, dmabuf_fd[32];
>>         int i, j, ret;
>>         void *p = NULL;
>>         char *c;
>>
>> -       printf("  Testing alloced %ldk buffers are zeroed:  ", size / 1024);
>> +       ksft_print_msg("Testing alloced %ldk buffers are zeroed:\n", size / 1024);
>>         heap_fd = dmabuf_heap_open(heap_name);
>> -       if (heap_fd < 0)
>> -               return -1;
>>
>>         /* Allocate and fill a bunch of buffers */
>>         for (i = 0; i < 32; i++) {
>>                 ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
>> -               if (ret < 0) {
>> -                       printf("FAIL (Allocation (%i) failed)\n", i);
>> -                       goto out;
>> -               }
>> +               if (ret)
>> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) failed)\n", i);
>> +
>>                 /* mmap and fill with simple pattern */
>>                 p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
>> -               if (p == MAP_FAILED) {
>> -                       printf("FAIL (mmap() failed!)\n");
>> -                       ret = -1;
>> -                       goto out;
>> -               }
>> +               if (p == MAP_FAILED)
>> +                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
> 
> So based on the previous ksft_exit_fail_msg calls I thought your
> intention was to exit the program and never run subsequent tests when
> errors occurred. That's what led to my initial comment about switching
> to ksft_exit_fail_msg from ksft_print_msg here, and I expected to see
> only ksft_exit_fail_msg for error cases afterwards. But you're still
> mixing ksft_exit_fail_msg and (ksft_print_msg +
> ksft_test_result{_pass,_fail,_skip}) so we've got a mix of behaviors
> where some errors lead to complete program exits and different errors
> lead to skipped/failed tests followed by further progress.
> 
> It seems most useful and predictable to me to have all tests run even
> after encountering an error for a single test, which we don't get when
> ksft_exit_fail_msg is called from the individual tests. I was fine
> with switching all error handling to ksft_exit_fail_msg to eliminate
> cleanup code and reduce maintenance, but I think we should be
> consistent with the behavior for dealing with errors which this
> doesn't currently have. So let's either always call ksft_exit_fail_msg
> for errors, or never call it (my preference).
The following rules are being used:
- If a fetal error occurs where initial conditions to perform a test aren't
fulfilled, we exit the entire test by ksft_exit_fail_msg().
- If some test fails after fulfilling of initial conditions,
ksft_print_msg() + ksft_test_result{_pass,_fail} are used to avoid putting
multiple ksft_test_result_fail() and later ksft_test_result_pass.

ksft_exit_fail_msg() like behaviour was being followed before this patch.
On non-zero return value, all of following test weren't being run.
ksft_exit_fail_msg() cannot be used on every failure as it wouldn't run
following test cases.


> 
> Slight tangent:
> For this specific MAP_FAILED error, I don't actually think it should
> be considered a test failure because the mmap operation is optional
> for dma-buf: https://docs.kernel.org/driver-api/dma-buf.html#c.dma_buf_ops.
> It would be pretty unusual to get a buffer like that, and skipping
> instead of failing when that happens would differ from the original
> behavior of the test so that could go in another patch, but I wanted
> to point this out.
I see. This can be done in another patch after this one.

> 
>> +
>>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
>>                 memset(p, 0xff, size);
>>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
>> @@ -255,23 +240,19 @@ static int test_alloc_zeroed(char *heap_name, size_t size)
>>         /* Allocate and validate all buffers are zeroed */
>>         for (i = 0; i < 32; i++) {
>>                 ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
>> -               if (ret < 0) {
>> -                       printf("FAIL (Allocation (%i) failed)\n", i);
>> -                       goto out;
>> -               }
>> +               if (ret < 0)
>> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) failed)\n", i);
>>
>>                 /* mmap and validate everything is zero */
>>                 p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
>> -               if (p == MAP_FAILED) {
>> -                       printf("FAIL (mmap() failed!)\n");
>> -                       ret = -1;
>> -                       goto out;
>> -               }
>> +               if (p == MAP_FAILED)
>> +                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
>> +
>>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
>>                 c = (char *)p;
>>                 for (j = 0; j < size; j++) {
>>                         if (c[j] != 0) {
>> -                               printf("FAIL (Allocated buffer not zeroed @ %i)\n", j);
>> +                               ksft_print_msg("FAIL (Allocated buffer not zeroed @ %i)\n", j);
>>                                 break;
>>                         }
>>                 }
>> @@ -283,16 +264,8 @@ static int test_alloc_zeroed(char *heap_name, size_t size)
>>                 close(dmabuf_fd[i]);
>>
>>         close(heap_fd);
>> -       printf("OK\n");
>> -       return 0;
>> -
>> -out:
>> -       while (i > 0) {
>> -               close(dmabuf_fd[i]);
>> -               i--;
>> -       }
>> -       close(heap_fd);
>> -       return ret;
>> +       ksft_test_result_pass("%s\n", __func__);
> 
> Don't we need ksft_test_result based on whether we ever see a non-zero
> value so that we get ksft_cnt.ksft_fail++ for the failure case?
> Otherwise we could have all non-zero values and the test would still
> pass with a bunch of "FAIL (Allocated buffer not zeroed"
> ksft_print_msg.
Yeah, I'll fix it.

> 
>> +       return;
>>  }
>>
>>  /* Test the ioctl version compatibility w/ a smaller structure then expected */
>> @@ -360,126 +333,98 @@ static int dmabuf_heap_alloc_newer(int fd, size_t len, unsigned int flags,
>>         return ret;
>>  }
>>
>> -static int test_alloc_compat(char *heap_name)
>> +static void test_alloc_compat(char *heap_name)
>>  {
>> -       int heap_fd = -1, dmabuf_fd = -1;
>> -       int ret;
>> +       int ret, heap_fd = -1, dmabuf_fd = -1;
>>
>>         heap_fd = dmabuf_heap_open(heap_name);
>> -       if (heap_fd < 0)
>> -               return -1;
>>
>> -       printf("  Testing (theoretical)older alloc compat:  ");
>> +       ksft_print_msg("Testing (theoretical) older alloc compat:\n");
>>         ret = dmabuf_heap_alloc_older(heap_fd, ONE_MEG, 0, &dmabuf_fd);
>> -       if (ret) {
>> -               printf("FAIL (Older compat allocation failed!)\n");
>> -               ret = -1;
>> -               goto out;
>> -       }
>> -       close(dmabuf_fd);
>> -       printf("OK\n");
>> +       if (dmabuf_fd >= 0)
>> +               close(dmabuf_fd);
>> +       ksft_test_result(!ret, "dmabuf_heap_alloc_older\n");
>>
>> -       printf("  Testing (theoretical)newer alloc compat:  ");
>> +       ksft_print_msg("Testing (theoretical) newer alloc compat:\n");
>>         ret = dmabuf_heap_alloc_newer(heap_fd, ONE_MEG, 0, &dmabuf_fd);
>> -       if (ret) {
>> -               printf("FAIL (Newer compat allocation failed!)\n");
>> -               ret = -1;
>> -               goto out;
>> -       }
>> -       printf("OK\n");
>> -out:
>>         if (dmabuf_fd >= 0)
>>                 close(dmabuf_fd);
>> -       if (heap_fd >= 0)
>> -               close(heap_fd);
>> +       ksft_test_result(!ret, "dmabuf_heap_alloc_newer\n");
>>
>> -       return ret;
>> +       close(heap_fd);
>>  }
>>
>> -static int test_alloc_errors(char *heap_name)
>> +static void test_alloc_errors(char *heap_name)
>>  {
>>         int heap_fd = -1, dmabuf_fd = -1;
>>         int ret;
>>
>>         heap_fd = dmabuf_heap_open(heap_name);
>> -       if (heap_fd < 0)
>> -               return -1;
>>
>> -       printf("  Testing expected error cases:  ");
>> +       ksft_print_msg("Testing expected error cases:\n");
>>         ret = dmabuf_heap_alloc(0, ONE_MEG, 0x111111, &dmabuf_fd);
>> -       if (!ret) {
>> -               printf("FAIL (Did not see expected error (invalid fd)!)\n");
>> -               ret = -1;
>> -               goto out;
>> -       }
>> +       ksft_test_result(ret, "Error expected on invalid fd\n");
>>
>>         ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0x111111, &dmabuf_fd);
>> -       if (!ret) {
>> -               printf("FAIL (Did not see expected error (invalid heap flags)!)\n");
>> -               ret = -1;
>> -               goto out;
>> -       }
>> +       ksft_test_result(ret, "Error expected on invalid heap flags\n");
>>
>>         ret = dmabuf_heap_alloc_fdflags(heap_fd, ONE_MEG,
>>                                         ~(O_RDWR | O_CLOEXEC), 0, &dmabuf_fd);
>> -       if (!ret) {
>> -               printf("FAIL (Did not see expected error (invalid fd flags)!)\n");
>> -               ret = -1;
>> -               goto out;
>> -       }
>> +       ksft_test_result(ret, "Error expected on invalid heap flags\n");
>>
>> -       printf("OK\n");
>> -       ret = 0;
>> -out:
>>         if (dmabuf_fd >= 0)
>>                 close(dmabuf_fd);
>>         if (heap_fd >= 0)
>>                 close(heap_fd);
>> +}
>>
>> -       return ret;
>> +static int numer_of_heaps(void)
>> +{
>> +       DIR *d = opendir(DEVPATH);
>> +       struct dirent *dir;
>> +       int heaps = 0;
>> +
>> +       while ((dir = readdir(d))) {
>> +               if (!strncmp(dir->d_name, ".", 2))
>> +                       continue;
>> +               if (!strncmp(dir->d_name, "..", 3))
>> +                       continue;
>> +               heaps++;
>> +       }
>> +
>> +       return heaps;
>>  }
>>
>>  int main(void)
>>  {
>> -       DIR *d;
>>         struct dirent *dir;
>> -       int ret = -1;
>> +       DIR *d;
>> +
>> +       ksft_print_header();
>>
>>         d = opendir(DEVPATH);
>>         if (!d) {
>> -               printf("No %s directory?\n", DEVPATH);
>> -               return -1;
>> +               ksft_print_msg("No %s directory?\n", DEVPATH);
>> +               return KSFT_SKIP;
>>         }
>>
>> -       while ((dir = readdir(d)) != NULL) {
>> +       ksft_set_plan(9 * numer_of_heaps());
>> +
>> +       while ((dir = readdir(d))) {
>>                 if (!strncmp(dir->d_name, ".", 2))
>>                         continue;
>>                 if (!strncmp(dir->d_name, "..", 3))
>>                         continue;
>>
>> -               printf("Testing heap: %s\n", dir->d_name);
>> -               printf("=======================================\n");
>> -               ret = test_alloc_and_import(dir->d_name);
>> -               if (ret)
>> -                       break;
>> -
>> -               ret = test_alloc_zeroed(dir->d_name, 4 * 1024);
>> -               if (ret)
>> -                       break;
>> -
>> -               ret = test_alloc_zeroed(dir->d_name, ONE_MEG);
>> -               if (ret)
>> -                       break;
>> -
>> -               ret = test_alloc_compat(dir->d_name);
>> -               if (ret)
>> -                       break;
>> -
>> -               ret = test_alloc_errors(dir->d_name);
>> -               if (ret)
>> -                       break;
>> +               ksft_print_msg("Testing heap: %s\n", dir->d_name);
>> +               ksft_print_msg("=======================================\n");
>> +               test_alloc_and_import(dir->d_name);
>> +               test_alloc_zeroed(dir->d_name, 4 * 1024);
>> +               test_alloc_zeroed(dir->d_name, ONE_MEG);
>> +               test_alloc_compat(dir->d_name);
>> +               test_alloc_errors(dir->d_name);
>>         }
>>         closedir(d);
>>
>> -       return ret;
>> +       ksft_finished();
>>  }
>> --
>> 2.42.0
>>
>>
> 

-- 
BR,
Muhammad Usama Anjum

