Return-Path: <linux-kselftest+bounces-36005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 969C3AEC11D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 22:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311DF162F18
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F0622D781;
	Fri, 27 Jun 2025 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWZBKHma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D522A813
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056676; cv=none; b=Ww0KxF+EWaF2Pe3gVMikHDYpnOsJ9/ROAKGROfame/0EhU6u9J2cjBEHhhM4aTWVkH4U0W9cfFOCI5W43JJA3cIBQqKZ4Z/E1kMO9gHBfE0fZMPUMPfmHdCT4TC9urN5mxXTCI0ArVVWN3rxubNHGMrW/PW/WbLS68llq57nq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056676; c=relaxed/simple;
	bh=jVCnSgKgTBaALIL5kswG283XAlndIy4N1hK9vcUxt+M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RMGG45/FEQrwaAHKjGG14Qj7BFcUCMaQUxn1Ov5DIeB0I2uwHRELIiK1gEJwNAs6P/A03umqk2vhVE3OxW54Vv3WwsodmQS6KN3BEqqhW6W15MfwktBeVAH2r24rhNovV46d0HXWOM8l98BafukgMEim76yVuxjJ1DHDXMnj0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWZBKHma; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso760990a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751056674; x=1751661474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KNNvKIHZytjNLKER5B5vXrvdNfJHgheLSxitrBAGU4I=;
        b=ZWZBKHmaK5wk/zCcm449atcmiRiZ5iBkLYwQUhRf//jWZ97rFcD8eZj5aJEADQppvc
         cWt05VHRyOj/pD6rgY2WVYm3gtISa/HVIY65zetcMsme9DBzzHanIHyo1E5E7UVYlvWo
         dFn9iO8lqjDVB9NPStf0jB7E1qtJhv3/+mcZR977v8eMK8b3klnPNj+X4Ux/WysWh0Dl
         7HqHWL5f5+gEr92ZKZA1Y10N4ef/Z28sHyl4FrHUEMA56Pomt4wGYr29ZxPdWjJo1Cz0
         DsRr6Ucx772Bk/or7nXCZr9D8zhsJE/8x5EzqAff3404eZpnjopEFgLoGd4kfLy1od7v
         yrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751056674; x=1751661474;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNNvKIHZytjNLKER5B5vXrvdNfJHgheLSxitrBAGU4I=;
        b=MSCvOIsDaxeGV89hiPIL5scQJ63kRUpTnbHqw5oArwMRenppMySjKoHzqs44CHV08b
         zVlf6NvKMwpHaRw5peomqZG1s0gIni/er7UvKtj/qXLi4Ga6h1+6kNTWvclUmGhZ6hLh
         rEgzKpRHnDo4oLktybqDkdfL/MRhY3pzE7WWzc3vCWSUqiutfHYB8ZpZ6Guaiapj7B80
         MmyN5kxtqR8IL31WADj6ZxNVCBNBBCGkSIqZ6sL60Z2N95pB77Kv0l0ES9H2y/z3DFLv
         yQAP3zJriX1CFrNUgoiWYyaeFAYEvPjeK5gj/ZEOVkIRuQhrcQ/CttILwkOFAvKaaZdk
         ISTg==
X-Forwarded-Encrypted: i=1; AJvYcCXOnN96q9FrWM0z4SSAm40B6/Xbc2YXzqT/VwpLT3ldsYc8xCZtGGikMpWfJwO3dMtzBGafL6zF/er0ajaXr4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+h2lacdDZ30m/v5NYueTJ9zA6EZrOtfoBoNHI30sTODmBI8bV
	uk07+YmwgPlQMRUNCPMnA15ubezhlqK9i1TQcPaCY+si4nxicEruJX/IwC6bzyA2AON0VHoqlis
	RdMyFjQlkzQ==
X-Google-Smtp-Source: AGHT+IEQQPKAxqNl0ciLgZyXlCg61DjKjjnF3AS+cRg0GMCYoGzXmaiv9R+XlDrGhMU44WAuOC72MBc+TqmK
X-Received: from pjn8.prod.google.com ([2002:a17:90b:5708:b0:312:151d:c818])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:278e:b0:311:ffe8:20e6
 with SMTP id 98e67ed59e1d1-318c8ecd20cmr6632918a91.3.1751056673987; Fri, 27
 Jun 2025 13:37:53 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:37:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627203748.881022-1-ynaffit@google.com>
Subject: [PATCH 0/5] binder: Set up KUnit tests for alloc
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

binder_alloc_selftest provides a robust set of checks for the binder allocator,
but it rarely runs because it must hook into a running binder process and block
all other binder threads until it completes. The test itself is a good candidate
for conversion to KUnit, and it can be further isolated from user processes by
using a test-specific lru freelist instead of the global one. This series
converts the selftest to KUnit to make it less burdensome to run and to set up a
foundation for testing future binder_alloc changes.

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
 drivers/android/tests/binder_alloc_kunit.c | 572 +++++++++++++++++++++
 include/kunit/test.h                       |  12 +
 lib/kunit/user_alloc.c                     |   4 +-
 12 files changed, 644 insertions(+), 340 deletions(-)
 delete mode 100644 drivers/android/binder_alloc_selftest.c
 create mode 100644 drivers/android/tests/.kunitconfig
 create mode 100644 drivers/android/tests/Makefile
 create mode 100644 drivers/android/tests/binder_alloc_kunit.c

-- 
2.50.0.727.gbf7dc18ff4-goog


