Return-Path: <linux-kselftest+bounces-36353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D7AF5FBE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 19:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916F13AE176
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AFC301137;
	Wed,  2 Jul 2025 17:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R62Ug5R3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A791301129;
	Wed,  2 Jul 2025 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476638; cv=none; b=Ff4uk2qP94eHz3k8qbT7aJJgQi0I238P7HGwAlQlFXWz44mFy9F8cOTb1bZKU6eyTpNuZOgxkxzJgbvH/GexJPX+bO7Hz1NYEKGoMTz9F3tKKjb7yH0Baccs0E9yd6YniKbpWqULUlN94bkGRBsHZwLT6p6pQwWTE7r9+QvG5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476638; c=relaxed/simple;
	bh=eysMrIQ62IHEN1IrnTH/RbeWmSOOIErti0LPAnDPqpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nxwzu7E9rZCmjzBZgff2+oRsmH+hEPG9iaPkeqiWSMmpX7p5rjPwnCUtsUXNOVnUJzLdKfQFGE4aCzXl/Er2SYLYyyFwSEifDOH2jMUnd44NScVa41LfhQb1p1uxkwx5VQZU3xvCK+WA8mxmC3EFfM0jstze+Sm0sH7bRZFW8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R62Ug5R3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2352400344aso67813675ad.2;
        Wed, 02 Jul 2025 10:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476636; x=1752081436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wcCtm9f7p6jwuZ0do6mGaH16Y08BotVqwa8c/wAtMks=;
        b=R62Ug5R3deGOmRfvcuDHFYCnGHV6EGPratAvUvj+AW0YrjpBpZzeMDSmQcIhOw14Dk
         jf8E8zugoiyXeFTQCNBroCCO5eZzFErsF07JoqIrhj10GDWOx5itlMKqC1EetYLhsAy9
         QZt1g+fo+5u2ENjAovxJuq0gTWH0LVi9CkTbsh+NL61oJQlWqimGYJLv3/MkvGHeEp5S
         1vbEKpi/VkyxoZPZeVb44tV3utm9UD3ODm3MDPW48eNi4P2Mrr7+XcZmdl1d7+As6Cdk
         jPtC22Fm4P92xe1Ys1/e8QkacqnYaztAOWte9PmHZuPHYVQxs1rsLBlyLEGsfN35Fnma
         3gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476636; x=1752081436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcCtm9f7p6jwuZ0do6mGaH16Y08BotVqwa8c/wAtMks=;
        b=GVMLi80RRLeEeNN4vA0nG8zPu19rIKJ4uZxdvTTlE5qKbjqG2eO9X7J2JgG0ReD58v
         Vn+zvSRyVIrs2rmtlGMdmSnIHdUbmFPYp4hkbaxIzWnhmXEJnncHo2mhVnVeWXcM+fk7
         8vTZIaEdLaIKFSr1b9VFMFerljbzu0HIpE0dThpBh/WrA/Vs6oG4LPa9xCtBU6i667uA
         WEayHxt6HrPUmJagTNh6V8Dfma4DuhP7O9Tmkw0v7JInQaGTw6xjrDxsmuVXuY5RYqkl
         5TK/j32r0xlUDeXAxkEXMvj9oohswDqbOWGwZbJ+stB3+8UKkyr/7y7TKAZHtbt3PDRK
         s4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWWQr9//w3pKWztlvosKP2mRZL0004h+lv3wnhoEu4J2jpbsswiWGF4g3ikaQpJe/BafVNq758B9/Z6BIwzsNG1@vger.kernel.org, AJvYcCX9tZYSWVOYCEnYYR8pIfl3luHsphWYT0N+DS0ECLUHRz9s7aUAXK0pk+sQoS86n5v16d6S/JeOzG/1yRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxwupn8xRcgqkMnsu6FYryFWNXnrL5YLtP1D4VZepQ/ctk0caW
	E+woMiTAhHS8TWEFrz31h1ZuRdWvNyxjkWqLc4FD2188v6ACHohthuyf
X-Gm-Gg: ASbGnctvMiZDp3RIWnIptux2VDW7uaIGcu9levH5GYvCnuWH/VFBwPTnwdPtj1u14/y
	cn1LcIKSqr3bbC3J/jLffQr1yqldUzqCprnBhqL5ENRuugcPKb+XWH8YwWW/4wv4WDOMANhrJS9
	QgYSQTIJX1qu6LEFi7ufHKPzD0gOfVdc+l/7F962ZNfT5zoDscKNNz2BPvxY0EeMV3syycxjPTW
	Kt+ER7vBLxFGW0E/cub9Hrma8I1C+EuT42CXwGinh2+UZeP+JKO1aEYGOYaskI2VsxL26gMeLbh
	ECKUfHn57gVI/2SHM+jWQau73+wTcYnjeHZ5cx0G/QaPl0EoTvAKTzQb4GeOLkpi
X-Google-Smtp-Source: AGHT+IGoqFyrVCn6Y1nY8V1kqw3Ktn3Uz+x2Fn28RGNMIDJoOM2Rf1r7mTP7AxkaWXBBJ0Gt2fEGnw==
X-Received: by 2002:a17:903:1b67:b0:236:15b7:62e4 with SMTP id d9443c01a7336-23c6e511dc5mr70706755ad.38.1751476635539;
        Wed, 02 Jul 2025 10:17:15 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:a36d:9d50:6dc7:23e0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7a47sm138699745ad.166.2025.07.02.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:17:15 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: khan@linuxfoundation.org
Cc: kexec@lists.infradead.org,
	dwmw@amazon.co.uk,
	mingo@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2] selftests/kexec: fix test_kexec_jump build
Date: Wed,  2 Jul 2025 10:17:05 -0700
Message-ID: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test_kexec_jump program builds correctly when invoked from the top-level
selftests/Makefile, which explicitly sets the OUTPUT variable. However,
building directly in tools/testing/selftests/kexec fails with:

  make: *** No rule to make target '/test_kexec_jump', needed by 'test_kexec_jump.sh'.  Stop.

This failure occurs because the Makefile rule relies on $(OUTPUT), which is
undefined in direct builds.

Fix this by listing test_kexec_jump in TEST_GEN_PROGS, the standard way to
declare generated test binaries in the kselftest framework. This ensures the
binary is built regardless of invocation context and properly removed by
make clean.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
Changes in v2:
- Dropped the .gitignore addition, as it is already handled in [1]

[1] https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com


 tools/testing/selftests/kexec/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index e3000ccb9a5d..874cfdd3b75b 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -12,7 +12,7 @@ include ../../../scripts/Makefile.arch
 
 ifeq ($(IS_64_BIT)$(ARCH_PROCESSED),1x86)
 TEST_PROGS += test_kexec_jump.sh
-test_kexec_jump.sh: $(OUTPUT)/test_kexec_jump
+TEST_GEN_PROGS := test_kexec_jump
 endif
 
 include ../lib.mk
-- 
2.43.0


