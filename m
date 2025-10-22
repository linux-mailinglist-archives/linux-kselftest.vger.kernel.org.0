Return-Path: <linux-kselftest+bounces-43728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D3FBF989B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 02:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B34E4DAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F611D63C7;
	Wed, 22 Oct 2025 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="lSLaLCmT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F4153BED
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094644; cv=none; b=E7+sJIznlu57YGz8thnIQtM3QXOg4K3zGofviFRiLQ5D7PIW10SkFEqq6nhBQUs4T/dEWqqR0hko9TAGG4KoEW+BhDY8AmC4hRS59f7rEWNJW9+iSiYgduC4FdztaGgJB1ZWBViIzHJuxecQQ9jyiEgTJ6sc4V07DBfdFu95ow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094644; c=relaxed/simple;
	bh=9krFfBFzNRyhUMmfeWLlyo3WxmWtdBaTzDL2to5lDlA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FPo+dONeEeKBCV4dMRsjPJHAh1vqsHGWQ3gChYukS1lsvDm0i7SRmRnUoiwm2QPUb55wLpb2qX/b3m/8pluI3pmuQW5XnJva26v6zfhIo2ZyjHf6MnlBWZSXglIdCAlYET841EVmVG7Ylnm8vpsit4DdYYclyAlGi+wAy+unfRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=lSLaLCmT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4e89d4f0e8bso5194811cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761094641; x=1761699441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6rRIjCz5N1D5Ed0cxws3QbJ+B4MJ09ZUi0KecBqWPM=;
        b=lSLaLCmTKjXZDFzC5cprVwF2QrNInMEgRA+kVGEsHdG1PMNAB069TCyZYe9zgzSXie
         K1L+NWHaNoBITTZyoF/V4qD6qqQSx/oUP+kIbwlqhFF2PqMj68DzG7ZzOtFG9WNqsNCE
         Q0v/GtRnfZ1WUGpcXqEk1bYB7xFpvvSTe8/SoH269mAjliugAVzNQchzLI5zOftbAJLu
         bAYUiY/4rrqVeLehcoZ6+A/taVzKlNrs5J5laqDaddMkhqVZdaceZU0/MoxvZy9a6L8A
         BH1SYqcUQHTe+t9m3RkaZgiVmuM54KsO30zFTHYPF3b89n8x2hFoWOFO4FhUBWFJmUg0
         fSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094641; x=1761699441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6rRIjCz5N1D5Ed0cxws3QbJ+B4MJ09ZUi0KecBqWPM=;
        b=DYsEu55dhqLj737yXqOx6akQeTEbI3UunrxbecMPR1b66fmhygNLMswFLBhUNFd9Cs
         w/rYUAZYxUP6gpVvpBeTaktBucRywIW/q6KKNsOvn1x8Gem3B2ADOMvNbMoLoRLO0aB1
         7ELEua+M2db0vYvAMYiA+Pu75ZGl1jxM5XfZPFDAhrR43v78jJMiScbydwh8WUiK4HBj
         dw6Jgbtp1ci96OZ0iy5+4hy4Jx3cGdGumtodfQj7R2UIUYWMIP4gkXfMG5HfZTZsLGyb
         +wiLQqhmtafuBIgn1dQ7VhgeVZ0fBXUmhlaeS91FhHo50e9jS+eMVJ/5/AjMePJNF8sh
         hlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBWRgraqwGalpwAB0DGu6Wk6l1DMAmPhHiry0WOVEe0+mtUd6j8M/zCP27Lrs5xgHW91/NuK4a4JnxCceB42k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kJ9KVUOtbHMPpzry1qMybvlyzQZtPe6pza9KTpJM58MpMfAH
	4J3/FDFXDx1JORn0R2X9JiwJuLLlNgc5/sjLEDf1859+N/S7e7qWb6Fxk3ZJ8k9qRKk=
X-Gm-Gg: ASbGncvnyKdM050UzlXrZNllx1sUC6PtCxRYj80THE2e4WiFSdr7NJaKgOsqPEd3lGG
	6OXKD0EQrxLoyGcF3PZrajGzyIzV+T2MjWtjEg21uUC+uZ0DfAm9KOdd+92sG7FQ/+I13z6CQRj
	o9L+tUIm6+his5NidqaYw41DEhCmngcUf737x8Otfp7vv7omjn7jOp93ZGI1AU9p1gY/5udiDj4
	v7lmRAzN7GSZ2QHUaE7Ocda3NEbz6lM5sSYgNaJU9/Jw8ooeb56jdpOrpwWJkay/1h1Q4YCjBRn
	f0Ek2mKKW8a5Rml6hEvbDhQ6vptYy7n5Ec53qqTvq2i6pagfsdpdZjzIW+vuAmi6GSkzjbCaIEg
	md7Mbsvm0KCsLaR0Xj3786QbAxESUr9rdcy0bYNaEcPh7Q9XgJPp3QVmPr84FN/142dzsJZ+ujQ
	Zc7/kABU5ApnUaspBQyEMq8qckld+oU2iZnOXp0jN/KXdmLYQ3/ItAzo7p+U6edYNZCrHtJ3nOJ
	6KQYFxJBMKH+gjDWpdwkXkytPFls6ll
X-Google-Smtp-Source: AGHT+IEIQnd/1fvDkk54xuNCdb61dv8JtlPct/U8dUFU7qNizs881GaUOM4iAn8ujhSbADE1PGNtYg==
X-Received: by 2002:ac8:58ce:0:b0:4e8:96ed:2e63 with SMTP id d75a77b69052e-4e89d2bb2f9mr209505651cf.34.1761094640840;
        Tue, 21 Oct 2025 17:57:20 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3432dsm84169501cf.2.2025.10.21.17.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:57:20 -0700 (PDT)
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
Subject: [PATCHv7 0/7] liveupdate: Rework KHO for in-kernel users
Date: Tue, 21 Oct 2025 20:57:12 -0400
Message-ID: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are taken from the LUOv4 series [1] and address recent
comments from Pratyush.

They apply onto mm/mm-nonmm-unstable.

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
   part of the stateless KHO work [2].
 - Moves all KHO code into a new kernel/liveupdate/ directory to
   consolidate live update components.

[1] https://lore.kernel.org/all/20250929010321.3462457-1-pasha.tatashin@soleen.com
[2] https://lore.kernel.org/all/20251001011941.1513050-1-jasonmiu@google.com

Mike Rapoport (Microsoft) (1):
  kho: drop notifiers

Pasha Tatashin (6):
  kho: allow to drive kho from within kernel
  kho: make debugfs interface optional
  kho: add interfaces to unpreserve folios and page ranges
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  liveupdate: kho: move kho debugfs directory to liveupdate

 Documentation/core-api/kho/concepts.rst       |   2 +-
 MAINTAINERS                                   |   3 +-
 include/linux/kexec_handover.h                |  53 +-
 init/Kconfig                                  |   2 +
 kernel/Kconfig.kexec                          |  24 -
 kernel/Makefile                               |   3 +-
 kernel/kexec_handover_internal.h              |  16 -
 kernel/liveupdate/Kconfig                     |  39 ++
 kernel/liveupdate/Makefile                    |   5 +
 kernel/{ => liveupdate}/kexec_handover.c      | 513 +++++++-----------
 .../{ => liveupdate}/kexec_handover_debug.c   |   0
 kernel/liveupdate/kexec_handover_debugfs.c    | 219 ++++++++
 kernel/liveupdate/kexec_handover_internal.h   |  56 ++
 lib/test_kho.c                                |  30 +-
 mm/memblock.c                                 |  62 +--
 tools/testing/selftests/kho/init.c            |   2 +-
 tools/testing/selftests/kho/vmtest.sh         |   1 +
 17 files changed, 576 insertions(+), 454 deletions(-)
 delete mode 100644 kernel/kexec_handover_internal.h
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (80%)
 rename kernel/{ => liveupdate}/kexec_handover_debug.c (100%)
 create mode 100644 kernel/liveupdate/kexec_handover_debugfs.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h


base-commit: 4d90027271cfa0d89473d1e288af52fda9a74935
-- 
2.51.0.915.g61a8936c21-goog


