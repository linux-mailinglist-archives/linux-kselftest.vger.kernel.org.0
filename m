Return-Path: <linux-kselftest+bounces-10652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF688CDFDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 05:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815071C22233
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21ED2E3EB;
	Fri, 24 May 2024 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/W/eTrJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38933BA42
	for <linux-kselftest@vger.kernel.org>; Fri, 24 May 2024 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521984; cv=none; b=MmN3c5I1lLtKqQ8k6nibmg23YT8vYiiFyygWHZUiETT45LS90Umor695tKhaSiSheP4qbL21L83rI+UERy3CuY/ueERXXbf+gr5omg/e7xrB5hk86bsHAZ8CL6o908NWEE4KYrNZksYQ8napYlnxdt2Jn7V1tb1zAYQaz34pGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521984; c=relaxed/simple;
	bh=P8hmXNe9pVfxehRdEFph7gYxFMRHhtBZuM9VKZou2o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GkEd2prHRYQZ0ROn3K1RwRledpaSEMQmjo7njlI4keX/cNgztEnZV4TPQAS2gaf18pbk/0aZgegwOSHiLKJHedETbkYVhCBeHCHK70oLLgKMd+TOPwHtCx8RjDZxt7j62toXGgGoe2Cu6IMm9PX91jSkS651aT8vJ8SuL22+Fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U/W/eTrJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-681adefa33fso325977a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 20:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716521982; x=1717126782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZM+C443YkAbqJrVfa7/d/V0qYnAraDfxHHb3nzF0+w=;
        b=U/W/eTrJ7Ed6VUBIzN5zPDPOZz6RZvoLRrQHLJ03VSYFLfEHQx5dLddic6gvUSSoWY
         VjwDP9OfGDToWqcKtf4LBNKI+M/8amM/Jc93Boy/q6Wf0vSbmMtiU20bIlxVL+5f210F
         vxVlEnzN5YKJF+RNmPPoiRmYd7z7psp2e6Sag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521982; x=1717126782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZM+C443YkAbqJrVfa7/d/V0qYnAraDfxHHb3nzF0+w=;
        b=i9fDluoCacnN8qOYVZkcuBEPpaiWAX7yLdg7NuInkf2VW6d1vI4qeGk4mJWqALyxGP
         Rd+AVs2PODvEA2/gl7MIH3Q0Wo5rExMa9ohKignrNp27KSGV1z8rLnY0aH9DVG06dO/k
         BsN3W/W6+uSiaTb9IWxHWzTyKwI6wI2sd6HyX8jOgSUaq1cxCfJ48nZh+mEqdslB1O8y
         yFwp/67cnGB3skx6vTG/iTh01NQWqdOxxeF7ACYI5AkTmE49KxHnJAi6pdqFWHPilIqA
         t4BBXknGaMfeuTN3UpsdmF/ZCv/TfEJPR98frt5RL3K0nBv8Au8M3dNOswuRuy/iq27e
         DzZg==
X-Forwarded-Encrypted: i=1; AJvYcCV6/Cb7JhN8KFt/BiZncur3/BkXRSAn2ORVbWSYVKtC1IGuPiIic6L3feb62maacqahnUBmD0SsNQVwelkHH0UZ18+HhwEkayPXh3dzI0/6
X-Gm-Message-State: AOJu0YwWWf2bfNLc9Y/BSKGKWHEaspn+YB7FGJcmiDz2wP/1zqmMKDEt
	14T06/n1mjY3CArmlYpBS14lM8EgGCHE4CjRNu/KNIKtFnf8YArNCsMNnyID1w==
X-Google-Smtp-Source: AGHT+IERupiu47qJljsmVu1JdjLbKzVfc9DMWEHXDw9WaIvbcwYeeqWAwGzBdeP97EVsJttoCi5QSg==
X-Received: by 2002:a17:90a:d18b:b0:2bd:92b3:a18c with SMTP id 98e67ed59e1d1-2bf5e84acc5mr1266399a91.3.1716521982456;
        Thu, 23 May 2024 20:39:42 -0700 (PDT)
Received: from localhost (197.59.83.34.bc.googleusercontent.com. [34.83.59.197])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2bf5f61272fsm405503a91.27.2024.05.23.20.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 20:39:42 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@google.com
Cc: jeffxu@chromium.org,
	akpm@linux-foundation.org,
	cyphar@cyphar.com,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2 0/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable
Date: Fri, 24 May 2024 03:39:29 +0000
Message-ID: <20240524033933.135049-1-jeffxu@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

By default, memfd_create() creates a non-sealable MFD, unless the
MFD_ALLOW_SEALING flag is set.

When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD created
with that flag is sealable, even though MFD_ALLOW_SEALING is not set.
This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
unless MFD_ALLOW_SEALING is explicitly set.

This is a non-backward compatible change. However, as MFD_NOEXEC_SEAL
is new, we expect not many applications will rely on the nature of
MFD_NOEXEC_SEAL being sealable. In most cases, the application already
sets MFD_ALLOW_SEALING if they need a sealable MFD.

Additionally, this enhances the useability of  pid namespace sysctl
vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel will
add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the MFD
to be sealable. This means, any application that does not desire this
behavior will be unable to utilize vm.memfd_noexec = 1 or 2 to
migrate/enforce non-executable MFD. This adjustment ensures that
applications can anticipate that the sealable characteristic will
remain unmodified by vm.memfd_noexec.

This patch was initially developed by Barnabás Pőcze, and Barnabás
used Debian Code Search and GitHub to try to find potential breakages
and could only find a single one. Dbus-broker's memfd_create() wrapper
is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries to
work around it [1]. This workaround will break. Luckily, this only
affects the test suite, it does not affect
the normal operations of dbus-broker. There is a PR with a fix[2]. In
addition, David Rheinsberg also raised similar fix in [3]

[1]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f267d4a8784cb/src/util/misc.c#L114
[2]: https://github.com/bus1/dbus-broker/pull/366
[3]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu/


History
======
V2:
  update commit message.
  add testcase for vm.memfd_noexec
  add documentation.

V1:
https://lore.kernel.org/lkml/20240513191544.94754-1-pobrn@protonmail.com/


Jeff Xu (2):
  memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
  memfd:add MEMFD_NOEXEC_SEAL documentation

 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 90 ++++++++++++++++++++++
 mm/memfd.c                                 |  9 +--
 tools/testing/selftests/memfd/memfd_test.c | 26 ++++++-
 4 files changed, 120 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/userspace-api/mfd_noexec.rst

-- 
2.45.1.288.g0e0cd299f1-goog


