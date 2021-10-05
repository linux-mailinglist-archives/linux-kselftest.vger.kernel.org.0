Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EBB42310C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 21:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhJETx1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 15:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhJETxZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 15:53:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268EDC06174E
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Oct 2021 12:51:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s16so490647pfk.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Oct 2021 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c248+YsMzL9W0qCEd1iDHyrRshzyg80e+KsJR5NsZNM=;
        b=I6EHoGSdu3KoBtbKasywVsL+zTRgSEXt22cxdTFwLWr4xn/flSD2xtXn1VaSpCqPhp
         g88hv14ARss37ze+/b8ioywDIwAU/qCuH0Xlb4lnNlfMXDFaS3NbbU+lnpD39poKxNtm
         i//q0VDL8a9ea6JTn1lH7LSvf1aOAvMS+9KoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c248+YsMzL9W0qCEd1iDHyrRshzyg80e+KsJR5NsZNM=;
        b=szGQ3Qf5+9cAng1hyigHXZI9aRTJ+nXbiiMQfHhtBEeSuRqb7U2zvd/Zwcq4q44+wX
         DrqQ91bFt5lyF1I+wxZyr7JoMZotasaKmMkqXzSZSaS72FiSedWpD6moYwlSekaxYjMm
         mTfx4d35exWEwRxupnLD6MRo7AImgKpU6W7Obi4m7YnoGvJd15DoMEnolpWr3QoWBFlF
         6XrWgDXqAcc6IK2O+KLQ9uq+n6zSSeEi/aX0ASYPMzRtH+H8FKJ8EGZu0LP8mVTDvHdh
         mDb4BBgfH3LRPTsc724KIUZHhJc+sAGbOUkEU1mWQH4JUZZONXRZwXI3o7AVEuob0i6Q
         vAhw==
X-Gm-Message-State: AOAM5311lTgT9U6cMzgee1SBANfeMTnytRlB7XpxkrwRfYbJKulaymbQ
        8SoXFEgIsdMovNdCTFYvS2hJgQ==
X-Google-Smtp-Source: ABdhPJz7SItMl/gwavRck2FczeV8C2olPc8vu/fElDdn6AKXulzTkdGczLNMtutPlrJXnUhl6xgBZQ==
X-Received: by 2002:a05:6a00:1ad4:b0:44c:619e:f386 with SMTP id f20-20020a056a001ad400b0044c619ef386mr12723497pfv.66.1633463494468;
        Tue, 05 Oct 2021 12:51:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t2sm2886284pjf.1.2021.10.05.12.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:51:34 -0700 (PDT)
Date:   Tue, 5 Oct 2021 12:51:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/12] test_sysfs: add support to use kernfs failure
 injection
Message-ID: <202110051248.FCF2E89@keescook>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-6-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 27, 2021 at 09:37:58AM -0700, Luis Chamberlain wrote:
> This extends test_sysfs with support for using the failure injection
> wait completion and knobs to force a few race conditions which
> demonstrates that kernfs active reference protection is sufficient
> for kobject / device protection at higher layers.
> 
> This adds 4 new tests which tries to remove the device attribute
> store operation in 4 different situations:
> 
>   1) at the start of kernfs_kernfs_fop_write_iter()
>   2) before the of->mutex is held in kernfs_kernfs_fop_write_iter()
>   3) after the of->mutex is held in kernfs_kernfs_fop_write_iter()
>   4) after the kernfs node active reference is taken
> 
> A write fails in call cases except the last one, test number #32. There
> is a good explanation for this: *once* kernfs_get_active() gets called
> we have a guarantee that the kernfs entry cannot be removed. If
> kernfs_get_active() succeeds that entry cannot be removed and so
> anything trying to remove that entry will have to wait. It is perhaps
> not obvious but since a sysfs write will trigger eventually a
> kernfs_get_active() call, and *only* if this succeeds will the sysfs
> op be called, this and the fact that you cannot remove the kernfs
> entry while the kenfs entry is active implies that a module that
> created the respective sysfs / kernfs entry *cannot* possibly be
> removed during a sysfs operation. And test number 32 provides us with
> proof of this. If it were not true test #32 should crash.
> 
> No null dereferences are reproduced, even though this has been observed
> in some complex testing cases [0]. If this issue really exists we should
> have enough tools on the sysfs_test toolbox now to try to reproduce
> this easily without having to poke around other drivers. It very likley
> was the case that the issue reported [0] was possibly a side issue after
> the first bug which was zram specific. This is why it is important to
> isolate the issue and try to reproduce it in a generic form using the
> test_sysfs driver.
> 
> [0] https://lkml.kernel.org/r/20210623215007.862787-1-mcgrof@kernel.org
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  lib/Kconfig.debug                      |   3 +
>  lib/test_sysfs.c                       |  31 +++++
>  tools/testing/selftests/sysfs/config   |   3 +
>  tools/testing/selftests/sysfs/sysfs.sh | 175 +++++++++++++++++++++++++
>  4 files changed, 212 insertions(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a29b7d398c4e..176b822654e5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2358,6 +2358,9 @@ config TEST_SYSFS
>  	depends on SYSFS
>  	depends on NET
>  	depends on BLOCK
> +	select FAULT_INJECTION
> +	select FAULT_INJECTION_DEBUG_FS
> +	select FAIL_KERNFS_KNOBS

I don't like seeing "select" for user-configurable CONFIGs -- things
tend to end up weird. This should simply be:

	depends on FAIL_KERNFS_KNOBS

>  	help
>  	  This builds the "test_sysfs" module. This driver enables to test the
>  	  sysfs file system safely without affecting production knobs which
> diff --git a/lib/test_sysfs.c b/lib/test_sysfs.c
> index 2043ca494af8..c6e62de61403 100644
> --- a/lib/test_sysfs.c
> +++ b/lib/test_sysfs.c
> @@ -38,6 +38,11 @@
>  #include <linux/rtnetlink.h>
>  #include <linux/genhd.h>
>  #include <linux/blkdev.h>
> +#include <linux/kernfs.h>
> +
> +#ifdef CONFIG_FAIL_KERNFS_KNOBS

This isn't an optional config here (and following)?

> +MODULE_IMPORT_NS(KERNFS_DEBUG_PRIVATE);
> +#endif
>  
>  static bool enable_lock;
>  module_param(enable_lock, bool_enable_only, 0644);
> @@ -82,6 +87,13 @@ static bool enable_verbose_rmmod;
>  module_param(enable_verbose_rmmod, bool_enable_only, 0644);
>  MODULE_PARM_DESC(enable_verbose_rmmod, "enable verbose print messages on rmmod");
>  
> +#ifdef CONFIG_FAIL_KERNFS_KNOBS
> +static bool enable_completion_on_rmmod;
> +module_param(enable_completion_on_rmmod, bool_enable_only, 0644);
> +MODULE_PARM_DESC(enable_completion_on_rmmod,
> +		 "enable sending a kernfs completion on rmmod");
> +#endif
> +
>  static int sysfs_test_major;
>  
>  /**
> @@ -285,6 +297,12 @@ static ssize_t config_show(struct device *dev,
>  			"enable_verbose_writes:\t%s\n",
>  			enable_verbose_writes ? "true" : "false");
>  
> +#ifdef CONFIG_FAIL_KERNFS_KNOBS
> +	len += snprintf(buf+len, PAGE_SIZE - len,
> +			"enable_completion_on_rmmod:\t%s\n",
> +			enable_completion_on_rmmod ? "true" : "false");
> +#endif
> +
>  	test_dev_config_unlock(test_dev);
>  
>  	return len;
> @@ -904,10 +922,23 @@ static int __init test_sysfs_init(void)
>  }
>  module_init(test_sysfs_init);
>  
> +#ifdef CONFIG_FAIL_KERNFS_KNOBS
> +/* The goal is to race our device removal with a pending kernfs -> store call */
> +static void test_sysfs_kernfs_send_completion_rmmod(void)
> +{
> +	if (!enable_completion_on_rmmod)
> +		return;
> +	complete(&kernfs_debug_wait_completion);
> +}
> +#else
> +static inline void test_sysfs_kernfs_send_completion_rmmod(void) {}
> +#endif
> +
>  static void __exit test_sysfs_exit(void)
>  {
>  	if (enable_debugfs)
>  		debugfs_remove(debugfs_dir);
> +	test_sysfs_kernfs_send_completion_rmmod();
>  	if (delay_rmmod_ms)
>  		msleep(delay_rmmod_ms);
>  	unregister_test_dev_sysfs(first_test_dev);
> diff --git a/tools/testing/selftests/sysfs/config b/tools/testing/selftests/sysfs/config
> index 9196f452ecd5..2876a229f95b 100644
> --- a/tools/testing/selftests/sysfs/config
> +++ b/tools/testing/selftests/sysfs/config
> @@ -1,2 +1,5 @@
>  CONFIG_SYSFS=m
>  CONFIG_TEST_SYSFS=m
> +CONFIG_FAULT_INJECTION=y
> +CONFIG_FAULT_INJECTION_DEBUG_FS=y
> +CONFIG_FAIL_KERNFS_KNOBS=y
> diff --git a/tools/testing/selftests/sysfs/sysfs.sh b/tools/testing/selftests/sysfs/sysfs.sh
> index b3f4c2236c7f..f928635d0e35 100755
> --- a/tools/testing/selftests/sysfs/sysfs.sh
> +++ b/tools/testing/selftests/sysfs/sysfs.sh
> @@ -62,6 +62,10 @@ ALL_TESTS="$ALL_TESTS 0025:1:1:test_dev_y:block"
>  ALL_TESTS="$ALL_TESTS 0026:1:1:test_dev_y:block"
>  ALL_TESTS="$ALL_TESTS 0027:1:0:test_dev_x:block" # deadlock test
>  ALL_TESTS="$ALL_TESTS 0028:1:0:test_dev_x:block" # deadlock test with rntl_lock
> +ALL_TESTS="$ALL_TESTS 0029:1:1:test_dev_x:block" # kernfs race removal of store
> +ALL_TESTS="$ALL_TESTS 0030:1:1:test_dev_x:block" # kernfs race removal before mutex
> +ALL_TESTS="$ALL_TESTS 0031:1:1:test_dev_x:block" # kernfs race removal after mutex
> +ALL_TESTS="$ALL_TESTS 0032:1:1:test_dev_x:block" # kernfs race removal after active
>  
>  allow_user_defaults()
>  {
> @@ -92,6 +96,9 @@ allow_user_defaults()
>  	if [ -z $SYSFS_DEBUGFS_DIR ]; then
>  		SYSFS_DEBUGFS_DIR="/sys/kernel/debug/test_sysfs"
>  	fi
> +	if [ -z $KERNFS_DEBUGFS_DIR ]; then
> +		KERNFS_DEBUGFS_DIR="/sys/kernel/debug/kernfs"
> +	fi
>  	if [ -z $PAGE_SIZE ]; then
>  		PAGE_SIZE=$(getconf PAGESIZE)
>  	fi
> @@ -167,6 +174,14 @@ modprobe_reset_enable_rtnl_lock_on_rmmod()
>  	unset FIRST_MODPROBE_ARGS
>  }
>  
> +modprobe_reset_enable_completion()
> +{
> +	FIRST_MODPROBE_ARGS="enable_completion_on_rmmod=1 enable_verbose_writes=1"
> +	FIRST_MODPROBE_ARGS="$FIRST_MODPROBE_ARGS enable_verbose_rmmod=1 delay_rmmod_ms=0"
> +	modprobe_reset
> +	unset FIRST_MODPROBE_ARGS
> +}
> +
>  load_req_mod()
>  {
>  	modprobe_reset
> @@ -197,6 +212,63 @@ debugfs_reset_first_test_dev_ignore_errors()
>  	echo -n "1" >"$SYSFS_DEBUGFS_DIR"/reset_first_test_dev
>  }
>  
> +debugfs_kernfs_kernfs_fop_write_iter_exists()
> +{
> +	KNOB_DIR="${KERNFS_DEBUGFS_DIR}/config_fail_kernfs_fop_write_iter"
> +	if [[ ! -d $KNOB_DIR ]]; then
> +		echo "kernfs debugfs does not exist $KNOB_DIR"
> +		return 0;
> +	fi
> +	KNOB_DEBUGFS="${KERNFS_DEBUGFS_DIR}/fail_kernfs_fop_write_iter"
> +	if [[ ! -d $KNOB_DEBUGFS ]]; then
> +		echo -n "kernfs debugfs for coniguring fail_kernfs_fop_write_iter "
> +		echo "does not exist $KNOB_DIR"
> +		return 0;
> +	fi
> +	return 1
> +}
> +
> +debugfs_kernfs_kernfs_fop_write_iter_set_fail_once()
> +{
> +	KNOB_DEBUGFS="${KERNFS_DEBUGFS_DIR}/fail_kernfs_fop_write_iter"
> +	echo 1 > $KNOB_DEBUGFS/interval
> +	echo 100 > $KNOB_DEBUGFS/probability
> +	echo 0 > $KNOB_DEBUGFS/space
> +	# Disable verbose messages on the kernel ring buffer which may
> +	# confuse developers with a kernel panic.
> +	echo 0 > $KNOB_DEBUGFS/verbose
> +
> +	# Fail only once
> +	echo 1 > $KNOB_DEBUGFS/times
> +}
> +
> +debugfs_kernfs_kernfs_fop_write_iter_set_fail_never()
> +{
> +	KNOB_DEBUGFS="${KERNFS_DEBUGFS_DIR}/fail_kernfs_fop_write_iter"
> +	echo 0 > $KNOB_DEBUGFS/times
> +}
> +
> +debugfs_kernfs_set_wait_ms()
> +{
> +	SLEEP_AFTER_WAIT_MS="${KERNFS_DEBUGFS_DIR}/sleep_after_wait_ms"
> +	echo $1 > $SLEEP_AFTER_WAIT_MS
> +}
> +
> +debugfs_kernfs_disable_wait_kernfs_fop_write_iter()
> +{
> +	ENABLE_WAIT_KNOB="${KERNFS_DEBUGFS_DIR}/config_fail_kernfs_fop_write_iter/wait_"
> +	for KNOB in ${ENABLE_WAIT_KNOB}*; do
> +		echo 0 > $KNOB
> +	done
> +}
> +
> +debugfs_kernfs_enable_wait_kernfs_fop_write_iter()
> +{
> +	ENABLE_WAIT_KNOB="${KERNFS_DEBUGFS_DIR}/config_fail_kernfs_fop_write_iter/wait_$1"
> +	echo -n "1" > $ENABLE_WAIT_KNOB
> +	return $?
> +}
> +
>  set_orig()
>  {
>  	if [[ ! -z $TARGET ]] && [[ ! -z $ORIG ]]; then
> @@ -972,6 +1044,105 @@ sysfs_test_0028()
>  	fi
>  }
>  
> +sysfs_race_kernfs_kernfs_fop_write_iter()
> +{
> +	TARGET="${DIR}/$(get_test_target $1)"
> +	WAIT_AT=$2
> +	EXPECT_WRITE_RETURNS=$3
> +	MSDELAY=$4
> +
> +	modprobe_reset_enable_completion
> +	ORIG=$(cat "${TARGET}")
> +	TEST_STR=$(( $ORIG + 1 ))
> +
> +	echo -n "Test racing removal of sysfs store op with kernfs $WAIT_AT ... "
> +
> +	if debugfs_kernfs_kernfs_fop_write_iter_exists; then
> +		echo -n "skipping test as CONFIG_FAIL_KERNFS_KNOBS "
> +		echo " or CONFIG_FAULT_INJECTION_DEBUG_FS is disabled"
> +		return $ksft_skip
> +	fi
> +
> +	# Allow for failing the kernfs_kernfs_fop_write_iter call once,
> +	# we'll provide exact context shortly afterwards.
> +	debugfs_kernfs_kernfs_fop_write_iter_set_fail_once
> +
> +	# First disable all waits
> +	debugfs_kernfs_disable_wait_kernfs_fop_write_iter
> +
> +	# Enable a wait_for_completion(&kernfs_debug_wait_completion) at the
> +	# specified location inside the kernfs_fop_write_iter() routine
> +	debugfs_kernfs_enable_wait_kernfs_fop_write_iter $WAIT_AT
> +
> +	# Configure kernfs so that after its wait_for_completion() it
> +	# will msleep() this amount of time and schedule(). We figure this
> +	# will be sufficient time to allow for our module removal to complete.
> +	debugfs_kernfs_set_wait_ms $MSDELAY
> +
> +	# Now we trigger a kernfs write op, which will run kernfs_fop_write_iter,
> +	# but will wait until our driver sends a respective completion
> +	set_test_ignore_errors &
> +	write_pid=$!
> +
> +	# At this point kernfs_fop_write_iter() hasn't run our op, its
> +	# waiting for our completion at the specified time $WAIT_AT.
> +	# We now remove our module which will send a
> +	# complete(&kernfs_debug_wait_completion) right before we deregister
> +	# our device and the sysfs device attributes are removed.
> +	#
> +	# After the completion is sent, the test_sysfs driver races with
> +	# kernfs to do the device deregistration with the kernfs msleep
> +	# and schedule(). This should mean we've forced trying to remove the
> +	# module prior to allowing kernfs to run our store operation. If the
> +	# race did happen we'll panic with a null dereference on the store op.
> +	#
> +	# If no race happens we should see no write operation triggered.
> +	modprobe -r $TEST_DRIVER > /dev/null 2>&1
> +
> +	debugfs_kernfs_kernfs_fop_write_iter_set_fail_never
> +
> +	wait $write_pid
> +	if [[ $? -eq $EXPECT_WRITE_RETURNS ]]; then
> +		echo "ok"
> +	else
> +		echo "FAIL" >&2
> +	fi
> +}
> +
> +sysfs_test_0029()
> +{
> +	for delay in 0 2 4 8 16 32 64 128 246 512 1024; do
> +		echo "Using delay-after-completion: $delay"
> +		sysfs_race_kernfs_kernfs_fop_write_iter 0029 at_start 1 $delay
> +	done
> +}
> +
> +sysfs_test_0030()
> +{
> +	for delay in 0 2 4 8 16 32 64 128 246 512 1024; do
> +		echo "Using delay-after-completion: $delay"
> +		sysfs_race_kernfs_kernfs_fop_write_iter 0030 before_mutex 1 $delay
> +	done
> +}
> +
> +sysfs_test_0031()
> +{
> +	for delay in 0 2 4 8 16 32 64 128 246 512 1024; do
> +		echo "Using delay-after-completion: $delay"
> +		sysfs_race_kernfs_kernfs_fop_write_iter 0031 after_mutex 1 $delay
> +	done
> +}
> +
> +# A write only succeeds *iff* a module removal happens *after* the
> +# kernfs active reference is obtained with kernfs_get_active().
> +sysfs_test_0032()
> +{
> +	for delay in 0 2 4 8 16 32 64 128 246 512 1024; do
> +		echo "Using delay-after-completion: $delay"
> +		sysfs_race_kernfs_kernfs_fop_write_iter 0032 after_active 0 $delay
> +	done
> +}
> +
>  test_gen_desc()
>  {
>  	echo -n "$1 x $(get_test_count $1)"
> @@ -1013,6 +1184,10 @@ list_tests()
>  	echo "$(test_gen_desc 0026) - block test writing y larger delay and resetting device"
>  	echo "$(test_gen_desc 0027) - test rmmod deadlock while writing x ... "
>  	echo "$(test_gen_desc 0028) - test rmmod deadlock using rtnl_lock while writing x ..."
> +	echo "$(test_gen_desc 0029) - racing removal of store op with kernfs at start"
> +	echo "$(test_gen_desc 0030) - racing removal of store op with kernfs before mutex"
> +	echo "$(test_gen_desc 0031) - racing removal of store op with kernfs after mutex"
> +	echo "$(test_gen_desc 0032) - racing removal of store op with kernfs after active"
>  }
>  
>  usage()
> -- 
> 2.30.2
> 

-- 
Kees Cook
