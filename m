Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98D7154E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 07:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjE3FVs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 01:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjE3FVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 01:21:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0F7AD;
        Mon, 29 May 2023 22:21:44 -0700 (PDT)
X-QQ-mid: bizesmtp86t1685424093t09pbsru
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 13:21:32 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: q+yjhizk/eK4Twfz5/tkrE7vplCQXvJ4uATWgDp4FlclbHqgTQzECLOaM/5aW
        ciP3qrlZXDUOoqXXgEGPnefG1bscVwQQcb7SNzzTIUIyuSYUnjA8MKAIs/4DWDkTv1UZ/hm
        RMJH3jBhaBXbW+jZobqHikfj6kgNNqri+YL8Wf/avB5c+itkx6m82TmJENM86el0C6f/Hah
        qDPSYwt8xGHJ0WHIxeW8UvilJGfwXk5SfSfWmTbHMizcoiuPY/0TCVlG/oPymB/LEqFCkxa
        jd4aj/2GFDHuQnp5eeriEYwyGxXrr+Y3YlUbxdCrz7RaTK2mcAvBq2mBB0Fb9NGSN+dEcTt
        TpvzNke228KrB4bPGDkzB13vfe9pBxTtmH12H0PsMyn3IJ2toM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6904062556633079927
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, arnd@arndb.de, w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 04/13] tools/nolibc: add missing nanoseconds support for __NR_statx
Date:   Tue, 30 May 2023 13:21:32 +0800
Message-Id: <20230530052132.364685-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3a3edd48-1ace-4c89-89e8-9c594dd1b3c9@t-8ch.de>
References: <3a3edd48-1ace-4c89-89e8-9c594dd1b3c9@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thomas, Arnd, Willy

> On 2023-05-30 03:50:34+0800, Zhangjin Wu wrote:
> > Commit a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
> > added nanoseconds for stat() but missed the statx case, this adds it.
> 
> Welp, I should have thought of that.
> At least the testcase seems to have been useful.
>

yeah, your testcase telled me this issue.

> Thanks for the fix!
> 
> > The stx_atime, stx_mtime, stx_ctime are in type of 'struct
> > statx_timestamp', which is incompatible with 'struct timespec', should
> > convert explicitly.
> > 
> >     /* include/uapi/linux/stat.h */
> > 
> >     struct statx_timestamp {
> >     	__s64	tv_sec;
> >     	__u32	tv_nsec;
> >     	__s32	__reserved;
> >     };
> > 
> >     /* include/uapi/linux/time_types.h */
> >     struct __kernel_timespec {
> >     	__kernel_time64_t       tv_sec;                 /* seconds */
> >     	long long               tv_nsec;                /* nanoseconds */
> >     };
> > 
> >     /* tools/include/nolibc/types.h */
> >     #define timespec __kernel_timespec
> > 
> > Without this patch, the stat_timestamps test case would fail on rv32.
> > 
> > Fixes: a89c937d781a ("tools/nolibc: support nanoseconds in stat()")
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/sys.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index 154194056962..98cfa2f6d021 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -1175,9 +1175,9 @@ int sys_stat(const char *path, struct stat *buf)
> >  	buf->st_size    = statx.stx_size;
> >  	buf->st_blksize = statx.stx_blksize;
> >  	buf->st_blocks  = statx.stx_blocks;
> > -	buf->st_atime   = statx.stx_atime.tv_sec;
> > -	buf->st_mtime   = statx.stx_mtime.tv_sec;
> > -	buf->st_ctime   = statx.stx_ctime.tv_sec;
> > +	buf->st_atim    = (struct timespec){ .tv_sec = statx.stx_atime.tv_sec, .tv_nsec = statx.stx_atime.tv_nsec };
> > +	buf->st_mtim    = (struct timespec){ .tv_sec = statx.stx_mtime.tv_sec, .tv_nsec = statx.stx_mtime.tv_nsec };
> > +	buf->st_ctim    = (struct timespec){ .tv_sec = statx.stx_ctime.tv_sec, .tv_nsec = statx.stx_ctime.tv_nsec };
> 
> I would prefer to split the compound assignment into two single
> assignments, though.
> 
> buf->st_ctim.tv_sec = statx.stx_ctime.tv_sec;
> buf->st_ctim.tv_nsec = statx.stx_ctime.tv_nsec;
>

Ok, will update it in the v3 revision.

And further, what about removing the other !statx parts
(__NR_newfstatat, __NR_stat)? just like we are doing for the other 64bit
syscalls (llseek and time65).

Best regards,
Zhangjin

> >  	return ret;
> >  }
> >  #else
