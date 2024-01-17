Return-Path: <linux-kselftest+bounces-3133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5882FFDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 06:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECC32891CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 05:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411D6AB8;
	Wed, 17 Jan 2024 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AmFv18Le"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAC8F59;
	Wed, 17 Jan 2024 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469686; cv=none; b=WWmqo1HTcuoLLF9fIVGw/oFvNcdHmQ/iybu6cKlzCZgYAlBIG3vb2SdMqAiebBP6DZkFMsvjI842SAYEc3ocHHdAel1YoXfNG+sf3Tjp0ALSHF/6XHWdjGDWtQKXitPOY8VvrMXKLPxW74Z+JAjzb6owU+h/M4K45Nwzt1Xg9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469686; c=relaxed/simple;
	bh=x592FMBNjaV6lXHxwk11ZaeUHrXFxX3mbetxxxrwMOE=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:Content-Language:To:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=kKjCASB9rnDcw4WpV99I0quHwkhpMzjJhUB95yw9TqiF9kplV+t0N2eocVcjXO+QwmPo/sPai+I2+XeEHPLTljoE6YSxfJJ+4ZTSeAVkZl6tetZI6MYqdaM6teecH9DZP9/VsF9vO8q+SQ+ukqXuevd5/dzbQS1QeQGZxjuV7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AmFv18Le; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705469683;
	bh=x592FMBNjaV6lXHxwk11ZaeUHrXFxX3mbetxxxrwMOE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AmFv18Le8nAhy0LOS+nASRMi56aWaAjzEO4NFw0+A96SWbY+cZGe0cXPYFJf7RFuy
	 S9Pt84Dr61bIVuN/OdikZNVJkEFTSs2FFTvW4u/Qdu+1wnKdkGf5/724N9S0wH6rZt
	 SD99nZb1rcVV/+fpygC8fsc9n6aB9iHrImJDI0rstoei8M92TURLDSFhu6dJCVaTwn
	 n9/hGNqFdVdxqd/95Q7RuX+CLU0sYkOyFnk4b7GiKqYv8rWzgxFZ2chwvrBsLsu+GK
	 rIfFW5cMOB0J5Xr04rPahD96FvDLS9emDRLyYdlthiqtHk08UYW149Z/m9vaXDK+79
	 EMLOoiLJiBZqw==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 61013378000A;
	Wed, 17 Jan 2024 05:34:40 +0000 (UTC)
Message-ID: <d9c99910-364c-4b18-9f26-169c719de29b@collabora.com>
Date: Wed, 17 Jan 2024 10:34:49 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] selftests/mm: hugetlb-read-hwpoison: conform test
 to TAP format output
Content-Language: en-US
To: Jiaqi Yan <jiaqiyan@google.com>
References: <20240115073247.1280266-1-usama.anjum@collabora.com>
 <20240115073247.1280266-5-usama.anjum@collabora.com>
 <CACw3F531DPDtQe5PJmH091n9RhK57FhUYR1L45FdjrYBMSUOtQ@mail.gmail.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CACw3F531DPDtQe5PJmH091n9RhK57FhUYR1L45FdjrYBMSUOtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/16/24 10:07 PM, Jiaqi Yan wrote:
> On Sun, Jan 14, 2024 at 11:33 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Conform the layout, informational and status messages to TAP. No
>> functional change is intended other than the layout of output messages.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in v3:
>> - Use ksft_perror as short hand instead of missing strerror(errno) at
>>   one place
> 
> Minor thing: I think we should preserve previous changelogs, right?
Definately. There was no changes in v2 for this patch. Hence there isn't
any changelog before this series.

> 
>>
>> Tested this by reverting the patch a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
>> ("mm/filemap: remove hugetlb special casing in filemap.c") as it has
>> broken the test. The bug report can be found at [1].
>>
>> Tested with proposed fix as well [2].
>>
>> [1] https://lore.kernel.org/all/079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com
>> [2] https://lore.kernel.org/all/a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com
>> ---
>>  .../selftests/mm/hugetlb-read-hwpoison.c      | 116 ++++++++----------
>>  1 file changed, 54 insertions(+), 62 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>> index ba6cc6f9cabc..23b41b88c6af 100644
>> --- a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>> +++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>> @@ -58,8 +58,8 @@ static bool verify_chunk(char *buf, size_t len, char val)
>>
>>         for (i = 0; i < len; ++i) {
>>                 if (buf[i] != val) {
>> -                       printf(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
>> -                               i, buf[i], val);
>> +                       ksft_print_msg(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
>> +                                      i, buf[i], val);
>>                         return false;
>>                 }
>>         }
>> @@ -75,21 +75,21 @@ static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
>>         ssize_t total_ret_count = 0;
>>         char val = offset / wr_chunk_size + offset % wr_chunk_size;
>>
>> -       printf(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
>> -       printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>> -              expected);
>> +       ksft_print_msg(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
>> +       ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>> +                      expected);
>>         if (lseek(fd, offset, SEEK_SET) < 0) {
>> -               perror(PREFIX ERROR_PREFIX "seek failed");
>> +               ksft_perror(PREFIX ERROR_PREFIX "seek failed");
>>                 return false;
>>         }
>>
>>         while (offset + total_ret_count < len) {
>>                 ret_count = read(fd, buf, wr_chunk_size);
>>                 if (ret_count == 0) {
>> -                       printf(PREFIX PREFIX "read reach end of the file\n");
>> +                       ksft_print_msg(PREFIX PREFIX "read reach end of the file\n");
>>                         break;
>>                 } else if (ret_count < 0) {
>> -                       perror(PREFIX ERROR_PREFIX "read failed");
>> +                       ksft_perror(PREFIX ERROR_PREFIX "read failed");
>>                         break;
>>                 }
>>                 ++val;
>> @@ -98,8 +98,8 @@ static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
>>
>>                 total_ret_count += ret_count;
>>         }
>> -       printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>> -              total_ret_count);
>> +       ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>> +                      total_ret_count);
>>
>>         return total_ret_count == expected;
>>  }
>> @@ -112,15 +112,15 @@ static bool read_hugepage_filemap(int fd, size_t len,
>>         ssize_t total_ret_count = 0;
>>         char val = 0;
>>
>> -       printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>> -              expected);
>> +       ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>> +                      expected);
>>         while (total_ret_count < len) {
>>                 ret_count = read(fd, buf, wr_chunk_size);
>>                 if (ret_count == 0) {
>> -                       printf(PREFIX PREFIX "read reach end of the file\n");
>> +                       ksft_print_msg(PREFIX PREFIX "read reach end of the file\n");
>>                         break;
>>                 } else if (ret_count < 0) {
>> -                       perror(PREFIX ERROR_PREFIX "read failed");
>> +                       ksft_perror(PREFIX ERROR_PREFIX "read failed");
>>                         break;
>>                 }
>>                 ++val;
>> @@ -129,8 +129,8 @@ static bool read_hugepage_filemap(int fd, size_t len,
>>
>>                 total_ret_count += ret_count;
>>         }
>> -       printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>> -              total_ret_count);
>> +       ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>> +                      total_ret_count);
>>
>>         return total_ret_count == expected;
>>  }
>> @@ -142,14 +142,14 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
>>         char *filemap = NULL;
>>
>>         if (ftruncate(fd, len) < 0) {
>> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
>> +               ksft_perror(PREFIX ERROR_PREFIX "ftruncate failed");
>>                 return status;
>>         }
>>
>>         filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
>>                        MAP_SHARED | MAP_POPULATE, fd, 0);
>>         if (filemap == MAP_FAILED) {
>> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
>> +               ksft_perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
>>                 goto done;
>>         }
>>
>> @@ -162,7 +162,7 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
>>         munmap(filemap, len);
>>  done:
>>         if (ftruncate(fd, 0) < 0) {
>> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
>> +               ksft_perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
>>                 status = TEST_FAILED;
>>         }
>>
>> @@ -179,14 +179,14 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
>>         const unsigned long pagesize = getpagesize();
>>
>>         if (ftruncate(fd, len) < 0) {
>> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
>> +               ksft_perror(PREFIX ERROR_PREFIX "ftruncate failed");
>>                 return status;
>>         }
>>
>>         filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
>>                        MAP_SHARED | MAP_POPULATE, fd, 0);
>>         if (filemap == MAP_FAILED) {
>> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
>> +               ksft_perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
>>                 goto done;
>>         }
>>
>> @@ -201,7 +201,7 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
>>          */
>>         hwp_addr = filemap + len / 2 + pagesize;
>>         if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
>> -               perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
>> +               ksft_perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
>>                 goto unmap;
>>         }
>>
>> @@ -228,7 +228,7 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
>>         munmap(filemap, len);
>>  done:
>>         if (ftruncate(fd, 0) < 0) {
>> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
>> +               ksft_perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
>>                 status = TEST_FAILED;
>>         }
>>
>> @@ -240,27 +240,32 @@ static int create_hugetlbfs_file(struct statfs *file_stat)
>>         int fd;
>>
>>         fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
>> -       if (fd < 0) {
>> -               perror(PREFIX ERROR_PREFIX "could not open hugetlbfs file");
>> -               return -1;
>> -       }
>> +       if (fd < 0)
>> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "could not open hugetlbfs file: %s\n",
>> +                                  strerror(errno));
>>
>>         memset(file_stat, 0, sizeof(*file_stat));
>> +
>>         if (fstatfs(fd, file_stat)) {
>> -               perror(PREFIX ERROR_PREFIX "fstatfs failed");
>> -               goto close;
>> +               close(fd);
>> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "fstatfs failed: %s\n", strerror(errno));
>>         }
>>         if (file_stat->f_type != HUGETLBFS_MAGIC) {
>> -               printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
>> -               goto close;
>> +               close(fd);
>> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
>>         }
>>
>>         return fd;
>> -close:
>> -       close(fd);
>> -       return -1;
>>  }
>>
>> +#define KSFT_PRINT_MSG(status, fmt, ...)                                       \
>> +       do {                                                                    \
>> +               if (status == TEST_SKIPPED)                                     \
>> +                       ksft_test_result_skip(fmt, __VA_ARGS__);                \
>> +               else                                                            \
>> +                       ksft_test_result(status == TEST_PASSED, fmt, __VA_ARGS__); \
>> +       } while (0)
>> +
>>  int main(void)
>>  {
>>         int fd;
>> @@ -273,50 +278,37 @@ int main(void)
>>         };
>>         size_t i;
>>
>> +       ksft_print_header();
>> +       ksft_set_plan(12);
> 
> Minor: can this number be calculated, or at least defined as a macro
> with documents? That would make it easier for reading.
The number can be calculated to some extent via macro. As all the tests
don't define a macro for this, I'll prepare one patch for all the tests
later on.

> 
>> +
>>         for (i = 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
>> -               printf("Write/read chunk size=0x%lx\n",
>> -                      wr_chunk_sizes[i]);
>> +               ksft_print_msg("Write/read chunk size=0x%lx\n",
>> +                              wr_chunk_sizes[i]);
>>
>>                 fd = create_hugetlbfs_file(&file_stat);
>> -               if (fd < 0)
>> -                       goto create_failure;
>> -               printf(PREFIX "HugeTLB read regression test...\n");
>> +               ksft_print_msg(PREFIX "HugeTLB read regression test...\n");
>>                 status = test_hugetlb_read(fd, file_stat.f_bsize,
>>                                            wr_chunk_sizes[i]);
>> -               printf(PREFIX "HugeTLB read regression test...%s\n",
>> -                      status_to_str(status));
>> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB read regression test...%s\n",
>> +                              status_to_str(status));
>>                 close(fd);
>> -               if (status == TEST_FAILED)
>> -                       return -1;
>>
>>                 fd = create_hugetlbfs_file(&file_stat);
>> -               if (fd < 0)
>> -                       goto create_failure;
>> -               printf(PREFIX "HugeTLB read HWPOISON test...\n");
>> +               ksft_print_msg(PREFIX "HugeTLB read HWPOISON test...\n");
>>                 status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
>>                                                     wr_chunk_sizes[i], false);
>> -               printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
>> -                      status_to_str(status));
>> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB read HWPOISON test..%s\n",
>> +                              status_to_str(status));
>>                 close(fd);
>> -               if (status == TEST_FAILED)
>> -                       return -1;
>>
>>                 fd = create_hugetlbfs_file(&file_stat);
>> -               if (fd < 0)
>> -                       goto create_failure;
>> -               printf(PREFIX "HugeTLB seek then read HWPOISON test...\n");
>> +               ksft_print_msg(PREFIX "HugeTLB seek then read HWPOISON test...\n");
>>                 status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
>>                                                     wr_chunk_sizes[i], true);
>> -               printf(PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
>> -                      status_to_str(status));
>> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
>> +                              status_to_str(status));
>>                 close(fd);
>> -               if (status == TEST_FAILED)
>> -                       return -1;
>>         }
>>
>> -       return 0;
>> -
>> -create_failure:
>> -       printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs file\n");
>> -       return -1;
>> +       ksft_finished();
>>  }
>> --
>> 2.42.0
>>
>>
> 
> This version looks good to me. Maybe someone else need to take another
> look, just add mine:
> 
> Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>
Thanks

> 

-- 
BR,
Muhammad Usama Anjum

