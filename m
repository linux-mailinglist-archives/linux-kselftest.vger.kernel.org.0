Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6454FF42
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 23:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiFQVR3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 17:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiFQVR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 17:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D994222BDC
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jun 2022 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655500646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRGM3eCM2TVyTh8eKkLCwBJv4tVgFarHtFdgBbpbMvw=;
        b=WE1a+M3ThheqWq81a0KbrmY6+JDp9qoDrU3SUobNplCmsUEhmJPQmv1AsQehDBzaWIwonY
        X4s5LXiOD4JpqHaz8pEhbe5uiMLhMonH5b1AgCIGma+cadFDi0UZw5fGKIwQ01wvcVRR0K
        vSyChlAB+VdmvlfJM4s2HtsY/OqFZ1A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-AKmPiZPkNTePDOE-39LfxA-1; Fri, 17 Jun 2022 17:17:25 -0400
X-MC-Unique: AKmPiZPkNTePDOE-39LfxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D623A802C17;
        Fri, 17 Jun 2022 21:17:24 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70EEF4010E4D;
        Fri, 17 Jun 2022 21:17:24 +0000 (UTC)
Date:   Fri, 17 Jun 2022 17:17:23 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com
Subject: Re: [PATCH 2/2] selftests: livepatch: Test livepatching a heavily
 called syscall
Message-ID: <YqzvY37fI0GzHoIH@redhat.com>
References: <20220603143242.870-1-mpdesouza@suse.com>
 <20220603143242.870-3-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603143242.870-3-mpdesouza@suse.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 03, 2022 at 11:32:42AM -0300, Marcos Paulo de Souza wrote:
> Syscalls are called a tricky way. Test that it is possible and works.

"Tricky" may be accurate, but short on details.  If the full story is
too much for the commit log, maybe just handwave about the
__SYSCALL_DEFINEx preprocessor wrappers, etc.  :)

> 
> This new test creates one userspace process per online cpu calling getpid
> continuously and tries to livepatch the getpid function.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  tools/testing/selftests/livepatch/Makefile    | 12 +++-
>  .../selftests/livepatch/test-syscall.sh       | 46 ++++++++++++++
>  .../test_binaries/test_klp-call_getpid.c      | 48 +++++++++++++++
>  .../selftests/livepatch/test_modules/Makefile |  3 +-
>  .../livepatch/test_modules/test_klp_syscall.c | 60 +++++++++++++++++++
>  5 files changed, 165 insertions(+), 4 deletions(-)
>  create mode 100755 tools/testing/selftests/livepatch/test-syscall.sh
>  create mode 100644 tools/testing/selftests/livepatch/test_binaries/test_klp-call_getpid.c
>  create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> 
> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> index 5ef492b87bb1..35014197184e 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -1,10 +1,14 @@
>  # SPDX-License-Identifier: GPL-2.0
> +include ../../../build/Build.include
> +include ../../../scripts/Makefile.arch
> +include ../../../scripts/Makefile.include
>  
>  TEST_FILES := settings \
>  		test_modules
>  
>  # We need the test_modules dir in order to make gen_tar and install to work
> -TEST_GEN_PROGS_EXTENDED := test_modules/test_klp_atomic_replace.ko \
> +TEST_GEN_PROGS_EXTENDED := test_binaries/test_klp-call_getpid \
> +			test_modules/test_klp_atomic_replace.ko \
>  			test_modules/test_klp_callbacks_busy.ko \
>  			test_modules/test_klp_callbacks_demo.ko \
>  			test_modules/test_klp_callbacks_demo2.ko \
> @@ -13,7 +17,8 @@ TEST_GEN_PROGS_EXTENDED := test_modules/test_klp_atomic_replace.ko \
>  			test_modules/test_klp_state.ko \
>  			test_modules/test_klp_state2.ko \
>  			test_modules/test_klp_state3.ko \
> -			test_modules/test_klp_shadow_vars.ko
> +			test_modules/test_klp_shadow_vars.ko \
> +			test_modules/test_klp_syscall.ko
>  
>  TEST_PROGS_EXTENDED := functions.sh
>  TEST_PROGS := \
> @@ -21,7 +26,8 @@ TEST_PROGS := \
>  	test-callbacks.sh \
>  	test-shadow-vars.sh \
>  	test-state.sh \
> -	test-ftrace.sh
> +	test-ftrace.sh \
> +	test-syscall.sh
>  
>  # override lib.mk's default rules
>  OVERRIDE_TARGETS := 1
> diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/testing/selftests/livepatch/test-syscall.sh
> new file mode 100755
> index 000000000000..f1d49e6ce2ee
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-syscall.sh
> @@ -0,0 +1,46 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE
> +# Author: Marcos Paulo de Souza <mpdesouza@suse.com>
> +
> +. $(dirname $0)/functions.sh
> +
> +MOD_SYSCALL=test_klp_syscall
> +
> +setup_config
> +
> +# - Start _NRPROC processes calling getpid and load a livepatch to patch the
> +#   getpid syscall
> +
> +start_test "patch getpid syscall while being heavily hammered"
> +
> +declare -a pids
> +for i in $(seq 1 $(getconf _NPROCESSORS_ONLN)); do
> +	./test_klp-call_getpid &
> +	pids[${#pids[*]}]="$!"
             ^^^^^^^^^^^
This looks fancy, would it be more approachable to use something like
this:

  for i in $(seq 0 $(( $(getconf _NPROCESSORS_ONLN) - 1 )) ); do
  	./test_klp-call_getpid &
  	pids[$i]="$!"
  done

or is there some strange race condition that requires using the method
in the patch?

> +done
> +
> +load_lp $MOD_SYSCALL
> +# Success, getpid syscall was livepatched

I don't think we need this comment as success is implied, otherwise
load_lp would have pulled the die() ripcord.

> +
> +for pid in ${pids[@]}; do
> +	kill $pid || true
> +done
> +
> +disable_lp $MOD_SYSCALL
> +unload_lp $MOD_SYSCALL
> +
> +check_result "% insmod test_modules/$MOD_SYSCALL.ko
> +livepatch: enabling patch '$MOD_SYSCALL'
> +livepatch: '$MOD_SYSCALL': initializing patching transition
> +livepatch: '$MOD_SYSCALL': starting patching transition
> +livepatch: '$MOD_SYSCALL': completing patching transition
> +livepatch: '$MOD_SYSCALL': patching complete
> +% echo 0 > /sys/kernel/livepatch/$MOD_SYSCALL/enabled
> +livepatch: '$MOD_SYSCALL': initializing unpatching transition
> +livepatch: '$MOD_SYSCALL': starting unpatching transition
> +livepatch: '$MOD_SYSCALL': completing unpatching transition
> +livepatch: '$MOD_SYSCALL': unpatching complete
> +% rmmod $MOD_SYSCALL"
> +
> +exit 0
> diff --git a/tools/testing/selftests/livepatch/test_binaries/test_klp-call_getpid.c b/tools/testing/selftests/livepatch/test_binaries/test_klp-call_getpid.c
> new file mode 100644
> index 000000000000..be9d3110687d
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test_binaries/test_klp-call_getpid.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 SUSE
> + * Author: Libor Pechacek <lpechacek@suse.cz>
> + */
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <signal.h>
> +
> +static int run = 1;
> +static int sig_int;
> +
> +void hup_handler(int signum)
> +{
> +	run = 0;
> +}
> +
> +void int_handler(int signum)
> +{
> +	run = 0;
> +	sig_int = 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	pid_t orig_pid, pid;
> +	long count = 0;
> +
> +	signal(SIGHUP, &hup_handler);
> +	signal(SIGINT, &int_handler);
> +
> +	orig_pid = syscall(SYS_getpid);
> +
> +	while(run) {

nit: could do s/run/stop/g and flip the assignment and check here so it
matches the sig_int flag, ie, 0 by default and 1 on HUP / INT.

> +		pid = syscall(SYS_getpid);
> +		if (pid != orig_pid)
> +			return 1;
> +		count++;
> +	}
> +
> +	if (sig_int)
> +		printf("%d iterations done\n", count);

nit: %ld for long

> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
> index 375180bc1b16..288c65ccd080 100644
> --- a/tools/testing/selftests/livepatch/test_modules/Makefile
> +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> @@ -15,7 +15,8 @@ obj-m += test_klp_atomic_replace.o \
>  	test_klp_state.o \
>  	test_klp_state2.o \
>  	test_klp_state3.o \
> -	test_klp_shadow_vars.o
> +	test_klp_shadow_vars.o \
> +	test_klp_syscall.o
>  
>  %.ko:
>  	make -C $(KDIR) M=$(TESTMODS_DIR) $@
> diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> new file mode 100644
> index 000000000000..e170accfb10c
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017-2022 SUSE
> + * Authors: Libor Pechacek <lpechacek@suse.cz>
> + *          Nicolai Stange <nstange@suse.de>
> + *          Marcos Paulo de Souza <mpdesouza@suse.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/livepatch.h>
> +
> +#if defined(__x86_64__)
> +#define FN_PREFIX __x64_
> +#elif defined(__s390x__)
> +#define FN_PREFIX __s390x_
> +#elif defined(__PPC64__)
> +#define FN_PREFIX __ppc64_
> +#else
> +#error "livepatch not supported"

What about 32-bit powerpc [1]?  Would this cause the selftests to fail
on that hardware?

[1] https://lore.kernel.org/live-patching/cover.1640017960.git.christophe.leroy@csgroup.eu/

> +#endif
> +
> +asmlinkage long lp_sys_getpid(void)
> +{
> +	return task_tgid_vnr(current);
> +}
> +
> +static struct klp_func vmlinux_funcs[] = {
> +	{
> +		.old_name = __stringify(FN_PREFIX) "sys_getpid",
> +		.new_func = lp_sys_getpid,
> +	}, {}
> +};
> +
> +static struct klp_object objs[] = {
> +	{
> +		/* name being NULL means vmlinux */
> +		.funcs = vmlinux_funcs,
> +	}, {}
> +};
> +
> +static struct klp_patch patch = {
> +	.mod = THIS_MODULE,
> +	.objs = objs,
> +};
> +
> +static int livepatch_init(void)
> +{
> +	return klp_enable_patch(&patch);
> +}
> +
> +static void livepatch_exit(void)
> +{
> +}
> +
> +module_init(livepatch_init);
> +module_exit(livepatch_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_INFO(livepatch, "Y");
> -- 
> 2.35.3
>

Hi Marcos,

A few comments and small nits found inline above.

First, the test is pretty straightforward and a reasonable one to run,
particularly putting the system under some load while patching.

What do you think about the following tweaks:

test_klp_syscall:
- only calls the new syscall behavior for a list of known PIDs
- PID list supplied via module parameter
- when calling new syscall, PID is removed from list,
  PIDs-left-to-patch counter (exposed to sysfs) decremented

test-syscall.sh:
- loads test_klp_syscall with test_klp-call_getpid PIDs that it spawned
- before killing the test_klp-call_getpid PIDs, checks that
  test_klp_syscall's sysfs PIDs-left-to-patch counter == 0

I think this would ensure a few things:

  1. Restrict the getpid syscall change to only callers expecting new
     behavior
  2. Force test_klp_syscall to patch each test_klp-call_getpid
  3. Force all test_klp-call_getpid to hang around long enough for (2)

Maybe this is too defensive, but I think could be handled without adding
too much complexity.

Regards,

--
Joe 

