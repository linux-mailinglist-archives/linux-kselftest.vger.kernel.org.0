Return-Path: <linux-kselftest+bounces-2960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EBD82D458
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 07:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2375E1F212BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 06:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522B23C9;
	Mon, 15 Jan 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="x4G0IDWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958123C0B;
	Mon, 15 Jan 2024 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705301966;
	bh=PUNiFql2LzYt4AfUj6+kFyjiKSLCP2jzF69eYRLV3m8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=x4G0IDWOY9mEwa96umEJ9cNBDjBE4yobVBcd4b24K9J2SDz+Xbq91JY3wHcD3J0XY
	 cxAEJCIb0PbJP2BRUiPQEJs4eIztkhtfEUAbFOT1ySKJTdmf186KS+TL6RT0TD3hDe
	 XitrekO2fzeO27o9ECzEkxPKXgENniSs/eO5lUGceSw8JL1xyulBqytWZoce0ZRJKh
	 eeZcMa8E9aCWCvLNd4dUETYLqhjVgSa6yQR6wAl541jhZIjTQf1aQLbgQfRdoWHl2S
	 RjwXQxpYLfShFF79t0I+JbDNYqByetDJwhxoxx6/5so3WJSn06WGK15wAwgz9S6NNC
	 EPOpkWzGzaqBw==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1CB6E3780C35;
	Mon, 15 Jan 2024 06:59:24 +0000 (UTC)
Message-ID: <dc244d6a-c9ac-4b21-90ca-ac54e6ebe39a@collabora.com>
Date: Mon, 15 Jan 2024 11:59:33 +0500
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
Subject: Re: [PATCH v2 5/7] selftests/mm: hugetlb-read-hwpoison: conform test
 to TAP format output
Content-Language: en-US
To: Jiaqi Yan <jiaqiyan@google.com>
References: <20240112072144.620098-1-usama.anjum@collabora.com>
 <20240112072144.620098-5-usama.anjum@collabora.com>
 <CACw3F51dwDhuaRxy+ud3CWfTt5ZcoS8=7jLU74KXJHJaCcc8Dw@mail.gmail.com>
 <0b5a7c8c-d46b-496c-b705-fafc54a91ff0@collabora.com>
 <CACw3F50OXfYYSGzbp3+eHjVxj=VU4sJiQO-=yrDTEUX=Map6gQ@mail.gmail.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CACw3F50OXfYYSGzbp3+eHjVxj=VU4sJiQO-=yrDTEUX=Map6gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/15/24 11:52 AM, Jiaqi Yan wrote:
> On Sun, Jan 14, 2024 at 10:32 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 1/13/24 6:08 AM, Jiaqi Yan wrote:
>>> On Thu, Jan 11, 2024 at 11:21 PM Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> Conform the layout, informational and status messages to TAP. No
>>>> functional change is intended other than the layout of output messages.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>> Tested this by reverting the patch a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
>>>> ("mm/filemap: remove hugetlb special casing in filemap.c") as it has
>>>> broken the test. The bug report can be found at [1].
>>>>
>>>> Tested with proposed fix as well [2].
>>>>
>>>> [1] https://lore.kernel.org/all/079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com
>>>> [2] https://lore.kernel.org/all/a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com
>>>> ---
>>>>  .../selftests/mm/hugetlb-read-hwpoison.c      | 116 +++++++++---------
>>>>  1 file changed, 56 insertions(+), 60 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>>>> index ba6cc6f9cabc..193ad7275df5 100644
>>>> --- a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>>>> +++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
>>>> @@ -58,8 +58,8 @@ static bool verify_chunk(char *buf, size_t len, char val)
>>>>
>>>>         for (i = 0; i < len; ++i) {
>>>>                 if (buf[i] != val) {
>>>> -                       printf(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
>>>> -                               i, buf[i], val);
>>>> +                       ksft_print_msg(PREFIX ERROR_PREFIX "check fail: buf[%lu] = %u != %u\n",
>>>> +                                      i, buf[i], val);
>>>>                         return false;
>>>>                 }
>>>>         }
>>>> @@ -75,9 +75,9 @@ static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
>>>>         ssize_t total_ret_count = 0;
>>>>         char val = offset / wr_chunk_size + offset % wr_chunk_size;
>>>>
>>>> -       printf(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
>>>> -       printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>>>> -              expected);
>>>> +       ksft_print_msg(PREFIX PREFIX "init val=%u with offset=0x%lx\n", val, offset);
>>>> +       ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>>>> +                      expected);
>>>>         if (lseek(fd, offset, SEEK_SET) < 0) {
>>>>                 perror(PREFIX ERROR_PREFIX "seek failed");
>>>>                 return false;
>>>> @@ -86,7 +86,7 @@ static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
>>>>         while (offset + total_ret_count < len) {
>>>>                 ret_count = read(fd, buf, wr_chunk_size);
>>>>                 if (ret_count == 0) {
>>>> -                       printf(PREFIX PREFIX "read reach end of the file\n");
>>>> +                       ksft_print_msg(PREFIX PREFIX "read reach end of the file\n");
>>>>                         break;
>>>>                 } else if (ret_count < 0) {
>>>>                         perror(PREFIX ERROR_PREFIX "read failed");
>>>> @@ -98,8 +98,8 @@ static bool seek_read_hugepage_filemap(int fd, size_t len, size_t wr_chunk_size,
>>>>
>>>>                 total_ret_count += ret_count;
>>>>         }
>>>> -       printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>>>> -              total_ret_count);
>>>> +       ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>>>> +                      total_ret_count);
>>>>
>>>>         return total_ret_count == expected;
>>>>  }
>>>> @@ -112,15 +112,15 @@ static bool read_hugepage_filemap(int fd, size_t len,
>>>>         ssize_t total_ret_count = 0;
>>>>         char val = 0;
>>>>
>>>> -       printf(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>>>> -              expected);
>>>> +       ksft_print_msg(PREFIX PREFIX "expect to read 0x%lx bytes of data in total\n",
>>>> +                      expected);
>>>>         while (total_ret_count < len) {
>>>>                 ret_count = read(fd, buf, wr_chunk_size);
>>>>                 if (ret_count == 0) {
>>>> -                       printf(PREFIX PREFIX "read reach end of the file\n");
>>>> +                       ksft_print_msg(PREFIX PREFIX "read reach end of the file\n");
>>>>                         break;
>>>>                 } else if (ret_count < 0) {
>>>> -                       perror(PREFIX ERROR_PREFIX "read failed");
>>>> +                       ksft_print_msg(PREFIX ERROR_PREFIX "read failed");
>>>
>>> Should we also include strerror(errno) in log msg, like you did below?
>> Looks like I missed it. I'll post a v3.
>>>
>>> Actually, would ksft_perror be a better choice for perror()s?
>> It may or may not be. There aren't ksft_*_perror macros for printing the
>> logs at this time. I prefer using just whatever macros are available. They
>> aren't generic enough. Maybe mm tests use perror whenever error occurs, but
>> other tests don't.
> 
> can't you use this ksft_perror available today?
> https://github.com/torvalds/linux/blob/master/tools/testing/selftests/kselftest.h#L161C25-L172
Sorry, I wan't able to find it. It has missing signature in header comment
as well. I'll just update this current test. I'll use ksft_perror in future
patches. Thanks for mentining it.

> 
>>
>>>
>>>>
>>>>                         break;
>>>>                 }
>>>>                 ++val;
>>>> @@ -129,8 +129,8 @@ static bool read_hugepage_filemap(int fd, size_t len,
>>>>
>>>>                 total_ret_count += ret_count;
>>>>         }
>>>> -       printf(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>>>> -              total_ret_count);
>>>> +       ksft_print_msg(PREFIX PREFIX "actually read 0x%lx bytes of data in total\n",
>>>> +                      total_ret_count);
>>>>
>>>>         return total_ret_count == expected;
>>>>  }
>>>> @@ -142,14 +142,15 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
>>>>         char *filemap = NULL;
>>>>
>>>>         if (ftruncate(fd, len) < 0) {
>>>> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
>>>> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate failed: %s\n", strerror(errno));
>>>>                 return status;
>>>>         }
>>>>
>>>>         filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
>>>>                        MAP_SHARED | MAP_POPULATE, fd, 0);
>>>>         if (filemap == MAP_FAILED) {
>>>> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
>>>> +               ksft_print_msg(PREFIX ERROR_PREFIX "mmap for primary mapping failed: %s\n",
>>>> +                              strerror(errno));
>>>>                 goto done;
>>>>         }
>>>>
>>>> @@ -162,7 +163,8 @@ test_hugetlb_read(int fd, size_t len, size_t wr_chunk_size)
>>>>         munmap(filemap, len);
>>>>  done:
>>>>         if (ftruncate(fd, 0) < 0) {
>>>> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
>>>> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate back to 0 failed : %s\n",
>>>> +                              strerror(errno));
>>>>                 status = TEST_FAILED;
>>>>         }
>>>>
>>>> @@ -179,14 +181,15 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
>>>>         const unsigned long pagesize = getpagesize();
>>>>
>>>>         if (ftruncate(fd, len) < 0) {
>>>> -               perror(PREFIX ERROR_PREFIX "ftruncate failed");
>>>> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate failed: %s\n", strerror(errno));
>>>>                 return status;
>>>>         }
>>>>
>>>>         filemap = mmap(NULL, len, PROT_READ | PROT_WRITE,
>>>>                        MAP_SHARED | MAP_POPULATE, fd, 0);
>>>>         if (filemap == MAP_FAILED) {
>>>> -               perror(PREFIX ERROR_PREFIX "mmap for primary mapping failed");
>>>> +               ksft_print_msg(PREFIX ERROR_PREFIX "mmap for primary mapping failed: %s\n",
>>>> +                              strerror(errno));
>>>>                 goto done;
>>>>         }
>>>>
>>>> @@ -201,7 +204,7 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
>>>>          */
>>>>         hwp_addr = filemap + len / 2 + pagesize;
>>>>         if (madvise(hwp_addr, pagesize, MADV_HWPOISON) < 0) {
>>>> -               perror(PREFIX ERROR_PREFIX "MADV_HWPOISON failed");
>>>> +               ksft_print_msg(PREFIX ERROR_PREFIX "MADV_HWPOISON failed: %s\n", strerror(errno));
>>>>                 goto unmap;
>>>>         }
>>>>
>>>> @@ -228,7 +231,8 @@ test_hugetlb_read_hwpoison(int fd, size_t len, size_t wr_chunk_size,
>>>>         munmap(filemap, len);
>>>>  done:
>>>>         if (ftruncate(fd, 0) < 0) {
>>>> -               perror(PREFIX ERROR_PREFIX "ftruncate back to 0 failed");
>>>> +               ksft_print_msg(PREFIX ERROR_PREFIX "ftruncate back to 0 failed: %s\n",
>>>> +                              strerror(errno));
>>>>                 status = TEST_FAILED;
>>>>         }
>>>>
>>>> @@ -240,27 +244,32 @@ static int create_hugetlbfs_file(struct statfs *file_stat)
>>>>         int fd;
>>>>
>>>>         fd = memfd_create("hugetlb_tmp", MFD_HUGETLB);
>>>> -       if (fd < 0) {
>>>> -               perror(PREFIX ERROR_PREFIX "could not open hugetlbfs file");
>>>> -               return -1;
>>>> -       }
>>>> +       if (fd < 0)
>>>> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "could not open hugetlbfs file: %s\n",
>>>> +                                  strerror(errno));
>>>>
>>>>         memset(file_stat, 0, sizeof(*file_stat));
>>>> +
>>>>         if (fstatfs(fd, file_stat)) {
>>>> -               perror(PREFIX ERROR_PREFIX "fstatfs failed");
>>>> -               goto close;
>>>> +               close(fd);
>>>> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "fstatfs failed: %s\n", strerror(errno));
>>>>         }
>>>>         if (file_stat->f_type != HUGETLBFS_MAGIC) {
>>>> -               printf(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
>>>> -               goto close;
>>>> +               close(fd);
>>>> +               ksft_exit_fail_msg(PREFIX ERROR_PREFIX "not hugetlbfs file\n");
>>>>         }
>>>>
>>>>         return fd;
>>>> -close:
>>>> -       close(fd);
>>>> -       return -1;
>>>>  }
>>>>
>>>> +#define KSFT_PRINT_MSG(status, fmt, ...)                                       \
>>>> +       do {                                                                    \
>>>> +               if (status == TEST_SKIPPED)                                     \
>>>> +                       ksft_test_result_skip(fmt, __VA_ARGS__);                \
>>>> +               else                                                            \
>>>> +                       ksft_test_result(status == TEST_PASSED, fmt, __VA_ARGS__); \
>>>> +       } while (0)
>>>> +
>>>>  int main(void)
>>>>  {
>>>>         int fd;
>>>> @@ -273,50 +282,37 @@ int main(void)
>>>>         };
>>>>         size_t i;
>>>>
>>>> +       ksft_print_header();
>>>> +       ksft_set_plan(12);
>>>> +
>>>>         for (i = 0; i < ARRAY_SIZE(wr_chunk_sizes); ++i) {
>>>> -               printf("Write/read chunk size=0x%lx\n",
>>>> -                      wr_chunk_sizes[i]);
>>>> +               ksft_print_msg("Write/read chunk size=0x%lx\n",
>>>> +                              wr_chunk_sizes[i]);
>>>>
>>>>                 fd = create_hugetlbfs_file(&file_stat);
>>>> -               if (fd < 0)
>>>> -                       goto create_failure;
>>>> -               printf(PREFIX "HugeTLB read regression test...\n");
>>>> +               ksft_print_msg(PREFIX "HugeTLB read regression test...\n");
>>>>                 status = test_hugetlb_read(fd, file_stat.f_bsize,
>>>>                                            wr_chunk_sizes[i]);
>>>> -               printf(PREFIX "HugeTLB read regression test...%s\n",
>>>> -                      status_to_str(status));
>>>> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB read regression test...%s\n",
>>>> +                              status_to_str(status));
>>>>                 close(fd);
>>>> -               if (status == TEST_FAILED)
>>>> -                       return -1;
>>>>
>>>>                 fd = create_hugetlbfs_file(&file_stat);
>>>> -               if (fd < 0)
>>>> -                       goto create_failure;
>>>> -               printf(PREFIX "HugeTLB read HWPOISON test...\n");
>>>> +               ksft_print_msg(PREFIX "HugeTLB read HWPOISON test...\n");
>>>>                 status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
>>>>                                                     wr_chunk_sizes[i], false);
>>>> -               printf(PREFIX "HugeTLB read HWPOISON test...%s\n",
>>>> -                      status_to_str(status));
>>>> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB read HWPOISON test..%s\n",
>>>> +                              status_to_str(status));
>>>>                 close(fd);
>>>> -               if (status == TEST_FAILED)
>>>> -                       return -1;
>>>>
>>>>                 fd = create_hugetlbfs_file(&file_stat);
>>>> -               if (fd < 0)
>>>> -                       goto create_failure;
>>>> -               printf(PREFIX "HugeTLB seek then read HWPOISON test...\n");
>>>> +               ksft_print_msg(PREFIX "HugeTLB seek then read HWPOISON test...\n");
>>>>                 status = test_hugetlb_read_hwpoison(fd, file_stat.f_bsize,
>>>>                                                     wr_chunk_sizes[i], true);
>>>> -               printf(PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
>>>> -                      status_to_str(status));
>>>> +               KSFT_PRINT_MSG(status, PREFIX "HugeTLB seek then read HWPOISON test...%s\n",
>>>> +                              status_to_str(status));
>>>>                 close(fd);
>>>> -               if (status == TEST_FAILED)
>>>> -                       return -1;
>>>>         }
>>>>
>>>> -       return 0;
>>>> -
>>>> -create_failure:
>>>> -       printf(ERROR_PREFIX "Abort test: failed to create hugetlbfs file\n");
>>>> -       return -1;
>>>> +       ksft_finished();
>>>>  }
>>>> --
>>>> 2.42.0
>>>>
>>>>
>>>
>>
>> --
>> BR,
>> Muhammad Usama Anjum
> 

-- 
BR,
Muhammad Usama Anjum

