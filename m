Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96C94C6497
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Feb 2022 09:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiB1IOY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 03:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiB1IOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 03:14:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415FB44760;
        Mon, 28 Feb 2022 00:13:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C506461135;
        Mon, 28 Feb 2022 08:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE1CC340F1;
        Mon, 28 Feb 2022 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646036015;
        bh=sWjNywV4Hawa+wAWyt+/svpPxHH0iIMffke7+3j6r+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhtZtjLbwzN9TenrfaB1NKpMJs96EcLE3oJvaXo6W/v7zKRsE0Akv0hp4NU8RahJm
         WFUAFd/pj/dHcrdRVDEEyHowGnZBWKbOhQNQzs3MGd1zJ9vP7p44AOy27tGzNgdK9m
         +vFvW8+njtZ1KAHJYCOOUyv7dRDy8XBsAcOVA+1sTGdbrDAS0No0VhBI7bHv8ENR6b
         dEfnK5PEZCf5JUDsJsBrN/QMqKtyuEcBfMgZvj60v38m48LzbVNEKaSajl6XeCmPih
         qGDuxl5TZ0pCEiBPkLvDQ/hGeAtn3s92EzPCWp/ryBDrvaV6Guy99P0e9tzXWjrJjo
         jXJm3SugXcPcw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, skhan@linuxfoundation.org, rientjes@google.com,
        xhao@linux.alibaba.com, gregkh@linuxfoundation.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 12/13] Docs/admin-guide/mm/damon/usage: Document DAMON sysfs interface
Date:   Mon, 28 Feb 2022 08:13:13 +0000
Message-Id: <20220228081314.5770-13-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228081314.5770-1-sj@kernel.org>
References: <20220228081314.5770-1-sj@kernel.org>
MIME-Version: 1.0
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

This commit adds detailed usage of DAMON sysfs interface in the
admin-guide document for DAMON.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 350 ++++++++++++++++++-
 1 file changed, 344 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index b6ec650873b2..592ea9a50881 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -4,7 +4,7 @@
 Detailed Usages
 ===============
 
-DAMON provides below three interfaces for different users.
+DAMON provides below interfaces for different users.
 
 - *DAMON user space tool.*
   `This <https://github.com/awslabs/damo>`_ is for privileged people such as
@@ -14,17 +14,21 @@ DAMON provides below three interfaces for different users.
   virtual and physical address spaces monitoring.  For more detail, please
   refer to its `usage document
   <https://github.com/awslabs/damo/blob/next/USAGE.md>`_.
-- *debugfs interface.*
-  :ref:`This <debugfs_interface>` is for privileged user space programmers who
+- *sysfs interface.*
+  :ref:`This <sysfs_interface>` is for privileged user space programmers who
   want more optimized use of DAMON.  Using this, users can use DAMON’s major
-  features by reading from and writing to special debugfs files.  Therefore,
-  you can write and use your personalized DAMON debugfs wrapper programs that
-  reads/writes the debugfs files instead of you.  The `DAMON user space tool
+  features by reading from and writing to special sysfs files.  Therefore,
+  you can write and use your personalized DAMON sysfs wrapper programs that
+  reads/writes the sysfs files instead of you.  The `DAMON user space tool
   <https://github.com/awslabs/damo>`_ is one example of such programs.  It
   supports both virtual and physical address spaces monitoring.  Note that this
   interface provides only simple :ref:`statistics <damos_stats>` for the
   monitoring results.  For detailed monitoring results, DAMON provides a
   :ref:`tracepoint <tracepoint>`.
+- *debugfs interface.*
+  :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
+  <sysfs_interface>`.  This will be removed after next LTS kernel is released,
+  so users should move to the :ref:`sysfs interface <sysfs_interface>`.
 - *Kernel Space Programming Interface.*
   :doc:`This </vm/damon/api>` is for kernel space programmers.  Using this,
   users can utilize every feature of DAMON most flexibly and efficiently by
@@ -32,6 +36,340 @@ DAMON provides below three interfaces for different users.
   DAMON for various address spaces.  For detail, please refer to the interface
   :doc:`document </vm/damon/api>`.
 
+.. _sysfs_interface:
+
+sysfs Interface
+===============
+
+DAMON sysfs interface is built when ``CONFIG_DAMON_SYSFS`` is defined.  It
+creates multiple directories and files under its sysfs directory,
+``<sysfs>/kernel/mm/damon/``.  You can control DAMON by writing to and reading
+from the files under the directory.
+
+For a short example, users can monitor the virtual address space of a given
+workload as below. ::
+
+    # cd /sys/kernel/mm/damon/admin/
+    # echo 1 > kdamonds/nr && echo 1 > kdamonds/0/contexts/nr
+    # echo vaddr > kdamonds/0/contexts/0/operations
+    # echo 1 > kdamonds/0/contexts/0/targets/nr
+    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
+    # echo on > kdamonds/0/state
+
+Files Hierarchy
+---------------
+
+The files hierarchy of DAMON sysfs interface is shown below.  In the below
+figure, parents-children relations are represented with indentations, each
+directory is having ``/`` suffix, and files in each directory are separated by
+comma (","). ::
+
+    /sys/kernel/mm/damon/admin
+    │ kdamonds/nr_kdamonds
+    │ │ 0/state,pid
+    │ │ │ contexts/nr_contexts
+    │ │ │ │ 0/operations
+    │ │ │ │ │ monitoring_attrs/
+    │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
+    │ │ │ │ │ │ nr_regions/min,max
+    │ │ │ │ │ targets/nr_targets
+    │ │ │ │ │ │ 0/pid_target
+    │ │ │ │ │ │ │ regions/nr_regions
+    │ │ │ │ │ │ │ │ 0/start,end
+    │ │ │ │ │ │ │ │ ...
+    │ │ │ │ │ │ ...
+    │ │ │ │ │ schemes/nr_schemes
+    │ │ │ │ │ │ 0/action
+    │ │ │ │ │ │ │ access_pattern/
+    │ │ │ │ │ │ │ │ sz/min,max
+    │ │ │ │ │ │ │ │ nr_accesses/min,max
+    │ │ │ │ │ │ │ │ age/min,max
+    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
+    │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
+    │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
+    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
+    │ │ │ │ │ │ ...
+    │ │ │ │ ...
+    │ │ ...
+
+Root
+----
+
+The root of the DAMON sysfs interface is ``<sysfs>/kernel/mm/damon/``, and it
+has one directory named ``admin``.  The directory contains the files for
+privileged user space programs' control of DAMON.  User space tools or deamons
+having the root permission could use this directory.
+
+kdamonds/
+---------
+
+The monitoring-related information including request specifications and results
+are called DAMON context.  DAMON executes each context with a kernel thread
+called kdamond, and multiple kdamonds could run in parallel.
+
+Under the ``admin`` directory, one directory, ``kdamonds``, which has files for
+controlling the kdamonds exist.  In the beginning, this directory has only one
+file, ``nr_kdamonds``.  Writing a number (``N``) to the file creates the number
+of child directories named ``0`` to ``N-1``.  Each directory represents each
+kdamond.
+
+kdamonds/<N>/
+-------------
+
+In each kdamond directory, two files (``state`` and ``pid``) and one directory
+(``contexts``) exist.
+
+Reading ``state`` returns ``on`` if the kdamond is currently running, or
+``off`` if it is not running.  Writing ``on`` or ``off`` makes the kdamond be
+in the state.  Writing ``update_schemes_stats`` to ``state`` file updates the
+contents of stats files for each DAMON-based operation scheme of the kdamond.
+For details of the stats, please refer to :ref:`stats section
+<sysfs_schemes_stats>`.
+
+If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
+
+``contexts`` directory contains files for controlling the monitoring contexts
+that this kdamond will execute.
+
+kdamonds/<N>/contexts/
+----------------------
+
+In the beginning, this directory has only one file, ``nr_contexts``.  Writing a
+number (``N``) to the file creates the number of child directories named as
+``0`` to ``N-1``.  Each directory represents each monitoring context.  At the
+moment, only one context per kdamond is supported, so only ``0`` or ``1`` can
+be written to the file.
+
+contexts/<N>/
+-------------
+
+In each context directory, one file (``operations``) and three directories
+(``monitoring_attrs``, ``targets``, and ``schemes``) exist.
+
+DAMON supports multiple types of monitoring operations, including those for
+virtual address space and the physical address space.  You can set and get what
+type of monitoring operations DAMON will use for the context by writing one of
+below keywords to, and reading from the file.
+
+ - vaddr: Monitor virtual address spaces of specific processes
+ - paddr: Monitor the physical address space of the system
+
+contexts/<N>/monitoring_attrs/
+------------------------------
+
+Files for specifying attributes of the monitoring including required quality
+and efficiency of the monitoring are in ``monitoring_attrs`` directory.
+Specifically, two directories, ``intervals`` and ``nr_regions`` exist in this
+directory.
+
+Under ``intervals`` directory, three files for DAMON's sampling interval
+(``sample_us``), aggregation interval (``aggr_us``), and update interval
+(``update_us``) exist.  You can set and get the values in micro-seconds by
+writing to and reading from the files.
+
+Under ``nr_regions`` directory, two files for the lower-bound and upper-bound
+of DAMON's monitoring regions (``min`` and ``max``, respectively), which
+controls the monitoring overhead, exist.  You can set and get the values by
+writing to and rading from the files.
+
+For more details about the intervals and monitoring regions range, please refer
+to the Design document (:doc:`/vm/damon/design`).
+
+contexts/<N>/targets/
+---------------------
+
+In the beginning, this directory has only one file, ``nr_targets``.  Writing a
+number (``N``) to the file creates the number of child directories named ``0``
+to ``N-1``.  Each directory represents each monitoring target.
+
+targets/<N>/
+------------
+
+In each target directory, one file (``pid_target``) and one directory
+(``regions``) exist.
+
+If you wrote ``vaddr`` to the ``contexts/<N>/operations``, each target should
+be a process.  You can specify the process to DAMON by writing the pid of the
+process to the ``pid_target`` file.
+
+targets/<N>/regions
+-------------------
+
+When ``vaddr`` monitoring operations set is being used (``vaddr`` is written to
+the ``contexts/<N>/operations`` file), DAMON automatically sets and updates the
+monitoring target regions so that entire memory mappings of target processes
+can be covered.  However, users could want to set the initial monitoring region
+to specific address ranges.
+
+In contrast, DAMON do not automatically sets and updates the monitoring target
+regions when ``paddr`` monitoring operations set is being used (``paddr`` is
+written to the ``contexts/<N>/operations``).  Therefore, users should set the
+monitoring target regions by themselves in the case.
+
+For such cases, users can explicitly set the initial monitoring target regions
+as they want, by writing proper values to the files under this directory.
+
+In the beginning, this directory has only one file, ``nr_regions``.  Writing a
+number (``N``) to the file creates the number of child directories named ``0``
+to ``N-1``.  Each directory represents each initial monitoring target region.
+
+regions/<N>/
+------------
+
+In each region directory, you will find two files (``start`` and ``end``).  You
+can set and get the start and end addresses of the initial monitoring target
+region by writing to and reading from the files, respectively.
+
+contexts/<N>/schemes/
+---------------------
+
+For usual DAMON-based data access aware memory management optimizations, users
+would normally want the system to apply a memory management action to a memory
+region of a specific access pattern.  DAMON receives such formalized operation
+schemes from the user and applies those to the target memory regions.  Users
+can get and set the schemes by reading from and writing to files under this
+directory.
+
+In the beginning, this directory has only one file, ``nr_schemes``.  Writing a
+number (``N``) to the file creates the number of child directories named ``0``
+to ``N-1``.  Each directory represents each DAMON-based operation scheme.
+
+schemes/<N>/
+------------
+
+In each scheme directory, four directories (``access_pattern``, ``quotas``,
+``watermarks``, and ``stats``) and one file (``action``) exist.
+
+The ``action`` file is for setting and getting what action you want to apply to
+memory regions having specific access pattern of the interest.  The keywords
+that can be written to and read from the file and their meaning are as below.
+
+ - ``willneed``: Call ``madvise()`` for the region with ``MADV_WILLNEED``
+ - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``
+ - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``
+ - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
+ - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
+ - ``stat``: Do nothing but count the statistics
+
+schemes/<N>/access_pattern/
+---------------------------
+
+The target access pattern of each DAMON-based operation scheme is constructed
+with three ranges including the size of the region in bytes, number of
+monitored accesses per aggregate interval, and number of aggregated intervals
+for the age of the region.
+
+Under the ``access_pattern`` directory, three directories (``sz``,
+``nr_accesses``, and ``age``) each having two files (``min`` and ``max``)
+exist.  You can set and get the access pattern for the given scheme by writing
+to and reading from the ``min`` and ``max`` files under ``sz``,
+``nr_accesses``, and ``age`` directories, respectively.
+
+schemes/<N>/quotas/
+-------------------
+
+Optimal ``target access pattern`` for each ``action`` is workload dependent, so
+not easy to find.  Worse yet, setting a scheme of some action too aggressive
+can cause severe overhead.  To avoid such overhead, users can limit time and
+size quota for each scheme.  In detail, users can ask DAMON to try to use only
+up to specific time (``time quota``) for applying the action, and to apply the
+action to only up to specific amount (``size quota``) of memory regions having
+the target access pattern within a given time interval (``reset interval``).
+
+When the quota limit is expected to be exceeded, DAMON prioritizes found memory
+regions of the ``target access pattern`` based on their size, access frequency,
+and age.  For personalized prioritization, users can set the weights for the
+three properties.
+
+Under ``quotas`` directory, three files (``ms``, ``bytes``,
+``reset_interval_ms``) and one directory (``weights``) having three files
+(``sz_permil``, ``nr_accesses_permil``, and ``age_permil``) in it exist.
+
+You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, and
+``reset interval`` in milliseconds by writing the values to the three files,
+respectively.  You can also set the prioritization weights for size, access
+frequency, and age in per-thousand unit by writing the values to the three
+files under the ``weights`` directory.
+
+schemes/<N>/watermarks/
+-----------------------
+
+To allow easy activation and deactivation of each scheme based on system
+status, DAMON provides a feature called watermarks.  The feature receives five
+values called ``metric``, ``interval``, ``high``, ``mid``, and ``low``.  The
+``metric`` is the system metric such as free memory ratio that can be measured.
+If the metric value of the system is higher than the value in ``high`` or lower
+than ``low`` at the memoent, the scheme is deactivated.  If the value is lower
+than ``mid``, the scheme is activated.
+
+Under the watermarks directory, five files (``metric``, ``interval_us``,
+``high``, ``mid``, and ``low``) for setting each value exist.  You can set and
+get the five values by writing to the files, respectively.
+
+Keywords and meanings of those that can be written to the ``metric`` file are
+as below.
+
+ - none: Ignore the watermarks
+ - free_mem_rate: System's free memory rate (per thousand)
+
+The ``interval`` should written in microseconds unit.
+
+.. _sysfs_schemes_stats:
+
+schemes/<N>/stats/
+------------------
+
+DAMON counts the total number and bytes of regions that each scheme is tried to
+be applied, the two numbers for the regions that each scheme is successfully
+applied, and the total number of the quota limit exceeds.  This statistics can
+be used for online analysis or tuning of the schemes.
+
+The statistics can be retrieved by reading the files under ``stats`` directory
+(``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``, and
+``qt_exceeds``), respectively.  The files are not updated in real time, so you
+should ask DAMON sysfs interface to updte the content of the files for the
+stats by writing a special keyword, ``update_schemes_stats`` to the relevant
+``kdamonds/<N>/state`` file.
+
+Example
+~~~~~~~
+
+Below commands applies a scheme saying "If a memory region of size in [4KiB,
+8KiB] is showing accesses per aggregate interval in [0, 5] for aggregate
+interval in [10, 20], page out the region.  For the paging out, use only up to
+10ms per second, and also don't page out more than 1GiB per second.  Under the
+limitation, page out memory regions having longer age first.  Also, check the
+free memory rate of the system every 5 seconds, start the monitoring and paging
+out when the free memory rate becomes lower than 50%, but stop it if the free
+memory rate becomes larger than 60%, or lower than 30%". ::
+
+    # cd <sysfs>/kernel/mm/damon/admin
+    # # populate directories
+    # echo 1 > kdamonds/nr_kdamonds; echo 1 > kdamonds/0/contexts/nr_contexts;
+    # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
+    # cd kdamonds/0/contexts/0/schemes/0
+    # # set the basic access pattern and the action
+    # echo 4096 > access_patterns/sz/min
+    # echo 8192 > access_patterns/sz/max
+    # echo 0 > access_patterns/nr_accesses/min
+    # echo 5 > access_patterns/nr_accesses/max
+    # echo 10 > access_patterns/age/min
+    # echo 20 > access_patterns/age/max
+    # echo pageout > action
+    # # set quotas
+    # echo 10 > quotas/ms
+    # echo $((1024*1024*1024)) > quotas/bytes
+    # echo 1000 > quotas/reset_interval_ms
+    # # set watermark
+    # echo free_mem_rate > watermarks/metric
+    # echo 5000000 > watermarks/interval_us
+    # echo 600 > watermarks/high
+    # echo 500 > watermarks/mid
+    # echo 300 > watermarks/low
+
+Please note that it's highly recommended to use user space tools like `damo
+<https://github.com/awslabs/damo>`_ rather than manually reading and writing
+the files as above.  Above is only for an example.
 
 .. _debugfs_interface:
 
-- 
2.17.1

