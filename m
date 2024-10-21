Return-Path: <linux-kselftest+bounces-20331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355549A9322
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5701F230F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC531E283A;
	Mon, 21 Oct 2024 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ79nMOY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE91C9EDA;
	Mon, 21 Oct 2024 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548972; cv=none; b=WSIU3QKyZX5v/s2E3n/y8WVF9hZNCeoJOgs6aPZ0vSK59jPl/M4zb1C2CmimVl9WRxew7vi2vSCJtTy+TwRkzDE7FYWk1cbQ0aANiCEEteK+U8xhGjyabcTZfFfyEqUSPLlZEK3G0vNGdQRlAKYplF+fgvTkXaYYVmcZj/oRIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548972; c=relaxed/simple;
	bh=eiNYccaEe6YvcZ5Yhjie50uzxPO+pld8P9lHn4HdcS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UTcwvkSQV2L4qADFX1xG7g3eVWMm4eQ0vjC6eUewHqF7BigQZA2bWO0ajeJupUuVKC+AUejhz7uLOUOokvxoKklxb2Axf1AoINeEWrfvq/1m12nt+l1OB98/LJ863YwCSsUr/s4eiEJDzXOZ2LVA7PUexCrH75rOnq+z6Rqjpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ79nMOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361CCC4CEC3;
	Mon, 21 Oct 2024 22:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729548971;
	bh=eiNYccaEe6YvcZ5Yhjie50uzxPO+pld8P9lHn4HdcS0=;
	h=From:Date:Subject:To:Cc:From;
	b=KZ79nMOYfWpzgBl7pJ2U5ZhwrEdOqPBKtVfE98BKOvGvbgmnQHLeYx2KBiO9qL3ML
	 x5vhtgON7wW1Nkv9Zi0KrtMPWjBJw7JMhOY8NwgiyfpYH6h+7NmAIDPA8cN8wzNjJI
	 3RtrgTACOFHKytJXtfrv2D6v64fLZhbkmvRY/jwg80osIY5+poDdLxtfNAQ2JOO7xT
	 cYcLXf04Nlh+Z/TWuC2nkrwa7PZWP1UrHBJ32P6o4JrlHtj8sD4nyhj5l48xg324A1
	 9Jyi0viYu5oUDhq5qkTLbcJw/LAiG0X5r3ruym1vU7rbZarUhuGmss2yFRnXCvITss
	 Hwo6s5liITKjw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 21 Oct 2024 23:11:40 +0100
Subject: [PATCH] KVM: selftests: Fix build on on non-x86 architectures
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241021-kvm-build-break-v1-1-625ea60ed7df@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJvRFmcC/x3MQQqAIBBA0avIrBtQsUVdJVpoTjVUFkoShHdPW
 r7F/y8kikwJevFCpMyJz1ChGgHTasNCyL4atNRGSa1wywe6m3ePLpLd0HStdeSnVpGEWl2RZn7
 +4zCW8gGvogcgYQAAAA==
X-Change-ID: 20241021-kvm-build-break-495abedc51e0
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eiNYccaEe6YvcZ5Yhjie50uzxPO+pld8P9lHn4HdcS0=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnSxSys7LC3EWFtO+05rmVSWMF9Fc9ZjjaXv/7UYF9ZafFp/
 nSG8k9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYSMU69n92jv93ZW8Pa0xMnZfsL3
 33ZZh2cpHj0v7AaRGsBbdffshbudw0OP0Lx/SCnx9/vK35JhnaU1pTo3Ljc+9lQZ0pDIpyDYdaIqqY
 1uqX/zmtE9KrzHGv8uIRg1ClzKu7UhvuzH3NaVsiabTqW8PqZwahIj/Egj8mecxeKHAleS7v9NjIAJ
 FzemIPVdR+H+MKzClfKb/47V+Ba82GBT7TbDRqfN/VdLuu/p32evm7kMYJlzydmsOZK/jacjMX2r/N
 2v1tSlD1R++2O1HevB9nCa1yWtJrcFQwnNHhssOWymDO007cfh+mCc0Wbw6xatl97vzKxA7LNQyHe7
 i4/aO7JNac3D1Vcaf+t6smQlayAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Commit 9a400068a158 ("KVM: selftests: x86: Avoid using SSE/AVX
instructions") unconditionally added -march=x86-64-v2 to the CFLAGS used
to build the KVM selftests which does not work on non-x86 architectures:

  cc1: error: unknown value ‘x86-64-v2’ for ‘-march’

Fix this by making the addition of this x86 specific command line flag
conditional on building for x86.

Fixes: 9a400068a158 ("KVM: selftests: x86: Avoid using SSE/AVX instructions")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index e6b7e01d57080b304b21120f0d47bda260ba6c43..156fbfae940feac649f933dc6e048a2e2926542a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -244,11 +244,13 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
-	-march=x86-64-v2 \
 	$(KHDR_INCLUDES)
 ifeq ($(ARCH),s390)
 	CFLAGS += -march=z10
 endif
+ifeq ($(ARCH),x86)
+	CFLAGS += -march=x86-64-v2
+endif
 ifeq ($(ARCH),arm64)
 tools_dir := $(top_srcdir)/tools
 arm64_tools_dir := $(tools_dir)/arch/arm64/tools/

---
base-commit: d129377639907fce7e0a27990e590e4661d3ee02
change-id: 20241021-kvm-build-break-495abedc51e0

Best regards,
-- 
Mark Brown <broonie@kernel.org>


