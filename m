Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5414C4734
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 15:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiBYOQY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 09:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiBYOQW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 09:16:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4235E1FEFB3;
        Fri, 25 Feb 2022 06:15:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98F57B830C8;
        Fri, 25 Feb 2022 14:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D657C340F1;
        Fri, 25 Feb 2022 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645798546;
        bh=n82Y8RnPpfY02Xrsn+QUdZbrEExyxQmU1+/ez3ckXGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=sD99tTC1niVnsEBA+ICbWcLbHs0BaiBg/w8nPZPxjfEhEGPMUgoMperxUmq4+7mOq
         HBrm6zFrGmNtn8czhnWuxPKOVXl9Xz69TCqFbflCyALo+AD8U6slDr0ci3Ne5UxtNf
         Kv7xJ/ZR9J9Z/pV7qFYxezi+IPyWPXXwgFllMiQFZv86E4W+/E5wVVW8CPl2T4Mzae
         EyY8+vyNrWPdlwZqziMBcjqW04B7SPzwZR23UScBj6DCF/jJsbGLP2sUifDozQemp5
         cPc3B9A+4HNgVcgZOwl7lo70raTESwspGEX3oylTz8UTlkMEhkF1lKr3M4MI/sSzmo
         5hllAB4MNJBaA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, akpm@linux-foundation.org,
        corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] Docs/ABI/testing: Add DAMON sysfs interface ABI document
Date:   Fri, 25 Feb 2022 14:15:40 +0000
Message-Id: <20220225141540.13082-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225141007.12974-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 25 Feb 2022 14:10:07 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hello Gregg,
> 
> 
> On Fri, 25 Feb 2022 13:23:00 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Fri, 25 Feb 2022 14:18:59 +0100 Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Fri, Feb 25, 2022 at 01:07:12PM +0000, SeongJae Park wrote:
> > > > This commit adds DAMON sysfs interface ABI document under
> > > > Documentation/ABI/testing.
> > > > 
> > > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > > ---
> > > >  .../ABI/testing/sysfs-kernel-mm-damon         | 276 ++++++++++++++++++
> > > >  MAINTAINERS                                   |   1 +
> > > >  2 files changed, 277 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-damon
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > > > new file mode 100644
> > > > index 000000000000..11984c3a4b55
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> > > > @@ -0,0 +1,276 @@
> > > > +what:		/sys/kernel/mm/damon/
> > > > +Date:		Feb 2022
> > > > +Contact:	SeongJae Park <sj@kernel.org>
> > > > +Description:	Interface for Data Access MONitoring (DAMON).
> > > > +		See Documentation/admin-guide/mm/damon/index.rst for details.
> > > 
> > > Ick, no.  Put the real details in here please.  That way it works with
> > > our tools.
> > 
> > Ok, thanks for the quick comment!
> 
> Before sending the full series again, I'd like to get your comment if you're
> ok.  What do you think about below?
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> new file mode 100644
> index 000000000000..11984c3a4b55
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> @@ -0,0 +1,276 @@
> +what:		/sys/kernel/mm/damon/
> +Date:		Feb 2022
> +Contact:	SeongJae Park <sj@kernel.org>
> +Description:	Interface for Data Access MONitoring (DAMON).
> +		See Documentation/admin-guide/mm/damon/index.rst for details.

Oops, I pasted wrong, sorry.  Please read below:

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
new file mode 100644
index 000000000000..e58d844b4f82
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -0,0 +1,273 @@
+what:		/sys/kernel/mm/damon/
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Interface for Data Access MONitoring (DAMON).  Contains files
+		for controlling DAMON.
+
+What:		/sys/kernel/mm/damon/admin/
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Interface for privileged users of DAMON.  Contains files for
+		controlling DAMON that aimed to be used by privileged users.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON worker thread (kdamond)
+		named '0' to 'N-1' under the kdamonds/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/state
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
+		stops, respectively.  Reading the file returns the keywords
+		based on the current status.  Writing 'update_schemes_stats' to
+		the file updates contents of schemes stats files of the
+		kdamond.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the pid of the kdamond if it is
+		running.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/nr_contexts
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON context named '0' to
+		'N-1' under the contexts/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/operations
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a keyword for a monitoring operations set ('vaddr' for
+		virtual address spaces monitoring, and 'paddr' for the physical
+		address space monitoring) to this file makes the context to use
+		the operations set.  Reading the file returns the keyword for
+		the operations set the context is set to use.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the sampling interval of the
+		DAMON context in microseconds as the value.  Reading this file
+		returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/aggr_us
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the aggregation interval of
+		the DAMON context in microseconds as the value.  Reading this
+		file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/update_us
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the update interval of the
+		DAMON context in microseconds as the value.  Reading this file
+		returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/nr_regions/min
+
+WDate:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the minimum number of
+		monitoring regions of the DAMON context as the value.  Reading
+		this file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/nr_regions/max
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the maximum number of
+		monitoring regions of the DAMON context as the value.  Reading
+		this file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/nr_targets
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON target of the context
+		named '0' to 'N-1' under the contexts/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/pid_target
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the pid of
+		the target process if the context is for virtual address spaces
+		monitoring, respectively.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/nr_regions
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for setting each DAMON target memory region of the
+		context named '0' to 'N-1' under the regions/ directory.  In
+		case of the virtual address space monitoring, DAMON
+		automatically sets the target memory region based on the target
+		processes' mappings.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/<R>/start
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the start
+		address of the monitoring region.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/<R>/end
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the end
+		address of the monitoring region.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/nr_schemes
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON-based operation scheme
+		of the context named '0' to 'N-1' under the schemes/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/action
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the action
+		of the scheme.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/sz/min
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the mimimum
+		size of the scheme's target regions in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/sz/max
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the maximum
+		size of the scheme's target regions in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/nr_accesses/min
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the manimum
+		'nr_accesses' of the scheme's target regions.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/nr_accesses/max
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the maximum
+		'nr_accesses' of the scheme's target regions.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/age/min
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the minimum
+		'age' of the scheme's target regions.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/age/max
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the maximum
+		'age' of the scheme's target regions.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/ms
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the time
+		quota of the scheme in milliseconds.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/bytes
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the size
+		quota of the scheme in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/reset_interval_ms
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the quotas
+		charge reset interval of the scheme in milliseconds.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		under-quota limit regions prioritization weight for 'size' in
+		permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/nr_accesses_permil
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		under-quota limit regions prioritization weight for
+		'nr_accesses' in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/age_permil
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		under-quota limit regions prioritization weight for 'age' in
+		permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/metric
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the metric
+		of the watermarks for the scheme.  The writable/readable
+		keywords for this file are 'none' for disabling the watermarks
+		feature, or 'free_mem_rate' for the system's global free memory
+		rate in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/interval_us
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the metric
+		check interval of the watermarks for the scheme in
+		microseconds.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/high
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the high
+		watermark of the scheme in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/mid
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the mid
+		watermark of the scheme in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/low
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the low
+		watermark of the scheme in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the number of regions that the action
+		of the scheme has tried to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_tried
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total size of regions that the
+		action of the scheme has tried to be applied in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_applied
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the number of regions that the action
+		of the scheme has successfully applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_applied
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total size of regions that the
+		action of the scheme has successfully applied in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/qt_exceeds
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the number of the exceed events of
+		the scheme's quotas.

