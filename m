Return-Path: <linux-kselftest+bounces-30371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E489FA81500
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 20:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F684E141E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F79244186;
	Tue,  8 Apr 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0X8XZX6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F2241678;
	Tue,  8 Apr 2025 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744138239; cv=none; b=VoGBSa/CS1XOwT7IbdLZNdmMx2jEUuny4pZ8JEayMBxk3/DKdukfiYpPyOZYO9cRvHwZjei3l8xdMGWiHG6lUBW0WWrrj0J3C8E/J8p4yAtJZxJLPGgjdTNd1WLNw5yi/QPpLbWOIRPLhuaS18wIoU3AdN64wYJXD23Nv2ANrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744138239; c=relaxed/simple;
	bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0VkBt7RGza3BkCPc3yhXILFcb/L91AI8TcB+ueXyWkFyhId4uvWVH4l2ftGl24ST/BHGubcwbkMqKoI+izPELobntw9vTQq2KvXPYVjNOh3Fgey26+t2WVhk9i5zwcf2wjGdSy+tSdmgzcYD5x9pu57A1qdVgxPVARsN4Q6lGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0X8XZX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D33C4CEE8;
	Tue,  8 Apr 2025 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744138239;
	bh=k56u8xsssiS9PLGw09HLQ5Vh+FXmTGCSWgKOA+mivOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J0X8XZX61BVSHHOroz19lUhgfLNDjFWUqoEPUHRgjq7sZRsryzbd14wW/jwSyu9oQ
	 F4kPGG9RJMWhIB6s3A/ZH2dJKpSJdZcBuewmrtk4iwPyDIoA8ExigjWRcst/gNymy5
	 Z9cBRUxvj5pTjyT1HdsVbFAjCUIjiizr6EwCywmt2oAOBj5sQLxegdg/2LJXqBoe5j
	 z3f8f4Z2w7hWIZYB/K7pyguqXr5cdvQKAZcNrhQC2fwVO5SjJMmxYFa41P7aMnCsgM
	 OyiJCJasBL5miT4eBoFJdb/ngL4MHeDwDh02f6pGYsfHccJIQYJI8j+WUlS5eZCU7Z
	 R2z9k9BbeOpmA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 08 Apr 2025 19:49:42 +0100
Subject: [PATCH RFT v15 2/8] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-clone3-shadow-stack-v15-2-3fa245c6e3be@kernel.org>
References: <20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org>
In-Reply-To: <20250408-clone3-shadow-stack-v15-0-3fa245c6e3be@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn9W/ooniTARt6/JF4hCBA0D+hWJCBXdE+dR3uxruN
 RVcDO7uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/Vv6AAKCRAk1otyXVSH0OO1B/
 9Srn6gXti+dRcHL9KQNBljGQUtUQRC2oVqUsr/DjwQo0+mm6HdNnrMT3HLRZklF/1XLe0cS+h2koMF
 +UGWiuriCRQqyffiIA4wGW7KpxvGd7hESCAwmQ/C7mhQpisDaJZt1XJiXuj8bofn1kqzrzIHvTfHm6
 U8NlJGDWYbc9BXJKMJMkg5jRTgPPJwztgog8l2m02J9mJScJBLkwfRDRrETpKRuk/dX/Pqc4K54WFh
 OWF86/phmJPUitNJXumc68mYfXhSMecwScRFCjWWYTMiLdHpRPu22riHXQ1e1+9LOVhXPKrF7+slw3
 fljMC7En+Qif/nkg+9qT2lYvbyx3Xu
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


