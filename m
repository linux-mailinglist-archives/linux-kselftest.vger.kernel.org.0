Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF96181450
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 10:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgCKJOB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 05:14:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40522 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKJOB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 05:14:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id p2so1548754wrw.7
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 02:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=xsSU+80Y3lxtivrqrvbzy5IJmkkrb659KNbVYST+ACI=;
        b=IFOsCCE2tqs8vx0LM5wU6CBztdfLg8u2Yup4/1hoWnbdB8GRQnXPqJAupS00fKh0SQ
         gyW5ONhZFoGqUClx+6WidjOaeLvCqHarhro1Wih52JXWfB6iGxVH1NIhpmyNjVfcLScE
         OysFcgv0gnUrFxRa7VeRmv2YlTf7HzOiMUCrOJeeW//iZiZzHLRhVFPwy5TYk6vldHUV
         JcuAeJTEMtx4feucRB1uHuJj5AbSV4J2ovEcstxrGHRhHmvNqpUUhqu575E2EEh4EpDQ
         MfHaayirdiHL3P1RzvQ7rEo5ifv+yLeZsajyiuBLsdIj7YjD3KRcXfauNIRYJgO7Aj7k
         WCLA==
X-Gm-Message-State: ANhLgQ0S0OZ0xfTq4oyY0UQL1q14jAtzfaJEbgiQDF2NiqmUOdluHYjz
        1z6bBN+7PFBl7n8pPgJ3LLPVBQ==
X-Google-Smtp-Source: ADFU+vsYf1KquYfcemf3FjAgci4KByuaitL3xBXGeBCd9SxaaK7D/ZsYeNmplABcK3CkkFJDnRTDxQ==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr3390174wrr.415.1583918039172;
        Wed, 11 Mar 2020 02:13:59 -0700 (PDT)
Received: from Google-Pixel-3a.fritz.box (ip5f5bf7ec.dynamic.kabel-deutschland.de. [95.91.247.236])
        by smtp.gmail.com with ESMTPSA id f127sm7782162wma.4.2020.03.11.02.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 02:13:58 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:13:57 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+G9fYusdfg7PMfC9Xce-xLT7NiyKSbgojpK35GOm=Pf9jXXrA@mail.gmail.com>
References: <CA+G9fYusdfg7PMfC9Xce-xLT7NiyKSbgojpK35GOm=Pf9jXXrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: WARNING: at refcount.c:190 refcount_sub_and_test_checked+0xac/0xc8 - refcount_t: underflow; use-after-free.
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     John Stultz <john.stultz@linaro.org>, tkjos@google.com,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, ardb@kernel.org,
        Kees Cook <keescook@chromium.org>, lkft-triage@lists.linaro.org
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <FBB76EEA-5503-4D57-AD2B-642D0CA7C090@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On March 11, 2020 8:52:16 AM GMT+01:00, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>While running selftest binderfs_test on linux mainline the following
>warning on arm64, arm, x86_64 and i386.
>
>[  329.383391] refcount_t: underflow; use-after-free.
>[  329.391025] WARNING: CPU: 0 PID: 2604 at
>/usr/src/kernel/lib/refcount.c:28 refcount_warn_saturate+0xd4/0x150
>[  329.403319] Modules linked in: cls_bpf sch_fq algif_hash af_alg
>rfkill tda998x drm_kms_helper drm crct10dif_ce fuse
>[  329.413828] CPU: 0 PID: 2604 Comm: binderfs_test Not tainted
>5.6.0-rc5 #1
>[  329.420640] Hardware name: ARM Juno development board (r2) (DT)
>[  329.426584] pstate: 40000005 (nZcv daif -PAN -UAO)
>[  329.431402] pc : refcount_warn_saturate+0xd4/0x150
>[  329.436216] lr : refcount_warn_saturate+0xd4/0x150
>[  329.441026] sp : ffff800013d03a70
>[  329.444356] x29: ffff800013d03a70 x28: ffff00092c3f8000
>[  329.449694] x27: 0000000000000000 x26: ffff80001236f000
>[  329.455033] x25: ffff800012656000 x24: 0000000000000001
>[  329.460371] x23: ffff800012656f76 x22: ffff80001265b2c0
>[  329.465709] x21: ffff000929035c00 x20: ffff00095cd8ce00
>[  329.471048] x19: ffff80001261c848 x18: ffffffffffffffff
>[  329.476386] x17: 0000000000000000 x16: 0000000000000000
>[  329.481724] x15: ffff80001236fa88 x14: ffff800093d03767
>[  329.487062] x13: ffff800013d03775 x12: ffff80001239e000
>[  329.492400] x11: 0000000005f5e0ff x10: ffff800013d03700
>[  329.497738] x9 : ffff8000126ddc68 x8 : 0000000000000028
>[  329.503076] x7 : ffff800010190a5c x6 : ffff00097ef0b428
>[  329.508414] x5 : ffff00097ef0b428 x4 : ffff00092c3f8000
>[  329.513752] x3 : ffff800012370000 x2 : 0000000000000000
>[  329.519090] x1 : 295161095161e100 x0 : 0000000000000000
>[  329.524429] Call trace:
>[  329.526894]  refcount_warn_saturate+0xd4/0x150
>[  329.531362]  binderfs_evict_inode+0xcc/0xe8
>[  329.535567]  evict+0xa8/0x188
>[  329.538552]  iput+0x278/0x318
>[  329.541537]  dentry_unlink_inode+0x154/0x170
>[  329.545827]  __dentry_kill+0xc4/0x1d8
>[  329.549509]  shrink_dentry_list+0xf4/0x210
>[  329.553625]  shrink_dcache_parent+0x124/0x210
>[  329.558002]  do_one_tree+0x20/0x50
>[  329.561423]  shrink_dcache_for_umount+0x30/0x98
>[  329.565975]  generic_shutdown_super+0x2c/0xf8
>[  329.570354]  kill_anon_super+0x24/0x48
>[  329.574122]  kill_litter_super+0x2c/0x38
>[  329.578065]  binderfs_kill_super+0x24/0x48
>[  329.582182]  deactivate_locked_super+0x74/0xa0
>[  329.586647]  deactivate_super+0x8c/0x98
>[  329.590502]  cleanup_mnt+0xd8/0x130
>[  329.594008]  __cleanup_mnt+0x20/0x30
>[  329.597605]  task_work_run+0x90/0x150
>[  329.601287]  do_notify_resume+0x130/0x498
>[  329.605317]  work_pending+0x8/0x14
>[  329.608736] irq event stamp: 1612
>[  329.612072] hardirqs last  enabled at (1611): [<ffff800010190bf4>]
>console_unlock+0x514/0x5d8
>[  329.620631] hardirqs last disabled at (1612): [<ffff8000100a904c>]
>debug_exception_enter+0xac/0xe8
>[  329.629622] softirqs last  enabled at (1608): [<ffff8000100818bc>]
>__do_softirq+0x4c4/0x578
>[  329.638005] softirqs last disabled at (1561): [<ffff80001010b6ac>]
>irq_exit+0x144/0x150
>[  329.646035] ---[ end trace bac6584738d9306f ]---
>
>Metadata:
>---------------
>  git branch: master
>git repo:
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>  git describe: v5.6-rc5
>  kernel-config:
>http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkft/linux-mainline/2518/config
>
>Full test log,
>https://lkft.validation.linaro.org/scheduler/job/1273667#L6591
>https://lkft.validation.linaro.org/scheduler/job/1273569#L6222
>https://lkft.validation.linaro.org/scheduler/job/1273548#L6126
>https://lkft.validation.linaro.org/scheduler/job/1273596#L4687

Thanks, I'll take a look in a little bit.
