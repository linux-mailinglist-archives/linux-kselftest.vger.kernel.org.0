Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60853723AD1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjFFIAf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjFFIAN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:00:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3929B2D4E;
        Tue,  6 Jun 2023 00:57:42 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ED6636600359;
        Tue,  6 Jun 2023 08:56:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686038213;
        bh=IwGH7O6yfy2pLElm5a7Z4qnsrbwSCuHpRSxYI2fRk0c=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=h7mZ87VWxltGhn4xDgLOGheOC2AlbsLZa9LzJrZ90HEK5lTkylQDoR1X+bPH2ZpDB
         E2uSYT5gXfLbzvNuwTG6hd2mg9DUll9UShRrUKkRu5MvDnfeEycK2WYTOq3BIzfQvz
         lX/eZhjfi7/cqqtwhh7mUiumavsuqdT86T7MfW4qGcuhv8MEL5Xv/AQGok0HpK54Kc
         HYN91AHAmhkAj2tDAAWAIfVpp5RZjqL4012JPJPwRqCSpXKoouvb4rkyEPqbHkvaBa
         9+mI1tYsh3N0+FIazeXt2r0HYm8WfPGIQk/pwl5Gt8UWFwyAKyDyvBxlOnsCIkE32M
         IsHrBS1CNsBxQ==
Message-ID: <41fa2d6e-9655-32c6-fb48-d7a1495c8bd4@collabora.com>
Date:   Tue, 6 Jun 2023 12:56:47 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] selftests/mm: move certain uffd*() routines from
 vm_util.c to uffd-common.c
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-10-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-10-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/6/23 12:16 PM, John Hubbard wrote:
> There are only three uffd*() routines that are used outside of the uffd
> selftests. Leave these in vm_util.c, where they are available to any mm
> selftest program:
> 
>     uffd_register()
>     uffd_unregister()
>     uffd_register_with_ioctls().
> 
> A few other uffd*() routines, however, are only used by the uffd-focused
> tests found in uffd-stress.c and uffd-unit-tests.c. Move those routines
> into uffd-common.c.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/uffd-common.c | 59 ++++++++++++++++++++++++
>  tools/testing/selftests/mm/uffd-common.h |  5 ++
>  tools/testing/selftests/mm/vm_util.c     | 59 ------------------------
>  tools/testing/selftests/mm/vm_util.h     |  4 --
>  4 files changed, 64 insertions(+), 63 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 61c6250adf93..ba20d7504022 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -616,3 +616,62 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>  {
>  	return __copy_page(ufd, offset, false, wp);
>  }
> +
> +int uffd_open_dev(unsigned int flags)
> +{
> +	int fd, uffd;
> +
> +	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> +	if (fd < 0)
> +		return fd;
> +	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
> +	close(fd);
> +
> +	return uffd;
> +}
> +
> +int uffd_open_sys(unsigned int flags)
> +{
> +#ifdef __NR_userfaultfd
> +	return syscall(__NR_userfaultfd, flags);
> +#else
> +	return -1;
> +#endif
> +}
> +
> +int uffd_open(unsigned int flags)
> +{
> +	int uffd = uffd_open_sys(flags);
> +
> +	if (uffd < 0)
> +		uffd = uffd_open_dev(flags);
> +
> +	return uffd;
> +}
> +
> +int uffd_get_features(uint64_t *features)
> +{
> +	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
> +	/*
> +	 * This should by default work in most kernels; the feature list
> +	 * will be the same no matter what we pass in here.
> +	 */
> +	int fd = uffd_open(UFFD_USER_MODE_ONLY);
> +
> +	if (fd < 0)
> +		/* Maybe the kernel is older than user-only mode? */
> +		fd = uffd_open(0);
> +
> +	if (fd < 0)
> +		return fd;
> +
> +	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
> +		close(fd);
> +		return -errno;
> +	}
> +
> +	*features = uffdio_api.features;
> +	close(fd);
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
> index 6068f2346b86..197f5262fe0d 100644
> --- a/tools/testing/selftests/mm/uffd-common.h
> +++ b/tools/testing/selftests/mm/uffd-common.h
> @@ -110,6 +110,11 @@ int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
>  int copy_page(int ufd, unsigned long offset, bool wp);
>  void *uffd_poll_thread(void *arg);
>  
> +int uffd_open_dev(unsigned int flags);
> +int uffd_open_sys(unsigned int flags);
> +int uffd_open(unsigned int flags);
> +int uffd_get_features(uint64_t *features);
> +
>  #define TEST_ANON	1
>  #define TEST_HUGETLB	2
>  #define TEST_SHMEM	3
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 9b06a5034808..681277615839 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -242,62 +242,3 @@ int uffd_unregister(int uffd, void *addr, uint64_t len)
>  
>  	return ret;
>  }
> -
> -int uffd_open_dev(unsigned int flags)
> -{
> -	int fd, uffd;
> -
> -	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
> -	if (fd < 0)
> -		return fd;
> -	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
> -	close(fd);
> -
> -	return uffd;
> -}
> -
> -int uffd_open_sys(unsigned int flags)
> -{
> -#ifdef __NR_userfaultfd
> -	return syscall(__NR_userfaultfd, flags);
> -#else
> -	return -1;
> -#endif
> -}
> -
> -int uffd_open(unsigned int flags)
> -{
> -	int uffd = uffd_open_sys(flags);
> -
> -	if (uffd < 0)
> -		uffd = uffd_open_dev(flags);
> -
> -	return uffd;
> -}
> -
> -int uffd_get_features(uint64_t *features)
> -{
> -	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
> -	/*
> -	 * This should by default work in most kernels; the feature list
> -	 * will be the same no matter what we pass in here.
> -	 */
> -	int fd = uffd_open(UFFD_USER_MODE_ONLY);
> -
> -	if (fd < 0)
> -		/* Maybe the kernel is older than user-only mode? */
> -		fd = uffd_open(0);
> -
> -	if (fd < 0)
> -		return fd;
> -
> -	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
> -		close(fd);
> -		return -errno;
> -	}
> -
> -	*features = uffdio_api.features;
> -	close(fd);
> -
> -	return 0;
> -}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 07f39ed2efba..c2d4ff798b91 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -48,10 +48,6 @@ unsigned long default_huge_page_size(void);
>  int uffd_register(int uffd, void *addr, uint64_t len,
>  		  bool miss, bool wp, bool minor);
>  int uffd_unregister(int uffd, void *addr, uint64_t len);
> -int uffd_open_dev(unsigned int flags);
> -int uffd_open_sys(unsigned int flags);
> -int uffd_open(unsigned int flags);
> -int uffd_get_features(uint64_t *features);
>  int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
>  			      bool miss, bool wp, bool minor, uint64_t *ioctls);
>  

-- 
BR,
Muhammad Usama Anjum
