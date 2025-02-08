Return-Path: <linux-kselftest+bounces-26118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 021B5A2D96C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 23:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036C11887E4C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 22:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D91244194;
	Sat,  8 Feb 2025 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8jAUkS2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0A24418E;
	Sat,  8 Feb 2025 22:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739055165; cv=none; b=APCOMx9AcBoMuori0Hls48P+IB7Sv8l/zYNATUvPRhhL4ENBx2/ty9kHNW485SpaRa1iABRH3MPmzXvy6cz/PGkSeYyMp5LiEuRnP6ZEfuxqsUpgHg7AU7zB4pidT9K5YTrjz8GfEAZtvdEpVH+xMEyizO4spIHgRj9eSTHxDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739055165; c=relaxed/simple;
	bh=+V2DO/v/Rg0iRMpNhmXPlkc6DKQjfJ/2+v6OBma+Sdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fbWIUDyjx6WTT2ySTcjFz2v9SvvfLPXf7t4AJaUYBW5vgKWGzBu37a31WujXTi5ykyLOYTHxyfF+zYtm+RZi7i2lMBWl8pAM5VqpgWz5wD+z61IWhLAxiwC/zVP3rPphFLdLNCspXdaBD31Xcrbs0e5ppTC3ZD44mi3/cPlUIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8jAUkS2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46fee2b9c7aso27972441cf.2;
        Sat, 08 Feb 2025 14:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739055162; x=1739659962; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiwq+pdt/QT32WgaSaqVbKDmKdsYjXMio3uaPJqsb8I=;
        b=V8jAUkS2U38F3Lqo3S9yLUwvaSk2VtLxOgt1r4uEj9gRLiUosKxAFWRG/60mI1B/6X
         Uli0rNUzfjGgoPjLf3sdiXA44lueMi69ktG7OG51jE5FizU4fBJKXsf/LPXLQA8zbc7k
         q57qySrLemJLmofLVIT3R90VyFs3LxKHyMLCOpOBBAA0CkjVJAXQ7DDpRdyLDfJ9FW70
         goaZBwyXNlSN7DO0685vOUmfch2D6b9kDDtO6rsVX4e1V3pt/3s9PFrxT52z6GCh32g+
         ArvGgndSHCSwrSaxkimyoFTexZxx7VA5EUfqFHz+IKImyXzZawvyQZFW8bxOdgpZzqpB
         hj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739055162; x=1739659962;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiwq+pdt/QT32WgaSaqVbKDmKdsYjXMio3uaPJqsb8I=;
        b=cj2ovkmIg82EXSDy8IgTAOGt4NNxbI/H0MVn9IFpFLbJ8GxBujxr8zBWRGy9Fhw6IP
         Y72jiJao/F/mgm+XqISFo3S5J5vo1/N1Fx5PFFvaVwHeqozFOdLNUveUO7/n/xD9WDP5
         wc7l/vy/hNQchVYz8OR0AO9+dxw85usfBh+cZJIVlHLjrl6loGH1hpls0QLfs5Xrcn7I
         R/NyptPMFDM18cIbMYD0mrluMStz2VMLKQwtxN9mjXyViJgKlyb08O03aAJb2WQnb/tL
         iPk4+Ka7YCQsJxJA3ailWZ64sNIeycr1DopWL+jIgbtD9nQc+zY1Wl7NcGFnupxnzRTe
         hmfg==
X-Forwarded-Encrypted: i=1; AJvYcCWurWVB5W/yoXWixgwnfYapfyT+5Ek8P8r2/JzjeoB0Z56w4ugP0U4546AF9S2hKvapRtxBy+TMsoutTcJuZfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyX+xIe76yIfOG6uXXPx8myCVmY4O1P50na7Fxc+ihBaZnnE8C
	rCx0IsfBNHnA96s1NIcy4v3FX9u/IQ7O2ms/J7auhCjzZL9KptZ+T6ligW7W
X-Gm-Gg: ASbGncuSaKPdYFWt0REKLfugH0Ui+A8bvmvaSsY5QKCkqm//Hzact02nK356fDT+doR
	Ml3WbLcAE/nz3vxIA4WSAB3PATXmMwh/XOBy4A0mb680Ol3fLjlzQyt47Rg4c3ys10OIu4N5ahZ
	Q9yH/NEORCKsYqN2p4/mZdK0+yktg+nt6p0/+9YaKdqy6BIhhOG4s1sM/jJFzVyl2xR4uwaP5Md
	RYH0gHFs5rIEe2jKkqrixc4j3gHInPc6x7U086Lf2tbO3D3djukGsf0s4MjMSP0Cwj4t3LkSQJ9
	hQ5HCW8cUUhSMPM5EcSJLNsJlIlnJG4TbBjsDKgcmaM=
X-Google-Smtp-Source: AGHT+IF9x/UVPlnlzagsmolAT1pyOw7ZFMx5hVbLojcHERHZQClpLOUgQQK/GQc5uaChpmF3X4YKWA==
X-Received: by 2002:a05:622a:4c0e:b0:467:681c:425f with SMTP id d75a77b69052e-471679945a9mr145138131cf.4.1739055162322;
        Sat, 08 Feb 2025 14:52:42 -0800 (PST)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:15f6:96e9:3308:934a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4718c20a23esm310731cf.4.2025.02.08.14.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 14:52:41 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/2] lib/prime_numbers: convert self-test to KUnit
Date: Sat, 08 Feb 2025 17:52:28 -0500
Message-Id: <20250208-prime_numbers-kunit-convert-v3-0-8ffd5816d8dc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACzgp2cC/43NSw6CMBSF4a2Yjq3pAyk4ch/GGCgXuNG2pIVGQ
 9i7hREj4/A/g+/MJIBHCORymImHiAGdTSGPB6L7ynZAsUlNBBNnJpiig0cDDzuZGnygz8niSLW
 zEfxIFddlLTVveJORJAweWnxv+u2euscwOv/ZziJf1//cyCmjOctVK2qlFZfXzlT4OmlnyOpGs
 beK35ZIVpFLzsssU8CyvbUsyxd7SQaZEgEAAA==
X-Change-ID: 20250207-prime_numbers-kunit-convert-71c9b3c1d1d4
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is a clear example of a unit test.

I tested this using:

$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 math-prime_numbers

On success:
; [08:51:41] ============== math-prime_numbers (1 subtest) ==============
; [08:51:41] [PASSED] prime_numbers_test
; [08:51:41] =============== [PASSED] math-prime_numbers ================
; [08:51:41] ============================================================
; [08:51:41] Testing complete. Ran 1 tests: passed: 1

On failure:
; [08:50:19] ============== math-prime_numbers (1 subtest) ==============
; [08:50:19]     # prime_numbers_test: ASSERTION FAILED at lib/math/tests/prime_numbers_kunit.c:28
; [08:50:19]     Expected slow == fast, but
; [08:50:19]         slow == 0 (0x0)
; [08:50:19]         fast == 1 (0x1)
; [08:50:19] is-prime(2)
; [08:50:19] [FAILED] prime_numbers_test
; [08:50:19] # module: prime_numbers_kunit
; [08:50:19] # math-prime_numbers: primes.{last=61, .sz=64, .primes[]=...x28208a20a08a28ac} = 2-3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61
; [08:50:19] =============== [FAILED] math-prime_numbers ================
; [08:50:19] ============================================================
; [08:50:19] Testing complete. Ran 1 tests: failed: 1

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Remove `selftest_max` again; snuck into v2.
- Restore `#include <linux/slab.h>`.
- Sending v3 early because kernel test robot is sad.
- Link to v2: https://lore.kernel.org/r/20250208-prime_numbers-kunit-convert-v2-0-863119447e04@gmail.com

Changes in v2:
- Keep all the details hidden in prime_numbers.c; expose `with_primes`
  for debug logging in the test. (David Gow)
- Link to v1: https://lore.kernel.org/r/20250207-prime_numbers-kunit-convert-v1-0-6067f2b7c713@gmail.com

---
Tamir Duberstein (2):
      lib/math: Hook up tests/Makefile
      lib/prime_numbers: convert self-test to KUnit

 lib/Kconfig.debug                            | 14 +++++
 lib/math/Makefile                            |  4 +-
 lib/math/prime_numbers.c                     | 76 ++++------------------------
 lib/math/prime_numbers_private.h             | 17 +++++++
 lib/math/tests/Makefile                      |  1 +
 lib/math/tests/prime_numbers_kunit.c         | 59 +++++++++++++++++++++
 tools/testing/selftests/lib/config           |  1 -
 tools/testing/selftests/lib/prime_numbers.sh |  4 --
 8 files changed, 102 insertions(+), 74 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250207-prime_numbers-kunit-convert-71c9b3c1d1d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


