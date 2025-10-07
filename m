Return-Path: <linux-kselftest+bounces-42803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC91BC016B
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48264188DA23
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26053B7A8;
	Tue,  7 Oct 2025 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WTL6iwSp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0273834BA3E
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807868; cv=none; b=nMdVVCf4lu2Xw0dO3NZ7FsAPGPxoBQEQthLmMFmhwP2XF48OyyPFtAJPq5p7yWR2DEAsxf09DSD8msf4WHz4W0dRoALGvqFoPABUwyXuo0teWQkAj3g6mDGwG4C8e0V+l1cw5n5qFdFSA3PpPSUlZG+ZkZOysV/TUTYcCX/OmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807868; c=relaxed/simple;
	bh=MhQ6oJejU6PDuMID1wCmHAiUGwf2Bfqf9rncwjrHPQw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QsEPnSwF2O2FDpulLen6OIfROKqPEwcgMEQV6k3NqKzGY48OiIPe6ri16oLujBbOuGcHCgNjB+h96Ol+zbZt2aBVxxL9S4Dec1Btr2D5c3AgG08gSf7hVsXTISHX5u5krMgj2l7gY5vz1Olg0cworN/UR59qUjqEguHU11oEj0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WTL6iwSp; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-58de3ab1831so5469342137.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 20:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807866; x=1760412666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjctk86pjCIgeyP/NdtThstP3+9eB+EELMA59nxuFWo=;
        b=WTL6iwSpS69VOe17zYnHhBqm+nkBidSvzd7Pj9gEFDXZyR/uouifYQAWiIJrY7DA41
         nEZGvUwiXISWhc4jYz8F1H3Gfa/qqXBUufc1nGrbZFhZmH7o90c8dzogGfQ5BRDPwWmX
         ytkgC+UpAhvWm54gvhCQxDjVCMWNnpPqbUlThUEA5D4icp2FyvMRi2ZcPKhDqwsKLnrt
         a4eYlkUaQDPE+EAcLgPRA9dd7vnBVdI+8B/ij9TH0F0TW750nFoWKskZTNLTk+klEfUk
         x5j3IT49IDd2gnewq/NUcjtFqLB5+Y3batYxFzkzYE8RZkm7ZFen3ME7uDwSU67INgBi
         RMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807866; x=1760412666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjctk86pjCIgeyP/NdtThstP3+9eB+EELMA59nxuFWo=;
        b=PUXgVnnvpb5UolQa+na5mCbrrfN5Ee/9uQVzdey6mVk0yMgkmtqN560BZ1CCaSW+dc
         aZVsfhxuTtVxxTzcN4cKbRhh1MmhOHCnkDXz5mFZzpZC4uk6/0TFFOQRMUTT2R2c/jDk
         nxNqE9i864yDgxtZhYH6+6DfhfG1jz8ETIyF9GKA0N0bxRsLuaLHLj7pO1zFny1c0hQ0
         nM6NA0wN0zNDoLqfiFbqw106JkJCqs0IDTkeLuArdQFbVQmZ23xxfsb1ZqAslB6ojW1G
         Gp5JxpyZvCsCfhMVkA60WroWWTlrcXeBPl7IUWt+Mqs4x8l+Al9m1PIZpIIRUywwYf6O
         yMNA==
X-Forwarded-Encrypted: i=1; AJvYcCVYM6SC9VTtibc2LFQNNWDdiYFJPbBrgSphZ8KhgkEiecE9bnLAup4Mv6k/kAhrbyP4BuA5Kf9BhVfU+X86NR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfeLXpbsaoZxNJFf1x8oVE3ZVJrxIbm9mEcMg/sEA8CABhjGq0
	4huTbkfYx+rVLBdgkcsq8ikKURdGXOHsJU1SegRGJFbhEmJwYE3i1opx+PlRLawX/+UPSEF6BU8
	Wovel
X-Gm-Gg: ASbGncvCSzPDWfy2p1aD34AqN/EbxhOJtqfhW1h+HYFDz3mA7Nb/dFSHRoYYgUXvHxW
	cCp1cDLe5iyb9WlrXjfLd70paq8JtDhpSLDfSfI1d3FhC9hbQ+8IQpTBZJ4iGdLMtNMaDzb9Ulp
	yOaD5MzRvFoAFWkVnHrStHeLYP0ARKSAL2d8X6ENU1Mybab3XoOpELMLdf6YQRVDJfJwhEb27iY
	YzRRDYSXAVgZqiEaMH3HIsDVaj0cWVdXkCY2yEnQtmQEAJ+gEC+eQ9WT8ntjx5GpXhH52zfIslu
	uPkyLVYpT2tBZaw01EmMpJYyNBISpO5uFEfAlLAhd9vPLjQKRGSL+Z3l1fkYdEbOTTaNL6CqRib
	7FJ2u2m+bzwnt4FnBDrM9m4HfJ2D2nMG6GUrZapmXVyXB18EQW9dfcqHaXhKX2nuJFRZfMX6sjt
	vbfv/6YVHEXUvXOd5Il2IkXeK2kY7I6Ic=
X-Google-Smtp-Source: AGHT+IGKRy0UP3vTkTlJTpx5s9AazpWHtvbvNx1lS1PdbgNpyNUKLM1G0yemMh+rckd5h8dVv5lWbg==
X-Received: by 2002:a05:6102:5347:b0:59c:93df:4fe with SMTP id ada2fe7eead31-5d41cff3341mr5630492137.9.1759807865789;
        Mon, 06 Oct 2025 20:31:05 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:05 -0700 (PDT)
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
Subject: [PATCH v5 0/7] liveupdate: Rework KHO for in-kernel users
Date: Tue,  7 Oct 2025 03:30:53 +0000
Message-ID: <20251007033100.836886-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches are taken from the LUOv4 series [1] and address recent
comments from Pratyush.

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
  kho: add interfaces to unpreserve folios and page ranes
  kho: don't unpreserve memory during abort
  liveupdate: kho: move to kernel/liveupdate
  kho: move kho debugfs directory to liveupdate

 Documentation/core-api/kho/concepts.rst     |   2 +-
 MAINTAINERS                                 |   3 +-
 include/linux/kexec_handover.h              |  53 +-
 init/Kconfig                                |   2 +
 kernel/Kconfig.kexec                        |  15 -
 kernel/Makefile                             |   2 +-
 kernel/liveupdate/Kconfig                   |  30 ++
 kernel/liveupdate/Makefile                  |   4 +
 kernel/{ => liveupdate}/kexec_handover.c    | 515 ++++++++------------
 kernel/liveupdate/kexec_handover_debug.c    | 216 ++++++++
 kernel/liveupdate/kexec_handover_internal.h |  47 ++
 lib/test_kho.c                              |  30 +-
 mm/memblock.c                               |  60 +--
 tools/testing/selftests/kho/init.c          |   2 +-
 tools/testing/selftests/kho/vmtest.sh       |   1 +
 15 files changed, 553 insertions(+), 429 deletions(-)
 create mode 100644 kernel/liveupdate/Kconfig
 create mode 100644 kernel/liveupdate/Makefile
 rename kernel/{ => liveupdate}/kexec_handover.c (79%)
 create mode 100644 kernel/liveupdate/kexec_handover_debug.c
 create mode 100644 kernel/liveupdate/kexec_handover_internal.h


base-commit: 4a71531471926e3c391665ee9c42f4e0295a4585
-- 
2.51.0.618.g983fd99d29-goog


