Return-Path: <linux-kselftest+bounces-39159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9A3B2919D
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 07:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC082A1BAA
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 05:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1D31A0703;
	Sun, 17 Aug 2025 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfB6yRGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6D1581EE;
	Sun, 17 Aug 2025 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755408197; cv=none; b=f+NyKPq9weBs+/JVjXqYT9VOvhbtPBltzmBr2Ks5Hx0pSjEYmhNhud1vGXMEeZxSMHHXeWY1pkQmBoc4iFfGJxGnHeoo2ZvrSD9qri8RHSBVIdDFoaenU7ScBZ8MLIfMWBhBg0KeBrdpa9xLKmqz/jAvG8cmtJ6k3btA7qCSvsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755408197; c=relaxed/simple;
	bh=2Krz1q4dLXwXDvNiRnwBsAnhUvKZtc4rAuQ9af6bRPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prxThdV5LwXt7c9iBRh/kK/bFutoOX8Quy/LFTnxF3o/HRQqQBENUi9jIqsQ5DR48d719WF8VTm5CW+gBe5DFuAmCMW81IVarxNdemJrZkOjrop29Mx0WGVZr0zo2v3dol0U/tFVfl4ajfZYz9DCqwFXpAah+6BRxp0MZ/mRwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfB6yRGM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e39ec6f52so2783309b3a.1;
        Sat, 16 Aug 2025 22:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755408195; x=1756012995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kp6ZpPi7OjGlmUly9kUQqc77MGv9H1CyM6s09oVZLEQ=;
        b=VfB6yRGMp6IFhjjo/g5whuED5+9spRqoy92lOhfit/JPZkK8yhKaJdTBoDeqS5fNb+
         Qjg4pOYYwCpHb4z4r6BaX0X/OKtkBvqiKvcwm7omAaTPNZKOYl5Ls0sWyX4I4eNSqIYH
         Y7iFHBYdy7fLVqjiicnepb6pNxMNg4YOD12tumGd4bQmDchD9WRzYnpjrVE9LacFAQVS
         kUkVbqt7/quvwTmBq0UI2DyyzFH8vYaCTLHpUUY/mN6Sx5K7Fd/wBdPa1bIH/iF7T5kj
         C/IFlmR7X+jgJYmfCI3fxPaw+PLhApNT598gPY4K2J8Du3IhsQBGiPm/VzXnBSN/7MFZ
         aocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755408195; x=1756012995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp6ZpPi7OjGlmUly9kUQqc77MGv9H1CyM6s09oVZLEQ=;
        b=qnOQnP7SG8/+Je0xoT2h7RqCVUU3BW8yRXf/glVpDir/jVBxzP1COnkfpgzYCr1nWo
         w38TZs2MME/bgZWQMKYWWEAK0snLU6A33EX7i92+oE0LLeoBy9gDyD5llpfygWVxICpn
         +4KOb0aCTAdqGWoI1KRmGxEFyaqX6bjQe/QQO5OPWbip6Kg0q0NxIlj9fZ3VN94zVFZ3
         A42uHKM3ijcyldUoJ5N8IuyDqaTgMe4oJxWVfmmCr5JzRgGxaGrCLEQEm3fs96Mr7a+E
         bQBcIXW7u/xwUPCYS141lpwMkAO9s7XvJJJV+X9vEeuSLUzyFj64pjtv+xMFbfz2pg3l
         ffHA==
X-Forwarded-Encrypted: i=1; AJvYcCWgf+KntIQfNuRe/vFRl64FLUdeVxPOLS5CrJYp+4e2/lhAEmk0Af7/zgtBVFy5hy8FllQ3cDhcMaiVOvnvhDTc@vger.kernel.org, AJvYcCXw+k5oqpjSo2ltogXhA0CdQnWmEHVSWTSI+0Lr0WmEwv2f3riJlk+Z/9DLp1IAj0go7Bnp/+YUK1eJMsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HsZ78ACGw6x4WXJUnNkJdhMMGTX0Wr+g8qbf+mGBVPwYodql
	orQW+bB3LjAPk0G2b9tv7aGWtv3yLPrWdioS3F+BUVrfCtmuDkDvm+Y5
X-Gm-Gg: ASbGncuBkWKm3BtPeeHpmKjh3tn4W+1cBEVMGwAMMAVIIggyxzjlxxVtZ7yKotKL9sE
	kKaDoYJpDSbbMHXQUgXLEIUjAreQmjWjOEPoFakrFpf2CE26TrIPlwPbyKP9w7Q2HSMPS8l75iS
	8PUGXXIDDzQvilsTdQWYycRyJC5X/5GPoyatn1ATmSx10Oqt+y/ojf0wdTK/RVP7tyEtg9opeqP
	zNXH4wkWt9rQHuckF4vR1x+IDcb3BMPfTNTkowjNYUn8yoYGdQ4Cvo5KV6A864YkAgvlZi6uKYV
	Rb0eArLeKdiIcdrjA8FFPLei/nej/MfopIcHA6+0whjOp7JKF8sPsIigSuDRsgiFMmvpbSQiB31
	wzvQz8Ex+ztJF/UUxH569nAYjeb8Akc0uEpBjv9FoWYbRMBgeF/na
X-Google-Smtp-Source: AGHT+IFVbgdeT/QfwgQykch+QhrWI4zgFHqFV8jB8otfCty8P30FG2RsqWRDOf9aMTlgNZpyP1+N3A==
X-Received: by 2002:a05:6a00:3cd5:b0:769:93fb:210a with SMTP id d2e1a72fcca58-76e4484dee1mr10276988b3a.21.1755408195517;
        Sat, 16 Aug 2025 22:23:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ad1b:5a79:43f0:e247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4556670csm4405906b3a.79.2025.08.16.22.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 22:23:15 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH 0/3] kselftest/arm64: Cleanups and readability fixes
Date: Sat, 16 Aug 2025 22:22:44 -0700
Message-Id: <20250817052244.8822-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Hi all,

This small series makes cosmetic style cleanups in the arm64 kselftests
to improve readability and suppress checkpatch warnings. These changes
are purely cosmetic and do not affect functionality.

Changes in this series:
  * Suppress unnecessary checkpatch warning in a comment
  * Add parentheses around sizeof for clarity
  * Remove redundant blank line

---

Vivek Yadav (3):
  kselftest/arm64: Remove extra blank line
  kselftest/arm64: Supress warning and improve readability
  kselftest/arm64: Add parentheses around sizeof for clarity

 tools/testing/selftests/arm64/abi/hwcap.c       | 1 -
 tools/testing/selftests/arm64/bti/assembler.h   | 1 -
 tools/testing/selftests/arm64/fp/fp-ptrace.c    | 1 -
 tools/testing/selftests/arm64/fp/fp-stress.c    | 4 ++--
 tools/testing/selftests/arm64/fp/sve-ptrace.c   | 2 +-
 tools/testing/selftests/arm64/fp/vec-syscfg.c   | 1 -
 tools/testing/selftests/arm64/fp/zt-ptrace.c    | 1 -
 tools/testing/selftests/arm64/gcs/gcs-locking.c | 1 -
 8 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.25.1


