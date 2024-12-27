Return-Path: <linux-kselftest+bounces-23761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F39FCF7F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 02:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472393A0445
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 01:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18601C6A3;
	Fri, 27 Dec 2024 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1JvUlzV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1856AD2C
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Dec 2024 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735264331; cv=none; b=F9ecW15kwDf9IxI2NSH6VL3ms3J9BXs7jDf8DGEz2EVgfU6Mw4JjZzB6WE8Xyu2CHPJHZm6WXxo/md8NmjFN9mwtTEAleJKojXJNunA8RXg1f2sRmDYXI/gGAXaIR//JtIck1EwXSnxp7SeupGlu2waf5mzWLe0H5PHCTba/CO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735264331; c=relaxed/simple;
	bh=a/fNTsv6ntKkl7rpZpXxG8kUA7FAoQIOWQNKCb3dd98=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KnkWL/22pfd79+3Q8wJTd2tlNsMPIBkfNwUHxiBzt5lQjZ2/gaLsaPJCnDUBkZcu+A5GKWnB1pnN3ux6OXRknsG9PVEUOcBzUvOCHUbyqHTMKa0yEu5ZZUPihJORHNLHusEP3SvzRD14sul13kkGtrQJ2QEIxK8sCygjJprjxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1JvUlzV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso8895050a91.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Dec 2024 17:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735264329; x=1735869129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BF8+fyz9Apz0jWTN+ibPUE67TAfznRJEkUbbncSLIn0=;
        b=M1JvUlzV/fiWGNbAJoNpZfJVil56+Zkpn+gDFZYGzh7bsEr2ZDEV4oyL2O7BhGxfIi
         Ux4TCi/a9c2q5M+34EOaHg7CDy6oemLlYKne1P30Os+8GPjU3yEjr4rhtZ2m6DfATDS7
         5YYHxzDnZrZ8XZQE837MzoUFP2K73gIkTAtnwXY9i2VaujDDqzUIX4EQC6dJZpUWvCrR
         bqM9itFawGKvYD0sX8QQ4O0xG/tPZfEEoKwOWIPIGoo/iwNSU+InVtnU2dbcCB3+BCrI
         d9L5dvgiCBCs1xUn/e3wf9N4Ay4KJmTuyGhFogmVEBSmCDYFtoIXVanUA4a6R3xkwz1/
         PL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735264329; x=1735869129;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BF8+fyz9Apz0jWTN+ibPUE67TAfznRJEkUbbncSLIn0=;
        b=Hg1/iVqPo5AeS/fhltwHCpikHes/YxRJPYV45n0kHUHQsGqref8W/Hc9B/i4aPovYd
         j6xMNRRgnt9qL1RC4OnJcZJKVyxnmMEXuFg/9tzzK9skMoXlddoT2x3YcRJ0g/vgGLQf
         7+xlwT6AXl3OqbhDUTipBNxHXR9HRqQ7soAlD/ULhoeJwFxi5/QqqSd6mGpFlLsC7+cS
         6ZSo70yVo+5iA8v1rqxAjXYD30JA+IITCBdV9JOSCkg+ixsE2DbdsS6FEDQofPjPg8fa
         a8FF2pVYOgqLs2qsojEvLXU38wL6Q7vDgtriEQbeAGJVQSA2EfkNbq0x6tIhiJYStm/g
         78Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVxB+hymWtyERliRU/rL+TeFA8AghFYYfM5lsjxHW9E80bTpTykH543KggG3QkFa7VFD8kb9gkQo46aSDofMUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwShhGVAhade6wN5rucH5RYz9SwCxXYLfZqpF6ObsW6ccpnmnYP
	xDOlOJw//Y7f/u13J/nk534rKqxR7kFcP6cGSdHsnCJ0KNn49ueYx2Tbbuze7A1RX7OziDZXauu
	gNZp9yDb85znu3aT1Mqi4+P9K7nAmFbQB/g==
X-Google-Smtp-Source: AGHT+IGuX+zCZe9XINQ2OHBvFsAHYmtq8kFvhZSqusND653YtJ/1Ql8aLRlwnglyZbf88PFhlsVSjKKaqK3wMSlvU8sKiA==
X-Received: from pjbtb7.prod.google.com ([2002:a17:90b:53c7:b0:2ea:4139:e72d])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:524b:b0:2ee:d797:408b with SMTP id 98e67ed59e1d1-2f452dfcd74mr35605744a91.2.1735264329304;
 Thu, 26 Dec 2024 17:52:09 -0800 (PST)
Date: Thu, 26 Dec 2024 17:51:58 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241227015205.1375680-1-isaacmanjarres@google.com>
Subject: [RFC PATCH v2 0/2] Add file seal to prevent future exec mappings
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: surenb@google.com, kaleshsingh@google.com, jstultz@google.com, 
	aliceryhl@google.com, jeffxu@google.com, kees@kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Android uses the ashmem driver [1] for creating shared memory regions
between processes. The ashmem driver exposes an ioctl command for
processes to restrict the permissions an ashmem buffer can be mapped
with.

Buffers are created with the ability to be mapped as readable, writable,
and executable. Processes remove the ability to map some ashmem buffers
as executable to ensure that those buffers cannot be used to inject
malicious code for another process to run. Other buffers retain their
ability to be mapped as executable, as these buffers can be used for
just-in-time (JIT) compilation. So there is a need to be able to remove
the ability to map a buffer as executable on a per-buffer basis.

Android is currently trying to migrate towards replacing its ashmem
driver usage with memfd. Part of the transition involved introducing a
library that serves to abstract away how shared memory regions are
allocated (i.e. ashmem vs memfd). This allows clients to use a single
interface for restricting how a buffer can be mapped without having to
worry about how it is handled for ashmem (through the ioctl
command mentioned earlier) or memfd (through file seals).

While memfd has support for preventing buffers from being mapped as
writable beyond a certain point in time (thanks to
F_SEAL_FUTURE_WRITE), it does not have a similar interface to prevent
buffers from being mapped as executable beyond a certain point.
However, that could be implemented as a file seal (F_SEAL_FUTURE_EXEC)
which works similarly to F_SEAL_FUTURE_WRITE.

F_SEAL_FUTURE_WRITE was chosen as a template for how this new seal
should behave, instead of F_SEAL_WRITE, for the following reasons:

1. Having the new seal behave like F_SEAL_FUTURE_WRITE matches the
   behavior that was present with ashmem. This aids in seamlessly
   transitioning clients away from ashmem to memfd.

2. Making the new seal behave like F_SEAL_WRITE would mean that no
   mappings that could become executable in the future (i.e. via
   mprotect()) can exist when the seal is applied. However, there are
   known cases (e.g. CursorWindow [2]) where restrictions are applied
   on how a buffer can be mapped after a mapping has already been made.
   That mapping may have VM_MAYEXEC set, which would not allow the seal
   to be applied successfully.

Therefore, the F_SEAL_FUTURE_EXEC seal was designed to have the same
semantics as F_SEAL_FUTURE_WRITE.

Note: this series depends on Lorenzo's work [3], [4], [5] from Andrew
Morton's mm-unstable branch [6], which reworks memfd's file seal checks,
allowing for newer file seals to be implemented in a cleaner fashion.

Changes from v1 ==> v2:

- Changed the return code to be -EPERM instead of -EACCES when
  attempting to map an exec sealed file with PROT_EXEC to align
  to mmap()'s man page. Thank you Kalesh Singh for spotting this!

- Rebased on top of Lorenzo's work to cleanup memfd file seal checks in
  mmap() ([3], [4], and [5]). Thank you for this Lorenzo!

- Changed to deny PROT_EXEC mappings only if the mapping is shared,
  instead of for both shared and private mappings, after discussing
  this with Lorenzo.

Opens:

- Lorenzo brought up that this patch may negatively impact the usage of
  MFD_NOEXEC_SCOPE_NOEXEC_ENFORCED [7]. However, it is not clear to me
  why that is the case. At the moment, my intent is for the executable
  permissions of the file to be disjoint from the ability to create
  executable mappings.

Links:

[1] https://cs.android.com/android/kernel/superproject/+/common-android-mainline:common/drivers/staging/android/ashmem.c
[2] https://developer.android.com/reference/android/database/CursorWindow
[3] https://lore.kernel.org/all/cover.1732804776.git.lorenzo.stoakes@oracle.com/
[4] https://lkml.kernel.org/r/20241206212846.210835-1-lorenzo.stoakes@oracle.com
[5] https://lkml.kernel.org/r/7dee6c5d-480b-4c24-b98e-6fa47dbd8a23@lucifer.local
[6] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/?h=mm-unstable
[7] https://lore.kernel.org/all/3a53b154-1e46-45fb-a559-65afa7a8a788@lucifer.local/

Links to previous versions:

v1: https://lore.kernel.org/all/20241206010930.3871336-1-isaacmanjarres@google.com/

Isaac J. Manjarres (2):
  mm/memfd: Add support for F_SEAL_FUTURE_EXEC to memfd
  selftests/memfd: Add tests for F_SEAL_FUTURE_EXEC

 include/uapi/linux/fcntl.h                 |  1 +
 mm/memfd.c                                 | 39 ++++++++++-
 tools/testing/selftests/memfd/memfd_test.c | 79 ++++++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


