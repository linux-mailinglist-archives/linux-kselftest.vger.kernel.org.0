Return-Path: <linux-kselftest+bounces-38053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9F9B15387
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 21:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552EB189C0B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C2C23B610;
	Tue, 29 Jul 2025 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TwXzGbcv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254B23F405
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817835; cv=none; b=PBxQ9t+v5qiPI11l6xcJs4Q4kgnlns5H8bX0lvrCDYEo0fBj1Ryjn6tctolaW0k3fG6zt9rM2xknWtDm74EFESzgsvtdNuh0sqtsG8Y2GS/SmKWq46G/fFS28O8jlI+rLS9PMxjhnRgWNT5mH3ABTYwOf48idVotNMWF9i7F67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817835; c=relaxed/simple;
	bh=KPwEzcGU4uNGF/h53KOqJ0tthPOjgGljSwmDo4IsG9Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DHSWGy2G0YOj9AS8iQKP0zSYGRn9Nmh25xafUtO8J0Olvg0QO0a67wY5nmRBIcR8/107k6n4MC8EWIwYi8jhvmD5DHMAESSO5s5WzwqOrD4CX6GQd561kcFeJ4WGgc/FsqWTOpArf75gA6whqD7/Ora2Nfut0dO3S1qLjNntq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TwXzGbcv; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e2e8a90a90so976405885a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817833; x=1754422633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iY//lVxLTeQ/wpFhoCwsWTSD0JOlrDoBeeghyQ/Upjs=;
        b=TwXzGbcvGppzlHuDvlDA/z90hW0n2CgYUMTEQRDrQUE5isX3N17ty1U6z6/AOFLNLg
         9gJ+PL+Ynvq2NS4UMjzYvzTlnD9Qm4Nx2QK1TOVvP+C5WfxNU6c+6uaTzfsKBXIWc/kI
         5xUdRKTBA/DGMwneHA3vYxMLmzZqwvfFYNFFDKhGs5JM97lwRy85rDyGIliKXfc5QPl3
         HdbPCRVqOnBtqT+4XBdTCcB1hQ9+ti8hqq0sZ84yxUPoBc6JxEVIWt64qI0zqFlYV0YW
         a6KPBTMyLzTbPQf78N+TzTjPkrXDlx96knzNJs+g+w0AWlRzzXuHfcuYgQXrQlfyLThZ
         bzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817833; x=1754422633;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iY//lVxLTeQ/wpFhoCwsWTSD0JOlrDoBeeghyQ/Upjs=;
        b=AYMiHJcO6Jzdyd+uG80Lr7SpkgbZl9EOsxhhhL0+vjU4gCqEpMNeR2W4M3STcSXJjP
         dQ2E7UCv3VDprFkP1KKoKrIuSmosqCW5OulKCiPLgrwqmvMAKL/CL36sGxhmZnowxjzQ
         NHjAVrd+S92aPgoSN8DIGZpCJ5k0GKptKxERoDwqs9byuPmlqlyr2C5FmKAvijKRPKs3
         gP9mCXwXXEnCuljqtlFepTIXB2Gckrt3fifJIRo5COsfIEbu615BqRB/gQPYAlOBXllE
         TDM8DZmLWSYuIxD5Yjj82i+3rWadQDfFx4PGwYKxktzqJPVMFYTW62hfysbFOZ+n+px/
         hu6A==
X-Forwarded-Encrypted: i=1; AJvYcCVqv2p6zjR7lhvy8y/Wqp1/d6H5yT3HzCdZHQidMX/k71GogfymG4dOjXw+012GhlrLGXcoGOeW15GwKxw/XQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7oW6YZr5SiTaKsUEzoOLQYW+b9ABvQ69g/21k/N+xzefi1iFY
	LK7u/ZxHQAQxa7DpazgQc9j3L6cRZkZSShEiyWKRlzrLNL9OvsrumH6C3/l226uIernRsnapVom
	pHKWxMPmI8J2pOg==
X-Google-Smtp-Source: AGHT+IGn2AxD4SAxB/kWHZWeagJBNiPsMMNzOwk1sETIYxGHKzcBJDio12VD/zBRlWE/2YAZFEUedLapEWbiNA==
X-Received: from qtbfc18.prod.google.com ([2002:a05:622a:4892:b0:4ab:b55c:cea3])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a10d:b0:7d4:4aa6:a509 with SMTP id af79cd13be357-7e66f39138amr112976185a.48.1753817833109;
 Tue, 29 Jul 2025 12:37:13 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:36:38 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193647.3410634-1-marievic@google.com>
Subject: [PATCH 0/9] kunit: Refactor and extend KUnit's
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello!

KUnit offers a parameterized testing framework, where tests can be
run multiple times with different inputs.

Currently, the same `struct kunit` is used for each parameter
execution. After each run, the test instance gets cleaned up.
This creates the following limitations:

a. There is no way to store resources that are accessible across
   the individual parameter test executions.
b. It's not possible to pass additional context besides the
   previous parameter to `generate_params()` to get the next
   parameter.
c. Test users are restricted to using pre-defined static arrays
   of parameter objects or `generate_params()` to define their
   parameters. There is no flexibility to pass a custom dynamic
   array without using `generate_params()`, which can be complex
   if generating the next parameter depends on more than just
   the single previous parameter (e.g., two or more previous
   parameters).

This patch series resolves these limitations by:

1. [P 1] Giving each parameterized test execution its own
   `struct kunit`. This aligns more with the definition of a
   `struct kunit` as a running instance of a test. It will also
   remove the need to manage state, such as resetting the
   `test->priv` field or the `test->status_comment` after every
   parameter run.

2. [P 1] Introducing a parent pointer of type `struct kunit`.
   Behind the scenes, a parent instance for the parameterized
   tests will be created. It won't be used to execute any test
   logic, but will instead be used as a context for shared
   resources. Each individual running instance of a test will
   now have a reference to that parent instance and thus, have
   access to those resources.

3. [P 2] Introducing `param_init()` and `param_exit()` functions
   that can set up and clean up the parent instance of the
   parameterized tests. They will run once before and after the
   parameterized series and provide a way for the user to
   access the parent instance to add the parameter array or any
   other resources to it, including custom ones to the
   `test->parent->priv` field or to `test->parent->resources`
   via the Resource API (link below).

https://elixir.bootlin.com/linux/v6.16-rc7/source/include/kunit/resource.h

4. [P 3, 4 & 5] Passing the parent `struct kunit` as an additional
   parameter to `generate_params()`. This provides
   `generate_params()` with more available context, making
   parameter generation much more flexible. The
   `generate_params()` implementations in the KCSAN and drm/xe
   tests have been adapted to match the new function pointer
   signature.

5. [P 6] Introducing a `params_data` field in `struct kunit`.
   This will allow the parent instance of a test to have direct
   storage of the parameter array, enabling features like using
   dynamic parameter arrays or using context beyond just the
   previous parameter.

Thank you!
-Marie

Marie Zhussupova (9):
  kunit: Add parent kunit for parameterized test context
  kunit: Introduce param_init/exit for parameterized test shared context
    management
  kunit: Pass additional context to generate_params for parameterized
    testing
  kcsan: test: Update parameter generator to new signature
  drm/xe: Update parameter generator to new signature
  kunit: Enable direct registration of parameter arrays to a KUnit test
  kunit: Add example parameterized test with shared resources and direct
    static parameter array setup
  kunit: Add example parameterized test with direct dynamic parameter
    array setup
  Documentation: kunit: Document new parameterized test features

 Documentation/dev-tools/kunit/usage.rst | 455 +++++++++++++++++++++++-
 drivers/gpu/drm/xe/tests/xe_pci.c       |   2 +-
 include/kunit/test.h                    |  98 ++++-
 kernel/kcsan/kcsan_test.c               |   2 +-
 lib/kunit/kunit-example-test.c          | 207 +++++++++++
 lib/kunit/test.c                        |  82 ++++-
 6 files changed, 818 insertions(+), 28 deletions(-)

-- 
2.50.1.552.g942d659e1b-goog


