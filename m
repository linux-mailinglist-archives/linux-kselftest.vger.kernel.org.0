Return-Path: <linux-kselftest+bounces-36235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDAAF07B2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD5417F3AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 01:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7315B1369B4;
	Wed,  2 Jul 2025 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STQ65RKJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45472624
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418295; cv=none; b=QVgDoA5G56hALe/iToni61BdIrpRsnGxt/j9Z9nZliCRc1ULBSp2bY3ZYd3PZ2q42HiiG/Hcezl4En+KcHL3iSQJUdOqOBgTm20wKu9ajR+0KE4ZSBmHfxjMzO1us6kVVuu5XxW0pfpxZRqsJpSj+rVoHkVAreCUVK3XcdmABBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418295; c=relaxed/simple;
	bh=mkoinqK8VSa4bSxXL8+6TQQpGHjznYbUGTdepBjTk58=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jMw0ZDJBC95Qa2H+Ef05T39GYigk2aZMDVdFOMgi5pCn3cTMd0LSpz81+2wCHtOeJyIjIALgCKAyyfS584BQh8wky0dugBteg2fLzCInw/TEfN/QbjdvzxQL1MGE/2IlDKqAm/z80WkUkAXG/X1c+zBmP4mb+fXUDzeslEkzoco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STQ65RKJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso4000775a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751418293; x=1752023093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k6+7FGVXnmiRH7+roF8mwKR5/30REpmZHbgcAOWa//U=;
        b=STQ65RKJV+S33Zqa812FHDdwqq04rkBovHElIB4km9suluS2AXxxp3LiQn7mbXn7/h
         rdD/GXYidfR8abM4tzA9kP08JxMmpZGX7vBKxoOXzjJ3hIkRKIr2xYU054I0T4xt9lVU
         ZMgYKOwTJhiVGi7g1UZ5heRYugUvzph/S5Yv/FePaCXmxtwykKsXIFxoje9NtnyJKyj1
         tbIVtMqVcDuoHkaBXtaRrMTPmXlfrybRd/j43EkXvMErRLbYpWL5VRGTnTfbW1yzOR7m
         4V/P26mYI88kJxzhu2zwRhIHooifL2pGOsO8QC/fkd6c/MePe492ybU0NEgEp0/rD4Uv
         7rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418293; x=1752023093;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6+7FGVXnmiRH7+roF8mwKR5/30REpmZHbgcAOWa//U=;
        b=oIEudu/6iDFVO5nUOKHkfQ75CNJ5emd7QEfRhW8KxqOfwBqisLtsfO1kvTmwGtdoDj
         EXqofAryDEvGia79ZCaDEMU2ZjrVso3BuEgE0V1t+fm8OToLPTVwVPJa03ej0FhQnznE
         0Q03XcWIbHpfIkEkT2YRRyWBIo1mKg+k9YPSwoU9Q9O3QfhAcmY1tdFOyGYSwik+OZtC
         2A89bwVY3AW+nA1lsq+s2oDmw3wW0UYX6sS2T5vIYDg4X2yVbAwViEEQeRl+IbRidNHC
         dWtK5OaSKzl9tE0+ogJgamKwronbkehbceey+Snq9jrqvHaojcBmibeNmUxvY6MsOnKc
         EMWA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Nc4MgtIbAHExsS9IwmHF9LuJRz2tZyYuHffmLJl2E4q+XJd7TFlbzX6O7boAJRja5kVZu3eDAso2XCfgzUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EgnsXNRLaVujARhkOASl8hz5N2VBINugrdF2v8QgybTgQ0d/
	w3zurztdPxLZF34852hkMGnLDcfUA3xbhFJ43m6fFNpvo+OKp72mJ+P3SnG20dRG4AYtCPxDjcF
	Gll8KPl3Kjw==
X-Google-Smtp-Source: AGHT+IGSGIt25XHkyQSkOAt8ewfiP6oL/YpHwTZsSxQcaWeClZrLFXIh5cq0roz0N+PKZICZZiHaVwqL3JnC
X-Received: from pjbkl12.prod.google.com ([2002:a17:90b:498c:b0:311:c5d3:c7d0])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3889:b0:312:f0d0:bc4
 with SMTP id 98e67ed59e1d1-31a90b1c47emr1365291a91.5.1751418293134; Tue, 01
 Jul 2025 18:04:53 -0700 (PDT)
Date: Tue,  1 Jul 2025 18:04:40 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702010447.2994412-1-ynaffit@google.com>
Subject: [PATCH v2 0/5] binder: Set up KUnit tests for alloc
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

Tiffany Yang (5):
  binder: Fix selftest page indexing
  binder: Store lru freelist in binder_alloc
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
 drivers/android/tests/.kunitconfig         |   3 +
 drivers/android/tests/Makefile             |   3 +
 drivers/android/tests/binder_alloc_kunit.c | 573 +++++++++++++++++++++
 include/kunit/test.h                       |  12 +
 lib/kunit/user_alloc.c                     |   4 +-
 12 files changed, 645 insertions(+), 340 deletions(-)
 delete mode 100644 drivers/android/binder_alloc_selftest.c
 create mode 100644 drivers/android/tests/.kunitconfig
 create mode 100644 drivers/android/tests/Makefile
 create mode 100644 drivers/android/tests/binder_alloc_kunit.c

-- 
2.50.0.727.gbf7dc18ff4-goog


