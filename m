Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E24230F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 21:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbhJETtQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 15:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhJETtO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 15:49:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228ADC061760
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Oct 2021 12:47:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m21so298492pgu.13
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Oct 2021 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qkCPekbpEDYGwhlOfyAIA3I+UiuzlYJMJltSakAIdZc=;
        b=S13VUg/QnYYkvQ+R1A1zbvAPOkCbL2fLfrYDbRam9Ekzbn6gRSQM4wc9pVUQyPK2Nd
         EnBjSxt7knLmlUt7qHqO8cIcDkNQ8ZUa5EVfr/BZsNcIAQ/diKpkAc/MiWI6eaih820H
         Jcjlu3OoF3cA5IXl5FSVPE7ZrzW23UcdTPOS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qkCPekbpEDYGwhlOfyAIA3I+UiuzlYJMJltSakAIdZc=;
        b=3t0K+393QGwCB7QJY5KvFL8iO2d3q7439XgnU6M0aqQgnhTMhAFno4snmOS6bWSJlz
         DNe+W1m213nQbSWoKoQjpT3DwAXTFMj8YPxftKXCOILKKgTszbpkgvJ7SkHUpnK5aeDf
         pk4lmLGIM0L/cFscOhkgnanIO3igZrfP6gbYEek6JCM5i5maWI7/rpPTXn8dRvuCqiJP
         SYTMwn61tTsE8vm4Li1l5JhHRf/1eUIOhuLXV2tKHn6D08KD5b5uDMHGpnlqqg7FV4xk
         6YHa76cBWou7D1eediH0mPcDkksFJOt6U+OLTr4hB1EwrcW16jDxZ98muj8pORVSgRAi
         R6+Q==
X-Gm-Message-State: AOAM530JExeS0QWqrkNyMDw51t1rM5Y3N0B7I8j4JGaZkIhxaihXGaAa
        xM5xwKuOTO1/vR7+LPGnQZYJsw==
X-Google-Smtp-Source: ABdhPJxkJ/A7j051CT/sSu9pcT/gf0qUN0UbUyp7hIb1ZYaEsjs7D8BL/cJPyqsTp/vJhryzKuYBzQ==
X-Received: by 2002:a62:cd0f:0:b0:447:b8fe:d6c2 with SMTP id o15-20020a62cd0f000000b00447b8fed6c2mr33105130pfg.70.1633463243376;
        Tue, 05 Oct 2021 12:47:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l19sm3295785pff.131.2021.10.05.12.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:47:22 -0700 (PDT)
Date:   Tue, 5 Oct 2021 12:47:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/12] kernfs: add initial failure injection support
Message-ID: <202110051225.419CD64@keescook>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-5-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 27, 2021 at 09:37:57AM -0700, Luis Chamberlain wrote:
> This adds initial failure injection support to kernfs. We start
> off with debug knobs which when enabled allow test drivers, such as
> test_sysfs, to then make use of these to try to force certain
> difficult races to take place with a high degree of certainty.
> 
> This only adds runtime code *iff* the new bool CONFIG_FAIL_KERNFS_KNOBS is
> enabled in your kernel. If you don't have this enabled this provides
> no new functional. When CONFIG_FAIL_KERNFS_KNOBS is disabled the new
> routine kernfs_debug_should_wait() ends up being transformed to if
> (false), and so the compiler should optimize these out as dead code
> producing no new effective binary changes.
> 
> We start off with enabling failure injections in kernfs by allowing us to
> alter the way kernfs_fop_write_iter() behaves. We allow for the routine
> kernfs_fop_write_iter() to wait for a certain condition in the kernel to
> occur, after which it will sleep a predefined amount of time. This lets
> kernfs users to time exactly when it want kernfs_fop_write_iter() to
> complete, allowing for developing race conditions and test for correctness
> in kernfs.
> 
> You'd boot with this enabled on your kernel command line:
> 
> fail_kernfs_fop_write_iter=1,100,0,1
> 
> The values are <interval,probability,size,times>, we don't care for
> size, so for now we ignore it. The above ensures a failure will trigger
> only once.
> 
> *How* we allow for this routine to change behaviour is left to knobs we
> expose under debugfs:
> 
>  # ls -1 /sys/kernel/debug/kernfs/config_fail_kernfs_fop_write_iter/

I'd expect this to live under /sys/kernel/debug/fail_kernfs, like the
other fault injectors.

> wait_after_active
> wait_after_mutex
> wait_at_start
> wait_before_mutex
> 
> A debugfs entry also exists to allow us to sleep a configurabler amount
> of time after the completion:
> 
> /sys/kernel/debug/kernfs/sleep_after_wait_ms
> 
> These two sets of knobs allow us to construct races and demonstrate
> how the kernfs active reference should suffice to project against
> races.
> 
> Enabling CONFIG_FAULT_INJECTION_DEBUG_FS enables us to configure the
> differnt fault injection parametres for the new fail_kernfs_fop_write_iter
> fault injection at run time:
> 
> ls -1 /sys/kernel/debug/kernfs/fail_kernfs_fop_write_iter/
> interval
> probability
> space
> times
> task-filter
> verbose
> verbose_ratelimit_burst
> verbose_ratelimit_interval_ms
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  .../fault-injection/fault-injection.rst       | 22 +++++
>  MAINTAINERS                                   |  2 +-
>  fs/kernfs/Makefile                            |  1 +
>  fs/kernfs/failure-injection.c                 | 91 +++++++++++++++++++
>  fs/kernfs/file.c                              | 13 +++
>  fs/kernfs/kernfs-internal.h                   | 72 +++++++++++++++
>  include/linux/kernfs.h                        |  5 +
>  lib/Kconfig.debug                             | 10 ++
>  8 files changed, 215 insertions(+), 1 deletion(-)
>  create mode 100644 fs/kernfs/failure-injection.c
> 
> diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
> index 4a25c5eb6f07..d4d34b082f47 100644
> --- a/Documentation/fault-injection/fault-injection.rst
> +++ b/Documentation/fault-injection/fault-injection.rst
> @@ -28,6 +28,28 @@ Available fault injection capabilities
>  
>    injects kernel RPC client and server failures.
>  
> +- fail_kernfs_fop_write_iter
> +
> +  Allows for failures to be enabled inside kernfs_fop_write_iter(). Enabling
> +  this does not immediately enable any errors to occur. You must configure
> +  how you want this routine to fail or change behaviour by using the debugfs
> +  knobs for it:
> +
> +  # ls -1 /sys/kernel/debug/kernfs/config_fail_kernfs_fop_write_iter/
> +  wait_after_active
> +  wait_after_mutex
> +  wait_at_start
> +  wait_before_mutex

This should be split up and detailed in the "debugfs entries" section
below here.

> +
> +  You can also configure how long to sleep after a wait under
> +
> +  /sys/kernel/debug/kernfs/sleep_after_wait_ms
> +
> +  If you enable CONFIG_FAULT_INJECTION_DEBUG_FS the fail_add_disk failure
> +  injection parameters are placed under:
> +
> +  /sys/kernel/debug/kernfs/fail_kernfs_fop_write_iter/
> +
>  - fail_make_request
>  
>    injects disk IO errors on devices permitted by setting
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b4cefcb064c..fadfd961ad80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10384,7 +10384,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Tejun Heo <tj@kernel.org>
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> -F:	fs/kernfs/
> +F:	fs/kernfs/*
>  F:	include/linux/kernfs.h
>  
>  KEXEC
> diff --git a/fs/kernfs/Makefile b/fs/kernfs/Makefile
> index 4ca54ff54c98..bc5b32ca39f9 100644
> --- a/fs/kernfs/Makefile
> +++ b/fs/kernfs/Makefile
> @@ -4,3 +4,4 @@
>  #
>  
>  obj-y		:= mount.o inode.o dir.o file.o symlink.o
> +obj-$(CONFIG_FAIL_KERNFS_KNOBS)    += failure-injection.o
> diff --git a/fs/kernfs/failure-injection.c b/fs/kernfs/failure-injection.c
> new file mode 100644
> index 000000000000..4130d202c13b
> --- /dev/null
> +++ b/fs/kernfs/failure-injection.c

I'd name this fault_inject.c, which matches the more common case:

$ find . -type f -name '*fault*inject*.c'
./fs/nfsd/fault_inject.c
./drivers/nvme/host/fault_inject.c
./drivers/scsi/ufs/ufs-fault-injection.c
./lib/fault-inject.c
./lib/fault-inject-usercopy.c

> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/fault-inject.h>
> +#include <linux/delay.h>
> +
> +#include "kernfs-internal.h"
> +
> +static DECLARE_FAULT_ATTR(fail_kernfs_fop_write_iter);
> +struct kernfs_config_fail kernfs_config_fail;
> +
> +#define kernfs_config_fail(when) \
> +	kernfs_config_fail.kernfs_fop_write_iter_fail.wait_ ## when
> +
> +#define kernfs_config_fail(when) \
> +	kernfs_config_fail.kernfs_fop_write_iter_fail.wait_ ## when
> +
> +static int __init setup_fail_kernfs_fop_write_iter(char *str)
> +{
> +	return setup_fault_attr(&fail_kernfs_fop_write_iter, str);
> +}
> +
> +__setup("fail_kernfs_fop_write_iter=", setup_fail_kernfs_fop_write_iter);
> +
> +struct dentry *kernfs_debugfs_root;
> +struct dentry *config_fail_kernfs_fop_write_iter;
> +
> +static int __init kernfs_init_failure_injection(void)
> +{
> +	kernfs_config_fail.sleep_after_wait_ms = 100;
> +	kernfs_debugfs_root = debugfs_create_dir("kernfs", NULL);
> +
> +	fault_create_debugfs_attr("fail_kernfs_fop_write_iter",
> +				  kernfs_debugfs_root, &fail_kernfs_fop_write_iter);
> +
> +	config_fail_kernfs_fop_write_iter =
> +		debugfs_create_dir("config_fail_kernfs_fop_write_iter",
> +				   kernfs_debugfs_root);
> +
> +	debugfs_create_u32("sleep_after_wait_ms", 0600,
> +			   kernfs_debugfs_root,
> +			   &kernfs_config_fail.sleep_after_wait_ms);
> +
> +	debugfs_create_bool("wait_at_start", 0600,
> +			    config_fail_kernfs_fop_write_iter,
> +			    &kernfs_config_fail(at_start));
> +	debugfs_create_bool("wait_before_mutex", 0600,
> +			    config_fail_kernfs_fop_write_iter,
> +			    &kernfs_config_fail(before_mutex));
> +	debugfs_create_bool("wait_after_mutex", 0600,
> +			    config_fail_kernfs_fop_write_iter,
> +			    &kernfs_config_fail(after_mutex));
> +	debugfs_create_bool("wait_after_active", 0600,
> +			    config_fail_kernfs_fop_write_iter,
> +			    &kernfs_config_fail(after_active));
> +	return 0;
> +}
> +late_initcall(kernfs_init_failure_injection);
> +
> +int __kernfs_debug_should_wait_kernfs_fop_write_iter(bool evaluate)
> +{
> +	if (!evaluate)
> +		return 0;
> +
> +	return should_fail(&fail_kernfs_fop_write_iter, 0);
> +}

Every caller ends up doing the wait, so how about just including that
here instead? It should make things much less intrusive and more readable.

And for the naming, other fault injectors use "should_fail_$topic", so
maybe better here would be something like may_wait_kernfs(...).

> +
> +DECLARE_COMPLETION(kernfs_debug_wait_completion);
> +EXPORT_SYMBOL_NS_GPL(kernfs_debug_wait_completion, KERNFS_DEBUG_PRIVATE);
> +
> +void kernfs_debug_wait(void)
> +{
> +	unsigned long timeout;
> +
> +	timeout = wait_for_completion_timeout(&kernfs_debug_wait_completion,
> +					      msecs_to_jiffies(3000));
> +	if (!timeout)
> +		pr_info("%s waiting for kernfs_debug_wait_completion timed out\n",
> +			__func__);
> +	else
> +		pr_info("%s received completion with time left on timeout %u ms\n",
> +			__func__, jiffies_to_msecs(timeout));
> +
> +	/**
> +	 * The goal is wait for an event, and *then* once we have
> +	 * reached it, the other side will try to do something which
> +	 * it thinks will break. So we must give it some time to do
> +	 * that. The amount of time is configurable.
> +	 */
> +	msleep(kernfs_config_fail.sleep_after_wait_ms);
> +	pr_info("%s ended\n", __func__);
> +}

All the uses of "__func__" here seems redundant; I would drop them.

> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 60e2a86c535e..4479c6580333 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -259,6 +259,9 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	const struct kernfs_ops *ops;
>  	char *buf;
>  
> +	if (kernfs_debug_should_wait(kernfs_fop_write_iter, at_start))
> +		kernfs_debug_wait();

So this could just be:

	may_wait_kernfs(kernfs_fop_write_iter, at_start);

> +
>  	if (of->atomic_write_len) {
>  		if (len > of->atomic_write_len)
>  			return -E2BIG;
> @@ -280,17 +283,27 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	}
>  	buf[len] = '\0';	/* guarantee string termination */
>  
> +	if (kernfs_debug_should_wait(kernfs_fop_write_iter, before_mutex))
> +		kernfs_debug_wait();
> +
>  	/*
>  	 * @of->mutex nests outside active ref and is used both to ensure that
>  	 * the ops aren't called concurrently for the same open file.
>  	 */
>  	mutex_lock(&of->mutex);
> +
> +	if (kernfs_debug_should_wait(kernfs_fop_write_iter, after_mutex))
> +		kernfs_debug_wait();
> +
>  	if (!kernfs_get_active(of->kn)) {
>  		mutex_unlock(&of->mutex);
>  		len = -ENODEV;
>  		goto out_free;
>  	}
>  
> +	if (kernfs_debug_should_wait(kernfs_fop_write_iter, after_active))
> +		kernfs_debug_wait();
> +
>  	ops = kernfs_ops(of->kn);
>  	if (ops->write)
>  		len = ops->write(of, buf, len, iocb->ki_pos);
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index f9cc912c31e1..9e3abf597e2d 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -18,6 +18,7 @@
>  
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
> +#include <linux/stringify.h>
>  
>  struct kernfs_iattrs {
>  	kuid_t			ia_uid;
> @@ -147,4 +148,75 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
>   */
>  extern const struct inode_operations kernfs_symlink_iops;
>  
> +/*
> + * failure-injection.c
> + */
> +#ifdef CONFIG_FAIL_KERNFS_KNOBS
> +
> +/**
> + * struct kernfs_fop_write_iter_fail - how kernfs_fop_write_iter_fail fails
> + *
> + * This lets you configure what part of kernfs_fop_write_iter() should behave
> + * in a specific way to allow userspace to capture possible failures in
> + * kernfs. The wait knobs are allowed to let you design capture possible
> + * race conditions which would otherwise be difficult to reproduce. A
> + * secondary driver would tell kernfs's wait completion when it is done.
> + *
> + * The point to the wait completion failure injection tests are to confirm
> + * that the kernfs active refcount suffice to ensure other objects in other
> + * layers are also gauranteed to exist, even they are opaque to kernfs. This
> + * includes kobjects, devices, and other objects built on top of this, like
> + * the block layer when using sysfs block device attributes.
> + *
> + * @wait_at_start: waits for completion from a third party at the start of
> + *	the routine.
> + * @wait_before_mutex: waits for completion from a third party before we
> + *	are allowed to continue before the of->mutex is held.
> + * @wait_after_mutex: waits for completion from a third party after we
> + *	have held the of->mutex.
> + * @wait_after_active: waits for completion from a thid party after we
> + *	have refcounted the struct kernfs_node.
> + */
> +struct kernfs_fop_write_iter_fail {
> +	bool wait_at_start;
> +	bool wait_before_mutex;
> +	bool wait_after_mutex;
> +	bool wait_after_active;
> +};
> +
> +/**
> + * struct kernfs_config_fail - kernfs configuration for failure injection
> + *
> + * You can kernfs failure injection on boot, and in particular we currently
> + * only support failures for kernfs_fop_write_iter(). However, we don't
> + * want to always enable errors on this call when failure injection is enabled
> + * as this routine is used by many parts of the kernel for proper functionality.
> + * The compromise we make is we let userspace start enabling which parts it
> + * wants to fail after boot, if and only if failure injection has been enabled.
> + *
> + * @kernfs_fop_write_iter_fail: configuration for how we want to allow
> + *	for failure injection on kernfs_fop_write_iter()
> + * @sleep_after_wait_ms: how many ms to wait after completion is received.
> + */
> +struct kernfs_config_fail {
> +	struct kernfs_fop_write_iter_fail kernfs_fop_write_iter_fail;
> +	u32 sleep_after_wait_ms;
> +};
> +
> +extern struct kernfs_config_fail kernfs_config_fail;
> +
> +#define __kernfs_config_wait_var(func, when) \
> +	(kernfs_config_fail.  func  ## _fail.wait_  ## when)
                            ^^     ^               ^
nit: needless spaces

> +#define __kernfs_debug_should_wait_func_name(func) __kernfs_debug_should_wait_## func
> +
> +#define kernfs_debug_should_wait(func, when) \
> +	__kernfs_debug_should_wait_func_name(func)(__kernfs_config_wait_var(func, when))
> +int __kernfs_debug_should_wait_kernfs_fop_write_iter(bool evaluate);
> +void kernfs_debug_wait(void);
> +#else
> +static inline void kernfs_init_failure_injection(void) {}
> +#define kernfs_debug_should_wait(func, when) (false)
> +static inline void kernfs_debug_wait(void) {}
> +#endif
> +
>  #endif	/* __KERNFS_INTERNAL_H */
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 3ccce6f24548..cd968ee2b503 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -411,6 +411,11 @@ void kernfs_init(void);
>  
>  struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
>  						   u64 id);
> +
> +#ifdef CONFIG_FAIL_KERNFS_KNOBS
> +extern struct completion kernfs_debug_wait_completion;
> +#endif
> +
>  #else	/* CONFIG_KERNFS */
>  
>  static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ae19bf1a21b8..a29b7d398c4e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1902,6 +1902,16 @@ config FAULT_INJECTION_USERCOPY
>  	  Provides fault-injection capability to inject failures
>  	  in usercopy functions (copy_from_user(), get_user(), ...).
>  
> +config FAIL_KERNFS_KNOBS
> +	bool "Fault-injection support in kernfs"
> +	depends on FAULT_INJECTION
> +	help
> +	  Provide fault-injection capability for kernfs. This only enables
> +	  the error injection functionality. To use it you must configure which
> +	  which path you want to trigger on error on using debugfs under
> +	  /sys/kernel/debug/kernfs/config_fail_kernfs_fop_write_iter/. By
> +	  default all of these are disabled.
> +
>  config FAIL_MAKE_REQUEST
>  	bool "Fault-injection capability for disk IO"
>  	depends on FAULT_INJECTION && BLOCK
> -- 
> 2.30.2
> 

-- 
Kees Cook
