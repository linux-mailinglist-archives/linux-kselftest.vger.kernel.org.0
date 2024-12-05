Return-Path: <linux-kselftest+bounces-22865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FBE9E5489
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 12:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D99E280E61
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E892116FE;
	Thu,  5 Dec 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imxTa0fi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677F212B08
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399385; cv=none; b=OCSlipcbgV5LwzhvbMlf+Gf8pHHVGW3OoC1nyCvMeNPEXofT6Wn+SNPSXwpaSwkCsFNE4VA3eYgG8S7AFKhY21IDoZvW+JiYWhxWvG34HLOmvTxgHla24O90VSi+5NC0qcKN9c0wvYLCqeKniYhkwAhgmhx+/yyk7wELKpHKhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399385; c=relaxed/simple;
	bh=BFt+sq+G2C98wzeuVl5J1IwNYozlprQOZ8qoDPvG2bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iJYbU4RyF20oW4Bc4EhmIl1NSu63UnIS6yCvAWEYFcI/OO8altjOlLUYt8TFwTyic3ZFSltuXu0CBnzQbartIYc8ryRiBX6XjdeLoKsYpPlogZ+jz4qgiDrtcZcGRjQ0aRq7ydz9jyLa44pv7LPsKv9qICt2h9KWibQLT9+Y6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imxTa0fi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215b0582aaeso5915315ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 03:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733399383; x=1734004183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMSioP6xaqJTxr5Vp63iZPRRfxSTWw68PJiHrNfwOOY=;
        b=imxTa0fi89OYXx+NG3D3S7VqYniqEAi+7q3XGhMuKFqgoFbhdWNpH9hB4hYBRy4Fb1
         OySjAcX1+tjfikfJufrP91i19YuVUvpLUOKqRJl7wEBOBWtmPtUFbX7aodXVg7jceoJi
         XEUiRAcotWhW7T9tEta5KmCVs4HmI2P4O3LluSflJYveoyxE/md00Zv30UVoiHFCcQIa
         fF+73J+T5yaUDdD9/Mv8xgpK6XivftauRDp+RrkT4MJwePrs544RwmEnZH/He3Zlf5I+
         pxcSz20l1Zqy2eltBpAnTB2YkNaWQllQKeldqUI+3kN/uce4BN+AMO780YCRO9I0rp2d
         Og+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733399383; x=1734004183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMSioP6xaqJTxr5Vp63iZPRRfxSTWw68PJiHrNfwOOY=;
        b=Pqu6ApSxwj7kZzeEG32SyJ4wjENSHLDHxMyCPNt0E2SDzeHDLpkwSf9e1C/N+6FGqh
         l1aIKCaDr6sb/Q5zfddl3sPR6qsNFxu5WgHAYqJStVfy8FwbzukcNmjGNEokInMrtxoc
         WlWFiY25UoKoVTehU5MNPyzUwGgnvGeJ6oUVdzxDMBxQcEmmqQoVW1jm2nxIzp4Y9A+h
         MAdHSf0xODlKMdG/JbmDR0vlEE150qFkG1hh5IICcoD0Fvlg1eKXsx03aEhNn1Pd71xN
         eaOETANZuWXPsemtA6pNoGJvk3IGVwwEN2GB7ggI6mICBJ7H6Q/wzO+B07RyteVpdTnG
         zlPg==
X-Forwarded-Encrypted: i=1; AJvYcCUibGe76ODqp+MetzAwW1EwoRRNjUok7SPtbX0pswM0Pe9xokIYwUExjHrTk2YPWgfE5GnTAubkwr+HoY8Jhig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVTpLnajbspz3oMD+AT3srhTLWmsfUNHWKYBqqRLPVMCbcq8v
	a4jKYWemeyXhWhIQQFDMbeKFPBH1DQUwgR4j8oqiEvpHHzCpT+n8
X-Gm-Gg: ASbGnctB36eUHyTAwJcPnQREHsDavmzi+h6A55yRsXxQgX6gkSH9hmQ6nvg4giYhfR2
	QYgYB39cOQ5C4HOy3C0Is9WAyf4RyqkRHZbfq2A0qcBHQJqT31udDk0biCtr+COP9b1SNfYgx8q
	Y2vmw4ErnaW15rUIXWK98VIb8OD+wXRD4wfnrWqWoCM8a15CASWZlnCbAJm5kDpJSqvpZ0iIbWt
	RHvVCb94yQZ0cxBWyYbH6qclmWg9dc5rW9Fo1lhzDJIYvX8+4Hbj90OmhztuPtWSr757wYeLHg=
X-Google-Smtp-Source: AGHT+IGr/MnVCHhfQWAuxpnTKfibfERfWYxYywuFez1iF2qY2audco67Zv8tH8apTmwgtkYy42mLMw==
X-Received: by 2002:a17:902:e54d:b0:215:6fcd:6cd1 with SMTP id d9443c01a7336-215bcfbcde4mr125603515ad.7.1733399382697;
        Thu, 05 Dec 2024 03:49:42 -0800 (PST)
Received: from BiscuitBobby.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e41e52sm10965545ad.3.2024.12.05.03.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:49:42 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: simeddon@gmail.com,
	shuah@kernel.org
Cc: mbenes@suse.cz,
	Petr Mladek <pmladek@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/3] selftests/lib.mk: Introduce check to validate required configs
Date: Thu,  5 Dec 2024 17:17:56 +0530
Message-Id: <20241205114757.5916-3-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205114757.5916-1-simeddon@gmail.com>
References: <20241205114757.5916-1-simeddon@gmail.com>
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
specified in the selftest makefile. In case scripts/config is not found,
this check is skipped.

Use TEST_CONFIG_DEPS to check for specific config options before compiling,
example usage:
```
TEST_CONFIG_DEPS := CONFIG_LIVEPATCH CONFIG_DYNAMIC_DEBUG
```
Here it checks whether CONFIG_LIVEPATCH and CONFIG_DYNAMIC_DEBUG are enabled.

Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 tools/testing/selftests/lib.mk | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be8..7ca713237bf7 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -97,7 +97,21 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
-all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
+KDIR ?= /lib/modules/$(shell uname -r)/build
+
+define CHECK_CONFIG_DEPS
+    $(if $(wildcard $(KDIR)/scripts/config),
+        $(eval MISSING_FLAGS := $(filter-out 1,$(foreach cfg,$(TEST_CONFIG_DEPS),\
+            $(shell cd $(KDIR) && scripts/config --state $(cfg) | grep -q '^\(y\|m\)$$' && echo 1 || echo $(cfg))))),
+        $(info Skipping CHECK_GEN_REQ: $(KDIR)/scripts/config not found)
+    )
+    $(if $(MISSING_FLAGS),$(error Missing required config flags: $(MISSING_FLAGS)))
+endef
+
+check_config_deps:
+	$(call CHECK_CONFIG_DEPS)
+
+all: check_config_deps $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
 	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
 
 define RUN_TESTS
@@ -228,4 +242,4 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
 
-.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
+.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir check_config_deps
-- 
2.39.5


