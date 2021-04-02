Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB3A3530F4
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Apr 2021 00:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhDBWHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Apr 2021 18:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBWHJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Apr 2021 18:07:09 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83822C0613E6
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Apr 2021 15:07:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id j26so1388768iog.13
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Apr 2021 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ufc3tKYNwksLGFPH3EZGN2CwDcSPRBpZMnT9dNYYcpo=;
        b=FM2b8AV6U1pErPkd4u15lCvgQK3rcBNBpOBfoq/v+AZoCry3DZPZWEuv5TuiAw9jd4
         /2TiMpSdpznOqg5P3VIGIEfRCNqsJJX26lyZS35o2YtxR/l0Xor0E2flncZbz1zA+8wW
         /SYt8EtGGYchE6L7s6Yd6uobfLfnBhSatUwj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ufc3tKYNwksLGFPH3EZGN2CwDcSPRBpZMnT9dNYYcpo=;
        b=NTphTVf7hYHAUj8CUFdmgZJ61o7uFaG9J8/ezfIAYIFGR9NpWzi8+p8dsdjotuCRFg
         8dg94PzAZh94ymr5Mw2NGZjoJs5K/Uqxv9T3zqqIzWYkUT1hZT+0Q8+MkhWSp7jQcA0d
         66Kq5Xxcv27ybMxw5/6k49y4lyqVr0HHiiI0CIsPWneBAG0C8C1w/XZ3jYoUfXvOAtwN
         jjWibG6XNikoujWuOTxTHqzSDbqt6MEtvun2/xDm7WMExpXzd0X8IHoihcKlP5Ce9pBI
         xzeMxUAsFwB7dofPHJetQSXoJGrs6YYB4k1NrPoKhaRDqYp0LPDTLNLP3iAVmdSVz8bl
         PGCw==
X-Gm-Message-State: AOAM531S0m2BmicvcZx4fHPrhrP66Ijcd4TLZTjn1VMYjicRVxusroJ1
        Ai7uKrsv7Hpk9/oafX6fwdKIlw==
X-Google-Smtp-Source: ABdhPJzSgtp6bhNQ5pf/2JbV8yjDA4k0WO7Si2W/a68Dfe9AObIYkNpGYSoG/UdSUE4ZtlKgaCHrbQ==
X-Received: by 2002:a02:c6c4:: with SMTP id r4mr14205746jan.77.1617401225907;
        Fri, 02 Apr 2021 15:07:05 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g8sm4735642ile.44.2021.04.02.15.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 15:07:05 -0700 (PDT)
Subject: Re: [PATCH] selftests: get readahead size for check_file_mmap()
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        ricardo.canuelo@collabora.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210330124058.65277-1-jefflexu@linux.alibaba.com>
 <fbebc7d0-a095-26db-389a-098d4b76370f@linux.alibaba.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <086c240b-333d-122a-2084-ad8d390d810b@linuxfoundation.org>
Date:   Fri, 2 Apr 2021 16:07:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <fbebc7d0-a095-26db-389a-098d4b76370f@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/30/21 6:45 AM, JeffleXu wrote:
> 
> 
> On 3/30/21 8:40 PM, Jeffle Xu wrote:
>> The readahead size used to be 2MB, thus it's reasonable to set the file
>> size as 4MB when checking check_file_mmap().
>>
>> However since commit c2e4cd57cfa1 ("block: lift setting the readahead
>> size into the block layer"), readahead could be as large as twice the
>> io_opt, and thus the hardcoded file size no longer works.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Forgot to mention that otherwise, "Read-ahead pages reached the end of
> the file" is reported in check_file_mmap().
> 

Please update the change log and send v2 including the change history.

>> ---
>>   .../selftests/mincore/mincore_selftest.c      | 57 +++++++++++++++----
>>   1 file changed, 47 insertions(+), 10 deletions(-)
>>

Please include test name in the subject line

>> diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
>> index 5a1e85ff5d32..cf0c86697403 100644
>> --- a/tools/testing/selftests/mincore/mincore_selftest.c
>> +++ b/tools/testing/selftests/mincore/mincore_selftest.c
>> @@ -15,6 +15,11 @@
>>   #include <string.h>
>>   #include <fcntl.h>
>>   #include <string.h>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <sys/ioctl.h>
>> +#include <sys/sysmacros.h>
>> +#include <sys/mount.h>
>>   
>>   #include "../kselftest.h"
>>   #include "../kselftest_harness.h"
>> @@ -195,10 +200,42 @@ TEST(check_file_mmap)
>>   	int fd;
>>   	int i;
>>   	int ra_pages = 0;
>> +	long ra_size, filesize;
>> +	struct stat stats;
>> +	dev_t devt;
>> +	unsigned int major, minor;
>> +	char devpath[32];
>> +
>> +	retval = stat(".", &stats);
>> +	ASSERT_EQ(0, retval) {
>> +		TH_LOG("Can't stat pwd: %s", strerror(errno));
>> +	}
>> +
>> +	devt = stats.st_dev;
>> +	major = major(devt);
>> +	minor = minor(devt);
>> +	snprintf(devpath, sizeof(devpath), "/dev/block/%u:%u", major, minor);
>> +
>> +	fd = open(devpath, O_RDONLY);
>> +	ASSERT_NE(-1, fd) {
>> +		TH_LOG("Can't open underlying disk %s", strerror(errno));
>> +	}
>> +
>> +	retval = ioctl(fd, BLKRAGET, &ra_size);
>> +	ASSERT_EQ(0, retval) {
>> +		TH_LOG("Error ioctl with the underlying disk: %s", strerror(errno));
>> +	}
>> +
>> +	/*
>> +	 * BLKRAGET ioctl returns the readahead size in sectors (512 bytes).
>> +	 * Make filesize large enough to contain the readahead window.
>> +	 */
>> +	ra_size *= 512;
>> +	filesize = ra_size * 2;
>>   
>>   	page_size = sysconf(_SC_PAGESIZE);
>> -	vec_size = FILE_SIZE / page_size;
>> -	if (FILE_SIZE % page_size)
>> +	vec_size = filesize / page_size;
>> +	if (filesize % page_size)
>>   		vec_size++;
>>   
>>   	vec = calloc(vec_size, sizeof(unsigned char));
>> @@ -213,7 +250,7 @@ TEST(check_file_mmap)
>>   			strerror(errno));
>>   	}
>>   	errno = 0;
>> -	retval = fallocate(fd, 0, 0, FILE_SIZE);
>> +	retval = fallocate(fd, 0, 0, filesize);
>>   	ASSERT_EQ(0, retval) {
>>   		TH_LOG("Error allocating space for the temporary file: %s",
>>   			strerror(errno));
>> @@ -223,12 +260,12 @@ TEST(check_file_mmap)
>>   	 * Map the whole file, the pages shouldn't be fetched yet.
>>   	 */
>>   	errno = 0;
>> -	addr = mmap(NULL, FILE_SIZE, PROT_READ | PROT_WRITE,
>> +	addr = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
>>   			MAP_SHARED, fd, 0);
>>   	ASSERT_NE(MAP_FAILED, addr) {
>>   		TH_LOG("mmap error: %s", strerror(errno));
>>   	}
>> -	retval = mincore(addr, FILE_SIZE, vec);
>> +	retval = mincore(addr, filesize, vec);
>>   	ASSERT_EQ(0, retval);
>>   	for (i = 0; i < vec_size; i++) {
>>   		ASSERT_EQ(0, vec[i]) {
>> @@ -240,14 +277,14 @@ TEST(check_file_mmap)
>>   	 * Touch a page in the middle of the mapping. We expect the next
>>   	 * few pages (the readahead window) to be populated too.
>>   	 */
>> -	addr[FILE_SIZE / 2] = 1;
>> -	retval = mincore(addr, FILE_SIZE, vec);
>> +	addr[filesize / 2] = 1;
>> +	retval = mincore(addr, filesize, vec);
>>   	ASSERT_EQ(0, retval);
>> -	ASSERT_EQ(1, vec[FILE_SIZE / 2 / page_size]) {
>> +	ASSERT_EQ(1, vec[filesize / 2 / page_size]) {
>>   		TH_LOG("Page not found in memory after use");
>>   	}
>>   
>> -	i = FILE_SIZE / 2 / page_size + 1;
>> +	i = filesize / 2 / page_size + 1;
>>   	while (i < vec_size && vec[i]) {
>>   		ra_pages++;
>>   		i++;
>> @@ -271,7 +308,7 @@ TEST(check_file_mmap)
>>   		}
>>   	}
>>   
>> -	munmap(addr, FILE_SIZE);
>> +	munmap(addr, filesize);
>>   	close(fd);
>>   	free(vec);
>>   }
>>
> 

thanks,
-- Shuah
