Return-Path: <linux-kselftest+bounces-43838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA3BFED54
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E228A4F13DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56C5CDF1;
	Thu, 23 Oct 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5VsN2Tb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BBEEC0;
	Thu, 23 Oct 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182740; cv=none; b=GtZuYCAwD8tkcWAie5hBeOURUqZEqVz4WM+uBlHWUSGTpe0RlmGNQavirXfoGW01AL1/Jtuzi8mylvWFI80okT+1+GiI3dMlPi6l4ke5C8UhFQ/Qd4lD2dj5V0dq0TlmkcA3Ho8SfW6k/6cAPXZ7Wqg72jfLgxaSUBI+Js0hzBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182740; c=relaxed/simple;
	bh=5dAZqb/8nKzWGonIOSbPc0VMsx+iKGKnuvKbkmMuljY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xwf8v6y2qHMOZ8b7GX0hceMdeGsvZrjfJsTMXqmZmYULnRua/C+ARjecDbogesGYVnkfriomFUL6Eodf7HhvyBSAgkLhBX0Y8ROf5E73hwTSZV0Mwv2LkGaxSJFhAelHUdwOVm0gLJlXMcIAZBkk78+X72v7COfSyKw/v+n7kxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5VsN2Tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D3AC4CEE7;
	Thu, 23 Oct 2025 01:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182740;
	bh=5dAZqb/8nKzWGonIOSbPc0VMsx+iKGKnuvKbkmMuljY=;
	h=From:To:Cc:Subject:Date:From;
	b=p5VsN2TbC2z+vM835LYYIWswWOiEQ6xdRmtG1t7XCvXQBthUHQD9ldMl2vCRCmGR+
	 FtOBnSJ1Uasrb35cEOosHVnRg1HeG22t8Q7NquQzTBlqF3eoLDcQ7P+hOlXAgoosfP
	 vbc6jEIZ9llkw5ia3cgAfZa2vMWWmy11FXlagHmY7EwXKYkKAm8UAyZZw+ZgIiVRmy
	 uiAqXUIecH4ayO+G397CA7tMAUsbWgGf1E8wuK4OwAUOBJG5I5412ud2ShTiiqhOTG
	 J3wCFqYtDdsHsjIKmKfbo+2jiBMSTuHroHZGzJvwXzPF4La1o37djH9LFvovvuDM+2
	 pDOY7sCbE04TA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Bijan Tabatabai <bijan311@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/9] mm/damon: support pin-point targets removal
Date: Wed, 22 Oct 2025 18:25:24 -0700
Message-ID: <20251023012535.69625-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON maintains the targets in a list, and allows committing only an
entire list of targets having the new parameters.  Targets having same
index on the lists are treated as matching source and destination
targets.  If an existing target cannot find a matching one in the
sources list, the target is removed.  This means that there is no way to
remove only a specific monitoring target in the middle of the current
targets list.

Such pin-point target removal is really needed in some use cases,
though.  Monitoring access patterns on virtual address spaces of
processes that spawned from the same ancestor is one example.  If a
process of the group is terminated, the user may want to remove the
matching DAMON target as soon as possible, to save in-kernel memory
usage for the unnecessary target data.  The user may also want to do
that without turning DAMON off or removing unnecessary targets, to keep
the current monitoring results for other active processes.

Extend DAMON kernel API and sysfs ABI to support the pin-point removal
in the following way.  For API, add a new damon_target field, namely
'obsolete'.  If the field on parameters commit source target is set, it
means the matching destination target is obsolete.  Then the parameters
commit logic removes the destination target from the existing targets
list.  For sysfs ABI, add a new file under the target directory, namely
'obsolete_target'.  It is connected with the 'obsolete' field of the
commit source targets, so internally using the new API.

Also add a selftest for the new feature.  The related helper scripts for
manipulating the sysfs interface and dumping in-kernel DAMON status are
also extended for this.  Note that the selftest part was initially
posted as an individual RFC series [1], but now merged into this one.

Bijan Tabatabai (bijan311@gmail.com) has originally reported this issue,
and participated in this solution design on a GitHub issue [1] for DAMON
user-space tool.

Changes from RFC
(https://lore.kernel.org/20251016214736.84286-1-sj@kernel.org)
- Wordsmith commit messages
- Add Reviewed-by: tags from Bijan
- Add a kselftest for the functionality of the new feature
  (https://lore.kernel.org/20251018204448.8906-1-sj@kernel.org)

[1] https://github.com/damonitor/damo/issues/36

SeongJae Park (9):
  mm/damon/core: add damon_target->obsolete for pin-point removal
  mm/damon/sysfs: test commit input against realistic destination
  mm/damon/sysfs: implement obsolete_target file
  Docs/admin-guide/mm/damon/usage: document obsolete_target file
  Docs/ABI/damon: document obsolete_target sysfs file
  selftests/damon/_damon_sysfs: support obsolete_target file
  drgn_dump_damon_status: dump damon_target->obsolete
  sysfs.py: extend assert_ctx_committed() for monitoring targets
  selftests/damon/sysfs: add obsolete_target test

 .../ABI/testing/sysfs-kernel-mm-damon         |  7 +++
 Documentation/admin-guide/mm/damon/usage.rst  | 13 +++--
 include/linux/damon.h                         |  6 +++
 mm/damon/core.c                               | 10 +++-
 mm/damon/sysfs.c                              | 51 ++++++++++++++++++-
 tools/testing/selftests/damon/_damon_sysfs.py | 11 +++-
 .../selftests/damon/drgn_dump_damon_status.py |  1 +
 tools/testing/selftests/damon/sysfs.py        | 48 +++++++++++++++++
 8 files changed, 140 insertions(+), 7 deletions(-)


base-commit: a3e008fdd7964bc3e6d876491c202d476406ed59
-- 
2.47.3

