Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DBF742F74
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 23:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjF2VX6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 17:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjF2VXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 17:23:51 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0762D5B;
        Thu, 29 Jun 2023 14:23:48 -0700 (PDT)
X-QQ-mid: bizesmtp69t1688073816t6rn2wxp
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 05:23:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 3d/k9/GSbqqdYOgmaIVI6oSQFPKWPhUina+MSZdvM1lVs8hdfFSn2l+S1MGhM
        AhRd8U/uFb0bUA1K72HFAsqeTjFP/MqKvv92L7Yw8O9S/3fq82lIouT2iFpUGGpwIH7y7US
        o8usMbkY78sf/DpIG+AvXE3wQa7hg+5RpEZuCD7D9+J3RNJgOkUkkWNx9OdgPZpztFyI7AY
        WgRQxxrpfNjSK1LxrBfbtvSPyhYsjfQTt1Qnzwi/Kc0HHGnd8bOSR2tPFhVrCQyp00Oz2O0
        xBKBcjay+osjSR4cHiyEZnnmhMoGt4yBwP5b7tONfXobnZmaT/D3r6NsOimhY22dyVi0zcr
        ZaHDl27emXN6W2UTDY=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17768331475880898827
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: Re: [PATCH v1 05/17] selftests/nolibc: stat_timestamps: remove procfs dependency
Date:   Fri, 30 Jun 2023 05:23:35 +0800
Message-Id: <20230629212335.115754-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <df1f8ba1-3040-465c-804e-495f046dba7a@t-8ch.de>
References: <df1f8ba1-3040-465c-804e-495f046dba7a@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Hi Zhangjin,
> 
> On 2023-06-28 21:59:22+0800, Zhangjin Wu wrote:
> > I'm preparing a revision for this series, in the past days, when I was
> > working on testing our new 'minimal' kernel config support for all of
> > the architectures, the time cost (and wait) is really appreciable and the
> > repeated develop and test is really a big pain, I can also image when you
> > was working on stack-protector and Willy was working on lots of old
> > features ;-)
> 
> To be honest I almost never built a kernel.
> Most of the time I tested my stuff with qemu-user.
> This made the dev-cycle really fast, especially with a binfmt setup that
> launches foreign binaries automatically with qemu-user.
>

Yeah, qemu-user-static + binfmt_misc work perfectly, but my host kernel
is not that new, so, I'm still a little worried about that there may be
some hidden issues.

> > As you explained before, I knew the idea of using '/proc/self' here is
> > important to not using a fixed-time file, besides our proposed method (make
> > sure it at least not fail, just skip for !procfs):
> > 
> >     - CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
> >     + CASE_TEST(stat_timestamps);   EXPECT_SYSZR(proc, test_stat_timestamps()); break;
> > 
> > To further avoid skip it for !procfs (I don't mean relaly disable it for the
> > default tinyconfig support, which need more discuss, at least provide the
> > possibility to pass without procfs), do you like this change? it doesn't depend
> > on 'proc' now.
> > 
> >     -	if (stat("/proc/self/", &st))
> >     +	if (stat("/proc/self/", &st) && stat("/init", &st) && stat("/", &st))
> > 
> > The "/init" is compiled for 'run' target every time, so, the time stamp should
> > be dynamic enough, for libc-test, the /proc/self should be always there (if
> > still not enough, we can reuse the init file list here), the "/" here is only
> > for the worst-case scene ;-)
> 
> Both aproaches seem fine. Just skipping on !proc seems good enough.
>

To get less skips, let's use the second method, just updated my local
patches ;-)

> As for enabling proc in the test configs I just tested a plain
> tinyconfig vs one with CONFIG_PROC_FS enabled:
> 
> tinyconfig:                  375.06user 53.21system 2:05.80elapsed
> tinyconfig + CONFIG_PROC_FS: 397.77user 56.84system 2:09.24elapsed
> 
> The overhead seems acceptable.
>

Yeah, only one option is ok, but "multiple options x multiple
architectures x multiple repeated runs", that is 'huge' ;-)

> 
> Note as for disabling memfd:
> 
> It seems currently MEMFD_CREATE is hardwired to only be enabled when
> either TMPFS or HUGETLBFS is enabled.
> 
> But the memfd code and syscalls seem to work perfectly fine with those
> options disabled. I'll send a patch to fix up the Kconfigs to enable
> that usecase.

Good catch!

but for the vfprintf test cases, It is able to open a file from tmpfs
directly. If no tmpfs, use the default ramfs (initramfs uses) instead,
this will also avoid the new flags trying (to silence the warning).

     static int expect_vfprintf(int llen, size_t c, const char *expected, const char *fmt, ...)
     {
    +       static const char *tmpfile = "/tmp/nolibc-vfprintf";
    +       struct stat stat_buf;
            int ret, fd, w, r;
            char buf[100];
            FILE *memfile;
            va_list args;

    -       fd = memfd_create("vfprintf", 0);
    +       if (stat("/tmp/.", &stat_buf)) {
    +               pad_spc(llen, 64, "[SKIPPED]\n");
    +               return 0;
    +       }
    +
    +       fd = open(tmpfile, O_CREAT | O_TRUNC | O_RDWR, 0755);
    ...
    +       unlink(tmpfile);
    ...

tmpfs is mounted (in another patch) like procfs in prepare() for pid==1.

I plan to use this method in the revision, do you like this?

memfd_create() was designed to do this work, but in current stage,
opening tmpfile ourselves may be better.

Thanks,
Zhangjin
