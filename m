Return-Path: <linux-kselftest+bounces-3757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E9842C4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 20:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE17D1C21B6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300412CD87;
	Tue, 30 Jan 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nq1fs+eL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3DC6995A
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641476; cv=none; b=Xg3622FcUOIo+fqKTGsOtl4p3sy/RkIiEj5qeAaIblq6oz06a+B/YgreSeWczBPMMeYeG+Rwz4mnIPqKPNQSQRweVi3VthMoD1v+3ngB4BhoZPzocdpACOHxbbHTp0BGO+Cz23vVmDRN4ycjzOTfbH+KwCFwogIstigIN1DkDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641476; c=relaxed/simple;
	bh=nus7scvl4gLMAQ9st9lYJlzmjXyvjRvTvEos3E8SaN8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HLX/K1fp3CQIiC54AKCbwFVk3vvc+oMOiP9X86gozOzdy6uvq48S8drTLne3cJI74aRLHSdCxvLZ2CPnVSpBEZQ6AMjAR55WdNz+VNd8LBiMNUwwN1j7UaVb+JXL1TmmDVl972tmP6PiGX4f5vdhfXIjOTLMGxzgStlmTAJl6f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nq1fs+eL; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so2165225a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 11:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706641472; x=1707246272; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4D44QK/kPW88RwduNoGSI0iqhkYRS1kC786c0l3XOWc=;
        b=nq1fs+eLRG59MrNTwnRre/mwxVOl+aj0QMpkHDumPah7ZW1TL0rOO6VrB7qpI6tFa6
         dpZGcGyYfDYFABPTaT1mfSdsk6oIK69rR6T4wpc2aZXFjQRBjsCFZPGxJa/J3fj0a5TL
         KmoAlm0AIap6GR3E/rdAJIWn96OsIz2P5DxodQuJ/hmbDCKdU/iOLEjTVC+npNpppJxH
         0eFJlicOrCDL1/dvNC5cVAB0N+XJeAEvzbUr9pUBxqL7xD39Mhe7G2Hni4pIzl+mmE8g
         rT84b8AJsg35DA16mj07jEUTdHvbPDXhLl+93Cf+fGAgGN1BXeOlu9bqDXv5R5oh8k9C
         cMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706641472; x=1707246272;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4D44QK/kPW88RwduNoGSI0iqhkYRS1kC786c0l3XOWc=;
        b=t5x41ojABl02Y9y6sYyCyWCi1LrjHdMjVW2I0pt3u1WAflDvgCiYod8qEgynpi4lMM
         Z+2UMrgs4WSLC55wIZvzWMmYYGwMTcx2peEJdSPes4nLFXqcxJEQr4r93sWkabkQVwyI
         lBrht7wD70Cf5JDXpHsqxd6pGQzJpwwb0HFopg3DxtzRJmrvH+Yxso0xrVoYjBbzt2Lp
         OHd7lIPz9ln8yEKYIwR1xVai3yCQ0F5zh6jciL0kCnz4JqmTczZTVh3Qe2rXWwvnadus
         AS3oWid5oRXcn3s1G5X1pdQtHoOnznIkK9ZTLNTEr2CdqB97E436aB8F0T1SdJseTCVY
         iyaQ==
X-Gm-Message-State: AOJu0YwJAM0Gc2fY8ugtgVHmRF2lQUAAhgQt/qJY6fS0HevCC4UVDOtB
	SV9MgBkwbmaikcOI1V87NwT6mHnzpylbtZlfUpinjJV/Od85zDIA7CByI47qccU=
X-Google-Smtp-Source: AGHT+IHDqzd/dBdeKM2ZuEG20ibf2MrAQHh0T7+zovFIc6n7MNP/9tMbddtfCfApaIPGdcPdBlRWvQ==
X-Received: by 2002:a05:6a20:291e:b0:199:8ed6:746e with SMTP id t30-20020a056a20291e00b001998ed6746emr4930207pzf.58.1706641472640;
        Tue, 30 Jan 2024 11:04:32 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090aec8600b00295c3bb9318sm1196541pjy.54.2024.01.30.11.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:04:31 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 0/3] riscv: mm: Use hint address in mmap if available
Date: Tue, 30 Jan 2024 11:04:29 -0800
Message-Id: <20240130-use_mmap_hint_address-v2-0-f34ebfd33053@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1IuWUC/3XNQQ6CMBCF4auQrq1hagXrynsYQtoylVnQkhaJh
 nB3gbBxwfKfZL43sYSRMLF7NrGIIyUKfglxyphttX8hp2ZpJnIhcwDF3wnrrtN93ZIfat00EVP
 iTjlpwBTu6oAtv31ER5/NfVZLt5SGEL/bzAjrdReFOBBH4MCLwhq8lU6qAh+RxpDI27MN3bqxA
 +oYyLm0pWz0DS5Gwz9QzfP8AxGwGU3+AAAA
To: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706641471; l=2052;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=nus7scvl4gLMAQ9st9lYJlzmjXyvjRvTvEos3E8SaN8=;
 b=KdPbSOIofsdWCW2zc9sZLA78Ps5RefDdeL5SX6tbIQDoFBXQBMlLBYRg9jpjXuHz+YesaWxjJ
 OSV+nMMkghNBtK/mt4vwjxEe5eas0TqtgvuALwBT9CPyCLon78uuHuz
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
Changes in v2:
- Add back forgotten "mmap_end = STACK_TOP_MAX"
- Link to v1: https://lore.kernel.org/r/20240129-use_mmap_hint_address-v1-0-4c74da813ba1@rivosinc.com

---
Charlie Jenkins (3):
      riscv: mm: Use hint address in mmap if available
      selftests: riscv: Generalize mm selftests
      docs: riscv: Define behavior of mmap

 Documentation/arch/riscv/vm-layout.rst           | 16 ++--
 arch/riscv/include/asm/processor.h               | 22 +++---
 tools/testing/selftests/riscv/mm/mmap_bottomup.c | 20 +----
 tools/testing/selftests/riscv/mm/mmap_default.c  | 20 +----
 tools/testing/selftests/riscv/mm/mmap_test.h     | 93 +++++++++++++-----------
 5 files changed, 67 insertions(+), 104 deletions(-)
---
base-commit: 556e2d17cae620d549c5474b1ece053430cd50bc
change-id: 20240119-use_mmap_hint_address-f9f4b1b6f5f1
-- 
- Charlie


