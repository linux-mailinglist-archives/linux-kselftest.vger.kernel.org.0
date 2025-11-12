Return-Path: <linux-kselftest+bounces-45425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2015C534F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 17:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A8544211
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AE2328B78;
	Wed, 12 Nov 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVg6vKow"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91230AAC1;
	Wed, 12 Nov 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962121; cv=none; b=RrNhJKAvoNvewUkbi8+aIXHnBp3Fw0g4WrlG4fUqOWH8PYD1ZxPfpD5Pqtz0bcYDqbI1FLcU9sryYXOnsDTpfUpdkFqJTlpa2c4soVDjvOEfnBmh5FlegcsAuc/6L643IIu+Jlb/TFTygeIMFdnSdMtP+hHiUCXiFNAbodytlBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962121; c=relaxed/simple;
	bh=RV6XEf4RD0FSD3rZ6zn+ujLr2U2ziSUdSWBe0aiDwBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eUe8tIER5ZIJcd8hSyGRqfHWgZNPDv6+4St5WPtJ/T99kBU2t1Bkm4/vXGZLFAehg9tOGXHIBFlLqQEoHxVwnD8NVspVepr7IkzUgHyCjf8AQ8mL6oHhH5jYW2uigxAvkROhlHCZWXsuf9IEpiS9Z0fieelMSOyWcxSpS0iy4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVg6vKow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88B5C4CEF7;
	Wed, 12 Nov 2025 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962120;
	bh=RV6XEf4RD0FSD3rZ6zn+ujLr2U2ziSUdSWBe0aiDwBo=;
	h=From:To:Cc:Subject:Date:From;
	b=aVg6vKowroSd0N7vGnLb3piydnhBDNsCjtJovexqZWBWkXsTe/9ohWwJqVFUVtVxE
	 NVzabcponIiM5dP/bhvobHVssD8SIjVhM6txqc/vtF+QVyrQDtidaC6cThCAGxrjxE
	 kujjKtMP0CxabrtCiDdqjKhH6GwOG5xW/Z2H1JydwtQfi6hILw9HkdrSZ+zisSOkHf
	 6/69xw2Wy7QKZtnhqHr0ybrz9ev6KFD9sbE1vLxtlRwlG+CR7HrQH2X0yZtruP5ogx
	 xJrM2cVPZyMC0cpoX3CyrrKwx5K0rNs6drjnmCug3F2Qj/wXGPp7CVFczHXYheaFDG
	 WmCxhH83o5l9w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Bill Wendling <morbo@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/9] mm/damon: misc cleanups
Date: Wed, 12 Nov 2025 07:41:03 -0800
Message-ID: <20251112154114.66053-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yet another batch of misc cleanups and refactoring for DAMON code,
tests, and documents.

First two patches (1and 2) rename DAMOS core filters related code for
readability.

Three following patches (3-5) refactor page table walk callback
functions in DAMON, as suggested by Hugh and David, and I promised.

Next two patches (6 and 7) refactor DAMON core layer kunit test and
sysfs interface selftest to be simple and deduplicated.

Final two patches (8 and 9) fix up sphinx and grammatical errors on
documents.

SeongJae Park (9):
  mm/damon: rename damos core filter helpers to have word core
  mm/damon: rename damos->filters to damos->core_filters
  mm/damon/vaddr: cleanup using pmd_trans_huge_lock()
  mm/damon/vaddr: use vm_normal_folio{,_pmd}() instead of
    damon_get_folio()
  mm/damon/vaddr: consistently use only pmd_entry for damos_migrate
  mm/damon/tests/core-kunit: remove DAMON_MIN_REGION redefinition
  selftests/damon/sysfs.py: merge DAMON status dumping into commitment
    assertion
  Docs/mm/damon/maintainer-profile: fix a typo on mm-untable link
  Docs/mm/damon/maintainer-profile: fix grammartical errors

 .clang-format                                 |   4 +-
 Documentation/mm/damon/maintainer-profile.rst |  10 +-
 include/linux/damon.h                         |  14 +-
 mm/damon/core.c                               |  25 ++-
 mm/damon/tests/core-kunit.h                   |  59 ++++----
 mm/damon/vaddr.c                              | 143 +++++++-----------
 .../selftests/damon/drgn_dump_damon_status.py |   8 +-
 tools/testing/selftests/damon/sysfs.py        |  45 ++----
 8 files changed, 121 insertions(+), 187 deletions(-)


base-commit: 4e9ec347bc14de636aec3014dee3b5d279ca33bf
-- 
2.47.3

