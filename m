Return-Path: <linux-kselftest+bounces-48306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B31CF9139
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B05430146CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055EF32C957;
	Tue,  6 Jan 2026 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqpIMTbj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E72E1EF8;
	Tue,  6 Jan 2026 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713463; cv=none; b=vEXv5Ku/+zaG+Vd/yW+ly0XA4fSFU+tUfexwaLopDpQBx87PKQNNNz4sLBQRKyBjvJweYowz/ksIjU7foD4usIrSKMX1Ly+xa/xeSs1mdp5atMxv7YHD246LrHKRjPDoL643E8IfatCafoul3nctlU4V1qU2JbuKQRSMIXowDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713463; c=relaxed/simple;
	bh=s5hlAiZwy5shBl25mwnt/7Xjt5YXhmeFEvImoaDXUvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFHS3SgkqZ9pp3HZN5fXgl9nK2Vpq4G2gHsai+iSHsWj8KsdGWphBimgwB7dSg1iACbxzF1VuEe2mVskHrmvcCujU9F5XcefdK0qfpnjYBGK7y7uC/hIQ1u4NBs98sDSQwcy28/ZlFfrh7yLsds925JN9nQV89PWBHZDRQX7JLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqpIMTbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CA8C19423;
	Tue,  6 Jan 2026 15:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767713463;
	bh=s5hlAiZwy5shBl25mwnt/7Xjt5YXhmeFEvImoaDXUvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XqpIMTbjUuMczRkQai6kHfdpJfZVOlbut9xnz+QfBNDCCNUCSStmlGuO3hCV+/Tir
	 7bJSQDAfbRQv/ABrcTM9SE8VNRoOVT2Z9gy8I3QVur3g2EUvITga9COgcRgPtNSGi8
	 3bI1LHNzyLt59H2zyC9/v5rzBgmMV0Hj0lnWpl8dGyPuZL6jxiyWN5wA9QvH3kZTzF
	 o+qZeSW2s4AGztzLdaxawgtP2U2KVrw4ct1uzNlMCjNAb6wK4ww6lJE+KVu3Ok3LRP
	 e7kyrD4ObbCEPUC2Sk1/77tZAPjL74WIYSAbRJylSqD06n1C8tT1HXIh/f7cV+lgk4
	 AnPyC9V5UW9tg==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 06 Jan 2026 16:30:55 +0100
Subject: [PATCH 2/2] selftests/hid: fix bpf compilations due to
 -fms-extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wip-fix-bpf-compilation-v1-2-0b29c85f1157@kernel.org>
References: <20260106-wip-fix-bpf-compilation-v1-0-0b29c85f1157@kernel.org>
In-Reply-To: <20260106-wip-fix-bpf-compilation-v1-0-0b29c85f1157@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767713458; l=1230;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=s5hlAiZwy5shBl25mwnt/7Xjt5YXhmeFEvImoaDXUvY=;
 b=82DwgvdPuy/ZKe/WGlyff+RAiRsQbsb1dkta/gUwQLhrSUOO98dePNiJ30XiSZ0oTXr8+1B6h
 NaKx06GC7/LDr7AbC0IyKl0Wuj5qMz5ATzfip82Gdbq/Kw8CrObGyTz
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Similar to commit 835a50753579 ("selftests/bpf: Add -fms-extensions to
bpf build flags") and commit 639f58a0f480 ("bpftool: Fix build warnings
due to MS extensions")

The kernel is now built with -fms-extensions, therefore
generated vmlinux.h contains types like:
struct slab {
   ..
   struct freelist_counters;
};

Use -fms-extensions and -Wno-microsoft-anon-tag flags
to build bpf programs that #include "vmlinux.h"

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index 2839d2612ce3..50ec9e0406ab 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -184,6 +184,8 @@ MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
 
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
 BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 		\
+	     -Wno-microsoft-anon-tag                                    \
+	     -fms-extensions                                            \
 	     -I$(INCLUDE_DIR)
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \

-- 
2.52.0


