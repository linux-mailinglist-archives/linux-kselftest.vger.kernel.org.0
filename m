Return-Path: <linux-kselftest+bounces-15911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B67695A56E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DBF283EAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845E16F8F5;
	Wed, 21 Aug 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLyRI3bO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6A0137745;
	Wed, 21 Aug 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269831; cv=none; b=r20LdvzZ6z+ac7/7VMMvYQ/jIbNZo/z40PeUCkm9uUmRmXH7+KQ68RSJaMnUmVzSTbxjhh3ZylCc4BXfjXeG9O5oO+PU759KfoS9yjScszJJONnN+6diK5P5+O/ntCcikkoPDIs/AUJjQIF0Jqz7b4kFPpK2nMa23XcK8mxTtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269831; c=relaxed/simple;
	bh=XqaXLGAQ/MwY54koFKC2rQRtWZp0KxmYdMIZOGKT0R8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGrbjI+1iN3lCex3PyOIR/cEte5JWE5FHeUascZIGRO/8Nzj34u0NWoBoHH3rzxIiKByNDEfx9lXrxsM+ILDyEhm1dSOYZ4ogmFCuxwmUFFAYlmBPrANMg1MkjnaXT1mkYJGecFmk0kaUV4NKZWf0rowtoNMFA6ZvYmsPd4Rn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLyRI3bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A13C4AF13;
	Wed, 21 Aug 2024 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724269831;
	bh=XqaXLGAQ/MwY54koFKC2rQRtWZp0KxmYdMIZOGKT0R8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WLyRI3bOPlN+noQ8+juXVDa0etYYSXg6Zz9bBTHAY4qvxJ48a3CSxpoOHeihFxu6g
	 HsHu0f6joxUITmqgwweHwa471dfd1MiWY+Dc4TR3nYH7eTloUgHEHrqpl7mcgNjB/8
	 fcB9Hmm521oimjaXpHq5UgGQbVyx4/x2bP0V9zDc4T4irZrFsEne/zpUR80alGnG2y
	 L20d5WBXlYLWRsOZ3fjBWWdXba7m7GP2AOzQd88vAa8zWcYslQsvho0ZhqyjQuzUgA
	 DbjgJMP1YaLdI2m+A3ygBgTpSnowdGVG6wTQmLUVQY77PLOS6D7MOSMA0Y9nUkVjoG
	 w/hxkd2v7AtZA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 21 Aug 2024 20:49:47 +0100
Subject: [PATCH RFT v10 1/8] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-clone3-shadow-stack-v10-1-06e8797b9445@kernel.org>
References: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
In-Reply-To: <20240821-clone3-shadow-stack-v10-0-06e8797b9445@kernel.org>
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
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3025; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XqaXLGAQ/MwY54koFKC2rQRtWZp0KxmYdMIZOGKT0R8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxkTzN8r7uAOtp9K3ugTi+sHgrab9M/rfCFd5DE9G
 jAMkX96JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsZE8wAKCRAk1otyXVSH0DYUB/
 sEp2EphzksK2LC6zHqb4zhg9kZ6qJZA1N/HJovcXAeYxmUl6+DyHZn6WvxUqt34GnAPYV0j5F/h6rI
 Nyh9GjWy4KiJvYkbTAHLAzDEdu7KllpZlGgq4ESgzHXxu89cGS1vTGKO0TC+4R9MwrZUcQINB2JoXP
 +GyLCZnKVWUNWyUMPx2aqPQiq/oT8R84/lOdoZT3iaiiBofBO9YfyYOhTp67oEICW3/PfublaIQOC6
 61f100EOCE6ZN1ZXUwDMq+FX3DLQFW3+42uiUXfeSu9JF0qzDSFsy+NVXDJNb9Gu3WMliIpa5Q+Lga
 rkGhIPS857aNxfrH1rmUaaH+C53e35
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/userspace-api/index.rst        |  1 +
 Documentation/userspace-api/shadow_stack.rst | 41 ++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 274cc7546efc..c39709bfba2c 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -59,6 +59,7 @@ Everything else
 
    ELF
    netlink/index
+   shadow_stack
    sysfs-platform_profile
    vduse
    futex2
diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
new file mode 100644
index 000000000000..c576ad3d7ec1
--- /dev/null
+++ b/Documentation/userspace-api/shadow_stack.rst
@@ -0,0 +1,41 @@
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
2.39.2


