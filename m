Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E10A4C649F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Feb 2022 09:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiB1IOg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 03:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiB1IOW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 03:14:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F296149F23;
        Mon, 28 Feb 2022 00:13:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0FCCB80E62;
        Mon, 28 Feb 2022 08:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B83C36AE2;
        Mon, 28 Feb 2022 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646036016;
        bh=9Z4JPYulrfOQIZ7m1bu8DbwH2cCbsjJBaZhWIz/XpSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=co+FDNWg284sMrEVA3hgQekcR4y8dyK28HJyLsQUAj56JwHUzIhOYrBEYw/W34MVl
         /DCp3wYOvI4OqKzN5e0jcPC+n1QPgwN0F3AsYPeUCtgmqFQKl6HVsQDus8uiMA8odb
         7GbJpbq1qaAMvxWd/02Go7L1dTd+QpzEZ/SPSPJnd44RAlnNMF4TQNgHwJ0UUmLaRp
         cQCinykij2QE6BXVVgoiw2YydQaiohUqCnJxuuCqAElerEt+cfokhgTWQaqOKKNszz
         GLd6xiRfE8sB8Zr3grSrdoOtrFjHJiSal5jCoLOj74/IFiGjj8ofUPvrhkMrEzUDkl
         tpxhmDrxdEsfA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, gregkh@linuxfoundation.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 13/13] Docs/ABI/testing: Add DAMON sysfs interface ABI document
Date:   Mon, 28 Feb 2022 08:13:14 +0000
Message-Id: <20220228081314.5770-14-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228081314.5770-1-sj@kernel.org>
References: <20220228081314.5770-1-sj@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit adds DAMON sysfs interface ABI document under
Documentation/ABI/testing.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 274 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 275 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-damon

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
new file mode 100644
index 000000000000..9e282065cbcf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -0,0 +1,274 @@
+what:		/sys/kernel/mm/damon/
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Interface for Data Access MONitoring (DAMON).  Contains files
+		for controlling DAMON.  For more details on DAMON itself,
+		please refer to Documentation/admin-guide/mm/damon/index.rst.
+
+What:		/sys/kernel/mm/damon/admin/
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Interface for privileged users of DAMON.  Contains files for
+		controlling DAMON that aimed to be used by privileged users.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON worker thread (kdamond)
+		named '0' to 'N-1' under the kdamonds/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/state
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
+		stops, respectively.  Reading the file returns the keywords
+		based on the current status.  Writing 'update_schemes_stats' to
+		the file updates contents of schemes stats files of the
+		kdamond.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the pid of the kdamond if it is
+		running.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/nr_contexts
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON context named '0' to
+		'N-1' under the contexts/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/operations
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a keyword for a monitoring operations set ('vaddr' for
+		virtual address spaces monitoring, and 'paddr' for the physical
+		address space monitoring) to this file makes the context to use
+		the operations set.  Reading the file returns the keyword for
+		the operations set the context is set to use.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the sampling interval of the
+		DAMON context in microseconds as the value.  Reading this file
+		returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/aggr_us
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the aggregation interval of
+		the DAMON context in microseconds as the value.  Reading this
+		file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/update_us
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the update interval of the
+		DAMON context in microseconds as the value.  Reading this file
+		returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/nr_regions/min
+
+WDate:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the minimum number of
+		monitoring regions of the DAMON context as the value.  Reading
+		this file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/nr_regions/max
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the maximum number of
+		monitoring regions of the DAMON context as the value.  Reading
+		this file returns the value.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/nr_targets
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON target of the context
+		named '0' to 'N-1' under the contexts/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/pid_target
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the pid of
+		the target process if the context is for virtual address spaces
+		monitoring, respectively.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/nr_regions
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for setting each DAMON target memory region of the
+		context named '0' to 'N-1' under the regions/ directory.  In
+		case of the virtual address space monitoring, DAMON
+		automatically sets the target memory region based on the target
+		processes' mappings.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/<R>/start
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the start
+		address of the monitoring region.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/<R>/end
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the end
+		address of the monitoring region.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/nr_schemes
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON-based operation scheme
+		of the context named '0' to 'N-1' under the schemes/ directory.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/action
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the action
+		of the scheme.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/sz/min
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the mimimum
+		size of the scheme's target regions in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/sz/max
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the maximum
+		size of the scheme's target regions in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/nr_accesses/min
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the manimum
+		'nr_accesses' of the scheme's target regions.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/nr_accesses/max
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the maximum
+		'nr_accesses' of the scheme's target regions.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/age/min
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the minimum
+		'age' of the scheme's target regions.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/age/max
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the maximum
+		'age' of the scheme's target regions.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/ms
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the time
+		quota of the scheme in milliseconds.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/bytes
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the size
+		quota of the scheme in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/reset_interval_ms
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the quotas
+		charge reset interval of the scheme in milliseconds.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		under-quota limit regions prioritization weight for 'size' in
+		permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/nr_accesses_permil
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		under-quota limit regions prioritization weight for
+		'nr_accesses' in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/age_permil
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		under-quota limit regions prioritization weight for 'age' in
+		permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/metric
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the metric
+		of the watermarks for the scheme.  The writable/readable
+		keywords for this file are 'none' for disabling the watermarks
+		feature, or 'free_mem_rate' for the system's global free memory
+		rate in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/interval_us
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the metric
+		check interval of the watermarks for the scheme in
+		microseconds.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/high
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the high
+		watermark of the scheme in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/mid
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the mid
+		watermark of the scheme in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/low
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the low
+		watermark of the scheme in permil.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the number of regions that the action
+		of the scheme has tried to be applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_tried
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total size of regions that the
+		action of the scheme has tried to be applied in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_applied
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the number of regions that the action
+		of the scheme has successfully applied.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_applied
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total size of regions that the
+		action of the scheme has successfully applied in bytes.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/qt_exceeds
+Date:		Mar 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the number of the exceed events of
+		the scheme's quotas.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0153a614bab0..f45c6d381e22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5416,6 +5416,7 @@ DATA ACCESS MONITOR
 M:	SeongJae Park <sj@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-kernel-mm-damon
 F:	Documentation/admin-guide/mm/damon/
 F:	Documentation/vm/damon/
 F:	include/linux/damon.h
-- 
2.17.1

