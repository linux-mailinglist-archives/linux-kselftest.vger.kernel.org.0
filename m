Return-Path: <linux-kselftest+bounces-37275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F5B04795
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 20:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361E34E167B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2E627604B;
	Mon, 14 Jul 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ueewz1F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DA1EF39E
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519211; cv=none; b=nfIgrGXVSqr/QhREuLys06IX5Bloj1iktFV140KxALMvtPLZMgFHArXq9yLTWhjmIK0+TQ7aKuY3gfESrDD4/m7B4GuD2meMr/0ZM9jzLtQcJ//mTnqi0QG8N1BrzHDqr0n9iAZJwl2vd/zg6EQMMPd8HWA51LiaEvFTAgNsTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519211; c=relaxed/simple;
	bh=risPXDj3ZE97v8mJJ667EAITpJdxezJ7+lZmuf9qg8I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=llfIulMCoTG7hR8qTUSQZpUr+TTmIjkaUyCs8XcWkAhvKlYhUC8w1AfV1MJgWeoDhSAVMSrxrW9+eJAZ7WbwHbf5znt2iWQgM/FReOciKvRNPyjd7anoHK1duG2JCqIL/hGs6EM7LUR+b4TFR1aVaiNFnkF3DvniCDhYW4zv1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ueewz1F; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-315af08594fso5065243a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752519209; x=1753124009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+xgwesTSILPgyLCGoIs7ePcEq+ry82PgVAHVTCzBcY=;
        b=4Ueewz1F/CJ3qbuWZM8Ui8AHSdSBjE5ovda541sstDrFWifpib8/qOuwKhb4oYlKSL
         7ZIyFVTKHFZWuWFGx40dTvQkzQuTw4OXmzl6JUUygkM+aZeuQctwmv2J2MpvPYoQ5RSi
         eyQxnfJCUb59o6W6BhaOL5GJLjYFDw+Zu6n3AgJbQf+PbNq1zY24pcoDJafsaP2dROuR
         YwiOPNiWP1/pbbOD85cvlFl4ADySj7oDg+DrbKHyJQ+6G4wER5sRZKT89qUTIVJsdBcO
         MQ+vrweman6Zm2JAj49O02FRRHw5JfI7LO62xsY7yZyu4q+1djVgIY8HZHiqv6DoMvos
         aeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519209; x=1753124009;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+xgwesTSILPgyLCGoIs7ePcEq+ry82PgVAHVTCzBcY=;
        b=IENRRYghoJsO0BLodHFPPZ+RZK95nUNs8VV4F4XQfLxuJZkoR+RP3x3xHHL+i5I2SA
         sarOch1tfPtA2NXDk1I4U36MbciwHmYSxlTIUaLYgl9Eri4CDSrv1vTxZ5SNQB60WNGJ
         +Z64RrK43Jdx7lCMOZW2wnNZa7Wixn4sffZpHhYpIJ5t7jd2tzBaSs8ELYZeW+CQ3myQ
         mb7pjvLhdvja1Bu+TZbtOhS1OIAdM6RHDcqdsOQ4aD3Fk8LZHn7FBjo7IeVwYtIfV0pT
         h29rPXotuLOuhrDB3bd9TmV9gzJkGsXj0kroXnMpescdEvAcHAJWgZtHqleogDlP6nP5
         95yw==
X-Forwarded-Encrypted: i=1; AJvYcCWw3DEykyNvL1OipZ/mEES7brcxpuh5hoLNMvv1EsBJ8npXL4iWxUmQOzp/Uyw5WQP8TnaMMirfDsoJcdEffMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxj+Uy8Hbm1SDBRtutFiLT8cTv+oeGWvQZ+J1HLEgvHs2FJyqG
	XaE/30fs1PKQRgarPJ7wTz4Ga0Yx/ntINSNCdhqPfayrqNF3qbd1sBu1J6KDtgTZqkodQC7XDW+
	6NDWg2/nCbw==
X-Google-Smtp-Source: AGHT+IGSxDfyVQ+AlcvCfHNaTx/qi0MWma6wabzsdqo+Mm0Scra8QIkBiktjFo9tWCkzTTnfXRPym5tTQn1j
X-Received: from pjj14.prod.google.com ([2002:a17:90b:554e:b0:31c:2fe4:33bd])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39cc:b0:311:ffe8:20e9
 with SMTP id 98e67ed59e1d1-31c4f5127ebmr23378221a91.17.1752519208906; Mon, 14
 Jul 2025 11:53:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:53:13 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714185321.2417234-1-ynaffit@google.com>
Subject: [PATCH v3 0/6] binder: Set up KUnit tests for alloc
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


