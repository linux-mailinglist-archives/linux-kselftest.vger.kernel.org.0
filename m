Return-Path: <linux-kselftest+bounces-4900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057E7858C95
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 02:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EA3283A62
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Feb 2024 01:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AC200C4;
	Sat, 17 Feb 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLu/fetq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5620DC4;
	Sat, 17 Feb 2024 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131963; cv=none; b=dOLlFoESSts2UCMHKLQiZhmY22N4DHzqqcwsIJE4ZTnpQ7NMhLzpWmIuh0LyYXidL5QAKicPrtxiOSZa1zZbEH69wZPnEGejkUfK2rBiGSZqTujCf2cr7WnVrcdalLb5pBSXA+3u7EescOIMHODRy8COY2Ye+D8Yl47HTFj7S+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131963; c=relaxed/simple;
	bh=1HWmL/t+ml480s8rBnTxQKeWVgi/0Mqu3CbJKyMEIU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+y5L5PyH+VYeBMySDzAvoDfhvcv/XurRPybcTHWByhSoTEFIJAI3R8QZ3+SQyLBBtqEZQC/QlbKVOt5wECkAFUmLqFZXbCnZAvV3FklFDFzwROa1f80xj6v8GsHYBPMNWNr5JaSbn3vvE+ea0zDZeRWv27vdxIYyrYwxzIEE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLu/fetq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68291C433B1;
	Sat, 17 Feb 2024 01:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131962;
	bh=1HWmL/t+ml480s8rBnTxQKeWVgi/0Mqu3CbJKyMEIU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLu/fetqM+cb3tFtOHS4DOL5HzdsL62p8HCA7st+6zWovNRgJDBAgQnu6PXC1+c9G
	 HFZmLUhjJAsUY3SYQrxRX0DJ51MCTu7WUqyLaRDBYT0p7U3hhqasKo3LofYMLnFUmS
	 wyRODHMZMXZEjB75NprcfvwHNV/GncU03JL5Uh+3ni6KVVnTXs0sqEPcJRHZZ5VUhZ
	 KDwZy/JMZPFcz3N3YG14+nEDcPwAloywz+fsCh01BgyNBj0GdXEtQLT9hc25xBrUQB
	 JooWdwLPYjQZABiqq2n0BCu5ZwpDE4wcww/s7bAxn5H8dLXJcIiin859FkSNqXFBMd
	 ex/bdl98FQEGg==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 5/7] arm64: Unconditionally call unflatten_device_tree()
Date: Fri, 16 Feb 2024 17:05:54 -0800
Message-ID: <20240217010557.2381548-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call this function unconditionally so that we can populate an empty DTB
on platforms that don't boot with a firmware provided or builtin DTB.
When ACPI is in use, unflatten_device_tree() ignores the
'initial_boot_params' pointer so the live DT on those systems won't be
whatever that's pointing to. Similarly, when kexec copies the DT data
the previous kernel to the new one on ACPI systems,
of_kexec_alloc_and_setup_fdt() will ignore the live DT (the empty root
one) and copy the 'initial_boot_params' data.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm64/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42c690bb2d60..0d210720d47d 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -351,8 +351,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
-	if (acpi_disabled)
-		unflatten_device_tree();
+	unflatten_device_tree();
 
 	bootmem_init();
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


