Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7164C71A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Feb 2022 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiB1QYF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 11:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiB1QYE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 11:24:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FBB49F23;
        Mon, 28 Feb 2022 08:23:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5E75B81229;
        Mon, 28 Feb 2022 16:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FD8C340E7;
        Mon, 28 Feb 2022 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646065402;
        bh=4uwUbtFzUaPQDZkQalpW48JK5+hWGBKg6MdMcnnUZM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=bHFmNnssY5Wmor9erI1rBF/Nrqyn6U0q4md+d76eNWWpYLtwvmt1Un+e0ubpKGaUS
         NhxReyE0A1hdAAofrECxThFI+RvJdGK4kUTF82sdYmA8tf3qUi1hMyfE8bGw5y0HaL
         LLw1zDkoyX1tflw6SRVHuI/l3HnWhYWiTamRlZpuhNJgFcVrKt/rgvDiqSET/Cfgnx
         HAn50WvP45NdTTun1u+AI4tst8J9zLDAPE8aiCsyUSBW32Ye/uC71Z1ANHkOINCkKN
         QcgKmyuq2Zt4qLgkh98AH1qeyC26kBsz/RqBqyJ8tuYefstecWvBhplJG9ZEZZwbbG
         ZkJhlTK4dUVHg==
From:   SeongJae Park <sj@kernel.org>
To:     xhao@linux.alibaba.com
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        gregkh@linuxfoundation.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/13] mm/damon: Implement a minimal stub for sysfs-based DAMON interface
Date:   Mon, 28 Feb 2022 16:23:18 +0000
Message-Id: <20220228162318.4046-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <0f1051ce-2ce7-8659-f881-b5889018b8a2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Xin,

On Tue, 1 Mar 2022 00:09:35 +0800 xhao@linux.alibaba.com wrote:

> Hi SeongJae:
> 
> On 2/28/22 4:13 PM, SeongJae Park wrote:
> > DAMON's debugfs-based user interface served very well, so far.  However,
> > it unnecessarily depends on debugfs, while DAMON is not aimed to be used
> > for only debugging.  Also, the interface receives multiple values via
> > one file.  For example, schemes file receives 18 values separated by
> > white spaces.  As a result, it is ineffient, hard to be used, and
> > difficult to be extended.  Especially, keeping backward compatibility of
> > user space tools is getting only challenging.  It would be better to
> > implement another reliable and flexible interface and deprecate the
> > debugfs interface in long term.
> >
> > To this end, this commit implements a stub of a part of the new user
> > interface of DAMON using sysfs.  Specifically, this commit implements
> > the sysfs control parts for virtual address space monitoring.
> >
> > More specifically, the idea of the new interface is, using directory
> > hierarchies and making one file for one value.  The hierarchy that this
> > commit is introducing is as below.  In the below figure,
> > parents-children relations are represented with indentations, each
> > directory is having ``/`` suffix, and files in each directory are
> > separated by comma (",").
> >
> >      /sys/kernel/mm/damon/admin
> >      │ kdamonds/nr_kdamonds
> >      │ │ 0/state,pid
> >      │ │ │ contexts/nr_contexts
> >      │ │ │ │ 0/operations
> >      │ │ │ │ │ monitoring_attrs/
> >      │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
> >      │ │ │ │ │ │ nr_regions/min,max
> >      │ │ │ │ │ targets/nr_targets
> >      │ │ │ │ │ │ 0/pid_target
> >      │ │ │ │ │ │ ...
> >      │ │ │ │ ...
> >      │ │ ...
> >
> > Writing a number <N> to each 'nr' file makes directories of name <0> to
> > <N-1> in the directory of the 'nr' file.  That's all this commit does.
> > Writing proper values to relevant files will construct the DAMON
> > contexts, and writing a special keyword, 'on', to 'state' files for each
> > kdamond will ask DAMON to start the constructed contexts.
> >
> > For a short example, using below commands for
> > monitoring virtual address spaces of a given workload is imaginable:
> >
> >      # cd /sys/kernel/mm/damon/admin/
> >      # echo 1 > kdamonds/nr_kdamonds
> >      # echo 1 > kdamonds/0/contexts/nr_contexts
> >      # echo vaddr > kdamonds/0/contexts/0/operations
> >      # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
> >      # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
> >      # echo on > kdamonds/0/state
> >
> > Please note that this commit is implementing only the sysfs part stub as
> > abovely mentioned.  This commit doesn't implement the special keywords
> > for 'state' files.  Following commits will do that.
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >   mm/damon/Kconfig  |    7 +
> >   mm/damon/Makefile |    1 +
> >   mm/damon/sysfs.c  | 1082 +++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 1090 insertions(+)
> >   create mode 100644 mm/damon/sysfs.c
> >
> > diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> > index 01bad77ad7ae..9b559c76d6dd 100644
> > --- a/mm/damon/Kconfig
> > +++ b/mm/damon/Kconfig
> > @@ -52,6 +52,13 @@ config DAMON_VADDR_KUNIT_TEST
> >   
> >   	  If unsure, say N.
> >   
> > +config DAMON_SYSFS
> > +	bool "DAMON sysfs interface"
> > +	depends on DAMON && SYSFS
> > +	help
> > +	  This builds the sysfs interface for DAMON.  The user space can use
> > +	  the interface for arbitrary data access monitoring.
> > +
> >   config DAMON_DBGFS
> >   	bool "DAMON debugfs interface"
> >   	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
> > diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> > index aebbf6c14c51..dbf7190b4144 100644
> > --- a/mm/damon/Makefile
> > +++ b/mm/damon/Makefile
> > @@ -3,5 +3,6 @@
> >   obj-y				:= core.o
> >   obj-$(CONFIG_DAMON_VADDR)	+= ops-common.o vaddr.o
> >   obj-$(CONFIG_DAMON_PADDR)	+= ops-common.o paddr.o
> > +obj-$(CONFIG_DAMON_SYSFS)	+= sysfs.o
> >   obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
> >   obj-$(CONFIG_DAMON_RECLAIM)	+= reclaim.o
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > new file mode 100644
> > index 000000000000..87cf28ae6a6f
> > --- /dev/null
> > +++ b/mm/damon/sysfs.c
> > @@ -0,0 +1,1082 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DAMON sysfs Interface
> > + *
> > + * Copyright (c) 2022 SeongJae Park <sj@kernel.org>
> > + */
> > +
> > +#include <linux/damon.h>
> > +#include <linux/kobject.h>
> > +#include <linux/pid.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +
> > +static DEFINE_MUTEX(damon_sysfs_lock);
> > +
> > +/*
> > + * unsigned long range directory
> > + */
> > +
> > +struct damon_sysfs_ul_range {
> > +	struct kobject kobj;
> > +	unsigned long min;
> > +	unsigned long max;
> > +};
> > +
> > +static struct damon_sysfs_ul_range *damon_sysfs_ul_range_alloc(
> > +		unsigned long min,
> > +		unsigned long max)
> > +{
> > +	struct damon_sysfs_ul_range *range = kmalloc(sizeof(*range),
> > +			GFP_KERNEL);
> > +
> > +	if (!range)
> > +		return NULL;
> > +	range->kobj = (struct kobject){};
> > +	range->min = min;
> > +	range->max = max;
> > +
> > +	return range;
> > +}
> > +
> > +static ssize_t min_show(struct kobject *kobj, struct kobj_attribute *attr,
> > +		char *buf)
> > +{
> > +	struct damon_sysfs_ul_range *range = container_of(kobj,
> > +			struct damon_sysfs_ul_range, kobj);
> > +
> > +	return sysfs_emit(buf, "%lu\n", range->min);
> > +}
> > +
> 
> I have do some test about interface "min" and "max",  it looks have some 
> bugs.
> 
> [root@rt2k03395 nr_regions]# echo 10 > max
> [root@rt2k03395 nr_regions]# echo 20 > min
> [root@rt2k03395 nr_regions]# ls
> [root@rt2k03395 nr_regions]# cat max
> 10
> [root@rt2k03395 nr_regions]# cat min
> 20
> 
> how about do some fix like this:

It's an intended behavior.  The intention is to let the users put input in any
order (e.g., writing min first and then max later), and check the validity just
before applying the input to DAMON, which is, when writing 'on' to the 'status'
file.  One additional advantage of this is confining the validity check in one
place and therefore management of the code could be a little bit simpler.

So, I think the fix is not really needed.


Thanks,
SJ

[...]
