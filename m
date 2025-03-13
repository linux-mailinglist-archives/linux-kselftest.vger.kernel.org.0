Return-Path: <linux-kselftest+bounces-28925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0209BA5F310
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641963BF119
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A71F12F2;
	Thu, 13 Mar 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyhS4lKk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7F266B71
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866275; cv=none; b=gAiP5fak6mJVJVoM/AqW9UO2CrqSDed7e6JyZZe5H9dkr9CHW2Ovbp0n17YJIGCYsoQmh+t9AeE92y9iLS/FhHqXx8F8+tOlKq0FieNUeYpj7xJ8lgP+Jk4If4v3jpP/dZszCklfvyfNI6R6kEsKob0ko1gPiDQPwZC4sJCxNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866275; c=relaxed/simple;
	bh=RZxQPd6DhJpVyGhaRdUKVZqwkHQjwhx4+RC8j3iFEn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-type; b=gcKevQ0KOw5OoBzoMFkxu17rySqeONQ7Sph2pwEcYkJeaFv13WXYWjrLgimSJ4CUm83uOhXtu+S3OU0z5Cga+ly6bfXE8dj8Aj+Wvnm2KfdVm0P16Aa3NuzKQ1cvwm+KFZ02YgH/ocGIl4ySgTR2ZdZeLl5fwC/xTVFx1fM29dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyhS4lKk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vi3vqlZEjhRyke+tn+Q3MD+zw3p/H2XxVRSJ9/S1eBk=;
	b=SyhS4lKkaPXI30PtrxVEWTWXF48F6pS4JiMxk+zB4AljsFCjPmJqwQ6bBvSwQ8acn2zNaW
	DZE8b01aMUJ/q8hGVw33qVtfGhBT9L0DFxm5gplRIsV7Jkc8bLMzO7FaBJY+OhHeHKTTK+
	NL0LlyUDKxl0JEcqyZkw5sovF1mMVcE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-piVEfRF2PlSa0DxIblCmxw-1; Thu, 13 Mar 2025 07:44:31 -0400
X-MC-Unique: piVEfRF2PlSa0DxIblCmxw-1
X-Mimecast-MFC-AGG-ID: piVEfRF2PlSa0DxIblCmxw_1741866270
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912539665cso860810f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 04:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866269; x=1742471069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vi3vqlZEjhRyke+tn+Q3MD+zw3p/H2XxVRSJ9/S1eBk=;
        b=g53Sz0qFKo9dwwRgT1aM46ShF3UinfkzCdScPohUdbwZumv2kyAy2tSqzdDPHCRsU4
         nZEMC1S7ErSvq4Y81korbKzRiqYXevwb+L9MA/XTbVc3Dsrm6c2e6lMhyEc6G+VXSXPh
         ppkwLhfi2sXgoQrzCRyLe4mbXg+UMJ0jj8wRfmwL2bR33Ofr5gDUkX0ZU5pY/DU3e+DM
         /gsacf6wf99o8D1OY37ChhHMY8lYYg6s+n6oN01oReVUeUiFP54GpCG41A0SWEi16BQj
         vuZANdLXvOd4NVtmwDkkDsUCLHIjtwwAsUqXMYst66pXwGYvZ4KCujfXv+vP036jiIx9
         uDYw==
X-Gm-Message-State: AOJu0Yx+84yM30JR9AVIWydGjMSiIinKY4ZXZY6TigNwBlsCoIlQSfps
	NYuWQZWU0QATXuUqGiGYnzmsNx7/fdUL5orHY0UdcOzEYRESZaSV90k+JeKP+U5yeQj9s1ASbO/
	5fI1P+/E/BrMtJZDPv/tb7HsFWNTUOQefSfAozj4jnQZx50ZZMqGNTXclF3fH+8Xog7VvhlWYYQ
	FiJvT8uSxs0VJh3ZHBJGbtYh+HczAJuyxpBJp89M3w2OqTr3yedkhj
X-Gm-Gg: ASbGncui1GqrhjlzfkVLVDroBlh6lvWhvFzrgNrjxhl6Iam/kJ6upIfXZJXbA7S/jVL
	DxjRhjvQ5hirVgeA8PRyVb0fI8kIgOqMd0cIYyj0w7Eu4yzpnMPTixRqRwX4/kGRz/oJaBB6Yzu
	47ksioqJv6zsXsXOq873XPaIyoj4/X6103SUWh0cU84xCY+86cCNJkJbI6yLSnUp0VxSp5o4uyT
	pErhMzm5n/X8H2Z/mng0ohz3KGl11x2kpaG+WD0C3JzptzYVHvx0nJd72gSAK8T+aLOc3Txc2DO
	vF7P2Exdvk/MnzCGwK9z
X-Received: by 2002:a5d:64cb:0:b0:38f:23c4:208c with SMTP id ffacd0b85a97d-395b954ea75mr1784246f8f.18.1741866269162;
        Thu, 13 Mar 2025 04:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5B4S8E4d5tF3TI1rIoUvKO0tSV0G2B0BPE1gxY0qJz2LBrnTYS6FEhx79I2sbOMPQrE3jHw==
X-Received: by 2002:a5d:64cb:0:b0:38f:23c4:208c with SMTP id ffacd0b85a97d-395b954ea75mr1784186f8f.18.1741866268630;
        Thu, 13 Mar 2025 04:44:28 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:27 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	x86@kernel.org,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 00/14] Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:15 +0000
Message-Id: <20250313114329.284104-1-acarmina@redhat.com>
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
nor useful for a number of reasons.
- They can result in overlooked real problems.
- A warning that suddenly starts to show up in unit tests needs to be
  investigated and has to be marked to be ignored, for example by
  adjusting filter scripts. Such filters are ad-hoc because there is
  no real standard format for warnings. On top of that, such filter
  scripts would require constant maintenance.

One option to address problem would be to add messages such as "expected
warning backtraces start / end here" to the kernel log.  However, that
would again require filter scripts, it might result in missing real
problematic warning backtraces triggered while the test is running, and
the irrelevant backtrace(s) would still clog the kernel log.

Solve the problem by providing a means to identify and suppress specific
warning backtraces while executing test code. Support suppressing multiple
backtraces while at the same time limiting changes to generic code to the
absolute minimum. Architecture specific changes are kept at minimum by
retaining function names only if both CONFIG_DEBUG_BUGVERBOSE and
CONFIG_KUNIT are enabled.

The first patch of the series introduces the necessary infrastructure.
The second patch introduces support for counting suppressed backtraces.
This capability is used in patch three to implement unit tests.
Patch four documents the new API.
The next two patches add support for suppressing backtraces in drm_rect
and dev_addr_lists unit tests. These patches are intended to serve as
examples for the use of the functionality introduced with this series.
The remaining patches implement the necessary changes for all
architectures with GENERIC_BUG support.

With CONFIG_KUNIT enabled, image size increase with this series applied is
approximately 1%. The image size increase (and with it the functionality
introduced by this series) can be avoided by disabling
CONFIG_KUNIT_SUPPRESS_BACKTRACE.

This series is based on the RFC patch and subsequent discussion at
https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
and offers a more comprehensive solution of the problem discussed there.

Design note:
  Function pointers are only added to the __bug_table section if both
  CONFIG_KUNIT_SUPPRESS_BACKTRACE and CONFIG_DEBUG_BUGVERBOSE are enabled
  to avoid image size increases if CONFIG_KUNIT is disabled. There would be
  some benefits to adding those pointers all the time (reduced complexity,
  ability to display function names in BUG/WARNING messages). That change,
  if desired, can be made later.

Checkpatch note:
  Remaining checkpatch errors and warnings were deliberately ignored.
  Some are triggered by matching coding style or by comments interpreted
  as code, others by assembler macros which are disliked by checkpatch.
  Suggestions for improvements are welcome.

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

----
Guenter Roeck (14):
  bug/kunit: Core support for suppressing warning backtraces
  kunit: bug: Count suppressed warning backtraces
  kunit: Add test cases for backtrace warning suppression
  kunit: Add documentation for warning backtrace suppression API
  drm: Suppress intentional warning backtraces in scaling unit tests
  x86: Add support for suppressing warning backtraces
  arm64: Add support for suppressing warning backtraces
  loongarch: Add support for suppressing warning backtraces
  parisc: Add support for suppressing warning backtraces
  s390: Add support for suppressing warning backtraces
  sh: Add support for suppressing warning backtraces
  sh: Move defines needed for suppressing warning backtraces
  riscv: Add support for suppressing warning backtraces
  powerpc: Add support for suppressing warning backtraces

 Documentation/dev-tools/kunit/usage.rst |  30 ++++++-
 arch/arm64/include/asm/asm-bug.h        |  27 ++++--
 arch/arm64/include/asm/bug.h            |   8 +-
 arch/loongarch/include/asm/bug.h        |  42 +++++++---
 arch/parisc/include/asm/bug.h           |  29 +++++--
 arch/powerpc/include/asm/bug.h          |  37 +++++++--
 arch/riscv/include/asm/bug.h            |  38 ++++++---
 arch/s390/include/asm/bug.h             |  17 +++-
 arch/sh/include/asm/bug.h               |  28 ++++++-
 arch/x86/include/asm/bug.h              |  21 +++--
 drivers/gpu/drm/tests/drm_rect_test.c   |  16 ++++
 include/asm-generic/bug.h               |  16 +++-
 include/kunit/bug.h                     |  56 +++++++++++++
 include/kunit/test.h                    |   1 +
 include/linux/bug.h                     |  13 +++
 lib/bug.c                               |  51 +++++++++++-
 lib/kunit/Kconfig                       |   9 ++
 lib/kunit/Makefile                      |   7 +-
 lib/kunit/backtrace-suppression-test.c  | 104 ++++++++++++++++++++++++
 lib/kunit/bug.c                         |  42 ++++++++++
 20 files changed, 519 insertions(+), 73 deletions(-)
 create mode 100644 include/kunit/bug.h
 create mode 100644 lib/kunit/backtrace-suppression-test.c
 create mode 100644 lib/kunit/bug.c

-- 
2.34.1


