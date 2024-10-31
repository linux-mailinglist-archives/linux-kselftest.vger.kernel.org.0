Return-Path: <linux-kselftest+bounces-21250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31B9B8360
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 20:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF651C23D9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795991CB33D;
	Thu, 31 Oct 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTRYES7U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC021C9DD5;
	Thu, 31 Oct 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402747; cv=none; b=FVokmlcSxme8F7EpoL0g7ADDhYctPYXabCmBD8rV1xHb0TKUsx5sDfVTwHn2Nl9yGAn5DjKcsxAbvre/4ibeDk23TTGFoFxeSgXEIrQyYDRuJEqIA7AAkWiUznkZT8QuHvDKv9ioRj7eThWFhzn+7Dvo0HkmcDdxF9Tbx7PPQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402747; c=relaxed/simple;
	bh=AbLth5zSxZKGDmgHKpPb77+q+UuyNvYPAoJ2d927a7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8M8U+vC578zEoTmmClvYt75Ym3yBujh9ePxngE+uqVsqkS0bfv8TFG4/XbK3vCaAQOH0ny5+PJNXoWU27sWSwPbJBlriaJYG07we7GUwZmJ/Yk9qck0jIj06Q6sxd15sYDlALOLOUC+PX0OrgbMD93ZQRqu6tGVMr6pbbYsVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTRYES7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29938C4CED5;
	Thu, 31 Oct 2024 19:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402746;
	bh=AbLth5zSxZKGDmgHKpPb77+q+UuyNvYPAoJ2d927a7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tTRYES7UjaIysSzme+hY4ndfmiYPIZcR65Y8CjQG4I2ww4mdabaEU7gdECXUYYPOR
	 DUh7gDbKapImKeU0ayma9XLL0+eaj4bcF24yxrfXhSapmlSz8R9fjI0LotBUNQcOxO
	 Qex/HhjW6hJ5CX9LxCoGcb+znwWDukb1IbSJ+tjtJRo+puVUOu4qp2PmlH1H/cFIOH
	 ujq7jynMZXc5J9afn+wxQaMSpdZn9KHh13uCvwTHpBgfRx2WDud4XfmARH1aGU04+f
	 bR4wFGMchPnyAswN4XBxB/s5IMdCf29KnqxSwGuVMUi6zLmw5+pUIiXOoE/ibZ3RLw
	 VG/rq79CPAQFQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Oct 2024 19:25:03 +0000
Subject: [PATCH RFT v12 2/8] Documentation: userspace-api: Add shadow stack
 API documentation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-clone3-shadow-stack-v12-2-7183eb8bee17@kernel.org>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
In-Reply-To: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
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
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=3205; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AbLth5zSxZKGDmgHKpPb77+q+UuyNvYPAoJ2d927a7g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnI9mjcYzJgOXqROdCTV6U13+vds446fSmpbnSYa26
 K5EHJFqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyPZowAKCRAk1otyXVSH0HfOB/
 9JoESZWcg/BurSCzknvzkNSxSB1EUcIoa6UZobO1DtjeccIofJvAEEb3hzO9z0Bm669tdO3Xlympn5
 QCwRDXFHfYjrsdA7o46ttv2hKOwMn62mdUMp/b3y3ufByOJyYcSfX3O828IIrGjKDlnOTfQ7hYO7uH
 cw3+QBUru94Krhx+LX+o5deIG4lylgJ1p9EOpacIieJypNUHokn3cLBzPQQA8qmfQy+yAGAsHqLy/t
 zSQ9hA69tykd7Ji6zl70fLo44z5NdyeP8y1QE1IyasH+yeWHoaJu/zY/dN4NYiVQNR+YeLCUJWYYnh
 uSdWbt8UG/LEKo4LqEApfbfBI3IZrP
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
 Documentation/userspace-api/shadow_stack.rst | 42 ++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 274cc7546efc2a042d2dc00aa67c71c52372179a..c39709bfba2c5682d0d1a22444db17c17bcf01ce 100644
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
index 0000000000000000000000000000000000000000..9d0d4e79cfa7c47d3208dd53071a3d0b86c18575
--- /dev/null
+++ b/Documentation/userspace-api/shadow_stack.rst
@@ -0,0 +1,42 @@
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
2.39.2


