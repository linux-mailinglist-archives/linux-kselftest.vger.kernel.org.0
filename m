Return-Path: <linux-kselftest+bounces-1898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9D3812AAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 09:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7871C214D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36E72420B;
	Thu, 14 Dec 2023 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNjUUwEG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98928109
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:49:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daee86e2d70so8648608276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 00:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702543775; x=1703148575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SgmhxNS+9L5tI+v3DA2/WrvsfKfXTZ7phO9Gx1cypHI=;
        b=pNjUUwEGPGZrJFYZJfm6lTra3kUxpFUp3UCgGf96/Ai8iYb3MoGrxOXYdNoi0FmIMC
         X5X1z9p08J6jtheDOckyaWi7ssAUFxoQagCIW3pfhkUnkIA/PMhU/5jGr61k46/mjrWD
         bWs8oLZb3hYd7Rj4+Po7kNqX9RdGEPiEhWdt0AnTfhGYczOcA834yrnwD7Aq9NbGZI2t
         IN1p2krbHUjkV5qgEUic5iyAp5+/Yk6/TFWJpf50wJc2eRUO/i/Asvk+ehiEvQflCUed
         9mt6r4fT95MQvDz/rT8+2U8dzCmP82g+BZK6bGfNpCjGW84OpFqDifx41oPelmcxD9ZN
         NFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543775; x=1703148575;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgmhxNS+9L5tI+v3DA2/WrvsfKfXTZ7phO9Gx1cypHI=;
        b=XQJoKGJLIO0HdM60B68pzxMxMUMyiu0uvnQcc1rklDpg58L0E17lPKY6/BtOTxVQ+q
         lGRtxuexsMrJH2ri5s5yJcdougB7vEmmvo2NI7SBoXHaJ+ZVldKGqtleGjkg1toyE4dL
         YybDwD9N3Pvp1Ix9RhA4ccUhEdyAL1jpbOJ/R2kx3qdeQN+GTudoHUBsGRiU2M7nz92k
         n2oOdEKra9QBP8a70AyuIxdy6jjpVlYFEPgwKeLxFA19q20jQAHTdNB+kaxpXhTd18LS
         CGh4ZA+mLzs6VK5yZGJ+iLxrHN3vUr2E9ayTxwN3Fl6Fi2G7sbu42jslwBwfutS6wZbB
         ADyw==
X-Gm-Message-State: AOJu0YzgzcF1BfiEBL/nIyh/O13NvP1S16s/7c2yLGBqDQb5bncAEsx+
	q/am5RtYV44zDdsQ+BaXumetYJu2r4iP3w==
X-Google-Smtp-Source: AGHT+IHRwuLHo03IWI8xcYZK5aef+eOfAHhAVl0nDvAtLGtvSezhbw4GIajgAWGs+h9hV7UVtikAn+oKw0dyOQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:2454:0:b0:dbc:cab1:a86 with SMTP id
 k81-20020a252454000000b00dbccab10a86mr41153ybk.0.1702543774823; Thu, 14 Dec
 2023 00:49:34 -0800 (PST)
Date: Thu, 14 Dec 2023 16:49:14 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIrBemUC/1WOzQ6CMBAGX4Xs2Zr+UKSefA9jDG0XaFRqWmg0h
 He3cMLjfNmZ7AwRg8MI52KGgMlF54cM4lCA6ZuhQ+JsZuCUC3piNXlMgxvveoqk0UyZEtuytgb
 y/Ttg6z5b63rL3Ls4+vDd0omt61ZhnMpdJTFCSSUkFZUV2jBx6bzvnng0/gVrJvG9un8g8ayik opKq7Tg8k9dluUHC4B+Ot4AAAA=
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231214-kunit_bus-v3-0-7e9a287d3048@google.com>
Subject: [PATCH v3 0/5] kunit: Add helpers for creating test-managed devices
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


