Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7761549B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 23:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiKAWDi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 18:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiKAWDh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 18:03:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7EC644F;
        Tue,  1 Nov 2022 15:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B5C6B81E2A;
        Tue,  1 Nov 2022 22:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6358BC433D6;
        Tue,  1 Nov 2022 22:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667340213;
        bh=fXmQiQlwfo1wAtVQvQojVvgAeobZBuMjJxM4aD7I54Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Q9lbX6QjRZr48IH1loFyw7ZQIC/F6A4uWEKV18+WWDbfBbnX5P9vOFduF+agJj7t5
         qFqKcTZ6V8e2nu/UvyZuv2d1WYLU1Abk3z+BXEWvtNTUV3gbzNpCiDBgSIttEn2VyI
         uy5cwQyet4IQdKycQxA0R2hREj3rFeEXJrVMfm7YyAGMPDFyBqH842rADPmTqlmKuU
         2K46rFMIcVYPe5PKwZ3bZx5czIn96wZAhVR0Kpt6aCdmO0S0Ze5jOBKBuLT8DSnDSJ
         fbj2C5u1Y1LFYCk23WV5q7iKbukPOef/JQWFbWmcZ3/hJtYiidh7y1UkN2WM7BGozy
         X6GOYOF4RCLrg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] efficiently expose damos action tried regions information
Date:   Tue,  1 Nov 2022 22:03:20 +0000
Message-Id: <20221101220328.95765-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes from RFC
(https://lore.kernel.org/damon/20221019001317.104270-1-sj@kernel.org/):
- Split out cleanup/refactoring parts[1]

[1] https://lore.kernel.org/damon/20221026225943.100429-1-sj@kernel.org/

-----------------------------------------------------------------------

DAMON users can retrieve the monitoring results via 'after_aggregation'
callbacks if the user is using the kernel API, or 'damon_aggregated'
tracepoint if the user is in the user space.  Those are useful if full
monitoring results are necessary.  However, if the user has interest in
only a snapshot of the results for some regions having specific access
pattern, the interfaces could be inefficient.  For example, some users
only want to know which memory regions are not accessed for more than a
specific time at the moment.

Also, some DAMOS users would want to know exactly to what memory regions
the schemes' actions tried to be applied, for a debugging or a tuning.
As DAMOS has its internal mechanism for quota and regions
prioritization, the users would need to simulate DAMOS' mechanism
against the monitoring results.  That's unnecessarily complex.

This patchset implements DAMON kernel API callbacks and sysfs directory
for efficient exposure of the information for the use cases.  The new
callback will be called for each region when a DAMOS action is gonna
tried to be applied to it.  The sysfs directory will be called
'tried_regions' and placed under each scheme sysfs directory.  Users can
write a special keyworkd, 'update_schemes_regions', to the 'state' file
of a kdamond sysfs directory.  Then, DAMON sysfs interface will fill the
directory with the information of regions that corresponding scheme
action was tried to be applied for next one aggregation interval.

Patches Sequence
----------------

The first one (patch 1) implements the callback for the kernel space
users.  Following two patches (patches 2 and 3) implements sysfs
directories for the information and its sub directories.  Two patches
(patches 4 and 5) for implementing the special keywords for filling the
data to and cleaning up the directories follow.  Patch 6 adds a selftest
for the new sysfs directory.  Finally, two patches (patches 7 and 8)
document the new feature in the administrator guide and the ABI
document.

Assembled Tree
--------------

This patchset is based on the latest mm-unstable tree[1].  Assembled
tree is also available at the damon/next tree[2].

[1] https://git.kernel.org/akpm/mm/h/mm-unstable
[2] https://git.kernel.org/sj/h/damon/next

SeongJae Park (8):
  mm/damon/core: add a callback for scheme target regions check
  mm/damon/sysfs-schemes: implement schemes/tried_regions directory
  mm/damon/sysfs-schemes: implement scheme region directory
  mm/damon/sysfs: implement DAMOS tried regions update command
  mm/damon/sysfs-schemes: implement DAMOS-tried regions clear command
  tools/selftets/damon/sysfs: test tried_regions directory existence
  Docs/admin-guide/mm/damon/usage: document schemes/<s>/tried_regions
    sysfs directory
  Docs/ABI/damon: document 'schemes/<s>/tried_regions' sysfs directory

 .../ABI/testing/sysfs-kernel-mm-damon         |  32 +++
 Documentation/admin-guide/mm/damon/usage.rst  |  45 ++-
 include/linux/damon.h                         |   5 +
 mm/damon/core.c                               |   6 +-
 mm/damon/sysfs-common.h                       |  10 +
 mm/damon/sysfs-schemes.c                      | 261 ++++++++++++++++++
 mm/damon/sysfs.c                              |  77 +++++-
 tools/testing/selftests/damon/sysfs.sh        |   7 +
 8 files changed, 437 insertions(+), 6 deletions(-)

-- 
2.25.1

