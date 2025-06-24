Return-Path: <linux-kselftest+bounces-35715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07193AE7070
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 22:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEF75A2B21
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 20:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF68B2EA176;
	Tue, 24 Jun 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFthKog7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD32E8898;
	Tue, 24 Jun 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796083; cv=none; b=BYMFAteDaPtCJJkTCi7zfEw0rCQYQjAn20uFPaOxTSoJvEYyCEufhEEUOnmcTdr5dpURpvbgQh3aFaAiYMoHU29OQJB+rhcpMZOwmNblld9FlmWgbKtPb+FReHlAEyrrnRCPEwe7S/0LNhey7q/hbRNgsDRRW455ChfFBF3+OA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796083; c=relaxed/simple;
	bh=uhIaBtu5nDYQZF29WnuRATZzvZFbAKVMn+fqJ5S0vyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXW2JJkdVyWiG7uRo9H+3yDjuRUMlVOGoe+0GQOpnxjLbfUaTcrysniEpSIk3Jgd0u0eyLh2pMQzodVxrNHC8xJNnSVPoQ0TYx/u6tDUfIvO91aEj7L/lB4eFt/XmK3v4fsOThUxJJFsiaelfxzR4Ck1UP6XGPgKHYTrpOcwLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFthKog7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2363616a1a6so49964285ad.3;
        Tue, 24 Jun 2025 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750796082; x=1751400882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKwNZGxUka13BV0lgvKYQ+62h1vPzm83K1NHrGIKb+E=;
        b=TFthKog7A/soOWNx37oSE+CS1rttdjDo0us1hDg3vEjN8IG3xqiy7RQ8dnf2zx/DY9
         RvjxPMkIrPdO5p3ebPol/a+CgdQZQ4mlV86i0uDLhnHNoaHR52twe4Pm9psLpzA9DOt7
         u325uDhuMK4mIyQDghvdqpDV41EDm6AhM6T89MmY9D/RTrydCybx1r8HD2od6F8ncMRu
         buXswTpvV3l8GTB9y7w8SGDSQWr7deyL5cQXOybhRJSdKk2efat1SIse61zb15kReRom
         q/lAT0syIZYrNeH6V9ySqnqpLoWAIntKA5eR4xF9Z08xz6/8I9Si7w/Y6I+Pj1+rzRnO
         zknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750796082; x=1751400882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKwNZGxUka13BV0lgvKYQ+62h1vPzm83K1NHrGIKb+E=;
        b=RcNowD719t896s/hhgwrmrwezIuDldWe4PFRkaOAuX/kpnZSXiPxBwFRXmmunJkZS3
         Lon67BPOPpvaFw1N57PmKbUFccjkyNmoPGjd3/R8BFSBDvhhPKB9vOQMMbQpdhNIAYuQ
         G6FLDKmDsqpsfCTmsl9GchzN9ZtSQapCmQJrzrYnPCY5Ns4gBEwW9w1JpdAhCIqv8Nak
         XoS5LnEzLrtWJA6YxK8fMoiYLZksaSY+X+l+tTzbXIgJ3DCrA5rb5PPIMQVVPMgq9/oo
         5HqTPWOrHvFoLYzYisHC4SSrApeVYqvdVr4Xu3yOMEw1ULGVPCKTzwb78yK75qphX7+b
         YSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDmHOPg3LeJn6Fw8SrLfhpTg/y9lVKnGPTNoEO0iSNcAfju6Zuk56GZnMOFKRHbBmsl4t6oS5hfFkHjoWATdaD@vger.kernel.org, AJvYcCVgf9LbqUqB2nGlmZOk0IOaGQVXI6AMl4X9pcnhQHZZxejvOgDTDLuvwQIi5ZWEA0cdS143uUH5aDwPaJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WimZ2MeUvJgRSHR5fD9fy0e71uSV1dQLy9WwiezZJMycTLmZ
	SPzUXQVjHGbTLcgdea3ZBWtocrtb7FXG3+RrJ4vkQQj9O3TUvPIpZKQC0Pi/BqLN
X-Gm-Gg: ASbGnctB8Of+RGfNaLvNU+TZ8fdfFBCzhnELyaNwGSl1xIu16Uyg2HQlsick4XV3ExZ
	q7l0Yhlmf7RSddX1Vz0nV0lngCRx70N4C8QpyP+mLX9GvVPkDbmVNmthk7GBK2V7XXNDUmwaxg3
	0y+Zd7xiNIuEGPiCetIDjm4mjDfY4kd3OUJb9fyboazlPMQwH6HkH/pJcwjTbzayTZP5GcOhJSm
	a824nEEb0TuU4UpyCdAcF9jXEjC9KJ9gX0pmHVGqdhAcicW+DiXI5Vs9puFMNH43M72QJRmxYRI
	cAaF4flrjvBTHhGxfOR90AhuhGgB+lkS0SyqhcD8JKvu8tePhp1Aea8jSF+ndb3t
X-Google-Smtp-Source: AGHT+IEfzhn/g0z0I1uRydSMgKrQHJta/n3L63zk3PQzFdLue29xSPwQp4px+2tL4bP+pg3xXUTRzw==
X-Received: by 2002:a17:902:da86:b0:234:b131:15a with SMTP id d9443c01a7336-23823f94e3fmr11884165ad.4.1750796081719;
        Tue, 24 Jun 2025 13:14:41 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:9f1f:4826:a6d0:7822])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a12c9b9sm15094476a91.0.2025.06.24.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 13:14:41 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: shuah@kernel.org
Cc: dwmw@amazon.co.uk,
	mingo@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] selftests/kexec: fix test_kexec_jump build and ignore generated binary
Date: Tue, 24 Jun 2025 13:14:38 -0700
Message-ID: <20250624201438.89391-1-moonhee.lee.ca@gmail.com>
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

Also add the binary to .gitignore to avoid tracking it in version control.

Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 tools/testing/selftests/kexec/.gitignore | 2 ++
 tools/testing/selftests/kexec/Makefile   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kexec/.gitignore

diff --git a/tools/testing/selftests/kexec/.gitignore b/tools/testing/selftests/kexec/.gitignore
new file mode 100644
index 000000000000..5f3d9e089ae8
--- /dev/null
+++ b/tools/testing/selftests/kexec/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+test_kexec_jump
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


