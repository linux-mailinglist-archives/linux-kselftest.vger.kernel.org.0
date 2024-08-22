Return-Path: <linux-kselftest+bounces-16055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE3795B4C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D442854BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854A1C9456;
	Thu, 22 Aug 2024 12:14:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEFB1C9459;
	Thu, 22 Aug 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328875; cv=none; b=efqhCnSlZcAjfaS6xyzI9Sdqq7Mlxn8XNAB+oNpPbyeVjyo4N08lhlx4WFq8yzHHpeSWWelQltLxqUQ8gglz3Gl+NqeTKbmNy8/krCC4e/I7zFhhTUnHD4eKx4xjlHiv44gnsy55ajdFNiDv0UOxntBzBsP54cYQAxR9BLE4rp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328875; c=relaxed/simple;
	bh=cYztCLdn/b65lfJRc1shdcdICRccq0c2A1+0DdVlHEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8T11gJLkv6h1SjPkZDchkPMFMSWY7YgGnxWCTz5RlDjUoNwaJRSlIeT9CxK2/qJD5xzdsj/+NTfK8u9Ny+2A6W/OXhx/ZnobAVhAB2PG+XVb/WFtnvSWyL3DMfp1zqRM9eG6/JcOfS/uzE8r05GkjZ5vHT6wj5cGXUbmOMxyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81220DA7;
	Thu, 22 Aug 2024 05:14:59 -0700 (PDT)
Received: from e116581.arm.com (unknown [10.163.87.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80B5A3F66E;
	Thu, 22 Aug 2024 05:14:28 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	oleg@redhat.com
Cc: mingo@kernel.org,
	tglx@linutronix.de,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
Date: Thu, 22 Aug 2024 17:44:14 +0530
Message-Id: <20240822121415.3589190-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822121415.3589190-1-dev.jain@arm.com>
References: <20240822121415.3589190-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename sigaltstack to generic signal directory, to allow adding more
signal tests in the future.

Signed-off-by: Dev Jain <dev.jain@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/Makefile                                | 2 +-
 tools/testing/selftests/{sigaltstack => signal}/.gitignore      | 0
 tools/testing/selftests/{sigaltstack => signal}/Makefile        | 0
 .../selftests/{sigaltstack => signal}/current_stack_pointer.h   | 0
 tools/testing/selftests/{sigaltstack => signal}/sas.c           | 0
 5 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/{sigaltstack => signal}/.gitignore (100%)
 rename tools/testing/selftests/{sigaltstack => signal}/Makefile (100%)
 rename tools/testing/selftests/{sigaltstack => signal}/current_stack_pointer.h (100%)
 rename tools/testing/selftests/{sigaltstack => signal}/sas.c (100%)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index bc8fe9e8f7f2..edbe30fb3304 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -87,7 +87,7 @@ TARGETS += rtc
 TARGETS += rust
 TARGETS += seccomp
 TARGETS += sgx
-TARGETS += sigaltstack
+TARGETS += signal
 TARGETS += size
 TARGETS += sparc64
 TARGETS += splice
diff --git a/tools/testing/selftests/sigaltstack/.gitignore b/tools/testing/selftests/signal/.gitignore
similarity index 100%
rename from tools/testing/selftests/sigaltstack/.gitignore
rename to tools/testing/selftests/signal/.gitignore
diff --git a/tools/testing/selftests/sigaltstack/Makefile b/tools/testing/selftests/signal/Makefile
similarity index 100%
rename from tools/testing/selftests/sigaltstack/Makefile
rename to tools/testing/selftests/signal/Makefile
diff --git a/tools/testing/selftests/sigaltstack/current_stack_pointer.h b/tools/testing/selftests/signal/current_stack_pointer.h
similarity index 100%
rename from tools/testing/selftests/sigaltstack/current_stack_pointer.h
rename to tools/testing/selftests/signal/current_stack_pointer.h
diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/signal/sas.c
similarity index 100%
rename from tools/testing/selftests/sigaltstack/sas.c
rename to tools/testing/selftests/signal/sas.c
-- 
2.30.2


