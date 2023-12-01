Return-Path: <linux-kselftest+bounces-961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA1800B80
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 14:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8701C20BE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650FB25767;
	Fri,  1 Dec 2023 13:13:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC0D10F8;
	Fri,  1 Dec 2023 05:13:16 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9590C1FD70;
	Fri,  1 Dec 2023 13:13:13 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18EF31369E;
	Fri,  1 Dec 2023 13:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AWyXM+jbaWW5GAAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Fri, 01 Dec 2023 13:13:12 +0000
Date: Fri, 1 Dec 2023 10:13:10 -0300
From: Marcos Paulo de Souza <mpdesouza@suse.de>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
	Joe Lawrence <joe.lawrence@redhat.com>, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests: livepatch: Test livepatching a heavily
 called syscall
Message-ID: <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
 <20231031-send-lp-kselftests-v3-3-2b1655c2605f@suse.com>
 <f9d82fa6-08d7-4ab6-badc-691987b37a82@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d82fa6-08d7-4ab6-badc-691987b37a82@linuxfoundation.org>
X-Spamd-Bar: /
X-Spam-Level: 
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	spf=fail (smtp-out2.suse.de: domain of mpdesouza@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mpdesouza@suse.com;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 9590C1FD70
X-Spam-Score: 0.84
X-Spamd-Result: default: False [0.84 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 NEURAL_HAM_LONG(-0.07)[-0.068];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.18)[-0.892];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FORGED_SENDER(0.30)[mpdesouza@suse.de,mpdesouza@suse.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FROM_NEQ_ENVFROM(0.10)[mpdesouza@suse.de,mpdesouza@suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]

On Thu, Nov 30, 2023 at 04:24:26PM -0700, Shuah Khan wrote:
> On 10/31/23 15:10, Marcos Paulo de Souza wrote:
> > The test proves that a syscall can be livepatched. It is interesting
> > because syscalls are called a tricky way. Also the process gets
> > livepatched either when sleeping in the userspace or when entering
> > or leaving the kernel space.
> > 
> > The livepatch is a bit tricky:
> >    1. The syscall function name is architecture specific. Also
> >       ARCH_HAS_SYSCALL_WRAPPER must be taken in account.
> > 
> >    2. The syscall must stay working the same way for other processes
> >       on the system. It is solved by decrementing a counter only
> >       for PIDs of the test processes. It means that the test processes
> >       has to call the livepatched syscall at least once.
> > 
> > The test creates one userspace process per online cpu. The processes
> > are calling getpid in a busy loop. The intention is to create random
> > locations when the livepatch gets enabled. Nothing is guarantted.
> > The magic is in the randomness.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >   tools/testing/selftests/livepatch/Makefile         |   4 +-
> >   tools/testing/selftests/livepatch/test-syscall.sh  |  53 ++++++++++
> >   .../selftests/livepatch/test_klp-call_getpid.c     |  44 ++++++++
> >   .../selftests/livepatch/test_modules/Makefile      |   3 +-
> >   .../livepatch/test_modules/test_klp_syscall.c      | 116 +++++++++++++++++++++
> >   5 files changed, 218 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> > index 119e2bbebe5d..35418a4790be 100644
> > --- a/tools/testing/selftests/livepatch/Makefile
> > +++ b/tools/testing/selftests/livepatch/Makefile
> > @@ -1,5 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0
> > +TEST_GEN_FILES := test_klp-call_getpid
> >   TEST_GEN_MODS_DIR := test_modules
> >   TEST_PROGS_EXTENDED := functions.sh
> >   TEST_PROGS := \
> > @@ -8,7 +9,8 @@ TEST_PROGS := \
> >   	test-shadow-vars.sh \
> >   	test-state.sh \
> >   	test-ftrace.sh \
> > -	test-sysfs.sh
> > +	test-sysfs.sh \
> > +	test-syscall.sh
> >   TEST_FILES := settings
> > diff --git a/tools/testing/selftests/livepatch/test-syscall.sh b/tools/testing/selftests/livepatch/test-syscall.sh
> > new file mode 100755
> > index 000000000000..b76a881d4013
> > --- /dev/null
> > +++ b/tools/testing/selftests/livepatch/test-syscall.sh
> > @@ -0,0 +1,53 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2023 SUSE
> > +# Author: Marcos Paulo de Souza <mpdesouza@suse.com>
> > +
> > +. $(dirname $0)/functions.sh
> > +
> > +MOD_SYSCALL=test_klp_syscall
> > +
> > +setup_config
> > +
> > +# - Start _NRPROC processes calling getpid and load a livepatch to patch the
> > +#   getpid syscall. Check if all the processes transitioned to the livepatched
> > +#   state.
> > +
> > +start_test "patch getpid syscall while being heavily hammered"
> > +
> > +for i in $(seq 1 $(getconf _NPROCESSORS_ONLN)); do
> > +	./test_klp-call_getpid &
> > +	pids[$i]="$!"
> > +done
> > +
> > +pid_list=$(echo ${pids[@]} | tr ' ' ',')
> > +load_lp $MOD_SYSCALL klp_pids=$pid_list
> > +
> > +# wait for all tasks to transition to patched state
> > +loop_until 'grep -q '^0$' /sys/kernel/test_klp_syscall/npids'
> > +
> > +pending_pids=$(cat /sys/kernel/test_klp_syscall/npids)
> > +log "$MOD_SYSCALL: Remaining not livepatched processes: $pending_pids"
> > +
> > +for pid in ${pids[@]}; do
> > +	kill $pid || true
> > +done
> > +
> > +disable_lp $MOD_SYSCALL
> > +unload_lp $MOD_SYSCALL
> > +
> > +check_result "% insmod test_modules/$MOD_SYSCALL.ko klp_pids=$pid_list
> > +livepatch: enabling patch '$MOD_SYSCALL'
> > +livepatch: '$MOD_SYSCALL': initializing patching transition
> > +livepatch: '$MOD_SYSCALL': starting patching transition
> > +livepatch: '$MOD_SYSCALL': completing patching transition
> > +livepatch: '$MOD_SYSCALL': patching complete
> > +$MOD_SYSCALL: Remaining not livepatched processes: 0
> > +% echo 0 > /sys/kernel/livepatch/$MOD_SYSCALL/enabled
> > +livepatch: '$MOD_SYSCALL': initializing unpatching transition
> > +livepatch: '$MOD_SYSCALL': starting unpatching transition
> > +livepatch: '$MOD_SYSCALL': completing unpatching transition
> > +livepatch: '$MOD_SYSCALL': unpatching complete
> > +% rmmod $MOD_SYSCALL"
> > +
> > +exit 0
> > diff --git a/tools/testing/selftests/livepatch/test_klp-call_getpid.c b/tools/testing/selftests/livepatch/test_klp-call_getpid.c
> > new file mode 100644
> > index 000000000000..ce321a2d7308
> > --- /dev/null
> > +++ b/tools/testing/selftests/livepatch/test_klp-call_getpid.c
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 SUSE
> > + * Authors: Libor Pechacek <lpechacek@suse.cz>
> > + *          Marcos Paulo de Souza <mpdesouza@suse.com>
> > + */
> > +
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <sys/syscall.h>
> > +#include <sys/types.h>
> > +#include <signal.h>
> > +
> > +static int stop;
> > +static int sig_int;
> > +
> > +void hup_handler(int signum)
> > +{
> > +	stop = 1;
> > +}
> > +
> > +void int_handler(int signum)
> > +{
> > +	stop = 1;
> > +	sig_int = 1;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	long count = 0;
> > +
> > +	signal(SIGHUP, &hup_handler);
> > +	signal(SIGINT, &int_handler);
> > +
> > +	while (!stop) {
> > +		(void)syscall(SYS_getpid);
> > +		count++;
> > +	}
> > +
> > +	if (sig_int)
> > +		printf("%ld iterations done\n", count);
> > +
> > +	return 0;
> > +}
> > diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
> > index 6f7c2103d27d..f5e880269bff 100644
> > --- a/tools/testing/selftests/livepatch/test_modules/Makefile
> > +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> > @@ -10,7 +10,8 @@ obj-m += test_klp_atomic_replace.o \
> >   	test_klp_state.o \
> >   	test_klp_state2.o \
> >   	test_klp_state3.o \
> > -	test_klp_shadow_vars.o
> > +	test_klp_shadow_vars.o \
> > +	test_klp_syscall.o
> >   modules:
> >   	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
> > diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> > new file mode 100644
> > index 000000000000..619496cc3481
> > --- /dev/null
> > +++ b/tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c
> > @@ -0,0 +1,116 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017-2023 SUSE
> > + * Authors: Libor Pechacek <lpechacek@suse.cz>
> > + *          Nicolai Stange <nstange@suse.de>
> > + *          Marcos Paulo de Souza <mpdesouza@suse.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +#include <linux/livepatch.h>
> > +
> > +#if defined(__x86_64__)
> > +#define FN_PREFIX __x64_
> > +#elif defined(__s390x__)
> > +#define FN_PREFIX __s390x_
> > +#elif defined(__aarch64__)
> > +#define FN_PREFIX __arm64_
> > +#else
> > +/* powerpc does not select ARCH_HAS_SYSCALL_WRAPPER */
> > +#define FN_PREFIX
> > +#endif
> > +
> > +/* Protects klp_pids */
> > +static DEFINE_MUTEX(kpid_mutex);
> > +
> > +static unsigned int npids, npids_pending;
> > +static int klp_pids[NR_CPUS];
> > +module_param_array(klp_pids, int, &npids_pending, 0);
> > +MODULE_PARM_DESC(klp_pids, "Array of pids to be transitioned to livepatched state.");
> > +
> > +static ssize_t npids_show(struct kobject *kobj, struct kobj_attribute *attr,
> > +			  char *buf)
> > +{
> > +	return sprintf(buf, "%u\n", npids_pending);
> > +}
> > +
> > +static struct kobj_attribute klp_attr = __ATTR_RO(npids);
> > +static struct kobject *klp_kobj;
> > +
> > +asmlinkage long lp_sys_getpid(void)
> > +{
> > +	int i;
> > +
> > +	mutex_lock(&kpid_mutex);
> > +	if (npids_pending > 0) {
> > +		for (i = 0; i < npids; i++) {
> > +			if (current->pid == klp_pids[i]) {
> > +				klp_pids[i] = 0;
> > +				npids_pending--;
> > +				break;
> > +			}
> > +		}
> > +	}
> > +	mutex_unlock(&kpid_mutex);
> > +
> > +	return task_tgid_vnr(current);
> > +}
> > +
> > +static struct klp_func vmlinux_funcs[] = {
> > +	{
> > +		.old_name = __stringify(FN_PREFIX) "sys_getpid",
> > +		.new_func = lp_sys_getpid,
> > +	}, {}
> > +};
> > +
> > +static struct klp_object objs[] = {
> > +	{
> > +		/* name being NULL means vmlinux */
> > +		.funcs = vmlinux_funcs,
> > +	}, {}
> > +};
> > +
> > +static struct klp_patch patch = {
> > +	.mod = THIS_MODULE,
> > +	.objs = objs,
> > +};
> > +
> > +static int livepatch_init(void)
> > +{
> > +	int ret;
> > +
> > +	klp_kobj = kobject_create_and_add("test_klp_syscall", kernel_kobj);
> > +	if (!klp_kobj)
> > +		return -ENOMEM;
> > +
> > +	ret = sysfs_create_file(klp_kobj, &klp_attr.attr);
> > +	if (ret) {
> > +		kobject_put(klp_kobj);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * Save the number pids to transition to livepatched state before the
> > +	 * number of pending pids is decremented.
> > +	 */
> > +	npids = npids_pending;
> > +
> > +	return klp_enable_patch(&patch);
> > +}
> > +
> > +static void livepatch_exit(void)
> > +{
> > +	kobject_put(klp_kobj);
> > +}
> > +
> > +module_init(livepatch_init);
> > +module_exit(livepatch_exit);
> > +MODULE_LICENSE("GPL");
> > +MODULE_INFO(livepatch, "Y");
> > +MODULE_AUTHOR("Libor Pechacek <lpechacek@suse.cz>");
> > +MODULE_AUTHOR("Nicolai Stange <nstange@suse.de>");
> > +MODULE_AUTHOR("Marcos Paulo de Souza <mpdesouza@suse.com>");
> > +MODULE_DESCRIPTION("Livepatch test: syscall transition");
> 
> Missing module name? Is there a reason to not name this module?

Can you please elaborate? This new module use the same MODULE_ macros used by
the current livepatch selftests. What do you mean by module name?

Thanks in advance,
  Marcos

> 
> thanks,
> -- Shuah

