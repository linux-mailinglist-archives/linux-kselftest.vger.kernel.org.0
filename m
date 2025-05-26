Return-Path: <linux-kselftest+bounces-33784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C34AC4057
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFD31888CB8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D895202C46;
	Mon, 26 May 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvK05rX3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA11876
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266102; cv=none; b=jdSYsQIjT3z2ZFhWoOZ26mkaGDbqRGc1VUKzFIk1KYLqd7mLnbaBhEcU5B/Ikzea2nVBS2Asypfjv3s0Ej9lteIvwBG3x+PP8TenvvGBGhfDWZF+jpc3R0/d/HL+Id8nZtVNHg8IkGOeMZEnjsdiyYtQ55YUlBpKi6opaH/wwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266102; c=relaxed/simple;
	bh=jWGCVJvCwWmqnY7C1gLvFAf5WbhXCFFFGXco88wozQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-type; b=ibn2yy8Zg+AWTyLWgLnIns0oTUJzNYyvkQ3yESXEAdMtcOyxHeXvyqxrjoqt5vOxIKu1Tw7WD5UA5dKaUqEilFVy5psOvAa8bSLdm0JtxqeKFqL0RZY0PlzyHOy6ab1E0TQ+pyj1lmd82io3+Rn7020jcGLPpjwB70u/y/PtGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvK05rX3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748266098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CaDjeuor3qvehrWwyZqxrxslYPrtt2O/kVi0sHBOQXY=;
	b=WvK05rX3UUyLIwbLFHRjmVWSHY+/Tep0usbbB4NUnwRmJNv08gdLaBh+/0PDUR7T2oeQiO
	UN8gIjz09sTU9+cwrw3rgoeDz17hy/zp/26dp9LQasS7hodr/JJI1DHZczH3NvpkoiwqZj
	cpNI2SXr9SCTeAppC9PXwcj9CAF7cio=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-FkTwtWvOM7esFUBCFlIvSQ-1; Mon, 26 May 2025 09:28:16 -0400
X-MC-Unique: FkTwtWvOM7esFUBCFlIvSQ-1
X-Mimecast-MFC-AGG-ID: FkTwtWvOM7esFUBCFlIvSQ_1748266096
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4dcfb3bbcso304339f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 06:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266095; x=1748870895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaDjeuor3qvehrWwyZqxrxslYPrtt2O/kVi0sHBOQXY=;
        b=daWUIMaki7lkIr5X+XV0VFImi5Te6fZvbzTnK1MqKMKg8hWdv42T0fwOvTV3qcmYQG
         dXdNpDg2Yaxbz7qEqiAiqveuBFFopDNtkXYBwwldnYjxVz5MRhzlVks3t7V1KyjCJinF
         nf3QL5XlTXAcxLD5U1FoT1CLNfFbperTijvjUtH8GlsiPSDVQ2GtWkHUx7k/z7K63e3T
         1PRDyTVuP+5p7MdUIuIgaF8ZX9BsAKrEcNEV6DkNW+UCRnPXbBRkB6lKXNMVm9iK0KXw
         cCTiLRauUhuh6mJNkHMIC+96Tm43DVs7bUKPSo2FqYqcAm75zy7eYjg7nQ8/I3ts13Gm
         Co3g==
X-Gm-Message-State: AOJu0YwNmo06oZiwvIyA8hTBGTkEicQVTw4CgztyuLiDrs7QhDxDAS/+
	GIS7CGGZNLe0ivbuK7ocRMSk+aKgky0+JAhyJHKVmWY3DyhHzHAKERRL9cTCJUIbzhPqgvS2C7n
	WRLVKWII1kv7v7/ArGJqDxp9RI/3i142NehCdkXxhEp/cfJseZLYs2jVpyfxCnPj5eeM09qtV8X
	zcbhW+8Rz3mUp8yj968dtnMWVaq8w52kquBMxLalyuF/UD5Uu2EWdvlIdW
X-Gm-Gg: ASbGncsfEXnyQojLeAvAcYyDTqBL05YVSzWlIuajD9VLHZBVJ/QGSylQHk6llji4qv1
	KXmF64hsQ3DEwRLDVzYRuEPYC/FdevB7psy8D3M4mfkjh429KTt8VWOx8sYV6NZaKbBqGJqo7+7
	/sErZW4yUPfYEGhzI4JGZmRkCLKUfLRmqatX99TpxaGQhQJJgccRufHL1d4PoDSdczURdpTYHHj
	mHqBkTUyuEQS6TL9g5LU27XrmzMjkKS2ltRg2iwQxRnsvO7+gRYxnCyaSWk26tqksufg9vwC0ju
	QJjq2BMYuSLecJ/M
X-Received: by 2002:a05:6000:2301:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a4da873b5dmr1710171f8f.42.1748266094862;
        Mon, 26 May 2025 06:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeYvbzrZNcWcmW1qUBxQajDh+d2LT6ajoVkh4KOQZsRA+0DvHZ1ZoRl+TxtNrpzzd9byku2A==
X-Received: by 2002:a05:6000:2301:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a4da873b5dmr1710127f8f.42.1748266094346;
        Mon, 26 May 2025 06:28:14 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4c8455e7dsm8836663f8f.9.2025.05.26.06.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 06:28:13 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v5 0/5] kunit: Add support for suppressing warning backtraces
Date: Mon, 26 May 2025 13:27:50 +0000
Message-Id: <20250526132755.166150-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Some unit tests intentionally trigger warning backtraces by passing bad
parameters to kernel API functions. Such unit tests typically check the
return value from such calls, not the existence of the warning backtrace.

Such intentionally generated warning backtraces are neither desirable
nor useful for a number of reasons:
- They can result in overlooked real problems.
- A warning that suddenly starts to show up in unit tests needs to be
  investigated and has to be marked to be ignored, for example by
  adjusting filter scripts. Such filters are ad hoc because there is
  no real standard format for warnings. On top of that, such filter
  scripts would require constant maintenance.

One option to address the problem would be to add messages such as
"expected warning backtraces start/end here" to the kernel log.
However, that would again require filter scripts, might result in
missing real problematic warning backtraces triggered while the test
is running, and the irrelevant backtrace(s) would still clog the
kernel log.

Solve the problem by providing a means to identify and suppress specific
warning backtraces while executing test code. Support suppressing multiple
backtraces while at the same time limiting changes to generic code to the
absolute minimum.

Overview:
Patch#1 Introduces the suppression infrastructure.
Patch#2 Mitigate the impact at WARN*() sites.
Patch#3 Adds selftests to validate the functionality.
Patch#4 Demonstrates real-world usage in the DRM subsystem.
Patch#5 Documents the new API and usage guidelines.

Design Notes:
The objective is to suppress unwanted WARN*() generated messages.

Although most major architectures share common bug handling via `lib/bug.c`
and `report_bug()`, some minor or legacy architectures still rely on their
own platform-specific handling. This divergence must be considered in any
such feature. Additionally, a key challenge in implementing this feature is
the fragmentation of `WARN*()` messages emission: specific part in the
macro, common with BUG*() part in the exception handler.
As a result, any intervention to suppress the message must occur before the
illegal instruction.

Lessons from the Previous Attempt
In earlier iterations, suppression logic was added inside the
`__report_bug()` function to intercept WARN*() messages not producing
messages in the macro.
To implement the check in the check in the bug handler code, two strategies
were considered:

* Strategy #1: Use `kallsyms` to infer the originating functionid, namely
  a pointer to the function. Since in any case, the user interface relies
  on function names, they must be translated in addresses at suppression-
  time or at check-time.
  Assuming to translate at suppression-time, the `kallsyms` subsystem needs
  to be used to determine the symbol address from the name, and again to
  produce the functionid from `bugaddr`. This approach proved unreliable
  due to compiler-induced transformations such as inlining, cloning, and
  code fragmentation. Attempts to preventing them is also unconvenient
  because several `WARN()` sites are in functions intentionally declared 
  as `__always_inline`.

* Strategy #2: Store function name `__func__` in `struct bug_entry` in
  the `__bug_table`. This implementation was used in the previous version.
  However, `__func__` is a compiler-generated symbol, which complicates
  relocation and linking in position-independent code. Workarounds such as
  storing offsets from `.rodata` or embedding string literals directly into
  the table would have significantly either increased complexity or
  increase the __bug_table size. 
  Additionally, architectures not using the unified `BUG()` path would 
  still require ad-hoc handling. Because current WARN*() message production
  strategy, a few WARN*() macros still need a check to suppress the part of
  the message produced in the macro itself.

Current Proposal: Check Directly in the `WARN()` Macros.
This avoids the need for function symbol resolution or ELF section
modification.
Suppression is implemented directly in the `WARN*()` macros.

A helper function, `__kunit_is_suppressed_warning()`, is used to determine
whether suppression applies. It is marked as `noinstr`, since some `WARN*()`
sites reside in non-instrumentable sections. As it uses `strcmp`, a
`noinstr` version of `strcmp` was introduced.
The implementation is deliberately simple and avoids architecture-specific
optimizations to preserve portability. Since this mechanism compares
function names and is intended for test usage only, performance is not a
primary concern.

This series is based on the RFC patch and subsequent discussion at
https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
and offers a more comprehensive solution of the problem discussed there.

Changes since RFC:
- Introduced CONFIG_KUNIT_SUPPRESS_BACKTRACE
- Minor cleanups and bug fixes
- Added support for all affected architectures
- Added support for counting suppressed warnings
- Added unit tests using those counters
- Added patch to suppress warning backtraces in dev_addr_lists tests

Changes since v1:
- Rebased to v6.9-rc1
- Added Tested-by:, Acked-by:, and Reviewed-by: tags
  [I retained those tags since there have been no functional changes]
- Introduced KUNIT_SUPPRESS_BACKTRACE configuration option, enabled by
  default.

Changes since v2:
- Rebased to v6.9-rc2
- Added comments to drm warning suppression explaining why it is needed.
- Added patch to move conditional code in arch/sh/include/asm/bug.h
  to avoid kerneldoc warning
- Added architecture maintainers to Cc: for architecture specific patches
- No functional changes

Changes since v3:
- Rebased to v6.14-rc6
- Dropped net: "kunit: Suppress lock warning noise at end of dev_addr_lists tests"
  since 3db3b62955cd6d73afde05a17d7e8e106695c3b9
- Added __kunit_ and KUNIT_ prefixes.
- Tested on interessed architectures.

Changes since v4:
- Rebased to v6.15-rc7
- Dropped all code in __report_bug()
- Moved all checks in WARN*() macros.
- Dropped all architecture specific code.
- Made __kunit_is_suppressed_warning nice to noinstr functions.

Alessandro Carminati (2):
  bug/kunit: Core support for suppressing warning backtraces
  bug/kunit: Suppressing warning backtraces reduced impact on WARN*()
    sites

Guenter Roeck (3):
  Add unit tests to verify that warning backtrace suppression works.
  drm: Suppress intentional warning backtraces in scaling unit tests
  kunit: Add documentation for warning backtrace suppression API

 Documentation/dev-tools/kunit/usage.rst |  30 ++++++-
 drivers/gpu/drm/tests/drm_rect_test.c   |  16 ++++
 include/asm-generic/bug.h               |  48 +++++++----
 include/kunit/bug.h                     |  62 ++++++++++++++
 include/kunit/test.h                    |   1 +
 lib/kunit/Kconfig                       |   9 ++
 lib/kunit/Makefile                      |   9 +-
 lib/kunit/backtrace-suppression-test.c  | 105 ++++++++++++++++++++++++
 lib/kunit/bug.c                         |  54 ++++++++++++
 9 files changed, 316 insertions(+), 18 deletions(-)
 create mode 100644 include/kunit/bug.h
 create mode 100644 lib/kunit/backtrace-suppression-test.c
 create mode 100644 lib/kunit/bug.c

-- 
2.34.1


