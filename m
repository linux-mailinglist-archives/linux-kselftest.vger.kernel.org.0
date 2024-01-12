Return-Path: <linux-kselftest+bounces-2927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC0082C624
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 21:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484B328865D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F816428;
	Fri, 12 Jan 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGnzveG/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573216419;
	Fri, 12 Jan 2024 20:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6629AC43390;
	Fri, 12 Jan 2024 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705090072;
	bh=Ftr3BKZw8coGMgoBGEKihNEJ4LajJ+HPG/Va2fa5Q/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGnzveG/zSlluWPqK50MsRXFZgcqSqsT+b/j0PKAXVP7ZtdQyKAg1m3guf/d+IBVA
	 07pgc33Sbuh8cKPwsn4TbkcS4oenSfh3ljankCMJg+3KSR3xYKkq/FmivEMPbadwki
	 Gnq+l6slqsgHmDwxM4NPuJLHDFpi9gubCjnjUfdn8Sxy8LDYoDjOakf6QcAqDVrAdr
	 MDEBQQjx5CgxrWGB2llxj/Yj47M6+dU6XpmzgIP+dv/eye+gmUbhi9gVZJmKU4tJND
	 6j9+++zKYkaAyoMnCs8uOcZrzTy3AjyU8ipiPD0bw/T6SgAUz0oA+ED7fSzqWiE2Uf
	 xFRtahWLY3/DA==
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
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Date: Fri, 12 Jan 2024 12:07:44 -0800
Message-ID: <20240112200750.4062441-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240112200750.4062441-1-sboyd@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call this function unconditionally so that we can populate an empty DTB
on platforms that don't boot with a firmware provided or builtin DTB.
There's no harm in calling unflatten_device_tree() unconditionally. If
there isn't a valid initial_boot_params dtb then unflatten_device_tree()
returns early.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
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


