Return-Path: <linux-kselftest+bounces-858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD17FE6EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 03:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B970C282210
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 02:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4585F10977;
	Thu, 30 Nov 2023 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4We1hTa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C31134B5;
	Thu, 30 Nov 2023 02:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6135C433C8;
	Thu, 30 Nov 2023 02:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701311819;
	bh=kmVvWSOSNg0jZKTITQFOc3w/RhYn3gjC0FKbwo8Ddmw=;
	h=From:To:Cc:Subject:Date:From;
	b=C4We1hTaQoMBxNMxK+etK/eU9uiVFvyaqY0ailoCmXBqYoLq3x4VxXTHvAzruRkPl
	 GIfBThPTbvy6LHqAHLHlOrsBBxRuBE6DuF7vtxpZDwEmtcgV8WMHBUtepnIaqfVuSN
	 FciTuVYgZ9LBeE1nHPlrxgC0uKdeh7QZ5mxu2/bk0Fi/HPJsp3q0XmIBjcKpd4Vlhm
	 cdYR/7tvoHLGkfqfNbu4SDN2igO9d8jsqBr04crSPyTzw8/c4T+n3J9jqkb8uCMtE8
	 cfyyCOGp9t9gMQdUHJhVCFBb+/gQP9959TZq8VuPOMySRAqLrykJzUXojEIkvRckWx
	 tJ6nkSdw3KixQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] mm/damon: let users feed and tame/auto-tune DAMOS
Date: Thu, 30 Nov 2023 02:36:43 +0000
Message-Id: <20231130023652.50284-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Aim-oriented Feedback-driven DAMOS Aggressiveness Auto-tuning.
It makes DAMOS self-tuned with periodic simple user feedback.

Patchset Changelog
==================

From RFC
(https://lore.kernel.org/damon/20231112194607.61399-1-sj@kernel.org/)
- Wordsmith commit messages and cover letter

Background: DAMOS Control Difficulty
====================================

DAMOS helps users easily implement access pattern aware system
operations.  However, controlling DAMOS in the wild is not that easy.

The basic way for DAMOS control is specifying the target access pattern.
In this approach, the user is assumed to well understand the access
pattern and the characteristics of the system and the workloads.  Though
there are useful tools for that, it takes time and effort depending on
the complexity and the dynamicity of the system and the workloads.
After all, the access pattern consists of three ranges, namely the size,
the access rate, and the age of the regions.  It means users need to
tune six parameters, which is anyway not a simple task.

One of the worst cases would be DAMOS being too aggressive like a
berserker, and therefore consuming too much system resource and making
unwanted radical system operations.  To let users avoid such cases,
DAMOS allows users to set the upper-limit of the schemes'
aggressiveness, namely DAMOS quota.  DAMOS further provides its
best-effort under the limit by prioritizing regions based on the access
pattern of the regions.  For example, users can ask DAMOS to page out up
to 100 MiB of memory regions per second.  Then DAMOS pages out regions
that are not accessed for a longer time (colder) first under the limit.
This allows users to set the target access pattern a bit naive with
wider ranges, and focus on tuning only one parameter, the quota.  In
other words, the number of parameters to tune can be reduced from six to
one.

Still, however, the optimum value for the quota depends on the system
and the workloads' characteristics, so not that simple.  The number of
parameters to tune can also increase again if the user needs to run
multiple schemes.

Aim-oriented Feedback-driven DAMOS Aggressiveness Auto Tuning
=============================================================

Users would use DAMOS since they want to achieve something with it.
They will likely have measurable metrics representing the achievement
and the target number of the metric like SLO, and continuously measure
that anyway.  While the additional cost of getting the information is
nearly zero, it could be useful for DAMOS to understand how appropriate
its current aggressiveness is set, and adjust it on its own to make the
metric value more close to the target.

Based on this idea, we introduce a new way of tuning DAMOS with nearly
zero additional effort, namely Aim-oriented Feedback-driven DAMOS
Aggressiveness Auto Tuning.  It asks users to provide feedback
representing how well DAMOS is doing relative to the users' aim.  Then
DAMOS adjusts its aggressiveness, specifically the quota that provides
the best effort result under the limit, based on the current level of
the aggressiveness and the users' feedback.

Implementation
--------------

The implementation asks users to represent the feedback with score
numbers.  The scores could be anything including user-space specific
metrics including latency and throughput of special user-space
workloads, and system metrics including free memory ratio, memory
pressure stall time (PSI), and active to inactive LRU lists size ratio.
The feedback scores and the aggressiveness of the given DAMOS scheme are
assumed to be positively proportional, though.  Selecting metrics of the
assumption is the users' responsibility.

The core logic uses the below simple feedback loop algorithm to
calculate the next aggressiveness level of the scheme from the current
aggressiveness level and the current feedback (target_score and
current_score).  It calculates the compensation for next aggressiveness
as a proportion of current aggressiveness and distance to the target
score.  As a result, it arrives at the near-goal state in a short time
using big steps when it's far from the goal, but avoids making
unnecessarily radical changes that could turn out to be a bad decision
using small steps when its near to the goal.

    f(n) = max(1, f(n - 1) * ((target_score - current_score) / target_score + 1))

Note that the compensation value becomes negative when it's over
achieving the goal.  That's why the feedback metric and the
aggressiveness of the scheme should be positively proportional.  The
distance-adaptive speed manipulation is simply applied.

Example Use Cases
-----------------

If users want to reduce the memory footprint of the system as much as
possible as long as the time spent for handling the resulting memory
pressure is within a threshold, they could use DAMOS scheme that
reclaims cold memory regions aiming for a little level of memory
pressure stall time.

If users want the active/inactive LRU lists well balanced to reduce the
performance impact due to possible future memory pressure, they could
use two schemes.  The first one would be set to locate hot pages in the
active LRU list, aiming for a specific active-to-inactive LRU list size
ratio, say, 70%.  The second one would be to locate cold pages in the
inactive LRU list, aiming for a specific inactive-to-active LRU list
size ratio, say, 30%.  Then, DAMOS will balance the two schemes based on
the goal and feedback.

This aim-oriented auto tuning could also be useful for general
balancing-required access aware system operations such as system memory
auto scaling[3] and tiered memory management[4].  These two example
usages are not what current DAMOS implementation is already supporting,
but require additional DAMOS action developments, though.

Evaluation: subtle memory pressure aiming proactive reclamation
---------------------------------------------------------------

To show if the implementation works as expected, we prepare four
different system configurations on AWS i3.metal instances.  The first
setup (original) runs the workload without any DAMOS scheme.  The second
setup (not-tuned) runs the workload with a virtual address space-based
proactive reclamation scheme that pages out memory regions that are not
accessed for five seconds or more.  The third setup (offline-tuned) runs
the same proactive reclamation DAMOS scheme, but after making it tuned
for each workload offline, using our previous user-space driven
automatic tuning approach, namely DAMOOS[1].  The fourth and final setup
(AFDAA) runs the scheme that is the same as that of 'not-tuned' setup,
but aims to keep 0.5% of 'some' memory pressure stall time (PSI) for the
last 10 seconds using the aiming-oriented auto tuning.

For each setup, we run realistic workloads from PARSEC3 and SPLASH-2X
benchmark suites.  For each run, we measure RSS and runtime of the
workload, and 'some' memory pressure stall time (PSI) of the system.  We
repeat the runs five times and use averaged measurements.

For simple comparison of the results, we normalize the measurements to
those of 'original'.  In the case of the PSI, though, the measurement
for 'original' was zero, so we normalize the value to that of
'not-tuned' scheme's result.  The normalized results are shown below.

            Not-tuned         Offline-tuned     AFDAA
    RSS     0.622688178226118 0.787950678944904 0.740093483278979
    runtime 1.11767826657912  1.0564674983585   1.0910833880499
    PSI     1                 0.727521443794069 0.308498846350299

The 'not-tuned' scheme achieves about 38.7% memory saving but incur
about 11.7% runtime slowdown.  The 'offline-tuned' scheme achieves about
22.2% memory saving with about 5.5% runtime slowdown.  It also achieves
about 28.2% memory pressure stall time saving.  AFDAA achieves about 26%
memory saving with about 9.1% runtime slowdown.  It also achieves about
69.1% memory pressure stall time saving.  We repeat this test multiple
times, and get consistent results.  AFDAA is now integrated in our daily
DAMON performance test setup.

Apparently the aggressiveness of 'AFDAA' setup is somewhere between
those of 'not-tuned' and 'offline-tuned' setup, since its memory saving
and runtime overhead are between those of the other two setups.
Actually we set the memory pressure stall time goal aiming for this
middle aggressiveness.  The difference in the two metrics are not
significant, though.  However, it shows significant saving of the memory
pressure stall time, which was the goal of the auto-tuning, over the two
variants.  Hence, we conclude the automatic tuning is working as
expected.

Please note that the AFDAA setup is only for the evaluation, and
therefore intentionally set a bit aggressive.  It might not be
appropriate for production environments.

The test code is also available[2], so you could reproduce it on your
system and workloads.

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

Two patches for simple tests of the logic and interfaces follow.  The
fifth patch implements the core logic unit test.  The sixth patch
implements a selftest for the DAMON Sysfs interface for the goals.

Finally, three patches for documentation follows.  The seventh patch
documents the design of the feature.  The eighth patch updates the API
doc for the new sysfs files.  The final eighth patch updates the usage
document for the features.

References
==========

[1] DAOS paper:
    https://www.amazon.science/publications/daos-data-access-aware-operating-system
[2] Evaluation code:
    https://github.com/damonitor/damon-tests/commit/3f884e61193f0166b8724554b6d06b0c449a712d
[3] Memory auto scaling RFC idea:
    https://lore.kernel.org/damon/20231112195114.61474-1-sj@kernel.org/
[4] DAMON-based tiered memory management RFC idea:
    https://lore.kernel.org/damon/20231112195602.61525-1-sj@kernel.org/

SeongJae Park (9):
  mm/damon/core: implement goal-oriented feedback-driven quota
    auto-tuning
  mm/damon/sysfs-schemes: implement files for scheme quota goals setup
  mm/damon/sysfs-schemes: commit damos quota goals user input to DAMOS
  mm/damon/sysfs-schemes: implement a command for scheme quota goals
    only commit
  mm/damon/core-test: add a unit test for the feedback loop algorithm
  selftests/damon: test quota goals directory
  Docs/mm/damon/design: document DAMOS quota auto tuning
  Docs/ABI/damon: document DAMOS quota goals
  Docs/admin-guide/mm/damon/usage: document for quota goals

 .../ABI/testing/sysfs-kernel-mm-damon         |  33 ++-
 Documentation/admin-guide/mm/damon/usage.rst  |  48 +++-
 Documentation/mm/damon/design.rst             |  13 +
 include/linux/damon.h                         |  19 ++
 mm/damon/core-test.h                          |  32 +++
 mm/damon/core.c                               |  68 ++++-
 mm/damon/sysfs-common.h                       |   3 +
 mm/damon/sysfs-schemes.c                      | 272 +++++++++++++++++-
 mm/damon/sysfs.c                              |  27 ++
 tools/testing/selftests/damon/sysfs.sh        |  27 ++
 10 files changed, 517 insertions(+), 25 deletions(-)


base-commit: b4e0245a831a402cae8634a4dc277a04830ff07a
-- 
2.34.1


