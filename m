Return-Path: <linux-kselftest+bounces-23703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C429F9A9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 20:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3011891A69
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667C521A431;
	Fri, 20 Dec 2024 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oymkflz2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232721CFF0
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723462; cv=none; b=ZvgtQFMPvFjoFh4JEma3pycTPxVM76N358eh6e9VHiQvaBBZtVMs9Rp/tq6f3sUypHI5pGm0HGrSNlh2fMiVUgfflKhXzU4RN9ewJluJhaT+hTbXAgz0JCEnu0vET+GJ0mNKz+i1xq4mkzFBJ9IFVC6y3daeJf+GMAQyPj5RTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723462; c=relaxed/simple;
	bh=7J2HSKMDZyciFL9W52T+XM/U0XrW3eHPjutLK4T1t2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXXC2O4Y+YiEMZEIiZsbI9GVvP7KkOk/E31orPQGQW8OOTUSLzNI8DTfLexFzdmbQ/Nmw0JvQDxhw18fC+F8868LR7tTmwVili43/u5uYlYqFOVdYC2iRjFFNatAunm0GZ04eeoj71bLp9ge8VsR6HGpdKCBlRrZNcsfO7cYVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oymkflz2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-820b825cbfcso2866873a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 11:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734723459; x=1735328259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/4/1lKAMtLS+F1t7d6RDrMvXKesNiqyvDziIAq2bJk=;
        b=Oymkflz2bpFtP84YJbPoOLM6MItrXpemnZKgn0x7LD7g1R75kSYJDihSkdEcmZysUW
         FoiBRnehKCw3dGJkUVA4xOONtMxkAU4HvoN7lB9tmExQGiv+/wv0YZ0HQObAG3KXvkrX
         I+2R4vNTv9jvkEZbyiWhgHRFY6xefVLKmxaYPcyy1WCSct9QJihuCVz7/yM2lHl7IdKj
         U3q8NBmlfbdRJD9fMBJ1b+bZ0w2ekNA5DIqFOsFNZ2w8CEHEOZguz2YFbhGVE1LK09Cr
         pBH36OO1kEeOtTuoQgjWcToOtyN1ZHsRxR2603gDJRHo4tszwKGCHgbNAYel4wTU3br5
         0Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734723459; x=1735328259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/4/1lKAMtLS+F1t7d6RDrMvXKesNiqyvDziIAq2bJk=;
        b=KW70TXX6gpxmpEu8kxvmi18Sm4u7UEhw3zrJtwUjR1TkLYpa7SiyfgsLYpK99476+G
         X4ePvSw4As60JOXhIjue15AXi4f9AVq482c9XL3z77y44TF6lhJRr+Rd6Vsj/K5YYEOz
         U241QMWCzgFJSsRtRX2jxpBQ03l54TLvb23LWZum0q0KDwququ5mYb5RnuRsFcw774rx
         r3faWNF/YLb/J1YSlNP0n3lNnmCczGRcW/OiiYx9QuOhqzWGPeWwnTLg+e0r8o82y/X9
         6YreNMH7d+y8e2vLP+v5BI/5rU6h1LBoQYVeq0g9Yzcp0vRzhxONEEggXVqVJTmMeJ7D
         RNPA==
X-Forwarded-Encrypted: i=1; AJvYcCVM9uQgUzK0rsSwMDjxmObxfBVCiAhuUBBUhvACXj3UdVIvLsaq79f+8RvgM3ea+W28WZ/7XYW+6ubT0gwB/t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCA+xRBVMnt3KU/Fgyd4pmFPW1gswYgD0q5PBDrPGYXei6m+jL
	1OWOqE/+VJcUBVVbAuiHXKycn3+5L2tqZVyW9vIyDkjax0YKN6QabeDvf6R4Afh2ig==
X-Gm-Gg: ASbGncvoK+mcT00M+B4ggBGvi++y7TyLpEIlhx/IWguUbhQkxyi/HhWTiryC85/pjk/
	5vHp+VFGhzE0PxAtLyrI3KjNnkudnr3NLdTE9tpjk66VJFpzEvJK+2Jbyz3IESzjxcxGAKX5yXj
	6rI0UwMG//KvtOIBqej+NhkPxc6eMbIHvRgAQbJhy1o8edhbmvNf+2rR5cbLQLuHy7+emiQ82Fe
	vaUVWa1nW6vrVh22y2iTG+DyzRIQOZskm7PADBT51FI+EFdQLkRACaZCzO17mx3Hp6n+lKJhwO0
	Q5t6CWn3e+Q=
X-Google-Smtp-Source: AGHT+IEBAuDv2uS/78Mtvpo1Ltj2D7cQBlhlEwQmsRHVrwYpALaaeDMijTwwy4kUwjHbpgEYC6HU+A==
X-Received: by 2002:a17:90b:524d:b0:2ee:9229:e4bd with SMTP id 98e67ed59e1d1-2f4536030d8mr6034403a91.2.1734723459257;
        Fri, 20 Dec 2024 11:37:39 -0800 (PST)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477ef3d9sm3680917a91.26.2024.12.20.11.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:37:38 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: simeddon@gmail.com,
	shuah@kernel.org
Cc: skhan@linuxfoundation.org,
	pmladek@suse.com,
	mbenes@suse.cz,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/lib.mk: Introduce check to validate required configs
Date: Sat, 21 Dec 2024 01:05:36 +0530
Message-Id: <20241220193536.13781-3-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220193536.13781-1-simeddon@gmail.com>
References: <20241220193536.13781-1-simeddon@gmail.com>
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

In order to view the missing config options required to compile the test,
set the environment variable LOCALMODCONFIG_DEBUG=1.

example usage:
```
LOCALMODCONFIG_DEBUG=1 make -C livepatch/
```

Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 v1->v2: moved the config checking logic to a separate perl script
 tools/testing/selftests/lib.mk | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 tools/testing/selftests/lib.mk

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
old mode 100644
new mode 100755
index d6edcfcb5be8..98dda6d8d702
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -97,7 +97,14 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
-all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
+TEST_DIR := $(shell pwd)
+
+check_config_deps:
+	@$(selfdir)/mktest.pl $(TEST_DIR)/config || \
+	{ echo "Skipping test: $(notdir $(TEST_DIR))"; exit 1; }
+
+
+all: check_config_deps $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
 	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
 
 define RUN_TESTS
@@ -228,4 +235,4 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
 
-.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
+.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir check_config_deps
-- 
2.39.5


