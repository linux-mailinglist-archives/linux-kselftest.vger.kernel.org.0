Return-Path: <linux-kselftest+bounces-27714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C4FA47541
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 06:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A6516EF6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 05:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F2A217654;
	Thu, 27 Feb 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHHWHuAo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D94D2153EA;
	Thu, 27 Feb 2025 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634426; cv=none; b=F4mFxYnsp7RlVwGyj732knF1r2dCscYZs08F6rjWP6EwMdRV1krkebRUT9rVG3VygyE8akwc3dYleJpJW8ZXet2r8P133dpTNymloQ2OtzZP18R+5QhX1FBPpw/hwqzpX3YsIdF8VnKxnV+XY3YYRlN0FYA5PBUBE7AqmpTU//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634426; c=relaxed/simple;
	bh=GzkEP80bc+2j9R7ea6A+JgaA7IWEDxVPCLy+hvQ9hAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOc80hEihXKNGHwN0ZzKqvgPo5SFRH4rnVoEibKTExBn4YkO0jldKZsj5AiR6ntpo67s+hchN79r9iU6Dsc3YGWAOcJGO6X27Dhwchh8i8Iz6cuaVEiw4KhJXiI1au4ZYwX78ALqSgsGXASaGjrT2vppL55j9GGJ24MKHEe9Qhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHHWHuAo; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso1213900a91.3;
        Wed, 26 Feb 2025 21:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740634424; x=1741239224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reYQ3kEdxRIcp+AlEGxe4/u4x5hxYLbz2KdG4kcg/Bg=;
        b=NHHWHuAolFz4Ijwwa/ohaj9zJ5TkbUEppfOWPw1sSOBkL/Kv1xTAT3uZKPbfm4c0hL
         DizfrFfTPfnuzTv6N13Oqw5+7OQfW2y2xfnhSUMe5F1ABm1TTu4Do/Y1Etl6FwvqD1eE
         kfiCfJW0tDLTbDwGI0N9BZbDrgHJUJa2Xi2cUH3qEqsRT1xIdjsn2kEq37eLRsMAbAU6
         ZseoXEk6I7StymvUn0xdJ0TKLKPs4oyZVsw07zmBlitC+yFG7FgxfkAQCo2ddkKVMZlX
         tR0lpDfXXmDNJjYmI7dG/Rstvd0aMTgS9+yihk/pZB3wFYmwEkHw5w/ycsm35GopmMDA
         9icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740634424; x=1741239224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reYQ3kEdxRIcp+AlEGxe4/u4x5hxYLbz2KdG4kcg/Bg=;
        b=lBmL5iVD53KNB/BLU4NWj8o+DC6nWNoGkTAgdGrFkJDJz0S0TifqdWYxFpqZpVDKgJ
         /Ujd7hvKM1TJ+WlwiMApjeQtG10RBCqPyIt/9V6ERX61c3gGQZJavBJN8ewS5d1rPBiL
         pvHCuxPmqR4pDWiIc6CEIxVe6KKlm47JJnDbvwrRrMZOi2x8FXsv2WGIy3Y6H0WpkTDi
         Oz785D+MM0beDlKiWV7k5L3Vtt/Lmv6uiN+xtnEefVIwhfuL5VHhxE6LlwwXFg9Na55w
         B5QHaJzymSdNufbsc6fCxVKQQmIbTvkAWd+j7l5hTrHz6iuqDm1R6l8VkIzlGPUTrsej
         +nLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1zHTWhyd3wqJ1bLP79BFq6kfoe+8+OzrBwp3cFIeLOQhKkp3nCGWrwaGLSJ/il1OYb92F8+p7UxHAxkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtrKXmc9uGbMv6CL2CrMRs85+Oj6lhLzlvUPvqv3hB6PAU761
	HhIKFTlPwakUmZ0S1qGt2FWF3Jx70Q7LogV5Ns+U+9hIhL+ufk3ibK8WMk8zBw0=
X-Gm-Gg: ASbGnctMUQ2lJXN/lEiq2ch/yldUgwRVkpyTZieBXlqInuV7zHsyy2g+teGJBPYC4d7
	OmJNxxflHTO8wpaoMl1WU+SzzV+Lqei1UdecEFMNNO19xUCXii/NS0hD/FCAfqTsPQ6vJqAgCkR
	zrFGq6GSuhdgOWgVzLMluloTuQjZu9+W5s+ZtMp5jpVenIu5oTrlLSL7aLrTMhD1lyvH6zgj82v
	TBB9r1O6DtnA4oJh2j9F3W1EZOaHn4HUmuW4P8nRAGExINmXmi1dVgxhu9++If/n009XJaEhpAW
	69w1ODZelXs71oY7ych21CDSC5il6V7RasJoZEnKswk=
X-Google-Smtp-Source: AGHT+IFBTfT+rXScplEGZOSqbKB16z8kFYvuSlvRtid2M/w3rf9uNa3iNQPcokIirQ03KU0lGrh0Vw==
X-Received: by 2002:a17:90b:2e0d:b0:2fa:17d2:166 with SMTP id 98e67ed59e1d1-2fe7e3b14cbmr8974123a91.31.1740634424211;
        Wed, 26 Feb 2025 21:33:44 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6753143sm582407a91.4.2025.02.26.21.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 21:33:43 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Cc: skhan@linuxfoundation.org,
	pmladek@suse.com,
	mbenes@suse.cz,
	linux-kernel@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v3 2/2] selftests/lib.mk: Introduce check to validate required dependencies
Date: Thu, 27 Feb 2025 10:59:27 +0530
Message-ID: <20250227053322.114215-3-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227053322.114215-1-simeddon@gmail.com>
References: <20250227053322.114215-1-simeddon@gmail.com>
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

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be8..0e11d1d3bab8 100644
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
2.48.1


