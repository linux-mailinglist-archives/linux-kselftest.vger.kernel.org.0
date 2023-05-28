Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C9B713A2D
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjE1OtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 10:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1OtM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 10:49:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5589CB8;
        Sun, 28 May 2023 07:49:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6ef9a928fso13362955e9.3;
        Sun, 28 May 2023 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685285350; x=1687877350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=um+ZIBHmGp4TfeKSdvKKFeVwJH/FQpz6nR2TripbIu4=;
        b=D5u0j/Br8jCPvAxfu/sLuIXAcuRhj/uCA3k9rVd0RYZIRy/x1dHty3YE2f/nTbRrRV
         MjmhrsRk1YYobDp4HLx6lwgU3lqkQjbGKQDoqU7ILmr0gLU24ASXIIp2lbPQLX+dSPjL
         0OA9CPcoa6iXz4yl03is8180HZmsXs6EKpUqKheAdYTXiNwR8AB5i/wKuj+yVojC77pP
         iqXRXbgy6JT7opiy7ajsql9Gv2m9X4szxKwr1Ho8o2s6WpLxgqHpwT0xtUIxKQUjq30f
         uuJwVY65b0hJKtp8HltO3b63TkhjULnXRpO/853uoLHI55qix8Q/CoEefJsgBJhRGEbC
         DaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685285350; x=1687877350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um+ZIBHmGp4TfeKSdvKKFeVwJH/FQpz6nR2TripbIu4=;
        b=Z30EkU3s0zxuGYt4XQ5XyHsNp+msGwak1/3l/ySw7yp9uyzf4w+FTtiqVhymdj5AOh
         gIWPhGOfJZ8s/e4s8QIwJ6mGLe6rUXmMU0/yTFApOm488BCquE1rmSLdTGHJbr+DdX1B
         jKKEVnaCgSFWYpk5EiFNvIMxoQFZeeWZtI57crbv4cCmxj33lkhqUY6jgUUvW0zrGWU3
         iDsjFGAcjGUSA5/50Bra5xRb621r+J/kb6z5HH+06Id2UQB1fGVo+md9J/s3eIyygjVD
         g8YHUj4vN/+0fEolnMifCM3UNoBQz/DxjUydaTDQGVMlHfbH7D9ICUL2Oygo3qRmRnGO
         n/vQ==
X-Gm-Message-State: AC+VfDzLB4C4LBoXsydNyV3+MLYRMjKSQwRtiTkMNfSXdxwgOZf+84qJ
        NZUnr7ReaXqo2GV799FUmaE=
X-Google-Smtp-Source: ACHHUZ7WfC3v+TMmHOiDbzB0lFrMelBb8/1324DY7fdiS9NE2NUOX1hsuo0dCwr8CGwVy8/EOf3djg==
X-Received: by 2002:adf:ec44:0:b0:30a:bae6:fa98 with SMTP id w4-20020adfec44000000b0030abae6fa98mr7225561wrn.39.1685285349551;
        Sun, 28 May 2023 07:49:09 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe590000000b002fb60c7995esm10940691wrm.8.2023.05.28.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:49:08 -0700 (PDT)
Date:   Sun, 28 May 2023 15:49:07 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1 1/3] selftests/mm: factor out detection of hugetlb
 page sizes into vm_util
Message-ID: <e49b5642-014b-4a95-9ba8-738bfd02b2ea@lucifer.local>
References: <20230519102723.185721-1-david@redhat.com>
 <20230519102723.185721-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519102723.185721-2-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 19, 2023 at 12:27:21PM +0200, David Hildenbrand wrote:
> Let's factor detection out into vm_util, to be reused by a new test.
>

Bit of a nit as it's hardly vitally important, but perhaps worth mentioning
that you also refactor the function to accept any array (this is a
requirement rather than simply refactoring a thing but still :)

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/cow.c     | 29 ++--------------------------
>  tools/testing/selftests/mm/vm_util.c | 27 ++++++++++++++++++++++++++
>  tools/testing/selftests/mm/vm_util.h |  1 +
>  3 files changed, 30 insertions(+), 27 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index dc9d6fe86028..7f3b620d9cb7 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -14,7 +14,6 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <fcntl.h>
> -#include <dirent.h>
>  #include <assert.h>
>  #include <sys/mman.h>
>  #include <sys/ioctl.h>
> @@ -70,31 +69,6 @@ static void detect_huge_zeropage(void)
>  	close(fd);
>  }
>
> -static void detect_hugetlbsizes(void)
> -{
> -	DIR *dir = opendir("/sys/kernel/mm/hugepages/");
> -
> -	if (!dir)
> -		return;
> -
> -	while (nr_hugetlbsizes < ARRAY_SIZE(hugetlbsizes)) {
> -		struct dirent *entry = readdir(dir);
> -		size_t kb;
> -
> -		if (!entry)
> -			break;
> -		if (entry->d_type != DT_DIR)
> -			continue;
> -		if (sscanf(entry->d_name, "hugepages-%zukB", &kb) != 1)
> -			continue;
> -		hugetlbsizes[nr_hugetlbsizes] = kb * 1024;
> -		nr_hugetlbsizes++;
> -		ksft_print_msg("[INFO] detected hugetlb size: %zu KiB\n",
> -			       kb);
> -	}
> -	closedir(dir);
> -}
> -
>  static bool range_is_swapped(void *addr, size_t size)
>  {
>  	for (; size; addr += pagesize, size -= pagesize)
> @@ -1717,7 +1691,8 @@ int main(int argc, char **argv)
>  	if (thpsize)
>  		ksft_print_msg("[INFO] detected THP size: %zu KiB\n",
>  			       thpsize / 1024);
> -	detect_hugetlbsizes();
> +	nr_hugetlbsizes = detect_hugetlb_page_sizes(hugetlbsizes,
> +						    ARRAY_SIZE(hugetlbsizes));
>  	detect_huge_zeropage();
>
>  	ksft_print_header();
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 9b06a5034808..5cf84d860076 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <string.h>
>  #include <fcntl.h>
> +#include <dirent.h>
>  #include <sys/ioctl.h>
>  #include <linux/userfaultfd.h>
>  #include <sys/syscall.h>
> @@ -198,6 +199,32 @@ unsigned long default_huge_page_size(void)
>  	return hps;
>  }
>
> +int detect_hugetlb_page_sizes(size_t sizes[], int max)
> +{
> +	DIR *dir = opendir("/sys/kernel/mm/hugepages/");
> +	int count = 0;
> +
> +	if (!dir)
> +		return 0;
> +
> +	while (count < max) {
> +		struct dirent *entry = readdir(dir);
> +		size_t kb;
> +
> +		if (!entry)
> +			break;
> +		if (entry->d_type != DT_DIR)
> +			continue;
> +		if (sscanf(entry->d_name, "hugepages-%zukB", &kb) != 1)
> +			continue;
> +		sizes[count++] = kb * 1024;
> +		ksft_print_msg("[INFO] detected hugetlb page size: %zu KiB\n",
> +			       kb);
> +	}
> +	closedir(dir);
> +	return count;
> +}
> +
>  /* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
>  int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
>  			      bool miss, bool wp, bool minor, uint64_t *ioctls)
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index b950bd16083a..99b795528716 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -44,6 +44,7 @@ bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
>  bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
>  int64_t allocate_transhuge(void *ptr, int pagemap_fd);
>  unsigned long default_huge_page_size(void);
> +int detect_hugetlb_page_sizes(size_t sizes[], int max);
>
>  int uffd_register(int uffd, void *addr, uint64_t len,
>  		  bool miss, bool wp, bool minor);
> --
> 2.40.1
>

Looks good to me,

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
