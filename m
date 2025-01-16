Return-Path: <linux-kselftest+bounces-24674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC93A142D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFBE16979D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCA622FDF0;
	Thu, 16 Jan 2025 20:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmzRsrmc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9181727;
	Thu, 16 Jan 2025 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058209; cv=none; b=LZU2yPXotNhEn4yubp+OLBwN48MwEC4J9nk4yW+OwWQ22Vofvp0miRNvLomxnlYHZsSHRgaazTUfQyP8EB/JTRGPN/0M/uT2kMArwC1zWnlyXWbYJ6aLJOmnOAZgj9q6yLjyBG489Ej2S/Rt5NiJuHGThTeNSvF1GaooFUzDtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058209; c=relaxed/simple;
	bh=3jeNLYLo/KSC7eDuKaHoasuOc8Pjafw0PxocsRK/ZAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LpUEu7I7LPI0DZFeIO4kukxPEBfU42Y/CTtBtx0tRVntDt3Yur0RD97IqQnIk4zhAB6KDWV4ha7uavkJm94kCaB5p3z21GCLHIyxe73ShxX97lZLg6XmHkxEBX1X+GjAjsWdXzZITrMUgfenqUc8AdPsxiXJM4IXEDwGE2UQg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmzRsrmc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163dc5155fso25245265ad.0;
        Thu, 16 Jan 2025 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737058207; x=1737663007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R9qr57k+DXl0UWsOvLS7wPLZNMz1fmnNJUTUipS7M1U=;
        b=GmzRsrmcLo/VTnruYTYWpCu3jJoujohs90D/K0m+xor1cRbFD7DI7ifVQCREJ4HmWr
         LcdjprX+DQ5Y88bTIe+cai5wTTz2XFhuX1Xaa8C/OXy8Xx9XM0RE9ftlBSMfC8LLR2ws
         c3GIiVleCJjBOPvfYptOxULLskmPFsy0k5yN10eq3/P0dkjItrp5qUFEwNNecYnossLp
         8SUv7M0uGBzg4xoFY9rS69WdS2Bd/tzrIXrbEJ0qtryFjzVUirjC6eIK5FoHq60m1g7o
         GNvH6BrUCpUhYQbExMPkoKJwwK6d2AIo2NHU51wqM9OrmkfGhUPARs/EeaoHn1Esl5Ju
         eZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737058207; x=1737663007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9qr57k+DXl0UWsOvLS7wPLZNMz1fmnNJUTUipS7M1U=;
        b=f13D2/G9bnFO2xa3li6TwifAlQbdeMXAGAfYCo4qG1+ktJ4BOEf1e5n83mylKfMrL4
         4QimJ1Tj4XVY8RsPUPpYEOOqRyc1PPmc+r8lAU3Wxq2WNXt1Bf8Stjvnp1Uv7Ob7VLhd
         nLfYHVXNHgFv6CzOF6fYkU+il+orP53kBw7kg2Sn8lk1zE4QcVnbzYH98LA5tG6OcRHp
         HNN8qEatfmVveZ0RIyU+S7MECWijUd9wS02Vo7Ly/oL6zYZwFPFogPvmUGHaYZ/9enPp
         hH1KV5chjqWdAUdka+6piymY2kIzkOtTI8mP7xkuwa8xTwsdbQPm+d4n7LM60o3bnezJ
         G2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWY+6p3p868ldKFqSsgWk9zXeNsczILB11M+FOy3rTf+PiVebVTZfdQjvyv+Fkk4KIEuAcoZFpqQ8O3RdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxtSwsrnKtyvjstnVBbBOJNY7VTZJLP1hQuQXpQVmrL8xd9X0c
	0PMlN5AfjgKoQQEcx81JKmEPtU1XbaWAnTnF6HJ6IY4QaOTOWajWgq7m+6RYfwU=
X-Gm-Gg: ASbGncuurGUvHR+ahbltNgJeBFlBMoq182JApk+CwoyXo3pZHLjXiI+DGAoQAagOSG9
	sPsAe7CurXum05vtXjCOJly/2pzqSD4rEzFdMOR34e3lxqK3V6Y5inWJT8n7Jr99CS1QuQ9jNDP
	sfSKGB1/9mBwbzJ+23JsG4yx4xLYblW6Oq5O07m5/Ru0HmlE/scc2c5Tk6ZDig4TDjwfXP/LvgR
	tz3+CNgUfo633MCu6iVotDmYx+PFnh47R4yc0CxFEU0b7KYOVtEZgdr80HEG1LTcm9JHc8=
X-Google-Smtp-Source: AGHT+IErpYjRsle6J00LdBcE8AfPG0RsVe8n9yEKS8SCTtRoWtNwgqW/3vVYd6f9BkMxcAkBeoAU2w==
X-Received: by 2002:a05:6a00:21ca:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-72dafb36d75mr163958b3a.15.1737058206188;
        Thu, 16 Jan 2025 12:10:06 -0800 (PST)
Received: from localhost.localdomain ([2405:201:f022:f804:ca0a:f615:5d6e:f4e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48ec3sm388336b3a.132.2025.01.16.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 12:10:05 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	pmladek@suse.com,
	mbenes@suse.cz,
	linux-kernel@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v3 2/2] selftests/lib.mk: Introduce check to validate required dependencies
Date: Fri, 17 Jan 2025 01:39:56 +0530
Message-Id: <20250116200956.108494-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kselftests does not have a generalised mechanism to skip compilation
and run tests when required kernel configuration flags are missing.

This patch introduces a check to validate the presence of required config flags
specified in the selftest config files. In case scripts/config or the current
kernel config is not found, this check is skipped.

In order to skip checking for config options required to compile the test,
set the environment variable SKIP_CHECKS=1.

example usage:
```
make SKIP_CHECKS=1 -C livepatch/
```

Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 v1->v2:
 - Moved the logic to check for required configurations
   to an external script
 v2 -> v3:
 - Add SKIP_CHECKS flag to skip checking the dependencies
   if required
 - Updated the test skip statement to be more meaningful
 tools/testing/selftests/lib.mk | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/lib.mk

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
old mode 100644
new mode 100755
index d6edcfcb5be8..0e11d1d3bab8
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -97,7 +97,18 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
-all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
+TEST_DIR := $(shell pwd)
+
+check_kselftest_deps:
+ifneq ($(SKIP_CHECKS),1)
+	@$(selfdir)/check_kselftest_deps.pl $(TEST_DIR) $(CC) || { \
+		echo "Skipping test: $(notdir $(TEST_DIR)) (missing required kernel features)"; \
+		exit 1; \
+	}
+endif
+
+
+all: check_kselftest_deps $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
 	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
 
 define RUN_TESTS
@@ -228,4 +239,4 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
 
-.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
+.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir check_kselftest_deps
-- 
2.39.5


