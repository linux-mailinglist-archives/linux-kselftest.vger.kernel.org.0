Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0AF738F1B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 20:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjFUSsz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 14:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFUSsx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 14:48:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A6E9B;
        Wed, 21 Jun 2023 11:48:52 -0700 (PDT)
Date:   Wed, 21 Jun 2023 20:48:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1687373324; bh=K7GIk7uEvmoc9FWOicXHtA/QKVy8xu48Me8OQ6sPdtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sndpqHdOhqYDseVfPJKdVYV8EPQpnkKnbMjylWcvseJzuXOOeCFxH/HHGQZw1zETm
         t5T5zd11sqSxgxI9tDY8MkGBV6S9041mlWP3nmtZdLHrDQRruUxrGFgJMwPsgUOe/3
         88AcTxzv/nCpQ4WMnVN1lpQp94jcsQ87kc8E7U40=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, david.laight@aculab.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 07/10] tools/nolibc: clean up mmap() support
Message-ID: <31d85464-5731-4df6-8fcd-2b0be11eac90@t-8ch.de>
References: <cover.1687187451.git.falcon@tinylab.org>
 <b1162bc16ce5c397e99925e49317756c110e6f1a.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1162bc16ce5c397e99925e49317756c110e6f1a.1687187451.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-19 23:51:20+0800, Zhangjin Wu wrote:
> Do several cleanups together:
> 
> - Since all supported architectures have my_syscall6() now, remove the
>   #ifdef check.
> 
> - Move the mmap() related macros to tools/include/nolibc/types.h
> 
> - Apply the new __sysret() to convert the calling of sys_map() to
>   oneline code
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/sys.h   | 24 +-----------------------
>  tools/include/nolibc/types.h | 11 +++++++++++
>  2 files changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 8a6e16472d54..1c02cec3bcd9 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -624,26 +624,11 @@ int mknod(const char *path, mode_t mode, dev_t dev)
>  	return __sysret(sys_mknod(path, mode, dev));
>  }
>  
> -#ifndef MAP_SHARED
> -#define MAP_SHARED		0x01	/* Share changes */
> -#define MAP_PRIVATE		0x02	/* Changes are private */
> -#define MAP_SHARED_VALIDATE	0x03	/* share + validate extension flags */
> -#endif
> -
> -#ifndef MAP_FAILED
> -#define MAP_FAILED ((void *)-1)
> -#endif
> -
>  #ifndef sys_mmap
>  static __attribute__((unused))
>  void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
>  	       off_t offset)

This could return a plain integer type instead to save some casts.
Not sure if API compatibility is guaranteed for the raw sys_ functions.

>  {
> -#ifndef my_syscall6
> -	/* Function not implemented. */
> -	return (void *)-ENOSYS;
> -#else
> -
>  	int n;
>  
>  #if defined(__NR_mmap2)
> @@ -654,20 +639,13 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
>  #endif
>  
>  	return (void *)my_syscall6(n, addr, length, prot, flags, fd, offset);
> -#endif
>  }
>  #endif
>  
>  static __attribute__((unused))
>  void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
>  {
> -	void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
> -
> -	if ((unsigned long)ret >= -4095UL) {
> -		SET_ERRNO(-(long)ret);
> -		ret = MAP_FAILED;
> -	}
> -	return ret;
> +	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
>  }
>  
>  static __attribute__((unused))
> diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
> index f96e28bff4ba..f889d4e0ac7e 100644
> --- a/tools/include/nolibc/types.h
> +++ b/tools/include/nolibc/types.h
> @@ -81,6 +81,17 @@
>  #define MAXPATHLEN     (PATH_MAX)
>  #endif
>  
> +/* flags for mmap */
> +#ifndef MAP_SHARED
> +#define MAP_SHARED		0x01	/* Share changes */
> +#define MAP_PRIVATE		0x02	/* Changes are private */
> +#define MAP_SHARED_VALIDATE	0x03	/* share + validate extension flags */
> +#endif
> +
> +#ifndef MAP_FAILED
> +#define MAP_FAILED ((void *)-1)
> +#endif
> +
>  /* whence values for lseek() */
>  #define SEEK_SET       0
>  #define SEEK_CUR       1
> -- 
> 2.25.1
> 
