Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15A933FE1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 05:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCREKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 00:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhCREKH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 00:10:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA6BC06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 21:10:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g15so2582667pfq.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Mar 2021 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v0FMiRP2ep+y/7iHbFg4j6pdz1i8NddTStWhM1r5FlE=;
        b=LUwT0JdLyskrtEhbtVVjzxbaFMS3wgwkqmhazE2U5tk+bSfpxRox6SBSAHLUIM1XeA
         ZtLim4S6h0SwXx1n4dIrZL1qZOHHCZLMCJPXP4NeNDtdIhrp6aX2fLipdMsn4I4KPOCg
         73Yz47V/KK5Q8zw/E/CUc1YYPLO0l7CmdlrrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v0FMiRP2ep+y/7iHbFg4j6pdz1i8NddTStWhM1r5FlE=;
        b=FNBgBF3V8YL2x5cNwRdZNCnbXiLvuBXhrk+YtqlVTimvVkXtYDyCyXdHdK1H++MAEL
         XbK9J2IDi0hEtoPMP1dwlhxNZ4r22Tfl/DCPrpVOUC8T896Azo5wFMi7ZjHsZZBC0bBH
         JerRzCSnbrCXrRUrGMzRY2tNUZVTQmxDCKEj6Q7Qa5+4wrQkybgvJ+EvbDLmwjEglH2r
         DIz2Nk5rfds2L4fbrlU1o7MXu66H+WqG9cQJC2o5j6EjEKU8tT/19R37I9Sit/3Lf8jz
         X+gR6SlekG8Im+DWQy9Bqmp2gj7C99rULLHTFKrhpdDYh1iUepsT2f7r3PP91kVm8G6H
         LyvQ==
X-Gm-Message-State: AOAM531gmnZXzCEplEWr+4LBf1eJqB4qAnfCaoIkf80vJU+XAFTFeGFu
        hZxq2K+vWC6A7H/9Kd5xP6OpcA==
X-Google-Smtp-Source: ABdhPJyaHrqhomJOREpOHLzZy7zkHyXD/ORaLyGKBMZite/h+zlNaTs9KB+BJ3/miX7NofK3ZvP7Jw==
X-Received: by 2002:a63:484b:: with SMTP id x11mr5343791pgk.2.1616040606977;
        Wed, 17 Mar 2021 21:10:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p3sm495481pgl.88.2021.03.17.21.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 21:10:06 -0700 (PDT)
Date:   Wed, 17 Mar 2021 21:10:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     Jann Horn <jannh@google.com>, Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <202103172108.404F9B6ED2@keescook>
References: <20210307113031.11671-1-john.wood@gmx.com>
 <20210307113031.11671-8-john.wood@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307113031.11671-8-john.wood@gmx.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Mar 07, 2021 at 12:30:30PM +0100, John Wood wrote:
> Add some info detailing what is the Brute LSM, its motivation, weak
> points of existing implementations, proposed solutions, enabling,
> disabling and self-tests.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  Documentation/admin-guide/LSM/Brute.rst | 278 ++++++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst |   1 +
>  security/brute/Kconfig                  |   3 +-
>  3 files changed, 281 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/LSM/Brute.rst
> 
> diff --git a/Documentation/admin-guide/LSM/Brute.rst b/Documentation/admin-guide/LSM/Brute.rst
> new file mode 100644
> index 000000000000..ca80aef9aa67
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/Brute.rst
> @@ -0,0 +1,278 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +===========================================================
> +Brute: Fork brute force attack detection and mitigation LSM
> +===========================================================
> +
> +Attacks against vulnerable userspace applications with the purpose to break ASLR
> +or bypass canaries traditionally use some level of brute force with the help of
> +the fork system call. This is possible since when creating a new process using
> +fork its memory contents are the same as those of the parent process (the
> +process that called the fork system call). So, the attacker can test the memory
> +infinite times to find the correct memory values or the correct memory addresses
> +without worrying about crashing the application.
> +
> +Based on the above scenario it would be nice to have this detected and
> +mitigated, and this is the goal of this implementation. Specifically the
> +following attacks are expected to be detected:
> +
> +1.- Launching (fork()/exec()) a setuid/setgid process repeatedly until a
> +    desirable memory layout is got (e.g. Stack Clash).
> +2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly until a
> +    desirable memory layout is got (e.g. what CTFs do for simple network
> +    service).
> +3.- Launching processes without exec() (e.g. Android Zygote) and exposing state
> +    to attack a sibling.
> +4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly until the
> +    previously shared memory layout of all the other children is exposed (e.g.
> +    kind of related to HeartBleed).
> +
> +In each case, a privilege boundary has been crossed:
> +
> +Case 1: setuid/setgid process
> +Case 2: network to local
> +Case 3: privilege changes
> +Case 4: network to local
> +
> +So, what really needs to be detected are fork/exec brute force attacks that
> +cross any of the commented bounds.
> +
> +
> +Other implementations
> +=====================
> +
> +The public version of grsecurity, as a summary, is based on the idea of delaying
> +the fork system call if a child died due to some fatal signal (SIGSEGV, SIGBUS,
> +SIGKILL or SIGILL). This has some issues:
> +
> +Bad practices
> +-------------
> +
> +Adding delays to the kernel is, in general, a bad idea.
> +
> +Scenarios not detected (false negatives)
> +----------------------------------------
> +
> +This protection acts only when the fork system call is called after a child has
> +crashed. So, it would still be possible for an attacker to fork a big amount of
> +children (in the order of thousands), then probe all of them, and finally wait
> +the protection time before repeating the steps.
> +
> +Moreover, this method is based on the idea that the protection doesn't act if
> +the parent crashes. So, it would still be possible for an attacker to fork a
> +process and probe itself. Then, fork the child process and probe itself again.
> +This way, these steps can be repeated infinite times without any mitigation.
> +
> +Scenarios detected (false positives)
> +------------------------------------
> +
> +Scenarios where an application rarely fails for reasons unrelated to a real
> +attack.
> +
> +
> +This implementation
> +===================
> +
> +The main idea behind this implementation is to improve the existing ones
> +focusing on the weak points annotated before. Basically, the adopted solution is
> +to detect a fast crash rate instead of only one simple crash and to detect both
> +the crash of parent and child processes. Also, fine tune the detection focusing
> +on privilege boundary crossing. And finally, as a mitigation method, kill all
> +the offending tasks involved in the attack instead of using delays.
> +
> +To achieve this goal, and going into more details, this implementation is based
> +on the use of some statistical data shared across all the processes that can
> +have the same memory contents. Or in other words, a statistical data shared
> +between all the fork hierarchy processes after an execve system call.
> +
> +The purpose of these statistics is, basically, collect all the necessary info
> +to compute the application crash period in order to detect an attack. This crash
> +period is the time between the execve system call and the first fault or the
> +time between two consecutive faults, but this has a drawback. If an application
> +crashes twice in a short period of time for some reason unrelated to a real
> +attack, a false positive will be triggered. To avoid this scenario the
> +exponential moving average (EMA) is used. This way, the application crash period
> +will be a value that is not prone to change due to spurious data and follows the
> +real crash period.
> +
> +To detect a brute force attack it is necessary that the statistics shared by all
> +the fork hierarchy processes be updated in every fatal crash and the most
> +important data to update is the application crash period.
> +
> +These statistics are hold by the brute_stats struct.
> +
> +struct brute_cred {
> +	kuid_t uid;
> +	kgid_t gid;
> +	kuid_t suid;
> +	kgid_t sgid;
> +	kuid_t euid;
> +	kgid_t egid;
> +	kuid_t fsuid;
> +	kgid_t fsgid;
> +};
> +
> +struct brute_stats {
> +	spinlock_t lock;
> +	refcount_t refc;
> +	unsigned char faults;
> +	u64 jiffies;
> +	u64 period;
> +	struct brute_cred saved_cred;
> +	unsigned char network : 1;
> +	unsigned char bounds_crossed : 1;
> +};

Instead of open-coding this, just use the kerndoc references you've
already built in the .c files:

.. kernel-doc:: security/brute/brute.c

> +
> +This is a fixed sized struct, so the memory usage will be based on the current
> +number of processes exec()ing. The previous sentence is true since in every fork
> +system call the parent's statistics are shared with the child process and in
> +every execve system call a new brute_stats struct is allocated. So, only one
> +brute_stats struct is used for every fork hierarchy (hierarchy of processes from
> +the execve system call).
> +
> +There are two types of brute force attacks that need to be detected. The first
> +one is an attack that happens through the fork system call and the second one is
> +an attack that happens through the execve system call. The first type uses the
> +statistics shared by all the fork hierarchy processes, but the second type
> +cannot use this statistical data due to these statistics dissapear when the
> +involved tasks finished. In this last scenario the attack info should be tracked
> +by the statistics of a higher fork hierarchy (the hierarchy that contains the
> +process that forks before the execve system call).
> +
> +Moreover, these two attack types have two variants. A slow brute force attack
> +that is detected if a maximum number of faults per fork hierarchy is reached and
> +a fast brute force attack that is detected if the application crash period falls
> +below a certain threshold.
> +
> +Once an attack has been detected, this is mitigated killing all the offending
> +tasks involved. Or in other words, once an attack has been detected, this is
> +mitigated killing all the processes that share the same statistics (the stats
> +that show an slow or fast brute force attack).
> +
> +Fine tuning the attack detection
> +--------------------------------
> +
> +To avoid false positives during the attack detection it is necessary to narrow
> +the possible cases. To do so, and based on the threat scenarios that we want to
> +detect, this implementation also focuses on the crossing of privilege bounds.
> +
> +To be precise, only the following privilege bounds are taken into account:
> +
> +1.- setuid/setgid process
> +2.- network to local
> +3.- privilege changes
> +
> +Moreover, only the fatal signals delivered by the kernel are taken into account
> +avoiding the fatal signals sent by userspace applications (with the exception of
> +the SIGABRT user signal since this is used by glibc for stack canary, malloc,
> +etc. failures, which may indicate that a mitigation has been triggered).
> +
> +Exponential moving average (EMA)
> +--------------------------------
> +
> +This kind of average defines a weight (between 0 and 1) for the new value to add
> +and applies the remainder of the weight to the current average value. This way,
> +some spurious data will not excessively modify the average and only if the new
> +values are persistent, the moving average will tend towards them.
> +
> +Mathematically the application crash period's EMA can be expressed as follows:
> +
> +period_ema = period * weight + period_ema * (1 - weight)
> +
> +Related to the attack detection, the EMA must guarantee that not many crashes
> +are needed. To demonstrate this, the scenario where an application has been
> +running without any crashes for a month will be used.
> +
> +The period's EMA can be written now as:
> +
> +period_ema[i] = period[i] * weight + period_ema[i - 1] * (1 - weight)
> +
> +If the new crash periods have insignificant values related to the first crash
> +period (a month in this case), the formula can be rewritten as:
> +
> +period_ema[i] = period_ema[i - 1] * (1 - weight)
> +
> +And by extension:
> +
> +period_ema[i - 1] = period_ema[i - 2] * (1 - weight)
> +period_ema[i - 2] = period_ema[i - 3] * (1 - weight)
> +period_ema[i - 3] = period_ema[i - 4] * (1 - weight)
> +
> +So, if the substitution is made:
> +
> +period_ema[i] = period_ema[i - 1] * (1 - weight)
> +period_ema[i] = period_ema[i - 2] * pow((1 - weight) , 2)
> +period_ema[i] = period_ema[i - 3] * pow((1 - weight) , 3)
> +period_ema[i] = period_ema[i - 4] * pow((1 - weight) , 4)
> +
> +And in a more generic form:
> +
> +period_ema[i] = period_ema[i - n] * pow((1 - weight) , n)
> +
> +Where n represents the number of iterations to obtain an EMA value. Or in other
> +words, the number of crashes to detect an attack.
> +
> +So, if we isolate the number of crashes:
> +
> +period_ema[i] / period_ema[i - n] = pow((1 - weight), n)
> +log(period_ema[i] / period_ema[i - n]) = log(pow((1 - weight), n))
> +log(period_ema[i] / period_ema[i - n]) = n * log(1 - weight)
> +n = log(period_ema[i] / period_ema[i - n]) / log(1 - weight)
> +
> +Then, in the commented scenario (an application has been running without any
> +crashes for a month), the approximate number of crashes to detect an attack
> +(using the implementation values for the weight and the crash period threshold)
> +is:
> +
> +weight = 7 / 10
> +crash_period_threshold = 30 seconds
> +
> +n = log(crash_period_threshold / seconds_per_month) / log(1 - weight)
> +n = log(30 / (30 * 24 * 3600)) / log(1 - 0.7)
> +n = 9.44
> +
> +So, with 10 crashes for this scenario an attack will be detected. If these steps
> +are repeated for different scenarios and the results are collected:
> +
> +1 month without any crashes ----> 9.44 crashes to detect an attack
> +1 year without any crashes -----> 11.50 crashes to detect an attack
> +10 years without any crashes ---> 13.42 crashes to detect an attack
> +
> +However, this computation has a drawback. The first data added to the EMA not
> +obtains a real average showing a trend. So the solution is simple, the EMA needs
> +a minimum number of data to be able to be interpreted. This way, the case where
> +a few first faults are fast enough followed by no crashes is avoided.
> +
> +Per system enabling/disabling
> +-----------------------------
> +
> +This feature can be enabled at build time using the CONFIG_SECURITY_FORK_BRUTE
> +option or using the visual config application under the following menu:
> +
> +Security options  --->  Fork brute force attack detection and mitigation
> +
> +Also, at boot time, this feature can be disable too, by changing the "lsm=" boot
> +parameter.
> +
> +Kernel selftests
> +----------------
> +
> +To validate all the expectations about this implementation, there is a set of
> +selftests. This tests cover fork/exec brute force attacks crossing the following
> +privilege boundaries:
> +
> +1.- setuid process
> +2.- privilege changes
> +3.- network to local
> +
> +Also, there are some tests to check that fork/exec brute force attacks without
> +crossing any privilege boundariy already commented doesn't trigger the detection
> +and mitigation stage.
> +
> +To build the tests:
> +make -C tools/testing/selftests/ TARGETS=brute
> +
> +To run the tests:
> +make -C tools/testing/selftests TARGETS=brute run_tests
> +
> +To package the tests:
> +make -C tools/testing/selftests TARGETS=brute gen_tar
> diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
> index a6ba95fbaa9f..1f68982bb330 100644
> --- a/Documentation/admin-guide/LSM/index.rst
> +++ b/Documentation/admin-guide/LSM/index.rst
> @@ -41,6 +41,7 @@ subdirectories.
>     :maxdepth: 1
> 
>     apparmor
> +   Brute
>     LoadPin
>     SELinux
>     Smack
> diff --git a/security/brute/Kconfig b/security/brute/Kconfig
> index 1bd2df1e2dec..334d7e88d27f 100644
> --- a/security/brute/Kconfig
> +++ b/security/brute/Kconfig
> @@ -7,6 +7,7 @@ config SECURITY_FORK_BRUTE
>  	  vulnerable userspace processes. The detection method is based on
>  	  the application crash period and as a mitigation procedure all the
>  	  offending tasks are killed. Like capabilities, this security module
> -	  stacks with other LSMs.
> +	  stacks with other LSMs. Further information can be found in
> +	  Documentation/admin-guide/LSM/Brute.rst.
> 
>  	  If you are unsure how to answer this question, answer N.
> --
> 2.25.1
> 

-- 
Kees Cook
