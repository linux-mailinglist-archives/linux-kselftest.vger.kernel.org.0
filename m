Return-Path: <linux-kselftest+bounces-30943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCBDA8B5A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 11:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7372316BD86
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAC8235C01;
	Wed, 16 Apr 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DU8YlgBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A83235BE5
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796315; cv=none; b=OL8Dw5mFGaVh+04Mf6hYrMMIRXyFBU8CEWPGrp9nv/LHFsB+HImE3IMmmRAC7hcMIBMpKisOVbuLtLKJINnax1xOJbx2Kxj+n5NovSJbMLXJgui1FzvN9Zl9X07cstxdpZWf8ZCdABS1jw+AKrN/FDfsTJRTsE8wwO9Of0Wsrs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796315; c=relaxed/simple;
	bh=sOfxDqWJ9ymYnjosfevYHIkqWVeQgthQJLwgiCPonuo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qTyg537ukZjhHcVx4F5Jrqcw8FsHmsNSSAwCqOo93AzMMM2PeMWHVdDmM3NKlCy2RPLjHXbPVwuHw81U6l924cABFrV7X5qBPp/IasH6PjKN4B/mE92lIpLfT/dTznOLhEai/6ve2AVtvIQ0Z4WT0y5IphI2SeUgZfXhHgXI2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DU8YlgBp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af8e645a1d1so4498636a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744796313; x=1745401113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IoFQtZYiuwltMSwksmBWJecA1s6pjQa1QqN35UJ7mbY=;
        b=DU8YlgBps1gFrCTUXbDMickc9dR8VJrf7sqYW8wxuXwWGuItTswxX1YayUUf+eS8dH
         z96FkdsaCqQHBA7GDCOLWqhF85jZ3aS680DAqQDz0+nXoftZcc8ruAG2O1r/mNjKdHro
         yu58pZebT2vXtaPQKovdZJopc/vKvd5KU/FSYOhfU+0uudgwVgMjCz1ZpNqc97g4m8dR
         +ELZPKmXbnL96iNiNvoTMAlEqnJbF5meIFmghswu03SpylrP2oCIO0ddV4lVtdySOq4Q
         7eZ83xS9vIEpxbCbhacPYUcvd9z43EcxbvosajOmouovJnjXCPu3xxK/mdvFdWxTvvST
         hhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744796313; x=1745401113;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IoFQtZYiuwltMSwksmBWJecA1s6pjQa1QqN35UJ7mbY=;
        b=p8aZaSJHCoR/pI+7zuOYa/fQEtPFwKZ6ZZBVwOHZY+Sm5BTbwriON+m7bMbx5Qw7nd
         kfYxFSDup6YklEtO2gNtGoJ+hVXDlSyx8tGn8MFrs2IeJ+0m8XgZlSJjY5YP48EWiot5
         /xE3Ww63+aD9mF+ktAblVnvprvKG7Rqe21x24p1/ZSytUiLGKm/HDb8k8phv9EMh8r6O
         J6dI8c5Kamlu0l/zZx0TtbJVNYuQBelzHCOJLJYz/fIUnna4pXvdEbe/J6oQLGYVO6Mj
         46xwKvTQ0DWE0yon3i9Evx98i7bgTNKMwkPr38y0OxScjYIswvnmRotrbjXVQ8UAFMYq
         LcLw==
X-Forwarded-Encrypted: i=1; AJvYcCW61UMw7R8Js9AwbScF+n98pjx5Wacqq0vR5GNTzxYuHmAolfPkVXs6dpld9LuBgHN1B680gQGkIP+pRJmpkrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPn8xMS1jOXWb+jnUPha46qOOkaZvHiDwzThor8IL6xdKGof8+
	I/sMGkPJrV+6VKAvFyRyr+xGuAV8o+gj4Do0YpFeSft0DeNG99GtL3yYmlQQu7iUBssDLoHvlVW
	LTRyrO7EiQg==
X-Google-Smtp-Source: AGHT+IFFPxpgsM7gXnMG5DlNdF6g++0p05toIQ90I7Ym9i5+B/o9N3F0bIR/RIGYEq7KV/oxE4LDXF8+tzSAfQ==
X-Received: from pfbcz18.prod.google.com ([2002:aa7:9312:0:b0:730:90b2:dab])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d50d:b0:1f5:8d8f:27aa with SMTP id adf61e73a8af0-203b3e4fe8dmr1797837637.8.1744796313238;
 Wed, 16 Apr 2025 02:38:33 -0700 (PDT)
Date: Wed, 16 Apr 2025 17:38:25 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250416093826.1550040-1-davidgow@google.com>
Subject: [PATCH] kunit: qemu_configs: Disable faulting tests on 32-bit SPARC
From: David Gow <davidgow@google.com>
To: "=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The 32-bit sparc configuration (--arch sparc) crashes on
the kunit_fault_test. It's known that some architectures don't handle
deliberate segfaults in kernel mode well, so there's a config switch to
disable tests which rely upon it by default.

Use this for the sparc config, making sure the default config for it
passes.

Fixes: 87c9c1631788 ("kunit: tool: add support for QEMU")
Signed-off-by: David Gow <davidgow@google.com>
---

Another quick fix to the sparc qemu_config I noticed while testing [1].

---
 tools/testing/kunit/qemu_configs/sparc.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/kunit/qemu_configs/sparc.py b/tools/testing/kunit/qemu_configs/sparc.py
index 3131dd299a6e..2019550a1b69 100644
--- a/tools/testing/kunit/qemu_configs/sparc.py
+++ b/tools/testing/kunit/qemu_configs/sparc.py
@@ -2,6 +2,7 @@ from ..qemu_config import QemuArchParams
 
 QEMU_ARCH = QemuArchParams(linux_arch='sparc',
 			   kconfig='''
+CONFIG_KUNIT_FAULT_TEST=n
 CONFIG_SPARC32=y
 CONFIG_SERIAL_SUNZILOG=y
 CONFIG_SERIAL_SUNZILOG_CONSOLE=y
-- 
2.49.0.604.gff1f9ca942-goog


