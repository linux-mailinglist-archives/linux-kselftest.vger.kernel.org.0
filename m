Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87892725343
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 07:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjFGFTa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 01:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFGFT3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 01:19:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808051735;
        Tue,  6 Jun 2023 22:19:26 -0700 (PDT)
X-QQ-mid: bizesmtp71t1686115155t27gq16b
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 13:19:14 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: G46xFj+wOV9ykUVNNQSk0ai1FCe8wBOCLmMzZ7Pq9KMAMo+Ve+JiiOCA59xXL
        LB+wGdNEQ5CzSFxziqNgxV9VzBrE8HihejgKfwc/We1fHyyT2wAfikXPh26ziGGx97VgxAR
        83s5NEOIzdP0+/C0LsLXZqD2C7eJw9tWBBvEWyf5wILHUYui/R4KysjOnWWAkUrkyPZ/Ain
        /+3yOZNyyrP9hKwwUj2867Yzp2MSXS7ySdlYuMGqfzxJjNZk6lj3LtDpHpadq6mIp1P4snf
        A6h3q1T1eI1OCqfzYqaS17X89RyvzKsGlHkm3d0GjyktR60s98HEBmzD8vO+VKCUFK095h+
        VO/5+WyaSOTdsgTnCHpjrCpEsbn4EmrUgfyPFlWN4JnWE0tQxvOotFuzblVkx648JDWe2HX
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4025936494722067388
From:   Zhangjin Wu <falcon@tinylab.org>
To:     arnd@arndb.de, w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v3 1/3] tools/nolibc: fix up #error compile failures with -ENOSYS
Date:   Wed,  7 Jun 2023 13:19:14 +0800
Message-Id: <20230607051914.667047-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4fcdd08c-e6fb-40b7-9f2b-77f96e798b37@app.fastmail.com>
References: <4fcdd08c-e6fb-40b7-9f2b-77f96e798b37@app.fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sat, Jun 3, 2023, at 11:01, Zhangjin Wu wrote:
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Link:
> > https://lore.kernel.org/linux-riscv/5e7d2adf-e96f-41ca-a4c6-5c87a25d4c9c@app.fastmail.com/
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/sys.h | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index 856249a11890..78c86f124335 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -124,7 +124,7 @@ int sys_chmod(const char *path, mode_t mode)
> >  #elif defined(__NR_chmod)
> >  	return my_syscall2(__NR_chmod, path, mode);
> >  #else
> > -#error Neither __NR_fchmodat nor __NR_chmod defined, cannot implement
> > sys_chmod()
> > +	return -ENOSYS;
> >  #endif
> >  }
>
> I think the most logical would be to have each syscall (chmod,
> fchmodat, ...) have its own function that returns -ENOSYS if
> that is not defined, and have the logic that decides which one
> to use as a separate function.
>

Yeah, agreed, we can clean up them one by one, If split them to their own
syscalls, I have two questions (for Arnd, and Willy too):

1. do we need to add the corresponding library routines at the same time?

  Use llseek() as an example, there will be llseek() and lsee64(). If off_t
  would be converted to 64bit, then, they can be simply added as follows:

    #define lseek64 lseek
    #define llseek lseek

  Or something like this:

    static __attribute__((unused))
    loff_t lseek(int fd, loff_t offset, int whence)
    {
    	return lseek(fd, offset, whence);
    }

    static __attribute__((unused))
    off64_t lseek(int fd, off64_t offset, int whence)
    {
    	return lseek(fd, offset, whence);
    }

  This one aligns with the other already added library routines.

  Which one do you like more?

2. If so, how to cope with the new types when add the library routines?

  Still use the above llseek() as an example, If not use '#define' method,
  We may need to declare loff_t and off64_t in std.h too:

    #define off64_t off_t
    #define loff_t off_t

  Or align with the other new types, use 'typedef' instead of '#define'.

  And further, use poll() as an example, in its manpage [1], there may be some
  new types, such as 'nfds_t', but 'int' is used in tools/include/nolibc/sys.h
  currently, do we need to add nfds_t?

  The 'idtypes_t' and 'id_t' types used by waitid() [2] is similar, both
  of them can simply use the 'int' type.

The above two questions are important to the coming patches, it may determine
how I should tune the new llseek() and waitid() syscalls and their library
routines. very welcome your suggestions.

> This patch is a step in that direction though, so I think that's
> totally fine.

Thanks, so, can I pick your Reviewed-by for the first two patches? I'm ready to
send v4 now ;-)

Best regards,
Zhangjin

---
[1]: https://linux.die.net/man/2/poll
[2]: https://linux.die.net/man/2/waitid

>
>      Arnd
