Return-Path: <linux-kselftest+bounces-20835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0253D9B3AAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8622E1F2253B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 19:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D70C18EFF3;
	Mon, 28 Oct 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2pJYZy0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1101C524C
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730144807; cv=none; b=srUYBaozmMWDOhl2Jwev3/UXJyN3YZQfMERGHjjIdDuc79vLSiwJq9Jmvh8TVRUir4kDCbkp6kMpEiPn65kagM3VnmRCxz/qXJpakWWfrScdgbvfIeZ6+TQ0XpSO+EJSS15uckRPkowzehbRfYJM0FuJLAfSlLUBGrJbP2H++WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730144807; c=relaxed/simple;
	bh=Wrs9JhiATMWL0KsGQ/kqNx9VR2O0tggm+HVJNv2F/io=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VNk/29OWfBBvtuIKRIbBEjLVnplioSL9sfB6TGTzqkFoSPSdHqPV1kVpikHJUTeaJfG1mIJXtGjkIL6jKu4Bq0rTRyw3hZkum1fxzEU7lW3vyfjBXF3cznnZColyqTjxIQE561iJ9nCl4TigIc+qOfWAuVE7XdcuMFU1oU2vBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B2pJYZy0; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4a484e9d537so1401452137.1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 12:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730144804; x=1730749604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j5XRrBUeW9Wl3ksjbcOXPj9gNcJLkL1Vlbum4WC6ah4=;
        b=B2pJYZy0i592JVnT0LtcmwgGRy256ikDCz2MXBvv7NdTO/r3XBh9JrE4V143wvu/MT
         ESbrBLNdYcBzeuUbgOnx2TIc4muhRx1uGZHVIS8xrsJKJqzZ0Aksk9Snm9ENAvVMGGUF
         bFgSvCkHGvLhzQHnAMTSkMXot725Yk57ToP6NsplUForySMMNN1I90z+GsqrufRowmBV
         s8om3r6HWp6iJCwBdb+rYEdpep5OzXmidq1XvRtbU8FDpSGhlNLxHickQUUzPHAHxt+3
         fWCEg2xjbzHeGMgRnPr+yJv5+1MsHuvYorPRu3mn5PHGALwrzpghXN43upKBMweKEpXf
         TgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730144804; x=1730749604;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5XRrBUeW9Wl3ksjbcOXPj9gNcJLkL1Vlbum4WC6ah4=;
        b=Ytwe0Z0tV54ATZSPYvIxsM9QNoml859D37BDAyGlsfPCv0ZuUM8hF0T/1BvWr/kZOh
         V5ESVhfpK0h56maJE4cTeOQAu/URuTupDoM0YWELx0I6loJr64Ylii+b+5rzBItExifG
         m2kV1bJA032UOyS2zqGiq1DKku5DPovHuGhzCtnsXuMmO9GprF6teciIvA88e9z/cCpO
         v07PCBt0QsrjZ4DjplrNwBWkYLKXG8HFM65Av5qHVNV4ezQxUEXmyh2rUlz7yNmVfMmR
         peDrmHVmd/5344OV0kjhywyQKOLUWQ6nnufKIe1Ao6Yo47c3EwBoYYtok0voNJAKCedw
         1bZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ApTdG6ikp1M9IaHphmI8gleAX/kAyXVWdtj1pUCiDTsTGBGP0BP7HksNbUntgBbQwXy7Jg7v+M5PPqOHokA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZVXV9NJLAHdT9nwrlkGQXbRSZ//qVp7eR9ca1zRbOqGRsNRjK
	aCBOXnItcioCyAbbqRwX7/jnALpNisA45+0XpDNiklGhs1aEFRug+IVtRC6EYEvZ5H/vljA0kuL
	2yRNGK24fZzNoU9hTICP46R3p+9vWTPIMD/d7yw==
X-Google-Smtp-Source: AGHT+IH6BXN+34x6/Q4FZwz5j6uquVhYmRBikZ0QKoU5eshCI12u7ivTDuCHpv6wXsxYB2wLgvjIZwpib6ufggFyI1Y=
X-Received: by 2002:a05:6102:3707:b0:4a5:c0e2:c42d with SMTP id
 ada2fe7eead31-4a8cfb45762mr7377334137.8.1730144803771; Mon, 28 Oct 2024
 12:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 29 Oct 2024 01:16:32 +0530
Message-ID: <CA+G9fYt0pqM_f-uiK=xH0RWrhfABdjy743yyxu4CLtb+kkS6-w@mail.gmail.com>
Subject: kselftest:arm64/FVP: arm64_check_buffer_fill - failed on Linux next-20241025
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Andre Przywara <andre.przywara@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Aishwarya TCV <Aishwarya.TCV@arm.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following kselftest arm64 and FVP failed with Linux next-20241025 on
  - Qemu-arm64
  - FVP

running Linux next-20241025 kernel.

First seen on next-20241025
  Good: next-20241024
  BAD:  next-20241025

 kselftest-arm64, FVP
    * arm64_check_buffer_fill
    * arm64_check_mmap_options
    * arm64_check_child_memory

Anyone have seen these failures ?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
----------
# selftests: arm64: check_buffer_fill
# 1..20
# ok 1 Check buffer correctness by byte with sync err mode and mmap memory
# ok 2 Check buffer correctness by byte with async err mode and mmap memory
# ok 3 Check buffer correctness by byte with sync err mode and
mmap/mprotect memory
# ok 4 Check buffer correctness by byte with async err mode and
mmap/mprotect memory
# ok 5 Check buffer write underflow by byte with sync mode and mmap memory
# ok 6 Check buffer write underflow by byte with async mode and mmap memory
# ok 7 Check buffer write underflow by byte with tag check fault
ignore and mmap memory
# ok 8 Check buffer write underflow by byte with sync mode and mmap memory
# ok 9 Check buffer write underflow by byte with async mode and mmap memory
# ok 10 Check buffer write underflow by byte with tag check fault
ignore and mmap memory
# ok 11 Check buffer write overflow by byte with sync mode and mmap memory
# ok 12 Check buffer write overflow by byte with async mode and mmap memory
# ok 13 Check buffer write overflow by byte with tag fault ignore mode
and mmap memory
# ok 14 Check buffer write correctness by block with sync mode and mmap memory
# ok 15 Check buffer write correctness by block with async mode and mmap memory
# ok 16 Check buffer write correctness by block with tag fault ignore
and mmap memory
# # FAIL: mmap allocation
# # FAIL: memory allocation
# not ok 17 Check initial tags with private mapping, sync error mode
and mmap memory
# ok 18 Check initial tags with private mapping, sync error mode and
mmap/mprotect memory
# # FAIL: mmap allocation
# # FAIL: memory allocation
# not ok 19 Check initial tags with shared mapping, sync error mode
and mmap memory
# ok 20 Check initial tags with shared mapping, sync error mode and
mmap/mprotect memory
# # Totals: pass:18 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 21 selftests: arm64: check_buffer_fill # exit=1
# timeout set to 45
# selftests: arm64: check_child_memory
# 1..12
# ok 1 Check child anonymous memory with private mapping, precise mode
and mmap memory
# ok 2 Check child anonymous memory with shared mapping, precise mode
and mmap memory
# ok 3 Check child anonymous memory with private mapping, imprecise
mode and mmap memory
# ok 4 Check child anonymous memory with shared mapping, imprecise
mode and mmap memory
# ok 5 Check child anonymous memory with private mapping, precise mode
and mmap/mprotect memory
# ok 6 Check child anonymous memory with shared mapping, precise mode
and mmap/mprotect memory
# # FAIL: mmap allocation
# # FAIL: memory allocation
# not ok 7 Check child file memory with private mapping, precise mode
and mmap memory
# # FAIL: mmap allocation
# # FAIL: memory allocation
# not ok 8 Check child file memory with shared mapping, precise mode
and mmap memory
# ok 9 Check child file memory with private mapping, imprecise mode
and mmap memory
# ok 10 Check child file memory with shared mapping, imprecise mode
and mmap memory
# ok 11 Check child file memory with private mapping, precise mode and
mmap/mprotect memory
# ok 12 Check child file memory with shared mapping, precise mode and
mmap/mprotect memory
# # Totals: pass:10 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 22 selftests: arm64: check_child_memory # exit=1

boot Log links,
--------
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241028/testrun/25586532/suite/kselftest-arm64/test/arm64_check_buffer_fill/log
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241028/testrun/25586576/suite/kselftest-arm64/test/arm64_check_mmap_options/log


Test results history:
----------
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241028/testrun/25586532/suite/kselftest-arm64/test/arm64_check_buffer_fill/history/
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241028/testrun/25586532/suite/kselftest-arm64/test/arm64_check_mmap_options/history/

metadata:
----
  git describe: next-20241028
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: dec9255a128e19c5fcc3bdb18175d78094cc624d
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2o3tMqzOtHXYQjlvfR5tnTcVMe5/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2o3tMqzOtHXYQjlvfR5tnTcVMe5/
  toolchain: gcc-13

Steps to reproduce:
---------
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2o3tON5kNijMOtxu3bD6Cg6QFYC/reproducer
- https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2o3tON5kNijMOtxu3bD6Cg6QFYC/tux_plan

--
Linaro LKFT
https://lkft.linaro.org

