Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355864C4570
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 14:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbiBYNJO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 08:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240989AbiBYNI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 08:08:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37051EDA07;
        Fri, 25 Feb 2022 05:08:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 394B7B830B4;
        Fri, 25 Feb 2022 13:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EFDC340E7;
        Fri, 25 Feb 2022 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645794488;
        bh=viwt/mzMMPdwv0w/XSxlKvT549ex+K2Nf6rlHiapcQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZ1vhvMywpkwiS67MhvEAQojfzVJghUR1i5I5aG30u1HtbzMOJ/5VqZTxHyzTLohc
         yzQVBpVrAKOULIQT7+TMOhqAlsHLvEQ6JZl/PzVwhwezGL20Ktu3iqqjZ2vMHrziFh
         v/Ff9VE1u2/vAuhzAGOxa9sdlsenNJ9ruubSOf3Z2lJxt+47M2DQsrBUrnrQk82mJK
         a80uwOG6/klFbDGr6UanHKZc3isDI9urNqELhw/3i8yq7Q4RFkLKaGyYwxnsgrXq2L
         bUafgjWiR69ytR1zO26+Zegd8LNfO8D8VA5YhWTH3ZfLkjbUY/a/0g0hswUczC+suK
         gOseQqvVHXO/A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v2 13/13] Docs/ABI/testing: Add DAMON sysfs interface ABI document
Date:   Fri, 25 Feb 2022 13:07:12 +0000
Message-Id: <20220225130712.12682-14-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220225130712.12682-1-sj@kernel.org>
References: <20220225130712.12682-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../ABI/testing/sysfs-kernel-mm-damon         | 276 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 277 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-damon

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
new file mode 100644
index 000000000000..11984c3a4b55
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -0,0 +1,276 @@
+what:		/sys/kernel/mm/damon/
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Interface for Data Access MONitoring (DAMON).
+		See Documentation/admin-guide/mm/damon/index.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Interface for privileged users of DAMON.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number to this file creates the number of kdamond
+		directories under the kdamonds/ directory.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/state
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the current state of the kdamond.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for getting the pid of the kdamond.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/nr_contexts
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number to this file creates the number of DAMON
+		context directories under the contexts/ directory.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/operations
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the monitoring operations set to
+		use for the context.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the sampling interval for the
+		context in micro-seconds.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/aggr_us
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the aggregation interval for the
+		context in micro-seconds.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/update_us
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the update interval for the
+		context in micro-seconds.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/nr_regions/min
+
+WDate:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the minimum number of monitoring
+		regions for the context.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/nr_regions/max
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the maximum number of monitoring
+		regions for the context.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/nr_targets
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number to this file creates the number of monitoring
+		target directories under the targets/ directory.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/pid_target
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the pid of the target process if
+		the context is for virtual address spaces monitoring.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/nr_regions
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number to this file creates the number of monitoring
+		region directories under the regions/ directory.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/<R>/start
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the start address of the
+		monitoring region.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/targets/<T>/regions/<R>/end
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the end address of the monitoring
+		region.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/nr_schemes
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a number to this file creates the number of DAMON-based
+		operation scheme directories under the schemes/ directory.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/action
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the action of the scheme.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/sz/min
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the mimimum size of the scheme's
+		target region.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/sz/max
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the maximum size of the scheme's
+		target region.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/nr_accesses/min
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the mimimum 'nr_accesses' of the
+		scheme's target region.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/nr_accesses/max
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the maximum 'nr_accesses' of the
+		scheme's target region.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/age/min
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the mimimum 'age' of the scheme's
+		target region.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/age/max
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the mimimum 'age' of the scheme's
+		target region.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/ms
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the time quota of the scheme.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/bytes
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the size quota of the scheme.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/reset_interval_ms
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the quota charge reset interval.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the under-quota regions
+		prioritization weight for 'nr_accesses'.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/nr_accesses_permil
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the under-quota regions
+		prioritization weight for 'nr_accesses'.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/age_permil
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the under-quota regions
+		prioritization weight for 'age'.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/metric
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the metric of the watermarks for
+		the scheme.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/interval_us
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the metric check interval of the
+		watermarks for the scheme.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/high
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the high watermark of the scheme.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/mid
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the mid watermark of the scheme.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/watermarks/low
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for setting and getting the low watermark of the scheme.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_tried
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for getting the number of regions that the action of the
+		scheme has tried.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_tried
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for getting the total size of regions that the action of
+		the scheme has tried.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_applied
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for getting the number of regions that the action of the
+		scheme has successfully applied.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_applied
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for getting the total size of regions that the action of
+		the scheme has successfully applied.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/qt_exceeds
+Date:		Feb 2022
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	File for getting the number of the exceed events of the
+		scheme's quota.
+		See Documentation/admin-guide/mm/damon/usage.rst for details.
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

