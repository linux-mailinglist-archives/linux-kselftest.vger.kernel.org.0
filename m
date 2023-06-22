Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1A273A8CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFVTJF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVTJE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 15:09:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A848FA2;
        Thu, 22 Jun 2023 12:09:01 -0700 (PDT)
X-QQ-mid: bizesmtp68t1687460925t3449k82
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 23 Jun 2023 03:08:43 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: zT6n3Y95oi0+GF2rz41IpqKmQQtPn9dIE2aj0KkXMIaCuzLAVuWvOc3JP5oeO
        PKznVlOojlNN6dUd5Tr33s/TsUPIxkR/zyEGfmHjEhnYEGfmqpPLcHD6P44A3G0OtsIngvF
        zg8X/8uKlWtzEIjFJNh9Ehw81v8ZGwOSu2nEKWXvPcLYUKpP8OLaOTK3yX9FWRe+wlt/wW1
        Cjjg9MamTX7Ydembt+uVrXDW/myWX152jB9blHmVoU9/TqU1kj0d2hRbhF3XtI77FI3slHf
        jxB8z+eCNy+gZVBtxzvpTJPhcVlMwsRZYsAcVsA5bJooVK3U2mqFfztB79sbX+oFQFDynek
        Gv1xDLxCtuiH78WOuPu9VSZCYQEaH9Pl3OOyZ/ZhJgSBZCh/EqUlpzwqhhbhQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11068915257765438877
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, david.laight@aculab.com, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, w@1wt.eu
Subject: Re: [PATCH v4 07/10] tools/nolibc: clean up mmap() support
Date:   Fri, 23 Jun 2023 03:08:43 +0800
Message-Id: <20230622190843.1189684-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <31d85464-5731-4df6-8fcd-2b0be11eac90@t-8ch.de>
References: <31d85464-5731-4df6-8fcd-2b0be11eac90@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> On 2023-06-19 23:51:20+0800, Zhangjin Wu wrote:
> > Do several cleanups together:
> > 
> > - Since all supported architectures have my_syscall6() now, remove the
> >   #ifdef check.
> > 
> > - Move the mmap() related macros to tools/include/nolibc/types.h
> > 
> > - Apply the new __sysret() to convert the calling of sys_map() to
> >   oneline code
> > 
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/sys.h   | 24 +-----------------------
> >  tools/include/nolibc/types.h | 11 +++++++++++
> >  2 files changed, 12 insertions(+), 23 deletions(-)
> > 
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index 8a6e16472d54..1c02cec3bcd9 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -624,26 +624,11 @@ int mknod(const char *path, mode_t mode, dev_t dev)
> >  	return __sysret(sys_mknod(path, mode, dev));
> >  }
> >  
> > -#ifndef MAP_SHARED
> > -#define MAP_SHARED		0x01	/* Share changes */
> > -#define MAP_PRIVATE		0x02	/* Changes are private */
> > -#define MAP_SHARED_VALIDATE	0x03	/* share + validate extension flags */
> > -#endif
> > -
> > -#ifndef MAP_FAILED
> > -#define MAP_FAILED ((void *)-1)
> > -#endif
> > -
> >  #ifndef sys_mmap
> >  static __attribute__((unused))
> >  void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
> >  	       off_t offset)
> 
> This could return a plain integer type instead to save some casts.
> Not sure if API compatibility is guaranteed for the raw sys_ functions.
>

Seems musl simply not provide the sys_xxx() functions, but let the library
routines call __syscall() directly. If we can treat these sys_xxx() as internal
functions, perhaps we can simply let the return type of sys_xxx() as 'long' to.

    $ grep "^void \*sys_" -ur tools/include/nolibc/sys.h 
    void *sys_brk(void *addr)
    void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,

Thanks,
Zhangjin


> >  {
> > -#ifndef my_syscall6
> > -	/* Function not implemented. */
> > -	return (void *)-ENOSYS;
> > -#else
> > -
> >  	int n;
> >  
> >  #if defined(__NR_mmap2)
> > @@ -654,20 +639,13 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
> >  #endif
> >  
> >  	return (void *)my_syscall6(n, addr, length, prot, flags, fd, offset);
> > -#endif
> >  }
> >  #endif
> >  
> >  static __attribute__((unused))
> >  void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
> >  {
> > -	void *ret = sys_mmap(addr, length, prot, flags, fd, offset);
> > -
> > -	if ((unsigned long)ret >= -4095UL) {
> > -		SET_ERRNO(-(long)ret);
> > -		ret = MAP_FAILED;
> > -	}
> > -	return ret;
> > +	return (void *)__sysret((unsigned long)sys_mmap(addr, length, prot, flags, fd, offset));
> >  }
> >  
> >  static __attribute__((unused))
> > diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
> > index f96e28bff4ba..f889d4e0ac7e 100644
> > --- a/tools/include/nolibc/types.h
> > +++ b/tools/include/nolibc/types.h
> > @@ -81,6 +81,17 @@
> >  #define MAXPATHLEN     (PATH_MAX)
> >  #endif
> >  
> > +/* flags for mmap */
> > +#ifndef MAP_SHARED
> > +#define MAP_SHARED		0x01	/* Share changes */
> > +#define MAP_PRIVATE		0x02	/* Changes are private */
> > +#define MAP_SHARED_VALIDATE	0x03	/* share + validate extension flags */
> > +#endif
> > +
> > +#ifndef MAP_FAILED
> > +#define MAP_FAILED ((void *)-1)
> > +#endif
> > +
> >  /* whence values for lseek() */
> >  #define SEEK_SET       0
> >  #define SEEK_CUR       1
> > -- 
> > 2.25.1
> > 
