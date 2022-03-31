Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7021C4EE1FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Mar 2022 21:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbiCaTlw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Mar 2022 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbiCaTlo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Mar 2022 15:41:44 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A68526D2
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Mar 2022 12:39:09 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id B6FD1CAB31
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Mar 2022 19:36:16 +0000 (UTC)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F20531C0002;
        Thu, 31 Mar 2022 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648755369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V8fHwSd70iFB+ISHP69lKJKpu/hepzr7wzhuGq/slrA=;
        b=T8FpwH1M9y04NkMIbM/MSxBGCYDgiJWha5qWF7sIDPHoh5jC1MfDCMtjKnilMEV2fVGupU
        lYkJxQmbZRjJtg6eqPH1+Tt8picFwnY2D5tYFv5g5SeuGEbgkSq4RxlM+3j0YIOwDSYI9X
        tosRqteU+usTABUV6A0ozBm4gjW3cdk6p/NrtZ5Y8Szlh4KgP58eNvzj6YR3zmEJjP2WpT
        SBgnj+FaIPUJdk//TpJ6eHFGHBhL0pscuxq+3cQwESTc9lah3Vd7DRdpo/PFLrGTi9fS4k
        6CXdgn8qAp8qrag1coPu3vXWqfkX7LIb14H5T4ajWoPIS7Ln4PbYJ1ZIvrYNjg==
Date:   Thu, 31 Mar 2022 21:36:08 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] [RFC] rtc: expose direct access to hardware alarm
 time in debugfs
Message-ID: <YkYCqI0HEJvi2VjV@piout.net>
References: <20220331190612.22162-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220331190612.22162-1-mat.jonczyk@o2.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On 31/03/2022 21:06:11+0200, Mateusz Jończyk wrote:
> Before Linux 5.17, there was a problem with the CMOS RTC driver:
> cmos_read_alarm() and cmos_set_alarm() did not check for the UIP (Update
> in progress) bit, which could have caused it to sometimes fail silently
> and read bogus values or do not set the alarm correctly.
> Luckily, this issue was masked by cmos_read_time() invocations in core
> RTC code - see https://marc.info/?l=linux-rtc&m=164858416511425&w=4
> 
> To avoid such a problem in the future in some other driver, I wrote a
> test unit that reads the alarm time many times in a row. As the alarm
> time is usually read once and cached by the RTC core, this requires a
> way for userspace to trigger direct alarm time read from hardware. I
> think that debugfs is the natural choice for this.
> 
> So, introduce /sys/kernel/debug/rtc/rtcX/wakealarm_raw. This interface
> as implemented here does not seem to be that useful to userspace, so
> there is little risk that it will become kernel ABI.
> 
> Is this approach correct and worth it?
> 

I'm not really in favor of adding another interface for very little
gain, you want to use this interface to exercise the API in a way that
will never happen in the real world, especially since __rtc_read_alarm
is only called once, at registration time.

I'm not sure the selftest is worth it then. You should better improve
the existing unit tests by exercising the ioctls a bit more. syzbot did
report interesting race conditions that were more severe.

> TODO:
> - should I add a new Kconfig option (like CONFIG_RTC_INTF_DEBUGFS), or
>   just use CONFIG_DEBUG_FS here? I wouldn't like to create unnecessary
>   config options in the kernel.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/class.c     |   3 ++
>  drivers/rtc/debugfs.c   | 112 ++++++++++++++++++++++++++++++++++++++++
>  drivers/rtc/interface.c |   3 +-
>  include/linux/rtc.h     |  16 ++++++
>  5 files changed, 133 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/rtc/debugfs.c
> 
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 678a8ef4abae..50e166a97f54 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -14,6 +14,7 @@ rtc-core-$(CONFIG_RTC_NVMEM)		+= nvmem.o
>  rtc-core-$(CONFIG_RTC_INTF_DEV)		+= dev.o
>  rtc-core-$(CONFIG_RTC_INTF_PROC)	+= proc.o
>  rtc-core-$(CONFIG_RTC_INTF_SYSFS)	+= sysfs.o
> +rtc-core-$(CONFIG_DEBUG_FS)		+= debugfs.o
>  
>  obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= lib_test.o
>  
> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
> index 4b460c61f1d8..5673b7b26c0d 100644
> --- a/drivers/rtc/class.c
> +++ b/drivers/rtc/class.c
> @@ -334,6 +334,7 @@ static void devm_rtc_unregister_device(void *data)
>  	 * Remove innards of this RTC, then disable it, before
>  	 * letting any rtc_class_open() users access it again
>  	 */
> +	rtc_debugfs_del_device(rtc);
>  	rtc_proc_del_device(rtc);
>  	if (!test_bit(RTC_NO_CDEV, &rtc->flags))
>  		cdev_device_del(&rtc->char_dev, &rtc->dev);
> @@ -417,6 +418,7 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
>  	}
>  
>  	rtc_proc_add_device(rtc);
> +	rtc_debugfs_add_device(rtc);
>  
>  	dev_info(rtc->dev.parent, "registered as %s\n",
>  		 dev_name(&rtc->dev));
> @@ -476,6 +478,7 @@ static int __init rtc_init(void)
>  	}
>  	rtc_class->pm = RTC_CLASS_DEV_PM_OPS;
>  	rtc_dev_init();
> +	rtc_debugfs_init();
>  	return 0;
>  }
>  subsys_initcall(rtc_init);
> diff --git a/drivers/rtc/debugfs.c b/drivers/rtc/debugfs.c
> new file mode 100644
> index 000000000000..5ceed5504033
> --- /dev/null
> +++ b/drivers/rtc/debugfs.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Debugfs interface for testing RTC alarms.
> + */
> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/rtc.h>
> +
> +static struct dentry *rtc_main_debugfs_dir;
> +
> +void rtc_debugfs_init(void)
> +{
> +	struct dentry *ret = debugfs_create_dir("rtc", NULL);
> +
> +	// No error is critical here
> +	if (!IS_ERR(ret))
> +		rtc_main_debugfs_dir = ret;
> +}
> +
> +/*
> + * Handler for /sys/kernel/debug/rtc/rtcX/wakealarm_raw .
> + * This function reads the RTC alarm time directly from hardware. If the RTC
> + * alarm is enabled, this function returns the alarm time modulo 24h in seconds
> + * since midnight.
> + *
> + * Should be only used for testing of the RTC alarm read functionality in
> + * drivers - to make sure that the driver returns consistent values.
> + *
> + * Used in tools/testing/selftests/rtc/rtctest.c .
> + */
> +static int rtc_debugfs_alarm_read(void *p, u64 *out)
> +{
> +	int ret;
> +	struct rtc_device *rtc = p;
> +	struct rtc_wkalrm alm;
> +
> +	/* Using rtc_read_alarm_internal() instead of __rtc_read_alarm() will
> +	 * allow us to avoid any interaction with rtc_read_time() and possibly
> +	 * see more issues.
> +	 */
> +	ret = rtc_read_alarm_internal(rtc, &alm);
> +	if (ret != 0)
> +		return ret;
> +
> +	if (!alm.enabled) {
> +		*out = -1;
> +		return 0;
> +	}
> +
> +	/* It does not matter if the device does not support seconds resolution
> +	 * of the RTC alarm.
> +	 */
> +	if (test_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->features))
> +		alm.time.tm_sec = 0;
> +
> +	/* The selftest code works with fully defined alarms only.
> +	 */
> +	if (alm.time.tm_sec == -1 || alm.time.tm_min == -1 || alm.time.tm_hour == -1) {
> +		*out = -2;
> +		return 0;
> +	}
> +
> +	/* Check if the alarm time is correct.
> +	 * rtc_valid_tm() does not allow fields containing "-1", so put in
> +	 * something to satisfy it.
> +	 */
> +	if (alm.time.tm_year == -1)
> +		alm.time.tm_year = 100;
> +	if (alm.time.tm_mon == -1)
> +		alm.time.tm_mon = 0;
> +	if (alm.time.tm_mday == -1)
> +		alm.time.tm_mday = 1;
> +	if (rtc_valid_tm(&alm.time))
> +		return -EINVAL;
> +
> +	/* We do not duplicate the logic in __rtc_read_alarm() and instead only
> +	 * return the alarm time modulo 24h, which all devices should support.
> +	 * This should be enough for testing purposes.
> +	 */
> +	*out = alm.time.tm_hour * 3600 + alm.time.tm_min * 60 + alm.time.tm_sec;
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(rtc_alarm_raw, rtc_debugfs_alarm_read, NULL, "%lld\n");
> +
> +void rtc_debugfs_add_device(struct rtc_device *rtc)
> +{
> +	struct dentry *dev_dir;
> +
> +	if (!rtc_main_debugfs_dir)
> +		return;
> +
> +	dev_dir = debugfs_create_dir(dev_name(&rtc->dev), rtc_main_debugfs_dir);
> +
> +	if (IS_ERR(dev_dir)) {
> +		rtc->debugfs_dir = NULL;
> +		return;
> +	}
> +	rtc->debugfs_dir = dev_dir;
> +
> +	if (test_bit(RTC_FEATURE_ALARM, rtc->features) && rtc->ops->read_alarm) {
> +		debugfs_create_file("wakealarm_raw", 0444, dev_dir,
> +				    rtc, &rtc_alarm_raw);
> +	}
> +}
> +
> +void rtc_debugfs_del_device(struct rtc_device *rtc)
> +{
> +	debugfs_remove_recursive(rtc->debugfs_dir);
> +	rtc->debugfs_dir = NULL;
> +}
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index d8e835798153..51c801c82472 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -175,8 +175,7 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
>  }
>  EXPORT_SYMBOL_GPL(rtc_set_time);
>  
> -static int rtc_read_alarm_internal(struct rtc_device *rtc,
> -				   struct rtc_wkalrm *alarm)
> +int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
>  {
>  	int err;
>  
> diff --git a/include/linux/rtc.h b/include/linux/rtc.h
> index 47fd1c2d3a57..4665bc238a94 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -41,6 +41,7 @@ static inline time64_t rtc_tm_sub(struct rtc_time *lhs, struct rtc_time *rhs)
>  #include <linux/mutex.h>
>  #include <linux/timerqueue.h>
>  #include <linux/workqueue.h>
> +#include <linux/debugfs.h>
>  
>  extern struct class *rtc_class;
>  
> @@ -152,6 +153,10 @@ struct rtc_device {
>  	time64_t offset_secs;
>  	bool set_start_time;
>  
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *debugfs_dir;
> +#endif
> +
>  #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
>  	struct work_struct uie_task;
>  	struct timer_list uie_timer;
> @@ -190,6 +195,7 @@ extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
>  int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
>  extern int rtc_read_alarm(struct rtc_device *rtc,
>  			struct rtc_wkalrm *alrm);
> +int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
>  extern int rtc_set_alarm(struct rtc_device *rtc,
>  				struct rtc_wkalrm *alrm);
>  extern int rtc_initialize_alarm(struct rtc_device *rtc,
> @@ -262,4 +268,14 @@ int rtc_add_groups(struct rtc_device *rtc, const struct attribute_group **grps)
>  	return 0;
>  }
>  #endif
> +
> +#ifdef CONFIG_DEBUG_FS
> +void rtc_debugfs_init(void);
> +void rtc_debugfs_add_device(struct rtc_device *rtc);
> +void rtc_debugfs_del_device(struct rtc_device *rtc);
> +#else /* CONFIG_DEBUG_FS */
> +static inline void rtc_debugfs_init(void) {}
> +static inline void rtc_debugfs_add_device(struct rtc_device *rtc) {}
> +static inline void rtc_debugfs_del_device(struct rtc_device *rtc) {}
> +#endif /* CONFIG_DEBUG_FS */
>  #endif /* _LINUX_RTC_H_ */
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
