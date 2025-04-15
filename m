Return-Path: <linux-kselftest+bounces-30919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C90A8AC27
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507BF188A7B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A312D8DB5;
	Tue, 15 Apr 2025 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig+t/Osg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CC21B9FF;
	Tue, 15 Apr 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759917; cv=none; b=PK52krbCv2iRg7DvRPCEsUjF2gpXDsTjBxaY2nhOKSWQUo0SX3sk+gT7PGG+3usv87Y69Bz/lsIO4Iqbe9FIF+jKpGSKD5/fip5mGj0FRgJJAQZ8p2AfIsdDbCnJuwn7W8H3OZWbAkrX8SRCCWgWG4/fzBSl5YWVA0F6WdWlyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759917; c=relaxed/simple;
	bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8+C8T/4rQVWcxy11Ihrds79oblQ2bks28akxhn9c3hKs0dBr73pETnbL9tM8tcwigOa2qHJV8Ptpi3qpyLKzaTafSoVWxpBcjuHqjr+0WQVxXQ9T85JyEHZ3eIKtReYehSJRAkA4ROhgVdkMXYDUFn2wO8bMYGGLeUg9Sc93kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig+t/Osg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0184C4CEE9;
	Tue, 15 Apr 2025 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744759916;
	bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ig+t/OsgFE/xxTxmZIeRoAYwDwvJ//IKrcyfQ43Cx+FdT2QaBzoCaQjkJtRSN+YCc
	 l8zJAIG4c3FMviEzAX0p0rgB+jCyrBUCybYfT0El3Bw6f4ZeSeKkrSBEnQRA2jXtR1
	 5jyiAJ7YThtld133nHPDYfEoPwjIktYOB4ENpSmJq4SZYU8MaDkEHK4RtM7TOr9sMy
	 xdWeCAdr/tB67bKDXoXvkutO11k68IH/b5YP7r5b2RJt3Dvn4iJSvHwVM6bL+h08mt
	 /eK+iLXikKZaJCio9+jMsON+C76FkkEEESPk7PByk+vDNl/w3KhhZ7xDn3O9lIOwh2
	 T+8jgj8fEiZoQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 16 Apr 2025 00:31:09 +0100
Subject: [PATCH RFT v16 2/8] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-clone3-shadow-stack-v16-2-2ffc9ca3917b@kernel.org>
References: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
In-Reply-To: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3235; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn/uxVXO4DncWW2JRSLnW0e97xpa40aI8JELgLmONV
 Vk3IyTqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/7sVQAKCRAk1otyXVSH0IPjB/
 4zS7GY3SkA6nhXU5/WED3xQ17CooiFvObNkC5r5iwnmUmxpHNbczZ1+peZZHUVJls3/AsXfi3s+Al6
 yvnvRxB0lEWfQIk5kCTiDqt2khbowx2JIDK1NUNzxIMJxB5Jat2E6xw1VdqaXbAxwbHjsMNynZwsUi
 uSlKxN6nqjyux/o/5e1RPhyqU9fbKB4qPTE4PmFatBP7f8paksg/gy0nHHpmJ3u0FXvszqZ16PxJ9R
 OfrzDQRmefBZQoenPiQLdilW5WBbskdKnwbkspel1ao0Hjw+EUJxSXOU6RrfKZXC3rYDKiepZ4px3z
 A/ginkehjflO2pQnFFIFmPoQ6C+Z3M
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There are a number of architectures with shadow stack features which we are
presenting to userspace with as consistent an API as we can (though there
are some architecture specifics). Especially given that there are some
important considerations for userspace code interacting directly with the
feature let's provide some documentation covering the common aspects.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Kees Cook <kees@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/userspace-api/index.rst        |  1 +
 Documentation/userspace-api/shadow_stack.rst | 44 ++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b8c73be4fb11..0167e59b541e 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -62,6 +62,7 @@ Everything else
 
    ELF
    netlink/index
+   shadow_stack
    sysfs-platform_profile
    vduse
    futex2
diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
new file mode 100644
index 000000000000..65c665496624
--- /dev/null
+++ b/Documentation/userspace-api/shadow_stack.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Shadow Stacks
+=============
+
+Introduction
+============
+
+Several architectures have features which provide backward edge
+control flow protection through a hardware maintained stack, only
+writeable by userspace through very limited operations.  This feature
+is referred to as shadow stacks on Linux, on x86 it is part of Intel
+Control Enforcement Technology (CET), on arm64 it is Guarded Control
+Stacks feature (FEAT_GCS) and for RISC-V it is the Zicfiss extension.
+It is expected that this feature will normally be managed by the
+system dynamic linker and libc in ways broadly transparent to
+application code, this document covers interfaces and considerations.
+
+
+Enabling
+========
+
+Shadow stacks default to disabled when a userspace process is
+executed, they can be enabled for the current thread with a syscall:
+
+ - For x86 the ARCH_SHSTK_ENABLE arch_prctl()
+ - For other architectures the PR_SET_SHADOW_STACK_ENABLE prctl()
+
+It is expected that this will normally be done by the dynamic linker.
+Any new threads created by a thread with shadow stacks enabled will
+themselves have shadow stacks enabled.
+
+
+Enablement considerations
+=========================
+
+- Returning from the function that enables shadow stacks without first
+  disabling them will cause a shadow stack exception.  This includes
+  any syscall wrapper or other library functions, the syscall will need
+  to be inlined.
+- A lock feature allows userspace to prevent disabling of shadow stacks.
+- Those that change the stack context like longjmp() or use of ucontext
+  changes on signal return will need support from libc.

-- 
2.39.5


