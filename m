Return-Path: <linux-kselftest+bounces-43995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF143C07342
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31FE1505C1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D06433439F;
	Fri, 24 Oct 2025 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BxX1dtA7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB4332907
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322208; cv=none; b=CmxeKEB4O6wR2IKAPEbPortNtauKWzdnSEBijW6LYeD/XVD1lFHnLdRIJ5+1puxXzLNdyf/SM3KhjRva1FzAX2HqyYpc2EF76EQmZXEumlcU4qtmUjAf6qqoRrerxiuS39kzTbzLZ/zvyp73KRiyh3HBT4yxR8o0+XofHAqurfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322208; c=relaxed/simple;
	bh=bpC1+Q4zVsrUEyqVBB7GM2fblaZmMTywHN3GD0AZz1I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dbP+kJ1kNCz8yQSVnKBD63cbVeFFE1tjG9v1dkrNcIKyeeGL5HiLXp7J9vEWHFQf3gkSjmEQhgxVIaqvI4eeUlk/0ANy8mOUcDV91E24uH6cGZmeeHzJpImVV4jlWmRcGm4wasLJ4Kq5IByRukerJGo5hfW1scxguDMLKTPggfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BxX1dtA7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d71bcab6fso21501547b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322205; x=1761927005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5lJRZHIBr4l8hQ14h2r8Jc1C5VceV8EYA0FrZUk2otA=;
        b=BxX1dtA7XOzEIwKmdQ9OT0JL92I+ohSYeKqp8f/EUksLP3+IsxavLFCdE6iAY2NHVK
         sXQ6LLcE8slr7/yZufBFBIDG10EKKfWSBzl+DUVwFd5JXRKXr54nTSt28HhL/r8sSpQP
         huo8mn8YBveb21eYTKr54rURU7evbONlMmQo0QLENSU2aJY1gDNavluhhbXCaq2iqKzq
         scJ7CpyZ0go1snaJ51Q0OjsQGiwlC8sdifa0wzJ4QDUB7SJmNjY51d8D2Ny4BmygJ8Zz
         aquWFxUtyRLopBGsfy0TA0FElLtz2yX0i2arESx4zDHs+LghYen//8ItBkt8/QiYVL2l
         srQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322205; x=1761927005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lJRZHIBr4l8hQ14h2r8Jc1C5VceV8EYA0FrZUk2otA=;
        b=ocIMfT6RlZMJhqb7dGHCu3bz2zotRF7YK9SfH8aIvBUogYr2Duk2KIEUhUdprBnCX0
         c7psbFSDVHguzH4yAnrNeYkiSMHpmarpSp+Grq7bcLkBX24QjIOmsmL14NZ1Z2qWN9GF
         +zXZjbPYjPj/oECf8vShm/zBaLXA+pvqbXWqorKPn29IEiJ/oZ6XObYbCXvRyIyvEiV/
         PC6GuGoQ4Lnn3uSBQC0Xs0J7/LCTzws6gBh/xBC7qRR0phWEyo66DIYVA9jP7oZKibu4
         xXrAnKyYYeEPJ2v9mx/zApySSM2Rx1FGfjgaAX1zIHDlNaqKIQYDZXp625NpPX5eqP3h
         l1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW39jWmmocwZNocIybcKk0M6JUEEGQnYWKs37YnCtBMNet/ZqIq/rUn5CJhgVWHxZkXLabVwwBSdCN+YdexCp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7pmgTYwaAp0pI+IjdDgYMee9erqACW4179tWhJzxWsxU9qbu6
	zuWO8uh7vJ0SIrVx2Jt7AH+C/q+B6cC2AUJ2QbhYHdKxuQB/dYdoUXOMGVzsZ8qRYnI=
X-Gm-Gg: ASbGncuux1JKpt5BATco6bPEWENnpOPJntlnsaG3w5HjzzbEx4e/CzzFwcDTsuRjDgP
	8AWwvpKQB5FIqze4lz5jsg2I0NfshGm+VGXv1F/PXbQhzrs9EhqhWM5XfBI/FYGvKpn43xI07C0
	aPgYbMOZCZGAr+ZU/6dln9Goarj2/rHWgyOr2yc4bPxehOEiZ//U6Ey6XUQt9cqERvo6nZGEszm
	qKARMRrXG0oXEFD/WfYwtlsAEwacSXmSrOhd3TCC4j5Ft3arQcVAgle6w7aZQjFX6oI8gx9HWPr
	xpMdOXnq6Edmz+EEokfhXqp7IfAgGcLJpX0J1+9ok7M63GSa5wVvAWQkXEORo3Flnv/bYFLUteU
	HimWLk3t1ci0CCy0HbvMZS/vOizrBXGptJmUbfNjtUm+6zBqawN7M+qFdGgE5u5AGrBF48+8tFx
	LZ6xskIKlPSLoApSspzLIIg3TpW9iDI59/QrCtilLQTGO3gamTNGsNc5lzugV9fSKwUREOt/B6M
	ugP5V8NAciEiMrl14W55LzqfN33BnJ8Iw==
X-Google-Smtp-Source: AGHT+IFbczexsGZdw5sv2+pG+AP8WrRH85zQQI+6zaXO2pY5DBaHCIdJeZqqgPLE5H36FmMsaKUogg==
X-Received: by 2002:a05:690c:4c09:b0:780:be5b:3435 with SMTP id 00721157ae682-785e01f9ce3mr23044217b3.44.1761322203852;
        Fri, 24 Oct 2025 09:10:03 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6edd87sm14099197b3.51.2025.10.24.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:10:03 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org
Subject: [PATCH v8 0/8] liveupdate: Rework KHO for in-kernel users
Date: Fri, 24 Oct 2025 12:09:54 -0400
Message-ID: <20251024161002.747372-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v8:
Added review-bys and addressed comments from Mike Rapoport and
Pratyush Yadav.
Added "memblock: Unpreserve memory in case of error" to handle
rollback if preserve fails half way through.

This series refactors the KHO framework to better support in-kernel
users like the upcoming LUO. The current design, which relies on a
notifier chain and debugfs for control, is too restrictive for direct
programmatic use.

The core of this rework is the removal of the notifier chain in favor of
a direct registration API. This decouples clients from the shutdown-time
finalization sequence, allowing them to manage their preserved state
more flexibly and at any time.

In support of this new model, this series also:
 - Exports kho_finalize() and kho_abort() for programmatic control.
 - Makes the debugfs interface optional.
 - Introduces APIs to unpreserve memory and fixes a bug in the abort
   path where client state was being incorrectly discarded. Note that
   this is an interim step, as a more comprehensive fix is planned as
   part of the stateless KHO work [1].
 - Moves all KHO code into a new kernel/liveupdate/ directory to
   consolidate live update components.

[1] https://lore.kernel.org/all/20251020100306.2709352-1-jasonmiu@google.com

Mike Rapoport (Microsoft) (1):
  kho: drop notifiers

Pasha Tatashin (7):
  kho: allow to drive kho from within kernel
  kho: make debugfs interface optional
  kho: add interfaces to unpreserve folios and page ranges
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  liveupdate: kho: move kho debugfs directory to liveupdate
  memblock: Unpreserve memory in case of error

 Documentation/core-api/kho/concepts.rst       |   2 +-
 MAINTAINERS                                   |   3 +-
 include/linux/kexec_handover.h                |  53 +-
 init/Kconfig                                  |   2 +
 kernel/Kconfig.kexec                          |  24 -
 kernel/Makefile                               |   3 +-
 kernel/kexec_handover_internal.h              |  16 -
 kernel/liveupdate/Kconfig                     |  39 ++
 kernel/liveupdate/Makefile                    |   5 +
 kernel/{ => liveupdate}/kexec_handover.c      | 508 +++++++-----------
 .../{ => liveupdate}/kexec_handover_debug.c   |   0
 kernel/liveupdate/kexec_handover_debugfs.c    | 219 ++++++++
 kernel/liveupdate/kexec_handover_internal.h   |  56 ++
 lib/test_kho.c                                |  33 +-
 mm/memblock.c                                 |  82 ++-
 tools/testing/selftests/kho/init.c            |   2 +-
 tools/testing/selftests/kho/vmtest.sh         |   1 +
 17 files changed, 590 insertions(+), 458 deletions(-)
 delete mode 100644 kernel/kexec_handover_internal.h
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (80%)
 rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
 create mode 100644 kernel/liveupdate/kexec_handover_debugfs.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h


base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
-- 
2.51.1.821.gb6fe4d2222-goog


