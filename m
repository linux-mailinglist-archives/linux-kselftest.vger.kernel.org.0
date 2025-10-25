Return-Path: <linux-kselftest+bounces-44042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B862C094AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2526334DA68
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521F308F35;
	Sat, 25 Oct 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CViEQPWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18E304BAB;
	Sat, 25 Oct 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408945; cv=none; b=sm06iZ/dTvCl8K13ZWxmORyt/QmlL0EursT0wb1CNxu/cjsdYK5N0e7m4rCoA+8mp6SLsvM0OO5VQUCRwRwG7bSVfxmP335zVLx8StYgIMMW2jXSjVpMAqC4MZQjr3W4Y6tTz1ajpBYAoIivva7MLjuu03MX09RgcUkaEjH2qds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408945; c=relaxed/simple;
	bh=A9z2z6aFPOT4Km+WtJCwhpbdqVDx2t8vg8AQo423VXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d09q+t/eom3WrSBJS65gkItNuHR0XbedS7TS7e2KZS1sr2qyLL7yi9Pj1u0LLBNB0hjnzDlVEC7Qq7b+2JxckaK+sDCl7ogWtU3vTWgRBIekSOZd5rKCZDgexVdlJ5rTatXDu1M+pDqTfFJGiF+HUjAs5wX7SeL9rdfJ+SAhSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CViEQPWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDBCC4CEFB;
	Sat, 25 Oct 2025 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408945;
	bh=A9z2z6aFPOT4Km+WtJCwhpbdqVDx2t8vg8AQo423VXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CViEQPWO4qzONgLwo5q9qHDMMdaHftmFK//rqqg4KJf6+kv+G0ytdzhtTvmd92+WC
	 va7NwpuRZH/lNjl+6QJgKX27Y+6sPrTpXYkUbF3ArnBgt9awwcursaxjd9jJzMO/cR
	 7IVF8vRuRGZMTizHkOQICFTaN+JNfx1TlssI5Arbgbpswa5BpjwqqlqHr0nA/y5lWb
	 mcPxC5eE0AW/VYTLD3uO36P4A3Z/qmvG701lRva+rdJYYAK/H1uQfJh5leco4Z4STL
	 lz4+E/oe8b/MrGAl5hQVNJlp2FboBqA/pH/V2AvjQPejZvGJ9DD+TJATGaAaCcEvyb
	 gNa17G1PAHVtQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Nai-Chen Cheng <bleach1827@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] selftests/Makefile: include $(INSTALL_DEP_TARGETS) in clean target to clean net/lib dependency
Date: Sat, 25 Oct 2025 11:56:15 -0400
Message-ID: <20251025160905.3857885-144-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nai-Chen Cheng <bleach1827@gmail.com>

[ Upstream commit d3f7457da7b9527a06dbcbfaf666aa51ac2eeb53 ]

The selftests 'make clean' does not clean the net/lib because it only
processes $(TARGETS) and ignores $(INSTALL_DEP_TARGETS). This leaves
compiled objects in net/lib after cleaning, requiring manual cleanup.

Include $(INSTALL_DEP_TARGETS) in clean target to ensure net/lib
dependency is properly cleaned.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://patch.msgid.link/20250910-selftests-makefile-clean-v1-1-29e7f496cd87@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – updating `tools/testing/selftests/Makefile:319` to iterate over
`$(TARGETS) $(INSTALL_DEP_TARGETS)` brings the `clean` recipe in line
with the existing `all` and `install` loops
(`tools/testing/selftests/Makefile:211` and `:276`), so the implicit
net/lib helper that gets built for networking selftests is now removed
during `make clean`. This fixes a real annoyance where stale objects
remain under `net/lib/` after cleaning, forcing manual removal and
risking rebuild flakiness if headers or tooling change. The change is
tiny, selftests-only, and mirrors logic already exercised in other
targets, so regression risk is negligible. Just make sure the stable
branch you target already carries the dependency hook that introduced
`INSTALL_DEP_TARGETS` (commit b86761ff6374813cdf64ffd6b95ddd1813c435d8
or equivalent); older branches without that infrastructure don’t need
this patch. Natural follow-up: once backported, run `make -C
tools/testing/selftests clean` after building the net tests to confirm
the stale net/lib objects are cleared.

 tools/testing/selftests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 030da61dbff3a..a2d8e1093b005 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -314,7 +314,7 @@ gen_tar: install
 	@echo "Created ${TAR_PATH}"
 
 clean:
-	@for TARGET in $(TARGETS); do \
+	@for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
 	done;
-- 
2.51.0


