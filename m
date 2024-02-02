Return-Path: <linux-kselftest+bounces-4040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159E847A1A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821931C22AF4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58985924;
	Fri,  2 Feb 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKk7oRVP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68CC81732;
	Fri,  2 Feb 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903955; cv=none; b=SZ9kB11jMULlBfJHTJh7tr9kwQK1sE68c5kDPaE80tbRnFH+W0C1slKHkUcpa6Y5SVkWtGBWz2taGPMhlxeCyBV0Ju0uW8net/Y9VTa59PvXqf/jPnBUldeVzA/C5mn3JMagYRFcwrN2TkOmw7viAihy86HgJd+wtErTG9Gac7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903955; c=relaxed/simple;
	bh=Ik7PysFz2Q/PQymMpEmnCsC39bu2MIXYeb1T3HpNV9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plsQUWDOW+J4pBC4W5n8jkeSx+ZbdaaUPTxiPUknGRLE5WHrQB9k2/89O4pSTLzwZiPImNA7RwlzALUeM0DHopW1hEmj+fQnaWKUbnhxsIquqCmx0YAcoXfxiR7WZFisAMrXQd3ndPz1TtKBBjAQpJLRl1y5ujxzhtegvsBATsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKk7oRVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A256FC43601;
	Fri,  2 Feb 2024 19:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903955;
	bh=Ik7PysFz2Q/PQymMpEmnCsC39bu2MIXYeb1T3HpNV9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKk7oRVPGb6C4HwkiFVL7iT8eK5Iik/EDFzYFOWPTWd77I5UUfPzNd7aKEoHobNdK
	 k6Iw7l3n0kK1QlfHNjMomlOOIirYwU1YpZobTyaCqSTvK63/LTQWC3U/94Wr+aCo1K
	 394zegdhvm14D9LJ9NsIivpUSTTgKA8VMQ+qda/ZZNZWNO9pqhQWXlJ356r8GK1dg/
	 Y9EE2/Xe7HhWLyB8r206UzMDMPWCWCqSs4f0n5ApmA9aFdeFK0zgM70sRYd1vQf03A
	 xHklCpZJB3PdHRb1/vDAF5/fzpbWmHhXlWWWVeSgi2bjCoLOEJCf9ZpZ0n4+cooxP7
	 oZE/QJs34kWsw==
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
Subject: [PATCH v3 5/7] arm64: Unconditionally call unflatten_device_tree()
Date: Fri,  2 Feb 2024 11:59:06 -0800
Message-ID: <20240202195909.3458162-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202195909.3458162-1-sboyd@kernel.org>
References: <20240202195909.3458162-1-sboyd@kernel.org>
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
index 417a8a86b2db..ede3d59dabf0 100644
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


