Return-Path: <linux-kselftest+bounces-15294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF9951510
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 09:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327931F219D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987413A41F;
	Wed, 14 Aug 2024 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mM4rHg8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0A139D12
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619673; cv=none; b=RoQvfafHzMwOJcqFe6cQrSyBROKXuhCLvEazB+XHSl90dlGXz2zLILWy6/jO0MXFWkk6KhpLs3DrP1IcNGIID62KnAQIZItLfjsW569FXJ1ElnwXOolDuofwfj/7Gk7ZP+ipxtDTfeDFCdLSgzE1UYRwkSvIDc31NQGegitl+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619673; c=relaxed/simple;
	bh=brPAjMdAxyVmTtvLRIgAXuSdAuoKek9fo+ninmBAJ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVxnOKbTuGVvOlsOsXsa2TfWUAV9cIlHwREvnMyPSf0S/a3C5R/91CCKJBdRVQ4jKpb0g2SLJzeKHL2AX9jqiM1yu5pOmrUm9R71qAVmuuUHqIPtFKwogerfJheplp0vfWYlYl1S79DaV8/PlBZwuyJ7VlopH8pQSf44dAM4Wqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mM4rHg8L; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-260e12aac26so3758364fac.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2024 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723619670; x=1724224470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwReknVIrDSfw0EPNLA7Z9rOAS1qkGFQa9Wg0CMwvkc=;
        b=mM4rHg8LBJJ0dGlbU3RSKAYUnHCOdik2y0Z6E3RYL0yuzsIV/A+db3cruBzjJPzVPS
         tMv+jQdlxhxvmHKbjcSjbsfXkw0pdHOrJnjNyKw/6pYHQJnukWVIsdJAOeqrMooPemXZ
         GdUmJgqRkQddJ0O0bw0b2KAi2+gqpGNQAZs2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723619670; x=1724224470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwReknVIrDSfw0EPNLA7Z9rOAS1qkGFQa9Wg0CMwvkc=;
        b=O7exI9NK0+y9X9D52aUMTlnLuCQfwwLwGV+lVEu0V1Uj9Is35FbQ+CwyeoO3YaVNcy
         Cg5m9judKRrwc+qA5OgKcWeV3Z4SbwDqaawmRTceLQotMt0U/k17twZeZ245FlL2YdfA
         wiosIj4fCypCwajCnUb7Xj2RydMAIgGkEDhV0DLuLFYzFC2NmUFwTMLqJMniZGRALq3y
         foSj2/rYTYHwtr/UUHtineJR9R9Si0DcztMvcA/d/IsgMrqVADocArFqpi6P9qWTxvQs
         Sh3B9s54lszFdX69RiCTKCVsvs0PIwDoD41ObZ+MkWOGHQmxknTz0nxOEJOHtWXeCuzM
         E/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpU+bbj3O6YCav+GECxXHEBo2FfFcUndGKBTYYu2X2wfgpF2tUnMOXOzOxuz5pu/gATm0OKz89wvJbzsi1GC2AN82ic3N8Yhgl1uEhzL87
X-Gm-Message-State: AOJu0Ywe6WoqN26CSSgsyi4fMzIlVfFGe4GVIo+Rg3Lo5rI/d9x0TzS/
	yCYBESoIA/ovFovNQQNWc2HvrloLV+ufjK9qS6rkqCiMy+JKcxBlIo1OfpXlvw==
X-Google-Smtp-Source: AGHT+IHYwRGCLISGoy8hJhOKkAgqX6DtlBOZAVZZqhX4BMHm8h57bmHw97vihcaDfkE2jw2NCAP0Jw==
X-Received: by 2002:a05:6870:3508:b0:268:9642:aa08 with SMTP id 586e51a60fabf-26fe59da324mr1981775fac.10.1723619670385;
        Wed, 14 Aug 2024 00:14:30 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-710e5873ad4sm6962870b3a.15.2024.08.14.00.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 00:14:29 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	willy@infradead.org,
	torvalds@linux-foundation.org,
	Liam.Howlett@oracle.com,
	pedro.falcato@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	jeffxu@google.com,
	lorenzo.stoakes@oracle.com,
	mpe@ellerman.id.au,
	oliver.sang@intel.com,
	vbabka@suse.cz,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 0/2] mremap refactor: check src address for vma boundaries first.
Date: Wed, 14 Aug 2024 07:14:22 +0000
Message-ID: <20240814071424.2655666-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

mremap doesn't allow relocate, expand, shrink across VMA boundaries,
refactor the code to check src address range before doing anything on
the destination, i.e. destination won't be unmapped, if src address
failed the boundaries check.

This also allows us to remove can_modify_mm from mremap.c, since
the src address must be single VMA, can_modify_vma is used.

It is likely this will improve the performance on mremap, previously 
the code does sealing check using can_modify_mm for the src address range,
and the new code removed the loop (used by can_modify_mm).

In order to verify this patch doesn't regress on mremap, I added tests in
mseal_test, the test patch can be applied before mremap refactor patch or
checkin independently.

Also this patch doesn't change mseal's existing schematic: if sealing fail,
user can expect the src/dst address isn't updated. So this patch can be
applied regardless if we decided to go with current out-of-loop approach 
or in-loop approach currently in discussion.

Regarding the perf test report by stress-ng [1] title:
8be7258aad: stress-ng.pagemove.page_remaps_per_sec -4.4% regression

The test is using below for testing:
stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --pagemove 64

I can't repro this using ChromeOS, the pagemove test shows large value
of stddev and stderr, and can't reasonably refect the performance impact.

For example: I write a c program [2] to run the above pagemove test 10 times
and calculate the stddev, stderr, for 3 commits:

1> before mseal feature is added:
Ops/sec:
  Mean     : 3564.40
  Std Dev  : 2737.35 (76.80% of Mean)
  Std Err  : 865.63 (24.29% of Mean)

2> after mseal feature is added:
Ops/sec:
  Mean     : 2703.84
  Std Dev  : 2085.13 (77.12% of Mean)
  Std Err  : 659.38 (24.39% of Mean)

3> after current patch (mremap refactor)
Ops/sec:
  Mean     : 3603.67
  Std Dev  : 2422.22 (67.22% of Mean)
  Std Err  : 765.97 (21.26% of Mean)

The result shows 21%-24% stderr, this means whatever perf improvment/impact
there might be won't be measured correctly by this test.

This test machine has 32G memory,  Intel(R) Celeron(R) 7305, 5 CPU.
And I reboot the machine before each test, and take the first 10 runs with
run_stress_ng 10 

(I will run longer duration to see if test still shows large stdDev,StdErr)

[1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel.com/
[2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c


Jeff Xu (2):
  mseal:selftest mremap across VMA boundaries.
  mseal: refactor mremap to remove can_modify_mm

 mm/internal.h                           |  24 ++
 mm/mremap.c                             |  77 +++----
 mm/mseal.c                              |  17 --
 tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
 4 files changed, 353 insertions(+), 58 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


