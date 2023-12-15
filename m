Return-Path: <linux-kselftest+bounces-2002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB54B81428F
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 08:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424D71F232D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 07:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A709D534;
	Fri, 15 Dec 2023 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/RaSu98"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1F12E75
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbcfd1b2c96so100681276.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 23:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702625953; x=1703230753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mp/8hWJv2G3IEKZLrg9ZmDkM8WmGCalwoEjWRw4iU4I=;
        b=l/RaSu98NWmILQWuM6rpl6zMyxbpbwNz5KIo9kTWfntjLzb2z3FiQlmQAufrErANHT
         dDzaj3j7hVnfNg5wnniuA4g2980iXazQa/BeoTi4LPn8KYKVDCtyVxqy1UvgE+kKvwq1
         /QgqK/pi+sODqBCWmYRmR+dIkrPDWf0bHqoYn4pYa6hVNCRevcnmfBHgmSoFJzRVJpKM
         s0Gq1ICunwOB0rDco4o3b56lRR79dtn0SbQ4BQU4PoJLjSWqMaAdLcSbNyv6JK2gz6NE
         UixTZ816jrYR73ON6JMT1BJJEVkCt9z2SOE8ypGbKC02wKDvGMOXj22xfW/3hoZ5xKui
         4Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625953; x=1703230753;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mp/8hWJv2G3IEKZLrg9ZmDkM8WmGCalwoEjWRw4iU4I=;
        b=UB69sKQmwgc9RrCnX/Uz0eUmLtBLfxai6wUWLsPNZpcSQm2Ye415PPunk5PWAyVluG
         43G9adF+ac1cOGvSnVO4+pnRszf4ijQul9g587fszHcrWDZr2jmKxHroSQLnNDbpwARU
         Oz6zZ6eLP7YEksJQ/6o91QeaFn3TojQamMKVjCVsOi85gffdt4JSdBiqQnNYG+VlOiXh
         YM4jqzNfS7BhzA/8bpsItKE21wy07dD3CH488q4iRoPtba2rW4rAUc66E8KS7NMlGEF0
         U2RuARt2mbvPQwGwYaWW4MLsZJfjbHXP+j4yI/ZR5CJH0fmntXZKyJ0+kKASfoQbjZTZ
         S1BQ==
X-Gm-Message-State: AOJu0YxoldB9HtlXuT7C4lqopOGR2HqRrQO3VI97FM/GkJ3pntrT1bEr
	vCCdAXXDEsVg2DkdwBictZjF/xCdM98Qsw==
X-Google-Smtp-Source: AGHT+IGHET7uXEidWHXMGL3nVLfetoQmh9ZEua39AXsgZMYdcjq38i3NEbBG3nl+MkvvMOLIudj38fXqOB+xkA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:a122:0:b0:dbc:35fe:5e81 with SMTP id
 z31-20020a25a122000000b00dbc35fe5e81mr102923ybh.12.1702625953359; Thu, 14 Dec
 2023 23:39:13 -0800 (PST)
Date: Fri, 15 Dec 2023 15:39:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJsCfGUC/2XO0Q6CIBTG8VdxXEcDDqh01Xu01hSOyippUqzmf
 PfQK1qX3xm//5hJwMlhIIdiJhNGF5wf05C7gpihGXukzqZNBBPAKl7T62t0z0v7CrRpuTYSO1l
 bQ9L7x4Sde2+t0zntwYWnnz5bOvL1ulW4YCqrRE4ZLUExKC20hsOx976/4d74O1kzUeQ0/0AUi aJWmimrWxDqj0JGucwpJFqhbkRdWWCy/qHLsnwBjE6oShkBAAA=
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
Subject: [PATCH v4 0/5] kunit: Add helpers for creating test-managed devices
From: davidgow@google.com
To: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org, 
	David Gow <davidgow@google.com>, Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="utf-8"

KUnit tests often need to provide a struct device, and thus far have
mostly been using root_device_register() or platform devices to create
a 'fake device' for use with, e.g., code which uses device-managed
resources. This has several disadvantages, including not being designed
for test use, scattering files in sysfs, and requiring manual teardown
on test exit, which may not always be possible in case of failure.

Instead, introduce a set of helper functions which allow devices
(internally a struct kunit_device) to be created and managed by KUnit --
i.e., they will be automatically unregistered on test exit. These
helpers can either use a user-provided struct device_driver, or have one
automatically created and managed by KUnit. In both cases, the device
lives on a new kunit_bus.

This is a follow-up to a previous proposal here:
https://lore.kernel.org/linux-kselftest/20230325043104.3761770-1-davidgow@google.com/

(The kunit_defer() function in the first patch there has since been
merged as the 'deferred actions' feature.)

My intention is to take this whole series in via the kselftest/kunit
branch, but I'm equally okay with splitting up the later patches which
use this to go via the various subsystem trees in case there are merge
conflicts.

Cheers,
-- David

Signed-off-by: David Gow <davidgow@google.com>
---
Changes in v4:
- Update tags, fix a missing Signed-off-by.
- Link to v3: https://lore.kernel.org/r/20231214-kunit_bus-v3-0-7e9a287d3048@google.com

Changes in v3:
- Port the DRM tests to these new helpers (Thanks, Maxime!)
- Include the lib/kunit/device-impl.h file, which was missing from the
  previous revision.
- Fix a use-after-free bug in kunit_device_driver_test, which resulted
  in memory corruption on some clang-built UML builds.
  - The 'test_state' is now allocated with kunit_kzalloc(), not on the
    stack, as the stack will be gone when cleanup occurs.
- Link to v2: https://lore.kernel.org/r/20231208-kunit_bus-v2-0-e95905d9b325@google.com

Changes in v2:
- Simplify device/driver/bus matching, removing the no-longer-required
  kunit_bus_match function. (Thanks, Greg)
- The return values are both more consistent (kunit_device_register now
  returns an explicit error pointer, rather than failing the test), and
  better documented.
- Add some basic documentation to the implementations as well as the
  headers. The documentation in the headers is still more complete, and
  is now properly compiled into the HTML documentation (under
  dev-tools/kunit/api/resources.html). (Thanks, Matti)
- Moved the internal-only kunit_bus_init() function to a private header,
  lib/kunit/device-impl.h to avoid polluting the public headers, and
  match other internal-only headers. (Thanks, Greg)
- Alphabetise KUnit includes in other test modules. (Thanks, Amadeusz.)
- Several code cleanups, particularly around error handling and
  allocation. (Thanks Greg, Maxime)
- Several const-correctness and casting improvements. (Thanks, Greg)
- Added a new test to verify KUnit cleanup triggers device cleanup.
  (Thanks, Maxime).
- Improved the user-specified device test to verify that probe/remove
  hooks are called correctly. (Thanks, Maxime).
- The overflow test no-longer needlessly calls
  kunit_device_unregister().
- Several other minor cleanups and documentation improvements, which
  hopefully make this a bit clearer and more robust.
- Link to v1: https://lore.kernel.org/r/20231205-kunit_bus-v1-0-635036d3bc13@google.com

---
David Gow (4):
      kunit: Add APIs for managing devices
      fortify: test: Use kunit_device
      overflow: Replace fake root_device with kunit_device
      ASoC: topology: Replace fake root_device with kunit_device in tests

Maxime Ripard (1):
      drm/tests: Switch to kunit devices

 Documentation/dev-tools/kunit/api/resource.rst |   9 ++
 Documentation/dev-tools/kunit/usage.rst        |  50 +++++++
 drivers/gpu/drm/tests/drm_kunit_helpers.c      |  66 +--------
 include/kunit/device.h                         |  80 +++++++++++
 lib/fortify_kunit.c                            |   5 +-
 lib/kunit/Makefile                             |   3 +-
 lib/kunit/device-impl.h                        |  17 +++
 lib/kunit/device.c                             | 181 +++++++++++++++++++++++++
 lib/kunit/kunit-test.c                         | 134 +++++++++++++++++-
 lib/kunit/test.c                               |   3 +
 lib/overflow_kunit.c                           |   5 +-
 sound/soc/soc-topology-test.c                  |  10 +-
 12 files changed, 485 insertions(+), 78 deletions(-)
---
base-commit: b285ba6f8cc1b2bfece0b4350fdb92c8780bc698
change-id: 20230718-kunit_bus-ab19c4ef48dc

Best regards,
-- 
David Gow <davidgow@google.com>


