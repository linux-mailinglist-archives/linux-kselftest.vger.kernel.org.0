Return-Path: <linux-kselftest+bounces-5478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB5868F71
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 12:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9952819DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 11:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BA913959F;
	Tue, 27 Feb 2024 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S5MM2CxO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999E8139599;
	Tue, 27 Feb 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034742; cv=none; b=ZPYaK8OI0fvrVHTIJmE4rN1wlYpNs6V569nI2KikIpi7oSZyTezLvItTTmZ2V933t4UIF2rf1ulWZYoPM2Wt9+KGPCpRPvWIOdvxSV8Y2Q0NL033RJefbEdKbFDA2NaLaCg56VhTpKKRED1qSKVIUZbx5dwxqA1ds2fPZu7WYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034742; c=relaxed/simple;
	bh=xw4zyQzl0Id0Z4DHabmeCkCQhjD5cr61ZeGQvk54bLA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tHjo3LVszqqFsi6C26vbpH9eZQWj/ho1KtCsbHvv9tRuEsNaeUpdN1VhpyLCo9ck9muHVOq8llR4yowmLxcFEDzSaJOmxZ4nhA0cyNFX2QZA5savIhS0JKzJ5njrGRvomkfjUfZwmM4b4I8ZMCmyu06T9FcEP3t/0GUYVxi0iis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S5MM2CxO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709034738;
	bh=xw4zyQzl0Id0Z4DHabmeCkCQhjD5cr61ZeGQvk54bLA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=S5MM2CxOPJlCO9VYWip/zkvw290O8fZYOtUAN3zytS8iuXi7zEkUCbwlrpZ0KXRtN
	 /mkrxA3ipEUu2+e5WpPnBbMYLwLmOKgDdAXJD3QyMjIXshmxIxyVtE4v2bpQiMv75E
	 kj3+N7fgCmvv9MLpZ+Trn8GloZ855D2Fj81n068/L+93DYP6ejSfuOPK7B4z2OqGwC
	 LI7xYViNITfpias8bLTOygjrvABY203QuPVsisgO/jbu3jCXWbSwZYjaLpLFPb34v/
	 LF4nP2nB8NI0v7vOcaAYAkWB1fOvXQrmTbluAhHLex2bqxv89e0h5+7x1WCPP1Md9q
	 K1gzSYaH39y6g==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A0DD037809D1;
	Tue, 27 Feb 2024 11:52:16 +0000 (UTC)
Message-ID: <8bd3174c-008b-48c3-9695-41ea07ea2f4b@collabora.com>
Date: Tue, 27 Feb 2024 16:52:38 +0500
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
Subject: Re: [PATCH 1/2] selftests/dmabuf-heap: conform test to TAP format
 output
Content-Language: en-US
To: "T.J. Mercier" <tjmercier@google.com>
References: <20240226080003.4094089-1-usama.anjum@collabora.com>
 <CABdmKX2YSrvHx3U-q1irvmEf=dDtqTtB38dERKx+4muu77zbfQ@mail.gmail.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABdmKX2YSrvHx3U-q1irvmEf=dDtqTtB38dERKx+4muu77zbfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/24 6:52 AM, T.J. Mercier wrote:
> On Sun, Feb 25, 2024 at 11:59 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 194 +++++++-----------
>>  1 file changed, 77 insertions(+), 117 deletions(-)
>>
>> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>> index 890a8236a8ba7..6e538e346cb8f 100644
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
>> @@ -166,7 +162,7 @@ static int test_alloc_and_import(char *heap_name)
>>                  dmabuf_fd,
>>                  0);
>>         if (p == MAP_FAILED) {
>> -               printf("FAIL (mmap() failed)\n");
>> +               ksft_print_msg("FAIL (mmap() failed)\n");
>>                 ret = -1;
>>                 goto out;
>>         }
> 
> I think you should just ksft_exit_fail_msg these too and get rid of
> out / not bother with manual cleanup if we're going to exit anyway.
Not sure how I missed this. I'll send a v2.


