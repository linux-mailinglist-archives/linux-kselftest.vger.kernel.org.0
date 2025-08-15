Return-Path: <linux-kselftest+bounces-39092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711C3B27E53
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 12:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2319FAA0DBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E082D73AE;
	Fri, 15 Aug 2025 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYAiQz4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCF259C9A
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254171; cv=none; b=heUPmzY0XXwSZD0RlV/TLDgWZET4gvC/lzYYlHsLb9WVVsM0gu1uGBDM0SWrT1+KLJI4KnU2coG0eHl1g/IfaGQ0G50HIGqNqCZreHNlDUyzZXyYMDE5V2iqI6nK7JcgHH3F+I/L1xJE0GgEcCjcEh2jgkHpGlPnGSuZ4voj6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254171; c=relaxed/simple;
	bh=byvwE3TiFZNjUcWQkr01VHegzmfVvfQRpa8VJPuEbMg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sp6As3FO2bo/B/89PZo2iMW3sI/7Uh/6UHDxLGcFMuN9lv5YZR64WVCiLkFX8khwr6xk39Y60EMrLqOdTET6s/usKhg2G15E5yhTV1lIVlRt0QFvOuLziuuevMzE34QIXMEwYGUkDV+GIULDzb4kT8ILvCJCJi0n+owj3WPBwU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYAiQz4Y; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e870676ac0so442141185a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 03:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755254168; x=1755858968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eFpXxq44oeslvizqCF8Bv0M0ZVaQrSB155EOLBMECVQ=;
        b=bYAiQz4Y6C9yXc7zHn9HOg5CNjPJrKqu6tQ3M6JazK795hSacPC2li+itBnjuBfFd8
         FjZKQfzu3a35EDQCdrJgVkwqC7kUA4qd8GkebiUhTlJDkBQv0udeu+IwGKBJwLkH0YDY
         uNrKDgH+bZKL0booGNZOS384/qUeisyrCkGTjb9vYrUbhzJurOo+tX0Cu8v/cJHmjbaB
         CDy0T5J/2ZbZ2MRo171ekpvh+nhanUuziZOPuKBwHJG8ENXPYFiZe+BSGdwXlikIDw17
         Yq4rh1Q2c5fjKREZAErI5+hFvcG/vBHstXIewVnHORZwCnsPNaX+gPelBA5/QHDqsFMO
         4SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755254168; x=1755858968;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFpXxq44oeslvizqCF8Bv0M0ZVaQrSB155EOLBMECVQ=;
        b=M8OqFREccRixPv7/3SFYShGuZ15yyyZ7O52Oyd2tGZ2U9lNtNS5SAQc00+HKDrvNoX
         /syfq7gnaC90BUZCzR2mCO9IRKPhNzA5lYtPbanyxzv+lM/oCd1PL+9jScOo6xiwBqId
         7XoVVR+BIocNagpgvi9ExBUQRPYnmooReIHRxwVXV5vN0+KMdl3EfBXrAS8jBJ+7nis+
         P5EApUpzVS0fpcrnNIFynCtNKH7mW1BfYiZl5zcy3uzZPQNSem6DDv9JhRhiMdoSsyy3
         3sdGq+auObuOQUJcuPq7vlWMBUIvs23d1rkzMdGAOS17H1EPBWFn+oc12yQAF1758ImK
         Zy9g==
X-Forwarded-Encrypted: i=1; AJvYcCUAxZbz943WUTDKQoiFJzQfGuI2E/OKZ58NvBY0nOOYxQTJGNcn8dgwlz2XMNUikrJKBiK5pQ/zCsobJDQHTng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhPd8Ua2rvSjOkm/6EFWOUM4X28BDpCPTfPOrK7K9YrYZGvaS
	s2yEg89FWzh/uFdG/307kgHZjDcrQWuV3DFv51CWs8bSZ4Z+irqqQny5zh9ip6zyc4MhJoX36+c
	3QxerpBAaGIf39Q==
X-Google-Smtp-Source: AGHT+IGqwcNa0muVNYMhfJnNR56U34U3LHWpaKq2hOoZwkS5Io63dT+8xTEkaJe22M4TB6v424ec54WU5OMILA==
X-Received: from qkpg1.prod.google.com ([2002:a05:620a:2781:b0:7e8:14fd:d2c9])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a17:b0:7e1:9c2d:a862 with SMTP id af79cd13be357-7e87e06b8dbmr185880085a.39.1755254168517;
 Fri, 15 Aug 2025 03:36:08 -0700 (PDT)
Date: Fri, 15 Aug 2025 10:35:57 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250815103604.3857930-1-marievic@google.com>
Subject: [PATCH v3 0/7] kunit: Refactor and extend KUnit's parameterized
 testing framework
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: mark.rutland@arm.com, elver@google.com, dvyukov@google.com, 
	lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello!

KUnit offers a parameterized testing framework, where tests can be
run multiple times with different inputs. However, the current
implementation uses the same `struct kunit` for each parameter run.
After each run, the test context gets cleaned up, which creates
the following limitations:

a. There is no way to store resources that are accessible across
   the individual parameter runs.
b. It's not possible to pass additional context, besides the previous
   parameter (and potentially anything else that is stored in the current
   test context), to the parameter generator function.
c. Test users are restricted to using pre-defined static arrays
   of parameter objects or generate_params() to define their
   parameters. There is no flexibility to make a custom dynamic
   array without using generate_params(), which can be complex if
   generating the next parameter depends on more than just the single
   previous parameter.

This patch series resolves these limitations by:

1. [P 1] Giving each parameterized run its own `struct kunit`. It will
   remove the need to manage state, such as resetting the `test->priv`
   field or the `test->status_comment` after every parameter run.

2. [P 1] Introducing parameterized test context available to all
   parameter runs through the parent pointer of type `struct kunit`.
   This context won't be used to execute any test logic, but will
   instead be used for storing shared resources. Each parameter run
   context will have a reference to that parent instance and thus,
   have access to those resources.

3. [P 2] Introducing param_init() and param_exit() functions that can
   initialize and exit the parameterized test context. They will run once
   before and after the parameterized test. param_init() can be used to add
   resources to share between parameter runs, pass parameter arrays, and
   any other setup logic. While param_exit() can be used to clean up
   resources that were not managed by the parameterized test, and
   any other teardown logic.

4. [P 3] Passing the parameterized test context as an additional argument
   to generate_params(). This provides generate_params() with more context,
   making parameter generation much more flexible. The generate_params()
   implementations in the KCSAN and drm/xe tests have been adapted to match
   the new function pointer signature.

5. [P 4] Introducing a `params_array` field in `struct kunit`. This will
   allow the parameterized test context to have direct storage of the
   parameter array, enabling features like using dynamic parameter arrays
   or using context beyond just the previous parameter. This will also
   enable outputting the KTAP test plan for a parameterized test when the
   parameter count is available.

Patches 5 and 6 add examples tests to lib/kunit/kunit-example-test.c to
showcase the new features and patch 7 updates the KUnit documentation
to reflect all the framework changes.

Thank you!
-Marie

---

Changes in v3:

Link to v2 of this patch series:
https://lore.kernel.org/all/20250811221739.2694336-1-marievic@google.com/

- Added logic for skipping the parameter runs and updating the test statistics
  when parameterized test initialization fails.
- Minor changes to the documentation.
- Commit message formatting.

Changes in v2:

Link to v1 of this patch series:
https://lore.kernel.org/all/20250729193647.3410634-1-marievic@google.com/

- Establish parameterized testing terminology:
   - "parameterized test" will refer to the group of all runs of a single test
     function with different parameters.
   - "parameter run" will refer to the execution of the test case function with
     a single parameter.
   - "parameterized test context" is the `struct kunit` that holds the context
     for the entire parameterized test.
   - "parameter run context" is the `struct kunit` that holds the context of the
     individual parameter run.
   - A test is defined to be a parameterized tests if it was registered with a
     generator function.
- Make comment edits to reflect the established terminology.
- Require users to manually pass kunit_array_gen_params() to
  KUNIT_CASE_PARAM_WITH_INIT() as the generator function, unless they want to
  provide their own generator function, if the parameter array was registered
  in param_init(). This is to be consistent with the definition of a
  parameterized test, i.e. generate_params() is never NULL if it's
  a parameterized test.
- Change name of kunit_get_next_param_and_desc() to
  kunit_array_gen_params().
- Other minor function name changes such as removing the "__" prefix in front
  of internal functions.
- Change signature of get_description() in `struct params_array` to accept
  the parameterized test context, as well.
- Output the KTAP test plan for a parameterized test when the parameter count
  is available.
- Cover letter was made more concise.
- Edits to the example tests.
- Fix bug of parameterized test init/exit logic being done outside of the
  parameterized test check.
- Fix bugs identified by the kernel test robot.

---

Marie Zhussupova (7):
  kunit: Add parent kunit for parameterized test context
  kunit: Introduce param_init/exit for parameterized test context
    management
  kunit: Pass parameterized test context to generate_params()
  kunit: Enable direct registration of parameter arrays to a KUnit test
  kunit: Add example parameterized test with shared resource management
    using the Resource API
  kunit: Add example parameterized test with direct dynamic parameter
    array setup
  Documentation: kunit: Document new parameterized test features

 Documentation/dev-tools/kunit/usage.rst | 342 +++++++++++++++++++++++-
 drivers/gpu/drm/xe/tests/xe_pci.c       |   2 +-
 include/kunit/test.h                    |  95 ++++++-
 kernel/kcsan/kcsan_test.c               |   2 +-
 lib/kunit/kunit-example-test.c          | 217 +++++++++++++++
 lib/kunit/test.c                        |  94 +++++--
 rust/kernel/kunit.rs                    |   4 +
 7 files changed, 728 insertions(+), 28 deletions(-)

-- 
2.51.0.rc1.167.g924127e9c0-goog


