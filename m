Return-Path: <linux-kselftest+bounces-3718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC08417B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0101C2282D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549323612C;
	Tue, 30 Jan 2024 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAgYYRtb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391936114;
	Tue, 30 Jan 2024 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575513; cv=none; b=iUQR5ux9RJFJ/h8Q8CMxvb8aZzQ4+RMySJetha4oaIBPG8uEpqktxJ9eShkVa+kYZKYFkk+7mhPmlkRiie0Q3rcQVr96Ls3byhyf9l/YV+WklQ7tQTIwU6gHgPiKuHxvxJf75sk48vOyA5VC4dg0gEdBKqM+YPs9kDAGfQ/FtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575513; c=relaxed/simple;
	bh=RoHfW0J4DhoHi6CIUbHFtKoJEfAKysJC1Fo3xRXVigg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D65D3EVIGKgalq+KrU0RXv9UUKLoNBrqm7IhhRns+xaILorxF9TArSpUSiIab3QiYa658HM39ClVaBtgU0XaoIAB4lMHSKzifk1SYY0v5EOeStaIMIIOjsfmtLDKdBcMnhF+VbJNzqZXsUUrkqlh6d9kkan9QGKJy+bgqUfkqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAgYYRtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430F2C4166C;
	Tue, 30 Jan 2024 00:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575513;
	bh=RoHfW0J4DhoHi6CIUbHFtKoJEfAKysJC1Fo3xRXVigg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAgYYRtbWJ5viR41vOf0Q8IcMgBCtlOzDpcv/45U9U4fYJYMSujLD6JfR2osY9ATY
	 4bStYc/TK7bqQzxeqWCsW9bvUgnTTtJJ8FKM0Kme5fVfrFfuPG6NDEZ8G+M9fe+crH
	 9ByGZOm401zpjqEGrrIHWvkq3Y6jn2TnJD6D7vJtCKzLG5iUGLZNqtGPq5D9/aESld
	 EK4qSV4IXVc7i2yKDT4qA/2Ji5egQXFQIAAjoVgxvqb3Gqfsyw5YbBpJn7iyNgtMCd
	 qBIGYbb+stxyLQrNEHZ+Z413GV36NRwX4SrxjuMtQxugmXLfho8V3HuuGCNZNsblTL
	 vBQ1Ri0YWWNSg==
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v2 3/7] x86/of: Unconditionally call unflatten_and_copy_device_tree()
Date: Mon, 29 Jan 2024 16:45:02 -0800
Message-ID: <20240130004508.1700335-4-sboyd@kernel.org>
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

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/x86/kernel/devicetree.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index afd09924094e..650752d112a6 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -283,22 +283,24 @@ void __init x86_flattree_get_config(void)
 	u32 size, map_len;
 	void *dt;
 
-	if (!initial_dtb)
-		return;
+	if (initial_dtb) {
+		map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
 
-	map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
+		dt = early_memremap(initial_dtb, map_len);
+		size = fdt_totalsize(dt);
+		if (map_len < size) {
+			early_memunmap(dt, map_len);
+			dt = early_memremap(initial_dtb, size);
+			map_len = size;
+		}
 
-	dt = early_memremap(initial_dtb, map_len);
-	size = fdt_totalsize(dt);
-	if (map_len < size) {
-		early_memunmap(dt, map_len);
-		dt = early_memremap(initial_dtb, size);
-		map_len = size;
+		early_init_dt_verify(dt);
 	}
 
-	early_init_dt_verify(dt);
 	unflatten_and_copy_device_tree();
-	early_memunmap(dt, map_len);
+
+	if (initial_dtb)
+		early_memunmap(dt, map_len);
 }
 #endif
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


