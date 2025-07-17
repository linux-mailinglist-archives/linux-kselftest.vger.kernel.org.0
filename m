Return-Path: <linux-kselftest+bounces-37458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AC4B08216
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 03:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A1A1621F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 01:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160E1A3177;
	Thu, 17 Jul 2025 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecDF4xZt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C82E371A
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Jul 2025 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714618; cv=none; b=OBdLwANNFnifOgrvmS3T5KPUUBWY4ASFv9YRly8WRd8GxB9T7C2DK3bkNUVJEoWFU9YTdL8q/EEuqKkAuzsFTPqiLdPR9Xnpv72Rq7CSoQP+jyNK5mNKIgLwGJSynv6lY3yXJlLgzQ8SeNMAV0dLAb2iAAJEnlfl0IpIIqSBeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714618; c=relaxed/simple;
	bh=ozo5eYb3YU7H8t4et3HK2fH+WMpaGapOeIfG0NbD4mg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rwNNV9W8RMijlVwIH0LG6hJ6Su45CsWARNj5qyBHNVKNGevbpkIMM6vOe+k8jV6sdOMX8io1Gozw0rEHJdK1mB1ZHvsf+vx9wB2tDKw2vj4pgNhbb7kr0pgYqC/Cco0889qLNx3/a0FUE2l3fwlN4/Yz9z6O085QlxH+C4Pjj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecDF4xZt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-740774348f6so440588b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752714616; x=1753319416; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gUTYXc26UxSuX2Bn6XGfKAUwzEOqqIS18eTa4THYyYg=;
        b=ecDF4xZtDqdG90mojbtbab+5UtKve9GUiJvRhe8WHA1IB3iH7qvDLzXNStYAq4KKOX
         IBMahwmM8VBwG4ZJfn27HxFyWUBvHXfPVkz/uP3KStCvhRXN1hd//H0QPsq6eMrEy5xW
         yHojqdtV/W9iF/5dsXN193tMao64UXj7VT2VUe/4CF4xtIEb8q9qjQ8Z1X2QaP7LZG05
         H7m124tWLfngCyEWKQXtDXHZ7Qgu50bfrLh7WaToDoNTOPBwsbJQiLeFR/VaxFQKlj3m
         kohVXyRpNp+jLByr1WQCRuD1/YdEfzMX1neHrEayitO1SR31GGnjnpFcmBOG3YbPWlcR
         FyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714616; x=1753319416;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gUTYXc26UxSuX2Bn6XGfKAUwzEOqqIS18eTa4THYyYg=;
        b=uZ2bI436DWd/JqbEe7Jqr4zz1qah/rshj+6QkPb55N1ZuM5S0ujNgaln1jKQ1IUUou
         /KA+ePBzXUoarH7xotdJO3G1yKhoY6fkGCkJqsJIrYqBVQXga5zYZtJrWmsU08MhujTf
         Evq0Mx0rs1CFXnFXED9Oz2Vx8Goby2l6saZxWJrgaSVBcq7MWsNbw0qsyRchp0dYtv4E
         jSFmW7TmlwadYV0kzu1VYVa1tscSWfTb6CoYszc8WJh6hZhsG5tvtj9ySXEbnTnJfvhW
         /8ZtggnTLeJFvU2MVgL+xo/wViDPmjEEyCPU3X9zB8o8eVFqwnw1QEdJK/vswy7KcEWP
         DVUg==
X-Forwarded-Encrypted: i=1; AJvYcCXeXR/Pm2RKcp9lWPx4LREH994cDUgkC5bT8hyeNsnagwPdYz0E2sq70ts1m15rNN3ZwEL/zv3Ll1375YR67us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLc+CGjWsFx9gFrGyHB3HG3sTq/nANZuw51bZ+Y01Tz8eNmkZ0
	PHJ/lyGy0FRAkT1UlJQ5Cpc9woBrZDO1gBvebX3UxXjRx4uAT47PySF7UG9lgjeIEc+5HfcaMID
	vUDEenUomTA==
X-Google-Smtp-Source: AGHT+IGO7wjMp0KfaKbLnIeQlDuZ8P0WlskU3pVAlzlM1+n4aG1Rf4SRiFBiSCRMYb8Wu1BLYQy3iuX62Gwc
X-Received: from pfoo3.prod.google.com ([2002:a05:6a00:1a03:b0:748:8e9:968e])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a14:b0:749:421:efcc
 with SMTP id d2e1a72fcca58-756e7faa901mr6472941b3a.5.1752714615759; Wed, 16
 Jul 2025 18:10:15 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:10:03 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717011011.3365074-1-ynaffit@google.com>
Subject: [PATCH v4 0/6] binder: Set up KUnit tests for alloc
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

binder_alloc_selftest provides a robust set of checks for the binder
allocator, but it rarely runs because it must hook into a running binder
process and block all other binder threads until it completes. The test
itself is a good candidate for conversion to KUnit, and it can be
further isolated from user processes by using a test-specific lru
freelist instead of the global one. This series converts the selftest
to KUnit to make it less burdensome to run and to set up a foundation
for unit testing future binder_alloc changes.

Thanks,
Tiffany

Tiffany Yang (6):
  binder: Fix selftest page indexing
  binder: Store lru freelist in binder_alloc
  kunit: test: Export kunit_attach_mm()
  binder: Scaffolding for binder_alloc KUnit tests
  binder: Convert binder_alloc selftests to KUnit
  binder: encapsulate individual alloc test cases

 drivers/android/Kconfig                    |  15 +-
 drivers/android/Makefile                   |   2 +-
 drivers/android/binder.c                   |  10 +-
 drivers/android/binder_alloc.c             |  39 +-
 drivers/android/binder_alloc.h             |  14 +-
 drivers/android/binder_alloc_selftest.c    | 306 -----------
 drivers/android/binder_internal.h          |   4 +
 drivers/android/tests/.kunitconfig         |   7 +
 drivers/android/tests/Makefile             |   6 +
 drivers/android/tests/binder_alloc_kunit.c | 572 +++++++++++++++++++++
 include/kunit/test.h                       |  12 +
 lib/kunit/user_alloc.c                     |   4 +-
 12 files changed, 651 insertions(+), 340 deletions(-)
 delete mode 100644 drivers/android/binder_alloc_selftest.c
 create mode 100644 drivers/android/tests/.kunitconfig
 create mode 100644 drivers/android/tests/Makefile
 create mode 100644 drivers/android/tests/binder_alloc_kunit.c

-- 
2.50.0.727.gbf7dc18ff4-goog


