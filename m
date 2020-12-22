Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8E2E0403
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Dec 2020 02:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgLVBom (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Dec 2020 20:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVBom (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Dec 2020 20:44:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA61DC0613D3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Dec 2020 17:44:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b26so18744343lff.9
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Dec 2020 17:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlJ+gSX9CX83EGElVlFXeLQjrVhJXRj1nsqlPU4eRmg=;
        b=FHLa/KdeoJ3uqDpF2FRlOgBZzKdszSdfc7e76og/OxR/AhSdzY2yvpOJpxcDvorgBo
         AutrCqbJ9ZZVUOKLOloU2oZudaQaX1zlqI5PNpJdnBpVSRdbw8dleY7sZTp2egjIzVQ1
         KB6+/Wt9wxYQ/Zw2v4XhmfFxSROTk/ptbo5zmSXGF1bqmQqCUQN3xjQB+Cry1B1wYzNi
         W4kgVxBTZEAHjRGpgkbDVcRlj5vbg6UcdEl8pcnung/Q/YSaXuR96/jiaAMdB/Ov0CYg
         LxYjF56e3kgVqr4A1yw00whmCoW2XGOhte4GXoUTERD6xO6agqifSe9DVxHGLSrgbh9g
         L+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlJ+gSX9CX83EGElVlFXeLQjrVhJXRj1nsqlPU4eRmg=;
        b=m6/VNbfC3KzaoAGtdEGHynbUK6MaoBNupz7EIMFesEvViFgCN8t9+KlD3wjS+3BUlJ
         MtUAKE+YIOTImQ3/TyGxyGNmQ02pVmZ0Mu4OoqjJRYKJ2vIrES+JqTO8v3UN1PZK/wlM
         LrUkvYJTwqBW8EuRUlGeG3eVWirvxW1o4OisKgTuST31m080aNjdzT4YzrRM7iG+0DMg
         asMgTJe7ErGf7YmdsC3cGonB+Ml4mdduvOCs0z5dsVWM3ynwAjm6bQso5YOmAOQSSK5U
         T3wqAjKorzqOOvkRBt8tcf46tazf4Kj8NhzEjIRYu17cJECPMVeteQ8LLrBXLxC5FMB/
         OqrA==
X-Gm-Message-State: AOAM533gm27AdiGHRD45RaCe0N7v1A6bn0bv6XoNAK3+B4OmZqFoyaRS
        QXQ3qAFuXSVX0/t+w786ZV24HgKgs0rPuj4De2yqCP0qLfj5VAIv
X-Google-Smtp-Source: ABdhPJynNnI2kDpzWFTVhhdo7KndqtwotCPscy6M8TCRhquUNCsr1CFWMI2PYGnMdOEsgLxwtRDdBhkB/7I4hNhayCs=
X-Received: by 2002:ac2:539c:: with SMTP id g28mr7483971lfh.382.1608601440286;
 Mon, 21 Dec 2020 17:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20201221144302.GR4077@smile.fi.intel.com> <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com> <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com>
In-Reply-To: <20201221200332.GB4077@smile.fi.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 22 Dec 2020 09:43:48 +0800
Message-ID: <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
Subject: Re: kunit stopped working
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 22, 2020 at 4:02 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 21, 2020 at 09:40:08PM +0200, Andy Shevchenko wrote:
> > +Cc people from culprit commit
>
> Guys, revert helps. I am open to test any solution you may propose, thanks!
>
> ...
>
> > # first bad commit: [757055ae8dedf5333af17b3b5b4b70ba9bc9da4e] init/console: Use ttynull as a fallback when there is no console
>
> --

+CC linux-um

There appear to be two problems here:
1. UML now no longer has console output by default (which KUnit needs
to get results)
2. UML now seems to crash on startup when ttynull is used (which is now default)

This can be worked around for KUnit by passing console=tty to the
kernel. I don't think this is a "correct" fix, as UML seems to be
crashing out-of-the-box anyway (see below), but it may be worth us
forcing this as we require the console output as well.

In any case, this patch fixes it in kunit_tool for now. I may submit
this as a proper patch anyway, but that won't fix UML in general:

diff --git a/tools/testing/kunit/kunit_kernel.py
b/tools/testing/kunit/kunit_kernel.py
index 57c1724b7e5d..698358c9c0d6 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -198,7 +198,7 @@ class LinuxSourceTree(object):
               return self.validate_config(build_dir)

       def run_kernel(self, args=[], build_dir='', timeout=None):
-               args.extend(['mem=1G'])
+               args.extend(['mem=1G', 'console=tty'])
               self._ops.linux_bin(args, timeout, build_dir)
               outfile = get_outfile_path(build_dir)
               subprocess.call(['stty', 'sane'])

---

It looks like this is breaking UML entirely by default, though: if I
start ./vmlinux, I get a SIGSEGV in n_tty_open() early on. It looks
like this is due to the ttynull driver trying to be opened and, for
whatever reason, `ldata' is pointing to invalid memory. I'm not sure
why this is broken but it definitely looks like ttynull is just
completely crashing UML at the moment.
The kernel output and stacktrace look like this:
Core dump limits :
       soft - 0
       hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking environment variables for a tempdir...none found
Checking if /dev/shm is on tmpfs...OK
Checking PROT_EXEC mmap in /dev/shm...OK
Program received signal SIGSEGV, Segmentation fault.
0x00000000601bf17c in n_tty_open (tty=0x6064d800) at
../drivers/tty/n_tty.c:1920
1920            ldata->overrun_time = jiffies;
(gdb) bt
#0  0x00000000601bf17c in n_tty_open (tty=0x6064d800) at
../drivers/tty/n_tty.c:1920
#1  0x00000000601c54e3 in tty_ldisc_open (ld=0x6041a020,
tty=0x6064d800) at ../drivers/tty/tty_ldisc.c:463
#2  tty_ldisc_setup (tty=tty@entry=0x6064d800, o_tty=0x0) at
../drivers/tty/tty_ldisc.c:773
#3  0x00000000601bcb36 in tty_init_dev
(driver=driver@entry=0x6040fb40, idx=0) at
../drivers/tty/tty_io.c:1366
#4  0x00000000601bd822 in tty_open_by_driver (filp=0x60407200,
device=5242881) at ../drivers/tty/tty_io.c:1987
#5  tty_open (inode=0x608050c0, filp=0x60407200) at ../drivers/tty/tty_io.c:2035
#6  0x00000000600ee087 in chrdev_open (inode=inode@entry=0x608050c0,
filp=filp@entry=0x60407200) at ../fs/char_dev.c:414
#7  0x00000000600e40c9 in do_dentry_open (f=f@entry=0x60407200,
inode=0x608050c0, open=0x600ee030 <chrdev_open>, open@entry=0x0) at
../fs/open.c:817
#8  0x00000000600e59d8 in vfs_open (path=path@entry=0x60433db0,
file=file@entry=0x60407200) at ../include/linux/dcache.h:552
#9  0x00000000600fa371 in do_open (op=0x60433ed0, file=0x60407200,
nd=0x60433db0) at ../fs/namei.c:3252
#10 path_openat (nd=nd@entry=0x60433db0, op=op@entry=0x60433ed0,
flags=flags@entry=65) at ../fs/namei.c:3369
#11 0x00000000600fa7ec in do_filp_open (dfd=dfd@entry=-100,
pathname=pathname@entry=0x60498000, op=op@entry=0x60433ed0) at
../fs/namei.c:3396
#12 0x00000000600e5f31 in file_open_name (name=name@entry=0x60498000,
flags=flags@entry=2, mode=mode@entry=0) at ../fs/open.c:1117
#13 0x00000000600e605e in filp_open
(filename=filename@entry=0x6025e26f "/dev/console",
flags=flags@entry=2, mode=mode@entry=0) at ../fs/open.c:1137
#14 0x0000000060001f03 in console_on_rootfs () at ../init/main.c:1480
#15 0x00000000600021b4 in kernel_init_freeable () at ../init/main.c:1536
#16 0x0000000060218bde in kernel_init (unused=<optimized out>) at
../init/main.c:1415
#17 0x00000000600184a1 in new_thread_handler () at
../arch/um/kernel/process.c:136
#18 0x0000000000000000 in ?? ()

Does anyone know why ttynull is being used by default on UML even when
there's the better 'tty' console driver to use? Either way, it'd be
nice if it didn't crash things, too.

Cheers,
-- David
