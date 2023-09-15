Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926677A13FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 04:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjIOCxE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 22:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjIOCxE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 22:53:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B726AB;
        Thu, 14 Sep 2023 19:53:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095D2C433C8;
        Fri, 15 Sep 2023 02:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694746379;
        bh=BMoIA/XytQAickyMtxvDt0cV0B7GH433aHBEMFeeRZA=;
        h=From:To:Cc:Subject:Date:From;
        b=cI0cRs6qX5hHpd59KhlA3hhK/Qql5/OjdtMEa3olBNhsnYd/e3op+jcl3KLu0BV8w
         RiEYfVAoYEvsFOzZvj27inW/LGydZnbhhHXGcPjfnz25pHn0jwDd1ILy8UKvbN9zB3
         OK2C7gXEQnKz3Vr60XXbCjyF8tPWZE+++a5tVe21EWqxU++Ci5bCOlRqQBxQ4vju+w
         gJq25kZYHVM3a46zVBvfPUAT8vRgQy5n9GUlelf6ALlF6imhHL/rAQnc/UTJ3iv4tG
         +16xC6MX6g3x/v2SqaDqjBK3e9BuOsJedv6ba6keD2wIfOpwEeZAjRZzjMnjab2s+h
         5uTX7Yzl3Svog==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] mm/damon: provide pseudo-moving sum based access rate
Date:   Fri, 15 Sep 2023 02:52:43 +0000
Message-Id: <20230915025251.72816-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes from RFC
(https://lore.kernel.org/damon/20230909033711.55794-1-sj@kernel.org/)
- Rebase on latest mm-unstable
- Minor wordsmithing of coverletter

DAMON checks the access to each region for every sampling interval, increase
the access rate counter of the region, namely nr_accesses, if the access was
made.  For every aggregation interval, the counter is reset.  The counter is
exposed to users to be used as a metric showing the relative access rate
(frequency) of each region.  In other words, DAMON provides access rate of each
region in every aggregation interval.  The aggregation avoids temporal access
pattern changes making things confusing.  However, this also makes a few
DAMON-related operations to unnecessarily need to be aligned to the aggregation
interval.  This can restrict the flexibility of DAMON applications, especially
when the aggregation interval is huge.

To provide the monitoring results in finer-grained timing while keeping
handling of temporal access pattern change, this patchset implements a
pseudo-moving sum based access rate metric.  It is pseudo-moving sum because
strict moving sum implementation would need to keep all values for last time
window, and that could incur high overhead of there could be arbitrary number
of values in a time window.  Especially in case of the nr_accesses, since the
sampling interval and aggregation interval can arbitrarily set and the past
values should be maintained for every region, it could be risky.  The
pseudo-moving sum assumes there were no temporal access pattern change in last
discrete time window to remove the needs for keeping the list of the last time
window values.  As a result, it beocmes not strict moving sum implementation,
but provides a reasonable accuracy.

Also, it keeps an important property of the moving sum.  That is, the moving
sum becomes same to discrete-window based sum at the time that aligns to the
time window.  This means using the pseudo moving sum based nr_accesses makes no
change to users who shows the value for every aggregation interval.

Patches Sequence
----------------

The sequence of the patches is as follows.  The first four patches are
for preparation of the change.  The first two (patches 1 and 2)
implements a helper function for nr_accesses update and eliminate corner
case that skips use of the function, respectively.  Following two
(patches 3 and 4) respectively implement the pseudo-moving sum function
and its simple unit test case.

Two patches for making DAMON to use the pseudo-moving sum follow.  The
fifthe one (patch 5) introduces a new field for representing the
pseudo-moving sum-based access rate of each region, and the sixth one
makes the new representation to actually updated with the pseudo-moving
sum function.

Last two patches (patches 7 and 8) makes followup fixes for skipping
unnecessary updates and marking the moving sum function as static,
respectively.

SeongJae Park (8):
  mm/damon/core: define and use a dedicated function for region access
    rate update
  mm/damon/vaddr: call damon_update_region_access_rate() always
  mm/damon/core: implement a pseudo-moving sum function
  mm/damon/core-test: add a unit test for damon_moving_sum()
  mm/damon/core: introduce nr_accesses_bp
  mm/damon/core: use pseudo-moving sum for nr_accesses_bp
  mm/damon/core: skip updating nr_accesses_bp for each aggregation
    interval
  mm/damon/core: mark damon_moving_sum() as a static function

 include/linux/damon.h | 16 +++++++++-
 mm/damon/core-test.h  | 21 ++++++++++++
 mm/damon/core.c       | 74 +++++++++++++++++++++++++++++++++++++++++++
 mm/damon/paddr.c      | 11 +++----
 mm/damon/vaddr.c      | 22 +++++++------
 5 files changed, 128 insertions(+), 16 deletions(-)


base-commit: a5b7405a0eaa74d23547ede9c3820f01ee0a2c13
-- 
2.25.1

