Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4DB7150FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 23:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjE2VjR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 17:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE2VjQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 17:39:16 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2EC1;
        Mon, 29 May 2023 14:39:15 -0700 (PDT)
Date:   Mon, 29 May 2023 23:39:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685396352; bh=KERa37f1jCecyGjPwDTuzqnl75Mz6w4gg8XNi9sny+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EsjZvZNlKzIeZ/C1NZ0oNAsYZo+76a2qugPQ+dERKwf0VIJ+gZT7N2+56s/ZcfWch
         kE7kbdQKhvkOFnUNSjZZQXdRJ05uafQpIdadfpI3d1t14QZtF+K95m9AeNtuRfnmFc
         GNOJ025pHOfgaS+mUQmYx7ubLMC/Nm2Tw4J0FVio=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 04/13] tools/nolibc: add missing nanoseconds support
 for __NR_statx
Message-ID: <3a3edd48-1ace-4c89-89e8-9c594dd1b3c9@t-8ch.de>
References: <cover.1685387484.git.falcon@tinylab.org>
 <4cd637be248b5bfad6f2a01b82a9fb6f3fe4c6fa.1685387484.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cd637be248b5bfad6f2a01b82a9fb6f3fe4c6fa.1685387484.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-30 03:50:34+0800, Zhangjin Wu wrote:
> Commit a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
> added nanoseconds for stat() but missed the statx case, this adds it.

Welp, I should have thought of that.
At least the testcase seems to have been useful.

Thanks for the fix!

> The stx_atime, stx_mtime, stx_ctime are in type of 'struct
> statx_timestamp', which is incompatible with 'struct timespec', should
> convert explicitly.
> 
>     /* include/uapi/linux/stat.h */
> 
>     struct statx_timestamp {
>     	__s64	tv_sec;
>     	__u32	tv_nsec;
>     	__s32	__reserved;
>     };
> 
>     /* include/uapi/linux/time_types.h */
>     struct __kernel_timespec {
>     	__kernel_time64_t       tv_sec;                 /* seconds */
>     	long long               tv_nsec;                /* nanoseconds */
>     };
> 
>     /* tools/include/nolibc/types.h */
>     #define timespec __kernel_timespec
> 
> Without this patch, the stat_timestamps test case would fail on rv32.
> 
> Fixes: a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/sys.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index 154194056962..98cfa2f6d021 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -1175,9 +1175,9 @@ int sys_stat(const char *path, struct stat *buf)
>  	buf->st_size    = statx.stx_size;
>  	buf->st_blksize = statx.stx_blksize;
>  	buf->st_blocks  = statx.stx_blocks;
> -	buf->st_atime   = statx.stx_atime.tv_sec;
> -	buf->st_mtime   = statx.stx_mtime.tv_sec;
> -	buf->st_ctime   = statx.stx_ctime.tv_sec;
> +	buf->st_atim    = (struct timespec){ .tv_sec = statx.stx_atime.tv_sec, .tv_nsec = statx.stx_atime.tv_nsec };
> +	buf->st_mtim    = (struct timespec){ .tv_sec = statx.stx_mtime.tv_sec, .tv_nsec = statx.stx_mtime.tv_nsec };
> +	buf->st_ctim    = (struct timespec){ .tv_sec = statx.stx_ctime.tv_sec, .tv_nsec = statx.stx_ctime.tv_nsec };

I would prefer to split the compound assignment into two single
assignments, though.

buf->st_ctim.tv_sec = statx.stx_ctime.tv_sec;
buf->st_ctim.tv_nsec = statx.stx_ctime.tv_nsec;

>  	return ret;
>  }
>  #else
> -- 
> 2.25.1
> 
