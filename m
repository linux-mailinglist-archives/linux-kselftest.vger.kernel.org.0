Return-Path: <linux-kselftest+bounces-25914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51150A2A7AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD477166600
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD28722DF89;
	Thu,  6 Feb 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYjZ12M2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6012288F0;
	Thu,  6 Feb 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842023; cv=none; b=Ry/2cLlq7LTka4vWxxjkwHtaaoOC609h+x/14dC8Z7mI/XdfTfQA+2qgB0geewN40s5dtIOvmMzp49LZOAFkEFZnK563XqJvmudy3QNARaolseLz0gn7uXqNsh/XdETb9BE2d7fClAI/30QH01BTxqbThrxs/NNML0c19mvK88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842023; c=relaxed/simple;
	bh=Rn1ReQWjHDBrfM29j7eU9MrcuInkiKGzptMD1gkGnC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TApYhjRMeNRYDM4S7VFXtEbN76s8Xj4MKvbLXBhWDr1qb52ck9Bg7BN9tqQjucPBTagUtQhb3VJfz1ZHz4lih09n/ffSqxxQxPvs2Q+sY6Ai5PtZ9zEK54xprUl3r9aOLmtZ+jzaQSe9xBhMTRijLTwSxAj6ZI+61Tap7IRNylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYjZ12M2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00B6C4CEE5;
	Thu,  6 Feb 2025 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738842023;
	bh=Rn1ReQWjHDBrfM29j7eU9MrcuInkiKGzptMD1gkGnC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OYjZ12M2vVnXlnvNew6MKCGPjXsP0osDyTFqH+UWKKapf6D+TYBvpVUwD2xKhgGPC
	 5kc723OH49/wOHF15YUErXhGv8OoCobEG6JsDtj7xcCSOjEP2VuFd5CqvcwZvAzMCq
	 6RP5BxSZu5khiim6G1iUs8JATmFpZ4beFQBZWctRBVGgNsmq5BnmwbUx48wizlGAmP
	 bEMBtk8SP53X0bQatX1FF6aY/olEDg1LnY3oW4VhEJwpFbcgJD5lBX26gZmzTFXCJ4
	 iz4tfe17SZV5xNptaHLvGg+d+JOGa1WtcwKgIpqrMpXIG7gTGg24/oc9xCeGdGPBHc
	 h2WCYVqdOu3og==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 06 Feb 2025 11:38:04 +0000
Subject: [PATCH RFT v14 2/8] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-clone3-shadow-stack-v14-2-805b53af73b9@kernel.org>
References: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
In-Reply-To: <20250206-clone3-shadow-stack-v14-0-805b53af73b9@kernel.org>
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
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Rn1ReQWjHDBrfM29j7eU9MrcuInkiKGzptMD1gkGnC8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnpJ+PEnkMA6qzvTp3Vm7rYeeO6o0S/66rzeoFngaU
 aII9xhyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ6SfjwAKCRAk1otyXVSH0JPkB/
 44TBdNZRnlayyrQ5r7mRUxn80kuXWVHlrEJbaWm1Fc6JODvTtJPybM+tKxIoJzBDfWnDbDOB9dQoml
 Et2ZPU1aNH/IO3tTjHAMdu6FRO35KLGT+2XK4dXQ02jQHHkXZd6OI5qphuBwDwQnXiIBVWPJE9YAo0
 sLYLXFfbRvit+ieztexzcCGBbiPPVkQWQg+1k4wmds4aRlMOIwhZR4X2tiI66kXvAJwSh38fvDjYsU
 WqjrDgnK+FOSItmXJEJeCwvGxiCthGx9+zciaqL1wlxpCiDdCu/rGOUiMuHE2heTYhd0L7PzuCWa8c
 bu3uFB59g2wxDgxnfonLfMYy4CDFdS
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/userspace-api/index.rst        |  1 +
 Documentation/userspace-api/shadow_stack.rst | 44 ++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b1395d94b3fd0a7d43a3a9a9afa329d467675ae5..c491f332d289e6333675b6e41ab7d55b7e108829 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -60,6 +60,7 @@ Everything else
 
    ELF
    netlink/index
+   shadow_stack
    sysfs-platform_profile
    vduse
    futex2
diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
new file mode 100644
index 0000000000000000000000000000000000000000..65c665496624c7d9c33dbd8c714b8dc88c2032b3
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


