Return-Path: <linux-kselftest+bounces-48305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E5DCF912C
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADFAE3013D53
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE4522A4D8;
	Tue,  6 Jan 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaWOxjUH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ACF1A5B9D;
	Tue,  6 Jan 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713462; cv=none; b=b8I/PU59+Uuo4q0z7bEVnw+Wik5JW/wNNFas6CcGYNdHhCq4ENqey087cuCR5JTmsU/faDRoWqYInW9cxbqe1PihfJGcZZ2gaf3XFxAz78gaPrNUnqBnXdgPZYSH8dZiFhSxy9lXe2hVcb6uFT30TGrPsMr6OmRIhCZRhXWN3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713462; c=relaxed/simple;
	bh=Ftnl5LVPPN6ORFYr81+xWYq9lMzP+BFzLbdgRYxmtxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k8qzznpdslK9ydlE9NcpnTW2FwdOsmmNN/EYMs/cA17H/zjzavWWmxXpRRLy/knP1fc+RyHvD/rFf4vopbbkSY13BZNMM/XaB0u+0gOwTKb4VgM5Bdf4ANA5XgPoANCxifzYv/qtdxpPZij8GCGgaUIHTSpgm21HKoSIrrg/5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaWOxjUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644BAC16AAE;
	Tue,  6 Jan 2026 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767713461;
	bh=Ftnl5LVPPN6ORFYr81+xWYq9lMzP+BFzLbdgRYxmtxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DaWOxjUHmjqvqMaixUbw1q15C3qspuNcmWWyqZ3ZbOz3W8QfJO1TRU4aavNbAP9/Y
	 tnJ7dwcaPa1GNLF9wZu2qoamAP7VbyFaepXCOv965evU0oAJKCzJvSlFY2z9lBxHBW
	 iWJgknTZe8buY3QM6/r7XsNbKFRduWYjwTIFOL5ZGStNb4fOfF9HQ0kXd5KFb3G9C4
	 WMw/YZdJUtu0nkAIrfeaDgEOmRH5e2xiWjqooAc23AE9YwBkCeIAqOWUnlrrFSJdv+
	 wQj62LDNqiWelVkHwJ1UB4vxxZZdsHDHdS54N1bcxlk1mf6n6gKYg0/hNLOBxpMcxp
	 nni6tQ0KZc3Og==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 06 Jan 2026 16:30:54 +0100
Subject: [PATCH 1/2] HID: bpf: fix bpf compilation with -fms-extensions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wip-fix-bpf-compilation-v1-1-0b29c85f1157@kernel.org>
References: <20260106-wip-fix-bpf-compilation-v1-0-0b29c85f1157@kernel.org>
In-Reply-To: <20260106-wip-fix-bpf-compilation-v1-0-0b29c85f1157@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767713457; l=1280;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Ftnl5LVPPN6ORFYr81+xWYq9lMzP+BFzLbdgRYxmtxY=;
 b=tsWRPwBI8l1cE/XFJHBMIu/GhcdyX/KvRfgT7KTqLgoCGx3TXYBbkRsSbjfk0BMAtSYqcSEh+
 fgbLO1PgIk2B4fILpQc6aAy7uchyaqGXkpAe6aQ6ueVfTqJuilje4QK
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
 drivers/hid/bpf/progs/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/bpf/progs/Makefile b/drivers/hid/bpf/progs/Makefile
index ec1fc642fd63..66b8f38e591d 100644
--- a/drivers/hid/bpf/progs/Makefile
+++ b/drivers/hid/bpf/progs/Makefile
@@ -56,8 +56,10 @@ clean:
 
 %.bpf.o: %.bpf.c vmlinux.h $(BPFOBJ) | $(OUTPUT)
 	$(call msg,BPF,$@)
-	$(Q)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(INCLUDES)	      \
-		 -c $(filter %.c,$^) -o $@ &&				      \
+	$(Q)$(CLANG) -g -O2 --target=bpf -Wall -Werror $(INCLUDES)		\
+		     -Wno-microsoft-anon-tag					\
+		     -fms-extensions						\
+		     -c $(filter %.c,$^) -o $@ &&				\
 	$(LLVM_STRIP) -g $@
 
 vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)

-- 
2.52.0


