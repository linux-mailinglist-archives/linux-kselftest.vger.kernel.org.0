Return-Path: <linux-kselftest+bounces-9199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4168B8A00
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 14:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E59B1F22E25
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927B485C66;
	Wed,  1 May 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rl9XOHpP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A21384D0B;
	Wed,  1 May 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566568; cv=none; b=Q/Lpg9es4AOBepw64+9PbEgtdP3ASSBJ2a0LBaJ6PItwsv6dBkrn+VzgeeujDhLEI3il/UfT4toLxMz3yh08CciQC6S5T0G7bUYDw8SFLTbwXCzWrclgRtHSAPNljhTKzi2G+sGfsgJDRva0vOMcN0xebgDFo94jYUmvJN7BKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566568; c=relaxed/simple;
	bh=WfmBhJXDCOMhPVuRWWQRpLQZSRvYuCJH93b9CuCJmnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0lPCBzqLca4wxPTGtELlFHORRKZUnp+4s48bzNc9c3D94jT3I4uw+//shr6kpuWiG+3PrcD55drisK4SHrAadkkxuhKKEEb1GUsnKEXtxfwe1JauplnNr9rOM1pZu8Fo0deh0uxexvZ6vfmWA45M4uUhrVUlz9m4f2YzP9FK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rl9XOHpP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714566565;
	bh=WfmBhJXDCOMhPVuRWWQRpLQZSRvYuCJH93b9CuCJmnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rl9XOHpPf5q6eDVJX+luXHvfNWz5tvcVMFlviGffV6OBHyRAK0ZYDHJqxBsAEpLwQ
	 Xp9aSZPC+ILKnv5D08JTgbarTHfBw2ZBdRgjuteYHEO2vZBGvbpzckCgRMFTtyAKVZ
	 wtXEzm7t5dO0ocP55AKC7gq2ySvzvnoJw4VlM4yOG5BcEG7NXOxj5FCG2f6vUoyWvG
	 s4cgQgH/Q1hMyyrQXovpjKX4naeWz3qAV2/2wOCC+z0FvBcKP8mhaP1aC1aKTaLBVq
	 deKlEIijzjXMd3FCKt7gv4bfKzV52nWTAyUXTUL26/st4EZurxhBL+ry/0FGPX03yP
	 +/s1aDsZRNLuw==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A3E0B3781FE9;
	Wed,  1 May 2024 12:29:18 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: kernel@collabora.com
Subject: [PATCH 2/8] selftests: x86: check_initial_reg_state: remove -no-pie while using -static
Date: Wed,  1 May 2024 17:29:12 +0500
Message-Id: <20240501122918.3831734-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501122918.3831734-1-usama.anjum@collabora.com>
References: <20240501122918.3831734-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -static clang flag ignores -no-pie flag. Hence following warning is
generated. Fix the warning by removing the -no-pie flag before
specifying -static flag.

clang: warning: argument unused during compilation: '-no-pie' [-Wunused-command-line-argument]

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 671b1819694ff..b0f5b5ff79b8d 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -108,8 +108,9 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
 # state.
-$(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
-$(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
+CFLAGS2:=$(filter-out -no-pie,$(CFLAGS))
+$(OUTPUT)/check_initial_reg_state_32: CFLAGS2 += -Wl,-ereal_start -static
+$(OUTPUT)/check_initial_reg_state_64: CFLAGS2 += -Wl,-ereal_start -static
 
 $(OUTPUT)/nx_stack_32: CFLAGS += -Wl,-z,noexecstack
 $(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
-- 
2.39.2


