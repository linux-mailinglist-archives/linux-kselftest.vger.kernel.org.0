Return-Path: <linux-kselftest+bounces-28369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F9BA54276
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 06:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDAE16D143
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 05:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7F1990AB;
	Thu,  6 Mar 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="anvF/6cV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25D38DFC
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240536; cv=none; b=BUU53ed34VU6zN9sAlEjniL0/UA5vgWzdiqu8A5obHiHpTjYamkwCSeBSMHoxeARA+0yRQsYQk0s7pPaVbOUeRrhlE/39J0LBMTnR1GmV3I2jkz28L+XqqS0ifK6jFRMdxgwR34bB6Ppbv5Zyy72AXgZ8IH0o+vA3XL0q8LqF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240536; c=relaxed/simple;
	bh=fStPxmsCJIjNv3GU3HTZoAXZLVWt4JfQuG8MDVhJlTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V+dfnnbBkHcS8wdv5tAnaIkNbHu6/by2zTrqupLzA9PqOLtpHny9neYeb8MHqzB8Lw6hoI27RbZz77x6reh2lpRv4RH4/2LIHHR+l21ibIRLgc1a7FBy9dBkNK0J7cTjQKR1vSQNN/6WSPle2aa6hkNkomLQl0YUMUoFYjFHXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=anvF/6cV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fb0f619dso4153445ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 21:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741240534; x=1741845334; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUdx3QRyuZIX7/o+JJ2wds9H9VcUk1U/xmQVPBXai18=;
        b=anvF/6cV9SGBke0ReSodh++QuZwCEU/BnTwRR6j26ZjgYoU1O/KIbl6MgQ53ZnH1Ra
         2IAkvZsNltj0nILEToutdduayMnLHOQtXqzt6wyrn+oceYEMlwutxNCibv1andkrPPq1
         p5mM8rFUk+vRD10BUFTAHVjWZitunFie2prYiOLcyAQMSpJZ6F4hRnLgutOyuSE/RaW/
         /GSWCngVhrUzmgvCgMJP3OW82HB8VN8dbuB5Cyq+AJrS4nv28BXIV9PypGmuZDW6votk
         WEdC4t212ctL99u9sphpgV4M399X/PlaBdYz1Mv1q3cay/UGUHjCbkXGtG/1AvvRi/cZ
         iYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741240534; x=1741845334;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUdx3QRyuZIX7/o+JJ2wds9H9VcUk1U/xmQVPBXai18=;
        b=mfPeb4hxn2fXXVZCP9V8p5Vs7QcSlgAi6403o4OCViux/7XpMNdCujQZFeaM2zbpaK
         UJptKMSwMCPvpZ6H4zGMjsuUX8Df7LHW+W0gfiMAlQDs7h5v/caoprX2djF3WN0k912t
         LS7hacVid3rNNt+M/Tk/T6vU8Rqafv0KmP4Q3+9+4nqYvgmQ1dyC6hKqRHaD7T586yA5
         LxuJR3BL3UKkmQ1z8f9LBe1kCZlVfNaBasEYw5bA+/BTklfLAs42GF3retG+sxx+jg4z
         x5bRbk0bMask/TdatRqI1dW/rHoqCJgecJMjfNsImmheEJAtIbCqWaxXr8o41AfiaooY
         ueQA==
X-Gm-Message-State: AOJu0Yxs/9lo1qCisE8RRgoDbTjYSZNzeCaC19tYgDidoZI27Y0aQPnH
	DsAsWGPXxjzgjIprIZL6ipFi6RfMjDpJjwuiYjgq/qvyured1U6+s7AY7DxBKnc=
X-Gm-Gg: ASbGncvr02YzSkh4IHe/LOnS83wOFi7lbSk3jfMPInb/qkc7nfxPAq3tfRk1CjFTs20
	m9Dt100Fs8ywP21qFrbMQOMZ6mrMXnBpPBBA/S27sTtrA3GEGUnPhzvVLJXX1lCoLPHDmS7+EvU
	5Xr1asPi3AIu59Ji0AmD6vVIHFyddnFK5+3gfNfK07LLkgYDKDWdKA1ZDDIZ1u1rOBaqMoc++D8
	2sN983uD7bU0hJoIzZHsLep/Y00QnHmdo2BxRhaIy+CwGce1KJ7uaLKgY6iZ/jg+JC/+Y8p2NAr
	Y+y2yWZtYPc5eAIGvvGqAFgXH5WOxlmgLBpCJZ8Mm3tGqHH6
X-Google-Smtp-Source: AGHT+IHWmtVby/odXZZF6dFxs4Y5suzRcbfsujqB5xfNftQwM4rblktBoE/1Jwu1suHSRVUrEebhQw==
X-Received: by 2002:a05:6a00:2d1d:b0:736:61c9:f9a6 with SMTP id d2e1a72fcca58-73682b6c31fmr8000931b3a.5.1741240534431;
        Wed, 05 Mar 2025 21:55:34 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73698515094sm458717b3a.131.2025.03.05.21.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 21:55:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 06 Mar 2025 14:55:19 +0900
Subject: [PATCH] selftests: Override command line in lib.mk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-lib-v1-1-85692f1a7ce4@daynix.com>
X-B4-Tracking: v=1; b=H4sIAMY4yWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMz3ZzMJF2TxGRLc0PDZEODRCMloMqCotS0zAqwKdGxtbUAszSkVlU
 AAAA=
X-Change-ID: 20250306-lib-4ac9711c10a2
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14.2

Documentation/dev-tools/kselftest.rst says you can use the "TARGETS"
variable on the make command line to run only tests targeted for a
single subsystem:

  $ make TARGETS="size timers" kselftest

A natural way to narrow down further to a particular test in a subsystem
is to specify e.g., TEST_GEN_PROGS:

  $ make TARGETS=net TEST_PROGS= TEST_GEN_PROGS=tun kselftest

However, this does not work well because the following statement in
tools/testing/selftests/lib.mk gets ignored:

  TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))

Add the override directive to make it and similar ones will be effective
even when TEST_GEN_PROGS and similar variables are specified in the
command line.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/lib.mk | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfcb5be832ddee4c3d34b5ad221e9295f878..68116e51f97d62376c63f727ba3fd1f616c67562 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -93,9 +93,9 @@ TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi
 # TEST_PROGS are for test shell scripts.
 # TEST_CUSTOM_PROGS and TEST_PROGS will be run by common run_tests
 # and install targets. Common clean doesn't touch them.
-TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
-TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
-TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
+override TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
+override TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
+override TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
 	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)

---
base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
change-id: 20250306-lib-4ac9711c10a2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


