Return-Path: <linux-kselftest+bounces-28736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28485A5C240
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299883B201C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA436192D96;
	Tue, 11 Mar 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbdTYZc9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C1156C62
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699101; cv=none; b=ZBGiZWssxQlrm/S1akw4nALgN2FfHw4y4kmT+ShioLaeXVNqrBfWHIgrOL+aUnD11C2wPcYSzFe48Bgl2cn8BJQM4z8qf+4WGe/tYlI0F69y6RhvKVJ08RWze79D9zrHc4NTzDY8ihhZ/1s2NK2X4V+0jcD2FvZziRsUkAxLIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699101; c=relaxed/simple;
	bh=kZWbCuYaORPFU8w7lpayL1MqlPThbNYBuwG+AoUzEec=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CxxM8HVUSI9KCpeJa8x02dXxqtpVw1Y6ZTzjUrHR0hf7A7D6/wGCZBSk5viIq7CkR957gXuN+LsSdD99oyyUY9qwciNc07AQzR3v7O/qvtsStX/HkwdoXSfL56Hg5kIhIFW/hvTnbd2bPXFI0WI8UuKhwx0lt3uviKM2c6F9v2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbdTYZc9; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so46270805e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699098; x=1742303898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y/V3ij2YZYBELRjrNa6UOH2HSQ/70gTUpUW2w6XjdEU=;
        b=jbdTYZc9CYChxKxJeexq7ATKWviMtjKR0YazIXTyIcyXSuNwiIekpv9z47JO3epmuP
         6r0liaKd+1FcZKYjBz4YPqdrVg2BfuZIu4Z5+xn6FUWtjsPZOUJP2n34WrcabNHcwlOt
         a+KLNHEs2UYePwttoIpa+Srn70sUgvZb2aFg92nPyU1pdUkjlkCLj46omV44lHTCE2sl
         OAZiDFC06857mmnRinRlbqEaooJlTEYlVscWhPiBSwI8r82vY4MF6EOSgqWOL4s4UK8u
         Dnd5e04lNHcG71AGfqetPppeo+wyWabc1Xg/yi57tKHyZydpFVBBNTWt+xxSBa6uuwz5
         wbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699098; x=1742303898;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/V3ij2YZYBELRjrNa6UOH2HSQ/70gTUpUW2w6XjdEU=;
        b=vx2vyxfZmp87krNgs9C1dvh1lknjJz61f10l6xLLp0G6JM5KvAGv9Ue1OuPxC/ZOQZ
         CGVigVTY49ZTzgMZj6tiYz7MUONgSCC0E7RanI9tol+hhsAqfL/816LrG4Z3LDmhkpDs
         7gwNxwzk2kZGCh+6QnyvgrIjj94HlSvfjNOXVrfrngW8oqdGbDnGhIcaFmlGiDO+GNAj
         4+284+kd5lecDawr4axJayRq/qNaBSbJDOc6QaW/Rmecg6nKmvwXrHHJs2DAAJiZebNS
         iLOR3Dr0AvGbJ/ip8sJ/zWv5F5t3zdGhm+R3hl46wZyg4Vpj3QSzBwjow4o3++ni1v3o
         QtZg==
X-Forwarded-Encrypted: i=1; AJvYcCXn0eAPgzmtTnj5LQ4hXxV3Sl1/Y2g1aJHVvUUAayhnSHVbaReBcis7BVepp6bWLLvfoFABwq8HEWPA9aplFHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4UbknJLyyPFlanDEkLTqZuAF2GFK5yXhnmdbhCS06ADh9PV4
	sxVbL/DBQpsdZOh1K/4uBZdvGj8zuWTSEYzDy2QGuNnRmP8pHnlGgKL0MWIT7ZIPUZP1QRxY8Za
	cUwvPk23aFA==
X-Google-Smtp-Source: AGHT+IEdpBmFLHqg0EwNWaYJjDN9PewywJgWEJo/obnFlbCutpR2jQdlCSgkfmSa3XZZhJ1mYrZR1WEEKTY4zw==
X-Received: from wmqc17.prod.google.com ([2002:a05:600c:a51:b0:43c:f5b8:aad0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1a:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-43d03df4496mr34621635e9.6.1741699098504;
 Tue, 11 Mar 2025 06:18:18 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:11 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABQ40GcC/3XNTQ6CMBCG4auQrq0p0x/QlfcwLqCdQhOgpiVEQ
 7i7hRViXH6TPO/MJGJwGMk1m0nAyUXnhzTEKSO6rYYGqTNpE2AgGQCjfU8jdnbEOEYKpjBMCrC
 VRpLIM6B1ry13f6Tdujj68N7qU75e/4SmnDJ6qWsrC6OEUPzWeN90eNa+J2tpgr3ODxqShlILo xQvuZY/mu91edB8/S1L5LWyDNj372VZPqv0VHIlAQAA
X-Change-Id: 20250220-mm-selftests-2d7d0542face
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Subject: [PATCH v4 00/12] selftests/mm: Some cleanups from trying to run them
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="utf-8"

I never had much luck running mm selftests so I spent a few hours
digging into why.

Looks like most of the reason is missing SKIP checks, so this series is
just adding a bunch of those that I found. I did not do anything like
all of them, just the ones I spotted in gup_longterm, gup_test, mmap,
userfaultfd and memfd_secret.

It's a bit unfortunate to have to skip those tests when ftruncate()
fails, but I don't have time to dig deep enough into it to actually make
them pass. I have observed the issue on 9pfs and heard rumours that NFS
has a similar problem.

I'm now able to run these test groups successfully:

- mmap
- gup_test
- compaction
- migration
- page_frag
- userfaultfd
- mlock

I've never gone past "Waiting for hugetlb memory to get depleted", in
the hugetlb tests. I don't know if they are stuck or if they would
eventually work if I was patient enough (testing on a 1G machine). I
have not investigated further.

I had some issues with mlock tests failing due to -ENOSRCH from
mlock2(), I can no longer reproduce that though, things work OK now.

Of the remaining tests there may be others that work fine, but there's
no convenient way to survey the whole output of run_vmtests.sh so I'm
just going test by test here.

In my spare moments I am slowly chipping away at a setup to run these
tests continuously in a reasonably hermetic QEMU environment via
virtme-ng:

https://github.com/bjackman/linux/blob/5fad4b9c592290f38e0f8bc73c9abb9c99d8787c/README.md

Hopefully that will eventually offer a way to provide a "canned"
environment where the tests are known to work, which can be fairly
easily reproduced by any developer.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v4:
- NOT ADDRESSED: still using errno==ENOENT as a hacky way to detect
  buggy filesystems:
  https://lore.kernel.org/all/CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com/
- Added some incomplete cleanups for the mlock tests.
- Fixed divide-by-zero error when running uffd-stress on <32cpu systems.
- Fixed misnamed nr_threads variable (now nr_parallel).
- Fixed reporting io_uring errors (retval instead of errno).
- Link to v3: https://lore.kernel.org/r/20250228-mm-selftests-v3-0-958e3b6f0203@google.com

Changes in v3:
- Added fix for userfaultfd tests.
- Dropped attempts to use sudo.
- Fixed garbage printf in uffd-stress.
  (Added EXTRA_CFLAGS=-Werror FORCE_TARGETS=1 to my scripts to prevent
   such errors happening again).
- Fixed missing newlines in ksft_test_result_skip() calls.
- Link to v2: https://lore.kernel.org/r/20250221-mm-selftests-v2-0-28c4d66383c5@google.com

Changes in v2 (Thanks to Dev for the reviews):
- Improve and cleanup some error messages
- Add some extra SKIPs
- Fix misnaming of nr_cpus variable in uffd tests
- Link to v1: https://lore.kernel.org/r/20250220-mm-selftests-v1-0-9bbf57d64463@google.com

---
Brendan Jackman (12):
      selftests/mm: Report errno when things fail in gup_longterm
      selftests/mm: Skip uffd-stress if userfaultfd not available
      selftests/mm: Skip uffd-wp-mremap if userfaultfd not available
      selftests/mm/uffd: Rename nr_cpus -> nr_parallel
      selftests/mm: Print some details when uffd-stress gets bad params
      selftests/mm: Don't fail uffd-stress if too many CPUs
      selftests/mm: Skip map_populate on weird filesystems
      selftests/mm: Skip gup_longterm tests on weird filesystems
      selftests/mm: Drop unnecessary sudo usage
      selftests/mm: Ensure uffd-wp-mremap gets pages of each size
      selftests/mm: Skip mlock tests if nobody user can't read it
      selftests/mm/mlock: Print error on failure

 tools/testing/selftests/mm/gup_longterm.c      | 45 +++++++++++++++++---------
 tools/testing/selftests/mm/map_populate.c      |  7 ++++
 tools/testing/selftests/mm/mlock-random-test.c |  4 +--
 tools/testing/selftests/mm/mlock2.h            |  8 ++++-
 tools/testing/selftests/mm/run_vmtests.sh      | 27 ++++++++++++++--
 tools/testing/selftests/mm/uffd-common.c       |  8 ++---
 tools/testing/selftests/mm/uffd-common.h       |  2 +-
 tools/testing/selftests/mm/uffd-stress.c       | 42 +++++++++++++++---------
 tools/testing/selftests/mm/uffd-unit-tests.c   |  2 +-
 tools/testing/selftests/mm/uffd-wp-mremap.c    |  5 ++-
 10 files changed, 105 insertions(+), 45 deletions(-)
---
base-commit: dcb38e6757f1b7944af9347ce6b54263d3666478
change-id: 20250220-mm-selftests-2d7d0542face

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


