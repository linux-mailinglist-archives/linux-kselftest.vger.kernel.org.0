Return-Path: <linux-kselftest+bounces-3778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C158843279
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D961F221BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 01:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7C363;
	Wed, 31 Jan 2024 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="M/A58gRt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2BE17BD2
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 01:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663226; cv=none; b=UPI9S5xprrpj1iqOJhGeJYPEoaTQ7/js+RijQdHdU+gQkjiqW3FQy0ugTvspPE9qzwcwvxqZXsnxdsqlPzWco6+mTB90Q7wUTue3MKUXFlgiT99urLLrwmUa3L7QuF1w0vC5qcBw+bOkK8Vb+sI5CBRFP+ktlA+C0hEiPrrXGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663226; c=relaxed/simple;
	bh=IbDUWk3KxJHGN3bPvPRSRgWjaoDgesrJOCG1kQ+QJ3I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h+pm+jIiCcQMGfiSrYslRfYIGCx8OclqhO8fAFDvLQXx6Pyw7JWY07zdZigovEF3sd0hSRC2YrMjTLdYd2nA+wkDRDjAcHkzYo1777Q8bjpp3fWlPk8s+5u++AkMw8Or+J3XXX2+hfZfoFqGBhdfHmkj8yk509iI5zM9Q/ISMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=M/A58gRt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so2637034a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 17:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706663224; x=1707268024; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kpHLBVSDtt2Vi3PB1+vKZ4waG/FnYqHyoq4gGiKTKkU=;
        b=M/A58gRt4APY4x76lW4djnGWLooG+c+k8bKDDV0tDz/L+Lh/A5ixeRAs3c2w8GioAt
         Df9ow7eksIU3SgZpgWB9qOvFIqKIV6k/r3OjWuD/r9HeY1ZHf9+hxDkZkNfVmJWFDPkg
         SmAOfvDb4h9us0Nw/rDYk6QoqhtLsVx8v3aWnorAdlftR/UOVcB5OMCKck+9ZTAY6fRr
         dFObWnnnwYLeu0CarZs2ac0OCUrYoRvUm/g49YpVEB4hFaqlIXSOZPlPkgxPEbtTjX4J
         vYZkZbrIy5SvKMWarYTXTqh8Y+ZYiV8U3Wr3v9UuP8ksVwE884oR5EH3B4GM34itqIEj
         KdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706663224; x=1707268024;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpHLBVSDtt2Vi3PB1+vKZ4waG/FnYqHyoq4gGiKTKkU=;
        b=jTyzuW8Q4R820iQPbYHJlGNT5+tdwhkLhPW04+4MnE+Z0IAcSYre8WOK3+Nlen9J1r
         nFWpJRPjGWOLmMYDpUxDpftVFm2o7mPzsr0HZc4wGDgAhMJrmA4lsv5dJ8K9z/Mn/aed
         KM4HgV7gctb/m+JByLdEUOTeR2yBkslzf8OtP1/+AT50LPHxxHWVLXBRLXY8VQW+aDrq
         cwLDOKUCJjmlMPXBAhezgiPgifA1xPBzGyIEQebQ4j118xTTE7kK2qE0vL/eeqEhaSgr
         IesKWFgzBt6OiyV6vGfrZPIpd6X3s2wf/R9QQcTNWI/I4fOw96TBMQAbtmxBak6tA2w4
         3Ihg==
X-Gm-Message-State: AOJu0YzlBvrMmxDWhqBWBG0MhkmZKF8CFt6ZEI7hP1kv6k1mqfZTWxih
	hELQGzXJRgRzmJLVJ2O11X8Ju9NL9XJlZwhbQ0BDxq5rojfmY3lePIJDk8tZ790=
X-Google-Smtp-Source: AGHT+IEledlNCHKmoKtfP+m1/NFojyVfcYEBlPa2pMEEwNPBKFgNLr0k77Wiitvd/LQG/pfBvXvaYA==
X-Received: by 2002:a05:6a20:da88:b0:19c:912f:1cfb with SMTP id iy8-20020a056a20da8800b0019c912f1cfbmr162474pzb.12.1706663224274;
        Tue, 30 Jan 2024 17:07:04 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id r12-20020a170903410c00b001d8d3c276c4sm4970822pld.35.2024.01.30.17.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:07:03 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 0/3] riscv: mm: Extend mappable memory up to hint
 address
Date: Tue, 30 Jan 2024 17:06:59 -0800
Message-Id: <20240130-use_mmap_hint_address-v3-0-8a655cfa8bcb@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOduWUC/3XOywrCMBAF0F+RrI1kklitK/9DpOQxsbPog0SDI
 v13U3GhQpd3YM69T5YwEiZ2WD1ZxEyJhr4EtV4x15r+gpx8yUwKqQVAzW8Jm64zY9NSf22M9xF
 T4qEO2oKtwjYAK79jxED3t3s6l9xSug7x8a7JMF8/opQLYgYOvKqcxf0u6LrCY6Q8JOrdxg3d3
 PEB6mVAcO122ps9KGvgF5hXZfm1RIklSBYoKI02eKXEVv1B0zS9AI1VQNFHAQAA
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706663222; l=2312;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=IbDUWk3KxJHGN3bPvPRSRgWjaoDgesrJOCG1kQ+QJ3I=;
 b=H2X+ZfEVZflQSr9sjSg75daZSBI4yo2Pp8YPZpTe6aqFR2nngVSjlVIm7BQM+Qe5pBNX4XkvY
 yrAhS+qz6eYBkMnzptrEfefikKErPddkr3rg0SrfPuiuPLi7+jspFb9
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

On riscv, mmap currently returns an address from the largest address
space that can fit entirely inside of the hint address. This makes it
such that the hint address is almost never returned. This patch raises
the mappable area up to and including the hint address. This allows mmap
to often return the hint address, which allows a performance improvement
over searching for a valid address as well as making the behavior more
similar to other architectures.

Note that a previous patch introduced stronger semantics compared to
other architectures for riscv mmap. On riscv, mmap will not use bits in
the upper bits of the virtual address depending on the hint address. On
other architectures, a random address is returned in the address space
requested. On all architectures the hint address will be returned if it
is available. This allows riscv applications to configure how many bits
in the virtual address should be left empty. This has the two benefits
of being able to request address spaces that are smaller than the
default and doesn't require the application to know the page table
layout of riscv.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Add back forgotten semi-colon
- Fix test cases
- Add support for rv32
- Change cover letter name so it's not the same as patch 1
- Link to v2: https://lore.kernel.org/r/20240130-use_mmap_hint_address-v2-0-f34ebfd33053@rivosinc.com

Changes in v2:
- Add back forgotten "mmap_end = STACK_TOP_MAX"
- Link to v1: https://lore.kernel.org/r/20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com

---
Charlie Jenkins (3):
      riscv: mm: Use hint address in mmap if available
      selftests: riscv: Generalize mm selftests
      docs: riscv: Define behavior of mmap

 Documentation/arch/riscv/vm-layout.rst           |  16 ++--
 arch/riscv/include/asm/processor.h               |  27 +++---
 tools/testing/selftests/riscv/mm/mmap_bottomup.c |  23 +----
 tools/testing/selftests/riscv/mm/mmap_default.c  |  23 +----
 tools/testing/selftests/riscv/mm/mmap_test.h     | 107 ++++++++++++++---------
 5 files changed, 83 insertions(+), 113 deletions(-)
---
base-commit: 556e2d17cae620d549c5474b1ece053430cd50bc
change-id: 20240119-use_mmap_hint_address-f9f4b1b6f5f1
-- 
- Charlie


