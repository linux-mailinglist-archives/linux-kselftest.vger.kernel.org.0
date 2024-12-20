Return-Path: <linux-kselftest+bounces-23701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4088D9F9A9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6DF7A10A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 19:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496B219A8A;
	Fri, 20 Dec 2024 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHGHxAfW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13319DF61
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723432; cv=none; b=bVm4BaKJ3+ZSg5fA2w/W2nx43QtN3zGu1syJRjkF8URmtMgdQ4lTRDjr/vjxq7ZMtRQECKQOw9QO+UoJgE54WLBefD6faZffr+f9cgjOQ4lEbFIKTmVcsyjSq6o3S7q9b0uEga6A8yKDfS2OevI2r0pFr2kpqEcOoFgPMI3PLlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723432; c=relaxed/simple;
	bh=Q8o/ve5UW+qa2Kmh3gGhDBWeM2IfdQnfh6HVnlQxCmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NAMLtB0xOFhPUbY2optr5amBp45ReWUu3R2ksbNU35Efkj6EnoBm7ha8xF1rteya1OsRYNSAeEsDonNVDf1WB3as/ngBDapzQjvk0YeksM0oRTW2L58xOfTgG4+WUOiPEeNcsHOjA/DuMBisFgVfNceYy5ZDbucvzAEjzyQ10Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHGHxAfW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fcf59a41ddso1450219a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 11:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734723430; x=1735328230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UhoMLFuvi2fGffqLSfLMI3GmIvvFsvNMsa4jT6vxBYU=;
        b=VHGHxAfWV+esVdMNYTwmZ+rco0TE/N0pkI0EfzbSkWfzsQIpS9x7I3tQRbQlsEc918
         WDWFiS6fLe45PIFhUKo3rdGSVxMvO+4w5+CB+qCNuyUSc91BGHw6sEOCZBoGB8GOJqe/
         etWrN3NS9xjQK6iKsyYeH69piC/GsgVbZk7Hjmz3JV9FLS6sdlQ91utsgygXZ+G7diI+
         kCgj7YwKdnj0U9e2AN6p0aRWdHIHyh+/FaBS5PC8Fdxe9do2nR6fMLmBakDI2V/VlZKE
         TkXATaYfkAXZvdEAAqvRnZyQwdzl6juInoQC8XOZtoU5Fl4oWbLqN6nSYqyZNiLoyJKp
         R3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734723430; x=1735328230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhoMLFuvi2fGffqLSfLMI3GmIvvFsvNMsa4jT6vxBYU=;
        b=PPfBIT0AC6xcBMxNoHwwyh3aR7OlYSXGAej+2ahfJqrMUDxEHTBrwMp1HWHAH89iPY
         S50S4uG7zPISD7oMhfSWYcZSPwqUoFYQ6E+cVymsO9UofErG/abN+PWJobkG+X69tgR9
         jPpLdbvdDD6QbbR0qrpe9iG8RSsO/QyxSly3qIc4dbgvEW834K1UGePe0RLFsVZbWMjU
         Gop2rMgeYIkSbfPuz2T9tL4hi9dQgGC7+jNhKICEAC79aE5LPdRQzG0eIsJpn1ufdaRU
         +KZdmowl013NHTTWwNzNW5FHej9lAMmZv3TsjTVyq87YYpVYOFozdyyy/yBFGoFssWma
         enuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVAlddseok4pZLVmP1bTfgS+38FEZusIf7rY8dwVpHNU7Ki+jMRA2wqWdQgSnsWlfwAeV9hXTtyN0lqipze+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wPbksExdCHEvdav42mkZ/eS3QfQ7hCwkFj6TqLiUe8z95oUV
	4JQSRT7fc3LtdFaVDfoehDvBC9ogVO5pTi1CAnV1jxOfV74uGCLw
X-Gm-Gg: ASbGncuu+xOcdLZ62BdEumutcjLs1ST6cj5rnRl6lOmVmYIHCrafqioAiI/rH1vkqY1
	pTNNtlppg3hEfiuUYEeV8TtpKw28N1eE6XVF7/L0owqwwPRV3E7aC/5gehicF8l8rSq/k7A3MB8
	SEcQJCzAvTTj4ssdBUnEqvV0J0Wh0rZj7+w3PTyz8Ac9LOyTU+F0ARWjr1HuQs5LW094JLll+dH
	AZxRYIXoxB9H7STBaRohV4sEYZuISoBad+8tvg/2a+DHyZW5bShkKnmmiyNSD7sxli5t63g13++
	PLQm1zmq8tI=
X-Google-Smtp-Source: AGHT+IHNVeYPKWZ/iCd0SJbDzP1xrCoKUPWfp9qXbpJ4jTQGIBkua/crAifUUCjm1btfUaKCu7sY5g==
X-Received: by 2002:a17:90a:d00f:b0:2ee:c9b6:4c42 with SMTP id 98e67ed59e1d1-2f452e214b8mr6661990a91.16.1734723429973;
        Fri, 20 Dec 2024 11:37:09 -0800 (PST)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477ef3d9sm3680917a91.26.2024.12.20.11.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:37:09 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: simeddon@gmail.com,
	shuah@kernel.org
Cc: skhan@linuxfoundation.org,
	pmladek@suse.com,
	mbenes@suse.cz,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] update kselftest framework to check for required configs
Date: Sat, 21 Dec 2024 01:05:34 +0530
Message-Id: <20241220193536.13781-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kselftests does not have a generalised mechanism to skip compilation
and run tests when required kernel configuration options are disabled.

This patch series adresses this issue by checking whether all required configs
from selftest/<test>/config are enabled in the current kernel

Siddharth Menon (2):
  selftests: Introduce script to validate required configs
  selftests/lib.mk: Introduce check to validate required configs

 tools/testing/selftests/lib.mk    |  11 ++-
 tools/testing/selftests/mktest.pl | 138 ++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/lib.mk
 create mode 100755 tools/testing/selftests/mktest.pl

-- 
2.39.5


