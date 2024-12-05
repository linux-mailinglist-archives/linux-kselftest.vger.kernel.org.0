Return-Path: <linux-kselftest+bounces-22863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3AE9E5486
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 12:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1881692B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA922211700;
	Thu,  5 Dec 2024 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIIMSI4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171D20D518;
	Thu,  5 Dec 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399342; cv=none; b=r18kasNuogaI5XmpDWAFQarF324ZrteLPnZRrgrkAmQZ08K6jf/PugWRp3GPm7foMLIoyfMQm60J27KqTWCqCTvuaUmpy8LRYpATYXul/46Bu/ybviUeoq/kbxJAYqJIPMwXqEVvmCcViXszb09123+ZvPBzq/XNgBIIlp9yYt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399342; c=relaxed/simple;
	bh=ry1Q9lVyvUUKX2WBlH1Bo/LYaeI5/egRWUooe5SRBEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofYiksYthcGAb7FyeVPRKX0B+VPTPB1RxMqoKaxeWrI3KSQQ8ZEjwBTMZ6pmDKiEpujIjGaKv9ZMyJxhId/ESI6I7JCgxYwvG3pCx8BSmB92yJjFVmxnm1PweFScxVm+hBBUnKb4DJsKMisQdM98aL5JfaXw0MYG4V7G/Qljxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIIMSI4k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2155e9dcbe7so6846595ad.3;
        Thu, 05 Dec 2024 03:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733399340; x=1734004140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4218+LaUPkk+3Xk7sYgTNuYCra7GTA77M4dYAwFmiyo=;
        b=hIIMSI4kVrBcGa/SuSATx7rxxgtZjG1yYA9zNkfQHIcUP9gcXgesewrfw6/PFwUIiK
         QTbAtj7FqqcM0KRea2OQVOEBsHpSc7tn6zwN9LGLGrcE1jlqUu2CAPVmyw2uBW+hh7Gm
         dHwiZtUhFDzHBRngXMrnBo11Ba0XEIRQMHMVcKZm1+7G8c2kWLD5hHG43WfqtcG1lWgI
         J/RHQl4Ew/pAsG+XzmWMf3J/gwLBP4K3oicpbZUF2TAHKSyBuwQkUkHw/7wEC/IDu/Rd
         22Qyjljp1m7a9hgDziYn4jlPHnpLaqskJbkgP/XzK2FfewRCS4yykTJKjfinOFieotXs
         n4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733399340; x=1734004140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4218+LaUPkk+3Xk7sYgTNuYCra7GTA77M4dYAwFmiyo=;
        b=Yy0V5shrJ6DvKa0fO6Kexvl1wXgx8f42lAqOtrBOr/f9+Qx835ENOSUPkQqzxQ5toU
         UR3aeiYGDaJPTNj5rK6Kr14GLNAULL5Wyf0pnrgwXyrz75EyvOjQX64V/L2qnJjRylC3
         YC3gu9IAMf7Fgh5KKSiNfNZ/+eWyDiSto4mM9umH93Uu2z6BqukdBmZ0pk9SgQYVNevx
         ZpufN7EIb2OoTD8XP2y8ppIYqlsEPgiv3ircVNkvHQra2GvZKO4G1eyEHiRYlrERMsOW
         HEP71qpfsKSPs5jeY7QgmwVX0rUPpLmEOL33Ro2mdMqTzK+FSy/TMkbI/G0U6X97dh8D
         w6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz9CMMUT1dIPpJqaGOJgsSk0cqEmv8OTAHHOeTBzgcOfW+PlBaVf5zBB0/v4Dm4tOj0FMXoKbYe9YmH3uJYkU=@vger.kernel.org, AJvYcCWZ32e67Q8MnSoCsuFFpDPqGMCHQmuqBkBZ41IOVC+6TQ63Gwm+TLSf1UXkbR7SDxU9Slbo/YrHyOdq9kujrA==@vger.kernel.org, AJvYcCXqefbFK+clbaUZ2H9FW+Nq2tzT0S/jpA7Z6XxD1CRG5t+PWtBPPdwYdAKVvSXK0J0wH4kIJIHSyG3J@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5A9p1vJDG6vybUtNY16ODPdsM7iutV7RVQfQtEhtFmJWXJAk
	9Oekd1KEPBTaHfgPrMjDZOUHe0IiSUuf/o5y4X32AoSPN+i9c5Ci
X-Gm-Gg: ASbGnctLsXaTMA5MomHSpscIEKcOuUOK+DtvLrUAwl1nWIkHNoqF5b3SzR1bgU5xQM5
	erL8bpoyta5ByImN98OA8fR0peOgNnsj3webHEosli+arx6SK176KV/Xs7fLJ3/puU8g7J91u3A
	bhQGpt0TFMEmKyrnOX+a6nmKVwqF/V8XBHf8evTIZICTN5JYwNqB+p7KPidaugUT8gxgCtelMLm
	QpTdMXQvv+ONskB4PtuI2a4LdoOJUUR1bWa1lsvxnpvRBAjSDPORYvuZsZr2z9grjq9r4WDKYk=
X-Google-Smtp-Source: AGHT+IHWN6Tn6tLa6h9VbDwRImkloqTz94E7obvsGuFMsOwcr5HZUuiLpglqYynL3HkgfzpYqNAe8w==
X-Received: by 2002:a17:903:190:b0:215:89a9:bd0a with SMTP id d9443c01a7336-215bd10d5femr137528305ad.24.1733399340382;
        Thu, 05 Dec 2024 03:49:00 -0800 (PST)
Received: from BiscuitBobby.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e41e52sm10965545ad.3.2024.12.05.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:49:00 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: simeddon@gmail.com,
	corbet@lwn.net,
	jikos@kernel.org,
	jpoimboe@kernel.org,
	mbenes@suse.cz,
	pmladek@suse.com,
	shuah@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH 0/3] kselftest framework to introduce TEST_CONFIG_DEPS
Date: Thu,  5 Dec 2024 17:17:54 +0530
Message-Id: <20241205114757.5916-1-simeddon@gmail.com>
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

This patch series addresses this limitation by introducing a new flag, 
'TEST_CONFIG_DEPS' in lib.mk, along with corresponding updates to the 
documentation. 
The selftests/livepatch/Makefile has been updated to utilize TEST_CONFIG_DEPS.

Siddharth Menon (3):
  docs/kselftests: Explain the usage of TEST_CONFIG_DEPS
  selftests/lib.mk: Introduce check to validate required configs
  selftests/livepatch: Check if required config options are enabled

 Documentation/dev-tools/kselftest.rst      |  3 +++
 tools/testing/selftests/lib.mk             | 18 ++++++++++++++++--
 tools/testing/selftests/livepatch/Makefile |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.39.5


