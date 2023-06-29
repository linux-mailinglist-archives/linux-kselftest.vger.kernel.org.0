Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081F4742FA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjF2Von (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 17:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjF2Voi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 17:44:38 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40BC3584;
        Thu, 29 Jun 2023 14:44:34 -0700 (PDT)
Date:   Thu, 29 Jun 2023 23:44:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688075073; bh=4IAUT0Ho/s5eQLzmy4bQkSShuJDJjqKX5GUlCungCVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFsmVdG7Wfi61VyTKzM+IbS5+K61lxAfx+Y//Seu2G/MBOjq9MWUWBW5k7/4+J2kG
         PImMs1RDsN7BRcdwbigq2/NK3rgLjYJLctL/NhCBpho8Xke22do2nxiIwbC6UjMPGQ
         f8mkJ1g4dFVfB+DIuOMu6Btom+o8J4PFT6aYx8jo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 05/17] selftests/nolibc: stat_timestamps: remove
 procfs dependency
Message-ID: <9ad51430-b7c0-47dc-80af-20c86539498d@t-8ch.de>
References: <df1f8ba1-3040-465c-804e-495f046dba7a@t-8ch.de>
 <20230629212335.115754-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629212335.115754-1-falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-06-30 05:23:35+0800, Zhangjin Wu wrote:
> > Hi Zhangjin,
> > 
> > On 2023-06-28 21:59:22+0800, Zhangjin Wu wrote:
> > > I'm preparing a revision for this series, in the past days, when I was
> > > working on testing our new 'minimal' kernel config support for all of
> > > the architectures, the time cost (and wait) is really appreciable and the
> > > repeated develop and test is really a big pain, I can also image when you
> > > was working on stack-protector and Willy was working on lots of old
> > > features ;-)
> > 
> > To be honest I almost never built a kernel.
> > Most of the time I tested my stuff with qemu-user.
> > This made the dev-cycle really fast, especially with a binfmt setup that
> > launches foreign binaries automatically with qemu-user.
> >
> 
> Yeah, qemu-user-static + binfmt_misc work perfectly, but my host kernel
> is not that new, so, I'm still a little worried about that there may be
> some hidden issues.

qemu-user shouldn't have specific requirements for the host kernel.
Could you elaborate?

> > > As you explained before, I knew the idea of using '/proc/self' here is
> > > important to not using a fixed-time file, besides our proposed method (make
> > > sure it at least not fail, just skip for !procfs):
> > > 
> > >     - CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
> > >     + CASE_TEST(stat_timestamps);   EXPECT_SYSZR(proc, test_stat_timestamps()); break;
> > > 
> > > To further avoid skip it for !procfs (I don't mean relaly disable it for the
> > > default tinyconfig support, which need more discuss, at least provide the
> > > possibility to pass without procfs), do you like this change? it doesn't depend
> > > on 'proc' now.
> > > 
> > >     -	if (stat("/proc/self/", &st))
> > >     +	if (stat("/proc/self/", &st) && stat("/init", &st) && stat("/", &st))
> > > 
> > > The "/init" is compiled for 'run' target every time, so, the time stamp should
> > > be dynamic enough, for libc-test, the /proc/self should be always there (if
> > > still not enough, we can reuse the init file list here), the "/" here is only
> > > for the worst-case scene ;-)
> > 
> > Both aproaches seem fine. Just skipping on !proc seems good enough.
> >
> 
> To get less skips, let's use the second method, just updated my local
> patches ;-)
> 
> > As for enabling proc in the test configs I just tested a plain
> > tinyconfig vs one with CONFIG_PROC_FS enabled:
> > 
> > tinyconfig:                  375.06user 53.21system 2:05.80elapsed
> > tinyconfig + CONFIG_PROC_FS: 397.77user 56.84system 2:09.24elapsed
> > 
> > The overhead seems acceptable.
> >
> 
> Yeah, only one option is ok, but "multiple options x multiple
> architectures x multiple repeated runs", that is 'huge' ;-)

In your other patchset you mentioned a few options that were needed.
But if we can drop CONFIG_NET completely, reduce CONFIG_TMPFS to
CONFIG_MEMFD I would like to reevaluate the overall impact.

> > 
> > Note as for disabling memfd:
> > 
> > It seems currently MEMFD_CREATE is hardwired to only be enabled when
> > either TMPFS or HUGETLBFS is enabled.
> > 
> > But the memfd code and syscalls seem to work perfectly fine with those
> > options disabled. I'll send a patch to fix up the Kconfigs to enable
> > that usecase.
> 
> Good catch!
> 
> but for the vfprintf test cases, It is able to open a file from tmpfs
> directly. If no tmpfs, use the default ramfs (initramfs uses) instead,
> this will also avoid the new flags trying (to silence the warning).
> 
>      static int expect_vfprintf(int llen, size_t c, const char *expected, const char *fmt, ...)
>      {
>     +       static const char *tmpfile = "/tmp/nolibc-vfprintf";
>     +       struct stat stat_buf;

This should not be static.

>             int ret, fd, w, r;
>             char buf[100];
>             FILE *memfile;
>             va_list args;
> 
>     -       fd = memfd_create("vfprintf", 0);
>     +       if (stat("/tmp/.", &stat_buf)) {
>     +               pad_spc(llen, 64, "[SKIPPED]\n");
>     +               return 0;
>     +       }

Instead of checking with stat() here it would be nicer to check the
result of open() below.

>     +
>     +       fd = open(tmpfile, O_CREAT | O_TRUNC | O_RDWR, 0755);

Seems like a good usecase for open("/tmp", O_TMPFILE | O_EXCL | ...)

>     ...
>     +       unlink(tmpfile);

... and drop this.

  fd = memfd_open();
+ if (fd == -1)
+        fd = open("/tmp", O_TMPFILE | O_EXCL | O_CREAT | O_RDWR, 0600);
+ if (fd == -1)
+        skip()

May be enough.

>     ...
> 
> tmpfs is mounted (in another patch) like procfs in prepare() for pid==1.
> 
> I plan to use this method in the revision, do you like this?
> 
> memfd_create() was designed to do this work, but in current stage,
> opening tmpfile ourselves may be better.

I'm not really a fan of having so much fallback code for features that
should always be available.
But if we can keep it straightforward it's probably fine.
Or Willy has another opinion :-)
