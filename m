Return-Path: <linux-kselftest+bounces-3716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD58417B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EB0285F94
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BF429CF8;
	Tue, 30 Jan 2024 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXXuBRXI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2974208C6;
	Tue, 30 Jan 2024 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575512; cv=none; b=QIgOTOip6OvZ6L1p+rrvP/PdZI65C6/L8vxpy6aNiSUdm0LvqKFFeZL3b6Z0haXMGNfbAACkIsddwMJMB7/RygScRwo4yBsJ10Pq2PwMQykHk+nD1z5dSk4upI3KV3ONcfvo1dYDwbnv+Rx5ZZUnvzA62qKt/on55F4QEEacRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575512; c=relaxed/simple;
	bh=VXgzDqWTdPwPLTS+PDtQWtuCy7mpsGpCkHXI8WBQloU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nhy/rI5rCxedljbzEJRjE7NYdt3h9MO0SknzAP+pLOtDs9JTKGwPcx8xcU79u8ZMS/qO88AQPW5/Bf+pYTX7D8Q0FfYLuQjTHmxfo3Z4eSfXN24dn33dLpEXlzOwb0P/XozLXZn8zL36LWtmeHVURl9JMhJthwaT4zB2IWh3Qdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXXuBRXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15EFC43399;
	Tue, 30 Jan 2024 00:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575511;
	bh=VXgzDqWTdPwPLTS+PDtQWtuCy7mpsGpCkHXI8WBQloU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXXuBRXIKUnxuty7JtrN6gOE8EGXiTS/vVocrxqVOHD9u8eXJPZNAcWujnPKBxo1e
	 VxixGTBUgU4e8M27QVG7vbXDPLdWyZaI2WBJ0ie6g+nRygM6aoSBqy9s3cPhVrF80A
	 8e+ipwBOhmcCAq5w1f5FrzEifL/zkRxhhz1IOxIVxIqv/LbCD5pKRoRECjmsxnJtXD
	 sEpg7dYiG5yiHGRPRji5Q1tD2vIC8GqNjBHLc+xPsuJe4rNQHxIBu+qlp+KZuRPmx8
	 /9ZHH+fgKf7RppPgtpnyzdafGQ5MHgepOcTqIXjk+DAG6R0tsKb3gAD8EnkA9cxhuV
	 v0+sc6RClMpTA==
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
Subject: [PATCH v2 1/7] arm64: Unconditionally call unflatten_device_tree()
Date: Mon, 29 Jan 2024 16:45:00 -0800
Message-ID: <20240130004508.1700335-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130004508.1700335-1-sboyd@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call this function unconditionally so that we can populate an empty DTB
on platforms that don't boot with a firmware provided or builtin DTB.
Override 'initial_boot_params' to NULL when ACPI is in use but the
bootloader has loaded a DTB so that we don't allow both ACPI and DT to
be used during boot. If there isn't a valid initial_boot_params dtb then
unflatten_device_tree() returns early so this is fine.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm64/kernel/setup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..ffb1942724ae 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -351,8 +351,11 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
-	if (acpi_disabled)
-		unflatten_device_tree();
+	/* Don't use the FDT from boot if ACPI is in use */
+	if (!acpi_disabled)
+		initial_boot_params = NULL;
+
+	unflatten_device_tree();
 
 	bootmem_init();
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


