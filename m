Return-Path: <linux-kselftest+bounces-19317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4F995ED4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 07:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968031F23891
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 05:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C3A155739;
	Wed,  9 Oct 2024 05:14:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63897143C45;
	Wed,  9 Oct 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728450886; cv=none; b=qYbmR8lihMuRTqkF8c1cETC7Za9+RZCudCk02BLbxPTFaRz+nNuvBSQduFY4trPQjRv7XUNg8b9HDgHhLy6zNWXg06cS/ogk31M9yVus6Hr58GGOeCUfaeZxGMio7wNOQSO90w8n6lXDaDjlCXj6GMGHJANHKKL3fYVxuhwFPms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728450886; c=relaxed/simple;
	bh=DfW85rTUY4zRns51cOLr0Gm+/C47u5W1UqywQ1IuFms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SfZbdSkDbpL99uHoCaa64Pv8nyjnjOJIwYEoFDcN0IZJnnA5RZUoL0TnqOZawq3yUZPhrBP+R304qwVkM3OuAzBVtSZfAq/fioO61ifurZiFAjKiOg0A0ViCJdtoVrTuorBJ80UhtuDMmR0qxnbkpzosolmdqKcKu4a41Fr4/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4880B139F;
	Tue,  8 Oct 2024 22:15:13 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90BBA3F64C;
	Tue,  8 Oct 2024 22:14:37 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	oleg@redhat.com
Cc: mingo@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	broonie@kernel.org,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	DeepakKumar.Mishra@arm.com,
	aneesh.kumar@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj@kernel.org,
	skhan@linuxfoundation.org,
	Dev Jain <dev.jain@arm.com>
Subject: [RESEND] [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
Date: Wed,  9 Oct 2024 10:44:23 +0530
Message-Id: <20241009051424.333380-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009051424.333380-1-dev.jain@arm.com>
References: <20241009051424.333380-1-dev.jain@arm.com>
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
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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


