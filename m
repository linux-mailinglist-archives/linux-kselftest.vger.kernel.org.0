Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9211E4C7155
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Feb 2022 17:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiB1QKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 11:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiB1QKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 11:10:23 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145204B84B;
        Mon, 28 Feb 2022 08:09:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V5oa4mN_1646064576;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V5oa4mN_1646064576)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Mar 2022 00:09:37 +0800
From:   xhao@linux.alibaba.com
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH v3 03/13] mm/damon: Implement a minimal stub for
 sysfs-based DAMON interface
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        gregkh@linuxfoundation.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220228081314.5770-1-sj@kernel.org>
 <20220228081314.5770-4-sj@kernel.org>
Message-ID: <0f1051ce-2ce7-8659-f881-b5889018b8a2@linux.alibaba.com>
Date:   Tue, 1 Mar 2022 00:09:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220228081314.5770-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi SeongJae:

On 2/28/22 4:13 PM, SeongJae Park wrote:
> DAMON's debugfs-based user interface served very well, so far.  However,
> it unnecessarily depends on debugfs, while DAMON is not aimed to be used
> for only debugging.  Also, the interface receives multiple values via
> one file.  For example, schemes file receives 18 values separated by
> white spaces.  As a result, it is ineffient, hard to be used, and
> difficult to be extended.  Especially, keeping backward compatibility of
> user space tools is getting only challenging.  It would be better to
> implement another reliable and flexible interface and deprecate the
> debugfs interface in long term.
>
> To this end, this commit implements a stub of a part of the new user
> interface of DAMON using sysfs.  Specifically, this commit implements
> the sysfs control parts for virtual address space monitoring.
>
> More specifically, the idea of the new interface is, using directory
> hierarchies and making one file for one value.  The hierarchy that this
> commit is introducing is as below.  In the below figure,
> parents-children relations are represented with indentations, each
> directory is having ``/`` suffix, and files in each directory are
> separated by comma (",").
>
>      /sys/kernel/mm/damon/admin
>      │ kdamonds/nr_kdamonds
>      │ │ 0/state,pid
>      │ │ │ contexts/nr_contexts
>      │ │ │ │ 0/operations
>      │ │ │ │ │ monitoring_attrs/
>      │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
>      │ │ │ │ │ │ nr_regions/min,max
>      │ │ │ │ │ targets/nr_targets
>      │ │ │ │ │ │ 0/pid_target
>      │ │ │ │ │ │ ...
>      │ │ │ │ ...
>      │ │ ...
>
> Writing a number <N> to each 'nr' file makes directories of name <0> to
> <N-1> in the directory of the 'nr' file.  That's all this commit does.
> Writing proper values to relevant files will construct the DAMON
> contexts, and writing a special keyword, 'on', to 'state' files for each
> kdamond will ask DAMON to start the constructed contexts.
>
> For a short example, using below commands for
> monitoring virtual address spaces of a given workload is imaginable:
>
>      # cd /sys/kernel/mm/damon/admin/
>      # echo 1 > kdamonds/nr_kdamonds
>      # echo 1 > kdamonds/0/contexts/nr_contexts
>      # echo vaddr > kdamonds/0/contexts/0/operations
>      # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
>      # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
>      # echo on > kdamonds/0/state
>
> Please note that this commit is implementing only the sysfs part stub as
> abovely mentioned.  This commit doesn't implement the special keywords
> for 'state' files.  Following commits will do that.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/Kconfig  |    7 +
>   mm/damon/Makefile |    1 +
>   mm/damon/sysfs.c  | 1082 +++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1090 insertions(+)
>   create mode 100644 mm/damon/sysfs.c
>
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index 01bad77ad7ae..9b559c76d6dd 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -52,6 +52,13 @@ config DAMON_VADDR_KUNIT_TEST
>   
>   	  If unsure, say N.
>   
> +config DAMON_SYSFS
> +	bool "DAMON sysfs interface"
> +	depends on DAMON && SYSFS
> +	help
> +	  This builds the sysfs interface for DAMON.  The user space can use
> +	  the interface for arbitrary data access monitoring.
> +
>   config DAMON_DBGFS
>   	bool "DAMON debugfs interface"
>   	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> index aebbf6c14c51..dbf7190b4144 100644
> --- a/mm/damon/Makefile
> +++ b/mm/damon/Makefile
> @@ -3,5 +3,6 @@
>   obj-y				:= core.o
>   obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
>   obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
> +obj-$(CONFIG_DAMON_SYSFS)	+= sysfs.o
>   obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
>   obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> new file mode 100644
> index 000000000000..87cf28ae6a6f
> --- /dev/null
> +++ b/mm/damon/sysfs.c
> @@ -0,0 +1,1082 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DAMON sysfs Interface
> + *
> + * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
> + */
> +
> +#include <linux/damon.h>
> +#include <linux/kobject.h>
> +#include <linux/pid.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +
> +static DEFINE_MUTEX(damon_sysfs_lock);
> +
> +/*
> + * unsigned long range directory
> + */
> +
> +struct damon_sysfs_ul_range {
> +	struct kobject kobj;
> +	unsigned long min;
> +	unsigned long max;
> +};
> +
> +static struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
> +		unsigned long min,
> +		unsigned long max)
> +{
> +	struct damon_sysfs_ul_range *range = kmalloc(sizeof(*range),
> +			GFP_KERNEL);
> +
> +	if (!range)
> +		return NULL;
> +	range->kobj = (struct kobject){};
> +	range->min = min;
> +	range->max = max;
> +
> +	return range;
> +}
> +
> +static ssize_t min_show(struct kobject *kobj, struct kobj_attribute *attr,
> +		char *buf)
> +{
> +	struct damon_sysfs_ul_range *range = container_of(kobj,
> +			struct damon_sysfs_ul_range, kobj);
> +
> +	return sysfs_emit(buf, "%lu\n", range->min);
> +}
> +

I have do some test about interface "min" and "max",  it looks have some 
bugs.

[root@rt2k03395 nr_regions]# echo 10 > max
[root@rt2k03395 nr_regions]# echo 20 > min
[root@rt2k03395 nr_regions]# ls
[root@rt2k03395 nr_regions]# cat max
10
[root@rt2k03395 nr_regions]# cat min
20

how about do some fix like this:

static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,
		const char *buf, size_t count)
{
	struct damon_sysfs_ul_range *range = container_of(kobj,
			struct damon_sysfs_ul_range, kobj);
	unsigned long min;
	int err;

	err = kstrtoul(buf, 0, &min);
-	if (err)
+	if (err || min >= range->max)
		return -EINVAL;

	range->min = min;
	return count;
}

static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,
		const char *buf, size_t count)
{
	struct damon_sysfs_ul_range *range = container_of(kobj,
			struct damon_sysfs_ul_range, kobj);
	unsigned long min;
	int err;

	err = kstrtoul(buf, 0, &max);
-	if (err)
+	if (err || max <= range->min)
		return -EINVAL;

	range->max = max;
	return count;
}

> +static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct damon_sysfs_ul_range *range = container_of(kobj,
> +			struct damon_sysfs_ul_range, kobj);
> +	unsigned long min;
> +	int err;
> +
> +	err = kstrtoul(buf, 0, &min);
> +	if (err)
> +		return -EINVAL;
> +
> +	range->min = min;
> +	return count;
> +}
> +
> +static ssize_t max_show(struct kobject *kobj, struct kobj_attribute *attr,
> +		char *buf)
> +{
> +	struct damon_sysfs_ul_range *range = container_of(kobj,
> +			struct damon_sysfs_ul_range, kobj);
> +
> +	return sysfs_emit(buf, "%lu\n", range->max);
> +}
> +
> +static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct damon_sysfs_ul_range *range = container_of(kobj,
> +			struct damon_sysfs_ul_range, kobj);
> +	unsigned long max;
> +	int err;
> +
> +	err = kstrtoul(buf, 0, &max);
> +	if (err)
> +		return -EINVAL;
> +
> +	range->max = max;
> +	return count;
> +}
> +
> +static void damon_sysfs_ul_range_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct damon_sysfs_ul_range, kobj));
> +}
> +
> +static struct kobj_attribute damon_sysfs_ul_range_min_attr =
> +		__ATTR_RW_MODE(min, 0600);
> +
> +static struct kobj_attribute damon_sysfs_ul_range_max_attr =
> +		__ATTR_RW_MODE(max, 0600);
> +
> +static struct attribute *damon_sysfs_ul_range_attrs[] = {
> +	&damon_sysfs_ul_range_min_attr.attr,
> +	&damon_sysfs_ul_range_max_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_ul_range);
> +
> +static struct kobj_type damon_sysfs_ul_range_ktype = {
> +	.release = damon_sysfs_ul_range_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_ul_range_groups,
> +};
> +
> +/*
> + * target directory
> + */
> +
> +struct damon_sysfs_target {
> +	struct kobject kobj;
> +	int pid;
> +};
> +
> +static struct damon_sysfs_target *damon_sysfs_target_alloc(void)
> +{
> +	return kzalloc(sizeof(struct damon_sysfs_target), GFP_KERNEL);
> +}
> +
> +static ssize_t pid_target_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_target *target = container_of(kobj,
> +			struct damon_sysfs_target, kobj);
> +
> +	return sysfs_emit(buf, "%d\n", target->pid);
> +}
> +
> +static ssize_t pid_target_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_target *target = container_of(kobj,
> +			struct damon_sysfs_target, kobj);
> +	int err = kstrtoint(buf, 0, &target->pid);
> +
> +	if (err)
> +		return -EINVAL;
> +	return count;
> +}
> +
> +static void damon_sysfs_target_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct damon_sysfs_target, kobj));
> +}
> +
> +static struct kobj_attribute damon_sysfs_target_pid_attr =
> +		__ATTR_RW_MODE(pid_target, 0600);
> +
> +static struct attribute *damon_sysfs_target_attrs[] = {
> +	&damon_sysfs_target_pid_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_target);
> +
> +static struct kobj_type damon_sysfs_target_ktype = {
> +	.release = damon_sysfs_target_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_target_groups,
> +};
> +
> +/*
> + * targets directory
> + */
> +
> +struct damon_sysfs_targets {
> +	struct kobject kobj;
> +	struct damon_sysfs_target **targets_arr;
> +	int nr;
> +};
> +
> +static struct damon_sysfs_targets *damon_sysfs_targets_alloc(void)
> +{
> +	return kzalloc(sizeof(struct damon_sysfs_targets), GFP_KERNEL);
> +}
> +
> +static void damon_sysfs_targets_rm_dirs(struct damon_sysfs_targets *targets)
> +{
> +	struct damon_sysfs_target **targets_arr = targets->targets_arr;
> +	int i;
> +
> +	for (i = 0; i < targets->nr; i++)
> +		kobject_put(&targets_arr[i]->kobj);
> +	targets->nr = 0;
> +	kfree(targets_arr);
> +	targets->targets_arr = NULL;
> +}
> +
> +static int damon_sysfs_targets_add_dirs(struct damon_sysfs_targets *targets,
> +		int nr_targets)
> +{
> +	struct damon_sysfs_target **targets_arr, *target;
> +	int err, i;
> +
> +	damon_sysfs_targets_rm_dirs(targets);
> +	if (!nr_targets)
> +		return 0;
> +
> +	targets_arr = kmalloc_array(nr_targets, sizeof(*targets_arr),
> +			GFP_KERNEL | __GFP_NOWARN);
> +	if (!targets_arr)
> +		return -ENOMEM;
> +	targets->targets_arr = targets_arr;
> +
> +	for (i = 0; i < nr_targets; i++) {
> +		target = damon_sysfs_target_alloc();
> +		if (!target) {
> +			damon_sysfs_targets_rm_dirs(targets);
> +			return -ENOMEM;
> +		}
> +
> +		err = kobject_init_and_add(&target->kobj,
> +				&damon_sysfs_target_ktype, &targets->kobj,
> +				"%d", i);
> +		if (err)
> +			goto out;
> +
> +		targets_arr[i] = target;
> +		targets->nr++;
> +	}
> +	return 0;
> +
> +out:
> +	damon_sysfs_targets_rm_dirs(targets);
> +	kobject_put(&target->kobj);
> +	return err;
> +}
> +
> +static ssize_t nr_targets_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_targets *targets = container_of(kobj,
> +			struct damon_sysfs_targets, kobj);
> +
> +	return sysfs_emit(buf, "%d\n", targets->nr);
> +}
> +
> +static ssize_t nr_targets_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_targets *targets = container_of(kobj,
> +			struct damon_sysfs_targets, kobj);
> +	int nr, err = kstrtoint(buf, 0, &nr);
> +
> +	if (err)
> +		return err;
> +	if (nr < 0)
> +		return -EINVAL;
> +
> +	if (!mutex_trylock(&damon_sysfs_lock))
> +		return -EBUSY;
> +	err = damon_sysfs_targets_add_dirs(targets, nr);
> +	mutex_unlock(&damon_sysfs_lock);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static void damon_sysfs_targets_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct damon_sysfs_targets, kobj));
> +}
> +
> +static struct kobj_attribute damon_sysfs_targets_nr_attr =
> +		__ATTR_RW_MODE(nr_targets, 0600);
> +
> +static struct attribute *damon_sysfs_targets_attrs[] = {
> +	&damon_sysfs_targets_nr_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_targets);
> +
> +static struct kobj_type damon_sysfs_targets_ktype = {
> +	.release = damon_sysfs_targets_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_targets_groups,
> +};
> +
> +/*
> + * intervals directory
> + */
> +
> +struct damon_sysfs_intervals {
> +	struct kobject kobj;
> +	unsigned long sample_us;
> +	unsigned long aggr_us;
> +	unsigned long update_us;
> +};
> +
> +static struct damon_sysfs_intervals *damon_sysfs_intervals_alloc(
> +		unsigned long sample_us, unsigned long aggr_us,
> +		unsigned long update_us)
> +{
> +	struct damon_sysfs_intervals *intervals = kmalloc(sizeof(*intervals),
> +			GFP_KERNEL);
> +
> +	if (!intervals)
> +		return NULL;
> +
> +	intervals->kobj = (struct kobject){};
> +	intervals->sample_us = sample_us;
> +	intervals->aggr_us = aggr_us;
> +	intervals->update_us = update_us;
> +	return intervals;
> +}
> +
> +static ssize_t sample_us_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_intervals *intervals = container_of(kobj,
> +			struct damon_sysfs_intervals, kobj);
> +
> +	return sysfs_emit(buf, "%lu\n", intervals->sample_us);
> +}
> +
> +static ssize_t sample_us_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_intervals *intervals = container_of(kobj,
> +			struct damon_sysfs_intervals, kobj);
> +	unsigned long us;
> +	int err = kstrtoul(buf, 0, &us);
> +
> +	if (err)
> +		return -EINVAL;
> +
> +	intervals->sample_us = us;
> +	return count;
> +}
> +
> +static ssize_t aggr_us_show(struct kobject *kobj, struct kobj_attribute *attr,
> +		char *buf)
> +{
> +	struct damon_sysfs_intervals *intervals = container_of(kobj,
> +			struct damon_sysfs_intervals, kobj);
> +
> +	return sysfs_emit(buf, "%lu\n", intervals->aggr_us);
> +}
> +
> +static ssize_t aggr_us_store(struct kobject *kobj, struct kobj_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct damon_sysfs_intervals *intervals = container_of(kobj,
> +			struct damon_sysfs_intervals, kobj);
> +	unsigned long us;
> +	int err = kstrtoul(buf, 0, &us);
> +
> +	if (err)
> +		return -EINVAL;
> +
> +	intervals->aggr_us = us;
> +	return count;
> +}
> +
> +static ssize_t update_us_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_intervals *intervals = container_of(kobj,
> +			struct damon_sysfs_intervals, kobj);
> +
> +	return sysfs_emit(buf, "%lu\n", intervals->update_us);
> +}
> +
> +static ssize_t update_us_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_intervals *intervals = container_of(kobj,
> +			struct damon_sysfs_intervals, kobj);
> +	unsigned long us;
> +	int err = kstrtoul(buf, 0, &us);
> +
> +	if (err)
> +		return -EINVAL;
> +
> +	intervals->update_us = us;
> +	return count;
> +}
> +
> +static void damon_sysfs_intervals_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct damon_sysfs_intervals, kobj));
> +}
> +
> +static struct kobj_attribute damon_sysfs_intervals_sample_us_attr =
> +		__ATTR_RW_MODE(sample_us, 0600);
> +
> +static struct kobj_attribute damon_sysfs_intervals_aggr_us_attr =
> +		__ATTR_RW_MODE(aggr_us, 0600);
> +
> +static struct kobj_attribute damon_sysfs_intervals_update_us_attr =
> +		__ATTR_RW_MODE(update_us, 0600);
> +
> +static struct attribute *damon_sysfs_intervals_attrs[] = {
> +	&damon_sysfs_intervals_sample_us_attr.attr,
> +	&damon_sysfs_intervals_aggr_us_attr.attr,
> +	&damon_sysfs_intervals_update_us_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_intervals);
> +
> +static struct kobj_type damon_sysfs_intervals_ktype = {
> +	.release = damon_sysfs_intervals_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_intervals_groups,
> +};
> +
> +/*
> + * monitoring_attrs directory
> + */
> +
> +struct damon_sysfs_attrs {
> +	struct kobject kobj;
> +	struct damon_sysfs_intervals *intervals;
> +	struct damon_sysfs_ul_range *nr_regions_range;
> +};
> +
> +static struct damon_sysfs_attrs *damon_sysfs_attrs_alloc(void)
> +{
> +	struct damon_sysfs_attrs *attrs = kmalloc(sizeof(*attrs), GFP_KERNEL);
> +
> +	if (!attrs)
> +		return NULL;
> +	attrs->kobj = (struct kobject){};
> +	return attrs;
> +}
> +
> +static int damon_sysfs_attrs_add_dirs(struct damon_sysfs_attrs *attrs)
> +{
> +	struct damon_sysfs_intervals *intervals;
> +	struct damon_sysfs_ul_range *nr_regions_range;
> +	int err;
> +
> +	intervals = damon_sysfs_intervals_alloc(5000, 100000, 60000000);
> +	if (!intervals)
> +		return -ENOMEM;
> +
> +	err = kobject_init_and_add(&intervals->kobj,
> +			&damon_sysfs_intervals_ktype, &attrs->kobj,
> +			"intervals");
> +	if (err)
> +		goto put_intervals_out;
> +	attrs->intervals = intervals;
> +
> +	nr_regions_range = damon_sysfs_ul_range_alloc(10, 1000);
> +	if (!nr_regions_range)
> +		goto put_intervals_out;
> +
> +	err = kobject_init_and_add(&nr_regions_range->kobj,
> +			&damon_sysfs_ul_range_ktype, &attrs->kobj,
> +			"nr_regions");
> +	if (err)
> +		goto put_nr_regions_intervals_out;
> +	attrs->nr_regions_range = nr_regions_range;
> +	return 0;
> +
> +put_nr_regions_intervals_out:
> +	kobject_put(&nr_regions_range->kobj);
> +	attrs->nr_regions_range = NULL;
> +put_intervals_out:
> +	kobject_put(&intervals->kobj);
> +	attrs->intervals = NULL;
> +	return err;
> +}
> +
> +static void damon_sysfs_attrs_rm_dirs(struct damon_sysfs_attrs *attrs)
> +{
> +	kobject_put(&attrs->nr_regions_range->kobj);
> +	kobject_put(&attrs->intervals->kobj);
> +}
> +
> +static void damon_sysfs_attrs_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct damon_sysfs_attrs, kobj));
> +}
> +
> +static struct attribute *damon_sysfs_attrs_attrs[] = {
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_attrs);
> +
> +static struct kobj_type damon_sysfs_attrs_ktype = {
> +	.release = damon_sysfs_attrs_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_attrs_groups,
> +};
> +
> +/*
> + * context directory
> + */
> +
> +/* This should match with enum damon_ops_id */
> +static const char * const damon_sysfs_ops_strs[] = {
> +	"vaddr",
> +	"paddr",
> +};
> +
> +struct damon_sysfs_context {
> +	struct kobject kobj;
> +	enum damon_ops_id ops_id;
> +	struct damon_sysfs_attrs *attrs;
> +	struct damon_sysfs_targets *targets;
> +};
> +
> +static struct damon_sysfs_context *damon_sysfs_context_alloc(
> +		enum damon_ops_id ops_id)
> +{
> +	struct damon_sysfs_context *context = kmalloc(sizeof(*context),
> +				GFP_KERNEL);
> +
> +	if (!context)
> +		return NULL;
> +	context->kobj = (struct kobject){};
> +	context->ops_id = ops_id;
> +	return context;
> +}
> +
> +static int damon_sysfs_context_set_attrs(struct damon_sysfs_context *context)
> +{
> +	struct damon_sysfs_attrs *attrs = damon_sysfs_attrs_alloc();
> +	int err;
> +
> +	if (!attrs)
> +		return -ENOMEM;
> +	err = kobject_init_and_add(&attrs->kobj, &damon_sysfs_attrs_ktype,
> +			&context->kobj, "monitoring_attrs");
> +	if (err)
> +		goto out;
> +	err = damon_sysfs_attrs_add_dirs(attrs);
> +	if (err)
> +		goto out;
> +	context->attrs = attrs;
> +	return 0;
> +
> +out:
> +	kobject_put(&attrs->kobj);
> +	return err;
> +}
> +
> +static int damon_sysfs_context_set_targets(struct damon_sysfs_context *context)
> +{
> +	struct damon_sysfs_targets *targets = damon_sysfs_targets_alloc();
> +	int err;
> +
> +	if (!targets)
> +		return -ENOMEM;
> +	err = kobject_init_and_add(&targets->kobj, &damon_sysfs_targets_ktype,
> +			&context->kobj, "targets");
> +	if (err) {
> +		kobject_put(&targets->kobj);
> +		return err;
> +	}
> +	context->targets = targets;
> +	return 0;
> +}
> +
> +static int damon_sysfs_context_add_dirs(struct damon_sysfs_context *context)
> +{
> +	int err;
> +
> +	err = damon_sysfs_context_set_attrs(context);
> +	if (err)
> +		return err;
> +
> +	err = damon_sysfs_context_set_targets(context);
> +	if (err)
> +		goto put_attrs_out;
> +	return 0;
> +
> +put_attrs_out:
> +	kobject_put(&context->attrs->kobj);
> +	context->attrs = NULL;
> +	return err;
> +}
> +
> +static void damon_sysfs_context_rm_dirs(struct damon_sysfs_context *context)
> +{
> +	damon_sysfs_attrs_rm_dirs(context->attrs);
> +	kobject_put(&context->attrs->kobj);
> +	damon_sysfs_targets_rm_dirs(context->targets);
> +	kobject_put(&context->targets->kobj);
> +}
> +
> +static ssize_t operations_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_context *context = container_of(kobj,
> +			struct damon_sysfs_context, kobj);
> +
> +	return sysfs_emit(buf, "%s\n", damon_sysfs_ops_strs[context->ops_id]);
> +}
> +
> +static ssize_t operations_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_context *context = container_of(kobj,
> +			struct damon_sysfs_context, kobj);
> +	enum damon_ops_id id;
> +
> +	for (id = 0; id < NR_DAMON_OPS; id++) {
> +		if (sysfs_streq(buf, damon_sysfs_ops_strs[id])) {
> +			/* Support only vaddr */
> +			if (id != DAMON_OPS_VADDR)
> +				return -EINVAL;
> +			context->ops_id = id;
> +			return count;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static void damon_sysfs_context_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct damon_sysfs_context, kobj));
> +}
> +
> +static struct kobj_attribute damon_sysfs_context_operations_attr =
> +		__ATTR_RW_MODE(operations, 0600);
> +
> +static struct attribute *damon_sysfs_context_attrs[] = {
> +	&damon_sysfs_context_operations_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_context);
> +
> +static struct kobj_type damon_sysfs_context_ktype = {
> +	.release = damon_sysfs_context_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_context_groups,
> +};
> +
> +/*
> + * contexts directory
> + */
> +
> +struct damon_sysfs_contexts {
> +	struct kobject kobj;
> +	struct damon_sysfs_context **contexts_arr;
> +	int nr;
> +};
> +
> +static struct damon_sysfs_contexts *damon_sysfs_contexts_alloc(void)
> +{
> +	return kzalloc(sizeof(struct damon_sysfs_contexts), GFP_KERNEL);
> +}
> +
> +static void damon_sysfs_contexts_rm_dirs(struct damon_sysfs_contexts *contexts)
> +{
> +	struct damon_sysfs_context **contexts_arr = contexts->contexts_arr;
> +	int i;
> +
> +	for (i = 0; i < contexts->nr; i++) {
> +		damon_sysfs_context_rm_dirs(contexts_arr[i]);
> +		kobject_put(&contexts_arr[i]->kobj);
> +	}
> +	contexts->nr = 0;
> +	kfree(contexts_arr);
> +	contexts->contexts_arr = NULL;
> +}
> +
> +static int damon_sysfs_contexts_add_dirs(struct damon_sysfs_contexts *contexts,
> +		int nr_contexts)
> +{
> +	struct damon_sysfs_context **contexts_arr, *context;
> +	int err, i;
> +
> +	damon_sysfs_contexts_rm_dirs(contexts);
> +	if (!nr_contexts)
> +		return 0;
> +
> +	contexts_arr = kmalloc_array(nr_contexts, sizeof(*contexts_arr),
> +			GFP_KERNEL | __GFP_NOWARN);
> +	if (!contexts_arr)
> +		return -ENOMEM;
> +	contexts->contexts_arr = contexts_arr;
> +
> +	for (i = 0; i < nr_contexts; i++) {
> +		context = damon_sysfs_context_alloc(DAMON_OPS_VADDR);
> +		if (!context) {
> +			damon_sysfs_contexts_rm_dirs(contexts);
> +			return -ENOMEM;
> +		}
> +
> +		err = kobject_init_and_add(&context->kobj,
> +				&damon_sysfs_context_ktype, &contexts->kobj,
> +				"%d", i);
> +		if (err)
> +			goto out;
> +
> +		err = damon_sysfs_context_add_dirs(context);
> +		if (err)
> +			goto out;
> +
> +		contexts_arr[i] = context;
> +		contexts->nr++;
> +	}
> +	return 0;
> +
> +out:
> +	damon_sysfs_contexts_rm_dirs(contexts);
> +	kobject_put(&context->kobj);
> +	return err;
> +}
> +
> +static ssize_t nr_contexts_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_contexts *contexts = container_of(kobj,
> +			struct damon_sysfs_contexts, kobj);
> +
> +	return sysfs_emit(buf, "%d\n", contexts->nr);
> +}
> +
> +static ssize_t nr_contexts_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_contexts *contexts = container_of(kobj,
> +			struct damon_sysfs_contexts, kobj);
> +	int nr, err;
> +
> +	err = kstrtoint(buf, 0, &nr);
> +	if (err)
> +		return err;
> +	/* TODO: support multiple contexts per kdamond */
> +	if (nr < 0 || 1 < nr)
> +		return -EINVAL;
> +
> +	if (!mutex_trylock(&damon_sysfs_lock))
> +		return -EBUSY;
> +	err = damon_sysfs_contexts_add_dirs(contexts, nr);
> +	mutex_unlock(&damon_sysfs_lock);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static void damon_sysfs_contexts_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct damon_sysfs_contexts, kobj));
> +}
> +
> +static struct kobj_attribute damon_sysfs_contexts_nr_attr
> +		= __ATTR_RW_MODE(nr_contexts, 0600);
> +
> +static struct attribute *damon_sysfs_contexts_attrs[] = {
> +	&damon_sysfs_contexts_nr_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_contexts);
> +
> +static struct kobj_type damon_sysfs_contexts_ktype = {
> +	.release = damon_sysfs_contexts_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_contexts_groups,
> +};
> +
> +/*
> + * kdamond directory
> + */
> +
> +struct damon_sysfs_kdamond {
> +	struct kobject kobj;
> +	struct damon_sysfs_contexts *contexts;
> +	struct damon_ctx *damon_ctx;
> +};
> +
> +static struct damon_sysfs_kdamond *damon_sysfs_kdamond_alloc(void)
> +{
> +	return kzalloc(sizeof(struct damon_sysfs_kdamond), GFP_KERNEL);
> +}
> +
> +static int damon_sysfs_kdamond_add_dirs(struct damon_sysfs_kdamond *kdamond)
> +{
> +	struct damon_sysfs_contexts *contexts;
> +	int err;
> +
> +	contexts = damon_sysfs_contexts_alloc();
> +	if (!contexts)
> +		return -ENOMEM;
> +
> +	err = kobject_init_and_add(&contexts->kobj,
> +			&damon_sysfs_contexts_ktype, &kdamond->kobj,
> +			"contexts");
> +	if (err) {
> +		kobject_put(&contexts->kobj);
> +		return err;
> +	}
> +	kdamond->contexts = contexts;
> +
> +	return err;
> +}
> +
> +static void damon_sysfs_kdamond_rm_dirs(struct damon_sysfs_kdamond *kdamond)
> +{
> +	damon_sysfs_contexts_rm_dirs(kdamond->contexts);
> +	kobject_put(&kdamond->contexts->kobj);
> +}
> +
> +static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
> +		char *buf)
> +{
> +	return -EINVAL;
> +}
> +
> +static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	return -EINVAL;
> +}
> +
> +static ssize_t pid_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	return -EINVAL;
> +}
> +
> +static void damon_sysfs_kdamond_release(struct kobject *kobj)
> +{
> +	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
> +			struct damon_sysfs_kdamond, kobj);
> +
> +	if (kdamond->damon_ctx)
> +		damon_destroy_ctx(kdamond->damon_ctx);
> +	kfree(container_of(kobj, struct damon_sysfs_kdamond, kobj));
> +}
> +
> +static struct kobj_attribute damon_sysfs_kdamond_state_attr =
> +		__ATTR_RW_MODE(state, 0600);
> +
> +static struct kobj_attribute damon_sysfs_kdamond_pid_attr =
> +		__ATTR_RO_MODE(pid, 0400);
> +
> +static struct attribute *damon_sysfs_kdamond_attrs[] = {
> +	&damon_sysfs_kdamond_state_attr.attr,
> +	&damon_sysfs_kdamond_pid_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_kdamond);
> +
> +static struct kobj_type damon_sysfs_kdamond_ktype = {
> +	.release = damon_sysfs_kdamond_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_kdamond_groups,
> +};
> +
> +/*
> + * kdamonds directory
> + */
> +
> +struct damon_sysfs_kdamonds {
> +	struct kobject kobj;
> +	struct damon_sysfs_kdamond **kdamonds_arr;
> +	int nr;
> +};
> +
> +static struct damon_sysfs_kdamonds *damon_sysfs_kdamonds_alloc(void)
> +{
> +	return kzalloc(sizeof(struct damon_sysfs_kdamonds), GFP_KERNEL);
> +}
> +
> +static void damon_sysfs_kdamonds_rm_dirs(struct damon_sysfs_kdamonds *kdamonds)
> +{
> +	struct damon_sysfs_kdamond **kdamonds_arr = kdamonds->kdamonds_arr;
> +	int i;
> +
> +	for (i = 0; i < kdamonds->nr; i++) {
> +		damon_sysfs_kdamond_rm_dirs(kdamonds_arr[i]);
> +		kobject_put(&kdamonds_arr[i]->kobj);
> +	}
> +	kdamonds->nr = 0;
> +	kfree(kdamonds_arr);
> +	kdamonds->kdamonds_arr = NULL;
> +}
> +
> +static int damon_sysfs_nr_running_ctxs(struct damon_sysfs_kdamond **kdamonds,
> +		int nr_kdamonds)
> +{
> +	int nr_running_ctxs = 0;
> +	int i;
> +
> +	for (i = 0; i < nr_kdamonds; i++) {
> +		struct damon_ctx *ctx = kdamonds[i]->damon_ctx;
> +
> +		if (!ctx)
> +			continue;
> +		mutex_lock(&ctx->kdamond_lock);
> +		if (ctx->kdamond)
> +			nr_running_ctxs++;
> +		mutex_unlock(&ctx->kdamond_lock);
> +	}
> +	return nr_running_ctxs;
> +}
> +
> +static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
> +		int nr_kdamonds)
> +{
> +	struct damon_sysfs_kdamond **kdamonds_arr, *kdamond;
> +	int err, i;
> +
> +	if (damon_sysfs_nr_running_ctxs(kdamonds->kdamonds_arr, kdamonds->nr))
> +		return -EBUSY;
> +
> +	damon_sysfs_kdamonds_rm_dirs(kdamonds);
> +	if (!nr_kdamonds)
> +		return 0;
> +
> +	kdamonds_arr = kmalloc_array(nr_kdamonds, sizeof(*kdamonds_arr),
> +			GFP_KERNEL | __GFP_NOWARN);
> +	if (!kdamonds_arr)
> +		return -ENOMEM;
> +	kdamonds->kdamonds_arr = kdamonds_arr;
> +
> +	for (i = 0; i < nr_kdamonds; i++) {
> +		kdamond = damon_sysfs_kdamond_alloc();
> +		if (!kdamond) {
> +			damon_sysfs_kdamonds_rm_dirs(kdamonds);
> +			return -ENOMEM;
> +		}
> +
> +		err = kobject_init_and_add(&kdamond->kobj,
> +				&damon_sysfs_kdamond_ktype, &kdamonds->kobj,
> +				"%d", i);
> +		if (err)
> +			goto out;
> +
> +		err = damon_sysfs_kdamond_add_dirs(kdamond);
> +		if (err)
> +			goto out;
> +
> +		kdamonds_arr[i] = kdamond;
> +		kdamonds->nr++;
> +	}
> +	return 0;
> +
> +out:
> +	damon_sysfs_kdamonds_rm_dirs(kdamonds);
> +	kobject_put(&kdamond->kobj);
> +	return err;
> +}
> +
> +static ssize_t nr_kdamonds_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
> +			struct damon_sysfs_kdamonds, kobj);
> +
> +	return sysfs_emit(buf, "%d\n", kdamonds->nr);
> +}
> +
> +static ssize_t nr_kdamonds_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_kdamonds *kdamonds = container_of(kobj,
> +			struct damon_sysfs_kdamonds, kobj);
> +	int nr, err;
> +
> +	err = kstrtoint(buf, 0, &nr);
> +	if (err)
> +		return err;
> +	if (nr < 0)
> +		return -EINVAL;
> +
> +	if (!mutex_trylock(&damon_sysfs_lock))
> +		return -EBUSY;
> +	err = damon_sysfs_kdamonds_add_dirs(kdamonds, nr);
> +	mutex_unlock(&damon_sysfs_lock);
> +	if (err)
> +		return err;
> +
> +	return count;
> +}
> +
> +static void damon_sysfs_kdamonds_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct damon_sysfs_kdamonds, kobj));
> +}
> +
> +static struct kobj_attribute damon_sysfs_kdamonds_nr_attr =
> +		__ATTR_RW_MODE(nr_kdamonds, 0600);
> +
> +static struct attribute *damon_sysfs_kdamonds_attrs[] = {
> +	&damon_sysfs_kdamonds_nr_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_kdamonds);
> +
> +static struct kobj_type damon_sysfs_kdamonds_ktype = {
> +	.release = damon_sysfs_kdamonds_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_kdamonds_groups,
> +};
> +
> +/*
> + * damon user interface directory
> + */
> +
> +struct damon_sysfs_ui_dir {
> +	struct kobject kobj;
> +	struct damon_sysfs_kdamonds *kdamonds;
> +};
> +
> +static struct damon_sysfs_ui_dir *damon_sysfs_ui_dir_alloc(void)
> +{
> +	return kzalloc(sizeof(struct damon_sysfs_ui_dir), GFP_KERNEL);
> +}
> +
> +static int damon_sysfs_ui_dir_add_dirs(struct damon_sysfs_ui_dir *ui_dir)
> +{
> +	struct damon_sysfs_kdamonds *kdamonds;
> +	int err;
> +
> +	kdamonds = damon_sysfs_kdamonds_alloc();
> +	if (!kdamonds)
> +		return -ENOMEM;
> +
> +	err = kobject_init_and_add(&kdamonds->kobj,
> +			&damon_sysfs_kdamonds_ktype, &ui_dir->kobj,
> +			"kdamonds");
> +	if (err) {
> +		kobject_put(&kdamonds->kobj);
> +		return err;
> +	}
> +	ui_dir->kdamonds = kdamonds;
> +	return err;
> +}
> +
> +static void damon_sysfs_ui_dir_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct damon_sysfs_ui_dir, kobj));
> +}
> +
> +static struct attribute *damon_sysfs_ui_dir_attrs[] = {
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_ui_dir);
> +
> +static struct kobj_type damon_sysfs_ui_dir_ktype = {
> +	.release = damon_sysfs_ui_dir_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = damon_sysfs_ui_dir_groups,
> +};
> +
> +static int __init damon_sysfs_init(void)
> +{
> +	struct kobject *damon_sysfs_root;
> +	struct damon_sysfs_ui_dir *admin;
> +	int err;
> +
> +	damon_sysfs_root = kobject_create_and_add("damon", mm_kobj);
> +	if (!damon_sysfs_root)
> +		return -ENOMEM;
> +
> +	admin = damon_sysfs_ui_dir_alloc();
> +	if (!admin) {
> +		kobject_put(damon_sysfs_root);
> +		return -ENOMEM;
> +	}
> +	err = kobject_init_and_add(&admin->kobj, &damon_sysfs_ui_dir_ktype,
> +			damon_sysfs_root, "admin");
> +	if (err)
> +		goto out;
> +	err = damon_sysfs_ui_dir_add_dirs(admin);
> +	if (err)
> +		goto out;
> +	return 0;
> +
> +out:
> +	kobject_put(&admin->kobj);
> +	kobject_put(damon_sysfs_root);
> +	return err;
> +}
> +subsys_initcall(damon_sysfs_init);

-- 
Best Regards!
Xin Hao

