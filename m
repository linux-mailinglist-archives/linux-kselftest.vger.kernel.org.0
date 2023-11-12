Return-Path: <linux-kselftest+bounces-36-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E20A27E9250
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 20:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B321C20836
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B0171CD;
	Sun, 12 Nov 2023 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlZGuL1E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9A168C1;
	Sun, 12 Nov 2023 19:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA4CC433C8;
	Sun, 12 Nov 2023 19:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699818373;
	bh=MaALdKM6CkRciDDOKQFdOFbCFn9uUlJOWClVU8b34tU=;
	h=From:To:Cc:Subject:Date:From;
	b=SlZGuL1E4T3k46McUNsHAf1w2NuqPphfcHyZcICORU0yuRPWSemZxbxascnJEM4wO
	 RGqzaYcCZwNc+hn+tWm1S1rg4ApB0FK+txAtSBRj88bPz3KUp1YmgrU3mqneE/WQcQ
	 LRgOIygyg6GiR1u0UPKj92CP9Tdtpb1PRH9r1LNpaqAfPR82U92kkYKhr9mJuIPHKw
	 mNv4tk7df0CvkpvYf/ccAWDqGNUqntwiHu537rFik2Qun1QdCwd+uZU52uP49w90oJ
	 FjqEAQwnVGcI2+vci38RO6C4TlriKg9GeNRv8iftoLU5nESSXp+US/N05doraV0GvC
	 ANjnFjTnid49A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/8] DAMOS: Introduce Aim-oriented Feedback-driven Aggressiveness Auto Tuning
Date: Sun, 12 Nov 2023 19:45:59 +0000
Message-Id: <20231112194607.61399-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another candidate of the subject was "Let users feed and tame DAMOS".

DAMOS Control Difficulty
========================

DAMOS helps users easily implementing effective access pattern aware
system operations.  However, controlling DAMOS in wild is not that easy.
The basic way to control DAMON is specifying the target access pattern.
Hence, the user is assumed to know the access pattern of the system and
the workloads well.  Though some good tools including DAMON can help
that, it requires time and resource, and the cost depends on the
complexity and the dynamicity of the system and workloads.  After all,
the access pattern consist of three ranges, namely ranges of access
rate, age, and size of the regions.  Tuning six parameters is already
complex.  It is not doable for everyone.

To ease the control, DAMOS allows users to set the upper-limit of the
schemes's aggressiveness, namely DAMOS quota.  Then DAMOS prioritizes
regions to apply the action under the limit based on the action and the
access pattern of the regions.  For example, use can ask DAMOS to page
out up to 100 MiB of memory regions per second.  Then DAMOS pages out
regions that not accessed for longer time first under the limit.  This
allows users to set access pattern bit more naively, and focus on only
the one parameter, the quota.  That is, the number of parameters to tune
with special care can be reduced from six to one.

Still, however, the optimal value for the quota depends on the system
and the workloads' characteristics, so not that simple.  The number of
parameters to tune can also increase again if the user needs to run
multiple schemes, e.g., collapsing hot pages into THP while splitting
cold pages into regular pages.

In short, the existing approach asks users to find the perfect or
adapted tuning and instruct DAMOS how to work.  It requires users to be
deligent.  That's not a virtue of human, but the machine.

Aim-oriented Feedback-driven DAMOS Quota Auto Tuning
====================================================

Most users would start using DAMOS since there is something they want to
achieve with DAMOS.  Having such goal metrics like SLO is common.
Hence, a better approach would be letting users inform DAMOS what they
aim to achieve, and how well DAMOS is doing that.  Then DAMOS can
somehow make it.  In detail, users provide feedback for each DAMOS
scheme.  DAMOS then tune the quota of each scheme based on the users'
feedback and the current quota values.

This patchset implements the idea.

Implementation
--------------

The core logic implementation is in the first patch.  In short, it uses
below simple feedback loop algorithm to get next aggressiveness from the
current aggressiveness and the feedback (target_core and current_score)
for the current aggressiveness.

    f(n, target_score, current_score) =
        max(f(n - 1) * ((target_score - current_score) / target_score + 1), 1)

Note that this algorithm assumes the aggressiveness and the score are
positively proportional.  Making it true is the feedback provider's
responsibility.

Test Results
------------

To show if this provides the expected benefit, we extend the performance
tests of damon-tests suite to support virtual address space-based
proactive reclamation scheme that aims 0.5% last 10 seconds some memory
PSI.  The test suite runs PARSEC3 and SPLASH-2X workloads with the
scheme and measure the runtime, the RSS, and the PSI for memory (some).
We do same with the same scheme but not having the goal, and yet another
variant of it that the target access patterns of the scheme is tuned for
each workload, in a offline-tuning approach named DAMOOS[1].

The results that normalized to the output that made without any scheme
are as below.  The PSI for original run (without any scheme) was zero.
To avoid divide-by-zero, we normalize the value to that of Not-tuned
scheme's result.

    xx      Not-tuned         Offline-tuned     Online-tuned
    RSS     0.622688178226118 0.787950678944904 0.740093483278979
    runtime 1.11767826657912  1.0564674983585   1.0910833880499
    PSI     1                 0.727521443794069 0.308498846350299

The not-tuned scheme acheives about 38.7% memory saving but incur about
11.7% runtime slowdown.  The offline-tuned scheme achieves about 22.2%
memory saving with about 5.5% runtiem slowdown.  It also achieves about
28.2% PSI saving.  The online-tuned scheme achieves about 26% memory
saving with about 9.1% runtime slowdown.  It also achieves about 69.1%
PSI saving.  Given the online-tuned version is using this RFC level
implementation and the goal (0.5% last-10 secs memory PSI) was made
after only a few experiments within a day, I think this results show
some potential of this feedback-driven auto tuning approach.

The test code is available[2], so you can reproduce on your system.


[1] https://www.amazon.science/publications/daos-data-access-aware-operating-system
[2] https://github.com/damonitor/damon-tests/commit/3f884e61193f0166b8724554b6d06b0c449a712d


Patches Sequence
================

The first four patches implement the core logic and user interfaces for
the auto tuning.  The first patch implements the core logic for the auto
tuning, and the API for DAMOS users in the kernel space.  The second
patch implements basic file operations of DAMON sysfs directories and
files that will be used for setting the goals and providing the
feedback.  The third patch connects the quota goals files inputs to the
DAMOS core logic.  Finally the fourth patch implements a dedicated DAMOS
sysfs command for efficiently committing the quota goals feedback.

Two patches for simple test of the logic and interfaces follow.  The
fifth patch implements the core logic unit test.  The sixth patch
implements a selftest for the DAMON Sysfs interface for the goals.

Finally, two patches for documentation follows.  The seventh patch
documents the design of the feature.  The final eighth patch updates the
usage document for the features.

SeongJae Park (8):
  mm/damon/core: implement goal-oriented feedback-driven quota
    auto-tuning
  mm/damon/sysfs-schemes: implement scheme quota goals directory
  mm/damon/sysfs-schemes: commit damos quota goals user input to DAMOS
    quota auto-tuning
  mm/damon/sysfs-schemes: implement a command for scheme quota goals
    only commit
  mm/damon/core-test: add a unit test for the feedback loop algorithm
  selftests/damon: test quota goals directory
  Docs/mm/damon/design: Document DAMOS quota auto tuning
  Docs/admin-guide/mm/damon/usage: update for quota goals

 Documentation/admin-guide/mm/damon/usage.rst |  25 +-
 Documentation/mm/damon/design.rst            |  11 +
 include/linux/damon.h                        |  19 ++
 mm/damon/core-test.h                         |  32 +++
 mm/damon/core.c                              |  65 ++++-
 mm/damon/sysfs-common.h                      |   3 +
 mm/damon/sysfs-schemes.c                     | 272 ++++++++++++++++++-
 mm/damon/sysfs.c                             |  27 ++
 tools/testing/selftests/damon/sysfs.sh       |  27 ++
 9 files changed, 463 insertions(+), 18 deletions(-)


base-commit: 4f26b84c39fbc6b03208674681bfde06e0bce25a
-- 
2.34.1


