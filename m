Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184CA7A2D4F
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 04:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjIPCKO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 22:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjIPCJ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 22:09:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069F6173C;
        Fri, 15 Sep 2023 19:09:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF77EC433C7;
        Sat, 16 Sep 2023 02:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694830193;
        bh=T68zS6krvg2xS5agV4Sw7lJICBfEHCuQmhqbi4p759U=;
        h=From:To:Cc:Subject:Date:From;
        b=o21TOvmnXJWR0ZzRfYrNfPxWcxyX7XTsYcOhCNZ7kpkZsb9OoFYsoMtMTSNJQCbbf
         vT3cnFGCf38LP9gif6XwOTN1aWukbcQLpqIG7/s62R/T2w1pF//R0b1A+YHPYRG1ev
         lxC/jXDe7eqZuOysU+FpuJWH0Gv8D2e0TmzlF/dwhz6skYbOQ5lzGSDMdXFrJjiDfr
         mrdtJLd7UOzXL+U6AkO7XrxmvOGuhq1fopSCdrtJuC49EC/cYHaJCAUKDv0bYxVnWB
         wqSkM1fCwK7Hiet2MiL9yKEwSdv3vnR/Yk3v6gO99dVrxtMiocrFj+JcoppKTEuif+
         VsKIprlQX+HWQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] mm/damon: implement DAMOS apply intervals
Date:   Sat, 16 Sep 2023 02:09:36 +0000
Message-Id: <20230916020945.47296-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes from RFC
(https://lore.kernel.org/damon/20230910034048.59191-1-sj@kernel.org/)
- Add kselftest for damos_apply_interval_us sysfs file
- Rebase on latest mm-unstable

DAMON-based operation schemes are applied for every aggregation
interval.  That is mainly because schemes are using nr_accesses, which
be complete to be used for every aggregation interval.

This makes some DAMOS use cases be tricky.  Quota setting under long
aggregation interval is one such example.  Suppose the aggregation
interval is ten seconds, and there is a scheme having CPU quota 100ms
per 1s.  The scheme will actually uses 100ms per ten seconds, since it
cannobe be applied before next aggregation interval.  The feature is
working as intended, but the results might not that intuitive for some
users.  This could be fixed by updating the quota to 1s per 10s.  But,
in the case, the CPU usage of DAMOS could look like spikes, and actually
make a bad effect to other CPU-sensitive workloads.

Also, with such huge aggregation interval, users may want schemes to be
applied more frequently.

DAMON provides nr_accesses_bp, which is updated for each sampling
interval in a way that reasonable to be used.  By using that instead of
nr_accesses, DAMOS can have its own time interval and mitigate abovely
mentioned issues.

This patchset makes DAMOS schemes to use nr_accesses_bp instead of
nr_accesses, and have their own timing intervals.  Also update DAMOS
tried regions sysfs files and DAMOS before_apply tracepoint to use the
new data as their source.  Note that the interval is zero by default,
and it is interpreted to use the aggregation interval instead.  This
avoids making user-visible behavioral changes.


Patches Seuqeunce
-----------------

The first patch (patch 1/9) makes DAMOS uses nr_accesses_bp instead of
nr_accesses, and following two patches (patches 2/9 and 3/9) updates
DAMON sysfs interface for DAMOS tried regions and the DAMOS before_apply
tracespoint to use nr_accesses_bp instead of nr_accesses, respectively.

The following two patches (patches 4/9 and 5/9) implements the
scheme-specific apply interval for DAMON kernel API users and update the
design document for the new feature.

Finally, the following four patches (patches 6/9, 7/9, 8/9 and 9/9) add
support of the feature in DAMON sysfs interface, add a simple selftest
test case, and document the new file on the usage and the ABI documents,
repsectively.


SeongJae Park (9):
  mm/damon/core: make DAMOS uses nr_accesses_bp instead of nr_accesses
  mm/damon/sysfs-schemes: use nr_accesses_bp as the source of
    tried_regions/<N>/nr_accesses
  mm/damon/core: use nr_accesses_bp as a source of damos_before_apply
    tracepoint
  mm/damon/core: implement scheme-specific apply interval
  Docs/mm/damon/design: document DAMOS apply intervals
  mm/damon/sysfs-schemes: support DAMOS apply interval
  selftests/damon/sysfs: test DAMOS apply intervals
  Docs/admin-guide/mm/damon/usage: update for DAMOS apply intervals
  Docs/ABI/damon: update for DAMOS apply intervals

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 ++
 Documentation/admin-guide/mm/damon/usage.rst  |  9 ++-
 Documentation/mm/damon/design.rst             |  3 +-
 include/linux/damon.h                         | 17 +++-
 include/trace/events/damon.h                  |  2 +-
 mm/damon/core.c                               | 77 ++++++++++++++++---
 mm/damon/dbgfs.c                              |  3 +-
 mm/damon/lru_sort.c                           |  2 +
 mm/damon/reclaim.c                            |  2 +
 mm/damon/sysfs-schemes.c                      | 40 ++++++++--
 tools/testing/selftests/damon/sysfs.sh        |  1 +
 11 files changed, 141 insertions(+), 22 deletions(-)


base-commit: abf99d088da21843246382c7a95f21e886193c31
-- 
2.25.1

