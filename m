Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B734E7B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhC3MpZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 08:45:25 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41863 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231803AbhC3MpO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 08:45:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UTrhepb_1617108311;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UTrhepb_1617108311)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 30 Mar 2021 20:45:11 +0800
Subject: Re: [PATCH] selftests: get readahead size for check_file_mmap()
To:     ricardo.canuelo@collabora.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
References: <20210330124058.65277-1-jefflexu@linux.alibaba.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <fbebc7d0-a095-26db-389a-098d4b76370f@linux.alibaba.com>
Date:   Tue, 30 Mar 2021 20:45:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330124058.65277-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/30/21 8:40 PM, Jeffle Xu wrote:
> The readahead size used to be 2MB, thus it's reasonable to set the file
> size as 4MB when checking check_file_mmap().
> 
> However since commit c2e4cd57cfa1 ("block: lift setting the readahead
> size into the block layer"), readahead could be as large as twice the
> io_opt, and thus the hardcoded file size no longer works.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Forgot to mention that otherwise, "Read-ahead pages reached the end of
the file" is reported in check_file_mmap().

> ---
>  .../selftests/mincore/mincore_selftest.c      | 57 +++++++++++++++----
>  1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
> index 5a1e85ff5d32..cf0c86697403 100644
> --- a/tools/testing/selftests/mincore/mincore_selftest.c
> +++ b/tools/testing/selftests/mincore/mincore_selftest.c
> @@ -15,6 +15,11 @@
>  #include <string.h>
>  #include <fcntl.h>
>  #include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/ioctl.h>
> +#include <sys/sysmacros.h>
> +#include <sys/mount.h>
>  
>  #include "../kselftest.h"
>  #include "../kselftest_harness.h"
> @@ -195,10 +200,42 @@ TEST(check_file_mmap)
>  	int fd;
>  	int i;
>  	int ra_pages = 0;
> +	long ra_size, filesize;
> +	struct stat stats;
> +	dev_t devt;
> +	unsigned int major, minor;
> +	char devpath[32];
> +
> +	retval = stat(".", &stats);
> +	ASSERT_EQ(0, retval) {
> +		TH_LOG("Can't stat pwd: %s", strerror(errno));
> +	}
> +
> +	devt = stats.st_dev;
> +	major = major(devt);
> +	minor = minor(devt);
> +	snprintf(devpath, sizeof(devpath), "/dev/block/%u:%u", major, minor);
> +
> +	fd = open(devpath, O_RDONLY);
> +	ASSERT_NE(-1, fd) {
> +		TH_LOG("Can't open underlying disk %s", strerror(errno));
> +	}
> +
> +	retval = ioctl(fd, BLKRAGET, &ra_size);
> +	ASSERT_EQ(0, retval) {
> +		TH_LOG("Error ioctl with the underlying disk: %s", strerror(errno));
> +	}
> +
> +	/*
> +	 * BLKRAGET ioctl returns the readahead size in sectors (512 bytes).
> +	 * Make filesize large enough to contain the readahead window.
> +	 */
> +	ra_size *= 512;
> +	filesize = ra_size * 2;
>  
>  	page_size = sysconf(_SC_PAGESIZE);
> -	vec_size = FILE_SIZE / page_size;
> -	if (FILE_SIZE % page_size)
> +	vec_size = filesize / page_size;
> +	if (filesize % page_size)
>  		vec_size++;
>  
>  	vec = calloc(vec_size, sizeof(unsigned char));
> @@ -213,7 +250,7 @@ TEST(check_file_mmap)
>  			strerror(errno));
>  	}
>  	errno = 0;
> -	retval = fallocate(fd, 0, 0, FILE_SIZE);
> +	retval = fallocate(fd, 0, 0, filesize);
>  	ASSERT_EQ(0, retval) {
>  		TH_LOG("Error allocating space for the temporary file: %s",
>  			strerror(errno));
> @@ -223,12 +260,12 @@ TEST(check_file_mmap)
>  	 * Map the whole file, the pages shouldn't be fetched yet.
>  	 */
>  	errno = 0;
> -	addr = mmap(NULL, FILE_SIZE, PROT_READ | PROT_WRITE,
> +	addr = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
>  			MAP_SHARED, fd, 0);
>  	ASSERT_NE(MAP_FAILED, addr) {
>  		TH_LOG("mmap error: %s", strerror(errno));
>  	}
> -	retval = mincore(addr, FILE_SIZE, vec);
> +	retval = mincore(addr, filesize, vec);
>  	ASSERT_EQ(0, retval);
>  	for (i = 0; i < vec_size; i++) {
>  		ASSERT_EQ(0, vec[i]) {
> @@ -240,14 +277,14 @@ TEST(check_file_mmap)
>  	 * Touch a page in the middle of the mapping. We expect the next
>  	 * few pages (the readahead window) to be populated too.
>  	 */
> -	addr[FILE_SIZE / 2] = 1;
> -	retval = mincore(addr, FILE_SIZE, vec);
> +	addr[filesize / 2] = 1;
> +	retval = mincore(addr, filesize, vec);
>  	ASSERT_EQ(0, retval);
> -	ASSERT_EQ(1, vec[FILE_SIZE / 2 / page_size]) {
> +	ASSERT_EQ(1, vec[filesize / 2 / page_size]) {
>  		TH_LOG("Page not found in memory after use");
>  	}
>  
> -	i = FILE_SIZE / 2 / page_size + 1;
> +	i = filesize / 2 / page_size + 1;
>  	while (i < vec_size && vec[i]) {
>  		ra_pages++;
>  		i++;
> @@ -271,7 +308,7 @@ TEST(check_file_mmap)
>  		}
>  	}
>  
> -	munmap(addr, FILE_SIZE);
> +	munmap(addr, filesize);
>  	close(fd);
>  	free(vec);
>  }
> 

-- 
Thanks,
Jeffle
