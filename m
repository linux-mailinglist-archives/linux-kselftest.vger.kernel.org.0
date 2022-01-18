Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAE349205C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 08:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiARHe0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 02:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiARHeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 02:34:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49670C061574;
        Mon, 17 Jan 2022 23:34:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u21so75538740edd.5;
        Mon, 17 Jan 2022 23:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/1OBZme0H7AVI+jDyd9p59GVxpM5RWOedaf9dth3aMc=;
        b=ni93+18+9ZRAbWhYSzp+z0hv9ztm+CzSmPZfaqhodYah7GEH39cUK9ZHd1eFolbIKV
         NZAFhG9iiGF6e4b0l2Xll8McRP5eFSgDTagFNbAKeogtG5i5kQp6TIP+zgTb8xLcqAVE
         ssxylESId85cxUM7wS4H7KGXsp3WbtzkLKjqBuL+E9gbMk+z6MalwsGUid5uirfjTiW+
         93tnTla0nhDiryj4YI3mOOIQybcctya/sSsfu/e7RGRl4by/EUJc8xWMhLI4ogHFwd1w
         LsZP/QXuCU6AE7cNRBsZqlisxxpZa8JZ7iAbjOjMU23KC3t9svLWdMnTfNUaj2zoiqCS
         7GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/1OBZme0H7AVI+jDyd9p59GVxpM5RWOedaf9dth3aMc=;
        b=t5YKEZAOJW9NTg3GjQ8gJX8lBkYHo/9Bxe8IHYwOFFNTk3moEj6ZntEBreGz8NT3zq
         h8zQ8SX3SfEfQwBuisD00/X+y+/2lh6HnXQlo7c3tn9DgUIkhs6IAvRARSaO8V18TlCI
         2I1k0DxmCTghjXOffafhnBWm9YhTrGMgEcAvYwb3xynuCovEx3GlVMJepNKQSJG3fUvH
         UQfUzIDgI6jR2hZtNwjI1jxItIgeamPszXo+IwGeK9EeRASdb5/gyvoB/rDAboupHMLT
         Vj6TLhx4OzjfCU1TQD04vvdW/kk3wEe9UR7NfAri840GnEJpYcRomxsjY7JWkgC7yin6
         eKhQ==
X-Gm-Message-State: AOAM530GXt2ONW0zkjTtcpMuTO2faLVTcDSDeLx3s6swvLwt7yqD6YS6
        /HQ3zHD/eiEhd6eOP7+Z2ertM7LIV78BBL7X9YU=
X-Google-Smtp-Source: ABdhPJzEy+UoEgRvCVbsb7dgoinR2POTS9Kevj+Md3URP1Oie4n0zruj5AejpaklPNynVAEtc3rUsmbI1szMyLvbiiU=
X-Received: by 2002:a17:906:7254:: with SMTP id n20mr12886751ejk.551.1642491262743;
 Mon, 17 Jan 2022 23:34:22 -0800 (PST)
MIME-Version: 1.0
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
In-Reply-To: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 18 Jan 2022 15:34:10 +0800
Message-ID: <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other failures
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,
I have studied the rcu torture test recently. I am also interested in
this topic.
But I can't open
[1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.txt
[2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt

From your email, It seems that include/generated/autoconf.h is not
generated in the early stage of kernel build.

Could you try following one by one if you have time ;-)
after invoking each of the following commands, we can examine if
include/generated/autoconf.h is created in another terminal, and if it
is
created, we can try the next command.
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE01=
"
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE02=
"
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE03=
"
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE04=
"
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE05=
"
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE06=
"
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE07=
"
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE08=
"
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE09=
"
tools/testing/selftests/rcutorture/bin/kvm.sh --buildonly --configs "TREE10=
"

I am a beginner at learning RCU ;-)  I may not be right. Apologize in
advance if I am not right.

Thanks
Zhouyi

On Tue, Jan 18, 2022 at 11:03 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Linux folks,
>
>
> On an IBM S822LC SL822 (ppc64le) with Ubuntu 21.04, I tried to torture
> the RCU. allmodconfig(2) failed though.
>
> ```
> $ git describe
> v5.16-10660-g0c947b893d69
> $ tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
>   ---  tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
>   --- Results directory:  2022.01.17-18.44.36-torture
>   --- allmodconfig: Start Mon Jan 17 06:44:36 PM CET 2022
>   --- rcutorture: Start Mon Jan 17 06:45:02 PM CET 2022
>   --- rcutorture-kasan: Start Mon Jan 17 07:07:41 PM CET 2022
>   --- locktorture: Start Mon Jan 17 07:33:38 PM CET 2022
>   --- locktorture-kasan: Start Mon Jan 17 07:37:05 PM CET 2022
>   --- scftorture: Start Mon Jan 17 07:40:54 PM CET 2022
>   --- scftorture-kasan: Start Mon Jan 17 07:43:31 PM CET 2022
>   --- refscale-rcu: Start Mon Jan 17 07:46:34 PM CET 2022
>   --- refscale-rcu-kasan: Start Mon Jan 17 07:49:08 PM CET 2022
>   --- refscale-srcu: Start Mon Jan 17 07:52:05 PM CET 2022
>   --- refscale-srcu-kasan: Start Mon Jan 17 07:54:39 PM CET 2022
>   --- refscale-rcu-tasks: Start Mon Jan 17 07:57:35 PM CET 2022
>   --- refscale-rcu-tasks-kasan: Start Mon Jan 17 08:00:10 PM CET 2022
>   --- refscale-rcu-trace: Start Mon Jan 17 08:03:06 PM CET 2022
>   --- refscale-rcu-trace-kasan: Start Mon Jan 17 08:05:40 PM CET 2022
>   --- refscale-refcnt: Start Mon Jan 17 08:08:40 PM CET 2022
>   --- refscale-refcnt-kasan: Start Mon Jan 17 08:11:15 PM CET 2022
>   --- refscale-rwlock: Start Mon Jan 17 08:14:14 PM CET 2022
>   --- refscale-rwlock-kasan: Start Mon Jan 17 08:16:48 PM CET 2022
>   --- refscale-rwsem: Start Mon Jan 17 08:19:45 PM CET 2022
>   --- refscale-rwsem-kasan: Start Mon Jan 17 08:22:18 PM CET 2022
>   --- refscale-lock: Start Mon Jan 17 08:25:17 PM CET 2022
>   --- refscale-lock-kasan: Start Mon Jan 17 08:27:53 PM CET 2022
>   --- refscale-lock-irq: Start Mon Jan 17 08:30:58 PM CET 2022
>   --- refscale-lock-irq-kasan: Start Mon Jan 17 08:33:42 PM CET 2022
>   --- refscale-acqrel: Start Mon Jan 17 08:36:58 PM CET 2022
>   --- refscale-acqrel-kasan: Start Mon Jan 17 08:39:33 PM CET 2022
>   --- refscale-clock: Start Mon Jan 17 08:42:33 PM CET 2022
>   --- refscale-clock-kasan: Start Mon Jan 17 08:45:08 PM CET 2022
>   --- rcuscale-rcu: Start Mon Jan 17 08:48:06 PM CET 2022
>   --- rcuscale-rcu-kasan: Start Mon Jan 17 08:49:25 PM CET 2022
>   --- rcuscale-srcu: Start Mon Jan 17 08:50:56 PM CET 2022
>   --- rcuscale-srcu-kasan: Start Mon Jan 17 08:52:14 PM CET 2022
>   --- rcuscale-srcud: Start Mon Jan 17 08:53:43 PM CET 2022
>   --- rcuscale-srcud-kasan: Start Mon Jan 17 08:55:01 PM CET 2022
>   --- rcuscale-tasks: Start Mon Jan 17 08:56:31 PM CET 2022
>   --- rcuscale-tasks-kasan: Start Mon Jan 17 08:57:48 PM CET 2022
>   --- rcuscale-tasks-tracing: Start Mon Jan 17 08:59:17 PM CET 2022
>   --- rcuscale-tasks-tracing-kasan: Start Mon Jan 17 09:00:35 PM CET 2022
>   --- rcuscale-kvfree: Start Mon Jan 17 09:02:05 PM CET 2022
>   --- rcuscale-kvfree-kasan: Start Mon Jan 17 09:03:23 PM CET 2022
>   --- clocksourcewd-1: Start Mon Jan 17 09:04:52 PM CET 2022
>   --- clocksourcewd-1-kasan: Start Mon Jan 17 09:06:11 PM CET 2022
>   --- clocksourcewd-2: Start Mon Jan 17 09:07:42 PM CET 2022
>   --- clocksourcewd-2-kasan: Start Mon Jan 17 09:08:59 PM CET 2022
>   ---  tools/testing/selftests/rcutorture/bin/torture.sh --duration 10
>   ---  Done Mon Jan 17 09:10:29 PM CET 2022
> SUCCESSES:
> rcutorture(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcutorture
> rcutorture-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcutorture-kasan
> locktorture(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-locktorture
> locktorture-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-locktorture-kasan
> scftorture(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-scftorture
> scftorture-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-scftorture-kasan
> refscale-rcu(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rcu
> refscale-rcu-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rcu-kasan
> refscale-srcu(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-srcu
> refscale-srcu-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-srcu-kasan
> refscale-rcu-tasks(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rcu-tasks
> refscale-rcu-tasks-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rcu-tasks-kasan
> refscale-rcu-trace(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rcu-trace
> refscale-rcu-trace-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rcu-trace-kasan
> refscale-refcnt(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-refcnt
> refscale-refcnt-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-refcnt-kasan
> refscale-rwlock(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rwlock
> refscale-rwlock-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rwlock-kasan
> refscale-rwsem(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rwsem
> refscale-rwsem-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-rwsem-kasan
> refscale-lock(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-lock
> refscale-lock-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-lock-kasan
> refscale-lock-irq(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-lock-irq
> refscale-lock-irq-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-lock-irq-kasan
> refscale-acqrel(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-acqrel
> refscale-acqrel-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-acqrel-kasan
> refscale-clock(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-clock
> refscale-clock-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-refscale-clock-kasan
> rcuscale-rcu(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-rcu
> rcuscale-rcu-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-rcu-kasan
> rcuscale-srcu(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-srcu
> rcuscale-srcu-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-srcu-kasan
> rcuscale-srcud(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-srcud
> rcuscale-srcud-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-srcud-kasan
> rcuscale-tasks(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-tasks
> rcuscale-tasks-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-tasks-kasan
> rcuscale-tasks-tracing(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-tasks-tracing
> rcuscale-tasks-tracing-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-tasks-tracing-kasan
> rcuscale-kvfree(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-kvfree
> rcuscale-kvfree-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcuscale-kvfree-kasan
> clocksourcewd-1(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-clocksourcewd-1
> clocksourcewd-1-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-clocksourcewd-1-kasan
> clocksourcewd-2(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-clocksourcewd-2
> clocksourcewd-2-kasan(0)
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-clocksourcewd-2-kasan
> FAILURES:
> allmodconfig(2)
> tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36-torture/allmod=
config
> Started at Mon Jan 17 06:44:36 PM CET 2022, ended at Mon Jan 17 09:10:29
> PM CET 2022, duration 2:25:53.
> Summary: Successes: 44 Failures: 1.
> Size before compressing 0 files: 86M Mon Jan 17 09:10:29 PM CET 2022
> Waiting for final batch 1 of 22 compressions Mon Jan 17 09:10:29 PM CET 2=
022
> Size after compressing 0 files: 86M Mon Jan 17 09:10:29 PM CET 2022
> Total duration 2:25:53.
> ```
>
> Here is an excerpt from `Make.out` [1]:
>
> ```
>    CC [M]  sound/isa/ad1848/ad1848.o
>    CC      security/keys/encrypted-keys/ecryptfs_format.o
> In file included from <command-line>:
> ././include/linux/kconfig.h:5:10: fatal error: generated/autoconf.h: No
> such file or directory
>      5 | #include <generated/autoconf.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
>    CC [M]  fs/reiserfs/inode.o
> In file included from <command-line>:
> ././include/linux/kconfig.h:5:10: fatal error: generated/autoconf.h: No
> such file or directory
>      5 | #include <generated/autoconf.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> In file included from <command-line>:
> ././include/linux/kconfig.h:5:10: fatal error: generated/autoconf.h: No
> such file or directory
>      5 | #include <generated/autoconf.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:288:
> security/keys/encrypted-keys/ecryptfs_format.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> In file included from <command-line>:
> ././include/linux/kconfig.h:5:10: fatal error: generated/autoconf.h: No
> such file or directory
>      5 | #include <generated/autoconf.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
>    CC [M]  sound/i2c/i2c.o
> In file included from <command-line>:
> ././include/linux/kconfig.h:5:10: fatal error: generated/autoconf.h: No
> such file or directory
>      5 | #include <generated/autoconf.h>
>        |          ^~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
>    CC [M]  fs/ext4/block_validity.o
> make[3]: *** [scripts/Makefile.build:288: sound/isa/ad1848/ad1848.o] Erro=
r 1
> make[2]: *** [scripts/Makefile.build:550: sound/isa/ad1848] Error 2
> make[1]: *** [scripts/Makefile.build:550: sound/isa] Error 2
> make[1]: *** Waiting for unfinished jobs....
> ```
>
> I wonder why other builds seem to have worked. But checking the other
> results, despite the output saying the runs were a success the Linux
> kernel builds seem to have failed. For example [2]:
>
> ```
> $ more
> tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36-torture/result=
s-rcutorture/log
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 7
> --configs CFLIST --trust-make --bootargs
> rcupdate.rcu_cpu_stall_suppress_at_boot=3D1 torture.disable_onoff_at_boot
> rcupdate.rcu_task_stall_timeout=3D30000 --datestamp
> 2022.01.17-18.44.36-torture/results-rcutorture
> ----Start batch 1: Mon Jan 17 06:45:03 PM CET 2022
> TREE03 16: Starting build. Mon Jan 17 06:45:03 PM CET 2022
> [=E2=80=A6]
> TREE09 1: Build complete. Mon Jan 17 07:07:40 PM CET 2022
> ---- No kernel runs. Mon Jan 17 07:07:40 PM CET 2022
> ---- TREE03 16: Build/run results:
>   --- Mon Jan 17 06:45:03 PM CET 2022: Starting build, PID 3530842
> :CONFIG_HYPERVISOR_GUEST=3Dy: improperly set
> :CONFIG_PARAVIRT=3Dy: improperly set
> Kernel build error
> make[2]: *** No rule to make target
> 'arch/powerpc/kvm//dev/shm/linux/tools/testing/selftests/rcutorture/kvm_m=
ain.o',
> needed by 'arch/powerpc/kvm/kvm.o'.  Stop.
> make[1]: *** [scripts/Makefile.build:550: arch/powerpc/kvm] Error 2
> make: *** [Makefile:1840: arch/powerpc] Error 2
> Run aborted.
> Build failed, not running KVM, see
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcutorture/TREE03.
> [=E2=80=A6]
> ESC[031mBUG: ESC[mBuild failed
>
> /dev/shm/linux/tools/testing/selftests/rcutorture/res/2022.01.17-18.44.36=
-torture/results-rcutorture/TREE09
>   --- Done at Mon Jan 17 07:07:41 PM CET 2022 (22:39.0) exitcode 0
> ```
>
>
> Kind regards,
>
> Paul
>
>
> [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.txt
> [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt
