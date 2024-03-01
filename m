Return-Path: <linux-kselftest+bounces-5698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCB786DD13
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 09:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880A21F21068
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838069D1F;
	Fri,  1 Mar 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o7s/s8wz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288B69D05;
	Fri,  1 Mar 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281704; cv=none; b=hnPCfLzf3t6y8ImUSdOwwGMPV54XtCmqMemx2BlH593JjLKlqjyZqtSHmAGvRqC3m+X5+gXgEzVxikropyKhCSR5ztrhbBYwF4bdMdTeT09eMAfZJlm3JUYfjVZxXsxYDG0VWpijE7w3dHddvPXbTNtWtYinDnRQrpqGgxRooCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281704; c=relaxed/simple;
	bh=fiWIkiqbMeG7PXBNe97FVs8k3T958G5hfM2DjwTaQMg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LvgTDcfhkmVauTtFJSDiFZ1KDQiGrc/MGw10QBM++NEQT7bHM004CsI3d0P2dASiFG+yRr5ycVYtKjNDHVQeoeRcmNPQltcypt8UtP5q45CcMimAVk0CbvqSZ4YLUyyhZ1PSwCijWYRWidAFqYyzzQhMbZ/Ixco+bGithZiuPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o7s/s8wz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709281700;
	bh=fiWIkiqbMeG7PXBNe97FVs8k3T958G5hfM2DjwTaQMg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=o7s/s8wzjpj481yJog1yc5fVp3kWqKefO0zd+FGLkzGGTdiFG43H6xomxNqLE8OW9
	 ydood/LBOvpb0kLpsgfpcGmr4EpYQyrU8opLFhAzDB8O/jHeu+rVXIsCBZ+QOM9hl7
	 pjhZziCJaocgdij6ju/iqCa3orLLPaimsF4m72dzbIApCsGNIufr+9GYii1yj29Ble
	 OGT7RitcIBAvotPinuXAXcjCu87Zobmha31PqiQIL/YM5A9Lx3UADOp2Yv4IemkBrV
	 X+OlEMovH1rxRx8fX1aUymynikOleXOgf9D8M/aI5KFsm06MdSAY/fMac4JUU5SQ2g
	 7V3HlTCmFcVrw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C4A1B37814A4;
	Fri,  1 Mar 2024 08:28:15 +0000 (UTC)
Message-ID: <3efa609f-0915-4958-85c7-f6c97a35d9e1@collabora.com>
Date: Fri, 1 Mar 2024 13:28:37 +0500
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
Subject: Re: [PATCH v3 1/2] selftests/dmabuf-heap: conform test to TAP format
 output
To: "T.J. Mercier" <tjmercier@google.com>
References: <20240229092035.1325113-1-usama.anjum@collabora.com>
 <CABdmKX2r=9+dK71qrp4iU8Dkmt=CF1oWWZFmi9Ny+0iphBoynw@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABdmKX2r=9+dK71qrp4iU8Dkmt=CF1oWWZFmi9Ny+0iphBoynw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/29/24 10:37 PM, T.J. Mercier wrote:
> On Thu, Feb 29, 2024 at 1:21 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v2:
>> - Minor improvements in test_alloc_zeroed() results
>>
>> Changes since v1:
>> - Update some more error handling code
>> ---
>>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 234 +++++++-----------
>>  1 file changed, 88 insertions(+), 146 deletions(-)
>>
>> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>> index 890a8236a8ba7..bdc157ba542fd 100644
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
>> @@ -179,70 +172,58 @@ static int test_alloc_and_import(char *heap_name)
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
>> -       if (p)
>> -               munmap(p, ONE_MEG);
>> -       if (importer_fd >= 0)
>> -               close(importer_fd);
>> -       if (dmabuf_fd >= 0)
>> -               close(dmabuf_fd);
>> -       if (heap_fd >= 0)
>> -               close(heap_fd);
>> +       munmap(p, ONE_MEG);
>> +       close(importer_fd);
>> +       close(dmabuf_fd);
>> +       close(heap_fd);
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
>> +
>>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
>>                 memset(p, 0xff, size);
>>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
>> @@ -251,48 +232,38 @@ static int test_alloc_zeroed(char *heap_name, size_t size)
>>         /* close them all */
>>         for (i = 0; i < 32; i++)
>>                 close(dmabuf_fd[i]);
>> +       ksft_test_result_pass("Allocate and fill a bunch of buffers\n");
>>
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
>>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
>>                 munmap(p, size);
>>         }
>> +
>> +       ksft_test_result(i == 32, "Allocate and validate all buffers are zeroed\n");
> 
> This part is still incorrect since we will always get i == 32 as long
> as the buffer can be allocated and mapped, regardless of the content
> of the buffer which this test is supposed to be checking.
I thought break would break the loop. But there are two loops here. I'll
fix it with goto instead.

> 

-- 
BR,
Muhammad Usama Anjum

