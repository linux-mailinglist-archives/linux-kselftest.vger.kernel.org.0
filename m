Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E769571D6A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGLO4W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 10:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGLO4U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 10:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5C3D4505D
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657637777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iu64qhMIeKDXTdMAS93ylmecC/7IfFjldR7drgxjKiE=;
        b=N5N72SMMnq8bRpye+XeGGDbQchYhxKteKDLqsAJbVJd/lMX35wW3C0nPLH9dDkSkbyz/CU
        ZBCrPvM88/wjGuOPLson6S+EEoHqPTanVZ1KrS/7/mCZa1ScNlb+UeNUPbBe0FkIa6DeRu
        UsQU3vyQJ4x8uF3k+AbQVAGLWJ3hu9M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-WiEk7N8NNo6UTtNmBSS9hQ-1; Tue, 12 Jul 2022 10:56:14 -0400
X-MC-Unique: WiEk7N8NNo6UTtNmBSS9hQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D25DB2806AB9;
        Tue, 12 Jul 2022 14:56:13 +0000 (UTC)
Received: from redhat.com (unknown [10.22.32.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DBFE2166B26;
        Tue, 12 Jul 2022 14:56:13 +0000 (UTC)
Date:   Tue, 12 Jul 2022 10:56:11 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com
Subject: Re: [PATCH v2 2/2] selftests: livepatch: Test livepatching a heavily
 called syscall
Message-ID: <Ys2Li9ilYtpmJhN3@redhat.com>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <20220630141226.2802-3-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630141226.2802-3-mpdesouza@suse.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 30, 2022 at 11:12:26AM -0300, Marcos Paulo de Souza wrote:
> Syscalls are called a tricky way. Some architectures add a prefix to the
> syscall name (SYSCALL_WRAPPER).
> 
> This new test creates one userspace process per online cpu calling getpid
> continuously and tries to livepatch the getpid function. Add the correct
> function prefix for all archs that select HAS_SYSCALL_WRAPPER.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Hi Marcos,

Thanks for working on this and sorry for the delayed reply.  I gave it a
spin yesterday and have a few comments below...

> ---
>  tools/testing/selftests/livepatch/Makefile    |  12 +-
>  .../selftests/livepatch/test-syscall.sh       |  52 ++++++
>  .../test_binaries/test_klp-call_getpid.c      |  48 ++++++
>  .../selftests/livepatch/test_modules/Makefile |   3 +-
>  .../livepatch/test_modules/test_klp_syscall.c | 150 ++++++++++++++++++
>  5 files changed, 261 insertions(+), 4 deletions(-)
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

Before I commit this to muscle memory, would "test_programs" better
describe this directory?  When I see "binaries", I think of source vs.
build and not kernel vs. userspace.

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
> index 000000000000..fb3270de7f1f
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-syscall.sh
> @@ -0,0 +1,52 @@
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
> +for i in $(seq 0 $(( $(getconf _NPROCESSORS_ONLN) -1)) ); do
> +	./test_binaries/test_klp-call_getpid &
> +	pids[$i]="$!"
> +done

On second thought, bash should only iterate through the elements that
are defined, so your earlier version is probably better:

  for i in $(seq 1 $(getconf _NPROCESSORS_ONLN)); do

> +
> +pid_list=$(echo ${pids[@]} | tr ' ' ',')
> +load_lp $MOD_SYSCALL klp_pids=$pid_list
> +

We could wait for all test_klp-call_getpid instances to execute the
livepatch code:

  loop_until 'grep -q '^0$' /sys/kernel/test_klp_syscall/npids'

This has a built in timeout, so it's not infinitely looping.  You
could add some die "reason" logic here, or just let the existing code
cleanup after the failed test.

> +pending_pids=$(cat /sys/kernel/test_klp_syscall/npids)
> +
> +for pid in ${pids[@]}; do
> +	kill $pid || true
> +done
> +
> +disable_lp $MOD_SYSCALL
> +unload_lp $MOD_SYSCALL
> +
> +if [[ "$pending_pids" != "0" ]]; then
> +	echo -e "FAIL\n\n"
> +	die "processes not livepatched: $pending_pids"
> +fi
> +
> +check_result "% insmod test_modules/$MOD_SYSCALL.ko klp_pids=$pid_list
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
> index 000000000000..ec470660dee6
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
> +static int stop = 0;

nit: no need to init global to 0

> +static int sig_int;
> +
> +void hup_handler(int signum)
> +{
> +	stop = 1;
> +}
> +
> +void int_handler(int signum)
> +{
> +	stop = 1;
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
> +	while (!stop) {
> +		pid = syscall(SYS_getpid);
> +		if (pid != orig_pid)
> +			return 1;

This test doesn't care about the user program return code, but I wonder
if the status should be flipped -- this is the desired code path, not
the one at the end of main(), right?

> +		count++;
> +	}
> +
> +	if (sig_int)
> +		printf("%ld iterations done\n", count);
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
> index 1eab43b741cd..ebb754accf46 100644
> --- a/tools/testing/selftests/livepatch/test_modules/Makefile
> +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> @@ -10,7 +10,8 @@ obj-m += test_klp_atomic_replace.o \
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
> index 000000000000..e90f4ac8e7a4
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> @@ -0,0 +1,150 @@
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
> +#include <linux/slab.h>
> +#include <linux/livepatch.h>
> +
> +#if defined(__x86_64__)
> +#define FN_PREFIX __x64_
> +#elif defined(__s390x__)
> +#define FN_PREFIX __s390x_
> +#elif defined(__aarch64__)
> +#define FN_PREFIX __arm64_
> +#else
> +/* powerpc does not select ARCH_HAS_SYSCALL_WRAPPER */
> +#define FN_PREFIX
> +#endif
> +
> +struct klp_pid_t {
> +	pid_t pid;
> +	struct list_head list;
> +};
> +static LIST_HEAD(klp_pid_list);
> +
> +/* Protects klp_pid_list */
> +static DEFINE_MUTEX(kpid_mutex);
> +
> +static int klp_pids[NR_CPUS];
> +static unsigned int npids;
> +module_param_array(klp_pids, int, &npids, 0);
> +
> +static ssize_t npids_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			  char *buf)
> +{
> +	return sprintf(buf, "%u\n", npids);
> +}
> +
> +static struct kobj_attribute klp_attr = __ATTR_RO(npids);
> +static struct kobject *klp_kobj;
> +
> +static void free_klp_pid_list(void)
> +{
> +	struct klp_pid_t *kpid, *temp;
> +
> +	mutex_lock(&kpid_mutex);
> +	list_for_each_entry_safe(kpid, temp, &klp_pid_list, list) {
> +		list_del(&kpid->list);
> +		kfree(kpid);
> +	}
> +	mutex_unlock(&kpid_mutex);
> +}
> +
> +asmlinkage long lp_sys_getpid(void)
> +{
> +	struct klp_pid_t *kpid, *temp;
> +
> +	/*
> +	 * For each thread calling getpid, check if the pid exists in
> +	 * klp_pid_list. If yes, decrement the npids variable and remove the pid
> +	 * from the list. npids will be later used to ensure that all pids
> +	 * transitioned to the liveaptched state.

I go back and forth with this comment: 1) the code is pretty
self-explanatory and 2) it explains what test-syscall.sh is doing with
npids

Describing the behavioral difference I suggest below would be helpful
(if you agree w/the change).  Something about removing the current pid
from the list, okay, too.

Then as far as describing npids' purpose, I'd put that up at the top of
the file where npids is defined.  It can be as generic as describing
what it's counting.

> +	 */
> +	mutex_lock(&kpid_mutex);
> +	list_for_each_entry_safe(kpid, temp, &klp_pid_list, list) {
> +		if (current->pid == kpid->pid) {
> +			list_del(&kpid->list);
> +			kfree(kpid);
> +			npids--;
> +			break;

I think it would be safer to return task_tgid_vnr() here, but ...

> +		}
> +	}
> +	mutex_unlock(&kpid_mutex);
> +
> +	return task_tgid_vnr(current);

task_pid_vnr() here.  That way we're only changing behavior for the
processes in the list and not all programs across the system.

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
> +	int ret;
> +	struct klp_pid_t *kpid;
> +
> +	if (npids > 0) {
> +		int i;
> +
> +		for (i = 0; i < npids; i++) {
> +			kpid = kmalloc(sizeof(struct klp_pid_t), GFP_KERNEL);
> +			if (!kpid)
> +				goto err_mem;
> +
> +			kpid->pid = klp_pids[i];
> +			list_add(&kpid->list, &klp_pid_list);
> +		}
> +	}
> +
> +	klp_kobj = kobject_create_and_add("test_klp_syscall", kernel_kobj);
> +	if (!klp_kobj)
> +		goto err_mem;
> +
> +	ret = sysfs_create_file(klp_kobj, &klp_attr.attr);
> +	if (ret) {
> +		kobject_put(klp_kobj);
> +		goto out_klp_pid_list;
> +	}
> +
> +	return klp_enable_patch(&patch);
> +
> +err_mem:
> +	ret = -ENOMEM;
> +out_klp_pid_list:
> +	free_klp_pid_list();
> +
> +	return ret;
> +}
> +
> +static void livepatch_exit(void)
> +{
> +	free_klp_pid_list();
> +	kobject_put(klp_kobj);
> +}
> +
> +module_init(livepatch_init);
> +module_exit(livepatch_exit);
> +MODULE_LICENSE("GPL");
> +MODULE_INFO(livepatch, "Y");

The linked list code looks like it should work and cleans up properly,
but if the current test is the extent of what we need, it would be
simpler to directly use klp_pids[] to track progress: since we're never
going to livepatch pid 0, we could just search klp_pids[] for our pid
and then zero it out once we've executed the livepatch code.

This would let us drop out the kmalloc and list management code (looks
to be nearly 25% of the file at this point).  I think the kpid_mutex
still needs to stay though.  Iterating through the fixed array shouldn't
be too much more expensive than through the (shrinking) klp_pid_list.

On the other hand, if you think that we'll need to adapt this module to
handle a dynamically changing list of klp_pids[], then perhaps a
separate list is the way to go.

Final note, kbuild is probably my weakest area, so I'm of limited help
review-wise there.  In trying out the code, I wasn't sure exactly how to
run things.  I did:

  $ make -C tools/testing/selftests/livepatch/ run_tests

and that built everything and ran the tests (good).  I changed a few .c
files and tried again, but they didn't rebuild.  Then from
tools/testing/selftests/livepatch/test_modules/ I ran `make` and it only
ran the clean target (not good, I think).

What is the typical workflow supposed to be in this combined setup?

Thanks,

--
Joe

